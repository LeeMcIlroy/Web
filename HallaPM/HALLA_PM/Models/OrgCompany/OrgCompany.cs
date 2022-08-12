using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class OrgCompany : OrgUnion
    {
        public int OrgUnionSeq { get; set; }
        //public int Seq { get; set; }
        public string CompanyName { get; set; }
        //public string IsUse { get; set; }
        //public string UserKey { get; set; }
        //public string EmpNo { get; set; }
        //public DateTime CreateDate { get; set; }
        public string UseYear { get; set; }
        public string UseMonth { get; set; }
        public string UseDisYear { get; set; }
        public string UseDisMonth { get; set; }
    }
}