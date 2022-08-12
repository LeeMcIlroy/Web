using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;


namespace HALLA_PM.Models
{
    public class AdminAuth : BaseInfo
    {
        public int RowNum { get; set; }
        public string AuthUserKey { get; set; }
        public string AuthEmpNo { get; set; }
        public string AuthUserKorName { get; set; }
        public int AuthLevel { get; set; }
        public string IsUse { get; set; }
        public string IsDisclosure { get; set; }

        public int OrgSeq { get; set; }

        public List<int> OrgCompanySeq { get; set; }
        //public string message { get; set; }

        public string CompKorName { get; set; }
        public string levelKorName { get; set; }

        public string AuthName { get; set; }
    }
}