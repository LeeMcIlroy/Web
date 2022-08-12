using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Web.Mvc;
using HALLA_PM.Util;
using HALLA_PM.Models;

namespace HALLA_PM.Core
{
    public class SystemAuthFilter : ActionFilterAttribute, IActionFilter
    {
        ActionExecutingContext context { get; set; }

        /// <summary>
        /// Define.MENU_TYPE의 키값과 비교
        /// </summary>
        public int MenuAuth = 0;
        public int OrgAuth = 0;

        /// <summary>
        /// 로그인권한이 없을때 페이지 이동
        /// </summary>
        public void ErrorPage()
        {
            context.Result = new RedirectResult(Define.SYSTEM_AUTH_PAGE_URL);
            return;
        }

        [HttpPost]
        void IActionFilter.OnActionExecuting(ActionExecutingContext filterContext)
        {
            try
            {
                context = filterContext;

                // 그룹페이지가 동일한 페이지여서 직접 주소를 입력하고 들어오는 것을 막는 것으로 변경
                if (context.HttpContext.Request.UrlReferrer == null) ErrorPage();
                
                if (SessionManager.GetMemberSession() == null)
                {
                    ErrorPage();
                }
            }
            catch (Exception e)
            {
                LogUtil.ReportErrorLog(e.ToString());
                ErrorPage();
            }
        }
    }
}