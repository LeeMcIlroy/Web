using HALLA_PM.Core;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class Reference
    {
        public int seq { get; set; }
        public string userKey { get; set; } = SessionManager.GetAdminSession() == null ? "" : SessionManager.GetAdminSession().insaUserV.userKey;
        public string empNo { get; set; } = SessionManager.GetAdminSession() == null ? "" : SessionManager.GetAdminSession().insaUserV.empNo;
        public string regDate { get; set; }
        public string updateDate { get; set; }

        public string title { get; set; }
        public string inputRegDate { get; set; }
        public string contents { get; set; }
        public string isUse { get; set; }
        public int viewCnt { get; set; }

        public int rowNum { get; set; }
    }
}