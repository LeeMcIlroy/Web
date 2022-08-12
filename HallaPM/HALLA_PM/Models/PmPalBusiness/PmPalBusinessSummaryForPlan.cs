using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class PmPalBusinessSummaryForPlan
    {

        public int orgCompanySeq { get; set; }
        public int orgBusinessSeq { get; set; }
        public string yearlyYear { get; set; }
        public decimal sales { get; set; }
        public decimal ebit { get; set; }
        public decimal rate { get; set; }
    }
}