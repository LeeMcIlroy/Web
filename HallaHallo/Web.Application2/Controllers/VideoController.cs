using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace HallaTube.Controllers
{
    public class VideoController : Controller
    {
        public ActionResult HeartBeat()
        {
            return new EmptyResult();
        }
    }
}