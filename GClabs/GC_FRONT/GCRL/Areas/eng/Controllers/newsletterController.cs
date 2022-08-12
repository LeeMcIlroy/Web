using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Data;

using GCRL.Modules;
using GCRL.Areas.eng.Models;

using Dapper;
using PagedList;

namespace GCRL.Areas.eng.Controllers
{
    public class newsletterController : Controller
    {
        private readonly int _pageSize = 6;

        private readonly string _pageType = PageEnum.EngNewsletters.ToCode();


        public ActionResult list()
        {
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

            engViewModel viewdata = null;

            using (var conn = Functions.ConnectionDefault)
            {
                conn.Open();

                viewdata = conn.QueryFirst<engViewModel>("dbo.GCRL_BOARD_COMMON_VIEW_SEL",
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
    }
}