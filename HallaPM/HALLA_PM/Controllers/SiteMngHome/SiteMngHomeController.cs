using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

using HALLA_PM.Core;
using HALLA_PM.Util;
using HALLA_PM.Models;
using System.Dynamic;

namespace HALLA_PM.Controllers.SiteMngHome
{
    [RoutePrefix("SiteMngHome")]
    public class SiteMngHomeController : SiteMngBaseController
    {
        InsaDeptVRepo insaDeptVRepo = new InsaDeptVRepo();
        /// <summary>
        /// 처음화면
        /// </summary>
        /// <returns></returns>
        [AdminLoginFilter]
        [Route("Index")]
        public ActionResult Index()
        {
            //MailInfo mInfo = new MailInfo();
            //mInfo.fromAddress = "cdy0826@midasit.com";
            //mInfo.fromName = "조도연";
            //mInfo.toAddress = "heartless80@nate.com";
            //mInfo.subject = "한라그룹 테스트";
            //mInfo.body = "test";

            //var b = MailUtil.SendMail(mInfo);
            //Response.Write(b);
            return View();
        }

        [Route("LogOut")]
        public ActionResult LogOut()
        {
            SessionManager.RemoveAdminSession();
            return View();
        }

        /// <summary>
        /// 가이드용 뷰(오리지널)입니다.
        /// </summary>
        /// <returns></returns>
        [Route("ViewGuideOrg")]
        public ActionResult ViewGuideOrg()
        {
            return View("~/Views/SiteMngHome/ViewGuideOrg.cshtml");
        }
        
        /// <summary>
        /// 가이드용 뷰(오리지널)입니다.
        /// </summary>
        /// <returns></returns>
        [Route("ViewGuideList")]
        public ActionResult ViewGuideList()
        {
            return View("~/Views/SiteMngHome/ViewGuideList.cshtml");
        }

        #region LoginAccessTemp : 임시로그인화면
        /// <summary>
        /// 특정 사원으로 임시로 로그인할수 있는 화면. 개발 완료후 삭제 예정
        /// </summary>
        /// <returns></returns>
        [Route("LoginAccessTemp")]
        public ActionResult LoginAccessTemp()
        {
            Search search = new Search();
            search.PageCount = 100;
            var adminAuthList = adminAuthRepo.selectList(search);
            /*
             * 개발서버 기준
             * 최종관리자 : 1 : 정지수(B20001)H0000082539
             * 중간관리자 : 2 : 김성혁(P13975)H0000000231
             * 실적담당자 : 3 : 김재현(P13840)H0000000198
             */
            dynamic model = new ExpandoObject();
            model.adminAuthList = adminAuthList;

            string pmSabun = "";

            pmSabun += "ts=" + DateTime.Now.ToString("yyyyMMddHHmmss");
            pmSabun += "&system=" + Define.SSO_SYSTEM_CODE;
            pmSabun += "&contents=" + Define.SSO_CONTENTS_CODE;
            pmSabun += "&empNo=H0000082539";

            string EncPmSaBun = SSOUtil.Encrypt(pmSabun, Define.SSO_DECRYPT_KEY, false);
            string DecPmSaBun = SSOUtil.Decrypt(EncPmSaBun, Define.SSO_DECRYPT_KEY, false);
            string DecPmSaBunTest = SSOUtil.Decrypt("TaNWzz5TMBaj4aJk001y6JP+g8Oqt6r7aGyXlNKnYgfb9fZZFTLr8jYbuUhTGmwY+HH3PopWy0OENh7Bxq7h2ppmS0UrxSkKiK5t3GVwaj+hmIGAMJv34aRIEEaw/YHyTba9f11qOiXjdKevkCoCKA==", Define.SSO_DECRYPT_KEY, false);
            // TaNWzz5TMBYUTCmVAX%2FNbc60PbtWlfg3aGyXlNKnYgfb9fZZFTLr8jYbuUhTGmwY%2BHH3PopWy0OENh7Bxq7h2ppmS0UrxSkKiK5t3GVwaj%2BhmIGAMJv34aRIEEaw%2FYHypTETGWG8U1h0Mp%2FnOJWclQ%3D%3D
            //dynamic model = new ExpandoObject();
            model.pmSabun = pmSabun;
            model.EncPmSaBun = EncPmSaBun;
            model.DecPmSaBun = DecPmSaBun;
            model.DecPmSaBunTest = DecPmSaBunTest;
            /*

            string pmSabun = "";

            pmSabun += "ts=" + DateTime.Now.ToString("yyyyMMddHHmmss");
            pmSabun += "&system=" + Define.SSO_SYSTEM_CODE;
            pmSabun += "&contents=" + Define.SSO_CONTENTS_CODE;
            pmSabun += "&empNo=B20001";

            string EncPmSaBun = SSOUtil.Encrypt(pmSabun, Define.SSO_DECRYPT_KEY, false);
            string DecPmSaBun = SSOUtil.Decrypt(EncPmSaBun, Define.SSO_DECRYPT_KEY, false);
            dynamic model = new ExpandoObject();
            model.pmSaBun = pmSabun;
            model.EncPmSaBun = EncPmSaBun;
            model.DecPmSaBun = DecPmSaBun;

            var insa = insaUserVRepo.selectOne(new { empNo = "B20001" });

            model.insa = insa;

            //return View("~/Views/SiteMngHome/LoginAccessTemp.cstHtml");
            */

            return View(model);
        }
        #endregion

        #region ssoLoginTempProc : 임시로그인로직
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
        #endregion

        #region ssoLoginProc : 한마루 SSO 로그인입니다.
        /// <summary>
        /// 한마루 SSO 로그인입니다.
        /// </summary>
        /// <param name="PM_SABUN"></param>
        /// <returns></returns>
        [Route("ssoLoginProc")]
        public ActionResult ssoLoginProc(string PM_SABUN)
        {
            string decString = SSOUtil.Decrypt(PM_SABUN, Define.SSO_DECRYPT_KEY, false);
            string[] decList = decString.Split('&');
            string empNo = "";

            if (decList.Length != 4)
            {
                TempData["alert"] = "잘못된 접근입니다.\\n암호화 코드가 잘못되었습니다.";
                return Redirect(Define.ERROR_PAGE_URL);
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
                            return Redirect(Define.ERROR_PAGE_URL);
                        }
                    }
                    else if (splitString[0].ToUpper() == "SYSTEM")
                    {
                        if (splitString[1] != Define.SSO_SYSTEM_CODE)
                        {
                            TempData["alert"] = "시스템 코드가 잘못되었습니다.";
                            return Redirect(Define.ERROR_PAGE_URL);
                        }
                    }
                    else if (splitString[0].ToUpper() == "CONTENTS")
                    {
                        if (splitString[1] != Define.SSO_CONTENTS_CODE)
                        {
                            TempData["alert"] = "컨텐츠 코드가 잘못되었습니다.";
                            return Redirect(Define.ERROR_PAGE_URL);
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
                    return Redirect(Define.ERROR_PAGE_URL);
                }
            }

            if (string.IsNullOrWhiteSpace(empNo))
            {
                TempData["alert"] = "사번정보가 없습니다.";
                return Redirect(Define.ERROR_PAGE_URL);
            }


            InsaUserV insa = insaUserVRepo.selectOne(new { empNo = empNo });

            if (insa == null)
            {
                TempData["alert"] = "접속 사번에 대한 인사정보가 없습니다.";
                return Redirect(Define.ERROR_PAGE_URL);
            }

            //

            // 페이지에 대한 권한을 추후 가져와야한다.
            AdminAuth adminAuth = adminAuthRepo.selectOne(new { AuthUserKey = insa.userKey});
            InsaDeptV insaDept = insaDeptVRepo.selectOne(new { Deptcode = insa.deptCode });
            int orgCount = adminOrgAuthRepo.countOrg(new { AuthUserKey = insa.userKey });

            if (adminAuth == null || adminAuth.IsUse == "N")
            {
                TempData["alert"] = "해당 사용자는 권한이 없습니다.";
                return Redirect(Define.ERROR_PAGE_URL);
            }

            SessionManager.SetAdminSession(new AdminSession { insaUserV = insa, adminAuth = adminAuth, insaDeptV = insaDept, orgCount = orgCount });
            AdminAccessLog adminAccessLog = new AdminAccessLog();
            adminAccessLog.UserKey = insa.userKey;
            adminAccessLog.EmpNo = insa.empNo;
            adminAccessLog.Ip = WebUtil.GetClientIP();
            adminAccessLog.UserKorName = insa.userKorName;
            adminAccessLog.Memo = "로그인 성공";

            adminAccessLogRepo.insert(adminAccessLog);

            //return View("~/Views/SiteMngHome/Main/Index.cshtml");
            //return RedirectToAction("Index");
            // 관리자 최초접근시 경영실적 Cash Flow로 이동 2018.12.06
            return Redirect("/SiteMngHome/Performance/Cash_Flow/List");
            //return Redirect("/SiteMngHome/Main/Index");
        }
        #endregion

        [Route("webToAdmin")]
        public ActionResult webToAdmin()
        {
            var sessionAdmin = SessionManager.GetAdminSession();
            if (sessionAdmin == null)
            {
                TempData["alert"] = "세션이 만료되거나 잘못된 접근입니다.";
                return Redirect(Define.ERROR_PAGE_URL);
            }

            if (sessionAdmin.adminAuth == null)
            {
                TempData["alert"] = "세션이 만료되거나 잘못된 접근입니다.";
                return Redirect(Define.ERROR_PAGE_URL);
            }

            AdminAccessLog adminAccessLog = new AdminAccessLog();
            adminAccessLog.UserKey = sessionAdmin.insaUserV.userKey;
            adminAccessLog.EmpNo = sessionAdmin.insaUserV.empNo;
            adminAccessLog.Ip = WebUtil.GetClientIP();
            adminAccessLog.UserKorName = sessionAdmin.insaUserV.userKorName;
            adminAccessLog.Memo = "로그인 성공";

            adminAccessLogRepo.insert(adminAccessLog);

            return Redirect("/SiteMngHome/Performance/Cash_Flow/List");
        }


        public ActionResult ssoLoginTempProc2(string empNo)
        {
            string pmSabun = "";

            pmSabun += "ts=" + DateTime.Now.ToString("yyyyMMddHHmmss");
            pmSabun += "&system=" + Define.SSO_SYSTEM_CODE;
            pmSabun += "&contents=" + Define.SSO_CONTENTS_CODE;
            pmSabun += "&empNo=" + empNo;

            string EncPmSaBun = SSOUtil.Encrypt(pmSabun, Define.SSO_DECRYPT_KEY, false);
            return SiteMngHomeAuthCheckProc(EncPmSaBun);
        }

        public JsonResult SiteMngHomeAuthCheckProc(string PM_SABUN)
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
                        DateTime dtAfter = DateTime.Now.AddMinutes(5);

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

            AdminAuth adminAuth = adminAuthRepo.selectOne(new { AuthUserKey = insa.userKey });
            if (adminAuth == null)
            {
                errorMsg = empNo + "사번은 권한이 없습니다.";
                isSuccess = false;
                return Json(new { success = isSuccess, Msg = errorMsg }, JsonRequestBehavior.AllowGet);
            }
            else
            {
                return Json(new { success = isSuccess, Msg = errorMsg }, JsonRequestBehavior.AllowGet);
            }

        }
    }
}