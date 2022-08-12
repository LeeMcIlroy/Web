using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class PlanMonthlyPalBusinessMonthlySum
    {
        public int PlanMonthlyPalSeq { get; set; }
        public int Seq { get; set; }
        public string Monthly { get; set; }
        public decimal Sales { get; set; }
        public decimal Ebit { get; set; }
        public decimal EbitRate { get; set; }
        public decimal Pbt { get; set; }

        public int PlanMonthlyPalBusinessMonthlySumSeq { get; set; }
        public decimal BeforeSales { get; set; }
        public decimal BeforeEbit { get; set; }
        public decimal BeforeEbitRate { get; set; }
        public decimal BeforePbt { get; set; }
    }
}