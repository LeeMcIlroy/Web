using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class PmBsRoic
    {
        public int PmBsSeq { get; set; }
        public int Seq { get; set; }
        public decimal AfterTaxOperationProfit { get; set; } = 0;
        public decimal PainInCapital { get; set; } = 0;
        public decimal Roic { get; set; } = 0;
        public decimal RoicYear { get; set; } = 0;
    }
}