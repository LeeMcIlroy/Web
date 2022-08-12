using Dapper;
using GCRL.Areas.test.Models;
using GCRL.Modules;
using System;
using System.Collections.Generic;
using System.Data;
using System.Dynamic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace GCRL.Areas.test.Controllers
{
    public class allergenController : Controller
    {
        // GET: test/allergen
        public ActionResult list()
        {
            List<allergenModel> lstResult = new List<allergenModel>();
            List<allergenModel> subList = new List<allergenModel>();

            string keyword = HttpUtility.UrlDecode(Request.QueryString["keyword"] ?? "");
            string initial = HttpUtility.UrlDecode(Request.QueryString["initial"] ?? "");
            string onoff = HttpUtility.UrlDecode(Request.QueryString["onoff"] ?? "off");
            ViewBag.onoff = onoff;

            using (var conn = Functions.ConnectionDefault)
            {
                conn.Open();

                 lstResult = conn.Query<allergenModel>("dbo.GCRL_ALLERGEN_LIST",
                    param: new
                    {
                       
                        GUBUN = "USER",
                        KeyWord = keyword ?? "",
                        INITIAL = initial ?? "",

                    },
                    commandType: CommandType.StoredProcedure
                ).ToList();

                for (int i = 1; i <= lstResult.Count(); i++)
                {
                    subList = conn.Query<allergenModel>("dbo.GCRL_ALLERGEN_LIST",
                        param: new
                        {

                            GUBUN = "USER_DT",
                            CTGR = lstResult[i - 1].CTGR,
                            //string.Format("{0:D2}", i),
                            KeyWord = keyword ?? "",
                            INITIAL = initial ?? ""

                        },
                        commandType: CommandType.StoredProcedure
                    ).ToList();
                    lstResult[i - 1].allergen = subList;
                }
                    //lstResult[i].CTGR = lstResult[i].ROW_NUM.ToString();
                    //List<allergenModel> tempList = subList;
            }
            ViewBag.initial = initial;
            ViewBag.KeyWord = keyword;
            ViewBag.TotalCount = lstResult.Count();

            return View(lstResult);
        }
    }
}