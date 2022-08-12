using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Data;

using GCMaster.Modules;
using GCMaster.Areas.common.Models;

using Dapper;
using PagedList;
using System.Net;

using GCMaster.Controllers;

namespace GCMaster.Areas.common.Controllers
{
    [Authorize]
    public class userController : BaseController
    {
        private readonly int _pageSize = 30;

        public ActionResult list()
        {
            ViewBag.datetype = Request.QueryString["datetype"] ?? "1";
            ViewBag.datepick1 = Request.QueryString["datepick1"] ?? "";
            ViewBag.datepick2 = Request.QueryString["datepick2"] ?? "";
            ViewBag.dateperiod = Request.QueryString["dateperiod"] ?? "A";
            ViewBag.usetype = Request.QueryString["usetype"] ?? "A";
            ViewBag.authtype = Request.QueryString["authtype"] ?? "";
            ViewBag.keytype = Request.QueryString["keytype"] ?? "";
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


            List<userListModel> lstResult = new List<userListModel>();

            using (var conn = Functions.ConnectionDefault)
            {
                conn.Open();

                lstResult = conn.Query<userListModel>("dbo.GCMASTER_COMMON_USER_LIST_SEL",
                    param: new
                    {
                        pDateType = ViewBag.datetype ?? "1",
                        pDatePick1 = ViewBag.datepick1,
                        pDatePick2 = ViewBag.datepick2,
                        pDatePeriod = ViewBag.dateperiod ?? "A",
                        pUseYN = ViewBag.usetype ?? "A",
                        pAuthType = ViewBag.authtype ?? "",
                        pKeyType = ViewBag.keytype ?? "",
                        pKeyWord = ViewBag.keyword ?? ""
                    },
                    commandType: CommandType.StoredProcedure
                ).ToList();
            }

            return View(lstResult.ToPagedList(pageNumber, _pageSize));
        }

        public ActionResult view(int? idx)
        {
            if (idx == null)
                return RedirectToAction("list");

            userViewModel viewData = new userViewModel();

            using (var conn = Functions.ConnectionDefault)
            {
                conn.Open();

                viewData = conn.Query<userViewModel>("dbo.GCMASTER_COMMON_USER_VIEW_SEL",
                    param: new
                    {
                        pIDX = idx
                    },
                    commandType: CommandType.StoredProcedure
                )
                .DefaultIfEmpty(new userViewModel()
                {
                    IDX = 0,
                    USE_YN = "Y",
                    AUTH_CODE = "",
                    ADM_NAME = "",
                    ADM_ID = "",
                    ADM_PWD = "",
                    DEPT_CODE = "",
                    PHONE = "",
                    EMAIL = "",

                    QNA_MAIL_TO = "",
                    QNA_MAIL_CC = "",
                    QNA_MAIL_BCC = ""
                })
                .FirstOrDefault();
            }

            return View(viewData);
        }


        public ActionResult checkid(int idx, string id)
        {
            int result = 0;

            using (var conn = Functions.ConnectionDefault)
            {
                conn.Open();

                result = conn.QuerySingleOrDefault<int>("dbo.GCMASTER_COMMON_USER_CHECKID_SEL",
                    param: new
                    {
                        pIDX = idx,
                        pID = id
                    },
                    commandType: CommandType.StoredProcedure
                );
            }

            return Json(result > 0, JsonRequestBehavior.AllowGet);
        }


        [HttpPost, ValidateInput(false)]
        [ValidateAntiForgeryToken]
        public ActionResult create(userViewModel formData)
        {

            int resultIDX = 0;

            try
            {
                using (var conn = Functions.ConnectionDefault)
                {
                    conn.Open();

                    var result = conn.ExecuteScalar("dbo.GCMASTER_COMMON_USER_CREATE_UPD",
                        param: new
                        {
                            USE_YN = formData.USE_YN,
                            ADM_ID = formData.ADM_ID,
                            ADM_NAME = formData.ADM_NAME,
                            ADM_PWD = formData.ADM_PWD,
                            PHONE = formData.PHONE,
                            EMAIL = formData.EMAIL,
                            
                            AUTH_CODE = formData.AUTH_CODE,
                            DEPT_CODE = formData.DEPT_CODE,

                            QNA_MAIL_TO = string.Join(",", formData.SelectedMailTos),
                            QNA_MAIL_CC = string.Join(",", formData.SelectedMailCCs),
                            QNA_MAIL_BCC = string.Join(",", formData.SelectedMailBCCs),

                            REGIST_IDX = this.AdminProfile.IDX
                        },
                        commandType: CommandType.StoredProcedure
                    );

                    if (result != null)
                        resultIDX = Convert.ToInt32(result);
                }

                if (resultIDX == 0)
                    TempData["errorMessage"] = "등록에 실패하였습니다.";
                else if (resultIDX == -1)
                    TempData["errorMessage"] = "등록에 실패하였습니다. : 사용중인 아이디 입니다.";
                else
                    return RedirectToAction("list");

            }
            catch (Exception ex)
            {
                SetViewMessageException(ex.Message);
            }

            return RedirectToAction("view", new { idx = resultIDX });
        }


        [HttpPost, ValidateInput(false)]
        [ValidateAntiForgeryToken]
        public ActionResult edit(userViewModel formData)
        {
            try
            {
                int resultCNT = 0;

                if (formData.SelectedMailTos != null && formData.SelectedMailTos.Any())
                    formData.QNA_MAIL_TO = string.Join(",", formData.SelectedMailTos);
                else
                    formData.QNA_MAIL_TO = "";

                if (formData.SelectedMailCCs != null && formData.SelectedMailCCs.Any())
                    formData.QNA_MAIL_CC = string.Join(",", formData.SelectedMailCCs);
                else
                    formData.QNA_MAIL_CC = "";

                if (formData.SelectedMailBCCs != null && formData.SelectedMailBCCs.Any())
                    formData.QNA_MAIL_BCC = string.Join(",", formData.SelectedMailBCCs);
                else
                    formData.QNA_MAIL_BCC = "";


                using (var conn = Functions.ConnectionDefault)
                {
                    conn.Open();

                    var result = conn.ExecuteScalar("dbo.GCMASTER_COMMON_USER_EDIT_UPD",
                        param: new
                        {
                            IDX = formData.IDX,
                            USE_YN = formData.USE_YN,
                            ADM_ID = formData.ADM_ID,
                            ADM_NAME = formData.ADM_NAME,
                            ADM_PWD = formData.ADM_PWD,
                            PHONE = formData.PHONE,
                            EMAIL = formData.EMAIL,

                            AUTH_CODE = formData.AUTH_CODE,
                            DEPT_CODE = formData.DEPT_CODE,

                            QNA_MAIL_TO = formData.QNA_MAIL_TO,
                            QNA_MAIL_CC = formData.QNA_MAIL_CC,
                            QNA_MAIL_BCC = formData.QNA_MAIL_BCC,

                            UPDATE_IDX = this.AdminProfile.IDX
                        },
                        commandType: CommandType.StoredProcedure
                    );

                    if (result != null)
                        resultCNT = Convert.ToInt32(result);
                }

                if (resultCNT == 0)
                    TempData["errorMessage"] = "수정에 실패하였습니다.";
                else if (resultCNT == -1)
                    TempData["errorMessage"] = "수정에 실패하였습니다. : 사용중인 아이디 입니다.";
                else
                    return RedirectToAction("list");
            }
            catch (Exception ex)
            {
                SetViewMessageException(ex.Message);
            }

            return RedirectToAction("view", new { idx = formData.IDX });
        }


        public ActionResult edithistory(int idx)
        {
            int pageNumber = Convert.ToInt16(Request.QueryString["page"] ?? "1");


            List<userEditHistoryModel> lstResult = new List<userEditHistoryModel>();

            using (var conn = Functions.ConnectionDefault)
            {
                conn.Open();

                lstResult = conn.Query<userEditHistoryModel>("dbo.GCMASTER_COMMON_USER_EDITHISTORY_SEL",
                    param: new
                    {
                        pIDX = idx
                    },
                    commandType: CommandType.StoredProcedure
                ).ToList();
            }

            return View(lstResult.ToPagedList(pageNumber, 10));
        }

        public ActionResult accesshistory(int idx)
        {
            int pageNumber = Convert.ToInt16(Request.QueryString["page"] ?? "1");


            List<userAccessHistoryModel> lstResult = new List<userAccessHistoryModel>();

            using (var conn = Functions.ConnectionDefault)
            {
                conn.Open();

                lstResult = conn.Query<userAccessHistoryModel>("dbo.GCMASTER_COMMON_USER_ACCESSHISTORY_SEL",
                    param: new
                    {
                        pIDX = idx
                    },
                    commandType: CommandType.StoredProcedure
                ).ToList();
            }

            return View(lstResult.ToPagedList(pageNumber, 10));
        }
    }
}