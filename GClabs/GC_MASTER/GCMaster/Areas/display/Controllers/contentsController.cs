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
using GCMaster.Areas.display.Models;

namespace GCMaster.Areas.display.Controllers
{
    [Authorize]
    public class contentsController : BaseController
    {
        private readonly int _pageSize = 30;

        private readonly string _pageType = PageEnum.DisplayContents.ToCode();

        public ActionResult list()
        {
            ViewBag.viewtype = Request.QueryString["viewtype"] ?? "A";
            ViewBag.divcode1 = Request.QueryString["divcode1"] ?? "";

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


            List<contentsModel> lstResult = new List<contentsModel>();

            using (var conn = Functions.ConnectionDefault)
            {
                conn.Open();

                lstResult = conn.Query<contentsModel>("dbo.GCMASTER_BOARD_MAIN_CONTENTS_LIST_SEL",
                    param: new
                    {
                        PTYPE = _pageType,
                    
                    },
                    commandType: CommandType.StoredProcedure
                ).ToList();
            }

            ViewBag.CategoryCodes = Functions.GetSelectListItems(groupCode: "main_div");

            return View(lstResult.ToPagedList(pageNumber, _pageSize));
        }

        public ActionResult view(int? id)
        {
            if (id == null)
                return RedirectToAction("list");

            ViewBag.COMM_CD = Request.QueryString["COMM_CD"] ?? "";
            ViewBag.LANG = Request.QueryString["LANG_CLS"] ?? "";
            ViewBag.DEVI = Request.QueryString["DEVI_CLS"] ?? "";

            contentsModel viewdata = null;

            using (var conn = Functions.ConnectionDefault)
            {
                conn.Open();

                viewdata = conn.Query<contentsModel>("dbo.GCMASTER_BOARD_MAIN_CONTENTS_VIEW_SEL",
                    param: new
                    {
                        pType = _pageType,
                        COMM_CD = ViewBag.COMM_CD,
                        LANG_CLS = ViewBag.LANG,
                        DEVI_CLS = ViewBag.DEVI

                    },
                    commandType: CommandType.StoredProcedure
                )
                .DefaultIfEmpty(new contentsModel()
                {
                    TYPE = "",
                    IDX = 0,
                    TITLE_1 = "",
                    TITLE_2 = "",
                    VIEW_YN = "Y",
                    LANG_CLS = "KOR",
                    REGIST_ID = "master",
                    REGIST_NAME = "관리자",
                    UPDATE_ID = "master",
                    UPDATE_NAME = "관리자",
                    REGIST_DATE = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"),
                    UPDATE_DATE = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")

                  
                })
                .FirstOrDefault();
            }

            return View(viewdata);
        }


        [HttpPost, ValidateInput(false)]
        [ValidateAntiForgeryToken]
        public ActionResult create(contentsModel formData, HttpPostedFileBase attachedImage)
        {

            bool result = false;

            if (attachedImage != null)
            {
                string fileName = Functions.GetGuidFileName(attachedImage.FileName);

                if (Functions.SaveAttachedImage(attachedImage, fileName))
                {
                    formData.IMAGE_ORG_NM = attachedImage.FileName;
                    formData.IMAGE_SAVE_NM = fileName;
                    formData.IMAGE_SIZE = attachedImage.ContentLength;
                }
            }

            try
            {
                using (var conn = Functions.ConnectionDefault)
                {
                    conn.Open();

                    var execResult = conn.ExecuteScalar("dbo.GCMASTER_BOARD_MAIN_CONTENTS_CUD",
                        param: new
                        {
                            CRUD = "I10",
                            IDX = formData.IDX,
                            TYPE = _pageType,
                            CONTENT_CLS =formData.COMM_CD,
                            LANG_CLS = formData.LANG_CLS,
                            DEVI_CLS = formData.DEVI_CLS,
                            SUBJECT = formData.SUBJECT,
                            TITLE_1 = formData.TITLE_1,
                            TITLE_2 = formData.TITLE_2,
                            LINK_URL = formData.LINK_URL,
                            IMAGE_ORG_NM = formData.IMAGE_ORG_NM,
                            IMAGE_SAVE_NM = formData.IMAGE_SAVE_NM,
                            IMAGE_SIZE = formData.IMAGE_SIZE,
                            VIEW_YN = formData.VIEW_YN,
                            REGIST_ID = formData.REGIST_ID ?? "master",
                           // REGIST_DATE = formData.REGIST_DATE ?? DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"),
                            UPDATE_ID = formData.UPDATE_ID ?? "master",
                            //UPDATE_DATE = formData.UPDATE_DATE ?? DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")


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
        public ActionResult edit(contentsModel formData, HttpPostedFileBase attachedImage)
        {
            bool result = false;

            string oldImageName = string.Empty;

            if (attachedImage != null)
            {
                string fileName = Functions.GetGuidFileName(attachedImage.FileName);

                if (Functions.SaveAttachedImage(attachedImage, fileName))
                {
                    oldImageName = formData.IMAGE_SAVE_NM;

                    formData.IMAGE_ORG_NM = attachedImage.FileName;
                    formData.IMAGE_SAVE_NM = fileName;
                    formData.IMAGE_SIZE = attachedImage.ContentLength;
                }
            }
            try
            {
                using (var conn = Functions.ConnectionDefault)
                {
                    conn.Open();

                    var execResult = conn.ExecuteScalar("dbo.GCMASTER_BOARD_MAIN_CONTENTS_CUD",
                        param: new
                        {
                            CRUD = "U10",
                            IDX = formData.IDX,
                            TYPE = _pageType,
                            CONTENT_CLS = formData.COMM_CD,
                            LANG_CLS = formData.LANG_CLS,
                            DEVI_CLS = formData.DEVI_CLS,
                            SUBJECT = formData.SUBJECT,
                            TITLE_1 = formData.TITLE_1,
                            TITLE_2 = formData.TITLE_2,
                            LINK_URL = formData.LINK_URL,
                            IMAGE_ORG_NM = formData.IMAGE_ORG_NM,
                            IMAGE_SAVE_NM = formData.IMAGE_SAVE_NM,
                            IMAGE_SIZE = formData.IMAGE_SIZE,
                            VIEW_YN = formData.VIEW_YN,
                            REGIST_ID = formData.REGIST_ID ?? "master",
                            UPDATE_ID = formData.UPDATE_ID ?? "master",

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
        public ActionResult delete(contentsModel formData)
        {
            bool result = false;
            try
            {
                using (var conn = Functions.ConnectionDefault)
                {
                    conn.Open();

                    var execResult = conn.ExecuteScalar("dbo.GCMASTER_BOARD_MAIN_CONTENTS_CUD",
                        param: new
                        {
                            CRUD = "D10",
                            IDX = formData.IDX,
                            TYPE = _pageType,
                            CONTENT_CLS = formData.COMM_CD

                        },
                        commandType: CommandType.StoredProcedure
                    );

                    if (execResult != null)
                        result = Convert.ToInt32(execResult) > 0;
                }

                SetViewMessageBoardDelete(result);

                if (result)
                {
                    if (!string.IsNullOrEmpty(formData.IMAGE_SAVE_NM))
                        Functions.DeleteSavedImage(formData.IMAGE_SAVE_NM);

                   
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
        public ActionResult deleteimage(contentsModel formData)
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
                            FILE_FLAG = "I1",

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
                    if (!string.IsNullOrEmpty(formData.IMAGE_SAVE_NM))
                        Functions.DeleteSavedImage(formData.IMAGE_SAVE_NM);
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