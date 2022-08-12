using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class PlanYearInvestSum
    {
        public int PlanYearInvestSeq { get; set; }
        public int Seq { get; set; }
        public string YearlyYear { get; set; }
        public decimal Investment { get; set; }
        public decimal Personnel { get; set; }
    }
}