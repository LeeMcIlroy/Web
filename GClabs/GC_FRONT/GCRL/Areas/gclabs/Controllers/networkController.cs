using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Data;

using GCRL.Modules;
using GCRL.Controllers;
using GCRL.Areas.gclabs.Models;

using Dapper;

namespace GCRL.Areas.gclabs.Controllers
{
    public class networkController : Controller
    {
        private readonly string _pageType = PageEnum.GclabsNetwork.ToCode();

        // GET: gclabs/network
        public ActionResult network()
        {
            ViewBag.branchname = Request.QueryString["branchname"] ?? "";
            ViewBag.regioncode = Request.QueryString["regioncode"] ?? "";

            List<networkModel> lstResult = new List<networkModel>();

            using (var conn = Functions.ConnectionDefault)
            {
                conn.Open();

                lstResult = conn.Query<networkModel>("dbo.GCRL_GCLABS_NETWORK_LIST_SEL",
                    param: new
                    {
                        pType = _pageType,
                        pBranchName = ViewBag.branchname ?? "",
                        pRegionCode = ViewBag.regioncode ?? ""
                    },
                    commandType: CommandType.StoredProcedure
                ).ToList();
            }

            return View(lstResult);
        }
    }
}