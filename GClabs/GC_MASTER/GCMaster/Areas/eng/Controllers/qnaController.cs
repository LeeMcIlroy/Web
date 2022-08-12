using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Data;
using System.Text;
using System.Net.Mail;

using GCMaster.Modules;
using GCMaster.Controllers;
using GCMaster.Models;

using Dapper;
using PagedList;

namespace GCMaster.Areas.eng.Controllers
{
    [Authorize]
    public class qnaController : BaseController
    {
        private readonly int _pageSize = 30;

        private readonly string _pageType = PageEnum.EngQna.ToCode();

        public ActionResult list()
        {
            ViewBag.datetype = Request.QueryString["datetype"] ?? "1";
            ViewBag.datepick1 = Request.QueryString["datepick1"] ?? "";
            ViewBag.datepick2 = Request.QueryString["datepick2"] ?? "";
            ViewBag.dateperiod = Request.QueryString["dateperiod"] ?? "A";
            ViewBag.ansst = Request.QueryString["ansst"] ?? "";
            ViewBag.qnatype = Request.QueryString["qnatype"] ?? "";
            ViewBag.keytype = Request.QueryString["keytype"] ?? "1";
            ViewBag.keyword = HttpUtility.UrlDecode(Request.QueryString["keyword"] ?? "");

            DateTime tmpDate1 = DateTime.Today.AddMonths(-1);
            DateTime tmpDate2 = DateTime.Today;

            if (!string.IsNullOrEmpty(ViewBag.datepick1))
                if (!DateTime.TryParse(ViewBag.datepick1, out tmpDate1))
                    tmpDate1 = DateTime.Today.AddMonths(-1);
            if (!string.IsNullOrEmpty(ViewBag.datepick2))
                if (!DateTime.TryParse(ViewBag.datepick2, out tmpDate2))
                    tmpDate2 = DateTime.Today;

            ViewBag.datepick1 = tmpDate1.ToString("yyyy-MM-dd");
            ViewBag.datepick2 = tmpDate2.ToString("yyyy-MM-dd");


            int pageNumber = Convert.ToInt16(Request.QueryString["page"] ?? "1");


            List<qnaListModel> lstResult = new List<qnaListModel>();

            using (var conn = Functions.ConnectionDefault)
            {
                conn.Open();

                lstResult = conn.Query<qnaListModel>("dbo.GCMASTER_CONNECT_QNA_LIST_SEL",
                    param: new
                    {
                        pType = _pageType,
                        pDateType = ViewBag.datetype ?? "1",
                        pDatePick1 = ViewBag.datepick1,
                        pDatePick2 = ViewBag.datepick2,
                        pDatePeriod = ViewBag.dateperiod ?? "A",
                        pAnsSt = ViewBag.ansst ?? "",
                        pQnaType = ViewBag.qnatype ?? "",
                        pKeyType = ViewBag.keytype ?? "",
                        pKeyWord = ViewBag.keyword ?? "",
                    },
                    commandType: CommandType.StoredProcedure
                ).ToList();
            }

            return View(lstResult.ToPagedList(pageNumber, _pageSize));
        }

        public ActionResult view(int? id)
        {
            if (id == null)
                return RedirectToAction("list");

            qnaViewModel viewData = null;

            using (var conn = Functions.ConnectionDefault)
            {
                conn.Open();

                viewData = conn.QueryFirst<qnaViewModel>("dbo.GCMASTER_CONNECT_QNA_VIEW_SEL",
                    param: new
                    {
                        pType = _pageType,
                        pIDX = id
                    },
                    commandType: CommandType.StoredProcedure
                );
            }

            return View(viewData);
        }

        [HttpPost, ValidateInput(false)]
        [ValidateAntiForgeryToken]
        public ActionResult answer(qnaViewModel formData, HttpPostedFileBase attachedFile = null)
        {
            bool result = false;
            try
            {
                if (attachedFile != null)
                {
                    string fileName = Functions.GetGuidFileName(attachedFile.FileName);

                    if (Functions.SaveAttachedFile(attachedFile, fileName))
                    {
                        formData.ATTACH2_ORG_NAME = attachedFile.FileName;
                        formData.ATTACH2_SAVE_NAME = fileName;
                    }
                }

                using (var conn = Functions.ConnectionDefault)
                {
                    conn.Open();

                    var execResult = conn.ExecuteScalar("dbo.GCMASTER_CONNECT_QNA_ANSWER_UPD",
                        param: new
                        {
                            TYPE = _pageType,
                            IDX = formData.IDX,

                            QUESTION_TYPE = formData.QUESTION_TYPE,
                            ANS_TITLE = formData.ANS_TITLE,
                            ANS_SENDEMAIL = formData.ANS_SENDEMAIL,
                            ANS_CONTENTS = formData.ANS_CONTENTS,

                            ATTACH2_ORG_NAME = formData.ATTACH2_ORG_NAME,
                            ATTACH2_SAVE_NAME = formData.ATTACH2_SAVE_NAME,

                            ANS_IDX = this.AdminProfile.IDX
                        },
                        commandType: CommandType.StoredProcedure
                    );

                    if (execResult != null)
                        result = Convert.ToInt32(execResult) > 0;
                }

                if (result)
                {
                    if (formData.ANS_SENDEMAIL == "Y")
                        SendMail2Guest(formData);

                    TempData["viewMessage"] = "답변이 저장되었습니다.";
                }
                else
                {
                    TempData["viewMessage"] = "답변 저장에 실패하였습니다.";
                }
            }
            catch (Exception ex)
            {
                SetViewMessageException(ex.Message);
            }

            if (result)
                return RedirectToAction("list");
            else
                return RedirectToAction("view", new { id = formData.IDX });
        }

        [HttpPost, ValidateInput(false)]
        [ValidateAntiForgeryToken]
        public ActionResult delete(qnaViewModel formData)
        {
            bool result = false;

            try
            {
                using (var conn = Functions.ConnectionDefault)
                {
                    conn.Open();

                    var execResult = conn.ExecuteScalar("dbo.GCMASTER_CONNECT_QNA_ANSWER_DEL",
                         param: new
                         {
                             TYPE = _pageType,
                             IDX = formData.IDX
                         },
                         commandType: CommandType.StoredProcedure
                     );

                    if (execResult != null)
                        result = Convert.ToInt32(execResult) > 0;
                }

                SetViewMessageBoardDelete(result);

                if (result)
                {
                    if (!string.IsNullOrEmpty(formData.ATTACH1_SAVE_NAME))
                        Functions.DeleteSavedFile(formData.ATTACH1_SAVE_NAME);

                    if (!string.IsNullOrEmpty(formData.ATTACH2_SAVE_NAME))
                        Functions.DeleteSavedFile(formData.ATTACH2_SAVE_NAME);
                }
            }
            catch (Exception ex)
            {
                SetViewMessageException(ex.Message);
            }

            if (result)
                return RedirectToAction("list");
            else
                return RedirectToAction("view", new { id = formData.IDX });
        }

        private void SendMail2Guest(qnaViewModel qnaData)
        {
            if (qnaData != null)
            {
                MailAddress sender = new MailAddress("gclabsob@gclabs.co.kr");

                List<MailAddress> lstMailAddress = new List<MailAddress>();
                {
                    lstMailAddress.Add(new MailAddress(qnaData.EMAIL, qnaData.NAME, Encoding.UTF8));
                }

                // 수신자가 없으면 발송 중지
                if (!lstMailAddress.Any())
                    return;


                string mailTitle = $"[GC Labs] {qnaData.NAME}, The answer to your inquiry has been registered.";

                // 메일바디 생성
                string htmlBody = $@"
<table cellspacing=""0"" cellpadding=""0"" style=""margin:10px 0 0 20px;padding:0;width:100%;max-width:700px;font-family:'Malgun Gothic',dotum"">
    <caption style=""display:none;"">{mailTitle}</caption><!-- 메일제목 -->
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
                    <td style=""padding:20px 0 20px 30px;font-size:14px;line-height:180%;color:#303030;border-top:1px solid #e0e0e0;"">
                        <strong> Hello, we're GC Labs.<br>
                        The answer to your inquiry has been registered.</strong>
                    </td>
                </tr>
                <tr>
                    <td style=""padding:30px;border-top:1px solid #e0e0e0;line-height:160%;font-size:14px;background-color:#f9fff2;"">
                        <strong style=""font-size:14px;""><span style=""color:#44af2b"">Q.</span> {qnaData.TITLE}</strong><br><br>
                        {qnaData.CONTENTS}
                    </td>
                </tr>
                <tr>
                    <td style=""padding:30px;border-top:1px solid #e0e0e0;border-bottom:1px solid #e0e0e0;line-height:160%;font-size:14px;background-color:#f5f5f5;"">
                        <strong style=""font-size:14px;""><span style=""color:#44af2b"">A.</span> {qnaData.ANS_TITLE}</strong><br><br>
                        {qnaData.ANS_CONTENTS}
                    </td>
                </tr>
                <tr>
                    <td style=""width:100%; text-align:center;padding-top:30px;"">
                    <a href=""https://gclabs.co.kr/eng"" target=""_blank""><button type=""submit"" style=""background: #44af2b;width: 180px;border: 0;border-radius: 6px; height: 35px; font-size: 15px; color:#fff;cursor: pointer;text-align:center;""><span style=""font-weight:600;"">GC Labs </span></button></a>
                    </td>
                </tr>
                <tr>
                    <td style=""padding:30px 0;magrgin:0;background:#fff;max-width:700px;"">
                        <table cellspacing=""0"" cellpadding=""0"" style=""margin:0;padding:20px 0 20px;width:100%;background:#f0f0f0;"">
                            tbody>
                            <tr>
                                <td style=""font-size:12px;line-height:20px;color:#666;padding: 0 25px"">This mail is outgoing only.
                                    Even if you reply to this email, you will not receive a reply.
                                    <br><strong>GC Labs</strong> 107, Ihyeonro 30beon-gil, Giheng-gu, Yongin-Si, Gyeonggi-do, Korea(R.O.K)  | Tel:  +82-31-280-9908
                                    <br>COPYRIGHT ⓒ GC Labs. All rights reserved.
                                </td>
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

                SmtpMail.SendFormMail(sender, lstMailAddress, null, null, mailTitle, htmlBody);
            }
        }



        [HttpPost, ValidateInput(false)]
        [ValidateAntiForgeryToken]
        public ActionResult deletefile(qnaViewModel formData)
        {
            bool result = false;

            try
            {
                using (var conn = Functions.ConnectionDefault)
                {
                    conn.Open();

                    var execResult = conn.ExecuteScalar("dbo.GCMASTER_CONNECT_QNA_DELETE_FILE_UPD",
                        param: new
                        {
                            TYPE = _pageType,
                            IDX = formData.IDX,

                            ANS_IDX = this.AdminProfile.IDX
                        },
                        commandType: CommandType.StoredProcedure
                    );

                    if (execResult != null)
                        result = Convert.ToInt32(execResult) > 0;
                }

                SetViewMessageBoardDeleteFile(result);

                if (result)
                {
                    if (!string.IsNullOrEmpty(formData.ATTACH2_SAVE_NAME))
                        Functions.DeleteSavedFile(formData.ATTACH2_SAVE_NAME);
                }
            }
            catch (Exception ex)
            {
                SetViewMessageException(ex.Message);
            }

            return RedirectToAction("view", new { id = formData.IDX });
        }
    }
}