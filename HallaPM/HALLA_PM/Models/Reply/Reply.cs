using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using HALLA_PM.Core;

namespace HALLA_PM.Models
{
    public class Reply
    {
        public int seq { get; set; }
        public string userKey { get; set; } = SessionManager.GetAdminSession() == null ? "" : SessionManager.GetAdminSession().insaUserV.userKey;
        public string empNo { get; set; } = SessionManager.GetAdminSession() == null ? "" : SessionManager.GetAdminSession().insaUserV.empNo;
        public string userKorName { get; set; }
        public string compKorName { get; set; }
        public string deptKorName { get; set; }
        public string attachTableName { get; set; }
        public string attachTableSeq { get; set; }
        public string inputRegDate { get; set; }
        public string commentYear { get; set; }
        public string commentMonth { get; set; }
        public string comment { get; set; }
        public string adminWrite { get; set; }
        public string companyName { get; set; }
        public int rowNum { get; set; } 
    }
}