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

namespace GCMaster.Areas.connect.Controllers
{
    [Authorize]
    public class qnaController : BaseController
    {
        private readonly int _pageSize = 30;

        private readonly string _pageType = PageEnum.ConnectQna.ToCode();

        public ActionResult list()
        {
            ViewBag.datetype = Request.QueryString["datetype"] ?? "1";
            ViewBag.datepick1 = Request.QueryString["datepick1"] ?? "";
            ViewBag.datepick2 = Request.QueryString["datepick2"] ?? "";
            ViewBag.dateperiod = Request.QueryString["dateperiod"] ?? "A";
            ViewBag.ansst = Request.QueryString["ansst"] ?? "";
            ViewBag.qnatype = Request.QueryString["qnatype"] ?? "";
            ViewBag.anstype = Request.QueryString["anstype"] ?? "";

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
                        pAnsType = ViewBag.anstype ?? "",

                        pKeyType = ViewBag.keytype ?? "1",
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

                viewData.QUESTION_TYPE_ORG = viewData.QUESTION_TYPE;
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
        public ActionResult change(qnaViewModel formData)
        {
            bool result = false;
            try
            {
                using (var conn = Functions.ConnectionDefault)
                {
                    conn.Open();

                    var execResult = conn.ExecuteScalar("dbo.GCMASTER_CONNECT_QNA_CHANGE_UPD",
                        param: new
                        {
                            TYPE = _pageType,
                            IDX = formData.IDX,

                            QUESTION_TYPE = formData.QUESTION_TYPE,

                            ANS_IDX = this.AdminProfile.IDX
                        },
                        commandType: CommandType.StoredProcedure
                    );

                    if (execResult != null)
                        result = Convert.ToInt32(execResult) > 0;
                }

                if (result)
                {
                    SendMail2Managers(formData);

                    TempData["viewMessage"] = "고객문의가 이관되었습니다.";
                }
                else
                {
                    TempData["viewMessage"] = "문의이관에 실패하였습니다.";
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
                MailAddress sender = new MailAddress("noreply@gclabs.co.kr");

                List<MailAddress> lstMailAddress = new List<MailAddress>();
                {
                    lstMailAddress.Add(new MailAddress(qnaData.EMAIL, qnaData.NAME, Encoding.UTF8));
                }

                // 수신자가 없으면 발송 중지
                if (!lstMailAddress.Any())
                    return;


                string mailTitle = $"[녹십자의료재단] {qnaData.NAME}님, 문의하신 내용에 대한 답변입니다.";

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
                    <td style=""padding:10px 0 20px;font-size:15px;line-height:180%;color:#303030""><img src=""https://gclabs.co.kr/assets/images/gclabs-logo.png"" width=""165"" alt=""GC Labs"" ></td>
                </tr>

                <tr>
                    <td style=""padding:20px 0 20px 30px;font-size:14px;line-height:180%;color:#303030;border-top:1px solid #e0e0e0;"">
                        <strong> 안녕하세요. GC녹십자의료재단 입니다.<br>
                        고객님께서 문의하신 내용에 답변이 등록되었습니다.</strong>
                    </td>
                </tr>
                <tr>
                    <td style=""padding:30px;border-top:1px solid #e0e0e0;line-height:160%;font-size:14px;background-color:#f9fff2;"">
                        <strong style=""font-size:14px;""><span style=""color:#44af2b"">Q.</span> {qnaData.TITLE}</strong><br><br>
                        {qnaData.CONTENTS.Replace("\n", "<br>")}
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
                        <a href=""https://gclabs.co.kr/support/qna/confirm"" target=""_blank"">
                            <button type=""submit"" style=""background: #44af2b;width: 180px;border: 0;border-radius: 6px; height: 35px; font-size: 15px; color:#fff;cursor: pointer;text-align:center;""><span style=""font-weight:600;"">GC Labs 바로가기</span></button>
                        </a>
                    </td>
                </tr>
                <tr>
                    <td style=""padding:30px 0;magrgin:0;background:#fff;max-width:700px;"">
                        <table cellspacing=""0"" cellpadding=""0"" style=""margin:0;padding:20px 0 20px;width:100%;background:#f0f0f0;"">
                            <tbody>
                            <tr>
                                <td style=""font-size:12px;line-height:20px;color:#666;padding: 0 25px"">이 메일은 발신전용입니다. 이 메일에 회신하셔도 답장을 받으실 수 없습니다.
                                    <br><strong>GC녹십자의료재단</strong> 경기도 용인시 기흥구 이현로 30번길 107  | Tel: 1566-0131 | Fax: 031-8061-6302
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


        public class MailReceiver
        {
            public string Name { get; set; }
            public string Email { get; set; }
            public string Type { get; set; }
        }
        private void SendMail2Managers(qnaViewModel qnaData)
        {
            try
            {
                List<MailReceiver> receivers = null;

                using (var conn = Functions.ConnectionDefault)
                {
                    conn.Open();

                    receivers = conn.Query<MailReceiver>("dbo.GCRL_SUPPORT_QNA_SENDMAIL_SEL",
                        param: new
                        {
                            pInqrCode = qnaData.QUESTION_TYPE
                        },
                        commandType: CommandType.StoredProcedure
                    ).ToList();
                }

                if (qnaData != null && receivers != null && receivers.Any(a => a.Type == "TO"))
                {
                    MailAddress sender = new MailAddress(qnaData.EMAIL, qnaData.NAME);

                    List<MailAddress> lstMailAddress = new List<MailAddress>();
                    List<MailAddress> lstCCs = new List<MailAddress>();
                    List<MailAddress> lstBCCs = new List<MailAddress>();

                    foreach (var item in receivers.Where(w => w.Type == "TO"))
                    {
                        lstMailAddress.Add(new MailAddress(item.Email, item.Name, Encoding.UTF8));
                    }
                    foreach (var item in receivers.Where(w => w.Type == "CC"))
                    {
                        lstCCs.Add(new MailAddress(item.Email, item.Name, Encoding.UTF8));
                    }
                    foreach (var item in receivers.Where(w => w.Type == "BCC"))
                    {
                        lstBCCs.Add(new MailAddress(item.Email, item.Name, Encoding.UTF8));
                    }

                    var qnaTypes = Functions.GetCommList_V2("qna_div", "").ToList();

                    string befQnaType = qnaTypes.FirstOrDefault(f => f.CODE == qnaData.QUESTION_TYPE_ORG).NAME;
                    string aftQnaType = qnaTypes.FirstOrDefault(f => f.CODE == qnaData.QUESTION_TYPE).NAME;

                    // 메일바디 생성
                    string htmlBody = $@"
<table cellspacing=""0"" cellpadding=""0"" style=""margin:10px 0 0 20px;padding:0;width:100%;max-width:700px;font-family:'Malgun Gothic',dotum"">
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
                    <td style=""padding:20px 0 20px;font-size:16px;line-height:180%;color:#303030;border-top:1px solid #e0e0e0;"">
                        <strong> 안녕하세요. GC녹십자의료재단 입니다.<br>
                        문의가 이관되었습니다.  자세한 사항은 관리자 시스템에서 확인 바랍니다.</strong>
                    </td>
                </tr>
                <tr>
                    <td style=""padding:0;"">
                        <table cellspacing=""0"" cellpadding=""0"" style=""margin:0;padding:0;width:100%;border:1px solid #e0e0e0;"">
                            <tbody>
                            <tr >
                                <td style=""border-right:1px solid #e0e0e0;border-bottom:1px solid #e0e0e0;font-size:14px;font-weight:bold;line-height:160%;color:#fff;vertical-align:top;width:120px;padding:7px 0 7px 0;text-align:center;background-color:#519f3f;"">문의유형</td>
                                <td style=""border-bottom:1px solid #e0e0e0;font-size:14px;line-height:160%;color:#333;padding:7px 0 7px 20px;"">{befQnaType} > {aftQnaType}</td>
                            </tr>
                            <tr >
                                <td style=""border-right:1px solid #e0e0e0;border-bottom:1px solid #e0e0e0;font-size:14px;font-weight:bold;line-height:160%;color:#fff;vertical-align:top;width:120px;padding:7px 0 7px 0;text-align:center;background-color:#519f3f;"">성명</td>
                                <td style=""border-bottom:1px solid #e0e0e0;font-size:14px;line-height:160%;color:#333;padding:7px 0 7px 20px;"">{qnaData.NAME}</td>
                            </tr>
                            <tr>
                                <td style=""border-right:1px solid #e0e0e0;border-bottom:1px solid #e0e0e0;font-size:14px;font-weight:bold;line-height:160%;color:#fff;vertical-align:top;width:120px;padding:7px 0 7px 0;text-align:center;background-color:#519f3f;"">직업</td>
                                <td style=""border-bottom:1px solid #e0e0e0;font-size:14px;line-height:160%;color:#333;padding:7px 0 7px 20px;"">{qnaData.OCCUPATION}</td>
                            </tr>
                            <tr>
                                <td style=""border-right:1px solid #e0e0e0;border-bottom:1px solid #e0e0e0;font-size:14px;font-weight:bold;line-height:160%;color:#fff;vertical-align:top;width:120px;padding:7px 0 7px 0;text-align:center;background-color:#519f3f;"">기관명</td>
                                <td style=""border-bottom:1px solid #e0e0e0;font-size:14px;line-height:160%;color:#333;padding:7px 0 7px 20px;"">{qnaData.ORG_NAME}</td>
                            </tr>
                          
                            <tr>
                                <td style=""border-right:1px solid #e0e0e0;border-bottom:1px solid #e0e0e0;font-size:14px;font-weight:bold;line-height:160%;color:#fff;vertical-align:top;width:120px;padding:7px 0 7px 0;text-align:center;background-color:#519f3f;"">이메일</td>
                                <td style=""font-size:14px;border-bottom:1px solid #e0e0e0;line-height:160%;color:#333;padding:7px 0 7px 20px;"">{qnaData.EMAIL}</td>
                            </tr>
                            <tr>
                                <td style=""border-right:1px solid #e0e0e0;border-bottom:1px solid #e0e0e0;font-size:14px;font-weight:bold;line-height:160%;color:#fff;vertical-align:top;width:120px;padding:7px 0 7px 0;text-align:center;background-color:#519f3f;"">문의제목</td>
                                <td style=""font-size:14px;line-height:160%;border-bottom:1px solid #e0e0e0;color:#333;padding:7px 0 7px 20px;"">{qnaData.TITLE}</td>
                            </tr>
                            <tr>
                                <td style=""border-right:1px solid #e0e0e0;font-size:14px;font-weight:bold;line-height:160%;color:#fff;vertical-align:top;width:120px;padding:7px 0 7px 0;text-align:center;background-color:#519f3f;"">문의내용</td>
                                <td style=""font-size:14px;line-height:160%;color:#333;padding:7px 10px 7px 20px;"">{qnaData.CONTENTS.Replace("\n", "<br>")}</td>
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


                    SmtpMail.SendFormMail(sender, lstMailAddress, lstCCs, lstBCCs, "문의가 등록되었습니다.", htmlBody);
                }
            }
            catch
            {

            }
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

                    var execResult = conn.ExecuteScalar("dbo.GCMASTER_CONNECT_QNA_DELETE_DEL",
                        param: new
                        {
                            pType = _pageType,
                            pIDX = formData.IDX,
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