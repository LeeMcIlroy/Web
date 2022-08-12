using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class PmQuarterPalBusinessSummary
    {
        public int PmQuarterPalBusinessSeq { get; set; }
        public int Seq { get; set; }
        public int OrgBusinessSeq { get; set; }
        public string BusinessYear { get; set; }
        public string Monthly { get; set; }
        public int BusinessQuarter { get; set; }
        public decimal Sales { get; set; }
        public decimal Ebit { get; set; }
        public decimal EbitRate { get; set; }
        public decimal Pbt { get; set; }
        public decimal NetProfitTerm { get; set; }
    }
}