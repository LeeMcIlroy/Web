using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class PlanYearBsRoic
    {
        public int PlanYearBsSeq { get; set; }
        public int Seq { get; set; }
        public string YearlyYear { get; set; }
        public string Monthly { get; set; }
        public decimal AfterTaxOperationProfit { get; set; }
        public decimal PainInCapital { get; set; }
        public decimal Roic { get; set; }
        public decimal RoicYear { get; set; }
        public int PlanYearBsRoicSeq { get; set; }
    }
}