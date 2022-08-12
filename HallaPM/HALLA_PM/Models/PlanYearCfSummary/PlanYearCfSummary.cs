using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class PlanYearCfSummary
    {
        public int PlanYearCfSeq { get; set; }
        public int Seq { get; set; }
        /// <summary>
        /// 전년대비 추가 2018.09.28, THIS 당해년도, LAST 전년도
        /// </summary>
        public string Yearly { get; set; }
        public string YearlyYear { get; set; }
        public string Monthly { get; set; }
        public decimal CfSales { get; set; }
        public decimal CfInvestment { get; set; }
        public decimal CfFinancial { get; set; }
        public decimal CfSum { get; set; }
        public decimal CfEndingCash { get; set; }
        public decimal CfAvailableCash { get; set; }
        public decimal Fcf1 { get; set; }
        public decimal Fcf2 { get; set; }
        public decimal Fcf3 { get; set; }
    }
}