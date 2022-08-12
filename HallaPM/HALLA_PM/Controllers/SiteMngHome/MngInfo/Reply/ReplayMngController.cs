
using System.Web.Mvc;
using HALLA_PM.Core;
using HALLA_PM.Util;
using System.Dynamic;
using HALLA_PM.Models;

namespace HALLA_PM.Controllers.SiteMngHome.MngInfo.Reply
{
    [AdminLoginFilter]
    [AuthAdminFilter(RequestAuthLevel = 1)]
    [RoutePrefix("SiteMngHome/MngInfo/Reply")]
    public class ReplayMngController : Controller
    {
        // GET: ReplayMng

        ReplyRepo replyRepo = new ReplyRepo();
        public OrgCompanyRepo orgCompanyRepo = new OrgCompanyRepo();
        public ActionResult Index()
        {
            return View();
        }

        [Route("List")]
        public ActionResult List(Search search)
        {

            dynamic model = new ExpandoObject();
            model.list = replyRepo.selectListExp(search);
            model.totalCount = replyRepo.totalCount(search);
            model.OrgCpyList = orgCompanyRepo.selectList(null);
            ViewBag.Search = search;
            return View("~/Views/SiteMngHome/MngInfo/Reply/List.cshtml", model);
        }
        [Route("PmList")]
        public ActionResult PmList(Search search)
        {

            dynamic model = new ExpandoObject();
            model.list = replyRepo.selectListPm(search);
            model.totalCount = replyRepo.totalCount(search);
            model.OrgCpyList = orgCompanyRepo.selectList(null);
            ViewBag.Search = search;
            return View("~/Views/SiteMngHome/MngInfo/Reply/PmList.cshtml", model);
        }
        [Route("BuList")]
        public ActionResult BuList(Search search)
        {

            dynamic model = new ExpandoObject();
            model.list = replyRepo.selectListExp(search);
            model.totalCount = replyRepo.totalCount(search);
            model.OrgCpyList = orgCompanyRepo.selectList(null);
            ViewBag.Search = search;
            return View("~/Views/SiteMngHome/MngInfo/Reply/BuList.cshtml", model);
        }
    }
}