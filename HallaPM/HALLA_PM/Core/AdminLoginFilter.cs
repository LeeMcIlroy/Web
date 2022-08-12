using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Web.Mvc;
using HALLA_PM.Util;
using HALLA_PM.Models;

namespace HALLA_PM.Core
{
    /// <summary>
    /// 관리자의 로그인 유무를 체크합니다.
    /// </summary>
    public class AdminLoginFilter : ActionFilterAttribute, IActionFilter
    {
        ActionExecutingContext context { get; set; }

        /// <summary>
        /// 에러나 문제 발생시 페이지 이동
        /// </summary>
        private void ErrorPage()
        {
            context.Result = new RedirectResult(Define.ERROR_PAGE_URL);
            return;
        }

        [HttpPost]
        void IActionFilter.OnActionExecuting(ActionExecutingContext filterContext)
        {
            try
            {
                context = filterContext;

                if (SessionManager.GetAdminSession() == null)
                {
                    /*
                    // 개발에서는 세션이 없으면 세션을 넣어준다.
                    InsaUserVRepo insaUserVRepo = new InsaUserVRepo();
                    InsaUserV insa = insaUserVRepo.selectOne(new { EmpNo = "B20001" });
                    AdminSession admin = new AdminSession();
                    admin.insaUserV = insa;
                    SessionManager.SetAdminSession(admin);
                    */
                    // 운영
                    ErrorPage();
                }
            }
            catch (Exception e)
            {
                LogUtil.MngError(e.ToString());
                ErrorPage();
            }
        }
    }
}