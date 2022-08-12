using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using HALLA_PM.Models;
using System.Net.Mail;
using HALLA_PM.Core;
using System.IO;

namespace HALLA_PM.Util
{
    public class MailUtil
    {
        public static bool SendMail(MailInfo mInfo)
        {
            bool success = true;
            //string smtpServer = "mail.halla.com";
            string smtpServer = "localhost";
            //int smtpPort = 25;
            int smtpPort = 9898;

            SmtpClient sClient = new SmtpClient(smtpServer, smtpPort);
            sClient.UseDefaultCredentials = true;
            //sClient.EnableSsl = true;
            sClient.DeliveryMethod = SmtpDeliveryMethod.Network;

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

        public static void RegistStatusMail(MailInfo mInfo)
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
            string mailForm = File.ReadAllText(HttpContext.Current.Server.MapPath("~/Contents/SiteMngHome/Mail/AllConfirmMain.html"));
            // 2019.01.03 반려는 다른 메일 폼 불러온다.
            if (mInfo.afterRegistStatus == Define.REGIST_STATUS.GetKey("1차반려") || mInfo.afterRegistStatus == Define.REGIST_STATUS.GetKey("2차반려") || mInfo.afterRegistStatus == Define.REGIST_STATUS.GetKey("3차반려"))
            {
                mailForm = File.ReadAllText(HttpContext.Current.Server.MapPath("~/Contents/SiteMngHome/Mail/mail2.html"));
            }


            string redirectUrl = ""; 
            if (HttpContext.Current.Request.Url.Host.Contains("localhost") || HttpContext.Current.Request.Url.Host.Contains("midashelp") || HttpContext.Current.Request.Url.Host.Contains("test"))
            {
                redirectUrl = "/Home/ssoLogingTest?empNo=" + "&HPRSURL=";
            }
            else
            {
                redirectUrl = "/Portal/Gadget/SignOnMando?SsoId=HALLA.HEIS&HPRSURL=";
            }

            if (mInfo.afterRegistStatus == Define.REGIST_STATUS.GetKey("승인대기")) //승인요청이면
            {
                // 중간관리자에게 메일 발송
                // 중간관리자 리스트 가져오기
                //해당회사,년,월 실적정보상태가 승인대기가 총 6개 이면 
                // 통합승인메일을 발송한다.
                mInfo.AuthLevel = Define.AUTH_LEVEL.GetKey("중간 관리자");
                List<AdminAuth> adminList = adminAuthRepo.selectListCompany(mInfo).ToList();
                foreach (var item in adminList)
                {
                    mailForm = MailForm(mInfo.afterRegistStatus);
                    InsaUserV toInfo = insaUserVRepo.selectOneMail(new { userKey = item.AuthUserKey });
                    mInfo.toAddress = toInfo.emailAddress;
                    mInfo.toName = toInfo.userKorName;
                    mInfo.subject = "[HPRS] " + mInfo.year + "년 " + mInfo.mm + "월 경영실적 승인 안내 메일입니다.";

                    mailForm = mailForm.Replace("{URL}", serverUrl).Replace("{YEAR}", mInfo.year).Replace("{MM}", mInfo.mm).Replace("{MENU_NAME}", mInfo.menuName).Replace("{CONTENT}", "승인요청이 등록되었습니다.").Replace("{COMPANY}", item.CompKorName);

                    // 2019.01.13 결제라인 추가
                    string hprsUrl = mInfo.ReferUrl + ":" + mInfo.Seq + ":" + mInfo.OrgCompanySeq;
                    // 개발서버 로그인 테스트용 url변경
                    hprsUrl = UrlString(redirectUrl.Replace("empNo=", "empNo=" + item.AuthUserKey) + hprsUrl);
                    mailForm = mailForm.Replace("{REDIRECT_URL}", hprsUrl);
                    mInfo.body = mailForm;
                    //mInfo.body = "[HRPS] " + mInfo.year + "년 " + mInfo.mm + "월 " + mInfo.menuName + " 경영실적 승인요청이 등록되었습니다. 한라 실적 보고 시스템 관리자에서 확인하시기 바랍니다.";

                    SendMail(mInfo);
                }
            }
            else if (mInfo.afterRegistStatus == Define.REGIST_STATUS.GetKey("1차승인"))
            {
                // 실적담당자에게 메일 발송
                mInfo.AuthLevel = Define.AUTH_LEVEL.GetKey("실적 담당자");
                List<AdminAuth> adminList = adminAuthRepo.selectListCompany(mInfo).ToList();
                foreach (var item in adminList)
                {
                    mailForm = MailForm(mInfo.afterRegistStatus);
                    InsaUserV toInfo = insaUserVRepo.selectOneMail(new { userKey = item.AuthUserKey });
                    mInfo.toAddress = toInfo.emailAddress;
                    mInfo.toName = toInfo.userKorName;
                    mInfo.subject = "[HPRS] " + mInfo.year + "년 " + mInfo.mm + "월 경영실적 승인 안내 메일입니다.";

                    mailForm = mailForm.Replace("{URL}", serverUrl).Replace("{YEAR}", mInfo.year).Replace("{MM}", mInfo.mm).Replace("{MENU_NAME}", mInfo.menuName).Replace("{CONTENT}", "1차 승인이 완료되었습니다.").Replace("{COMPANY}", item.CompKorName);

                    // 2019.01.13 결제라인 추가
                    string hprsUrl = mInfo.ReferUrl.Replace("/Edit", "/View") + ":" + mInfo.Seq + ":" + mInfo.OrgCompanySeq;
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
                foreach (var item in adminList)
                {
                    mailForm = MailForm(mInfo.afterRegistStatus);
                    InsaUserV toInfo = insaUserVRepo.selectOneMail(new { userKey = item.AuthUserKey });
                    mInfo.toAddress = toInfo.emailAddress;
                    mInfo.toName = toInfo.userKorName;
                    mInfo.subject = "[HPRS] " + mInfo.year + "년 " + mInfo.mm + "월 경영실적 승인 안내 메일입니다.";

                    mailForm = mailForm.Replace("{URL}", serverUrl).Replace("{YEAR}", mInfo.year).Replace("{MM}", mInfo.mm).Replace("{MENU_NAME}", mInfo.menuName).Replace("{CONTENT}", "1차 승인이 완료되었습니다.").Replace("{COMPANY}", item.CompKorName);

                    // 2019.01.13 결제라인 추가
                    string hprsUrl = mInfo.ReferUrl.Replace("/Edit", "/Edit") + ":" + mInfo.Seq + ":" + mInfo.OrgCompanySeq;
                    // 개발서버 로그인 테스트용 url변경
                    hprsUrl = UrlString(redirectUrl.Replace("empNo=", "empNo=" + item.AuthUserKey) + hprsUrl);
                    mailForm = mailForm.Replace("{REDIRECT_URL}", hprsUrl);

                    mInfo.body = mailForm;
                    //mInfo.body = "[HRPS] " + mInfo.year + "년 " + mInfo.mm + "월 " + mInfo.menuName + " 경영실적 1차 승인이 완료되었습니다. 한라 실적 보고 시스템 관리자에서 확인하시기 바랍니다.";

                    SendMail(mInfo);
                }

                //// 최종관리자에게 메일 발송
                //mInfo.AuthLevel = Define.AUTH_LEVEL.GetKey("최종 관리자");
                //adminList = adminAuthRepo.selectListCompany(mInfo).ToList();
                //foreach (var item in adminList)
                //{
                //    mailForm = MailForm(mInfo.afterRegistStatus);
                //    InsaUserV toInfo = insaUserVRepo.selectOneMail(new { userKey = item.AuthUserKey });
                //    mInfo.toAddress = toInfo.emailAddress;
                //    mInfo.toName = toInfo.userKorName;
                //    mInfo.subject = "[HPRS] " + mInfo.year + "년 " + mInfo.mm + "월 경영실적 승인 안내 메일입니다.";

                //    mailForm = mailForm.Replace("{URL}", serverUrl).Replace("{YEAR}", mInfo.year).Replace("{MM}", mInfo.mm).Replace("{MENU_NAME}", mInfo.menuName).Replace("{CONTENT}", "1차 승인이 완료되었습니다.").Replace("{COMPANY}", item.CompKorName);

                //    // 2019.01.13 결제라인 추가
                //    string hprsUrl = mInfo.ReferUrl.Replace("/Edit", "/Edit") + ":" + mInfo.Seq + ":" + mInfo.OrgCompanySeq;
                //    // 개발서버 로그인 테스트용 url변경
                //    hprsUrl = redirectUrl.Replace("empNo=", "empNo=" + item.AuthUserKey) + hprsUrl;
                //    mailForm = mailForm.Replace("{REDIRECT_URL}", hprsUrl);

                //    mInfo.body = mailForm;
                //    //mInfo.body = "[HRPS] " + mInfo.year + "년 " + mInfo.mm + "월 " + mInfo.menuName + " 경영실적 1차 승인이 완료되었습니다. 한라 실적 보고 시스템 관리자에서 확인하시기 바랍니다.";

                //    SendMail(mInfo);
                //}
            }
            else if (mInfo.afterRegistStatus == Define.REGIST_STATUS.GetKey("1차반려"))
            {
                // 실적담당자에게 메일 발송
                mInfo.AuthLevel = Define.AUTH_LEVEL.GetKey("실적 담당자");
                List<AdminAuth> adminList = adminAuthRepo.selectListCompany(mInfo).ToList();
                foreach (var item in adminList)
                {
                    mailForm = MailForm(mInfo.afterRegistStatus);
                    InsaUserV toInfo = insaUserVRepo.selectOneMail(new { userKey = item.AuthUserKey });
                    mInfo.toAddress = toInfo.emailAddress;
                    mInfo.toName = toInfo.userKorName;
                    mInfo.subject = "[HPRS] " + mInfo.year + "년 " + mInfo.mm + "월 경영실적 승인이 반려되었습니다.";

                    mailForm = mailForm.Replace("{URL}", serverUrl).Replace("{YEAR}", mInfo.year).Replace("{MM}", mInfo.mm).Replace("{MENU_NAME}", mInfo.menuName).Replace("{CONTENT}", "1차 승인이 반려되었습니다.").Replace("{COMPANY}", item.CompKorName);
                    mailForm = mailForm.Replace("{USER_INFO}", mInfo.UserInfo).Replace("{REJECT_RESON}", mInfo.RejectReson.Replace("\r\n", "<br />"));

                    // 2019.01.13 결제라인 추가
                    string hprsUrl = mInfo.ReferUrl.Replace("/Edit2", "/Edit").Replace("/Edit", "/Edit") + ":" + mInfo.Seq + ":" + mInfo.OrgCompanySeq;
                    // 개발서버 로그인 테스트용 url변경
                    hprsUrl = UrlString(redirectUrl.Replace("empNo=", "empNo=" + item.AuthUserKey) + hprsUrl);
                    mailForm = mailForm.Replace("{REDIRECT_URL}", hprsUrl);

                    mInfo.body = mailForm;
                    //mInfo.body = "[HRPS] " + mInfo.year + "년 " + mInfo.mm + "월 " + mInfo.menuName + " 경영실적 1차 승인이 반려되었습니다. 한라 실적 보고 시스템 관리자에서 확인하시기 바랍니다.";

                    SendMail(mInfo);
                }
            }
            else if (mInfo.afterRegistStatus == Define.REGIST_STATUS.GetKey("2차승인"))
            {
                // 실적담당자에게 메일 발송
                mInfo.AuthLevel = Define.AUTH_LEVEL.GetKey("실적 담당자");
                List<AdminAuth> adminList = adminAuthRepo.selectListCompany(mInfo).ToList();
                foreach (var item in adminList)
                {
                    mailForm = MailForm(mInfo.afterRegistStatus);
                    InsaUserV toInfo = insaUserVRepo.selectOneMail(new { userKey = item.AuthUserKey });
                    mInfo.toAddress = toInfo.emailAddress;
                    mInfo.toName = toInfo.userKorName;
                    mInfo.subject = "[HPRS] " + mInfo.year + "년 " + mInfo.mm + "월 경영실적 승인 안내 메일입니다.";

                    mailForm = mailForm.Replace("{URL}", serverUrl).Replace("{YEAR}", mInfo.year).Replace("{MM}", mInfo.mm).Replace("{MENU_NAME}", mInfo.menuName).Replace("{CONTENT}", "2차 승인이 완료되었습니다.").Replace("{COMPANY}", item.CompKorName);

                    // 2019.01.13 결제라인 추가
                    string hprsUrl = mInfo.ReferUrl.Replace("/Edit2", "/View").Replace("/Edit", "/View") + ":" + mInfo.Seq + ":" + mInfo.OrgCompanySeq;
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
                    mailForm = MailForm(mInfo.afterRegistStatus);
                    InsaUserV toInfo = insaUserVRepo.selectOneMail(new { userKey = item.AuthUserKey });
                    mInfo.toAddress = toInfo.emailAddress;
                    mInfo.toName = toInfo.userKorName;
                    mInfo.subject = "[HPRS] " + mInfo.year + "년 " + mInfo.mm + "월 경영실적 승인 안내 메일입니다.";

                    mailForm = mailForm.Replace("{URL}", serverUrl).Replace("{YEAR}", mInfo.year).Replace("{MM}", mInfo.mm).Replace("{MENU_NAME}", mInfo.menuName).Replace("{CONTENT}", "2차 승인이 완료되었습니다.").Replace("{COMPANY}", item.CompKorName);

                    // 2019.01.13 결제라인 추가
                    string hprsUrl = mInfo.ReferUrl.Replace("/Edit2", "/View").Replace("/Edit", "/View") + ":" + mInfo.Seq + ":" + mInfo.OrgCompanySeq;
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
                foreach (var item in adminList)
                {
                    mailForm = MailForm(mInfo.afterRegistStatus);
                    InsaUserV toInfo = insaUserVRepo.selectOneMail(new { userKey = item.AuthUserKey });
                    mInfo.toAddress = toInfo.emailAddress;
                    mInfo.toName = toInfo.userKorName;
                    mInfo.subject = "[HPRS] " + mInfo.year + "년 " + mInfo.mm + "월 경영실적 승인 안내 메일입니다.";

                    mailForm = mailForm.Replace("{URL}", serverUrl).Replace("{YEAR}", mInfo.year).Replace("{MM}", mInfo.mm).Replace("{MENU_NAME}", mInfo.menuName).Replace("{CONTENT}", "2차 승인이 완료되었습니다.").Replace("{COMPANY}", item.CompKorName);

                    // 2019.01.13 결제라인 추가
                    string hprsUrl = mInfo.ReferUrl.Replace("/Edit2", "/Edit").Replace("/Edit", "/Edit") + ":" + mInfo.Seq + ":" + mInfo.OrgCompanySeq;
                    // 개발서버 로그인 테스트용 url변경
                    hprsUrl = UrlString(redirectUrl.Replace("empNo=", "empNo=" + item.AuthUserKey) + hprsUrl);
                    mailForm = mailForm.Replace("{REDIRECT_URL}", hprsUrl);

                    mInfo.body = mailForm;
                    //mInfo.body = "[HRPS] " + mInfo.year + "년 " + mInfo.mm + "월 " + mInfo.menuName + " 경영실적 1차 승인이 완료되었습니다. 한라 실적 보고 시스템 관리자에서 확인하시기 바랍니다.";

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
                    mailForm = MailForm(mInfo.afterRegistStatus);
                    InsaUserV toInfo = insaUserVRepo.selectOneMail(new { userKey = item.AuthUserKey });
                    mInfo.toAddress = toInfo.emailAddress;
                    mInfo.toName = toInfo.userKorName;
                    mInfo.subject = "[HPRS] " + mInfo.year + "년 " + mInfo.mm + "월 경영실적 승인이 반려되었습니다.";

                    mailForm = mailForm.Replace("{URL}", serverUrl).Replace("{YEAR}", mInfo.year).Replace("{MM}", mInfo.mm).Replace("{MENU_NAME}", mInfo.menuName).Replace("{CONTENT}", "2차승인이 반려되었습니다.").Replace("{COMPANY}", item.CompKorName);
                    mailForm = mailForm.Replace("{USER_INFO}", mInfo.UserInfo).Replace("{REJECT_RESON}", mInfo.RejectReson.Replace("\r\n", "<br />"));

                    // 2019.01.13 결제라인 추가
                    string hprsUrl = mInfo.ReferUrl.Replace("/Edit2", "/Edit").Replace("/Edit", "/Edit") + ":" + mInfo.Seq + ":" + mInfo.OrgCompanySeq;
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
                    mailForm = MailForm(mInfo.afterRegistStatus);
                    InsaUserV toInfo = insaUserVRepo.selectOneMail(new { userKey = item.AuthUserKey });
                    mInfo.toAddress = toInfo.emailAddress;
                    mInfo.toName = toInfo.userKorName;
                    mInfo.subject = "[HPRS] " + mInfo.year + "년 " + mInfo.mm + "월 경영실적 승인이 반려되었습니다.";

                    mailForm = mailForm.Replace("{URL}", serverUrl).Replace("{YEAR}", mInfo.year).Replace("{MM}", mInfo.mm).Replace("{MENU_NAME}", mInfo.menuName).Replace("{CONTENT}", "2차승인이 반려되었습니다.").Replace("{COMPANY}", item.CompKorName);
                    mailForm = mailForm.Replace("{USER_INFO}", mInfo.UserInfo).Replace("{REJECT_RESON}", mInfo.RejectReson.Replace("\r\n", "<br />"));

                    // 2019.01.13 결제라인 추가
                    string hprsUrl = mInfo.ReferUrl.Replace("/Edit2", "/Edit").Replace("/Edit", "/Edit") + ":" + mInfo.Seq + ":" + mInfo.OrgCompanySeq;
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
                    mailForm = MailForm(mInfo.afterRegistStatus);
                    InsaUserV toInfo = insaUserVRepo.selectOneMail(new { userKey = item.AuthUserKey });
                    mInfo.toAddress = toInfo.emailAddress;
                    mInfo.toName = toInfo.userKorName;
                    mInfo.subject = "[HPRS] " + mInfo.year + "년 " + mInfo.mm + "월 경영실적 승인이 반려되었습니다.";

                    mailForm = mailForm.Replace("{URL}", serverUrl).Replace("{YEAR}", mInfo.year).Replace("{MM}", mInfo.mm).Replace("{MENU_NAME}", mInfo.menuName).Replace("{CONTENT}", "최종승인이 반려되었습니다.").Replace("{COMPANY}", item.CompKorName);
                    mailForm = mailForm.Replace("{USER_INFO}", mInfo.UserInfo).Replace("{REJECT_RESON}", mInfo.RejectReson.Replace("\r\n", "<br />"));

                    // 2019.01.13 결제라인 추가
                    string hprsUrl = mInfo.ReferUrl.Replace("/Edit2", "/Edit").Replace("/Edit", "/Edit") + ":" + mInfo.Seq + ":" + mInfo.OrgCompanySeq;
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
                    mailForm = MailForm(mInfo.afterRegistStatus);
                    InsaUserV toInfo = insaUserVRepo.selectOneMail(new { userKey = item.AuthUserKey });
                    mInfo.toAddress = toInfo.emailAddress;
                    mInfo.toName = toInfo.userKorName;
                    mInfo.subject = "[HPRS] " + mInfo.year + "년 " + mInfo.mm + "월 경영실적 승인이 반려되었습니다.";

                    mailForm = mailForm.Replace("{URL}", serverUrl).Replace("{YEAR}", mInfo.year).Replace("{MM}", mInfo.mm).Replace("{MENU_NAME}", mInfo.menuName).Replace("{CONTENT}", "최종승인이 반려되었습니다.").Replace("{COMPANY}", item.CompKorName);
                    mailForm = mailForm.Replace("{USER_INFO}", mInfo.UserInfo).Replace("{REJECT_RESON}", mInfo.RejectReson.Replace("\r\n", "<br />"));

                    // 2019.01.13 결제라인 추가
                    string hprsUrl = mInfo.ReferUrl.Replace("/Edit2", "/Edit").Replace("/Edit", "/Edit") + ":" + mInfo.Seq + ":" + mInfo.OrgCompanySeq;
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
                    mailForm = MailForm(mInfo.afterRegistStatus);
                    InsaUserV toInfo = insaUserVRepo.selectOneMail(new { userKey = item.AuthUserKey });
                    mInfo.toAddress = toInfo.emailAddress;
                    mInfo.toName = toInfo.userKorName;
                    mInfo.subject = "[HPRS] " + mInfo.year + "년 " + mInfo.mm + "월 경영실적 승인이 반려되었습니다.";

                    mailForm = mailForm.Replace("{URL}", serverUrl).Replace("{YEAR}", mInfo.year).Replace("{MM}", mInfo.mm).Replace("{MENU_NAME}", mInfo.menuName).Replace("{CONTENT}", "최종승인이 반려되었습니다.").Replace("{COMPANY}", item.CompKorName);
                    mailForm = mailForm.Replace("{USER_INFO}", mInfo.UserInfo).Replace("{REJECT_RESON}", mInfo.RejectReson.Replace("\r\n", "<br />"));

                    // 2019.01.13 결제라인 추가
                    string hprsUrl = mInfo.ReferUrl.Replace("/Edit", "/Edit2") + ":" + mInfo.Seq + ":" + mInfo.OrgCompanySeq;
                    // 개발서버 로그인 테스트용 url변경
                    hprsUrl = UrlString(redirectUrl.Replace("empNo=", "empNo=" + item.AuthUserKey) + hprsUrl);
                    mailForm = mailForm.Replace("{REDIRECT_URL}", hprsUrl);

                    mInfo.body = mailForm;
                    //mInfo.body = "[HRPS] " + mInfo.year + "년 " + mInfo.mm + "월 " + mInfo.menuName + " 경영실적 최종승인이 반려되었습니다. 한라 실적 보고 시스템 관리자에서 확인하시기 바랍니다.";

                    SendMail(mInfo);
                }
            }
        }
        public static void RegistStatusMailNew(MailInfo mInfo)
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
            string mailForm = File.ReadAllText(HttpContext.Current.Server.MapPath("~/Contents/SiteMngHome/Mail/mail.html"));
            // 2019.01.03 반려는 다른 메일 폼 불러온다.
            if (mInfo.afterRegistStatus == Define.REGIST_STATUS.GetKey("1차반려") || mInfo.afterRegistStatus == Define.REGIST_STATUS.GetKey("2차반려") || mInfo.afterRegistStatus == Define.REGIST_STATUS.GetKey("3차반려"))
            {
                mailForm = File.ReadAllText(HttpContext.Current.Server.MapPath("~/Contents/SiteMngHome/Mail/mail2.html"));
            }


            string redirectUrl = "";
            if (HttpContext.Current.Request.Url.Host.Contains("localhost") || HttpContext.Current.Request.Url.Host.Contains("midashelp") || HttpContext.Current.Request.Url.Host.Contains("test"))
            {
                redirectUrl = "/Home/ssoLogingTest?empNo=" + "&HPRSURL=";
            }
            else
            {
                redirectUrl = "/Portal/Gadget/SignOnMando?SsoId=HALLA.HEIS&HPRSURL=";
            }

            if (mInfo.afterRegistStatus == Define.REGIST_STATUS.GetKey("승인대기")) //승인요청이면
            {
                
            }
            else if (mInfo.afterRegistStatus == Define.REGIST_STATUS.GetKey("1차승인"))
            {
                

            }
            else if (mInfo.afterRegistStatus == Define.REGIST_STATUS.GetKey("1차반려"))
            {
                // 실적담당자에게 메일 발송
                mInfo.AuthLevel = Define.AUTH_LEVEL.GetKey("실적 담당자");
                List<AdminAuth> adminList = adminAuthRepo.selectListCompany(mInfo).ToList();
                foreach (var item in adminList)
                {
                    mailForm = MailForm(mInfo.afterRegistStatus);
                    InsaUserV toInfo = insaUserVRepo.selectOneMail(new { userKey = item.AuthUserKey });
                    mInfo.toAddress = toInfo.emailAddress;
                    mInfo.toName = toInfo.userKorName;
                    mInfo.subject = "[HPRS] " + mInfo.year + "년 " + mInfo.mm + "월 경영실적 승인이 반려되었습니다.";

                    mailForm = mailForm.Replace("{URL}", serverUrl).Replace("{YEAR}", mInfo.year).Replace("{MM}", mInfo.mm).Replace("{MENU_NAME}", mInfo.menuName).Replace("{CONTENT}", "1차 승인이 반려되었습니다.").Replace("{COMPANY}", item.CompKorName);
                    mailForm = mailForm.Replace("{USER_INFO}", mInfo.UserInfo).Replace("{REJECT_RESON}", mInfo.RejectReson.Replace("\r\n", "<br />"));

                    // 2019.01.13 결제라인 추가
                    string hprsUrl = mInfo.ReferUrl.Replace("/Edit2", "/Edit").Replace("/Edit", "/Edit") + ":" + mInfo.Seq + ":" + mInfo.OrgCompanySeq;
                    // 개발서버 로그인 테스트용 url변경
                    hprsUrl = UrlString(redirectUrl.Replace("empNo=", "empNo=" + item.AuthUserKey) + hprsUrl);
                    mailForm = mailForm.Replace("{REDIRECT_URL}", hprsUrl);

                    mInfo.body = mailForm;
                    //mInfo.body = "[HRPS] " + mInfo.year + "년 " + mInfo.mm + "월 " + mInfo.menuName + " 경영실적 1차 승인이 반려되었습니다. 한라 실적 보고 시스템 관리자에서 확인하시기 바랍니다.";

                    SendMail(mInfo);
                }
            }
            else if (mInfo.afterRegistStatus == Define.REGIST_STATUS.GetKey("2차승인"))
            {
               
            }
            else if (mInfo.afterRegistStatus == Define.REGIST_STATUS.GetKey("2차반려"))
            {
                // 실적담당자에게 메일 발송
                mInfo.AuthLevel = Define.AUTH_LEVEL.GetKey("실적 담당자");
                List<AdminAuth> adminList = adminAuthRepo.selectListCompany(mInfo).ToList();
                foreach (var item in adminList)
                {
                    mailForm = MailForm(mInfo.afterRegistStatus);
                    InsaUserV toInfo = insaUserVRepo.selectOneMail(new { userKey = item.AuthUserKey });
                    mInfo.toAddress = toInfo.emailAddress;
                    mInfo.toName = toInfo.userKorName;
                    mInfo.subject = "[HPRS] " + mInfo.year + "년 " + mInfo.mm + "월 경영실적 승인이 반려되었습니다.";

                    mailForm = mailForm.Replace("{URL}", serverUrl).Replace("{YEAR}", mInfo.year).Replace("{MM}", mInfo.mm).Replace("{MENU_NAME}", mInfo.menuName).Replace("{CONTENT}", "2차승인이 반려되었습니다.").Replace("{COMPANY}", item.CompKorName);
                    mailForm = mailForm.Replace("{USER_INFO}", mInfo.UserInfo).Replace("{REJECT_RESON}", mInfo.RejectReson.Replace("\r\n", "<br />"));

                    // 2019.01.13 결제라인 추가
                    string hprsUrl = mInfo.ReferUrl.Replace("/Edit2", "/Edit").Replace("/Edit", "/Edit") + ":" + mInfo.Seq + ":" + mInfo.OrgCompanySeq;
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
                    mailForm = MailForm(mInfo.afterRegistStatus);
                    InsaUserV toInfo = insaUserVRepo.selectOneMail(new { userKey = item.AuthUserKey });
                    mInfo.toAddress = toInfo.emailAddress;
                    mInfo.toName = toInfo.userKorName;
                    mInfo.subject = "[HPRS] " + mInfo.year + "년 " + mInfo.mm + "월 경영실적 승인이 반려되었습니다.";

                    mailForm = mailForm.Replace("{URL}", serverUrl).Replace("{YEAR}", mInfo.year).Replace("{MM}", mInfo.mm).Replace("{MENU_NAME}", mInfo.menuName).Replace("{CONTENT}", "2차승인이 반려되었습니다.").Replace("{COMPANY}", item.CompKorName);
                    mailForm = mailForm.Replace("{USER_INFO}", mInfo.UserInfo).Replace("{REJECT_RESON}", mInfo.RejectReson.Replace("\r\n", "<br />"));

                    // 2019.01.13 결제라인 추가
                    string hprsUrl = mInfo.ReferUrl.Replace("/Edit2", "/Edit").Replace("/Edit", "/Edit") + ":" + mInfo.Seq + ":" + mInfo.OrgCompanySeq;
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
                    mailForm = MailForm(mInfo.afterRegistStatus);
                    InsaUserV toInfo = insaUserVRepo.selectOneMail(new { userKey = item.AuthUserKey });
                    mInfo.toAddress = toInfo.emailAddress;
                    mInfo.toName = toInfo.userKorName;
                    mInfo.subject = "[HPRS] " + mInfo.year + "년 " + mInfo.mm + "월 경영실적 승인이 반려되었습니다.";

                    mailForm = mailForm.Replace("{URL}", serverUrl).Replace("{YEAR}", mInfo.year).Replace("{MM}", mInfo.mm).Replace("{MENU_NAME}", mInfo.menuName).Replace("{CONTENT}", "최종승인이 반려되었습니다.").Replace("{COMPANY}", item.CompKorName);
                    mailForm = mailForm.Replace("{USER_INFO}", mInfo.UserInfo).Replace("{REJECT_RESON}", mInfo.RejectReson.Replace("\r\n", "<br />"));

                    // 2019.01.13 결제라인 추가
                    string hprsUrl = mInfo.ReferUrl.Replace("/Edit2", "/Edit").Replace("/Edit", "/Edit") + ":" + mInfo.Seq + ":" + mInfo.OrgCompanySeq;
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
                    mailForm = MailForm(mInfo.afterRegistStatus);
                    InsaUserV toInfo = insaUserVRepo.selectOneMail(new { userKey = item.AuthUserKey });
                    mInfo.toAddress = toInfo.emailAddress;
                    mInfo.toName = toInfo.userKorName;
                    mInfo.subject = "[HPRS] " + mInfo.year + "년 " + mInfo.mm + "월 경영실적 승인이 반려되었습니다.";

                    mailForm = mailForm.Replace("{URL}", serverUrl).Replace("{YEAR}", mInfo.year).Replace("{MM}", mInfo.mm).Replace("{MENU_NAME}", mInfo.menuName).Replace("{CONTENT}", "최종승인이 반려되었습니다.").Replace("{COMPANY}", item.CompKorName);
                    mailForm = mailForm.Replace("{USER_INFO}", mInfo.UserInfo).Replace("{REJECT_RESON}", mInfo.RejectReson.Replace("\r\n", "<br />"));

                    // 2019.01.13 결제라인 추가
                    string hprsUrl = mInfo.ReferUrl.Replace("/Edit2", "/Edit").Replace("/Edit", "/Edit") + ":" + mInfo.Seq + ":" + mInfo.OrgCompanySeq;
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
                    mailForm = MailForm(mInfo.afterRegistStatus);
                    InsaUserV toInfo = insaUserVRepo.selectOneMail(new { userKey = item.AuthUserKey });
                    mInfo.toAddress = toInfo.emailAddress;
                    mInfo.toName = toInfo.userKorName;
                    mInfo.subject = "[HPRS] " + mInfo.year + "년 " + mInfo.mm + "월 경영실적 승인이 반려되었습니다.";

                    mailForm = mailForm.Replace("{URL}", serverUrl).Replace("{YEAR}", mInfo.year).Replace("{MM}", mInfo.mm).Replace("{MENU_NAME}", mInfo.menuName).Replace("{CONTENT}", "최종승인이 반려되었습니다.").Replace("{COMPANY}", item.CompKorName);
                    mailForm = mailForm.Replace("{USER_INFO}", mInfo.UserInfo).Replace("{REJECT_RESON}", mInfo.RejectReson.Replace("\r\n", "<br />"));

                    // 2019.01.13 결제라인 추가
                    string hprsUrl = mInfo.ReferUrl.Replace("/Edit", "/Edit2") + ":" + mInfo.Seq + ":" + mInfo.OrgCompanySeq;
                    // 개발서버 로그인 테스트용 url변경
                    hprsUrl = UrlString(redirectUrl.Replace("empNo=", "empNo=" + item.AuthUserKey) + hprsUrl);
                    mailForm = mailForm.Replace("{REDIRECT_URL}", hprsUrl);

                    mInfo.body = mailForm;
                    //mInfo.body = "[HRPS] " + mInfo.year + "년 " + mInfo.mm + "월 " + mInfo.menuName + " 경영실적 최종승인이 반려되었습니다. 한라 실적 보고 시스템 관리자에서 확인하시기 바랍니다.";

                    SendMail(mInfo);
                }
            }
        }



        private static string MailForm(int registStatus)
        {
            string mailForm = File.ReadAllText(HttpContext.Current.Server.MapPath("~/Contents/SiteMngHome/Mail/AllConfirmMain.html"));
            // 2019.01.03 반려는 다른 메일 폼 불러온다.
            if (registStatus == Define.REGIST_STATUS.GetKey("1차반려") || registStatus == Define.REGIST_STATUS.GetKey("2차반려") || registStatus == Define.REGIST_STATUS.GetKey("3차반려"))
            {
                mailForm = File.ReadAllText(HttpContext.Current.Server.MapPath("~/Contents/SiteMngHome/Mail/mail2.html"));
            }

            return mailForm;
        }

        private static string UrlString(string str)
        {
            string UrlString = "";
            if (HttpContext.Current.Request.Url.Host.Contains("localhost") ||  HttpContext.Current.Request.Url.Host.Contains("midashelp") || HttpContext.Current.Request.Url.Host.Contains("test"))
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
    }
}