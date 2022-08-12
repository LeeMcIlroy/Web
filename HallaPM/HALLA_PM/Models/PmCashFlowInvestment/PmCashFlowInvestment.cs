using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class PmCashFlowInvestment
    {
        public int PmCashFlowSeq { get; set; }
        public int Seq { get; set; }
        public int Cumulative { get; set; }
        public decimal Assets { get; set; }
        public decimal EquityInvestment { get; set; }
        public decimal AssetsSale { get; set; }
        public decimal NetCapexSum { get; set; }
        public decimal InvestmentEtc { get; set; }
    }
}