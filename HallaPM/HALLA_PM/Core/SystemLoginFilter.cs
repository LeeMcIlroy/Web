using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Web.Mvc;
using HALLA_PM.Util;
using HALLA_PM.Models;

namespace HALLA_PM.Core
{
    public class SystemLoginFilter : ActionFilterAttribute, IActionFilter
    {
        ActionExecutingContext context { get; set; }

        /// <summary>
        /// 로그인권한이 없을때 페이지 이동
        /// </summary>
        public void ErrorPage()
        {
            context.Result = new RedirectResult(Define.SYSTEM_ERROR_PAGE_URL);
            return;
        }

        [HttpPost]
        void IActionFilter.OnActionExecuting(ActionExecutingContext filterContext)
        {
            try
            {
                context = filterContext;

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