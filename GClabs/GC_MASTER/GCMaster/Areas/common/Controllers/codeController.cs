using Dapper;
using GCMaster.Areas.common.Models;
using GCMaster.Controllers;
using GCMaster.Modules;
using PagedList;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace GCMaster.Areas.common.Controllers
{
    public class codeController : BaseController
    {
        // GET: common/code
        public ActionResult Index()
        {
            return View();
        }
        private readonly int _pageSize = 20;

        public ActionResult list()
        {
            DateTime tmpDate1 = DateTime.Today.AddDays(-30);
            DateTime tmpDate2 = DateTime.Today;

            string datetype = Request.QueryString["datetype"] ?? "1";
            string datepick1 = Request.QueryString["datepick1"] ?? tmpDate1.ToString("yyyy-MM-dd");
            string datepick2 = Request.QueryString["datepick2"] ?? tmpDate2.ToString("yyyy-MM-dd");

            if (!string.IsNullOrEmpty(datepick1))
                DateTime.TryParse(datepick1, out tmpDate1);
            if (!string.IsNullOrEmpty(datepick2))
                DateTime.TryParse(datepick2, out tmpDate2);

            string usetype = Request.QueryString["usetype"] ?? "A";
            string keytype = Request.QueryString["keytype"] ?? "";
            string keyword = HttpUtility.UrlDecode(Request.QueryString["keyword"] ?? "");


            int pageNumber = Convert.ToInt16(Request.QueryString["page"] ?? "1");


            List<codeModel> lstResult = new List<codeModel>();

            using (var conn = Functions.ConnectionDefault)
            {
                conn.Open();

                lstResult = conn.Query<codeModel>("dbo.GCMASTER_COMMON_CODE_LIST_SEL",
                    param: new
                    {
                        pDateType = datetype ?? "1",
                        pDatePick1 = tmpDate1.ToString("yyyy-MM-dd"),
                        pDatePick2 = tmpDate2.ToString("yyyy-MM-dd"),
                        pDatePeriod = ViewBag.dateperiod ?? "A",
                        pUseYN = usetype ?? "A",
                        pKeyType = keytype ?? "",
                        pKeyWord = keyword ?? ""
                    },
                    commandType: CommandType.StoredProcedure
                ).ToList();
            }

            ViewBag.DateType = datetype;
            ViewBag.DatePick1 = datepick1;
            ViewBag.DatePick2 = datepick2;
            ViewBag.UseType = usetype;
            ViewBag.KeyType = keytype;
            ViewBag.KeyWord = keyword;
            ViewBag.dateperiod = Request.QueryString["dateperiod"] ?? "A";

            return View(lstResult.ToPagedList(pageNumber, _pageSize));
        }

        public ActionResult viewGroup(int? idx)
        {
            if (idx == null)
                return RedirectToAction("list");

            codeModel viewData = null;

            using (var conn = Functions.ConnectionDefault)
            {
                conn.Open();

                viewData = conn.Query<codeModel>("dbo.GCMASTER_COMMON_CODE_VIEW_SEL",
                    param: new
                    {
                        pIDX = idx,
                        GUBUN = "G"
                    },
                    commandType: CommandType.StoredProcedure
                )
                .DefaultIfEmpty(new codeModel()
                {
                    IDX = 0,
                    USE_FLG = "Y"
                })
                .FirstOrDefault();
            }

            return View(viewData);
        }

        public ActionResult viewDetail(int? idx)
        {
            if (idx == null)
                return RedirectToAction("list");
            codeDetail viewData = null;

            List<codeModel> groupList = new List<codeModel>();

            using (var conn = Functions.ConnectionDefault)
            {
                conn.Open();

                groupList = conn.Query<codeModel>("dbo.GCMASTER_COMMON_CODE_DROPDOWNLIST_SEL",
                   param: new
                   {
                       USE_FLG = "Y"
                   },
                   commandType: CommandType.StoredProcedure
               ).ToList();

                viewData = conn.Query<codeDetail>("dbo.GCMASTER_COMMON_CODE_VIEW_SEL",
                    param: new
                    {
                        pIDX = idx,
                        GUBUN = "D"

                    },
                    commandType: CommandType.StoredProcedure
                )
                .DefaultIfEmpty(new codeDetail()
                {
                    IDX = 0,
                    USE_FLG = "Y"
                })
                .FirstOrDefault();
            }
            #region 공통코드 초기화 

            List<SelectListItem> select_comm = new List<SelectListItem>();
            select_comm.Add(new SelectListItem() { Value = "", Text = "선택" });

            for (int i = 0; i < groupList.Count; i++)
            {
                select_comm.Add(new SelectListItem() { Value = groupList[i].GRP_CD, Text = groupList[i].GRP_NM });
            }

            ViewBag.CategoryCodes = select_comm;


            #endregion
            
           
            return View(viewData);
        }


        [HttpPost, ValidateInput(false)]
        [ValidateAntiForgeryToken]
        public ActionResult create(codeModel formData)
        {


            int resultIdx = 0;

            try
            {
                formData.INS_USER = "master";
                formData.UPD_USER = "master";
                formData.GRP_PCD = "";
                formData.NOTE = "";
                formData.GUBUN = "G";

                using (var conn = Functions.ConnectionDefault)
                {

                    conn.Open();

                    var result = conn.ExecuteScalar("dbo.GCMASTER_COMMON_CODE_CREATE_UPD",
                        param: new
                        {
                            GUBUN = formData.GUBUN,
                            GRP_CD = formData.GRP_CD,
                            GRP_NM = formData.GRP_NM,
                            GRP_PCD = formData.GRP_PCD,
                            NOTE = formData.NOTE,
                            USE_FLG = formData.USE_FLG,
                            INS_USER = formData.INS_USER,
                            UPD_USER = formData.UPD_USER

                        },
                        commandType: CommandType.StoredProcedure
                    );

                    if (result != null)
                        resultIdx = Convert.ToInt32(result);
                }

                if (resultIdx == 0)
                    TempData["errorMessage"] = "저장에 실패하였습니다.";
                else
                    return RedirectToAction("list");
            }
            catch (Exception ex)
            {
                SetViewMessageException(ex.Message);
            }

            return RedirectToAction("viewGroup", new { idx = resultIdx });
        }

        public ActionResult createDetail(codeDetail formData)
        {
            int resultIdx = 0;

            try
            {
                formData.INS_USER = "master";
                formData.UPD_USER = "master";
                formData.GUBUN = "D";

                using (var conn = Functions.ConnectionDefault)
                {

                    conn.Open();

                    var result = conn.ExecuteScalar("dbo.GCMASTER_COMMON_CODE_CREATE_UPD",
                        param: new
                        {
                            GUBUN = formData.GUBUN,
                            GRP_CD = formData.GRP_CD,
                            COMM_CD = formData.COMM_CD,
                            COMM_NM = formData.COMM_NM,
                            COMM_PCD = formData.COMM_PCD,
                            ETC_COL1 = formData.ETC_COL1,
                            ETC_COL2 = formData.ETC_COL2,
                            ETC_COL3 = formData.ETC_COL3,
                            ETC_COL4 = formData.ETC_COL4,
                            ETC_COL5 = formData.ETC_COL5,
                            SORT_SEQ = formData.SORT_SEQ,
                            NOTE = formData.NOTE,
                            USE_FLG = formData.USE_FLG,
                            INS_USER = formData.INS_USER,
                            UPD_USER = formData.UPD_USER

                        },
                        commandType: CommandType.StoredProcedure
                    );
                    if (result != null)
                        resultIdx = Convert.ToInt32(result);
                }

                if (resultIdx == 0)
                    TempData["errorMessage"] = "저장에 실패하였습니다.";
                else
                    return RedirectToAction("list");

            }
            catch (Exception ex)
            {
                SetViewMessageException(ex.Message);
            }

            return RedirectToAction("viewDetail", new { idx = resultIdx });
        }

        [HttpPost, ValidateInput(false)]
        [ValidateAntiForgeryToken]
        public ActionResult edit(codeModel formData)
        {
            int result = 0;

            try
            {

                formData.UPD_USER = "master";
                formData.GUBUN = "G";

                using (var conn = Functions.ConnectionDefault)
                {
                    conn.Open();

                    result = conn.Execute("dbo.GCMASTER_COMMON_CODE_EDIT_UPD",
                        param: new
                        {
                            IDX = formData.IDX,
                            GUBUN = formData.GUBUN,
                            GRP_CD = formData.GRP_CD,
                            GRP_NM = formData.GRP_NM,
                            GRP_PCD = formData.GRP_PCD,
                            NOTE = formData.NOTE,
                            USE_FLG = formData.USE_FLG,
                            INS_USER = formData.INS_USER,
                            UPD_USER = formData.UPD_USER,
                        },
                        commandType: CommandType.StoredProcedure
                    );
                }

                if (result == 0)
                    TempData["errorMessage"] = "수정에 실패하였습니다.";
                else
                    return RedirectToAction("list");

            }
            catch (Exception ex)
            {
                SetViewMessageException(ex.Message);
            }

            return RedirectToAction("viewGroup", new { idx = formData.IDX });
        }

        public ActionResult editDetail(codeDetail formData)
        {
            int result = 0;
            try
            {

                formData.UPD_USER = "master";
                formData.GUBUN = "D";


                using (var conn = Functions.ConnectionDefault)
                {
                    conn.Open();

                    result = conn.Execute("dbo.GCMASTER_COMMON_CODE_EDIT_UPD",
                        param: new
                        {
                            IDX = formData.IDX,
                            GUBUN = formData.GUBUN,
                            GRP_CD = formData.GRP_CD,
                            COMM_CD = formData.COMM_CD,
                            COMM_NM = formData.COMM_NM,
                            COMM_PCD = formData.COMM_PCD,
                            //ETC_COL1 = formData.ETC_COL1,
                            //ETC_COL2 = formData.ETC_COL2,
                            //ETC_COL3 = formData.ETC_COL3,
                            //ETC_COL4 = formData.ETC_COL4,
                            //ETC_COL5 = formData.ETC_COL5,
                            SORT_SEQ = formData.SORT_SEQ,
                            USE_FLG = formData.USE_FLG,
                            INS_USER = formData.INS_USER,
                            UPD_USER = formData.UPD_USER,
                        },
                        commandType: CommandType.StoredProcedure
                    );
                }

                if (result == 0)
                    TempData["errorMessage"] = "수정에 실패하였습니다.";
                else
                    return RedirectToAction("list");
            }
            catch (Exception ex)
            {
                SetViewMessageException(ex.Message);
            }

            return RedirectToAction("viewDetail", new { idx = formData.IDX });
        }

    }
}