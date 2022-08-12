using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class PlanYearCfFcf
    {
        public int PlanYearCfSeq { get; set; }
        public int Seq { get; set; }
        public string YearlyYear { get; set; }
        public string Monthly { get; set; }
        public decimal Fcf1 { get; set; }
        public decimal Fcf2 { get; set; }
        public decimal Fcf3 { get; set; }
        public decimal CashSum { get; set; }

        public decimal Sales { get; set; }
        public decimal FcfSales { get; set; }
    }
}