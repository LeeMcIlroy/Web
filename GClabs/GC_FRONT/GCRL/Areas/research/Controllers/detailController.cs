using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace GCRL.Areas.research.Controllers
{
    public class detailController : Controller
    {
        // GET: gclabs/detail
        public ActionResult assignment()
        {
            return View();
        }

        public ActionResult biological()
        {
            return View();
        }
        public ActionResult irb()
        {
            return View();
        }

        public ActionResult result()
        {
            return View();
        }

        public ActionResult clinical()
        {
            return View();
        }
        public ActionResult equipment()
        {
            return View();
        }
    }
}