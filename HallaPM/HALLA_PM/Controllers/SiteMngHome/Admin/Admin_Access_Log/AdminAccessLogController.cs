using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

using HALLA_PM.Core;
using HALLA_PM.Util;
using HALLA_PM.Models;
using System.Dynamic;

namespace HALLA_PM.Controllers.SiteMngHome
{
    [AdminLoginFilter]
    [AuthAdminFilter(RequestAuthLevel = 1)]
    [RoutePrefix("SiteMngHome/Admin/Admin_Access_Log")]
    public class AdminAccessLogController : SiteMngBaseController
    {
        [Route("List")]
        public ActionResult List(Search search)
        {
            dynamic model = new ExpandoObject();
            model.list = adminAccessLogRepo.selectList(search);
            ViewBag.Search = search;
            return View("~/Views/SiteMngHome/Admin/Admin_Access_Log/List.cshtml", model);
        }
    }
}