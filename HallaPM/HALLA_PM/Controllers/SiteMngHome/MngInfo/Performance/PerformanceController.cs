using HALLA_PM.Models;
using HALLA_PM.Util;
using System;
using System.Collections.Generic;
using System.Dynamic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using HALLA_PM.Core;


namespace HALLA_PM.Controllers.SiteMngHome
{
    [AdminLoginFilter]
    [AuthAdminFilter(RequestAuthLevel = 1)]
    [RoutePrefix("SiteMngHome/MngInfo/Performance")]
    public class AppNoticeController : Controller
    {
        BusinessPerformanceRepo businessPerformanceRepo = new BusinessPerformanceRepo();
        FileInfoRepo fileInfoRepo = new FileInfoRepo();

        [Route("List")]
        public ActionResult List(Search search)
        {
            dynamic model = new ExpandoObject();

            /*
            if (string.IsNullOrEmpty(search.searchText))
            {
                search.searchText = DateTime.Now.ToString("yyyy"); 
            }
            if (string.IsNullOrEmpty(search.searchText1))
            {
                search.searchText1 = DateTime.Now.ToString("MM");
            }
            */
            model.list = businessPerformanceRepo.selectList(search);
            model.totalCount = businessPerformanceRepo.totalCount(search);

            ViewBag.Search = search;
            return View("~/Views/SiteMngHome/MngInfo/Performance/List.cshtml", model);
        }

        [Route("Write")]
        public ActionResult Write(Search search)
        {
            ViewBag.Search = search;
            return View("~/Views/SiteMngHome/MngInfo/Performance/Write.cshtml");
        }

        [HttpPost]
        [AcceptVerbs(HttpVerbs.Post), ValidateInput(false)]
        [Route("writeAction")]
        public ActionResult writeAction(BusinessPerformance businessPerformance, Search search)
        {
            BusinessPerformance info = businessPerformanceRepo.availableCheckInfo(businessPerformance);
            if(info == null)
            {
                int seq = 0;
                if ((seq = businessPerformanceRepo.save(businessPerformance)) == -1)
                {
                    TempData["alert"] = "등록에 실패하였습니다.";
                }
                else
                {
                    TempData["alert"] = "등록 되었습니다.";
                    fileInfoRepo.attachFileDevelop(Request.Files, "BUSINESS_PERFORMANCE", seq, "businessPerformance");
                }

            }else
            {
                TempData["alert"] = "중복된 게시글이 있습니다.";
            }
            return RedirectToAction("List", search);
        }

        [Route("View")]
        public ActionResult view()
        {
            return View("~/Views/SiteMngHome/MngInfo/Performance/View.cshtml");
        }

        [Route("Edit")]
        public ActionResult Edit(int seq, Search search)
        {

            dynamic model = new ExpandoObject();
            model.businessPerformance = businessPerformanceRepo.selectOneExp(new { seq });
            ViewBag.Search = search;
            return View("~/Views/SiteMngHome/MngInfo/Performance/Edit.cshtml", model);
        }

        [HttpPost]
        [AcceptVerbs(HttpVerbs.Post), ValidateInput(false)]
        [Route("editAction")]
        public ActionResult editAction(BusinessPerformance businessPerformance, Search search)
        {
            BusinessPerformance info = businessPerformanceRepo.availableCheckInfo(businessPerformance);
            if (info == null)
            {
                int seq = 0;
                if ((seq = businessPerformanceRepo.save(businessPerformance)) == -1)
                {
                    TempData["alert"] = "수정에 실패하였습니다.";
                }
                else
                {
                    TempData["alert"] = "수정 되었습니다.";
                    fileInfoRepo.attachFileDevelop(Request.Files, "BUSINESS_PERFORMANCE", seq, "businessPerformance");
                }

            }
            else
            {
                if(info.seq == businessPerformance.seq)
                {
                    int seq = 0;
                    if ((seq = businessPerformanceRepo.save(businessPerformance)) == -1)
                    {
                        TempData["alert"] = "수정에 실패하였습니다.";
                    }
                    else
                    {
                        TempData["alert"] = "수정 되었습니다.";
                        fileInfoRepo.attachFileDevelop(Request.Files, "BUSINESS_PERFORMANCE", info.seq, "businessPerformance");
                    }
                }
                else
                {
                    TempData["alert"] = "중복된 게시글이 있습니다.";
                }
            }
            return RedirectToAction("List", search);
        }



        [HttpPost]
        [Route("deleteAction")]
        public ActionResult deleteAction(int seq, Search search)
        {
            if (businessPerformanceRepo.delete(new { seq }) == -1)
            {
                TempData["alert"] = "삭제에 실패하였습니다.";
            }
            else
            {
                TempData["alert"] = "삭제 되었습니다.";
                fileInfoRepo.deleteTableSeq(new FileInfo { attachTableName = "BUSINESS_PERFORMANCE", attachTableSeq = seq });
            }
            return RedirectToAction("List", search);
        }

        [HttpPost]
        [Route("deleteFileAction")]
        public JsonResult deleteFileAction(int seq, string inputName)
        {
            bool result = false;
            var procCnt = fileInfoRepo.deleteTableSeqAndInputName(new FileInfo { attachTableName = "BUSINESS_PERFORMANCE", attachTableSeq = seq, fileInputName = inputName });
            if (procCnt > 0)
            {
                result = true;
            }
            return Json(new { success = result }, JsonRequestBehavior.AllowGet);

        }

    }
}