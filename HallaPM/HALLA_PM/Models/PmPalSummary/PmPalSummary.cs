using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class PmPalSummary
    {
        public int PmPalSeq { get; set; }
        public int Seq { get; set; }
        public int kind { get; set; }
        public string PalYear { get; set; }
        public string Monthly { get; set; }
        public string MonthlyType { get; set; }
        public decimal Sales { get; set; }
        public decimal Ebit { get; set; }
        public decimal EbitRate { get; set; }
        public decimal Pbt { get; set; }
        public decimal NetProfitTerm { get; set; }
        public int PmPalSummarySeq { get; set; }
        public string LiabilitiesRateComment { get; set; }
    }
}