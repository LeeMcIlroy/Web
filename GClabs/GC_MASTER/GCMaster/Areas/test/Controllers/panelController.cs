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
    public class panelController : BaseController
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

            List<panelModel> lstResult = new List<panelModel>();

            using (var conn = Functions.ConnectionDefault)
            {
                conn.Open();

                lstResult = conn.Query<panelModel>("dbo.GCMASTER_PANEL_LIST",
                    param: new
                    {
                        DATE_TYP   = ViewBag.datetype ?? "1",
                        DATE_STT   = ViewBag.datepick1,
                        DATE_END   = ViewBag.datepick2,
                        DATE_PROD  = ViewBag.dateperiod ?? "A",
                        VIEW_YN    = ViewBag.usetype ?? "Y",
                        PAN_TYP    = ViewBag.authtype ?? "",
                        SEARCH_TYP = ViewBag.keytype ?? "",
                        SEARCH_TXT = ViewBag.keyword ?? "",
                    },
                    commandType: CommandType.StoredProcedure
                ).ToList();
            }

            return View(lstResult.ToPagedList(pageNumber, _pageSize));
        }

        public ActionResult view(int? idx, string pan_cd, string pan_typ, string trb_typ)
        {
            if (idx == null)
                return RedirectToAction("list");

            panelDetail viewData = new panelDetail();

            using (var conn = Functions.ConnectionDefault)
            {
                conn.Open();

                viewData = conn.Query<panelDetail>("dbo.GCMASTER_PANEL_DT",
                    param: new
                    {
                        PAN_CD = pan_cd ?? "",
                        PAN_TYP = pan_typ ?? "",
                        TRB_TYP = trb_typ ?? ""
                    },
                    commandType: CommandType.StoredProcedure
                )
                .DefaultIfEmpty(new panelDetail()
                {
                    IDX = 0,
                    PAN_CD = "",
                    PAN_NM = "",
                    PAN_TYP = "",
                    TRB_TYP = "",
                    FIX_YN = "N",
                    VIEW_SEQ = 10,
                    VIEW_YN = "Y",
                    INS_USER = "master",
                    UPD_USER = "master"
                })
                .FirstOrDefault();
            }

            #region 공통코드 초기화
            ViewBag.TrobleList1 = Functions.GetCommList("panel_test_cd", "01");
            ViewBag.TrobleList2 = Functions.GetCommList("panel_test_cd", "02");
            #endregion

            #region 조회수 증가
            using (var conn = Functions.ConnectionDefault)
            {
                conn.Open();

                var result = conn.ExecuteScalar("dbo.GCMASTER_PANEL_READ",
                    param: new
                    {
                        PAN_CD = pan_cd ?? "",
                        PAN_TYP = pan_typ ?? "",
                        TRB_TYP = trb_typ ?? ""
                    },
                    commandType: CommandType.StoredProcedure
                );

                //if (result != null)
                //    resultIdx = Convert.ToInt32(result);
            }
            #endregion

            if (idx > 0)
                viewData.IDX = 1;
            else
                viewData.IDX = 0;

            return View(viewData);
        }

        [HttpPost, ValidateInput(false)]
        [ValidateAntiForgeryToken]
        public ActionResult create(panelModel formData)
        {
            bool result = false;

            try
            {
                formData.INS_USER = this.AdminProfile.ID;
                formData.UPD_USER = this.AdminProfile.ID;

                using (var conn = Functions.ConnectionDefault)
                {

                    conn.Open();

                    var execResult = conn.ExecuteScalar("dbo.GCMASTER_PANEL_CRUD",
                        param: new
                        {
                            CRUD = "I10",
                            PAN_CD = formData.PAN_CD,
                            PAN_NM = formData.PAN_NM,
                            PAN_TYP = formData.PAN_TYP,
                            TRB_TYP = formData.TRB_TYP,
                            FIX_YN = formData.FIX_YN,
                            VIEW_YN = formData.VIEW_YN,
                            VIEW_SEQ = formData.VIEW_SEQ,
                            READ_CNT = formData.READ_CNT,
                            INS_USER = formData.INS_USER,
                            UPD_USER = formData.UPD_USER
                        },
                        commandType: CommandType.StoredProcedure
                    );

                    if (execResult != null)
                        result = true;
                }

                SetViewMessageBoardCreate(result);
            }
            catch (Exception ex)
            {
                SetViewMessageException(ex.Message);
            }

            if (result)
                return RedirectToAction("list");
            else
                return RedirectToAction("view", new { id = 0 });
        }

        [HttpPost, ValidateInput(false)]
        [ValidateAntiForgeryToken]
        public ActionResult edit(panelModel formData)
        {
            bool result = false;
            int resultIdx = 0;

            string pan_cd = Request.QueryString["pan_cd"];
            string pan_typ = Request.QueryString["pan_typ"];
            string trb_typ = Request.QueryString["trb_typ"];

            try
            {
                formData.INS_USER = this.AdminProfile.ID;
                formData.UPD_USER = this.AdminProfile.ID;

                using (var conn = Functions.ConnectionDefault)
                {

                    conn.Open();

                    var execResult = conn.ExecuteScalar("dbo.GCMASTER_PANEL_CRUD",
                        param: new
                        {
                            CRUD = "U10",
                            PAN_CD = formData.PAN_CD ?? pan_cd,
                            PAN_NM = formData.PAN_NM,
                            PAN_TYP = formData.PAN_TYP ?? pan_typ,
                            TRB_TYP = formData.TRB_TYP ?? trb_typ,
                            FIX_YN = formData.FIX_YN,
                            VIEW_YN = formData.VIEW_YN,
                            VIEW_SEQ = formData.VIEW_SEQ,
                            READ_CNT = formData.READ_CNT,
                            INS_USER = formData.INS_USER,
                            UPD_USER = formData.UPD_USER
                        },
                        commandType: CommandType.StoredProcedure
                    );

                    if (execResult != null)
                        result = true;
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
                return RedirectToAction("view", new { idx = resultIdx });
        }

        [HttpPost, ValidateInput(false)]
        [ValidateAntiForgeryToken]
        public ActionResult delete(panelModel formData)
        {
            bool result = false;
            string pan_cd = Request.QueryString["pan_cd"];
            string pan_typ = Request.QueryString["pan_typ"];
            string trb_typ = Request.QueryString["trb_typ"];

            try
            {
                using (var conn = Functions.ConnectionDefault)
                {
                    conn.Open();

                    var execResult = conn.ExecuteScalar("dbo.GCMASTER_PANEL_CRUD",
                        param: new
                        {
                            CRUD = "D10",
                            PAN_CD = formData.PAN_CD ?? pan_cd,
                            PAN_TYP = formData.PAN_TYP ?? pan_typ,
                            TRB_TYP = formData.TRB_TYP ?? trb_typ
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