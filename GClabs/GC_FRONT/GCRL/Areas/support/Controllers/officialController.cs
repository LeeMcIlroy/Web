using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Data;

using GCRL.Modules;
using GCRL.Areas.support.Models;

using Dapper;
using PagedList;

namespace GCRL.Areas.support.Controllers
{
    public class officialController : Controller
    {
        private readonly int _pageSize = 10;

        private readonly string _pageType = PageEnum.SupportOfficial.ToCode();

        public ActionResult list()
        {
            ViewBag.keyword = HttpUtility.UrlDecode(Request.QueryString["keyword"] ?? "");

            int pageNumber = Convert.ToInt16(Request.QueryString["page"] ?? "1");


            List<supportListModel> lstResult = new List<supportListModel>();

            using (var conn = Functions.ConnectionDefault)
            {
                conn.Open();

                lstResult = conn.Query<supportListModel>("dbo.GCRL_BOARD_COMMON_LIST_SEL",
                    param: new
                    {
                        pType = _pageType,
                        pKeyWord = ViewBag.keyword ?? "",
                    },
                    commandType: CommandType.StoredProcedure
                ).ToList();
            }

            ViewBag.NotiList = lstResult.Where(w => w.NOTI_YN == (string.IsNullOrEmpty(ViewBag.keyword) ? "Y" : "X")).ToList();

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

                viewdata = conn.QueryFirst<supportViewModel>("dbo.GCRL_BOARD_COMMON_VIEW_SEL",
                    param: new
                    {
                        pType = _pageType,
                        pIDX = id
                    },
                    commandType: CommandType.StoredProcedure
                );
            }

            return View(viewdata);
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="filesname">File Saved Name</param>
        /// <param name="fileoname">File Original Name</param>
        /// <returns></returns>
        /// <exception cref="ArgumentNullException"></exception>
        public FileResult download(string filesname, string fileoname)
        {
            if (filesname == null)
                throw new ArgumentNullException("filesname");

            if (fileoname == null || fileoname == "")
                fileoname = filesname;

            byte[] fileBytes = Functions.GetFileBytes(filesname);

            return File(fileBytes, System.Net.Mime.MediaTypeNames.Application.Octet, fileoname);

        }
    }
}