
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Data;
using System.Text;
using System.Net.Mail;

using GCRL.Modules;
using GCRL.Controllers;
using GCRL.Models;

using Dapper;
using PagedList;

namespace GCRL.Areas.eng.Controllers
{
    public class qnaController : Controller
    {
        private readonly int _pageSize = 10;

        private readonly string _pageType = PageEnum.EngQna.ToCode();


        public ActionResult write()
        {
            engQnaWriteModel writeModel = new engQnaWriteModel()
            {
                // 05:기타문의 로 고정
                QUESTION_TYPE = "05"
            };

            return View(writeModel);
        }


        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult write(engQnaWriteModel formData, HttpPostedFileBase attachFile = null)
        {
            bool result = false;
            int idx = 0;
            try
            {
                if (ModelState.IsValid)
                {
                    string attachOrgName = "", attachSaveName = "";

                    if (attachFile != null)
                    {
                        attachOrgName = attachFile.FileName;
                        attachSaveName = Functions.GetGuidFileName(attachOrgName);

                        if (!Functions.SaveAttachedFile(attachFile, attachSaveName))
                        {
                            attachOrgName = "";
                            attachSaveName = "";
                        }
                    }

                    using (var conn = Functions.ConnectionDefault)
                    {
                        conn.Open();

                        var execResult = conn.ExecuteScalar("dbo.GCRL_SUPPORT_QNA_WRITE_UPD",
                            param: new
                            {
                                TYPE = _pageType,
                                QUESTION_TYPE = formData.QUESTION_TYPE,
                                NAME = formData.NAME,
                                COUNTRY_NAME = formData.COUNTRY_NAME,
                                REGION_NAME = formData.REGION_NAME,
                                ORG_NAME = formData.ORG_NAME,
                                CONTACT = formData.CONTACT,
                                EMAIL = formData.EMAIL,
                                TITLE = formData.TITLE,
                                CONTENTS = formData.CONTENTS,
                                ATTACH1_ORG_NAME = attachOrgName,
                                ATTACH1_SAVE_NAME = attachSaveName
                            },
                            commandType: CommandType.StoredProcedure
                        );

                        if (execResult != null)
                            result = (idx = Convert.ToInt32(execResult)) > 0;
                    }

                    if (result)
                    {
                        // 관리자에 메일발송
                        SendMail2Managers(formData);
                    }
                }
            }
            catch
            {

            }

            if (result)
            {
                //qnaAuthModel qnaAuth = new qnaAuthModel()
                //{
                //    EMAIL = formData.EMAIL,
                //    PASSWORD = formData.PASSWORD,
                //    AuthDate = DateTime.Now.ToString("yyyy-MM-dd HH:mm")
                //};

                //string aesKey = Functions.Base64Encoding(qnaAuth.SerializeToJSON());

                TempData["viewMessage"] = "Success";

                //return RedirectToAction("view", new { key = aesKey });
            }
            else
            {
                //TempData["viewMessage"] = ModelState.Values.SelectMany(v => v.Errors).FirstOrDefault().ErrorMessage.ToString();
                TempData["viewMessage"] = "Fail";
                //return View(formData);
            }

            return RedirectToAction("write");
        }

        public class MailReceiver
        {
            public string Name { get; set; }
            public string Email { get; set; }
        }

        private void SendMail2Managers(engQnaWriteModel qnaData)
        {
            try
            {
                //List<MailReceiver> receivers = null;

                //using (var conn = Functions.ConnectionDefault)
                //{
                //    conn.Open();

                //    receivers = conn.Query<MailReceiver>("dbo.GCRL_SUPPORT_QNA_SENDMAIL_SEL",
                //        param: new
                //        {
                //            pInqrCode = qnaData.QUESTION_TYPE
                //        },
                //        commandType: CommandType.StoredProcedure
                //    ).ToList();
                //}

                //if (qnaData != null && receivers != null && receivers.Any())
                if (qnaData != null)
                {
                    MailAddress sender = new MailAddress(qnaData.EMAIL, qnaData.NAME);

                    List<MailAddress> lstMailAddress = new List<MailAddress>();

                    //foreach (var item in receivers)
                    //{
                    //    lstMailAddress.Add(new MailAddress(item.Email, item.Name, Encoding.UTF8));
                    //}

                    // 2022.04.26 영문주소 고정
                    //gclabsob@gclabs.co.kr
                    lstMailAddress.Add(new MailAddress("gclabsob@gclabs.co.kr"));

                    // 메일바디 생성
                    string htmlBody = $@"
<table cellspacing=""0"" cellpadding=""0"" style=""margin:10px 0 0 20px;padding:0;width:100%;max-width:700px;font-family:'Malgun Gothic',dotum;text-align:left;"">
    <caption style=""display:none;"">[녹십자의료재단] 문의가 등록되었습니다.</caption><!-- 메일제목 -->
    <tbody>
    <tr>
        <td style=""padding:10px 20px 30px;background:#fff"">
            <table cellspacing=""0"" cellpadding=""0"" width=""100%"">
                <tbody>
                <tr>
                        <td style=""padding:10px 0 20px;font-size:15px;line-height:180%;color:#303030""><img src=""https://gclabs.co.kr/assets/images/gclabs-logo.png"" width=""165"" alt=""GC Labs"" >
                    </td>
                </tr>
                <tr>
                    <td style=""padding:20px 0 20px;font-size:14px;line-height:180%;color:#303030;border-top:1px solid #e0e0e0;"">
                        <strong> 안녕하세요. GC녹십자의료재단 입니다.<br>
                        문의가 등록되었습니다.  자세한 사항은 관리자 시스템에서 확인 바랍니다.</strong>
                    </td>
                </tr>
                <tr>
                    <td style=""padding:0;"">
                        <table cellspacing=""0"" cellpadding=""0"" style=""margin:0;padding:0;width:100%;border:1px solid #e0e0e0;"">
                            <tbody>
                            <tr >
                                <td style=""border-right:1px solid #e0e0e0;border-bottom:1px solid #e0e0e0;font-size:14px;font-weight:bold;line-height:28px;color:#fff;vertical-align:top;width:120px;padding:7px 0 7px 0;text-align:center;background-color:#519f3f;"">Name</td>
                                <td style=""border-bottom:1px solid #e0e0e0;font-size:14px;line-height:28px;color:#333;padding:7px 0 7px 20px;"">{qnaData.NAME}</td>
                            </tr>
                            <tr>
                                <td style=""border-right:1px solid #e0e0e0;border-bottom:1px solid #e0e0e0;font-size:14px;font-weight:bold;line-height:28px;color:#fff;vertical-align:top;width:120px;padding:7px 0 7px 0;text-align:center;background-color:#519f3f;"">Country</td>
                                <td style=""border-bottom:1px solid #e0e0e0;font-size:14px;line-height:28px;color:#333;padding:7px 0 7px 20px;"">{qnaData.COUNTRY_NAME}</td>
                            </tr>
                            <tr>
                                <td style=""border-right:1px solid #e0e0e0;border-bottom:1px solid #e0e0e0;font-size:14px;font-weight:bold;line-height:28px;color:#fff;vertical-align:top;width:120px;padding:7px 0 7px 0;text-align:center;background-color:#519f3f;"">City</td>
                                <td style=""border-bottom:1px solid #e0e0e0;font-size:14px;line-height:28px;color:#333;padding:7px 0 7px 20px;"">{qnaData.REGION_NAME}</td>
                            </tr>
                            <tr>
                                <td style=""border-right:1px solid #e0e0e0;border-bottom:1px solid #e0e0e0;font-size:14px;font-weight:bold;line-height:28px;color:#fff;vertical-align:top;width:120px;padding:7px 0 7px 0;text-align:center;background-color:#519f3f;"">Company</td>
                                <td style=""border-bottom:1px solid #e0e0e0;font-size:14px;line-height:28px;color:#333;padding:7px 0 7px 20px;"">{qnaData.ORG_NAME}</td>
                            </tr>
                            <tr>
                                <td style=""border-right:1px solid #e0e0e0;border-bottom:1px solid #e0e0e0;font-size:14px;font-weight:bold;line-height:28px;color:#fff;vertical-align:top;width:120px;padding:7px 0 7px 0;text-align:center;background-color:#519f3f;"">Phone</td>
                                <td style=""border-bottom:1px solid #e0e0e0;font-size:14px;line-height:28px;color:#333;padding:7px 0 7px 20px;"">{qnaData.CONTACT}</td>
                            </tr>
                            <tr>
                                <td style=""border-right:1px solid #e0e0e0;border-bottom:1px solid #e0e0e0;font-size:14px;font-weight:bold;line-height:160%;color:#fff;vertical-align:top;width:120px;padding:7px 0 7px 0;text-align:center;background-color:#519f3f;"">E-mail</td>
                                <td style=""font-size:14px;border-bottom:1px solid #e0e0e0;line-height:160%;color:#333;padding:7px 0 7px 20px;"">{qnaData.EMAIL}</td>
                            </tr>
                            <tr>
                                <td style=""border-right:1px solid #e0e0e0;border-bottom:1px solid #e0e0e0;font-size:14px;font-weight:bold;line-height:160%;color:#fff;vertical-align:top;width:120px;padding:7px 0 7px 0;text-align:center;background-color:#519f3f;"">Title</td>
                                <td style=""font-size:14px;line-height:160%;border-bottom:1px solid #e0e0e0;color:#333;padding:7px 0 7px 20px;"">{qnaData.TITLE}</td>
                            </tr>
                            <tr>
                                <td style=""border-right:1px solid #e0e0e0;font-size:14px;font-weight:bold;line-height:160%;color:#fff;vertical-align:top;width:120px;padding:7px 0 7px 0;text-align:center;background-color:#519f3f;"">Description</td>
                                <td style=""font-size:14px;line-height:160%;color:#333;padding:7px 10px 7px 20px;"">{qnaData.CONTENTS}</td>
                            </tr>
                        </tbody>
                        </table>
                    </td>
                </tr>
            </tbody>
            </table>
        </td>
    </tr>
    </tbody>
</table>";


                    SmtpMail.SendFormMail(sender, lstMailAddress, null, null, "문의가 등록되었습니다.", htmlBody);
                }
            }
            catch
            {

            }
        }


        public ActionResult confirm()
        {
            return View();
        }


        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult confirm(qnaConfirmModel formData)
        {
            bool result = false;

            if (ModelState.IsValid)
            {
                using (var conn = Functions.ConnectionDefault)
                {
                    conn.Open();

                    var excureResult = conn.ExecuteScalar("dbo.GCRL_SUPPORT_QNA_CONFIRM_SEL",
                        param: new
                        {
                            pType = _pageType,
                            pEmmail = formData.EMAIL,
                            pPassword = formData.PASSWORD
                        },
                        commandType: CommandType.StoredProcedure
                    );

                    if (excureResult != null)
                        result = Convert.ToInt32(excureResult) > 0;
                }
            }

            if (result)
            {
                qnaAuthModel qnaAuth = new qnaAuthModel()
                {
                    EMAIL = formData.EMAIL,
                    PASSWORD = formData.PASSWORD,
                    AuthDate = DateTime.Now.ToString("yyyy-MM-dd HH:mm")
                };

                string aesKey = Functions.Base64Encoding(qnaAuth.SerializeToJSON());

                return RedirectToAction("view", new { key = aesKey });
            }
            else
            {
                TempData["viewMessage"] = "이메일과 비밀번호를 다시 확인해 주세요.";
                return View(formData);
            }
        }


        public ActionResult view()
        {
            qnaAuthModel authData = null;

            string authKey = Request.QueryString["key"] ?? "";

            if (!string.IsNullOrEmpty(authKey))
            {
                try
                {
                    string desKey = Functions.Base64Decoding(authKey);

                    authData = desKey.DeserializeFromJSON(typeof(qnaAuthModel)) as qnaAuthModel;

                    if (Convert.ToDateTime(authData.AuthDate) < DateTime.Now.AddHours(-2))
                    {
                        authData = null;
                        TempData["viewMessage"] = "인증시간이 만료되었습니다. 다시 입력해 주세요.";
                    }
                }
                catch
                {
                    authData = null;
                }
            }

            if (authData == null)
            {
                return RedirectToAction("confirm");
            }


            ViewBag.key = authKey;

            int pageNumber = Convert.ToInt16(Request.QueryString["page"] ?? "1");


            List<qnaListMode> lstResult = new List<qnaListMode>();

            using (var conn = Functions.ConnectionDefault)
            {
                conn.Open();

                lstResult = conn.Query<qnaListMode>("dbo.GCRL_SUPPORT_QNA_VIEW_SEL",
                    param: new
                    {
                        pType = _pageType,
                        pEmmail = authData.EMAIL,
                        pPassword = authData.PASSWORD
                    },
                    commandType: CommandType.StoredProcedure
                ).ToList();
            }

            return View(lstResult.ToPagedList(pageNumber, _pageSize));
        }
    }
}