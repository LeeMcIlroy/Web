using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class OrgBusiness : OrgCompany
    {
        public int OrgCompanySeq { get; set; }
        //public int Seq { get; set; }
        public string BusinessName { get; set; }

        //public string IsUse { get; set; }
        //public string UserKey { get; set; }
        //public string EmpNo { get; set; }
        //public DateTime CreateDate { get; set; }
    }
}