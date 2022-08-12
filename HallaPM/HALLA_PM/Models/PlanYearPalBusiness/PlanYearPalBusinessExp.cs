using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class PlanYearPalBusinessExp
    {
        public string PalYear { get; set; }
        public string YearPalYear { get; set; }
        public string Monthly { get; set; }
        public int MonthlyType { get; set; }

        public string YearlyYear { get; set; }
        public decimal Sales { get; set; }
        public decimal Ebit { get; set; }
        public decimal EbitRate { get; set; }
        public decimal Pbt { get; set; }



        public int OrgCompanySeq { get; set; }
        public string CompanyName { get; set; }

        public int OrgUnionSeq { get; set; }
        public string UnionName { get; set; }

        public int OrgBusinessSeq { get; set; }
        public string BusinessName { get; set; }
    }
}