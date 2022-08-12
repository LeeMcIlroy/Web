using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

using HALLA_PM.Models;
using HALLA_PM.Util;
using HALLA_PM.Core;

namespace HALLA_PM.Controllers
{
    [SystemLoginFilter]
    [RoutePrefix("Reply")]
    public class PartialReplayController : Controller
    {
        CommentListRepo cListRepo = new CommentListRepo();

        [HttpPost]
        [Route("SetReplySave")]
        public JsonResult SetReplySave(CommentList c)
        {
            string userKey = SessionManager.GetMemberSession().insaUserV.userKey;
            if (userKey == c.UserKey)
            {
                var r = cListRepo.insert(c);
                if (r > 0)
                {
                    return Json(new { success = true });
                }
                else
                {
                    return Json(new { success = false });
                }
            }
            else
            {
                return Json(new { success = false });
            }
        }

        [Route("GetReplyList")]
        public JsonResult GetReplyList(CommentList c)
        {
            var rValue = cListRepo.selectList(c).ToList();
            return Json(new { List = rValue, PageInfo = c });
        }

        [Route("GetReplyListAll")]
        public JsonResult GetReplyListAll(CommentList c)
        {
            var rValue = cListRepo.selectListAll(c).ToList();
            return Json(new { List = rValue, PageInfo = c });
        }

        [Route("SetReplyDelete")]
        public JsonResult SetReplyDelete(CommentList c)
        {
            string userKey = SessionManager.GetMemberSession().insaUserV.userKey;
            if (userKey == c.UserKey)
            {
                var r = cListRepo.delete(c);
                if (r > 0)
                {
                    return Json(new { success = true });
                }
                else
                {
                    return Json(new { success = false });
                }
            }
            else
            {
                return Json(new { success = false });
            }
        }
    }
}