using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class PlanYearBsSummary
    {
        public int PlanYearBsSeq { get; set; }
        public int Seq { get; set; }
        public string YearlyYear { get; set; }
        public decimal Assets { get; set; }
        public decimal CurrentAssets { get; set; } = 0;
        public decimal Liabilities { get; set; }
        public decimal CurrentLiabilities { get; set; } = 0;
        public decimal Capital { get; set; }
        public decimal Cash { get; set; }
        public decimal Loan { get; set; }
        public decimal LiabilitiesRate { get; set; }
        public decimal AfterTaxOperationProfit { get; set; }
        public decimal PainInCapital { get; set; }
        public decimal Roic { get; set; }
        public decimal RoicYear { get; set; }
        public decimal Ar { get; set; }
        public decimal ArToDays { get; set; }
        public decimal Ap { get; set; }
        public decimal ApToDays { get; set; }
        public decimal Inventory { get; set; }
        public decimal InventoryToDays { get; set; }
        public int PlanYearBsSummarySeq { get; set; }
    }
}