using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

using HALLA_PM.Core;
using HALLA_PM.Util;
using HALLA_PM.Models;
using System.Dynamic;
using Fluentx.Mvc;

namespace HALLA_PM.Controllers
{
    public class HomeController : Controller
    {
        SystemAuthRepo systemAuthRepo = new SystemAuthRepo();
        SystemMenuAuthRepo systemMenuAuthRepo = new SystemMenuAuthRepo();
        SystemOrgAuthRepo systemOrgAuthRepo = new SystemOrgAuthRepo();
        PageAuthRepo pageAuthRepo = new PageAuthRepo();
        InsaUserVRepo insaUserVRepo = new InsaUserVRepo();
        InsaDeptVRepo insaDeptVRepo = new InsaDeptVRepo();
        RegistYearListRepo rYearListRepo = new RegistYearListRepo();
        OrgCompanyRepo orgCompanyRepo = new OrgCompanyRepo();

        [SystemLoginFilter]
        public ActionResult Index()
        {
            return View();
        }
        
        public ActionResult LogOut()
        {
            SessionManager.RemoveMemberSession();
            return View();
        }

        public ActionResult Error()
        {
            return View();
        }

        public ActionResult LoginAccessTemp()
        {
            Search search = new Search();
            search.PageCount = 100;
            var systemAuthList = systemAuthRepo.selectList(search);


            dynamic model = new ExpandoObject();
            model.systemAuthList = systemAuthList;

            return View(model);
        }

        /// <summary>
        /// 2018.11.28 empNo(사번)은 중복이 있을수 있어 파라미터 이름을 동일하지만 userKey값을 넘긴다.
        /// </summary>
        /// <param name="empNo"></param>
        /// <returns></returns>
        public ActionResult ssoLoginTempProc(string empNo)
        {
            string pmSabun = "";

            pmSabun += "ts=" + DateTime.Now.ToString("yyyyMMddHHmmss");
            pmSabun += "&system=" + Define.SSO_SYSTEM_CODE;
            pmSabun += "&contents=" + Define.SSO_CONTENTS_CODE;
            pmSabun += "&empNo=" + empNo;

            string EncPmSaBun = SSOUtil.Encrypt(pmSabun, Define.SSO_DECRYPT_KEY, false);
            return ssoLoginProc(EncPmSaBun);
        }

        public ActionResult ssoLogingTest(string empNo, string HprsUrl,string confirmComment = "")
        {
            LogUtil.Error("코멘트:" + confirmComment);
            string pmSabun = "";

            pmSabun += "ts=" + DateTime.Now.ToString("yyyyMMddHHmmss");
            pmSabun += "&system=" + Define.SSO_SYSTEM_CODE;
            pmSabun += "&contents=" + Define.SSO_CONTENTS_CODE;
            pmSabun += "&empNo=" + empNo;
            
            string EncPmSaBun = SSOUtil.Encrypt(pmSabun, Define.SSO_DECRYPT_KEY, false);
            return ssoLoginProc(EncPmSaBun, "", "", HprsUrl, confirmComment);
        }

        public ActionResult ssoLoginProcMobileApp(string PM_SABUN, string MOBILE_TOKEN = "", string DEVICE_TYPE = "")
        {
            // 2018.12.11 11:30 앱 _ 한마루 앱에서 로그인시 암호화 사번을 이미 생성하고 가지고 있기때문에
            // 5분 시간 제한이 걸리기에 해당 로직은 빼기로 협의 
            string decString = SSOUtil.Decrypt(PM_SABUN, Define.SSO_DECRYPT_KEY, false);
            string[] decList = decString.Split('&');
            string empNo = "";

            if (decList.Length != 4)
            {
                TempData["alert"] = "잘못된 접근입니다.\\n암호화 코드가 잘못되었습니다.";
                return Redirect(Define.SYSTEM_ERROR_PAGE_URL);
            }

            foreach (string str in decList)
            {
                if (str.IndexOf('=') > 0)
                {
                    string[] splitString = str.Split('=');
                    if (splitString[0].ToUpper() == "TS")
                    {
                        //DateTime dtDec = DateTime.ParseExact(splitString[1], "yyyyMMddHHmmss", null);
                        //DateTime dtBofore = DateTime.Now.AddMinutes(-5);
                        //DateTime dtAfter = DateTime.Now.AddMinutes(5);

                        //if (dtDec <= dtBofore || dtDec >= dtAfter)
                        //{
                        //    TempData["alert"] = "연결시간을 초과하였습니다.";
                        //    return Redirect(Define.SYSTEM_ERROR_PAGE_URL);
                        //}
                    }
                    else if (splitString[0].ToUpper() == "SYSTEM")
                    {
                        if (splitString[1] != Define.SSO_SYSTEM_CODE)
                        {
                            TempData["alert"] = "시스템 코드가 잘못되었습니다.";
                            return Redirect(Define.SYSTEM_ERROR_PAGE_URL);
                        }
                    }
                    else if (splitString[0].ToUpper() == "CONTENTS")
                    {
                        if (splitString[1] != Define.SSO_CONTENTS_CODE)
                        {
                            TempData["alert"] = "컨텐츠 코드가 잘못되었습니다.";
                            return Redirect(Define.SYSTEM_ERROR_PAGE_URL);
                        }
                    }
                    else if (splitString[0].ToUpper() == "EMPNO")
                    {
                        empNo = splitString[1];
                    }
                }
                else
                {
                    TempData["alert"] = "잘못된 문자열입니다.";
                    return Redirect(Define.SYSTEM_ERROR_PAGE_URL);
                }
            }

            if (string.IsNullOrWhiteSpace(empNo))
            {
                TempData["alert"] = "사번정보가 없습니다.";
                return Redirect(Define.ERROR_PAGE_URL);
            }


            InsaUserV insa = insaUserVRepo.selectOne(new { empNo = empNo });
            InsaDeptV insaDept = insaDeptVRepo.selectOne(new { Deptcode = insa.deptCode });
            List<LevelTwo> lv2 = pageAuthRepo.GetUnionAuthLeft(new { AuthUserKey = insa.userKey }).ToList();
            List<SystemMenuAuth> systemMenuAuth = systemMenuAuthRepo.selectList(new { AuthUserKey = insa.userKey }).Where(w => w.IsUse == "Y").ToList();
            List<SystemOrgAuthExp> systemOrgAuthExp = systemOrgAuthRepo.selectListExp(new { AuthUserKey = insa.userKey }).ToList();
            List<RegistYearList> planYear = rYearListRepo.selectListPlan(new { }).ToList();

            if (systemMenuAuth == null || systemMenuAuth.Count() <= 0)
            {
                TempData["alert"] = "해당사번에 권한이 없습니다.";
                return Redirect(Define.ERROR_PAGE_URL);
            }

            // 2018.11.14 사용자에서 관리자 권한을 체크하여 버튼 활성화한다.
            AdminAuthRepo adminAuthRepo = new AdminAuthRepo();
            AdminAuth adminAuth = adminAuthRepo.selectOne(new { AuthUserKey = insa.userKey });

            if (!String.IsNullOrEmpty(MOBILE_TOKEN) && !String.IsNullOrEmpty(DEVICE_TYPE))
            {
                //mobile token 처리
                MobileDeviceRepo mobileDeviceRepo = new MobileDeviceRepo();
                MobileDevice mobileDevice = mobileDeviceRepo.selectOne(new { USER_IDX = insa.userKey, DEVICE_TOKEN = MOBILE_TOKEN });
                if (mobileDevice == null)
                {
                    //중복 토큰 없음
                    mobileDevice = new MobileDevice();
                    mobileDevice.UserIdx = insa.userKey;
                    mobileDevice.DeviceType = DEVICE_TYPE;
                    mobileDevice.DeviceToken = MOBILE_TOKEN;
                    mobileDevice.CreatedAt = DateTime.Now;
                    mobileDeviceRepo.insert(mobileDevice);
                }

            }

            MemberSession mSession = new MemberSession();
            mSession.insaUserV = insa;
            mSession.insaDeptV = insaDept;
            mSession.lv2 = lv2;
            mSession.systemMenuAuth = systemMenuAuth;
            mSession.systemOrgAuth = systemOrgAuthExp;
            mSession.planYear = planYear;
            // 2018.12.11 앱에서 접근시 관리자는 안 보여지는게 맞기때문에 권한이 없는 것으로 한다.
            mSession.adminAuth = null;
            SessionManager.SetMemberSession(mSession);


            //return RedirectToAction("Index");
            return Redirect("/Main/Main");
        }

        public ActionResult ssoLoginProc(string PM_SABUN, string MOBILE_TOKEN = "", string DEVICE_TYPE = "", string HPRSURL = "",string confirmComment = "")
        {
            // 2018.12.11 11:30 앱 _ 한마루 앱에서 로그인시 암호화 사번을 이미 생성하고 가지고 있기때문에
            // 5분 시간 제한이 걸리기에 해당 로직은 빼기로 협의 
            string decString = SSOUtil.Decrypt(PM_SABUN, Define.SSO_DECRYPT_KEY, false);
            string[] decList = decString.Split('&');
            string empNo = "";

            if (decList.Length != 4)
            {
                TempData["alert"] = "잘못된 접근입니다.\\n암호화 코드가 잘못되었습니다.";
                return Redirect(Define.SYSTEM_ERROR_PAGE_URL);
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
                        DateTime dtAfter = DateTime.Now.AddMinutes(5);

                        if (dtDec <= dtBofore || dtDec >= dtAfter)
                        {
                            TempData["alert"] = "연결시간을 초과하였습니다.";
                            return Redirect(Define.SYSTEM_ERROR_PAGE_URL);
                        }
                    }
                    else if (splitString[0].ToUpper() == "SYSTEM")
                    {
                        if (splitString[1] != Define.SSO_SYSTEM_CODE)
                        {
                            TempData["alert"] = "시스템 코드가 잘못되었습니다.";
                            return Redirect(Define.SYSTEM_ERROR_PAGE_URL);
                        }
                    }
                    else if (splitString[0].ToUpper() == "CONTENTS")
                    {
                        if (splitString[1] != Define.SSO_CONTENTS_CODE)
                        {
                            TempData["alert"] = "컨텐츠 코드가 잘못되었습니다.";
                            return Redirect(Define.SYSTEM_ERROR_PAGE_URL);
                        }
                    }
                    else if (splitString[0].ToUpper() == "EMPNO")
                    {
                        empNo = splitString[1];
                    }
                }
                else
                {
                    TempData["alert"] = "잘못된 문자열입니다.";
                    return Redirect(Define.SYSTEM_ERROR_PAGE_URL);
                }
            }

            if (string.IsNullOrWhiteSpace(empNo))
            {
                TempData["alert"] = "사번정보가 없습니다.";
                return Redirect(Define.SYSTEM_ERROR_PAGE_URL);
            }


            InsaUserV insa = insaUserVRepo.selectOne(new { empNo = empNo });

            if (insa == null)
            {
                TempData["alert"] = "접속 사번에 대한 인사정보가 없습니다.";
                return Redirect(Define.SYSTEM_ERROR_PAGE_URL);
            }
            InsaDeptV insaDept = insaDeptVRepo.selectOne(new { Deptcode = insa.deptCode});
            List<LevelTwo> lv2 = pageAuthRepo.GetUnionAuthLeft(new { AuthUserKey = insa.userKey }).ToList();
            List<SystemMenuAuth> systemMenuAuth = systemMenuAuthRepo.selectList(new { AuthUserKey = insa.userKey }).Where(w => w.IsUse == "Y").ToList();
            List<SystemOrgAuthExp> systemOrgAuthExp = systemOrgAuthRepo.selectListExp(new { AuthUserKey = insa.userKey }).ToList();
            List<RegistYearList> planYear = rYearListRepo.selectListPlan(new { }).ToList();
            
            // 2018.11.14 사용자에서 관리자 권한을 체크하여 버튼 활성화한다.
            AdminAuthRepo adminAuthRepo = new AdminAuthRepo();
            AdminOrgAuthRepo adminOrgAuthRepo = new AdminOrgAuthRepo();
            AdminAuth adminAuth = adminAuthRepo.selectOne(new { AuthUserKey = insa.userKey });
            int orgCount = adminOrgAuthRepo.countOrg(new { AuthUserKey = insa.userKey });

            if (!String.IsNullOrEmpty(MOBILE_TOKEN) && !String.IsNullOrEmpty(DEVICE_TYPE))
            {
                //mobile token 처리
                MobileDeviceRepo mobileDeviceRepo = new MobileDeviceRepo();
                MobileDevice mobileDevice = mobileDeviceRepo.selectOne(new { USER_IDX = insa.userKey, DEVICE_TOKEN = MOBILE_TOKEN});
                if( mobileDevice == null)
                {
                    //중복 토큰 없음
                    mobileDevice = new MobileDevice();
                    mobileDevice.UserIdx = insa.userKey;
                    mobileDevice.DeviceType = DEVICE_TYPE;
                    mobileDevice.DeviceToken = MOBILE_TOKEN;
                    mobileDevice.CreatedAt = DateTime.Now;
                    mobileDeviceRepo.insert(mobileDevice);
                }

            }

            MemberSession mSession = new MemberSession();
            mSession.insaUserV = insa;
            mSession.insaDeptV = insaDept;
            mSession.lv2 = lv2;
            mSession.systemMenuAuth = systemMenuAuth;
            mSession.systemOrgAuth = systemOrgAuthExp;
            mSession.planYear = planYear;
            mSession.adminAuth = adminAuth;
            SessionManager.SetMemberSession(mSession);

            // 2019.01.07 관리자 세션도 같이 넣어준다.
            AdminSession aSession = new AdminSession();
            aSession.insaUserV = insa;
            aSession.insaDeptV = insaDept;
            aSession.adminAuth = adminAuth;
            aSession.orgCount = orgCount;
            SessionManager.SetAdminSession(aSession);
            // 2019.01.07 HPRSURL에 값이 있으면 관리자로 리다이렉트
            if (!string.IsNullOrWhiteSpace(HPRSURL))
            {
                string[] splitUrl = HPRSURL.Split(':');
                int intCount = splitUrl.Count();
                if (splitUrl.Count() >= 7)
                {
                    #region
                    Dictionary<string, object> postData = new Dictionary<string, object>();
                    postData.Add("Seq", splitUrl[1]);
                    postData.Add("OrgCompanySeq", splitUrl[2]);
                    postData.Add("pmYear", splitUrl[3]);
                    postData.Add("monthly", splitUrl[4]);
                    postData.Add("preStatus", splitUrl[5]);
                    postData.Add("confirmStatus", splitUrl[6]);
                    postData.Add("confirmComment", confirmComment);
                    #endregion

                    // 2019.03.12 로그 남기기 추가
                    AdminAccessLogRepo adminAccessLogRepo = new AdminAccessLogRepo();
                    AdminAccessLog adminAccessLog = new AdminAccessLog();
                    adminAccessLog.UserKey = insa.userKey;
                    adminAccessLog.EmpNo = insa.empNo;
                    adminAccessLog.Ip = WebUtil.GetClientIP();
                    adminAccessLog.UserKorName = insa.userKorName;
                    adminAccessLog.Memo = "로그인 성공";

                    adminAccessLogRepo.insert(adminAccessLog);

                    return RedirectAndPostActionResult.RedirectAndPost(splitUrl[0], postData);
                }
                else if(splitUrl.Count() == 3)
                {
                    #region
                    Dictionary<string, object> postData = new Dictionary<string, object>();
                    postData.Add("Seq", splitUrl[1]);
                    postData.Add("OrgCompanySeq", splitUrl[2]); 
                    #endregion

                    // 2019.03.12 로그 남기기 추가
                    AdminAccessLogRepo adminAccessLogRepo = new AdminAccessLogRepo();
                    AdminAccessLog adminAccessLog = new AdminAccessLog();
                    adminAccessLog.UserKey = insa.userKey;
                    adminAccessLog.EmpNo = insa.empNo;
                    adminAccessLog.Ip = WebUtil.GetClientIP();
                    adminAccessLog.UserKorName = insa.userKorName;
                    adminAccessLog.Memo = "로그인 성공";

                    adminAccessLogRepo.insert(adminAccessLog);

                    return RedirectAndPostActionResult.RedirectAndPost(splitUrl[0], postData);
                }
                else
                {
                    return Redirect(HPRSURL);
                }
            }

            //if (systemMenuAuth == null || systemMenuAuth.Count() <= 0)
            //{
            //    TempData["alert"] = "해당사번에 메뉴 권한이 없습니다.";
            //    return Redirect(Define.SYSTEM_ERROR_PAGE_URL);
            //}

            //return RedirectToAction("Index");
            return Redirect("/Main/Main");
        }

        public ActionResult ssoLoginTempProc2(string empNo)
        {
            string pmSabun = "";

            pmSabun += "ts=" + DateTime.Now.ToString("yyyyMMddHHmmss");
            pmSabun += "&system=" + Define.SSO_SYSTEM_CODE;
            pmSabun += "&contents=" + Define.SSO_CONTENTS_CODE;
            pmSabun += "&empNo=" + empNo;

            string EncPmSaBun = SSOUtil.Encrypt(pmSabun, Define.SSO_DECRYPT_KEY, false);
            return SystemAuthCheckProc(EncPmSaBun);
        }

        /// <summary>
        /// 2018.11.28 empNo(사번)은 중복이 있을수 있어 파라미터 이름을 동일하지만 userKey값을 넘긴다.
        /// </summary>
        /// <param name="PM_SABUN"></param>
        /// <returns></returns>
        public JsonResult SystemAuthCheckProc(string PM_SABUN)
        {
            string decString = SSOUtil.Decrypt(PM_SABUN, Define.SSO_DECRYPT_KEY, false);
            string[] decList = decString.Split('&');
            string empNo = "";

            bool isSuccess = true;
            string errorMsg = "권한이 있는 사용자입니다.";

            if (decList.Length != 4)
            {
                errorMsg = "잘못된 접근입니다암호화 코드가 잘못되었습니다.";
                isSuccess = false;
                return Json(new { success = isSuccess.ToString(), Msg = errorMsg }, JsonRequestBehavior.AllowGet);
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
                        DateTime dtAfter = DateTime.Now.AddMinutes(5);

                        if (dtDec <= dtBofore || dtDec >= dtAfter)
                        {
                            errorMsg = "연결시간을 초과하였습니다.";
                            isSuccess = false;
                            return Json(new { success = isSuccess.ToString(), Msg = errorMsg }, JsonRequestBehavior.AllowGet);
                        }
                    }
                    else if (splitString[0].ToUpper() == "SYSTEM")
                    {
                        if (splitString[1] != Define.SSO_SYSTEM_CODE)
                        {
                            errorMsg = "시스템 코드가 잘못되었습니다.";
                            isSuccess = false;
                            return Json(new { success = isSuccess.ToString(), Msg = errorMsg }, JsonRequestBehavior.AllowGet);
                        }
                    }
                    else if (splitString[0].ToUpper() == "CONTENTS")
                    {
                        if (splitString[1] != Define.SSO_CONTENTS_CODE)
                        {
                            errorMsg = "컨텐츠 코드가 잘못되었습니다.";
                            isSuccess = false;
                            return Json(new { success = isSuccess.ToString(), Msg = errorMsg }, JsonRequestBehavior.AllowGet);
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
                    return Json(new { success = isSuccess.ToString(), Msg = errorMsg }, JsonRequestBehavior.AllowGet);
                }
            }

            if (string.IsNullOrWhiteSpace(empNo))
            {
                errorMsg = "사번정보가 없습니다.";
                isSuccess = false;
                return Json(new { success = isSuccess.ToString(), Msg = errorMsg }, JsonRequestBehavior.AllowGet);
            }


            InsaUserV insa = insaUserVRepo.selectOne(new { empNo = empNo });

            List<SystemMenuAuth> systemMenuAuth = systemMenuAuthRepo.selectList(new { AuthUserKey = insa.userKey }).Where(w => w.IsUse == "Y").ToList();
            if (systemMenuAuth == null || systemMenuAuth.Count() <= 0)
            {
                errorMsg = empNo + "사번은 권한이 없습니다.";
                isSuccess = false;
                return Json(new { success = isSuccess.ToString(), Msg = errorMsg }, JsonRequestBehavior.AllowGet);
            }
            else
            {
                return Json(new { success = isSuccess.ToString(), Msg = errorMsg }, JsonRequestBehavior.AllowGet);
            }

        }
    }
}