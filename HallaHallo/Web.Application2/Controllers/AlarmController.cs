
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;

namespace HallaTube.Controllers
{
    [Authorize]
    public class AlarmController : BaseController
    {
        AlarmRepository alarmRepository = new AlarmRepository();

        public ActionResult List(SearchModel search)
        {
            search.UserID = _User.UserId;

            var list = alarmRepository.GetList(search);
            ViewData["list"] = list;
            ViewData["search"] = search;
            return View();
        }

        [HttpPost]
        public ActionResult Read(string id)
        {
            alarmRepository.Read(id);

            return new EmptyResult();
        }

        [HttpPost]
        public ActionResult Delete(string id)
        {
            alarmRepository.Delete(id);

            return new EmptyResult();
        }

        [HttpPost]
        public ActionResult DeleteRead(string id)
        {
            alarmRepository.DeleteRead(_User.UserId);

            return new EmptyResult();
        }

        [HttpPost]
        public ActionResult DeleteAll(string id)
        {
            alarmRepository.DeleteAll(_User.UserId);

            return new EmptyResult();
        }
    }
}
