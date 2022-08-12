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
    public class clientsController : Controller
    {
        // GET: eng/clients
        public ActionResult list()
        {
            int pageNumber = Convert.ToInt16(Request.QueryString["page"] ?? "1");
            ViewBag.keyword = HttpUtility.UrlDecode(Request.QueryString["keyword"] ?? "");

            List<clientsModel> lstResult = new List<clientsModel>();

            using (var conn = Functions.ConnectionDefault)
            {
                conn.Open();

                lstResult = conn.Query<clientsModel>("dbo.GCRL_ENG_CLIENTS_LIST_SEL",
                    param: new
                    {
                        KEYWORD = ViewBag.keyword
                    },
                    commandType: CommandType.StoredProcedure
                ).ToList();
            }
            ViewBag.TotalCnt = lstResult.Count;

            return View(lstResult);
        }
    }
}