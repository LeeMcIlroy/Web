using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class TbPlanYearBs
    {
        public int seq { get; set; }
        public string yearBsYear { get; set; }
        public int orgCompanySeq { get; set; }
        public int registStatus { get; set; }
        public string userKey { get; set; }
        public string empNo { get; set; }
        public string createDate { get; set; }
    }
}