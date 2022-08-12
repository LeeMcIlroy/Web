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
    public class popupController : BaseController
    {
        private readonly int _pageSize = 20;

        public ActionResult list()
        {
            int pageNumber = Convert.ToInt16(Request.QueryString["page"] ?? "1");
            List<popupModel> lstResult = new List<popupModel>();

            using (var conn = Functions.ConnectionDefault)
            {
                conn.Open();

                lstResult = conn.Query<popupModel>("dbo.GCMASTER_POPUP_LIST",
                    param: new
                    {
                        CRUD = "R"
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

            popupDetail viewData = new popupDetail();

            using (var conn = Functions.ConnectionDefault)
            {
                conn.Open();

                viewData = conn.Query<popupDetail>("dbo.GCMASTER_POPUP_VIEW",
                    param: new
                    {
                        IDX = (id == 0 ? 0 : id)
                    },
                    commandType: CommandType.StoredProcedure
                )
                .DefaultIfEmpty(new popupDetail() {
                    IDX = Convert.ToInt32(id),
                    VIEW_DATE_ST = DateTime.Now.ToString("yyyy-MM-dd"),
                    VIEW_TIME_ST  = "00:00",
                    VIEW_DATE_ED = DateTime.Now.ToString("yyyy-MM-dd"),
                    VIEW_TIME_ED = "00:00",
                    DVI_TYP = "P",
                    INS_TYP = "E",
                    CLS_TYP = "P",
                    VIEW_YN = "Y",
                    LANG_TYP = "K",
                    INS_USER = "master",
                    INS_USR_NM = "관리자",
                    UPD_USER = "master",
                    UPD_USR_NM = "관리자",
                    INS_DATE = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"),
                    UPD_DATE = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")
                })
                .FirstOrDefault();
            }

            return View(viewData);
        }


        [HttpPost, ValidateInput(false)]
        [ValidateAntiForgeryToken]
        public ActionResult create(popupDetail formData, HttpPostedFileBase attachedImage)
        {
            bool result = false;

            if (attachedImage != null)
            {
                string fileName = Functions.GetGuidFileName(attachedImage.FileName);

                if (Functions.SaveAttachedImage(attachedImage, fileName))
                {
                    formData.IMG = attachedImage.FileName;
                    formData.IMG_NM = fileName;
                    formData.IMG_SIZE = attachedImage.ContentLength;
                }
            }

            try
            {
                using (var conn = Functions.ConnectionDefault)
                {
                    conn.Open();

                    var execResult = conn.ExecuteScalar("dbo.GCMASTER_POPUP_CRUD",
                        param: new
                        {
                            CRUD = "I0",
                            IDX = formData.IDX,
                            DVI_TYP = formData.DVI_TYP,
                            LANG_TYP = formData.LANG_TYP,
                            TITLE = formData.TITLE,
                            CONTENT = formData.CONTENT,
                            VIEW_DATE_ST = formData.VIEW_DATE_ST,
                            VIEW_TIME_ST = formData.VIEW_TIME_ST,
                            VIEW_DATE_ED = formData.VIEW_DATE_ED,
                            VIEW_TIME_ED = formData.VIEW_TIME_ED,
                            WID = formData.WID,
                            HEI = formData.HEI,
                            TOP = formData.TOP,
                            LFT = formData.LFT,
                            CLS_TYP = formData.CLS_TYP,
                            INS_TYP = formData.INS_TYP,
                            IMG = formData.IMG,
                            IMG_NM = formData.IMG_NM,
                            IMG_SIZE = formData.IMG_SIZE,
                            URL = formData.URL,
                            VIEW_YN = formData.VIEW_YN,
                            INS_DATE = formData.INS_DATE ?? DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"),
                            INS_USER = formData.INS_USER ?? "master",
                            UPD_DATE = formData.UPD_DATE ?? DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"),
                            UPD_USER = formData.UPD_USER ?? "master"
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
        public ActionResult edit(popupDetail formData, HttpPostedFileBase attachedImage = null)
        {
            bool result = false;

            try
            {
                string oldImageName = string.Empty;

                if (attachedImage != null)
                {
                    string fileName = Functions.GetGuidFileName(attachedImage.FileName);

                    if (Functions.SaveAttachedImage(attachedImage, fileName))
                    {
                        oldImageName = formData.IMG_NM;

                        formData.IMG = attachedImage.FileName;
                        formData.IMG_NM = fileName;
                        formData.IMG_SIZE = attachedImage.ContentLength;
                    }
                }

                using (var conn = Functions.ConnectionDefault)
                {
                    conn.Open();

                    var execResult = conn.ExecuteScalar("dbo.GCMASTER_POPUP_CRUD",
                        param: new
                        {
                            CRUD = "U0",
                            IDX = formData.IDX,
                            DVI_TYP = formData.DVI_TYP,
                            LANG_TYP = formData.LANG_TYP,
                            TITLE = formData.TITLE,
                            CONTENT = formData.CONTENT,
                            VIEW_DATE_ST = formData.VIEW_DATE_ST,
                            VIEW_TIME_ST = formData.VIEW_TIME_ST,
                            VIEW_DATE_ED = formData.VIEW_DATE_ED,
                            VIEW_TIME_ED = formData.VIEW_TIME_ED,
                            WID = formData.WID,
                            HEI = formData.HEI,
                            TOP = formData.TOP,
                            LFT = formData.LFT,
                            CLS_TYP = formData.CLS_TYP,
                            INS_TYP = formData.INS_TYP,
                            IMG = formData.IMG,
                            IMG_NM = formData.IMG_NM,
                            IMG_SIZE = formData.IMG_SIZE,
                            URL = formData.URL,
                            VIEW_YN = formData.VIEW_YN,
                            INS_DATE = formData.INS_DATE ?? DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"),
                            INS_USER = formData.INS_USER ?? "master",
                            UPD_DATE = formData.UPD_DATE ?? DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"),
                            UPD_USER = formData.UPD_USER ?? "master"
                        },
                        commandType: CommandType.StoredProcedure
                    );

                    if (execResult != null)
                        result = true;
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
        public ActionResult delete(popupDetail formData)
        {
            bool result = false;
            try
            {
                using (var conn = Functions.ConnectionDefault)
                {
                    conn.Open();

                    var execResult = conn.ExecuteScalar("dbo.GCMASTER_POPUP_CRUD",
                        param: new
                        {
                            CRUD = "D0",
                            IDX = formData.IDX
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