using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Data;

using GCMaster.Modules;
using GCMaster.Controllers;
using GCMaster.Areas.eng.Models;

using Dapper;
using PagedList;

namespace GCMaster.Areas.eng.Controllers
{
    [Authorize]
    public class intController : BaseController
    {
        private readonly int _pageSize = 30;

        private readonly string _pageType = PageEnum.EngInt.ToCode();

        public ActionResult list()
        {
            ViewBag.datetype = Request.QueryString["datetype"] ?? "1";
            ViewBag.datepick1 = Request.QueryString["datepick1"] ?? "";
            ViewBag.datepick2 = Request.QueryString["datepick2"] ?? "";
            ViewBag.dateperiod = Request.QueryString["dateperiod"] ?? "A";
            ViewBag.viewtype = Request.QueryString["viewtype"] ?? "A";
            ViewBag.notitype = Request.QueryString["notitype"] ?? "A";
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


            List<engListModel> lstResult = new List<engListModel>();

            using (var conn = Functions.ConnectionDefault)
            {
                conn.Open();

                lstResult = conn.Query<engListModel>("dbo.GCMASTER_BOARD_COMMON_LIST_SEL",
                    param: new
                    {
                        pType = _pageType,
                        pDateType = ViewBag.datetype ?? "1",
                        pDatePick1 = ViewBag.datepick1,
                        pDatePick2 = ViewBag.datepick2,
                        pDatePeriod = ViewBag.dateperiod ?? "A",
                        pViewYN = ViewBag.viewtype ?? "A",
                        pNotiYN = ViewBag.notitype ?? "A",
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

            engViewModel viewData = null;

            using (var conn = Functions.ConnectionDefault)
            {
                conn.Open();

                viewData = conn.Query<engViewModel>("dbo.GCMASTER_BOARD_COMMON_VIEW_SEL",
                    param: new
                    {
                        pType = _pageType,
                        pIDX = id
                    },
                    commandType: CommandType.StoredProcedure
                )
                .DefaultIfEmpty(new engViewModel()
                {
                    IDX = 0,
                    TITLE = "",
                    CONTENT_S = "",
                    CONTENT_F = "",
                    VIEW_CNT = 0,
                    VIEW_ORDER = 10,
                    VIEW_YN = "Y",
                    VIEW_DATE = DateTime.Today,
                    VIEW_DATE_YMD = DateTime.Today.ToString("yyyy-MM-dd"),
                    VIEW_DATE_HM = "00:00",
                    NOTI_YN = "N"
                })
                .FirstOrDefault();
            }

            return View(viewData);
        }


        [HttpPost, ValidateInput(false)]
        [ValidateAntiForgeryToken]
        public ActionResult create(engViewModel formData, HttpPostedFileBase attachedImage, HttpPostedFileBase attachedFile1 = null, HttpPostedFileBase attachedFile2 = null)
        {

            bool result = false;

            try
            {
                if (attachedImage != null)
                {
                    string fileName = Functions.GetGuidFileName(attachedImage.FileName);

                    if (Functions.SaveAttachedImage(attachedImage, fileName))
                    {
                        formData.IMAGE1_ORG_NAME = attachedImage.FileName;
                        formData.IMAGE1_SAVE_NAME = fileName;
                        formData.IMAGE1_SIZE = attachedImage.ContentLength;
                    }
                }

                if (attachedFile1 != null)
                {
                    string fileName = Functions.GetGuidFileName(attachedFile1.FileName);

                    if (Functions.SaveAttachedFile(attachedFile1, fileName))
                    {
                        formData.ATTACH1_ORG_NAME = attachedFile1.FileName;
                        formData.ATTACH1_SAVE_NAME = fileName;
                        formData.ATTACH1_SIZE = attachedFile1.ContentLength;
                    }
                }

                if (attachedFile2 != null)
                {
                    string fileName = Functions.GetGuidFileName(attachedFile2.FileName);

                    if (Functions.SaveAttachedFile(attachedFile2, fileName))
                    {
                        formData.ATTACH2_ORG_NAME = attachedFile2.FileName;
                        formData.ATTACH2_SAVE_NAME = fileName;
                        formData.ATTACH2_SIZE = attachedFile2.ContentLength;
                    }
                }

                using (var conn = Functions.ConnectionDefault)
                {
                    conn.Open();

                    var execResult = conn.ExecuteScalar("dbo.GCMASTER_BOARD_COMMON_CREATE_UPD",
                        param: new
                        {
                            TYPE = _pageType,
                            VIEW_ORDER = formData.VIEW_ORDER,
                            VIEW_YN = formData.VIEW_YN,
                            VIEW_DATE_YMD = formData.VIEW_DATE_YMD,
                            VIEW_DATE_HM = formData.VIEW_DATE_HM,
                            NOTI_YN = formData.NOTI_YN,

                            TITLE = formData.TITLE,
                            CONTENT_F = formData.CONTENT_F,
                            DIV_CODE1 = formData.DIV_CODE1,
                            DIV_CODE2 = formData.DIV_CODE2,

                            IMAGE1_ORG_NAME = formData.IMAGE1_ORG_NAME,
                            IMAGE1_SAVE_NAME = formData.IMAGE1_SAVE_NAME,
                            IMAGE1_SIZE = formData.IMAGE1_SIZE,

                            ATTACH1_ORG_NAME = formData.ATTACH1_ORG_NAME,
                            ATTACH1_SAVE_NAME = formData.ATTACH1_SAVE_NAME,
                            ATTACH1_SIZE = formData.ATTACH1_SIZE,

                            ATTACH2_ORG_NAME = formData.ATTACH2_ORG_NAME,
                            ATTACH2_SAVE_NAME = formData.ATTACH2_SAVE_NAME,
                            ATTACH2_SIZE = formData.ATTACH2_SIZE,

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
        public ActionResult edit(engViewModel formData, HttpPostedFileBase attachedImage = null, HttpPostedFileBase attachedFile1 = null, HttpPostedFileBase attachedFile2 = null)
        {
            bool result = false;
            try
            {
                string oldImageName = string.Empty;
                string oldFileName1 = string.Empty;
                string oldFileName2 = string.Empty;

                if (attachedImage != null)
                {
                    string fileName = Functions.GetGuidFileName(attachedImage.FileName);

                    if (Functions.SaveAttachedImage(attachedImage, fileName))
                    {
                        oldImageName = formData.IMAGE1_SAVE_NAME;

                        formData.IMAGE1_ORG_NAME = attachedImage.FileName;
                        formData.IMAGE1_SAVE_NAME = fileName;
                        formData.IMAGE1_SIZE = attachedImage.ContentLength;
                    }
                }

                if (attachedFile1 != null)
                {
                    string fileName = Functions.GetGuidFileName(attachedFile1.FileName);

                    if (Functions.SaveAttachedFile(attachedFile1, fileName))
                    {
                        oldFileName1 = formData.ATTACH1_SAVE_NAME;

                        formData.ATTACH1_ORG_NAME = attachedFile1.FileName;
                        formData.ATTACH1_SAVE_NAME = fileName;
                        formData.ATTACH1_SIZE = attachedFile1.ContentLength;
                    }
                }

                if (attachedFile2 != null)
                {
                    string fileName = Functions.GetGuidFileName(attachedFile2.FileName);

                    if (Functions.SaveAttachedFile(attachedFile2, fileName))
                    {
                        oldFileName2 = formData.ATTACH2_SAVE_NAME;

                        formData.ATTACH2_ORG_NAME = attachedFile2.FileName;
                        formData.ATTACH2_SAVE_NAME = fileName;
                        formData.ATTACH2_SIZE = attachedFile2.ContentLength;
                    }
                }


                using (var conn = Functions.ConnectionDefault)
                {
                    conn.Open();

                    var execResult = conn.ExecuteScalar("dbo.GCMASTER_BOARD_COMMON_EDIT_UPD",
                        param: new
                        {
                            TYPE = _pageType,
                            IDX = formData.IDX,
                            VIEW_ORDER = formData.VIEW_ORDER,
                            VIEW_YN = formData.VIEW_YN,
                            VIEW_DATE_YMD = formData.VIEW_DATE_YMD,
                            VIEW_DATE_HM = formData.VIEW_DATE_HM,
                            NOTI_YN = formData.NOTI_YN,

                            TITLE = formData.TITLE,
                            CONTENT_F = formData.CONTENT_F,
                            DIV_CODE1 = formData.DIV_CODE1,
                            DIV_CODE2 = formData.DIV_CODE2,

                            IMAGE1_ORG_NAME = formData.IMAGE1_ORG_NAME,
                            IMAGE1_SAVE_NAME = formData.IMAGE1_SAVE_NAME,
                            IMAGE1_SIZE = formData.IMAGE1_SIZE,

                            ATTACH1_ORG_NAME = formData.ATTACH1_ORG_NAME,
                            ATTACH1_SAVE_NAME = formData.ATTACH1_SAVE_NAME,
                            ATTACH1_SIZE = formData.ATTACH1_SIZE,

                            ATTACH2_ORG_NAME = formData.ATTACH2_ORG_NAME,
                            ATTACH2_SAVE_NAME = formData.ATTACH2_SAVE_NAME,
                            ATTACH2_SIZE = formData.ATTACH2_SIZE,

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
                    if (!string.IsNullOrEmpty(oldImageName))
                        Functions.DeleteSavedImage(oldImageName);

                    if (!string.IsNullOrEmpty(oldFileName1))
                        Functions.DeleteSavedFile(oldFileName1);

                    if (!string.IsNullOrEmpty(oldFileName2))
                        Functions.DeleteSavedFile(oldFileName2);
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
        public ActionResult delete(engViewModel formData)
        {
            bool result = false;
            try
            {
                using (var conn = Functions.ConnectionDefault)
                {
                    conn.Open();

                    var execResult = conn.ExecuteScalar("dbo.GCMASTER_BOARD_COMMON_DELETE_DEL",
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
                    if (!string.IsNullOrEmpty(formData.IMAGE1_SAVE_NAME))
                        Functions.DeleteSavedImage(formData.IMAGE1_SAVE_NAME);

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
        public ActionResult deletefile(engViewModel formData, string flag)
        {
            bool result = false;

            try
            {
                using (var conn = Functions.ConnectionDefault)
                {
                    conn.Open();

                    var execResult = conn.ExecuteScalar("dbo.GCMASTER_BOARD_COMMON_DELETE_FILE_UPD",
                        param: new
                        {
                            TYPE = _pageType,
                            IDX = formData.IDX,
                            FILE_FLAG = flag,

                            UPDATE_IDX = this.AdminProfile.IDX
                        },
                        commandType: CommandType.StoredProcedure
                    );

                    if (execResult != null)
                        result = Convert.ToInt32(execResult) > 0;
                }

                SetViewMessageBoardDeleteFile(result);

                if (result)
                {
                    if (!string.IsNullOrEmpty(formData.ATTACH1_SAVE_NAME))
                        Functions.DeleteSavedFile(formData.ATTACH1_SAVE_NAME);
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