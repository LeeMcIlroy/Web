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
using GCMaster.Areas.eng.Models;

namespace GCMaster.Areas.eng.Controllers
{
    [Authorize]
    public class clientsController : BaseController
    {
        private readonly int _pageSize = 30;


        public ActionResult list()
        {
            ViewBag.datetype = Request.QueryString["datetype"] ?? "1";
            ViewBag.datepick1 = Request.QueryString["datepick1"] ?? "";
            ViewBag.datepick2 = Request.QueryString["datepick2"] ?? "";
            ViewBag.dateperiod = Request.QueryString["dateperiod"] ?? "A";
            ViewBag.viewtype = Request.QueryString["viewtype"] ?? "A";
            ViewBag.notitype = Request.QueryString["notitype"] ?? "A";

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


            List<clientsModel> lstResult = new List<clientsModel>();

            using (var conn = Functions.ConnectionDefault)
            {
                conn.Open();

                lstResult = conn.Query<clientsModel>("dbo.GCMASTER_ENG_CLIENTS_LIST_SEL",
                    param: new
                    {
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


            ViewBag.keytype = Request.QueryString["subkeytype"] ?? "";
            ViewBag.keyword = HttpUtility.UrlDecode(Request.QueryString["subkeyword"] ?? "");

            int pageNumber = Convert.ToInt16(Request.QueryString["subpage"] ?? "1");

            clientsModel viewData = null;

            using (var conn = Functions.ConnectionDefault)
            {
                conn.Open();

                viewData = conn.Query<clientsModel>("dbo.GCMASTER_ENG_CLIENTS_VIEW_SEL",
                    param: new
                    {
                        IDX = id
                    },
                    commandType: CommandType.StoredProcedure
                )
                .DefaultIfEmpty(new clientsModel()
                {
                    IDX = 0,
                    VIEW_CNT = 0,
                    VIEW_ORDER = 10,
                    NOTI_YN = "N",
                    VIEW_YN = "Y",
                    VIEW_DATE_ST = DateTime.Now.ToString("yyyy-MM-dd"),
                    VIEW_TIME_ST = "00:00",
                    VIEW_DATE_ED = DateTime.Now.ToString("yyyy-MM-dd"),
                    VIEW_TIME_ED = "00:00",
                    REGIST_ID = "master",
                    UPDATE_ID = "master",
                })
                .FirstOrDefault();


               
            }


            return View(viewData);
        }


        [HttpPost, ValidateInput(false)]
        [ValidateAntiForgeryToken]
        public ActionResult create(clientsModel formData, HttpPostedFileBase attachedImage1 = null)
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
          
            try
            {
                using (var conn = Functions.ConnectionDefault)
                {
                    conn.Open();

                    var execResult = conn.ExecuteScalar("dbo.GCMASTER_ENG_CLIENTS_CUD",
                        param: new
                        {
                            CRUD = "I10",
                            TITLE = formData.TITLE,
                            IMAGE1_ORG_NM = formData.IMAGE1_ORG_NM,
                            IMAGE1_SAVE_NM = formData.IMAGE1_SAVE_NM,
                            IMAGE1_SIZE = formData.IMAGE1_SIZE,                 
                            LINK_URL = formData.LINK_URL,
                            VIEW_ORDER = formData.VIEW_ORDER,
                            VIEW_YN = formData.VIEW_YN,
                            NOTI_YN = formData.NOTI_YN,
                            VIEW_DATE_ST = formData.VIEW_DATE_ST,
                            VIEW_TIME_ST = formData.VIEW_TIME_ST,
                            VIEW_DATE_ED = formData.VIEW_DATE_ED,
                            VIEW_TIME_ED = formData.VIEW_TIME_ED,
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
        public ActionResult edit(clientsModel formData, HttpPostedFileBase attachedImage1 = null)
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
          
            try
            {
                using (var conn = Functions.ConnectionDefault)
                {
                    conn.Open();

                    var execResult = conn.ExecuteScalar("dbo.GCMASTER_ENG_CLIENTS_CUD",
                        param: new
                        {
                            CRUD = "U10",
                            IDX = formData.IDX,
                            TITLE = formData.TITLE,

                            IMAGE1_ORG_NM = formData.IMAGE1_ORG_NM,
                            IMAGE1_SAVE_NM = formData.IMAGE1_SAVE_NM,
                            IMAGE1_SIZE = formData.IMAGE1_SIZE,
                      
                            LINK_URL = formData.LINK_URL,
                            VIEW_ORDER = formData.VIEW_ORDER,
                            VIEW_YN = formData.VIEW_YN,
                            NOTI_YN = formData.NOTI_YN,
                            VIEW_DATE_ST = formData.VIEW_DATE_ST,
                            VIEW_TIME_ST = formData.VIEW_TIME_ST,
                            VIEW_DATE_ED = formData.VIEW_DATE_ED,
                            VIEW_TIME_ED = formData.VIEW_TIME_ED,
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

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult delete(networkModel formData)
        {
            bool result = false;
            try
            {
                using (var conn = Functions.ConnectionDefault)
                {
                    conn.Open();

                    var execResult = conn.ExecuteScalar("dbo.GCMASTER_ENG_CLIENTS_CUD",
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
                    if (!string.IsNullOrEmpty(formData.IMAGE2_SAVE_NM))
                        Functions.DeleteSavedImage(formData.IMAGE2_SAVE_NM);

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