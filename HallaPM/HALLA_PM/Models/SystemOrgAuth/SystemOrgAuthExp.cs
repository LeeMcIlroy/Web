using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class SystemOrgAuthExp : OrgCompany
    {
        public string AuthUserKey { get; set; }
        public int OrgCompanySeq { get; set; }
    }
}