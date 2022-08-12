using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class PmCashFlowFcf
    {
        public int PmCashFlowSeq { get; set; }
        public int Seq { get; set; }
        public int Cumulative { get; set; }
        public decimal Fcf1 { get; set; }
        public decimal Fcf2 { get; set; }
        public decimal Fcf3 { get; set; }
        public decimal CashSum { get; set; }
        public decimal FcfSales { get; set; }
    }
}