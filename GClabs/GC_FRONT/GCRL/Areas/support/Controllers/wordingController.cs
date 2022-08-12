using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Data;

using GCRL.Modules;
using GCRL.Controllers;
using GCRL.Areas.support.Models;

using Dapper;
using PagedList;

namespace GCRL.Areas.support.Controllers
{
    public class wordingController : Controller
    {
        private readonly int _pageSize = 10;

        private readonly string _pageType = PageEnum.SupportWording.ToCode();

        public ActionResult list()
        {

            ViewBag.keyword = HttpUtility.UrlDecode(Request.QueryString["keyword"] ?? "");
            ViewBag.firstletter = HttpUtility.UrlDecode(Request.QueryString["firstletter"] ?? "");

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
                        pFL = ViewBag.firstletter ?? ""
                    },
                    commandType: CommandType.StoredProcedure
                ).ToList();
            }

            return View(lstResult.ToPagedList(pageNumber, _pageSize));
        }
    }
}