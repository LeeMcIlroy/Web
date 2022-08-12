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
    [AuthAdminFilter(RequestAuthLevel = 3)]
    [RoutePrefix("SiteMngHome/Info/Reference")]
    public class ReferenceController : Controller
    {
        ReferenceRepo referenceRepo = new ReferenceRepo();
        FileInfoRepo fileInfoRepo = new FileInfoRepo();

        [Route("List")]
        public ActionResult List(Search search)
        {
            dynamic model = new ExpandoObject();
            model.list = referenceRepo.selectListForFront(search);
            model.totalCount = referenceRepo.totalCountForFront(search);

            ViewBag.Search = search;
            return View("~/Views/SiteMngHome/Info/Reference/List.cshtml", model);
        }

        [Route("View")]
        public ActionResult view(Reference r, Search search)
        {
            var alert = TempData["alert"];
            if(alert != null)
            {
                TempData["alert"] = alert;
            }
            dynamic model = new ExpandoObject();

            var list = referenceRepo.selectListForFrontBase();
            var reference = referenceRepo.selectOneExpForFront(new { seq = r.seq });

            var baseReference = list.Where(x => x.seq == reference.seq).FirstOrDefault();

            var prevReference = list.Where(x => x.rowNum == baseReference.rowNum - 1).FirstOrDefault();
            var nextReference = list.Where(x => x.rowNum == baseReference.rowNum + 1).FirstOrDefault();

            if(prevReference != null)
            {
                reference.prevSeq = prevReference.seq;
                reference.prevTitle = prevReference.title;
            }

            if(nextReference != null)
            {
                reference.nextSeq = nextReference.seq;
                reference.nextTitle = nextReference.title;
            }


            if (reference != null)
            {
                reference.viewCnt = reference.viewCnt + 1;
                referenceRepo.updateViewCnt(reference);
            }
            model.reference = reference;
            ViewBag.Search = search;
            return View("~/Views/SiteMngHome/Info/Reference/View.cshtml", model);
        }

        [Route("FileDownload")]
        public ActionResult FileDownload(int fileInfoSeq, int seq, string inputRegDate)
        {
            var fileInfo = fileInfoRepo.selectOneSeq(new { seq = fileInfoSeq });
            try
            {
                byte[] fileBytes = System.IO.File.ReadAllBytes(Define.FILE_PATH + "/" + fileInfo.filePath + " /" + fileInfo.fileStoredName);
                string fileName = fileInfo.fileOrgName;

                return File(fileBytes, System.Net.Mime.MediaTypeNames.Application.Octet, fileName);
            }catch(Exception e)
            {
                LogUtil.MngError(e.ToString());
                // View?seq=@item.seq&inputRegDate=@item.inputRegDate
                TempData["alert"] = "첨부파일에 오류가 있습니다.";
                return Redirect("/SiteMngHome/Info/Reference/View?seq="+seq+"&inputRegDate="+inputRegDate);
            }
        }

    }
}