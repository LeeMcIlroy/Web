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
    [RoutePrefix("SiteMngHome/Info/Notice")]
    public class NoticeController : Controller
    {
        NoticeRepo noticeRepo = new NoticeRepo();
        FileInfoRepo fileInfoRepo = new FileInfoRepo();

        [Route("List")]
        public ActionResult List(Search search)
        {
            dynamic model = new ExpandoObject();
            model.list = noticeRepo.selectListForFront(search);
            model.totalCount = noticeRepo.totalCountForFront(search);

            ViewBag.Search = search;
            return View("~/Views/SiteMngHome/Info/Notice/List.cshtml", model);
        }

        [Route("View")]
        public ActionResult view(Notice n, Search search)
        {
            var alert = TempData["alert"];
            if (alert != null)
            {
                TempData["alert"] = alert;
            }
            dynamic model = new ExpandoObject();

            var list = noticeRepo.selectListForFrontBase();
            var notice = noticeRepo.selectOneExpForFront(new { seq = n.seq });

            var baseNotice = list.Where(x => x.seq == notice.seq).FirstOrDefault();

            var prevNotice = list.Where(x => x.rowNum == baseNotice.rowNum - 1).FirstOrDefault();
            var nextNotice = list.Where(x => x.rowNum == baseNotice.rowNum + 1).FirstOrDefault();

            if(prevNotice != null)
            {
                notice.prevSeq = prevNotice.seq;
                notice.prevTitle = prevNotice.title;
            }

            if(nextNotice != null)
            {
                notice.nextSeq = nextNotice.seq;
                notice.nextTitle = nextNotice.title;
            }

            if (notice != null)
            {
                notice.viewCnt = notice.viewCnt + 1;
                noticeRepo.updateViewCnt(notice);
            }
            model.notice = notice;
            ViewBag.Search = search;
            return View("~/Views/SiteMngHome/Info/Notice/View.cshtml", model);
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
            }
            catch (Exception e)
            {
                LogUtil.MngError(e.ToString());
                // View?seq=@item.seq&inputRegDate=@item.inputRegDate
                TempData["alert"] = "첨부파일에 오류가 있습니다.";
                return Redirect("/SiteMngHome/Info/Notice/View?seq=" + seq + "&inputRegDate=" + inputRegDate);
            }
        }

    }
}