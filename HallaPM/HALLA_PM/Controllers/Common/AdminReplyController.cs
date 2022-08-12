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
    [AdminLoginFilter]
    [RoutePrefix("ReplyAdmin")]
    public class AdminReplyController : Controller
    {
        CommentListRepo cListRepo = new CommentListRepo();

        // GET: AdminReply
        public ActionResult Index()
        {
            return View();
        }

        [Route("SetReplyAdmin")]
        public JsonResult SetReplyAdmin(CommentList c)
        {

            // 하단 로직을 빼서 여기서 처리해야한다. 이미 저장되어있는 경우에는 위에 로직 제외해야해서..
            var cnt = 0;
            CommentList item = cListRepo.selectOne(c);
            if (item == null)
            {

                // 2019.01.08 처음 댓글을 다는 사람과 상관없이 중간관리자2(AUTH_LEVEL = 4)의 이름으로 댓글이 달려야 한다.
                // 관리자 권한에 중간관리자2가 있는지 확인
                AdminAuthRepo authRepo = new AdminAuthRepo();
                var auth = authRepo.selectOneForOrg(new { OrgSeq = c.AttachTableSeq });
                if (auth == null)
                {
                    return Json(new { success = false, result = "중간관리자2가 없습니다." });
                }
                // 인사디비에 중간관리자2가 있는지 확인
                InsaUserVRepo insaUserVRepo = new InsaUserVRepo();
                var insa = insaUserVRepo.selectOneJoinDept(new { EmpNo = auth.AuthUserKey });
                if (insa == null)
                {
                    return Json(new { success = false, result = "중간관리자2가 인사디비에 없습니다." });
                }

                c.UserKey = insa.userKey;
                c.UserKorName = insa.userKorName;
                c.CompKorName = insa.CompKorName;
                c.DeptKorName = insa.Deptkorname;

                cnt = cListRepo.insert(c);
            }
            else
            {
                cnt = cListRepo.update(c);
            }

            if (cnt > 0)
            {
                return Json(new { success = true, result = "댓글이 등록되었습니다." });
            }
            else
            {
                return Json(new { success = false, result = "댓글 입력에 실패했습니다." });
            }

            /*
            var r = cListRepo.save(c);
            if (r > 0)
            {
                return Json(new { success = true, result = "성공" });
            }
            else
            {
                return Json(new { success = false, result = "댓글 입력에 실패했습니다." });
            }
            */
        }

        [Route("GetReplyOne")]
        public JsonResult GetReplyOne(CommentList c)
        {
            CommentList rValue = cListRepo.selectOne(c);
            return Json(new { List = rValue, PageInfo = c });
        }
    }
}