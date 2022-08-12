using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class PlanYearPalBusiness
    {
        public int PlanYearPalSeq { get; set; }
        public int Seq { get; set; }
        public int OrgBusinessSeq { get; set; }
        public string YearlyYear { get; set; }
        public decimal Sales { get; set; }
        public decimal Ebit { get; set; }
        public decimal EbitRate { get; set; }
        public decimal Pbt { get; set; }
        public decimal BeforeSales { get; set; }
        public decimal BeforeEbit { get; set; }
        public decimal BeforeEbitRate { get; set; }
        public decimal BeforePbt { get; set; }

        public int PlanYearPalBusinessSeq { get; set; }
        public string CompanyName { get; set; }
        public string BusinessName { get; set; }
        //public List<int> PlanYearPalBusinessSeq { get; set; }
        //public List<decimal> Sales { get; set; }
        //public List<decimal> Ebit { get; set; }
        //public List<decimal> Pbt { get; set; }
    }
}