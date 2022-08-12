using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class PmPalAnalysis
    {
        public int PmPalSeq { get; set; }
        public int PmPalAnalysisSeq { get; set; }
        public int Seq { get; set; }
        public int Analysis { get; set; }
        public string MonthlyContent { get; set; }
        public decimal MonthlyValue { get; set; }
        public string CumulativeContent { get; set; }
        public decimal CumulativeValue { get; set; }
        public string PalYear { get; set; }
        public string Monthly { get; set; }
    }
}