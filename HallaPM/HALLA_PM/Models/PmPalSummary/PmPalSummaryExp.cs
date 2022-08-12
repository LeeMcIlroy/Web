using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class PmPalSummaryExp
    {
        public string PalYear { get; set; }
        public string Monthly { get; set; }
        public int MonthlyType { get; set; }


        public decimal Sales { get; set; }
        public decimal Ebit { get; set; }
        public decimal EbitRate { get; set; }
        public decimal Pbt { get; set; }


        public int OrgCompanySeq { get; set; }
        public string CompanyName { get; set; }

        public int OrgUnionSeq { get; set; }
        public string UnionName { get; set; }
        public string LiabilitiesRateComment { get; set; }
        public string IsUse { get; set; }
    }
}