using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class PlanGroupdataBsSummary
    {
        public int Seq { get; set; }
        public string GroupdataYear { get; set; }
        public string GroupdataMonth { get; set; }
        public string DataType { get; set; }

        public decimal Assets { get; set; }
        public decimal Liabilities { get; set; }
        public decimal Capital { get; set; }
        public decimal Cash { get; set; }
        public decimal Loan { get; set; }
        public decimal AfterTaxOperationProfit { get; set; }
        public decimal PainInCapital { get; set; }
        public decimal Ar { get; set; }
        public decimal ArToDays { get; set; }
        public decimal Ap { get; set; }
        public decimal ApToDays { get; set; }
        public decimal Inventory { get; set; }
        public decimal InventoryToDays { get; set; }
    }
}