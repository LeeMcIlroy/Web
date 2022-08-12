using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Core
{
    [Serializable()]
    public static class SessionManager
    {
        #region GetAdminSession : 관리자세션을 가져옵니다.
        /// <summary>
        /// 관리자세션을 가져옵니다.
        /// </summary>
        /// <returns></returns>
        public static AdminSession GetAdminSession()
        {
            if (HttpContext.Current.Session[Define.ADMIN_SESSION_NAME] != null)
                return (AdminSession)HttpContext.Current.Session[Define.ADMIN_SESSION_NAME];
            else
                return null;
        }
        #endregion

        #region SetAdminSession : 관리자세션을 설정합니다.
        /// <summary>
        /// 관리자세션을 설정합니다.
        /// </summary>
        /// <param name="adminSession"></param>
        public static void SetAdminSession(AdminSession adminSession)
        {
            HttpContext.Current.Session[Define.ADMIN_SESSION_NAME] = adminSession;
            HttpContext.Current.Session.Timeout = 300;
        }
        #endregion

        #region RemoveAdminSession : 관리자세션을 지웁니다.
        /// <summary>
        /// 관리자세션을 지웁니다.
        /// </summary>
        public static void RemoveAdminSession()
        {
            HttpContext.Current.Session.Clear();
            HttpContext.Current.Session.Abandon();
            HttpContext.Current.User = null;
            System.Web.Security.FormsAuthentication.SignOut();
        }
        #endregion

        #region GetMemberSession : 사용자세션을 가져옵니다.
        /// <summary>
        /// 사용자세션을 가져옵니다.
        /// </summary>
        /// <returns></returns>
        public static MemberSession GetMemberSession()
        {
            if (HttpContext.Current.Session[Define.MEMBER_SESSION_NAME] != null)
                return (MemberSession)HttpContext.Current.Session[Define.MEMBER_SESSION_NAME];
            else
                return null;
        }
        #endregion

        #region SetMemberSession : 사용자제션을 설정합니다.
        /// <summary>
        /// 사용자제션을 설정합니다.
        /// </summary>
        /// <param name="memberSession"></param>
        public static void SetMemberSession(MemberSession memberSession)
        {
            HttpContext.Current.Session[Define.MEMBER_SESSION_NAME] = memberSession;
            HttpContext.Current.Session.Timeout = 300;
        }
        #endregion

        #region RemoveMemberSession : 사용자세션을 지웁니다.
        /// <summary>
        /// 사용자세션을 지웁니다.
        /// </summary>
        public static void RemoveMemberSession()
        {
            HttpContext.Current.Session.Clear();
            HttpContext.Current.Session.Abandon();
            HttpContext.Current.User = null;
            System.Web.Security.FormsAuthentication.SignOut();
        }
        #endregion
    }
}