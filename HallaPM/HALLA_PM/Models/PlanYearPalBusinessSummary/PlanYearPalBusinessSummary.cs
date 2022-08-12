using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class PlanYearPalBusinessSummary
    {
        public int Seq { get; set; }
        public int PlanYearPalSeq { get; set; }
        public int orgCompanySeq { get; set; }
        public int orgBusinessSeq { get; set; }
        public string yearlyYear { get; set; }
        public decimal sales { get; set; }
        public decimal ebit { get; set; }
        public decimal rate { get; set; }
        public decimal pbt { get; set; }
        public decimal ebitRate { get; set; }

        public int PlanYearPalBusinessSummarySeq { get; set; }
        public decimal BeforeSales { get; set; }
        public decimal BeforeEbit { get; set; }
        public decimal BeforeEbitRate { get; set; }
        public decimal BeforePbt { get; set; }
    }
}