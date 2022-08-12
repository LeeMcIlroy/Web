using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace GCRL.Areas.main.Controllers
{
    public class termsController : Controller
    {
        // GET: main/terms
        public ActionResult cctv()
        {
            return View();
        }
        public ActionResult email()
        {
            return View();
        }
        public ActionResult privacy()
        {
            return View();
        }
    }
}