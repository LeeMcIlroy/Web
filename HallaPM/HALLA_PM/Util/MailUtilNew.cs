using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using HALLA_PM.Models;
using System.Net.Mail;
using HALLA_PM.Core;
using System.IO;
using HALLA_PM.Controllers;

namespace HALLA_PM.Util
{
    public class MailUtilNew
    {
        public static bool SendMail(MailInfo mInfo)
        {
            bool success = true;
            bool bloTestServer = false;
           
            string smtpServer = "";
            int smtpPort = 0;

            smtpServer = "mail.halla.com";
            smtpPort = 25;
            

            if (HttpContext.Current.Request.Url.Host.Contains("localhost") || HttpContext.Current.Request.Url.Host.Contains("midashelp") || HttpContext.Current.Request.Url.Host.Contains("test") || HttpContext.Current.Request.Url.Host.Contains("hprstest") || HttpContext.Current.Request.Url.Host.Contains("115.88.138.221") )
            {
                bloTestServer = !bloTestServer;
            }
            if (bloTestServer) {
                smtpServer = "mw-002.cafe24.com";
                smtpPort = 587;
            }            

            SmtpClient sClient = new SmtpClient(smtpServer, smtpPort);
            //sClient.UseDefaultCredentials = true;
            if (bloTestServer)
            {
                sClient.UseDefaultCredentials = false;  //추가
                sClient.Credentials = new System.Net.NetworkCredential("help@hprstest.com", "hprstest01");  //추가
            }
            else
            {
                sClient.UseDefaultCredentials = true;
            }
            sClient.DeliveryMethod = SmtpDeliveryMethod.Network;
            
            if (bloTestServer)
            {

                if (mInfo.AuthLevel == Define.AUTH_LEVEL.GetKey("실적 담당자"))
                {
                    mInfo.toAddress = "hyosub.kim@halla.com";
                    mInfo.toName = "김효섭 대리";  
                }
                else if (mInfo.AuthLevel == Define.AUTH_LEVEL.GetKey("중간 관리자")) {
                    mInfo.toAddress = "sunghyuk.kim@halla.com";
                    mInfo.toName = "김성혁 과장";
                }
                else if (mInfo.AuthLevel == Define.AUTH_LEVEL.GetKey("중간 관리자2")) {
                    mInfo.toAddress = "dj.jeong@halla.com";
                    mInfo.toName = "정다정 프로";
                }
                else if (mInfo.AuthLevel == Define.AUTH_LEVEL.GetKey("최종 관리자")) {
                    mInfo.toAddress = "fin.rpa@halla.com";
                    mInfo.toName = "최종관리자";
                }
            }
            MailAddress from = new MailAddress(mInfo.fromAddress, mInfo.fromName);
            MailAddress to = new MailAddress(mInfo.toAddress, mInfo.toName);

            MailMessage message = new MailMessage(from, to);
            message.Subject = mInfo.subject;
            message.Body = mInfo.body;
            message.IsBodyHtml = true;



            // 2018.01.03 메일 발송 시 이력 남기기 추가
            MailSendListRepo mSendListRepo = new MailSendListRepo();
            try
            {
                sClient.Send(message);

                message.Dispose();

                MailSendList m = new MailSendList();
                m.ToAddress = mInfo.toAddress;
                m.FmAddress = mInfo.fromAddress;
                m.Subject = mInfo.subject;
                m.Body = mInfo.body;
                m.IsSend = "Y";
                m.FailReason = "";
                mSendListRepo.insert(m);
            }
            catch (Exception e)
            {
                LogUtil.MngError(e.ToString());
                success = false;

                MailSendList m = new MailSendList();
                m.ToAddress = mInfo.toAddress;
                m.FmAddress = mInfo.fromAddress;
                m.Subject = mInfo.subject;
                m.Body = mInfo.body;
                m.IsSend = "N";
                m.FailReason = e.Message;
                mSendListRepo.insert(m);
            }

            return success;
        }

        public static void RegistStatusMail(MailInfo mInfo,string sendStatus)
        {
            AdminAuthRepo adminAuthRepo = new AdminAuthRepo();
            InsaUserVRepo insaUserVRepo = new InsaUserVRepo();
            InsaDeptVRepo insaDeptVRepo = new InsaDeptVRepo();
            
            // 보내는 사람의 메일 주소 가져오기
            string userKey = SessionManager.GetAdminSession().insaUserV.userKey;
            InsaUserV sendInfo = insaUserVRepo.selectOneMail(new { userKey });

            InsaDeptV insaDept = insaDeptVRepo.selectOne(new { Deptcode = sendInfo.deptCode });
  
            if (insaDept == null)
            {
                insaDept = new InsaDeptV();
                insaDept.Compkorname = "검색안됨";
                insaDept.Deptkorname = "검색안됨";
            }

            mInfo.fromAddress = sendInfo.emailAddress;
            mInfo.fromName = sendInfo.userKorName;
            mInfo.UserInfo = insaDept.Compkorname + " / " + insaDept.Deptkorname + " / " + sendInfo.userKorName;

            string serverUrl = "http://" + HttpContext.Current.Request.Url.Host;
            // 메일 폼 불러오기
            string URL_CASH_FLOW     = "/SiteMngHome/Performance/Cash_Flow/Edit" + ":";
            string URL_PAL           = "/SiteMngHome/Performance/Pal/Edit" + ":";
            string URL_QUARTER_PAL   = "/SiteMngHome/Performance/Quarter_Pal/Edit" + ":";
            string URL_BS            = "/SiteMngHome/Performance/BsNew/Edit" + ":";
            string URL_BSEX          = "/SiteMngHome/Performance/BsEx/Edit" + ":";
            string URL_INVEST        = "/SiteMngHome/Performance/InvestNew/Edit" + ":";            
            string strTempSeq = "";
            
            string COMFORM_COMMENT          = (mInfo.RejectReson != null) ? HttpContext.Current.Server.UrlDecode(mInfo.RejectReson) : "";
            if (mInfo.objPmSeq != null)
            {
                foreach (var strValues in mInfo.objPmSeq)
                {
                    URL_CASH_FLOW    = (strValues.Key == "PM_CASH_FLOW") ? URL_CASH_FLOW  + strValues.Value.ToString() + ":" + mInfo.OrgCompanySeq  : URL_CASH_FLOW;
                    URL_PAL          = (strValues.Key == "PM_PAL") ? URL_PAL  + strValues.Value.ToString() + ":" + mInfo.OrgCompanySeq : URL_PAL;
                    URL_QUARTER_PAL  = (strValues.Key == "PM_QUARTER_PAL") ? URL_QUARTER_PAL  + strValues.Value.ToString() + ":" + mInfo.OrgCompanySeq : URL_QUARTER_PAL;
                    URL_BS           = (strValues.Key == "PM_BS") ? URL_BS  + strValues.Value.ToString() + ":" + mInfo.OrgCompanySeq : URL_BS;
                    URL_BSEX         = (strValues.Key == "PM_BS_EX") ? URL_BSEX  + strValues.Value.ToString() + ":" + mInfo.OrgCompanySeq : URL_BSEX;
                    URL_INVEST       = (strValues.Key == "PM_INVEST") ? URL_INVEST  + strValues.Value.ToString() + ":" + mInfo.OrgCompanySeq : URL_INVEST;
                    strTempSeq       = strValues.Value.ToString();
                }
            }

            string mailForm = "";
            string strDisplay = (mInfo.OrgCompanySeq != 6) ? "none" : "";
            string redirectUrl = "";
            string COMFORM_URL = string.Format("/SiteMngHome/Confirm/RegistSendForm:{0}:{1}:{2}:{3}:{4}:{5}", strTempSeq, mInfo.OrgCompanySeq, mInfo.year, mInfo.mm,3,6);

            //if (HttpContext.Current.Request.Url.Host.Contains("localhost") || HttpContext.Current.Request.Url.Host.Contains("midashelp") || HttpContext.Current.Request.Url.Host.Contains("test")  || HttpContext.Current.Request.Url.Host.Contains("hprstest"))
                if ( HttpContext.Current.Request.Url.Host.Contains("midashelp") || HttpContext.Current.Request.Url.Host.Contains("test") || HttpContext.Current.Request.Url.Host.Contains("hprstest"))

                {
                    redirectUrl = "/Home/ssoLogingTest?empNo=" + "&HPRSURL=";
            }
            else
            {
                redirectUrl = "/Portal/Gadget/SignOnMando?SsoId=HALLA.HEIS&HPRSURL=";
            }

            string DETAIL_URL_CASH_FLOW = "";
            string DETAIL_URL_PAL = "";
            string DETAIL_URL_QUARTER_PAL = "";
            string DETAIL_URL_BS = "";
            string DETAIL_URL_BSEX = "";
            string DETAIL_URL_INVEST = "";
            string DETAIL_COMFORM_URL = "";

            if (mInfo.afterRegistStatus == Define.REGIST_STATUS.GetKey("승인대기") && sendStatus == "ALL") //승인요청이면
            {
                // 중간관리자에게 메일 발송
                // 중간관리자 리스트 가져오기
                //해당회사,년,월 실적정보상태가 승인대기가 총 6개 이면 
                // 통합승인메일을 발송한다.
                mInfo.AuthLevel = Define.AUTH_LEVEL.GetKey("중간 관리자");
                List<AdminAuth> adminList = adminAuthRepo.selectListCompany(mInfo).ToList();


                foreach (var item in adminList)
                {
                    mailForm = MailForm(mInfo.afterRegistStatus, "CONFIRM");
                    InsaUserV toInfo = insaUserVRepo.selectOneMail(new { userKey = item.AuthUserKey });
                    mInfo.toAddress = toInfo.emailAddress;
                    mInfo.toName = toInfo.userKorName;
                    mInfo.subject = "[HPRS] " + mInfo.year + "년 " + mInfo.mm + "월 경영실적 승인 안내 메일입니다.";

                    mailForm = mailForm.Replace("{URL}", serverUrl).Replace("{YEAR}", mInfo.year).Replace("{MM}", mInfo.mm).Replace("{MENU_NAME}", mInfo.menuName).Replace("{CONTENT}", "승인요청이 등록되었습니다.").Replace("{COMPANY}", item.CompKorName).Replace("{HALLA_EX_DISPLAY}", strDisplay);

                    // 2019.01.13 결제라인 추가

                    // string hprsUrl = mInfo.ReferUrl + ":" + mInfo.Seq + ":" + mInfo.OrgCompanySeq;
                    // 개발서버 로그인 테스트용 url변경
                    //hprsUrl = UrlString(redirectUrl.Replace("empNo=", "empNo=" + item.AuthUserKey) + hprsUrl);

                    DETAIL_URL_CASH_FLOW = UrlString(redirectUrl.Replace("empNo=", "empNo=" + item.AuthUserKey) + URL_CASH_FLOW);
                    DETAIL_URL_PAL = UrlString(redirectUrl.Replace("empNo=", "empNo=" + item.AuthUserKey) + URL_PAL);
                    DETAIL_URL_QUARTER_PAL = UrlString(redirectUrl.Replace("empNo=", "empNo=" + item.AuthUserKey) + URL_QUARTER_PAL);
                    DETAIL_URL_BS = UrlString(redirectUrl.Replace("empNo=", "empNo=" + item.AuthUserKey) + URL_BS);
                    DETAIL_URL_BSEX = UrlString(redirectUrl.Replace("empNo=", "empNo=" + item.AuthUserKey) + URL_BSEX);
                    DETAIL_URL_INVEST = UrlString(redirectUrl.Replace("empNo=", "empNo=" + item.AuthUserKey) + URL_INVEST);
                    DETAIL_COMFORM_URL = UrlString(redirectUrl.Replace("empNo=", "empNo=" + item.AuthUserKey) + COMFORM_URL);

                    mailForm = mailForm.Replace("{DETAIL_URL_CASH_FLOW}", DETAIL_URL_CASH_FLOW);
                    mailForm = mailForm.Replace("{DETAIL_URL_PAL}", DETAIL_URL_PAL);
                    mailForm = mailForm.Replace("{DETAIL_URL_QUARTER_PAL}", DETAIL_URL_QUARTER_PAL);
                    mailForm = mailForm.Replace("{DETAIL_URL_BS}", DETAIL_URL_BS);
                    mailForm = mailForm.Replace("{DETAIL_URL_BS_EX}", DETAIL_URL_BSEX);
                    mailForm = mailForm.Replace("{DETAIL_URL_INVEST}", DETAIL_URL_INVEST);
                    mailForm = mailForm.Replace("{COMFORM_URL}", DETAIL_COMFORM_URL);
                    mailForm = mailForm.Replace("{COMFIRM_COMMENT}", COMFORM_COMMENT);
                    mInfo.body = mailForm;
                    //mInfo.body = "[HRPS] " + mInfo.year + "년 " + mInfo.mm + "월 " + mInfo.menuName + " 경영실적 승인요청이 등록되었습니다. 한라 실적 보고 시스템 관리자에서 확인하시기 바랍니다.";

                    SendMail(mInfo);
                }
            }
            else if (mInfo.afterRegistStatus == Define.REGIST_STATUS.GetKey("1차승인") && sendStatus == "ALL")
            {
                // 실적담당자에게 메일 발송
                mInfo.AuthLevel = Define.AUTH_LEVEL.GetKey("실적 담당자");
                List<AdminAuth> adminList = adminAuthRepo.selectListCompany(mInfo).ToList();
                foreach (var item in adminList)
                {
                    mailForm = MailForm(mInfo.afterRegistStatus, "NOTICE");
                    InsaUserV toInfo = insaUserVRepo.selectOneMail(new { userKey = item.AuthUserKey });
                    mInfo.toAddress = toInfo.emailAddress;
                    mInfo.toName = toInfo.userKorName;
                    mInfo.subject = "[HPRS] " + mInfo.year + "년 " + mInfo.mm + "월 경영실적 승인 안내 메일입니다.";

                    mailForm = mailForm.Replace("{URL}", serverUrl).Replace("{YEAR}", mInfo.year).Replace("{MM}", mInfo.mm).Replace("{MENU_NAME}", mInfo.menuName).Replace("{CONTENT}", "1차 승인이 완료되었습니다.").Replace("{COMPANY}", item.CompKorName);

                    // 2019.01.13 결제라인 추가
                    //string hprsUrl = mInfo.ReferUrl.Replace("/Edit", "/View") + ":" + mInfo.Seq + ":" + mInfo.OrgCompanySeq;
                    string hprsUrl = "/SiteMngHome/Performance/Cash_Flow/List";
                    // 개발서버 로그인 테스트용 url변경
                    hprsUrl = UrlString(redirectUrl.Replace("empNo=", "empNo=" + item.AuthUserKey) + hprsUrl);
                    mailForm = mailForm.Replace("{REDIRECT_URL}", hprsUrl);

                    mInfo.body = mailForm;
                    //mInfo.body = "[HRPS] " + mInfo.year + "년 " + mInfo.mm + "월 " + mInfo.menuName + " 경영실적 1차 승인이 완료되었습니다. 한라 실적 보고 시스템 관리자에서 확인하시기 바랍니다.";

                    SendMail(mInfo);
                }
                // 최종관리자에게 메일 발송 : 중간관리자2로 변경
                mInfo.AuthLevel = Define.AUTH_LEVEL.GetKey("중간 관리자2");
                adminList = adminAuthRepo.selectListCompany(mInfo).ToList();

                COMFORM_URL = string.Format("/SiteMngHome/Confirm/RegistSendForm:{0}:{1}:{2}:{3}:{4}:{5}", strTempSeq, mInfo.OrgCompanySeq, mInfo.year, mInfo.mm, 6, 8);
                foreach (var item in adminList)
                {
                    mailForm = MailForm(mInfo.afterRegistStatus, "CONFIRM");
                    InsaUserV toInfo = insaUserVRepo.selectOneMail(new { userKey = item.AuthUserKey });
                    mInfo.toAddress = toInfo.emailAddress;
                    mInfo.toName = toInfo.userKorName;
                    mInfo.subject = "[HPRS] " + mInfo.year + "년 " + mInfo.mm + "월 경영실적 승인 안내 메일입니다.";

                    mailForm = mailForm.Replace("{URL}", serverUrl).Replace("{YEAR}", mInfo.year).Replace("{MM}", mInfo.mm).Replace("{MENU_NAME}", mInfo.menuName).Replace("{CONTENT}", "1차 승인이 완료되었습니다.").Replace("{COMPANY}", item.CompKorName).Replace("{HALLA_EX_DISPLAY}", strDisplay);

                    DETAIL_URL_CASH_FLOW = UrlString(redirectUrl.Replace("empNo=", "empNo=" + item.AuthUserKey) + URL_CASH_FLOW);
                    DETAIL_URL_PAL = UrlString(redirectUrl.Replace("empNo=", "empNo=" + item.AuthUserKey) + URL_PAL);
                    DETAIL_URL_QUARTER_PAL = UrlString(redirectUrl.Replace("empNo=", "empNo=" + item.AuthUserKey) + URL_QUARTER_PAL);
                    DETAIL_URL_BS = UrlString(redirectUrl.Replace("empNo=", "empNo=" + item.AuthUserKey) + URL_BS);
                    DETAIL_URL_BSEX = UrlString(redirectUrl.Replace("empNo=", "empNo=" + item.AuthUserKey) + URL_BSEX);
                    DETAIL_URL_INVEST = UrlString(redirectUrl.Replace("empNo=", "empNo=" + item.AuthUserKey) + URL_INVEST);
                    DETAIL_COMFORM_URL = UrlString(redirectUrl.Replace("empNo=", "empNo=" + item.AuthUserKey) + COMFORM_URL);

                    mailForm = mailForm.Replace("{DETAIL_URL_CASH_FLOW}", DETAIL_URL_CASH_FLOW);
                    mailForm = mailForm.Replace("{DETAIL_URL_PAL}", DETAIL_URL_PAL);
                    mailForm = mailForm.Replace("{DETAIL_URL_QUARTER_PAL}", DETAIL_URL_QUARTER_PAL);
                    mailForm = mailForm.Replace("{DETAIL_URL_BS}", DETAIL_URL_BS);
                    mailForm = mailForm.Replace("{DETAIL_URL_BS_EX}", DETAIL_URL_BSEX);
                    mailForm = mailForm.Replace("{DETAIL_URL_INVEST}", DETAIL_URL_INVEST);
                    mailForm = mailForm.Replace("{COMFORM_URL}", DETAIL_COMFORM_URL);
                    mailForm = mailForm.Replace("{COMFIRM_COMMENT}", COMFORM_COMMENT);
                    mInfo.body = mailForm;
                    //mInfo.body = "[HRPS] " + mInfo.year + "년 " + mInfo.mm + "월 " + mInfo.menuName + " 경영실적 1차 승인이 완료되었습니다. 한라 실적 보고 시스템 관리자에서 확인하시기 바랍니다.";

                    SendMail(mInfo);
                }


            }
            else if (mInfo.afterRegistStatus == Define.REGIST_STATUS.GetKey("1차반려"))
            {
                // 실적담당자에게 메일 발송
                mInfo.AuthLevel = Define.AUTH_LEVEL.GetKey("실적 담당자");
                List<AdminAuth> adminList = adminAuthRepo.selectListCompany(mInfo).ToList();
                foreach (var item in adminList)
                {
                    mailForm = MailForm(mInfo.afterRegistStatus, "REJECT");
                    InsaUserV toInfo = insaUserVRepo.selectOneMail(new { userKey = item.AuthUserKey });
                    mInfo.toAddress = toInfo.emailAddress;
                    mInfo.toName = toInfo.userKorName;
                    mInfo.subject = "[HPRS] " + mInfo.year + "년 " + mInfo.mm + "월 경영실적 승인이 반려되었습니다.";

                    mailForm = mailForm.Replace("{URL}", serverUrl).Replace("{YEAR}", mInfo.year).Replace("{MM}", mInfo.mm).Replace("{MENU_NAME}", mInfo.menuName).Replace("{CONTENT}", "1차 승인이 반려되었습니다.").Replace("{COMPANY}", item.CompKorName);
                    mailForm = mailForm.Replace("{USER_INFO}", mInfo.UserInfo).Replace("{REJECT_RESON}", mInfo.RejectReson.Replace("\r\n", "<br />"));

                    // 2019.01.13 결제라인 추가
                    string hprsUrl = mInfo.ReferUrl.Replace("/Edit2", "/Edit").Replace("/Edit", "/Edit") + ":" + mInfo.Seq + ":" + mInfo.OrgCompanySeq;
                    //string hprsUrl = "";
                    // 개발서버 로그인 테스트용 url변경
                    hprsUrl = UrlString(redirectUrl.Replace("empNo=", "empNo=" + item.AuthUserKey) + hprsUrl);
                    mailForm = mailForm.Replace("{REDIRECT_URL}", hprsUrl);

                    mInfo.body = mailForm;
                    //mInfo.body = "[HRPS] " + mInfo.year + "년 " + mInfo.mm + "월 " + mInfo.menuName + " 경영실적 1차 승인이 반려되었습니다. 한라 실적 보고 시스템 관리자에서 확인하시기 바랍니다.";

                    SendMail(mInfo);
                }
            }
            else if (mInfo.afterRegistStatus == Define.REGIST_STATUS.GetKey("2차승인") && sendStatus == "ALL")
            {
                // 실적담당자에게 메일 발송
                mInfo.AuthLevel = Define.AUTH_LEVEL.GetKey("실적 담당자");
                List<AdminAuth> adminList = adminAuthRepo.selectListCompany(mInfo).ToList();

                foreach (var item in adminList)
                {
                    mailForm = MailForm(mInfo.afterRegistStatus, "NOTICE");
                    InsaUserV toInfo = insaUserVRepo.selectOneMail(new { userKey = item.AuthUserKey });
                    mInfo.toAddress = toInfo.emailAddress;
                    mInfo.toName = toInfo.userKorName;
                    mInfo.subject = "[HPRS] " + mInfo.year + "년 " + mInfo.mm + "월 경영실적 승인 안내 메일입니다.";

                    mailForm = mailForm.Replace("{URL}", serverUrl).Replace("{YEAR}", mInfo.year).Replace("{MM}", mInfo.mm).Replace("{MENU_NAME}", mInfo.menuName).Replace("{CONTENT}", "2차 승인이 완료되었습니다.").Replace("{COMPANY}", item.CompKorName);

                    // 2019.01.13 결제라인 추가
                    //string hprsUrl = mInfo.ReferUrl.Replace("/Edit2", "/View").Replace("/Edit", "/View") + ":" + mInfo.Seq + ":" + mInfo.OrgCompanySeq;
                    string hprsUrl = "/SiteMngHome/Performance/Cash_Flow/List";
                    // 개발서버 로그인 테스트용 url변경
                    hprsUrl = UrlString(redirectUrl.Replace("empNo=", "empNo=" + item.AuthUserKey) + hprsUrl);
                    mailForm = mailForm.Replace("{REDIRECT_URL}", hprsUrl);

                    mInfo.body = mailForm;
                    //mInfo.body = "[HRPS] " + mInfo.year + "년 " + mInfo.mm + "월 " + mInfo.menuName + " 경영실적 1차 승인이 완료되었습니다. 한라 실적 보고 시스템 관리자에서 확인하시기 바랍니다.";

                    SendMail(mInfo);
                }
                // 중간담당자
                mInfo.AuthLevel = Define.AUTH_LEVEL.GetKey("중간 관리자");
                adminList = adminAuthRepo.selectListCompany(mInfo).ToList();
                foreach (var item in adminList)
                {
                    mailForm = MailForm(mInfo.afterRegistStatus, "NOTICE");
                    InsaUserV toInfo = insaUserVRepo.selectOneMail(new { userKey = item.AuthUserKey });
                    mInfo.toAddress = toInfo.emailAddress;
                    mInfo.toName = toInfo.userKorName;
                    mInfo.subject = "[HPRS] " + mInfo.year + "년 " + mInfo.mm + "월 경영실적 승인 안내 메일입니다.";

                    mailForm = mailForm.Replace("{URL}", serverUrl).Replace("{YEAR}", mInfo.year).Replace("{MM}", mInfo.mm).Replace("{MENU_NAME}", mInfo.menuName).Replace("{CONTENT}", "2차 승인이 완료되었습니다.").Replace("{COMPANY}", item.CompKorName);

                    // 2019.01.13 결제라인 추가
                    //string hprsUrl = mInfo.ReferUrl.Replace("/Edit2", "/View").Replace("/Edit", "/View") + ":" + mInfo.Seq + ":" + mInfo.OrgCompanySeq;
                    string hprsUrl = "/SiteMngHome/Performance/Cash_Flow/List";
                    // 개발서버 로그인 테스트용 url변경
                    hprsUrl = UrlString(redirectUrl.Replace("empNo=", "empNo=" + item.AuthUserKey) + hprsUrl);
                    mailForm = mailForm.Replace("{REDIRECT_URL}", hprsUrl);

                    mInfo.body = mailForm;
                    //mInfo.body = "[HRPS] " + mInfo.year + "년 " + mInfo.mm + "월 " + mInfo.menuName + " 경영실적 1차 승인이 완료되었습니다. 한라 실적 보고 시스템 관리자에서 확인하시기 바랍니다.";

                    SendMail(mInfo);
                }
                // 최종관리자에게 메일 발송
                mInfo.AuthLevel = Define.AUTH_LEVEL.GetKey("최종 관리자");
                adminList = adminAuthRepo.selectListCompany(mInfo).ToList();
                COMFORM_URL = string.Format("/SiteMngHome/Confirm/RegistSendForm:{0}:{1}:{2}:{3}:{4}:{5}", strTempSeq, mInfo.OrgCompanySeq, mInfo.year, mInfo.mm, 8, 7);
                foreach (var item in adminList)
                {
                    mailForm = MailForm(mInfo.afterRegistStatus, "CONFIRM");
                    InsaUserV toInfo = insaUserVRepo.selectOneMail(new { userKey = item.AuthUserKey });
                    mInfo.toAddress = toInfo.emailAddress;
                    mInfo.toName = toInfo.userKorName;
                    mInfo.subject = "[HPRS] " + mInfo.year + "년 " + mInfo.mm + "월 경영실적 승인 안내 메일입니다.";

                    mailForm = mailForm.Replace("{URL}", serverUrl).Replace("{YEAR}", mInfo.year).Replace("{MM}", mInfo.mm).Replace("{MENU_NAME}", mInfo.menuName).Replace("{CONTENT}", "2차 승인이 완료되었습니다.").Replace("{COMPANY}", item.CompKorName).Replace("{HALLA_EX_DISPLAY}", strDisplay);

                    DETAIL_URL_CASH_FLOW = UrlString(redirectUrl.Replace("empNo=", "empNo=" + item.AuthUserKey) + URL_CASH_FLOW);
                    DETAIL_URL_PAL = UrlString(redirectUrl.Replace("empNo=", "empNo=" + item.AuthUserKey) + URL_PAL);
                    DETAIL_URL_QUARTER_PAL = UrlString(redirectUrl.Replace("empNo=", "empNo=" + item.AuthUserKey) + URL_QUARTER_PAL);
                    DETAIL_URL_BS = UrlString(redirectUrl.Replace("empNo=", "empNo=" + item.AuthUserKey) + URL_BS);
                    DETAIL_URL_BSEX = UrlString(redirectUrl.Replace("empNo=", "empNo=" + item.AuthUserKey) + URL_BSEX);
                    DETAIL_URL_INVEST = UrlString(redirectUrl.Replace("empNo=", "empNo=" + item.AuthUserKey) + URL_INVEST);
                    DETAIL_COMFORM_URL = UrlString(redirectUrl.Replace("empNo=", "empNo=" + item.AuthUserKey) + COMFORM_URL);

                    mailForm = mailForm.Replace("{DETAIL_URL_CASH_FLOW}", DETAIL_URL_CASH_FLOW);
                    mailForm = mailForm.Replace("{DETAIL_URL_PAL}", DETAIL_URL_PAL);
                    mailForm = mailForm.Replace("{DETAIL_URL_QUARTER_PAL}", DETAIL_URL_QUARTER_PAL);
                    mailForm = mailForm.Replace("{DETAIL_URL_BS}", DETAIL_URL_BS);
                    mailForm = mailForm.Replace("{DETAIL_URL_BS_EX}", DETAIL_URL_BSEX);
                    mailForm = mailForm.Replace("{DETAIL_URL_INVEST}", DETAIL_URL_INVEST);
                    mailForm = mailForm.Replace("{COMFORM_URL}", DETAIL_COMFORM_URL);
                    mailForm = mailForm.Replace("{COMFIRM_COMMENT}", COMFORM_COMMENT);
                    mInfo.body = mailForm;
                    SendMail(mInfo);
                }
            }
            else if (mInfo.afterRegistStatus == Define.REGIST_STATUS.GetKey("2차반려"))
            {
                // 실적담당자에게 메일 발송
                mInfo.AuthLevel = Define.AUTH_LEVEL.GetKey("실적 담당자");
                List<AdminAuth> adminList = adminAuthRepo.selectListCompany(mInfo).ToList();
                foreach (var item in adminList)
                {
                    mailForm = MailForm(mInfo.afterRegistStatus, "REJECT");
                    InsaUserV toInfo = insaUserVRepo.selectOneMail(new { userKey = item.AuthUserKey });
                    mInfo.toAddress = toInfo.emailAddress;
                    mInfo.toName = toInfo.userKorName;
                    mInfo.subject = "[HPRS] " + mInfo.year + "년 " + mInfo.mm + "월 경영실적 승인이 반려되었습니다.";

                    mailForm = mailForm.Replace("{URL}", serverUrl).Replace("{YEAR}", mInfo.year).Replace("{MM}", mInfo.mm).Replace("{MENU_NAME}", mInfo.menuName).Replace("{CONTENT}", "2차승인이 반려되었습니다.").Replace("{COMPANY}", item.CompKorName);
                    mailForm = mailForm.Replace("{USER_INFO}", mInfo.UserInfo).Replace("{REJECT_RESON}", mInfo.RejectReson.Replace("\r\n", "<br />"));

                    // 2019.01.13 결제라인 추가
                    string hprsUrl = mInfo.ReferUrl.Replace("/Edit2", "/Edit").Replace("/Edit", "/Edit") + ":" + mInfo.Seq + ":" + mInfo.OrgCompanySeq;
                    //string hprsUrl = "";
                    // 개발서버 로그인 테스트용 url변경
                    hprsUrl = UrlString(redirectUrl.Replace("empNo=", "empNo=" + item.AuthUserKey) + hprsUrl);
                    mailForm = mailForm.Replace("{REDIRECT_URL}", hprsUrl);

                    mInfo.body = mailForm;
                    //mInfo.body = "[HRPS] " + mInfo.year + "년 " + mInfo.mm + "월 " + mInfo.menuName + " 경영실적 최종승인이 반려되었습니다. 한라 실적 보고 시스템 관리자에서 확인하시기 바랍니다.";

                    SendMail(mInfo);
                }
                // 최종관리자에게 메일 발송
                mInfo.AuthLevel = Define.AUTH_LEVEL.GetKey("중간 관리자");
                adminList = adminAuthRepo.selectListCompany(mInfo).ToList();
                foreach (var item in adminList)
                {
                    mailForm = MailForm(mInfo.afterRegistStatus, "REJECT");
                    InsaUserV toInfo = insaUserVRepo.selectOneMail(new { userKey = item.AuthUserKey });
                    mInfo.toAddress = toInfo.emailAddress;
                    mInfo.toName = toInfo.userKorName;
                    mInfo.subject = "[HPRS] " + mInfo.year + "년 " + mInfo.mm + "월 경영실적 승인이 반려되었습니다.";

                    mailForm = mailForm.Replace("{URL}", serverUrl).Replace("{YEAR}", mInfo.year).Replace("{MM}", mInfo.mm).Replace("{MENU_NAME}", mInfo.menuName).Replace("{CONTENT}", "2차승인이 반려되었습니다.").Replace("{COMPANY}", item.CompKorName);
                    mailForm = mailForm.Replace("{USER_INFO}", mInfo.UserInfo).Replace("{REJECT_RESON}", mInfo.RejectReson.Replace("\r\n", "<br />"));

                    // 2019.01.13 결제라인 추가
                    string hprsUrl = mInfo.ReferUrl.Replace("/Edit2", "/Edit").Replace("/Edit", "/Edit") + ":" + mInfo.Seq + ":" + mInfo.OrgCompanySeq;
                    //string hprsUrl = "";
                    // 개발서버 로그인 테스트용 url변경
                    hprsUrl = UrlString(redirectUrl.Replace("empNo=", "empNo=" + item.AuthUserKey) + hprsUrl);
                    mailForm = mailForm.Replace("{REDIRECT_URL}", hprsUrl);

                    mInfo.body = mailForm;
                    //mInfo.body = "[HRPS] " + mInfo.year + "년 " + mInfo.mm + "월 " + mInfo.menuName + " 경영실적 최종승인이 반려되었습니다. 한라 실적 보고 시스템 관리자에서 확인하시기 바랍니다.";

                    SendMail(mInfo);
                }
            }
            else if (mInfo.afterRegistStatus == Define.REGIST_STATUS.GetKey("3차반려"))
            {
                // 실적담당자에게 메일 발송
                mInfo.AuthLevel = Define.AUTH_LEVEL.GetKey("실적 담당자");
                List<AdminAuth> adminList = adminAuthRepo.selectListCompany(mInfo).ToList();
                foreach (var item in adminList)
                {
                    mailForm = MailForm(mInfo.afterRegistStatus, "REJECT");
                    InsaUserV toInfo = insaUserVRepo.selectOneMail(new { userKey = item.AuthUserKey });
                    mInfo.toAddress = toInfo.emailAddress;
                    mInfo.toName = toInfo.userKorName;
                    mInfo.subject = "[HPRS] " + mInfo.year + "년 " + mInfo.mm + "월 경영실적 승인이 반려되었습니다.";

                    mailForm = mailForm.Replace("{URL}", serverUrl).Replace("{YEAR}", mInfo.year).Replace("{MM}", mInfo.mm).Replace("{MENU_NAME}", mInfo.menuName).Replace("{CONTENT}", "최종승인이 반려되었습니다.").Replace("{COMPANY}", item.CompKorName);
                    mailForm = mailForm.Replace("{USER_INFO}", mInfo.UserInfo).Replace("{REJECT_RESON}", mInfo.RejectReson.Replace("\r\n", "<br />"));

                    // 2019.01.13 결제라인 추가
                    string hprsUrl = mInfo.ReferUrl.Replace("/Edit2", "/Edit").Replace("/Edit", "/Edit") + ":" + mInfo.Seq + ":" + mInfo.OrgCompanySeq;
                    //string hprsUrl = "";
                    // 개발서버 로그인 테스트용 url변경
                    hprsUrl = UrlString(redirectUrl.Replace("empNo=", "empNo=" + item.AuthUserKey) + hprsUrl);
                    mailForm = mailForm.Replace("{REDIRECT_URL}", hprsUrl);

                    mInfo.body = mailForm;
                    //mInfo.body = "[HRPS] " + mInfo.year + "년 " + mInfo.mm + "월 " + mInfo.menuName + " 경영실적 최종승인이 반려되었습니다. 한라 실적 보고 시스템 관리자에서 확인하시기 바랍니다.";

                    SendMail(mInfo);
                }
                // 최종관리자에게 메일 발송
                mInfo.AuthLevel = Define.AUTH_LEVEL.GetKey("중간 관리자");
                adminList = adminAuthRepo.selectListCompany(mInfo).ToList();
                foreach (var item in adminList)
                {
                    mailForm = MailForm(mInfo.afterRegistStatus, "REJECT");
                    InsaUserV toInfo = insaUserVRepo.selectOneMail(new { userKey = item.AuthUserKey });
                    mInfo.toAddress = toInfo.emailAddress;
                    mInfo.toName = toInfo.userKorName;
                    mInfo.subject = "[HPRS] " + mInfo.year + "년 " + mInfo.mm + "월 경영실적 승인이 반려되었습니다.";

                    mailForm = mailForm.Replace("{URL}", serverUrl).Replace("{YEAR}", mInfo.year).Replace("{MM}", mInfo.mm).Replace("{MENU_NAME}", mInfo.menuName).Replace("{CONTENT}", "최종승인이 반려되었습니다.").Replace("{COMPANY}", item.CompKorName);
                    mailForm = mailForm.Replace("{USER_INFO}", mInfo.UserInfo).Replace("{REJECT_RESON}", mInfo.RejectReson.Replace("\r\n", "<br />"));

                    // 2019.01.13 결제라인 추가
                    string hprsUrl = mInfo.ReferUrl.Replace("/Edit2", "/Edit").Replace("/Edit", "/Edit") + ":" + mInfo.Seq + ":" + mInfo.OrgCompanySeq;
                    //string hprsUrl = "";
                    // 개발서버 로그인 테스트용 url변경
                    hprsUrl = UrlString(redirectUrl.Replace("empNo=", "empNo=" + item.AuthUserKey) + hprsUrl);
                    mailForm = mailForm.Replace("{REDIRECT_URL}", hprsUrl);

                    mInfo.body = mailForm;
                    //mInfo.body = "[HRPS] " + mInfo.year + "년 " + mInfo.mm + "월 " + mInfo.menuName + " 경영실적 최종승인이 반려되었습니다. 한라 실적 보고 시스템 관리자에서 확인하시기 바랍니다.";

                    SendMail(mInfo);
                }
                // 최종관리자에게 메일 발송
                mInfo.AuthLevel = Define.AUTH_LEVEL.GetKey("중간 관리자2");
                adminList = adminAuthRepo.selectListCompany(mInfo).ToList();
                foreach (var item in adminList)
                {
                    mailForm = MailForm(mInfo.afterRegistStatus, "REJECT");
                    InsaUserV toInfo = insaUserVRepo.selectOneMail(new { userKey = item.AuthUserKey });
                    mInfo.toAddress = toInfo.emailAddress;
                    mInfo.toName = toInfo.userKorName;
                    mInfo.subject = "[HPRS] " + mInfo.year + "년 " + mInfo.mm + "월 경영실적 승인이 반려되었습니다.";

                    mailForm = mailForm.Replace("{URL}", serverUrl).Replace("{YEAR}", mInfo.year).Replace("{MM}", mInfo.mm).Replace("{MENU_NAME}", mInfo.menuName).Replace("{CONTENT}", "최종승인이 반려되었습니다.").Replace("{COMPANY}", item.CompKorName);
                    mailForm = mailForm.Replace("{USER_INFO}", mInfo.UserInfo).Replace("{REJECT_RESON}", mInfo.RejectReson.Replace("\r\n", "<br />"));

                    // 2019.01.13 결제라인 추가
                    string hprsUrl = mInfo.ReferUrl.Replace("/Edit", "/Edit2") + ":" + mInfo.Seq + ":" + mInfo.OrgCompanySeq;
                    //string hprsUrl = "";
                    // 개발서버 로그인 테스트용 url변경
                    hprsUrl = UrlString(redirectUrl.Replace("empNo=", "empNo=" + item.AuthUserKey) + hprsUrl);
                    mailForm = mailForm.Replace("{REDIRECT_URL}", hprsUrl);

                    mInfo.body = mailForm;
                    //mInfo.body = "[HRPS] " + mInfo.year + "년 " + mInfo.mm + "월 " + mInfo.menuName + " 경영실적 최종승인이 반려되었습니다. 한라 실적 보고 시스템 관리자에서 확인하시기 바랍니다.";

                    SendMail(mInfo);
                }
            }
            else if (mInfo.afterRegistStatus == Define.REGIST_STATUS.GetKey("최종승인") && sendStatus == "ALL")
            {
                LogUtil.MngError("최종승인:"  + "  호출자:MailUtilNew.cs");
                AllComfirmMaillSender(mInfo);
            }
       }

        private static string MailForm(int registStatus,string strMailType)
        {
            string mailForm = "";
            if (strMailType =="CONFIRM")
                 mailForm = File.ReadAllText(HttpContext.Current.Server.MapPath("~/Contents/SiteMngHome/Mail/AllConfirmMail.html"));
            else if (strMailType == "NOTICE")
                mailForm = File.ReadAllText(HttpContext.Current.Server.MapPath("~/Contents/SiteMngHome/Mail/Mail.html"));
            else if (registStatus == Define.REGIST_STATUS.GetKey("1차반려") || registStatus == Define.REGIST_STATUS.GetKey("2차반려") || registStatus == Define.REGIST_STATUS.GetKey("3차반려"))
            {
                mailForm = File.ReadAllText(HttpContext.Current.Server.MapPath("~/Contents/SiteMngHome/Mail/mail2.html"));
            }

            return mailForm;
        }

        private static string UrlString(string str)
        {
            string UrlString = "";
            //if (HttpContext.Current.Request.Url.Host.Contains("localhost") || HttpContext.Current.Request.Url.Host.Contains("midashelp") || HttpContext.Current.Request.Url.Host.Contains("test")  HttpContext.Current.Request.Url.Host.Contains("hprstest"))
             if (HttpContext.Current.Request.Url.Host.Contains("test")  || HttpContext.Current.Request.Url.Host.Contains("midashelp") ||   HttpContext.Current.Request.Url.Host.Contains("hprstest"))
          {
                string serverUrl = "http://" + HttpContext.Current.Request.Url.Host;
                string a = str.Substring(str.IndexOf("&HPRSURL=") + 9);
                string b = str.Substring(0, str.IndexOf("&HPRSURL=") + 9);
                UrlString = serverUrl + b + HttpContext.Current.Server.UrlEncode(a);
            }
            else
            {
                UrlString = "https://ep.halla.com/?rtn=" + HttpContext.Current.Server.UrlEncode(str);
            }
            return UrlString;
        }
        public static void AllComfirmMaillSender(MailInfo mInfo)
        {

            
            PmConfirmViewRepo pmconfirmViewRepo = new PmConfirmViewRepo();
            List<PmConfirmView> pmconfirmViewList;
            mInfo.objPmSeq = new Dictionary<string, int>();
            PmConfirmStateViewRepo pmconfirmStateViewRepo = new PmConfirmStateViewRepo();
            PmConfirmStateView pmconfirmStateView = pmconfirmStateViewRepo.selectOne(new { searchCpySeq = mInfo.OrgCompanySeq
                                                                                           ,searchYear = mInfo.year
                                                                                           ,searchMonth = mInfo.mm});

            pmconfirmViewList = pmconfirmViewRepo.selectSeqList(new {orgCompanySeq = mInfo.OrgCompanySeq
                                                               , planYear = mInfo.year
                                                               , monthly = mInfo.mm
                                                               , registStatus = mInfo.afterRegistStatus });
            foreach (var obj in pmconfirmViewList)
            {
                mInfo.objPmSeq.Add(obj.busType,obj.seq);
            }

            if (mInfo.afterRegistStatus == Define.REGIST_STATUS.GetKey("승인대기") && (pmconfirmStateView != null && pmconfirmStateView.readyFirstConfirm == "TRUE"))
            {
                MailUtilNew.RegistStatusMail(mInfo,"ALL");
            }
            else if (mInfo.afterRegistStatus == Define.REGIST_STATUS.GetKey("1차승인") && (pmconfirmStateView != null && pmconfirmStateView.readySecondConfirm == "TRUE"))
            {
                MailUtilNew.RegistStatusMail(mInfo, "ALL");
            }
            else if (mInfo.afterRegistStatus == Define.REGIST_STATUS.GetKey("2차승인") && (pmconfirmStateView != null && pmconfirmStateView.readyLastConfirm == "TRUE"))
            {
                MailUtilNew.RegistStatusMail(mInfo, "ALL");
            }
            else if (mInfo.afterRegistStatus == Define.REGIST_STATUS.GetKey("최종승인") && (pmconfirmStateView != null && pmconfirmStateView.finalConfirm == "TRUE"))
            {
                ///* 푸시 메세지 전송*/
                RegistYearListRepo rYearListRepo = new RegistYearListRepo();
                List<RegistYearList> registYearPm = rYearListRepo.selectListPm(new { }).ToList();
                InsaUserVRepo insaUserVRepo = new InsaUserVRepo();
                string year = mInfo.year;
                string month = mInfo.mm;

                var checkRegist = registYearPm.Where(w => w.RegistYear == year && w.RegistMonth == month).ToList();
                if ((checkRegist != null && checkRegist.Count() > 0) && !(HttpContext.Current.Request.Url.Host.Contains("localhost") || HttpContext.Current.Request.Url.Host.Contains("midashelp") || HttpContext.Current.Request.Url.Host.Contains("test") || HttpContext.Current.Request.Url.Host.Contains("hprstest") || HttpContext.Current.Request.Url.Host.Contains("115.88.138.221") || HttpContext.Current.Request.Url.Host.Contains("192.168.0.63")))
                {
                    // 인사디비에서 권한 사용자 가져온다.
                    var users = insaUserVRepo.selectListAuth().ToList();

                    PushMaster pushMaster = new PushMaster();
                    pushMaster.Type = 1;
                    pushMaster.Title = "-";
                    pushMaster.Contents = year + "년 " + month + "월 실적등록이 승인되었습니다.";
                    pushMaster.Link = "";

                    ApiController api = new ApiController();

                    List<string> result = api.SendPushServer(pushMaster, users);
                    if (result[0].ToUpper() == "FALSE")
                    {
                        LogUtil.MngError(result[2].ToString() + "[" + year + "." + month + ": pushsender");
                    }
                    
                }
                else
                {
                    LogUtil.MngError(" Api.SendPushServer:--1" + year + "년 " + month + "월 실적등록이 승인되었습니다.테스트서버일경우"  + " 호출자:MailUtilNew.cs" );
                }
                 
            }
            else
            {
                //MailUtil.RegistStatusMailNew(mInfo);
                MailUtilNew.RegistStatusMail(mInfo, "ONE");
            }
        } 
    }
    
} 