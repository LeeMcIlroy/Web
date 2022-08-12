using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class PlanYearCfInvestment
    {
        public int PlanYearCfSeq { get; set; }
        public int Seq { get; set; }
        public string YearlyYear { get; set; }
        public string Monthly { get; set; }
        public decimal Assets { get; set; }
        public decimal EquityInvestment { get; set; }
        public decimal AssetsSale { get; set; }
        public decimal Etc { get; set; }
        public decimal NetCapexSum { get; set; }
    }
}