using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class PlanMonthlyInvestBusiness
    {
        public int PlanMonthlyInvestSeq { get; set; }
        public int Seq { get; set; }
        public int OrgBusinessSeq { get; set; }
        public string Monthly { get; set; }
        public decimal Investment { get; set; }
        public decimal Personnel { get; set; }
        public decimal DomesticPersonnel { get; set; }
        public decimal OverseasPersonnel { get; set; }

        public string CompanyName { get; set; }
        public string BusinessName { get; set; }

        public int PlanMonthlyInvestBusinessSeq { get; set; }
        public decimal BeforeInvestment { get; set; }
        public decimal BeforePersonnel { get; set; }
        public decimal BeforeDomesticPersonnel { get; set; }
        public decimal BeforeOverseasPersonnel { get; set; }
    }
}