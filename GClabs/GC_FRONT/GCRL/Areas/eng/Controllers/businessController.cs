using Dapper;
using GCRL.Areas.eng.Models;
using GCRL.Modules;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace GCRL.Areas.eng.Controllers
{
    public class businessController : Controller
    {
        // GET: eng/business
        public ActionResult consulting()
        {
            return View();
        }
        public ActionResult gdn()
        {
            return View();
        }
        public ActionResult health()
        {
            return View();
        }
        public ActionResult insights()
        {
            return View();
        }
        public ActionResult networks()
        {
            int pageNumber = Convert.ToInt16(Request.QueryString["page"] ?? "1");

            List<networkModel> lstResult = new List<networkModel>();

            using (var conn = Functions.ConnectionDefault)
            {
                conn.Open();

                lstResult = conn.Query<networkModel>("dbo.GCRL_ENG_NETWORK_LIST_SEL",
                    param: new
                    {

                    },
                    commandType: CommandType.StoredProcedure
                ).ToList();
            }


            return View(lstResult);
        }
        public ActionResult send()
        {
            return View();
        }
        
    }
}