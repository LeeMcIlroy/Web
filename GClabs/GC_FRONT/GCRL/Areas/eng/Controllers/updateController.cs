using Dapper;
using GCRL.Areas.eng.Models;
using GCRL.Modules;
using PagedList;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace GCRL.Areas.eng.Controllers
{
    public class updateController : Controller
    {
        // GET: eng/update
        private readonly int _pageSize = 10;
        private readonly string _pageType = PageEnum.EngUpdates.ToCode();   //61

        public ActionResult list()
        {
            ViewBag.keytype = HttpUtility.UrlDecode(Request.QueryString["keytype"] ?? "");
            ViewBag.keyword = HttpUtility.UrlDecode(Request.QueryString["keyword"] ?? "");
            int pageNumber = Convert.ToInt16(Request.QueryString["page"] ?? "1");

            List<updateModel> lstResult = new List<updateModel>();

            using (var conn = Functions.ConnectionDefault)
            {
                conn.Open();

                lstResult = conn.Query<updateModel>("dbo.GCRL_TEST_UPDATES_LIST",
                    param: new
                    {
                        pType = _pageType,
                        pKeyType = ViewBag.keytype ?? "",
                        pKeyWord = ViewBag.keyword ?? ""
                    },
                    commandType: CommandType.StoredProcedure
                ).ToList();
            }

            ViewBag.totalCount = lstResult.Count;

            return View(lstResult.ToPagedList(pageNumber, _pageSize));
        }

        public ActionResult view()
        {
            //if (id == null)
            //    return RedirectToAction("list");
          
            ViewBag.id = HttpUtility.UrlDecode(Request.QueryString["id"] ?? "");
            ViewBag.keytype = HttpUtility.UrlDecode(Request.QueryString["keytype"] ?? "");
            ViewBag.keyword = HttpUtility.UrlDecode(Request.QueryString["keyword"] ?? "");

            updateViewModel viewData = null;

            using (var conn = Functions.ConnectionDefault)
            {
                conn.Open();

                viewData = conn.Query<updateViewModel>("dbo.GCRL_TEST_UPDATES_VIEW",
                    param: new
                    {
                        pIDX = ViewBag.id
                    },
                    commandType: CommandType.StoredProcedure
                )
                .DefaultIfEmpty(new updateViewModel()
                {
                    DIV_CODE1 = "",       // 구분
                    DIV_NAME1 = "",
                    TITLE = "",           // Test item
                    CONTENT_S = "",       // GC Labs code
                    CONTENT_F = "",       // 내용 
                    DIV_DATE1 = "",
                    REGIST_DATE = ""
                })
                .FirstOrDefault();
            }

            return View(viewData);
        }
    }
}