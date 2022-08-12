using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Data;

using GCRL.Modules;
using GCRL.Controllers;
using GCRL.Areas.eng.Models;

using Dapper;
using PagedList;

namespace GCRL.Areas.eng.Controllers
{
    public class formsController : Controller
    {
        //private readonly int _pageSize = 5;

        private readonly string _pageType = PageEnum.EngForms.ToCode();

        public ActionResult list()
        {

            ViewBag.keyword = HttpUtility.UrlDecode(Request.QueryString["keyword"] ?? "");

            //int pageNumber = Convert.ToInt16(Request.QueryString["page"] ?? "1");


            List<engListModel> lstResult = new List<engListModel>();

            using (var conn = Functions.ConnectionDefault)
            {
                conn.Open();

                lstResult = conn.Query<engListModel>("dbo.GCRL_BOARD_COMMON_LIST_SEL",
                    param: new
                    {
                        pType = _pageType,
                        pKeyWord = ViewBag.keyword ?? "",
                    },
                    commandType: CommandType.StoredProcedure
                ).ToList();
            }

            //return View(lstResult.ToPagedList(pageNumber, _pageSize));
            return View(lstResult);
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