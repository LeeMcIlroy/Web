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
    public class detailController : Controller
    {
        // GET: test/allergen
        public ActionResult diagnosis()
        {

            return View();
        }
        public ActionResult order()
        {

            return View();
        }
        public ActionResult pathology()
        {

            return View();
        }
        public ActionResult result()
        {
            HttpBrowserCapabilitiesBase isMobile = Request.Browser;
            if (isMobile.IsMobileDevice)
            {
                ViewBag.isMobile = true;
            }
            else
            {
                ViewBag.isMobile = false;
            }

            return View();
        }
        public ActionResult sample()
        {

            return View();

        }
    }
}