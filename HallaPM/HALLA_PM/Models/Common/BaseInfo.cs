using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using HALLA_PM.Core;

namespace HALLA_PM.Models
{
    public class BaseInfo
    {
        public string UserKey { get; set; } = SessionManager.GetAdminSession() ==  null ? "" : SessionManager.GetAdminSession().insaUserV.userKey;
        public string EmpNo { get; set; } = SessionManager.GetAdminSession() == null ? "" : SessionManager.GetAdminSession().insaUserV.empNo;
        public DateTime CreateDate { get; set; }
        public string message { get; set; }
    }
}