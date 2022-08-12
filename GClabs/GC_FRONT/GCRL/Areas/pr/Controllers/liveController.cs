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
    public class liveController : Controller
    {
        private readonly int _pageSize = 6;

        private readonly string _pageType = PageEnum.PrLive.ToCode();


        public ActionResult list()
        {

            ViewBag.divcode1 = HttpUtility.UrlDecode(Request.QueryString["divcode1"] ?? "");

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
                        pDivCode1 = ViewBag.divcode1 ?? "",
                        pKeyWord = ViewBag.keyword ?? "",
                    },
                    commandType: CommandType.StoredProcedure
                ).ToList();
            }

            //return View(lstResult.Count);
            return View(lstResult.ToPagedList(pageNumber, _pageSize));
        }

        public ActionResult more()
        {

            string divcode1 = HttpUtility.UrlDecode(Request.QueryString["divcode1"] ?? "");

            string keyword = HttpUtility.UrlDecode(Request.QueryString["keyword"] ?? "");

            int rowNo = Convert.ToInt16(Request.QueryString["frno"] ?? "1");


            List<prListModel> lstResult = new List<prListModel>();

            using (var conn = Functions.ConnectionDefault)
            {
                conn.Open();

                lstResult = conn.Query<prListModel>("dbo.GCRL_BOARD_COMMON_MORE_SEL",
                    param: new
                    {
                        pType = _pageType,
                        pDivCode1 = divcode1 ?? "",
                        pKeyWord = keyword ?? "",
                        pRowNo = rowNo,
                        pReadSize = _pageSize
                    },
                    commandType: CommandType.StoredProcedure
                ).ToList();
            }

            return Json(lstResult, JsonRequestBehavior.AllowGet);
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