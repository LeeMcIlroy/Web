
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Data;

using GCMaster.Modules;
using GCMaster.Controllers;
using GCMaster.Areas.gclabs.Models;

using Dapper;
using PagedList;

namespace GCMaster.Areas.gclabs.Controllers
{
    [Authorize]
    public class networkController : BaseController
    {
        private readonly int _pageSize = 30;

        private readonly string _pageType = PageEnum.GclabsNetwork.ToCode();

        public ActionResult list()
        {
            ViewBag.datetype = Request.QueryString["datetype"] ?? "1";
            ViewBag.datepick1 = Request.QueryString["datepick1"] ?? "";
            ViewBag.datepick2 = Request.QueryString["datepick2"] ?? "";
            ViewBag.dateperiod = Request.QueryString["dateperiod"] ?? "A";
            ViewBag.viewtype = Request.QueryString["viewtype"] ?? "A";
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


            List<networkListModel> lstResult = new List<networkListModel>();

            using (var conn = Functions.ConnectionDefault)
            {
                conn.Open();

                lstResult = conn.Query<networkListModel>("dbo.GCMASTER_GCLABS_NETWORK_LIST_SEL",
                    param: new
                    {
                        pType = _pageType,
                        pDateType = ViewBag.datetype ?? "1",
                        pDatePick1 = ViewBag.datepick1,
                        pDatePick2 = ViewBag.datepick2,
                        pDatePeriod = ViewBag.dateperiod ?? "A",
                        pViewYN = ViewBag.viewtype ?? "A",
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

            networkViewModel viewData = null;

            using (var conn = Functions.ConnectionDefault)
            {
                conn.Open();

                viewData = conn.Query<networkViewModel>("dbo.GCMASTER_GCLABS_NETWORK_VIEW_SEL",
                    param: new
                    {
                        pType = _pageType,
                        pIDX = id
                    },
                    commandType: CommandType.StoredProcedure
                )
                .DefaultIfEmpty(new networkViewModel()
                {
                    IDX = 0,

                    VIEW_CNT = 0,
                    VIEW_YN = "Y",

                    TEL_NO_VIEW = true,
                    FAX_NO_VIEW = true
                })
                .FirstOrDefault();
            }

            return View(viewData);
        }


        [HttpPost, ValidateInput(false)]
        [ValidateAntiForgeryToken]
        public ActionResult create(networkViewModel formData)
        {

            bool result = false;

            try
            {
                using (var conn = Functions.ConnectionDefault)
                {
                    conn.Open();

                    var execResult = conn.ExecuteScalar("dbo.GCMASTER_GCLABS_NETWORK_CREATE_UPD",
                        param: new
                        {
                            TYPE = _pageType,
                            VIEW_YN = formData.VIEW_YN,

                            BRANCH_NAME = formData.BRANCH_NAME,
                            MANAGER_NAME = formData.MANAGER_NAME,
                            //MAP_TAG = formData.MAP_TAG,
                            LATITUDE = formData.LATITUDE,
                            LONGITUDE = formData.LONGITUDE,
                            REGION_CODE = formData.REGION_CODE,
                            ADDRESS = formData.ADDRESS,
                            TEL_NO_1 = formData.TEL_NO_1,
                            TEL_NO_2 = formData.TEL_NO_2,
                            TEL_NO_3 = formData.TEL_NO_3,
                            TEL_NO_VIEW = formData.TEL_NO_VIEW,
                            FAX_NO_1 = formData.FAX_NO_1,
                            FAX_NO_2 = formData.FAX_NO_2,
                            FAX_NO_3 = formData.FAX_NO_3,
                            FAX_NO_VIEW = formData.FAX_NO_VIEW,

                            REGIST_IDX = this.AdminProfile.IDX
                        },
                        commandType: CommandType.StoredProcedure
                    );

                    if (execResult != null)
                        result = Convert.ToInt32(execResult) > 0;
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
        public ActionResult edit(networkViewModel formData)
        {
            bool result = false;

            try
            {
                using (var conn = Functions.ConnectionDefault)
                {
                    conn.Open();

                    var execResult = conn.ExecuteScalar("dbo.GCMASTER_GCLABS_NETWORK_EDIT_UPD",
                        param: new
                        {
                            TYPE = _pageType,
                            IDX = formData.IDX,
                            VIEW_YN = formData.VIEW_YN,

                            BRANCH_NAME = formData.BRANCH_NAME,
                            MANAGER_NAME = formData.MANAGER_NAME,
                            //MAP_TAG = formData.MAP_TAG,
                            LATITUDE = formData.LATITUDE,
                            LONGITUDE = formData.LONGITUDE,
                            REGION_CODE = formData.REGION_CODE,
                            ADDRESS = formData.ADDRESS,
                            TEL_NO_1 = formData.TEL_NO_1,
                            TEL_NO_2 = formData.TEL_NO_2,
                            TEL_NO_3 = formData.TEL_NO_3,
                            TEL_NO_VIEW = formData.TEL_NO_VIEW,
                            FAX_NO_1 = formData.FAX_NO_1,
                            FAX_NO_2 = formData.FAX_NO_2,
                            FAX_NO_3 = formData.FAX_NO_3,
                            FAX_NO_VIEW = formData.FAX_NO_VIEW,

                            UPDATE_IDX = this.AdminProfile.IDX
                        },
                        commandType: CommandType.StoredProcedure
                    );

                    if (execResult != null)
                        result = Convert.ToInt32(execResult) > 0;
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
                return RedirectToAction("view", new { id = formData.IDX });
        }

        [HttpPost, ValidateInput(false)]
        [ValidateAntiForgeryToken]
        public ActionResult delete(networkViewModel formData)
        {
            bool result = false;
            try
            {
                using (var conn = Functions.ConnectionDefault)
                {
                    conn.Open();

                    var execResult = conn.ExecuteScalar("dbo.GCMASTER_GCLABS_NETWORK_DELETE_DEL",
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