using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

using HALLA_PM.Core;

namespace HALLA_PM.Controllers.SiteMngHome
{
    [RoutePrefix("SiteMngHome/Main")]
    public class MainController : Controller
    {
        [Route("Index")]
        public ActionResult Index()
        {
            return View("~/Views/SiteMngHome/Main/Index.cshtml");
            //return View();
        }
    }
}