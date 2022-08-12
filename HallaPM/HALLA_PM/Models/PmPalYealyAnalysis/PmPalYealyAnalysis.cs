using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class PmPalYealyAnalysis
    {
        public int PmPalSeq { get; set; }
        public int Seq { get; set; }
        public int PmPalYealyAnalysisSeq { get; set; }
        public int Analysis { get; set; }
        public string MonthlyContent { get; set; }
        public decimal MonthlyValue { get; set; }
        public string YealyContent { get; set; }
        public decimal YealyValue { get; set; }
        public string PalYear { get; set; }
        public string Monthly { get; set; }
    }
}