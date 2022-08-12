using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace HALLA_PM.Controllers
{
    public class TestController : Controller
    {
        // GET: Test
        [Route("Test/View")]
        public ActionResult Index()
        {
            return View("~/Views/Test/View.cshtml");
        }

        [Route("Test/Mail")]
        public ActionResult Mail()
        {
            return View("~/Views/Test/MailTest.cshtml");
        }

    }
}