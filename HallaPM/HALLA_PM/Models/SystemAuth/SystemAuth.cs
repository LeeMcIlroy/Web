using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using HALLA_PM.Core;

namespace HALLA_PM.Models
{
    public class SystemAuth : BaseInfo
    {
        public int RowNum { get; set; }
        public string AuthUserKey { get; set; }
        public string AuthEmpNo { get; set; }
        public string AuthUserKorName { get; set; }
        public string IsUse { get; set; }

        public string IsDisclosure { get; set; }

        /*
        public string UserKey { get; set; } = SessionManager.GetAdminSession().insaUserV.userKey;
        public string EmpNo { get; set; } = SessionManager.GetAdminSession().insaUserV.empNo;
        public DateTime CreateDate { get; set; }
        */

        public List<int> OrgCompanySeq { get; set; }
        public List<int> MenuType { get; set; }
        //public string message { get; set; }

        public string CompKorName { get; set; }
        public string levelKorName { get; set; }
    }
}