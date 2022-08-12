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
    public class visualController : BaseController
    {
        private readonly int _pageSize = 30;


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


            List<visualModel> lstResult = new List<visualModel>();

            using (var conn = Functions.ConnectionDefault)
            {
                conn.Open();

                lstResult = conn.Query<visualModel>("dbo.GCMASTER_BOARD_MAIN_VISUAL_LIST_SEL",
                    param: new
                    {
                       
                       
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

            visualModel viewdata = null;

            using (var conn = Functions.ConnectionDefault)
            {
                conn.Open();

                viewdata = conn.Query<visualModel>("dbo.GCMASTER_BOARD_MAIN_VISUAL_VIEW_SEL",
                    param: new
                    {
                        IDX = id
                    },
                    commandType: CommandType.StoredProcedure
                )
                .DefaultIfEmpty(new visualModel()
                {
                    IDX = 0,
                    TITLE = "",
                    IMG_ALT = "",
                    VIEW_YN = "Y",
                    DEVI_CLS = "P",
                    VIEW_ORDER =10,
                    LANG_CLS = "KOR",
                    LINK_URL = "",
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
        public ActionResult create(visualModel formData, HttpPostedFileBase attachedImage1 = null/*,HttpPostedFileBase attachedImage2 = null*/)
        {

            bool result = false;

            if (attachedImage1 != null)
            {
                string fileName = Functions.GetGuidFileName(attachedImage1.FileName);

                if (Functions.SaveAttachedImage(attachedImage1, fileName))
                {
                    formData.IMAGE1_ORG_NM = attachedImage1.FileName;
                    formData.IMAGE1_SAVE_NM = fileName;
                    formData.IMAGE1_SIZE = attachedImage1.ContentLength;
                }

            }
            //if (attachedImage2 != null)
            //{
            //    string fileName = Functions.GetGuidFileName(attachedImage2.FileName);

            //    if (Functions.SaveAttachedImage(attachedImage2, fileName))
            //    {
            //        formData.IMAGE2_ORG_NM = attachedImage2.FileName;
            //        formData.IMAGE2_SAVE_NM = fileName;
            //        formData.IMAGE2_SIZE = attachedImage2.ContentLength;
            //    }

            //}
            try
            {
                using (var conn = Functions.ConnectionDefault)
                {
                    conn.Open();

                    var execResult = conn.ExecuteScalar("dbo.GCMASTER_BOARD_MAIN_VISUAL_CUD",
                        param: new
                        {
                            CRUD = "I10",
                            TITLE = formData.TITLE,
                            IMG_ALT = formData.IMG_ALT,
                            IMAGE1_ORG_NM = formData.IMAGE1_ORG_NM,
                            IMAGE1_SAVE_NM = formData.IMAGE1_SAVE_NM,
                            IMAGE1_SIZE = formData.IMAGE1_SIZE,
                            //IMAGE2_ORG_NM = formData.IMAGE2_ORG_NM,
                            //IMAGE2_SAVE_NM = formData.IMAGE2_SAVE_NM,
                            //IMAGE2_SIZE = formData.IMAGE2_SIZE,
                            VIEW_YN = formData.VIEW_YN,
                            VIEW_ORDER = formData.VIEW_ORDER,
                            LANG_CLS = formData.LANG_CLS,
                            DEVI_CLS = formData.DEVI_CLS,
                            LINK_URL = formData.LINK_URL,

                            REGIST_ID = formData.REGIST_ID ?? "master",
                            UPDATE_ID = formData.UPDATE_ID ?? "master",

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
        public ActionResult edit(visualModel formData, HttpPostedFileBase attachedImage1 = null, HttpPostedFileBase attachedImage2 = null)
        {
            bool result = false;

            string oldImage1Name = string.Empty;
            string oldImage2Name = string.Empty;

            if (attachedImage1 != null)
            {
                string file1Name = Functions.GetGuidFileName(attachedImage1.FileName);

                if (Functions.SaveAttachedImage(attachedImage1, file1Name))
                {
                    oldImage1Name = formData.IMAGE1_SAVE_NM;

                    formData.IMAGE1_ORG_NM = attachedImage1.FileName;
                    formData.IMAGE1_SAVE_NM = file1Name;
                    formData.IMAGE1_SIZE = attachedImage1.ContentLength;
                }

            }
            //if (attachedImage2 != null)
            //{
            //    string file2Name = Functions.GetGuidFileName(attachedImage2.FileName);

            //    if (Functions.SaveAttachedImage(attachedImage2, file2Name))
            //    {
            //        oldImage2Name = formData.IMAGE2_SAVE_NM;

            //        formData.IMAGE2_ORG_NM = attachedImage2.FileName;
            //        formData.IMAGE2_SAVE_NM = file2Name;
            //        formData.IMAGE2_SIZE = attachedImage2.ContentLength;
            //    }
            //}
                try
                {
                    using (var conn = Functions.ConnectionDefault)
                    {
                        conn.Open();

                        var execResult = conn.ExecuteScalar("dbo.GCMASTER_BOARD_MAIN_VISUAL_CUD",
                            param: new
                            {
                                CRUD = "U10",
                                IDX = formData.IDX,
                                TITLE = formData.TITLE,
                                IMG_ALT = formData.IMG_ALT,
                                IMAGE1_ORG_NM = formData.IMAGE1_ORG_NM,
                                IMAGE1_SAVE_NM = formData.IMAGE1_SAVE_NM,
                                IMAGE1_SIZE = formData.IMAGE1_SIZE,
                                //IMAGE2_ORG_NM = formData.IMAGE2_ORG_NM,
                                //IMAGE2_SAVE_NM = formData.IMAGE2_SAVE_NM,
                                //IMAGE2_SIZE = formData.IMAGE2_SIZE,
                                VIEW_YN = formData.VIEW_YN,
                                VIEW_ORDER = formData.VIEW_ORDER,
                                LANG_CLS = formData.LANG_CLS,
                                DEVI_CLS = formData.DEVI_CLS,
                                LINK_URL = formData.LINK_URL,

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
                        if (!string.IsNullOrEmpty(oldImage1Name))
                            Functions.DeleteSavedImage(oldImage1Name);

                        if (!string.IsNullOrEmpty(oldImage2Name))
                            Functions.DeleteSavedImage(oldImage2Name);
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
        public ActionResult delete(visualModel formData)
        {
            bool result = false;
            try
            {
                using (var conn = Functions.ConnectionDefault)
                {
                    conn.Open();

                    var execResult = conn.ExecuteScalar("dbo.GCMASTER_BOARD_MAIN_VISUAL_CUD",
                        param: new
                        {
                            CRUD = "D10",
                            IDX = formData.IDX,

                        },
                        commandType: CommandType.StoredProcedure
                    );

                    if (execResult != null)
                        result = Convert.ToInt32(execResult) > 0;
                }

                SetViewMessageBoardDelete(result);

                if (result)
                {
                    if (!string.IsNullOrEmpty(formData.IMAGE1_SAVE_NM))
                        Functions.DeleteSavedImage(formData.IMAGE1_SAVE_NM);
                    //if (!string.IsNullOrEmpty(formData.IMAGE2_SAVE_NM))
                    //    Functions.DeleteSavedImage(formData.IMAGE2_SAVE_NM);

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
    }
}