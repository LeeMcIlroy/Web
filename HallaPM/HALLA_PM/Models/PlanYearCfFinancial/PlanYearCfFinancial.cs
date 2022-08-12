using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class PlanYearCfFinancial
    {
        public int PlanYearCfSeq { get; set; }
        public int Seq { get; set; }
        public string YearlyYear { get; set; }
        public string Monthly { get; set; }
        public decimal Allocation { get; set; }
        public decimal Increase { get; set; }
        public decimal Borrowing { get; set; }
        public decimal Repayment { get; set; }
        public decimal Etc { get; set; }
        public decimal FinancialSum { get; set; }
    }
}