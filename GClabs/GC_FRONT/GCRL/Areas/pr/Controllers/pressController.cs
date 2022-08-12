using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Data;

using GCRL.Modules;
using GCRL.Areas.pr.Models;

using Dapper;
using PagedList;

namespace GCRL.Areas.pr.Controllers
{
    public class pressController : Controller
    {
        private readonly int _pageSize = 6;

        private readonly string _pageType = PageEnum.PrPress.ToCode();


        public ActionResult list()
        {
            ViewBag.keyword = HttpUtility.UrlDecode(Request.QueryString["keyword"] ?? "");

            int pageNumber = Convert.ToInt16(Request.QueryString["page"] ?? "1");


            List<prListModel> lstResult = new List<prListModel>();

            using (var conn = Functions.ConnectionDefault)
            {
                conn.Open();

                lstResult = conn.Query<prListModel>("dbo.GCRL_BOARD_COMMON_LIST_SEL",
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

            prViewModel viewdata = null;

            using (var conn = Functions.ConnectionDefault)
            {
                conn.Open();

                viewdata = conn.QueryFirst<prViewModel>("dbo.GCRL_BOARD_COMMON_VIEW_SEL",
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