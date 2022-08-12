using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Web.Mvc;
using HALLA_PM.Util;

namespace HALLA_PM.Core
{
    /// <summary>
    /// 관리자의 권한을 체크합니다.
    /// </summary>
    public class AuthAdminFilter:ActionFilterAttribute, IActionFilter
    {
        ActionExecutingContext context { get; set; }

        /// <summary>
        /// Define.AUTH_LEVEL 의 등급입니다.
        /// 1, "최종 관리자"
        /// 2, "중간 관리자"
        /// 3, "실적 담당자"
        /// </summary>
        public int RequestAuthLevel;

        /// <summary>
        /// 권한이 없거나 오류가 발생하였을때 이동하는 페이지
        /// </summary>
        private void Error()
        {
            context.Result = new RedirectResult(Define.AUTH_PAGE_URL);
            return;
        }

        void IActionFilter.OnActionExecuting(ActionExecutingContext filterContext)
        {
            try
            {
                context = filterContext;

                var adminSession = SessionManager.GetAdminSession();
                if (adminSession == null || RequestAuthLevel == 0)
                {
                    Error();
                }

                if (RequestAuthLevel == Define.AUTH_LEVEL.GetKey("최종 관리자"))
                {
                    if (adminSession.adminAuth.AuthLevel != Define.AUTH_LEVEL.GetKey("최종 관리자"))
                    {
                        Error();
                    }
                }

                if (RequestAuthLevel == Define.AUTH_LEVEL.GetKey("중간 관리자2"))
                {
                    if (adminSession.adminAuth.AuthLevel != Define.AUTH_LEVEL.GetKey("최종 관리자") &&
                        adminSession.adminAuth.AuthLevel != Define.AUTH_LEVEL.GetKey("중간 관리자2"))
                    {
                        Error();
                    }
                }

                if (RequestAuthLevel == Define.AUTH_LEVEL.GetKey("중간 관리자"))
                {
                    if (adminSession.adminAuth.AuthLevel != Define.AUTH_LEVEL.GetKey("최종 관리자") &&
                        adminSession.adminAuth.AuthLevel != Define.AUTH_LEVEL.GetKey("중간 관리자") &&
                        adminSession.adminAuth.AuthLevel != Define.AUTH_LEVEL.GetKey("중간 관리자2"))
                    {
                        Error();
                    }
                }

                if (RequestAuthLevel == Define.AUTH_LEVEL.GetKey("실적 담당자"))
                {
                    if (adminSession.adminAuth.AuthLevel != Define.AUTH_LEVEL.GetKey("최종 관리자") &&
                        adminSession.adminAuth.AuthLevel != Define.AUTH_LEVEL.GetKey("중간 관리자") &&
                        adminSession.adminAuth.AuthLevel != Define.AUTH_LEVEL.GetKey("중간 관리자2") &&
                        adminSession.adminAuth.AuthLevel != Define.AUTH_LEVEL.GetKey("실적 담당자"))
                    {
                        Error();
                    }

                }
            }
            catch (Exception e)
            {
                LogUtil.MngError(e.ToString());
                Error();
            }
        }
    }
}