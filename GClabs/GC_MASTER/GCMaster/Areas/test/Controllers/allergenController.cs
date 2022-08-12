using Dapper;
using GCMaster.Areas.test.Models;
using GCMaster.Controllers;
using GCMaster.Modules;
using PagedList;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace GCMaster.Areas.test.Controllers
{
    public class allergenController : BaseController
    {
        private readonly int _pageSize = 20;

        public ActionResult list()
        {
            ViewBag.datetype = Request.QueryString["datetype"] ?? "1";
            ViewBag.datepick1 = Request.QueryString["datepick1"] ?? "";
            ViewBag.datepick2 = Request.QueryString["datepick2"] ?? "";
            ViewBag.dateperiod = Request.QueryString["dateperiod"] ?? "A";
            ViewBag.usetype = Request.QueryString["usetype"] ?? "Y";
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

            List<allergenModel> lstResult = new List<allergenModel>();

            using (var conn = Functions.ConnectionDefault)
            {
                conn.Open();

                lstResult = conn.Query<allergenModel>("dbo.GCMASTER_ALLERGEN_LIST",
                    param: new
                    {
                        pDateType = ViewBag.datetype ?? "1",
                        pDatePick1 = ViewBag.datepick1,
                        pDatePick2 = ViewBag.datepick2,
                        pDatePeriod = ViewBag.dateperiod ?? "A",
                        pUseYN = ViewBag.usetype ?? "Y",
                        pAuthType = ViewBag.authtype ?? "",
                        pKeyType = ViewBag.keytype ?? "",
                        pKeyWord = ViewBag.keyword ?? "",
                    },
                    commandType: CommandType.StoredProcedure
                ).ToList();
            }

            return View(lstResult.ToPagedList(pageNumber, _pageSize));
        }

        public ActionResult view(int? idx, string arg_cd)
        {
            if (arg_cd == null)
                return RedirectToAction("list");

            allergenDetail viewData = new allergenDetail();

            using (var conn = Functions.ConnectionDefault)
            {
                conn.Open();

                viewData = conn.Query<allergenDetail>("dbo.GCMASTER_ALLERGEN_DT",
                    param: new
                    {
                        pARGCD = (arg_cd == "create" ? "" : arg_cd)
                    },
                    commandType: CommandType.StoredProcedure
                )
                .DefaultIfEmpty(new allergenDetail()
                {
                    IDX = 0,
                    ARG_CD = "",
                    ARG_NM = "",
                    VIEW_SEQ = 10,
                    CTGR = "",
                    VIEW_YN = "Y",
                    INS_USER = "master",
                    UPD_USER = "master"
                })
                .FirstOrDefault();
            }

            #region 조회수 증가
            using (var conn = Functions.ConnectionDefault)
            {
                conn.Open();

                var result = conn.ExecuteScalar("dbo.GCMASTER_ALLERGEN_CRUD",
                    param: new
                    {
                        CRUD = "U20",
                        ARG_CD = (arg_cd == "create" ? "" : arg_cd)
                    },
                    commandType: CommandType.StoredProcedure
                );
            }
            #endregion     

            return View(viewData);
        }

        [HttpPost, ValidateInput(false)]
        [ValidateAntiForgeryToken]
        public ActionResult create(allergenModel formData)
        {
            bool result = false;

            string resultCode = "create";

            try
            {
                formData.INS_USER = this.AdminProfile.ID;
                formData.UPD_USER = this.AdminProfile.ID;

                using (var conn = Functions.ConnectionDefault)
                {

                    conn.Open();

                    var execResult = conn.ExecuteScalar("dbo.GCMASTER_ALLERGEN_CRUD",
                        param: new
                        {
                            CRUD = "I10",
                            ARG_CD = formData.ARG_CD,
                            ARG_NM = formData.ARG_NM,
                            CTGR = formData.CTGR,
                            VIEW_YN = formData.VIEW_YN,
                            VIEW_SEQ = formData.VIEW_SEQ,
                            READ_CNT = formData.READ_CNT,
                            INS_USER = formData.INS_USER,
                            UPD_USER = formData.UPD_USER
                        },
                        commandType: CommandType.StoredProcedure
                    );

                    if (execResult != null)
                        result = Convert.ToInt32(execResult) == 0;
                }

                SetViewMessageBoardCreate(result);

                if (result)
                    resultCode = formData.ARG_CD;
            }
            catch (Exception ex)
            {
                SetViewMessageException(ex.Message);
            }

            if (result)
                return RedirectToAction("list");
            else
                return RedirectToAction("view", new { id = resultCode });
        }

        [HttpPost, ValidateInput(false)]
        [ValidateAntiForgeryToken]
        public ActionResult edit(allergenModel formData)
        {
            bool result = false;

            try
            {
                //formData.INS_USER = "master";
                string arg_cd = Request.QueryString["arg_cd"];

                formData.UPD_USER = this.AdminProfile.ID;

                using (var conn = Functions.ConnectionDefault)
                {

                    conn.Open();

                    var execResult = conn.ExecuteScalar("dbo.GCMASTER_ALLERGEN_CRUD",
                        param: new
                        {
                            CRUD = "U10",
                            ARG_CD = formData.ARG_CD ?? arg_cd,
                            ARG_NM = formData.ARG_NM,
                            CTGR = formData.CTGR,
                            VIEW_YN = formData.VIEW_YN,
                            VIEW_SEQ = formData.VIEW_SEQ,
                            READ_CNT = formData.READ_CNT,
                            INS_USER = formData.INS_USER,
                            UPD_USER = formData.UPD_USER
                        },
                        commandType: CommandType.StoredProcedure
                    );

                    if (execResult != null)
                        result = Convert.ToInt32(execResult) == 0;
                }

                SetViewMessageBoardEdit(result);
            }
            catch (Exception ex)
            {
                SetViewMessageException(ex.Message);
            }

            if (result)
                return RedirectToAction("list");
            else
                return RedirectToAction("view", new { id = formData.ARG_CD });
        }

        [HttpPost, ValidateInput(false)]
        [ValidateAntiForgeryToken]
        public ActionResult delete(allergenModel formData)
        {
            bool result = false;
            string arg_cd = Request.QueryString["arg_cd"];

            try
            {
                using (var conn = Functions.ConnectionDefault)
                {
                    conn.Open();

                    var execResult = conn.ExecuteScalar("dbo.GCMASTER_ALLERGEN_CRUD",
                        param: new
                        {
                            CRUD = "D10",
                            ARG_CD = formData.ARG_CD ?? arg_cd
                        },
                        commandType: CommandType.StoredProcedure
                    );

                    if (execResult != null)
                        result = true;
                }

                SetViewMessageBoardDelete(result);
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
    }
}