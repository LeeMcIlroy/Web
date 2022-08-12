using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Data;

using GCMaster.Modules;
using GCMaster.Controllers;
using GCMaster.Models;

using Dapper;
using PagedList;

namespace GCMaster.Areas.gclabs.Controllers
{
    [Authorize]
    public class doctorsController : BaseController
    {
        private readonly int _pageSize = 30;

        private readonly string _pageType = PageEnum.GclabsDoctors.ToCode();

        public ActionResult list()
        {
            ViewBag.datetype = Request.QueryString["datetype"] ?? "1";
            ViewBag.datepick1 = Request.QueryString["datepick1"] ?? "";
            ViewBag.datepick2 = Request.QueryString["datepick2"] ?? "";
            ViewBag.dateperiod = Request.QueryString["dateperiod"] ?? "A";
            ViewBag.viewtype = Request.QueryString["viewtype"] ?? "A";
            ViewBag.divcode1 = Request.QueryString["divcode1"] ?? "";
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


            List<doctorsListModel> lstResult = new List<doctorsListModel>();

            using (var conn = Functions.ConnectionDefault)
            {
                conn.Open();

                lstResult = conn.Query<doctorsListModel>("dbo.GCMASTER_GCLABS_DOCTORS_LIST_SEL",
                    param: new
                    {
                        pType = _pageType,
                        pDateType = ViewBag.datetype ?? "1",
                        pDatePick1 = ViewBag.datepick1,
                        pDatePick2 = ViewBag.datepick2,
                        pDatePeriod = ViewBag.dateperiod ?? "A",
                        pViewYN = ViewBag.viewtype ?? "A",
                        pDeptCode = ViewBag.divcode1 ?? "",
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


            ViewBag.keytype = Request.QueryString["subkeytype"] ?? "";
            ViewBag.keyword = HttpUtility.UrlDecode(Request.QueryString["subkeyword"] ?? "");

            int pageNumber = Convert.ToInt16(Request.QueryString["subpage"] ?? "1");

            doctorsViewModel viewData = null;
            List<paperListModel> lstResult = new List<paperListModel>();

            using (var conn = Functions.ConnectionDefault)
            {
                conn.Open();

                viewData = conn.Query<doctorsViewModel>("dbo.GCMASTER_GCLABS_DOCTORS_VIEW_SEL",
                    param: new
                    {
                        pType = _pageType,
                        pIDX = id
                    },
                    commandType: CommandType.StoredProcedure
                )
                .DefaultIfEmpty(new doctorsViewModel()
                {
                    IDX = 0,

                    VIEW_CNT = 0,
                    VIEW_ORDER = 10,
                    VIEW_YN = "Y",
                })
                .FirstOrDefault();


                lstResult = conn.Query<paperListModel>("dbo.GCMASTER_GCLABS_DOCTORS_PAPER_LIST_SEL",
                    param: new
                    {
                        pType = _pageType,
                        pDoctorsIDX = id,
                        pKeyType = ViewBag.keytype ?? "",
                        pKeyWord = ViewBag.keyword ?? ""
                    },
                    commandType: CommandType.StoredProcedure
                ).ToList();
            }

            ViewBag.PaperList = lstResult.ToPagedList(pageNumber, 10);

            return View(viewData);
        }


        [HttpPost, ValidateInput(false)]
        [ValidateAntiForgeryToken]
        public ActionResult create(doctorsViewModel formData)
        {

            int resultIDX = 0;

            try
            {
                using (var conn = Functions.ConnectionDefault)
                {
                    conn.Open();

                    var execResult = conn.ExecuteScalar("dbo.GCMASTER_GCLABS_DOCTORS_CREATE_UPD",
                        param: new
                        {
                            TYPE = _pageType,
                            VIEW_ORDER = formData.VIEW_ORDER,
                            VIEW_YN = formData.VIEW_YN,

                            NAME = formData.NAME,
                            NAME_ENG = formData.NAME_ENG,
                            DEPT_CODE = formData.DEPT_CODE,
                            SUMMARY = formData.SUMMARY,

                            REGIST_IDX = this.AdminProfile.IDX
                        },
                        commandType: CommandType.StoredProcedure
                    );

                    if (execResult != null)
                        resultIDX = Convert.ToInt32(execResult);
                }

                SetViewMessageBoardCreate(resultIDX > 0);
            }
            catch (Exception ex)
            {
                SetViewMessageException(ex.Message);
            }

            if (resultIDX == 0)
                return RedirectToAction("view", new { id = resultIDX });
            else
                return RedirectToAction("list");
        }

        [HttpPost, ValidateInput(false)]
        [ValidateAntiForgeryToken]
        public ActionResult edit(doctorsViewModel formData)
        {
            bool result = false;

            try
            {
                using (var conn = Functions.ConnectionDefault)
                {
                    conn.Open();

                    var execResult = conn.ExecuteScalar("dbo.GCMASTER_GCLABS_DOCTORS_EDIT_UPD",
                        param: new
                        {
                            TYPE = _pageType,
                            IDX = formData.IDX,
                            VIEW_ORDER = formData.VIEW_ORDER,
                            VIEW_YN = formData.VIEW_YN,

                            NAME = formData.NAME,
                            NAME_ENG = formData.NAME_ENG,
                            DEPT_CODE = formData.DEPT_CODE,
                            SUMMARY = formData.SUMMARY,

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
        public ActionResult delete(doctorsViewModel formData)
        {
            bool result = false;
            try
            {
                using (var conn = Functions.ConnectionDefault)
                {
                    conn.Open();

                    var execResult = conn.ExecuteScalar("dbo.GCMASTER_GCLABS_DOCTORS_DELETE_DEL",
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



        public ActionResult viewpaper(int id)
        {

            int paperIDX = Convert.ToInt16(Request.QueryString["idx"] ?? "0");

            paperViewModel viewData = null;

            using (var conn = Functions.ConnectionDefault)
            {
                conn.Open();

                viewData = conn.Query<paperViewModel>("dbo.GCMASTER_GCLABS_DOCTORS_PAPER_VIEW_SEL",
                    param: new
                    {
                        pType = _pageType,
                        pDoctorsIDX = id,
                        pIDX = paperIDX

                    },
                    commandType: CommandType.StoredProcedure
                )
                .DefaultIfEmpty(new paperViewModel()
                {
                    IDX = 0,
                    DOCTORS_IDX = id,
                    VIEW_YN = "Y",
                })
                .FirstOrDefault();
            }

            return View(viewData);
        }

        [HttpPost, ValidateInput(false)]
        [ValidateAntiForgeryToken]
        public ActionResult createpaper(paperViewModel formData, HttpPostedFileBase attachedfile)
        {

            bool result = false;

            try
            {
                if (attachedfile != null)
                {
                    string fileName = Functions.GetGuidFileName(attachedfile.FileName);

                    if (Functions.SaveAttachedFile(attachedfile, fileName))
                    {
                        formData.ATTACH_ORG_NAME = attachedfile.FileName;
                        formData.ATTACH_SAVE_NAME = fileName;
                        formData.ATTACH_SIZE = attachedfile.ContentLength;
                    }
                }

                using (var conn = Functions.ConnectionDefault)
                {
                    conn.Open();

                    var execResult = conn.ExecuteScalar("dbo.GCMASTER_GCLABS_DOCTORS_PAPER_CREATE_UPD",
                        param: new
                        {
                            TYPE = _pageType,
                            DOCTORS_IDX = formData.DOCTORS_IDX,
                            VIEW_YN = formData.VIEW_YN,

                            NAME = formData.NAME,
                            YEAR = formData.YEAR,
                            SOURCE = formData.SOURCE,

                            ATTACH_ORG_NAME = formData.ATTACH_ORG_NAME,
                            ATTACH_SAVE_NAME = formData.ATTACH_SAVE_NAME,
                            ATTACH_SIZE = formData.ATTACH_SIZE,

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
                return View("closepaper");
            else
                return RedirectToAction("viewpaper", new { id = formData.DOCTORS_IDX, idx = 0 });
        }

        [HttpPost, ValidateInput(false)]
        [ValidateAntiForgeryToken]
        public ActionResult editpaper(paperViewModel formData, HttpPostedFileBase attachedfile)
        {
            bool result = false;
            try
            {
                string oldFileName = string.Empty;

                if (attachedfile != null)
                {
                    string fileName = Functions.GetGuidFileName(attachedfile.FileName);

                    if (Functions.SaveAttachedFile(attachedfile, fileName))
                    {
                        oldFileName = formData.ATTACH_SAVE_NAME;

                        formData.ATTACH_ORG_NAME = attachedfile.FileName;
                        formData.ATTACH_SAVE_NAME = fileName;
                        formData.ATTACH_SIZE = attachedfile.ContentLength;
                    }
                }

                using (var conn = Functions.ConnectionDefault)
                {
                    conn.Open();

                    var execResult = conn.ExecuteScalar("dbo.GCMASTER_GCLABS_DOCTORS_PAPER_EDIT_UPD",
                        param: new
                        {
                            TYPE = _pageType,

                            DOCTORS_IDX = formData.DOCTORS_IDX,
                            IDX = formData.IDX,
                            VIEW_YN = formData.VIEW_YN,

                            NAME = formData.NAME,
                            YEAR = formData.YEAR,
                            SOURCE = formData.SOURCE,

                            ATTACH_ORG_NAME = formData.ATTACH_ORG_NAME,
                            ATTACH_SAVE_NAME = formData.ATTACH_SAVE_NAME,
                            ATTACH_SIZE = formData.ATTACH_SIZE,

                            UPDATE_IDX = this.AdminProfile.IDX
                        },
                        commandType: CommandType.StoredProcedure
                    );

                    if (execResult != null)
                        result = Convert.ToInt32(execResult) > 0;
                }

                SetViewMessageBoardEdit(result);

                if (result)
                {
                    if (!string.IsNullOrEmpty(oldFileName))
                        Functions.DeleteSavedFile(oldFileName);
                }
            }
            catch (Exception ex)
            {
                SetViewMessageException(ex.Message);
            }

            if (result)
                return View("closepaper");
            else
                return RedirectToAction("viewpaper", new { id = formData.DOCTORS_IDX, idx = formData.IDX });
        }

        [HttpPost, ValidateInput(false)]
        [ValidateAntiForgeryToken]
        public ActionResult deletepaper(paperViewModel formData)
        {
            bool result = false;
            try
            {
                using (var conn = Functions.ConnectionDefault)
                {
                    conn.Open();

                    var execResult = conn.ExecuteScalar("dbo.GCMASTER_GCLABS_DOCTORS_PAPER_DELETE_DEL",
                        param: new
                        {
                            pType = _pageType,
                            pDoctorsIDX = formData.DOCTORS_IDX,
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
                    if (!string.IsNullOrEmpty(formData.ATTACH_SAVE_NAME))
                        Functions.DeleteSavedFile(formData.ATTACH_SAVE_NAME);
                }
            }
            catch (Exception ex)
            {
                SetViewMessageException(ex.Message);
            }

            if (result)
                return View("closepaper");
            else
                return RedirectToAction("viewpaper", new { id = formData.DOCTORS_IDX, idx = formData.IDX });
        }
    }
}