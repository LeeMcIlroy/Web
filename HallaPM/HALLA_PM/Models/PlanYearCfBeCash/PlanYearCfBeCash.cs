using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class PlanYearCfBeCash
    {
        public int PlanYearCfSeq { get; set; }
        public int Seq { get; set; }
        public string YearlyYear { get; set; }
        public string Monthly { get; set; }
        public decimal BasicCash { get; set; }
        public decimal EndingCash { get; set; }
        public decimal CreditLine { get; set; }
        public decimal AvailableCash { get; set; }
    }
}