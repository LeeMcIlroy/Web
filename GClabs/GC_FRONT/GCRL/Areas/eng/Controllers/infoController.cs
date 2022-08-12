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
    public class infoController : Controller
    {
        private readonly int _pageSize = 5;

        private readonly string _pageType = PageEnum.EngInt.ToCode();

        public ActionResult list()
        {


            ViewBag.divcode1 = HttpUtility.UrlDecode(Request.QueryString["divcode1"] ?? "");
            ViewBag.divcode2 = HttpUtility.UrlDecode(Request.QueryString["divcode2"] ?? "");
            ViewBag.keyword = HttpUtility.UrlDecode(Request.QueryString["keyword"] ?? "");

            int pageNumber = Convert.ToInt16(Request.QueryString["page"] ?? "1");


            List<engListModel> lstResult = new List<engListModel>();

            using (var conn = Functions.ConnectionDefault)
            {
                conn.Open();

                lstResult = conn.Query<engListModel>("dbo.GCRL_BOARD_COMMON_LIST_SEL",
                    param: new
                    {
                        pType = _pageType,
                        pDivCode1 = ViewBag.divcode1 ?? "",
                        pdivCode2 = ViewBag.divcode2 ?? "",
                        pKeyWord = ViewBag.keyword ?? "",
                    },
                    commandType: CommandType.StoredProcedure
                ).ToList();
            }

            return View(lstResult.ToPagedList(pageNumber, _pageSize));
        }
    }
}