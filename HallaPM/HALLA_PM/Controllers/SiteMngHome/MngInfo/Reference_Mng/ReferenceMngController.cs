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
    [RoutePrefix("SiteMngHome/MngInfo/Reference_Mng")]
    public class ReferenceMngController : Controller
    {
        ReferenceRepo referenceRepo = new ReferenceRepo();
        FileInfoRepo fileInfoRepo = new FileInfoRepo();

        [Route("List")]
        public ActionResult List(Search search)
        {
            dynamic model = new ExpandoObject();
            model.list = referenceRepo.selectListExp(search);
            model.totalCount = referenceRepo.totalCount(search);
            ViewBag.Search = search;
            return View("~/Views/SiteMngHome/MngInfo/Reference_Mng/List.cshtml", model);
        }

        [Route("Write")]
        public ActionResult Write(Search search)
        {
            ViewBag.Search = search;
            return View("~/Views/SiteMngHome/MngInfo/Reference_Mng/Write.cshtml");
        }

        [HttpPost]
        [AcceptVerbs(HttpVerbs.Post), ValidateInput(false)]
        [Route("writeAction")]
        public ActionResult writeAction(Reference reference, Search search)
        {
            int seq = 0;
            if ((seq = referenceRepo.save(reference)) == -1)
            {
                TempData["alert"] = "등록에 실패하였습니다.";
            }
            else
            {
                TempData["alert"] = "등록 되었습니다.";
                fileInfoRepo.attachFileDevelop(Request.Files, "REFERENCE", seq, "reference");
            }
            return RedirectToAction("List", search);
        }

        [Route("View")]
        public ActionResult view()
        {
            return View("~/Views/SiteMngHome/MngInfo/Reference_Mng/View.cshtml");
        }

        [Route("Edit")]
        public ActionResult Edit(int seq, Search search)
        {
            dynamic model = new ExpandoObject();
            model.reference = referenceRepo.selectOneExp(new { seq });

            ViewBag.Search = search;
            return View("~/Views/SiteMngHome/MngInfo/Reference_Mng/Edit.cshtml", model);
        }

        [HttpPost]
        [AcceptVerbs(HttpVerbs.Post), ValidateInput(false)]
        [Route("editAction")]
        public ActionResult editAction(Reference reference, Search search)
        {
            int seq = reference.seq;
            if ((referenceRepo.save(reference)) == -1)
            {
                TempData["alert"] = "수정에 실패하였습니다.";
            }
            else
            {
                TempData["alert"] = "수정 되었습니다.";
                fileInfoRepo.attachFileDevelop(Request.Files, "REFERENCE", seq, "reference");
            }
            return RedirectToAction("List", search);
        }



        [HttpPost]
        [Route("deleteAction")]
        public ActionResult deleteAction(int seq, Search search)
        {
            if (referenceRepo.delete(new { seq }) == -1)
            {
                TempData["alert"] = "삭제에 실패하였습니다.";
            }
            else
            {
                TempData["alert"] = "삭제 되었습니다.";
                fileInfoRepo.deleteTableSeq(new FileInfo { attachTableName = "REFERENCE", attachTableSeq = seq });
            }
            return RedirectToAction("List", search);
        }

        [HttpPost]
        [Route("deleteFileAction")]
        public JsonResult deleteFileAction(int seq, string inputName)
        {
            bool result = false;
            var procCnt = fileInfoRepo.deleteTableSeqAndInputName(new FileInfo { attachTableName = "REFERENCE", attachTableSeq = seq, fileInputName = inputName });
            if (procCnt > 0)
            {
                result = true;
            }
            return Json(new { success = result }, JsonRequestBehavior.AllowGet);

        }



    }
}