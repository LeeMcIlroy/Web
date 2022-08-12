using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

using HALLA_PM.Core;
using HALLA_PM.Util;
using HALLA_PM.Models;
using System.Dynamic;
using System.Net;
using Newtonsoft.Json.Linq;
using Newtonsoft.Json;
using System.Text;
using System.IO;

namespace HALLA_PM.Controllers
{
    public class ApiController : Controller
    {
        SystemAuthRepo systemAuthRepo = new SystemAuthRepo();
        SystemMenuAuthRepo systemMenuAuthRepo = new SystemMenuAuthRepo();
        SystemOrgAuthRepo systemOrgAuthRepo = new SystemOrgAuthRepo();
        PageAuthRepo pageAuthRepo = new PageAuthRepo();
        InsaUserVRepo insaUserVRepo = new InsaUserVRepo();
        InsaDeptVRepo insaDeptVRepo = new InsaDeptVRepo();
        RegistYearListRepo rYearListRepo = new RegistYearListRepo();

        // GET: Api
        public ActionResult Index()
        {
            return View();
        }

        /// <summary>
        /// 그룹웨어에서 보내준 암호화 값으로 UserIdx값을 가져온다.
        /// </summary>
        /// <param name="PM_SABUN">암호화사번</param>
        /// <returns>Json</returns>
        public JsonResult GetUserIdx(string PM_SABUN, string push_token)
        {
            //PM_SABUN = "6zsk9okqYulpivYna9+IK5P+g8Oqt6r7aGyXlNKnYgfb9fZZFTLr8jYbuUhTGmwY+HH3PopWy0OENh7Bxq7h2ppmS0UrxSkKiK5t3GVwaj+hmIGAMJv34aRIEEaw/YHyFOAMHA0ArAZ3xKiuWJDLjQ==";
            string decString = SSOUtil.Decrypt(PM_SABUN, Define.SSO_DECRYPT_KEY, false);
            string[] decList = decString.Split('&');
            string empNo = "";

            bool isSuccess = true;
            string errorMsg = "권한이 있는 사용자입니다.";

            if (decList.Length != 4)
            {
                errorMsg = "잘못된 접근입니다암호화 코드가 잘못되었습니다.";
                isSuccess = false;
                return Json(new { success = isSuccess, Msg = errorMsg }, JsonRequestBehavior.AllowGet);
            }

            foreach (string str in decList)
            {
                if (str.IndexOf('=') > 0)
                {
                    string[] splitString = str.Split('=');
                    if (splitString[0].ToUpper() == "TS")
                    {
                        DateTime dtDec = DateTime.ParseExact(splitString[1], "yyyyMMddHHmmss", null);
                        DateTime dtBofore = DateTime.Now.AddMinutes(-5);
                        //DateTime dtAfter = DateTime.Now.AddMinutes(5);
                        DateTime dtAfter = DateTime.Now.AddYears(1);

                        if (dtDec <= dtBofore || dtDec >= dtAfter)
                        {
                            errorMsg = "연결시간을 초과하였습니다.";
                            isSuccess = false;
                            return Json(new { success = isSuccess, Msg = errorMsg }, JsonRequestBehavior.AllowGet);
                        }
                    }
                    else if (splitString[0].ToUpper() == "SYSTEM")
                    {
                        if (splitString[1] != Define.SSO_SYSTEM_CODE)
                        {
                            errorMsg = "시스템 코드가 잘못되었습니다.";
                            isSuccess = false;
                            return Json(new { success = isSuccess, Msg = errorMsg }, JsonRequestBehavior.AllowGet);
                        }
                    }
                    else if (splitString[0].ToUpper() == "CONTENTS")
                    {
                        if (splitString[1] != Define.SSO_CONTENTS_CODE)
                        {
                            errorMsg = "컨텐츠 코드가 잘못되었습니다.";
                            isSuccess = false;
                            return Json(new { success = isSuccess, Msg = errorMsg }, JsonRequestBehavior.AllowGet);
                        }
                    }
                    else if (splitString[0].ToUpper() == "EMPNO")
                    {
                        empNo = splitString[1];
                    }
                }
                else
                {
                    errorMsg = "잘못된 문자열입니다.";
                    isSuccess = false;
                    return Json(new { success = isSuccess, Msg = errorMsg }, JsonRequestBehavior.AllowGet);
                }
            }

            if (string.IsNullOrWhiteSpace(empNo))
            {
                errorMsg = "사번정보가 없습니다.";
                isSuccess = false;
                return Json(new { success = isSuccess, Msg = errorMsg }, JsonRequestBehavior.AllowGet);
            }


            InsaUserV insa = insaUserVRepo.selectOne(new { empNo = empNo });

            List<SystemMenuAuth> systemMenuAuth = systemMenuAuthRepo.selectList(new { AuthUserKey = insa.userKey }).ToList();
            if (systemMenuAuth == null || systemMenuAuth.Count() <= 0)
            {
                errorMsg = empNo + "사번은 권한이 없습니다.";
                isSuccess = false;
                return Json(new { success = isSuccess, Msg = errorMsg }, JsonRequestBehavior.AllowGet);
            }
            else
            {
                errorMsg = systemMenuAuth.First().AuthUserKey;
                return Json(new { success = isSuccess, Msg = errorMsg }, JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// 푸시할 데이터를 입력하는 것입니다.
        /// </summary>
        /// <param name="pMaster"></param>
        /// <param name="userIdx"></param>
        /// <returns></returns>
        public JsonResult SendPush(PushMaster pMaster, List<InsaUserV> users)
        {
            var result = false;
            var errorMessage = string.Empty;

            try
            {
                var mobileDeviceRepo = new MobileDeviceRepo();
                var deviceList = mobileDeviceRepo.selectAll().ToList();

                var targetList =
                    from device in deviceList
                    join user in users on device.UserIdx.Trim() equals user.userKey.Trim()
                    select new { UserIdx = device.UserIdx.Trim(), DeviceToken = device.DeviceToken.Trim() };

                if (targetList.Count() > 0)
                {
                    pMaster.Response = SendFCM(pMaster, targetList.Select(x => x.DeviceToken).ToList());

                    var pMasterRepo = new PushMasterRepo();
                    int pushIdx = pMasterRepo.insert(pMaster);

                    if (pushIdx > -1)
                    {
                        var pDetailRepo = new PushDetailRepo();
                        foreach (var userIdx in targetList.Select(x => x.UserIdx).Distinct())
                        {
                            var pDetail = new PushDetail
                            {
                                PushIdx = pushIdx,
                                UserIdx = userIdx,
                                PushConfirm = 0
                            };

                            pDetailRepo.insert(pDetail);
                        }
                    }

                    result = true;
                }
                else
                {
                    errorMessage = "not exist device";
                }
            }
            catch (Exception e)
            {
                errorMessage = e.Message;
            }

            var dic = new Dictionary<string, object>
            {
                { "result", result },
                { "message", pMaster.Response },
                { "errorMessage", errorMessage }
            };

            return Json(dic);            
        }

        public List<string> SendPushServer(PushMaster pMaster, List<InsaUserV> users)
        {
            List<string> returnValue = new List<string>();
            var result = false;
            var errorMessage = string.Empty;

            try
            {
                var mobileDeviceRepo = new MobileDeviceRepo();
                var deviceList = mobileDeviceRepo.selectAll().ToList();

                var targetList =
                    from device in deviceList
                    join user in users on device.UserIdx.Trim() equals user.userKey.Trim()
                    select new { UserIdx = device.UserIdx.Trim(), DeviceToken = device.DeviceToken.Trim() };

                if (targetList.Count() > 0)
                {
                    pMaster.Response = SendFCM(pMaster, targetList.Select(x => x.DeviceToken).ToList());

                    var pMasterRepo = new PushMasterRepo();
                    int pushIdx = pMasterRepo.insert(pMaster);

                    if (pushIdx > -1)
                    {
                        var pDetailRepo = new PushDetailRepo();
                        foreach (var userIdx in targetList.Select(x => x.UserIdx).Distinct())
                        {
                            var pDetail = new PushDetail
                            {
                                PushIdx = pushIdx,
                                UserIdx = userIdx,
                                PushConfirm = 0
                            };

                            pDetailRepo.insert(pDetail);
                        }
                    }

                    result = true;
                }
                else
                {
                    errorMessage = "not exist device";
                }
            }
            catch (Exception e)
            {
                errorMessage = e.Message;
            }

            returnValue.Add(result.ToString());
            returnValue.Add(pMaster.Response);
            returnValue.Add(errorMessage);

            return returnValue;
        }

        public string SendFCM(PushMaster pushMaster, List<string> deviceTokens)
        {
            var message = string.Empty;

            try
            {
                //개발 테스트때문에 임시 주석처리 합니다.
                var request = (HttpWebRequest)WebRequest.Create("https://fcm.googleapis.com/fcm/send");
                request.Method = "post";
                request.ContentType = "application/json;charset=utf-8;";
                request.Headers.Add(string.Format("Authorization: key={0}", "AAAAjef81SA:APA91bEgGh90cbbhUdQZu0bZ4Pf4FN88wPFrsj7mYHwnSq3_CwSvp9MxqQEhMKPfR6-PZ1e8zTjHfrQY-sTPUDA7-1fNdThzFVdFRnckYICPq8Je_bJrEAlNcHx5byNNAdfLKN-4UoYj"));

                var json = new
                {
                    registration_ids = deviceTokens,
                    content_available = true,
                    notification = new { action = "fl", title = pushMaster.Title, body = pushMaster.Contents, sound = "default" },
                    data = new { title = pushMaster.Title, body = pushMaster.Contents, sound = "default", click_action = "click_action", link = pushMaster.Link }
                };

                var byteArray = Encoding.UTF8.GetBytes(JsonConvert.SerializeObject(json));
                request.ContentLength = byteArray.Length;

                var requestStream = request.GetRequestStream();
                requestStream.Write(byteArray, 0, byteArray.Length);
                requestStream.Close();

                var response = request.GetResponse();
                var responseStream = response.GetResponseStream();
                var reader = new StreamReader(responseStream);
                message = reader.ReadToEnd();
                reader.Close();
                responseStream.Close();
                response.Close();
            }
            catch (Exception e)
            {
                message = e.Message;
            }

            return message;
        }
    }
}