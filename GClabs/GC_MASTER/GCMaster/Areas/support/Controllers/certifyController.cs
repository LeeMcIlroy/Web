
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

namespace GCMaster.Areas.support.Controllers
{
    [Authorize]
    public class certifyController : BaseController
    {
        private readonly int _pageSize = 10;

        private readonly string _pageType = PageEnum.SupportCertify.ToCode();

        // GET: test/equipment
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


            List<certifyListModel> lstResult = new List<certifyListModel>();

            using (var conn = Functions.ConnectionDefault)
            {
                conn.Open();

                lstResult = conn.Query<certifyListModel>("dbo.GCMASTER_SUPPORT_CERTIFY_LIST_SEL",
                    param: new
                    {
                        pType = _pageType,
                        pDateType = ViewBag.datetype ?? "1",
                        pDatePick1 = ViewBag.datepick1,
                        pDatePick2 = ViewBag.datepick2,
                        pDatePeriod = ViewBag.dateperiod ?? "A",
                        pViewYN = ViewBag.viewtype ?? "A",
                        pNotiYN = ViewBag.notitype ?? "A",
                        pCategoryCode = ViewBag.divcode1 ?? "",
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

            certifyViewModel viewData = null;

            using (var conn = Functions.ConnectionDefault)
            {
                conn.Open();

                viewData = conn.Query<certifyViewModel>("dbo.GCMASTER_SUPPORT_CERTIFY_VIEW_SEL",
                    param: new
                    {
                        pType = _pageType,
                        pIDX = id
                    },
                    commandType: CommandType.StoredProcedure
                )
                .DefaultIfEmpty(new certifyViewModel()
                {
                    IDX = 0,

                    CATEGORY_CODE = "010",

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
        public ActionResult create(certifyViewModel formData, HttpPostedFileBase attachedImage, HttpPostedFileBase attachedFile = null)
        {

            bool result = false;

            try
            {
                if (attachedImage != null)
                {
                    string fileName = Functions.GetGuidFileName(attachedImage.FileName);

                    if (Functions.SaveAttachedImage(attachedImage, fileName))
                    {
                        formData.IMAGE_ORG_NAME = attachedImage.FileName;
                        formData.IMAGE_SAVE_NAME = fileName;
                        formData.IMAGE_SIZE = attachedImage.ContentLength;
                    }
                }

                if (attachedFile != null)
                {
                    string fileName = Functions.GetGuidFileName(attachedFile.FileName);

                    if (Functions.SaveAttachedFile(attachedFile, fileName))
                    {
                        formData.ATTACH_ORG_NAME = attachedFile.FileName;
                        formData.ATTACH_SAVE_NAME = fileName;
                        formData.ATTACH_SIZE = attachedFile.ContentLength;
                    }
                }

                using (var conn = Functions.ConnectionDefault)
                {
                    conn.Open();

                    var execResult = conn.ExecuteScalar("dbo.GCMASTER_SUPPORT_CERTIFY_CREATE_UPD",
                        param: new
                        {
                            TYPE = _pageType,
                            VIEW_ORDER = formData.VIEW_ORDER,
                            VIEW_YN = formData.VIEW_YN,
                            VIEW_DATE_YMD = formData.VIEW_DATE_YMD,
                            VIEW_DATE_HM = formData.VIEW_DATE_HM,
                            NOTI_YN = formData.NOTI_YN,

                            CATEGORY_CODE = formData.CATEGORY_CODE,
                            CERTIFY_NAME = formData.CERTIFY_NAME,
                            PROGRAM_NAME = formData.PROGRAM_NAME,
                            COUNTRY_NAME = formData.COUNTRY_NAME,
                            ISSUER_NAME = formData.ISSUER_NAME,
                            ISSUE_DATE = formData.ISSUE_DATE,
                            CERTIFY_CONTENT = formData.CERTIFY_CONTENT,
                            ANALYSIS_ITEM = formData.ANALYSIS_ITEM,

                            IMAGE_ORG_NAME = formData.IMAGE_ORG_NAME,
                            IMAGE_SAVE_NAME = formData.IMAGE_SAVE_NAME,
                            IMAGE_SIZE = formData.IMAGE_SIZE,

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
                return RedirectToAction("list");
            else
                return RedirectToAction("view", new { id = 0 });
        }

        [HttpPost, ValidateInput(false)]
        [ValidateAntiForgeryToken]
        public ActionResult edit(certifyViewModel formData, HttpPostedFileBase attachedImage = null, HttpPostedFileBase attachedFile = null)
        {
            bool result = false;
            try
            {
                string oldImageName = string.Empty;
                string oldFileName = string.Empty;

                if (attachedImage != null)
                {
                    string fileName = Functions.GetGuidFileName(attachedImage.FileName);

                    if (Functions.SaveAttachedImage(attachedImage, fileName))
                    {
                        oldImageName = formData.IMAGE_SAVE_NAME;

                        formData.IMAGE_ORG_NAME = attachedImage.FileName;
                        formData.IMAGE_SAVE_NAME = fileName;
                        formData.IMAGE_SIZE = attachedImage.ContentLength;
                    }
                }

                if (attachedFile != null)
                {
                    string fileName = Functions.GetGuidFileName(attachedFile.FileName);

                    if (Functions.SaveAttachedFile(attachedFile, fileName))
                    {
                        oldFileName = formData.ATTACH_SAVE_NAME;

                        formData.ATTACH_ORG_NAME = attachedFile.FileName;
                        formData.ATTACH_SAVE_NAME = fileName;
                        formData.ATTACH_SIZE = attachedFile.ContentLength;
                    }
                }

                using (var conn = Functions.ConnectionDefault)
                {
                    conn.Open();

                    var execResult = conn.ExecuteScalar("dbo.GCMASTER_SUPPORT_CERTIFY_EDIT_UPD",
                        param: new
                        {
                            TYPE = _pageType,
                            IDX = formData.IDX,
                            VIEW_ORDER = formData.VIEW_ORDER,
                            VIEW_YN = formData.VIEW_YN,
                            VIEW_DATE_YMD = formData.VIEW_DATE_YMD,
                            VIEW_DATE_HM = formData.VIEW_DATE_HM,
                            NOTI_YN = formData.NOTI_YN,

                            CATEGORY_CODE = formData.CATEGORY_CODE,
                            CERTIFY_NAME = formData.CERTIFY_NAME,
                            PROGRAM_NAME = formData.PROGRAM_NAME,
                            COUNTRY_NAME = formData.COUNTRY_NAME,
                            ISSUER_NAME = formData.ISSUER_NAME,
                            ISSUE_DATE = formData.ISSUE_DATE,
                            CERTIFY_CONTENT = formData.CERTIFY_CONTENT,
                            ANALYSIS_ITEM = formData.ANALYSIS_ITEM,

                            IMAGE_ORG_NAME = formData.IMAGE_ORG_NAME,
                            IMAGE_SAVE_NAME = formData.IMAGE_SAVE_NAME,
                            IMAGE_SIZE = formData.IMAGE_SIZE,

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
                    if (!string.IsNullOrEmpty(oldImageName))
                        Functions.DeleteSavedImage(oldImageName);

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
        public ActionResult delete(certifyViewModel formData)
        {
            bool result = false;
            try
            {
                using (var conn = Functions.ConnectionDefault)
                {
                    conn.Open();

                    var execResult = conn.ExecuteScalar("dbo.GCMASTER_SUPPORT_CERTIFY_DELETE_DEL",
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
                    if (!string.IsNullOrEmpty(formData.IMAGE_SAVE_NAME))
                        Functions.DeleteSavedImage(formData.IMAGE_SAVE_NAME);

                    if (!string.IsNullOrEmpty(formData.ATTACH_SAVE_NAME))
                        Functions.DeleteSavedFile(formData.ATTACH_SAVE_NAME);
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
        public ActionResult deletefile(certifyViewModel formData)
        {
            bool result = false;

            try
            {
                using (var conn = Functions.ConnectionDefault)
                {
                    conn.Open();

                    var execResult = conn.ExecuteScalar("dbo.GCMASTER_SUPPORT_CERTIFY_DELETE_FILE_UPD",
                        param: new
                        {
                            TYPE = _pageType,
                            IDX = formData.IDX,

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
                    if (!string.IsNullOrEmpty(formData.ATTACH_SAVE_NAME))
                        Functions.DeleteSavedFile(formData.ATTACH_SAVE_NAME);
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