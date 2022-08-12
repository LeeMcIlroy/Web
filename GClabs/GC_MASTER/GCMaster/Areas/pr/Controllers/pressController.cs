
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Data;

using GCMaster.Modules;
using GCMaster.Controllers;
using GCMaster.Areas.pr.Models;

using Dapper;
using PagedList;

namespace GCMaster.Areas.pr.Controllers
{
    [Authorize]
    public class pressController : BaseController
    {
        private readonly int _pageSize = 30;

        private readonly string _pageType = PageEnum.PrPress.ToCode();

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


            List<prListModel> lstResult = new List<prListModel>();

            using (var conn = Functions.ConnectionDefault)
            {
                conn.Open();

                lstResult = conn.Query<prListModel>("dbo.GCMASTER_BOARD_COMMON_LIST_SEL",
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

            prViewModel viewData = null;

            using (var conn = Functions.ConnectionDefault)
            {
                conn.Open();

                viewData = conn.Query<prViewModel>("dbo.GCMASTER_BOARD_COMMON_VIEW_SEL",
                    param: new
                    {
                        pType = _pageType,
                        pIDX = id
                    },
                    commandType: CommandType.StoredProcedure
                )
                .DefaultIfEmpty(new prViewModel()
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
        public ActionResult create(prViewModel formData, HttpPostedFileBase attachedImage1, HttpPostedFileBase attachedImage2 = null, HttpPostedFileBase attachedFile = null)
        {

            bool result = false;

            try
            {
                if (attachedImage1 != null)
                {
                    string fileName = Functions.GetGuidFileName(attachedImage1.FileName);

                    if (Functions.SaveAttachedImage(attachedImage1, fileName))
                    {
                        formData.IMAGE1_ORG_NAME = attachedImage1.FileName;
                        formData.IMAGE1_SAVE_NAME = fileName;
                        formData.IMAGE1_SIZE = attachedImage1.ContentLength;
                    }
                }

                if (attachedImage2 != null)
                {
                    string fileName = Functions.GetGuidFileName(attachedImage2.FileName);

                    if (Functions.SaveAttachedImage(attachedImage2, fileName))
                    {
                        formData.IMAGE2_ORG_NAME = attachedImage2.FileName;
                        formData.IMAGE2_SAVE_NAME = fileName;
                        formData.IMAGE2_SIZE = attachedImage2.ContentLength;
                    }
                }

                if (attachedFile != null)
                {
                    string fileName = Functions.GetGuidFileName(attachedFile.FileName);

                    if (Functions.SaveAttachedFile(attachedFile, fileName))
                    {
                        formData.ATTACH1_ORG_NAME = attachedFile.FileName;
                        formData.ATTACH1_SAVE_NAME = fileName;
                        formData.ATTACH1_SIZE = attachedFile.ContentLength;
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
                            CONTENT_S = formData.CONTENT_S,
                            CONTENT_F = formData.CONTENT_F,

                            IMAGE1_ORG_NAME = formData.IMAGE1_ORG_NAME,
                            IMAGE1_SAVE_NAME = formData.IMAGE1_SAVE_NAME,
                            IMAGE1_SIZE = formData.IMAGE1_SIZE,

                            ATTACH1_ORG_NAME = formData.ATTACH1_ORG_NAME,
                            ATTACH1_SAVE_NAME = formData.ATTACH1_SAVE_NAME,
                            ATTACH1_SIZE = formData.ATTACH1_SIZE,

                            IMAGE2_ORG_NAME = formData.IMAGE2_ORG_NAME,
                            IMAGE2_SAVE_NAME = formData.IMAGE2_SAVE_NAME,
                            IMAGE2_SIZE = formData.IMAGE2_SIZE,

                            LINK1_NAME = formData.LINK1_NAME,
                            LINK1_URL = formData.LINK1_URL,
                            LINK2_NAME = formData.LINK2_NAME,
                            LINK2_URL = formData.LINK2_URL,
                            LINK3_NAME = formData.LINK3_NAME,
                            LINK3_URL = formData.LINK3_URL,

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
        public ActionResult edit(prViewModel formData, HttpPostedFileBase attachedImage1 = null, HttpPostedFileBase attachedImage2 = null, HttpPostedFileBase attachedFile = null)
        {
            bool result = false;
            try
            {
                string oldImageName1 = string.Empty;
                string oldImageName2 = string.Empty;
                string oldFileName = string.Empty;

                if (attachedImage1 != null)
                {
                    string fileName = Functions.GetGuidFileName(attachedImage1.FileName);

                    if (Functions.SaveAttachedImage(attachedImage1, fileName))
                    {
                        oldImageName1 = formData.IMAGE1_SAVE_NAME;

                        formData.IMAGE1_ORG_NAME = attachedImage1.FileName;
                        formData.IMAGE1_SAVE_NAME = fileName;
                        formData.IMAGE1_SIZE = attachedImage1.ContentLength;
                    }
                }

                if (attachedImage2 != null)
                {
                    string fileName = Functions.GetGuidFileName(attachedImage2.FileName);

                    if (Functions.SaveAttachedImage(attachedImage2, fileName))
                    {
                        oldImageName2 = formData.IMAGE2_SAVE_NAME;

                        formData.IMAGE2_ORG_NAME = attachedImage2.FileName;
                        formData.IMAGE2_SAVE_NAME = fileName;
                        formData.IMAGE2_SIZE = attachedImage2.ContentLength;
                    }
                }

                if (attachedFile != null)
                {
                    string fileName = Functions.GetGuidFileName(attachedFile.FileName);

                    if (Functions.SaveAttachedFile(attachedFile, fileName))
                    {
                        oldFileName = formData.ATTACH1_SAVE_NAME;

                        formData.ATTACH1_ORG_NAME = attachedFile.FileName;
                        formData.ATTACH1_SAVE_NAME = fileName;
                        formData.ATTACH1_SIZE = attachedFile.ContentLength;
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
                            CONTENT_S = formData.CONTENT_S,
                            CONTENT_F = formData.CONTENT_F,

                            IMAGE1_ORG_NAME = formData.IMAGE1_ORG_NAME,
                            IMAGE1_SAVE_NAME = formData.IMAGE1_SAVE_NAME,
                            IMAGE1_SIZE = formData.IMAGE1_SIZE,

                            IMAGE2_ORG_NAME = formData.IMAGE2_ORG_NAME,
                            IMAGE2_SAVE_NAME = formData.IMAGE2_SAVE_NAME,
                            IMAGE2_SIZE = formData.IMAGE2_SIZE,

                            ATTACH1_ORG_NAME = formData.ATTACH1_ORG_NAME,
                            ATTACH1_SAVE_NAME = formData.ATTACH1_SAVE_NAME,
                            ATTACH1_SIZE = formData.ATTACH1_SIZE,

                            LINK1_NAME = formData.LINK1_NAME,
                            LINK1_URL = formData.LINK1_URL,
                            LINK2_NAME = formData.LINK2_NAME,
                            LINK2_URL = formData.LINK2_URL,
                            LINK3_NAME = formData.LINK3_NAME,
                            LINK3_URL = formData.LINK3_URL,

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
                    if (!string.IsNullOrEmpty(oldImageName1))
                        Functions.DeleteSavedImage(oldImageName1);

                    if (!string.IsNullOrEmpty(oldImageName2))
                        Functions.DeleteSavedImage(oldImageName2);

                    if (!string.IsNullOrEmpty(oldFileName))
                        Functions.DeleteSavedFile(oldFileName);
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
        public ActionResult delete(prViewModel formData)
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

                    if (!string.IsNullOrEmpty(formData.IMAGE2_SAVE_NAME))
                        Functions.DeleteSavedImage(formData.IMAGE2_SAVE_NAME);

                    if (!string.IsNullOrEmpty(formData.ATTACH1_SAVE_NAME))
                        Functions.DeleteSavedFile(formData.ATTACH1_SAVE_NAME);
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
        public ActionResult deleteimage(prViewModel formData)
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
                            FILE_FLAG = "I2",

                            UPDATE_IDX = this.AdminProfile.IDX
                        },
                        commandType: CommandType.StoredProcedure
                    );

                    if (execResult != null)
                        result = Convert.ToInt32(execResult) > 0;
                }

                SetViewMessageBoardDeleteImage(result);

                if (result)
                {
                    if (!string.IsNullOrEmpty(formData.IMAGE2_SAVE_NAME))
                        Functions.DeleteSavedImage(formData.IMAGE2_SAVE_NAME);
                }
            }
            catch (Exception ex)
            {
                SetViewMessageException(ex.Message);
            }

            return RedirectToAction("view", new { id = formData.IDX });
        }

        [HttpPost, ValidateInput(false)]
        [ValidateAntiForgeryToken]
        public ActionResult deletefile(prViewModel formData)
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
                            FILE_FLAG = "F1",

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