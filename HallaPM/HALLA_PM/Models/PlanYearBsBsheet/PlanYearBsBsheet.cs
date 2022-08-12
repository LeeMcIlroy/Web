using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class PlanYearBsBsheet
    {
        public int PlanYearBsSeq { get; set; }
        public int Seq { get; set; }
        public string YearlyYear { get; set; }
        public string Monthly { get; set; }
        public decimal Assets { get; set; } = 0;
        public decimal CurrentAssets { get; set; } = 0;
        public decimal Liabilities { get; set; } = 0;
        public decimal CurrentLiabilities { get; set; } = 0;
        public decimal Capital { get; set; } = 0;
        public decimal Cash { get; set; } = 0;
        public decimal Loan { get; set; } = 0;
        public decimal LiabilitiesRate { get; set; } = 0;
        public decimal CurrentRate { get; set; } = 0;
        public int PlanYearBsBsheetSeq { get; set; }
    }
}