
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Data;

using GCMaster.Modules;
using GCMaster.Controllers;
using GCMaster.Areas.support.Models;

using Dapper;
using PagedList;
using System.IO;
using static GCMaster.Modules.Functions;

namespace GCMaster.Areas.support.Controllers
{
    [Authorize]
    public class officialController : BaseController
    {
        private readonly int _pageSize = 30;

        private readonly string _pageType = PageEnum.SupportOfficial.ToCode();

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


            List<supportListModel> lstResult = new List<supportListModel>();

            using (var conn = Functions.ConnectionDefault)
            {
                conn.Open();

                lstResult = conn.Query<supportListModel>("dbo.GCMASTER_BOARD_COMMON_LIST_SEL",
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

            supportViewModel viewdata = null;

            using (var conn = Functions.ConnectionDefault)
            {
                conn.Open();

                viewdata = conn.Query<supportViewModel>("dbo.GCMASTER_BOARD_COMMON_VIEW_SEL",
                    param: new
                    {
                        pType = _pageType,
                        pIDX = id
                    },
                    commandType: CommandType.StoredProcedure
                )
                .DefaultIfEmpty(new supportViewModel()
                {
                    IDX = 0,
                    DIV_CODE1 = "N",
                    DIV_CODE2 = "",
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

            return View(viewdata);
        }


        [HttpPost, ValidateInput(false)]
        [ValidateAntiForgeryToken]
        //public ActionResult create(supportViewModel formData, HttpPostedFileBase attachedImage = null, HttpPostedFileBase attachedFile = null)
        public ActionResult create(supportViewModel formData, HttpPostedFileBase attachedFile = null)
        {

            bool result = false;

            try
            {
                //if(attachedImage != null)
                //{
                //    string fileName = Functions.GetGuidFileName(attachedImage.FileName);

                //    if (Functions.SaveAttachedImage(attachedImage, fileName))
                //    {
                //        formData.IMAGE1_ORG_NAME = attachedImage.FileName;
                //        formData.IMAGE1_SAVE_NAME = fileName;
                //        formData.IMAGE1_SIZE = attachedImage.ContentLength;
                //    }
                //}

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

                            DIV_CODE1 = formData.DIV_CODE1,
                            DIV_CODE2 = formData.DIV_CODE2,
                            TITLE = formData.TITLE,
                            CONTENT_S = formData.CONTENT_S,
                            CONTENT_F = formData.CONTENT_F,

                            //IMAGE1_ORG_NAME = formData.IMAGE1_ORG_NAME,
                            //IMAGE1_SAVE_NAME = formData.IMAGE1_SAVE_NAME,
                            //IMAGE1_SIZE = formData.IMAGE1_SIZE,

                            ATTACH1_ORG_NAME = formData.ATTACH1_ORG_NAME,
                            ATTACH1_SAVE_NAME = formData.ATTACH1_SAVE_NAME,
                            ATTACH1_SIZE = formData.ATTACH1_SIZE,

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
        //public ActionResult edit(supportViewModel formData, HttpPostedFileBase attachedImage = null, HttpPostedFileBase attachedFile = null)
        public ActionResult edit(supportViewModel formData, HttpPostedFileBase attachedFile = null)
        {
            bool result = false;
            try
            {
                //string oldImageName = string.Empty;
                string oldFileName = string.Empty;

                //if (attachedImage != null)
                //{
                //    string fileName = Functions.GetGuidFileName(attachedImage.FileName);

                //    if (Functions.SaveAttachedImage(attachedImage, fileName))
                //    {
                //        oldImageName = formData.IMAGE1_SAVE_NAME;

                //        formData.IMAGE1_ORG_NAME = attachedImage.FileName;
                //        formData.IMAGE1_SAVE_NAME = fileName;
                //        formData.IMAGE1_SIZE = attachedImage.ContentLength;
                //    }
                //}

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

                            DIV_CODE1 = formData.DIV_CODE1,
                            DIV_CODE2 = formData.DIV_CODE2,
                            TITLE = formData.TITLE,
                            CONTENT_S = formData.CONTENT_S,
                            CONTENT_F = formData.CONTENT_F,

                            //IMAGE1_ORG_NAME = formData.IMAGE1_ORG_NAME,
                            //IMAGE1_SAVE_NAME = formData.IMAGE1_SAVE_NAME,
                            //IMAGE1_SIZE = formData.IMAGE1_SIZE,

                            ATTACH1_ORG_NAME = formData.ATTACH1_ORG_NAME,
                            ATTACH1_SAVE_NAME = formData.ATTACH1_SAVE_NAME,
                            ATTACH1_SIZE = formData.ATTACH1_SIZE,

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
                    //if (!string.IsNullOrEmpty(oldImageName))
                    //    Functions.DeleteSavedImage(oldImageName);

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
        public ActionResult delete(supportViewModel formData)
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
                    //if (!string.IsNullOrEmpty(formData.IMAGE1_SAVE_NAME))
                    //    Functions.DeleteSavedImage(formData.IMAGE1_SAVE_NAME);

                    if (!string.IsNullOrEmpty(formData.ATTACH1_SAVE_NAME))
                        Functions.DeleteSavedFile(formData.ATTACH1_SAVE_NAME);
                }
            }
            catch(Exception ex)
            {
                SetViewMessageException(ex.Message);
            }

            if (result)
                return RedirectToAction("list");
            else
                return RedirectToAction("view", new { id = formData.IDX });
        }

        //[HttpPost, ValidateInput(false)]
        //[ValidateAntiForgeryToken]
        //public ActionResult deleteimage(supportViewModel formData)
        //{
        //    bool result = false;

        //    try
        //    {
        //        using (var conn = Functions.ConnectionDefault)
        //        {
        //            conn.Open();

        //            var execResult = conn.ExecuteScalar("dbo.GCMASTER_BOARD_COMMON_DELETE_FILE_UPD",
        //                param: new
        //                {
        //                    TYPE = _pageType,
        //                    IDX = formData.IDX,
        //                    FILE_FLAG = "I1",

        //                    UPDATE_IDX = this.AdminProfile.IDX
        //                },
        //                commandType: CommandType.StoredProcedure
        //            );

        //            if (execResult != null)
        //                result = Convert.ToInt32(execResult) > 0;
        //        }

        //        SetViewMessageBoardDeleteImage(result);

        //        if (result)
        //        {
        //            if (!string.IsNullOrEmpty(formData.IMAGE1_SAVE_NAME))
        //                Functions.DeleteSavedImage(formData.IMAGE1_SAVE_NAME);
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        SetViewMessageException(ex.Message);
        //    }

        //    return RedirectToAction("view", new { id = formData.IDX });
        //}

        [HttpPost, ValidateInput(false)]
        [ValidateAntiForgeryToken]
        public ActionResult deletefile(supportViewModel formData)
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