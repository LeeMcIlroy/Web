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
    public class menuController : BaseController
    {
        private readonly int _pageSize = 30;

        [HttpGet]
        public ActionResult list()
        {
            ViewBag.authcode = Request.QueryString["authcode"] ?? "";
            ViewBag.groupcode = Request.QueryString["groupcode"] ?? "";

            int pageNumber = Convert.ToInt16(Request.QueryString["page"] ?? "1");


            List<menuListModel> lstResult = new List<menuListModel>();

            using (var conn = Functions.ConnectionDefault)
            {
                conn.Open();

                lstResult = conn.Query<menuListModel>("dbo.GCMASTER_COMMON_MENU_LIST_SEL",
                    param: new
                    {
                        pAuthCode = ViewBag.authcode ?? "",
                        pGroupCode = ViewBag.groupcode ?? ""
                    },
                    commandType: CommandType.StoredProcedure
                ).ToList();
            }

            return View(lstResult.ToPagedList(pageNumber, _pageSize));
        }


        [HttpPost, ValidateInput(false)]
        [ValidateAntiForgeryToken]
        public ActionResult list(List<menuListSaveModel> formData)
        {
            string authcode = Request.QueryString["authcode"] ?? "";
            string groupcode = Request.QueryString["groupcode"] ?? "";

            try
            {
                int resultCNT = 0;

                using (var conn = Functions.ConnectionDefault)
                {
                    conn.Open();

                    var result = conn.ExecuteScalar("dbo.GCMASTER_COMMON_MENU_LIST_UPD",
                        param: new
                        {
                            MENU_DATAS = formData.SerializeObject(),
                            REGIST_IDX = this.AdminProfile.IDX
                        },
                        commandType: CommandType.StoredProcedure
                    );

                    if (result != null)
                        resultCNT = Convert.ToInt32(result);
                }

                if (resultCNT == 0)
                    TempData["errorMessage"] = "저장된 내역이 없습니다.";
                else
                    TempData["errorMessage"] = "저장되었습니다.";
            }
            catch (Exception ex)
            {
                SetViewMessageException(ex.Message);
            }

            return RedirectToAction("list", new { @authcode = authcode, @groupcode = groupcode });
        }

        public ActionResult view(int? idx)
        {
            if (idx == null)
                return RedirectToAction("list");

            menuViewModel viewData = new menuViewModel();

            using (var conn = Functions.ConnectionDefault)
            {
                conn.Open();

                viewData = conn.Query<menuViewModel>("dbo.GCMASTER_COMMON_MENU_VIEW_SEL",
                    param: new
                    {
                        pIDX = idx
                    },
                    commandType: CommandType.StoredProcedure
                )
                .DefaultIfEmpty(new menuViewModel()
                {
                    IDX = 0,
                    GROUP_CODE = "",
                    CONTROLLER = "",
                    ACTION = "",
                    NAME = "",
                    USE_YN = "Y",

                })
                .FirstOrDefault();
            }

            return View(viewData);
        }


        [HttpPost, ValidateInput(false)]
        [ValidateAntiForgeryToken]
        public ActionResult create(menuViewModel formData)
        {

            bool result = false;

            try
            {
                using (var conn = Functions.ConnectionDefault)
                {
                    conn.Open();

                    var execResult = conn.ExecuteScalar("dbo.GCMASTER_COMMON_MENU_CREATE_UPD",
                        param: new
                        {
                            GROUP_CODE = formData.GROUP_CODE,
                            CONTROLLER = formData.CONTROLLER,
                            ACTION = formData.ACTION,
                            NAME = formData.NAME,
                            USE_YN = formData.USE_YN,

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
        public ActionResult edit(menuViewModel formData)
        {
            bool result = false;
            try
            {
                using (var conn = Functions.ConnectionDefault)
                {
                    conn.Open();

                    var execResult = conn.ExecuteScalar("dbo.GCMASTER_COMMON_MENU_EDIT_UPD",
                        param: new
                        {
                            IDX = formData.IDX,

                            GROUP_CODE = formData.GROUP_CODE,
                            CONTROLLER = formData.CONTROLLER,
                            ACTION = formData.ACTION,
                            NAME = formData.NAME,
                            USE_YN = formData.USE_YN,

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
    }
}