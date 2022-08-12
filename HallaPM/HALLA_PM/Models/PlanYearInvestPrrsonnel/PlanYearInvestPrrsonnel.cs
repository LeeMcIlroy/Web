using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class PlanYearInvestPrrsonnel
    {
        public int PlanYearInvestSeq { get; set; }
        public int Seq { get; set; }
        public string YearlyYear { get; set; }
        public decimal DomesticPersonnel { get; set; }
        public decimal OverseasPersonnel { get; set; }
    }
}