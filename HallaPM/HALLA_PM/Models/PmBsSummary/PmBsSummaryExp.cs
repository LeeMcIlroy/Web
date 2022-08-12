using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class PmBsSummaryExp
    {
        public int PmBsSeq { get; set; }
        public int Seq { get; set; }
        public decimal Assets { get; set; }
        public decimal Liabilities { get; set; }
        public decimal Capital { get; set; }
        public decimal Cash { get; set; }
        public decimal Loan { get; set; }
        public decimal LiabilitiesRate { get; set; }
        public decimal AfterTaxOperationProfit { get; set; }
        public decimal PainInCapital { get; set; }
        public decimal Roic { get; set; }
        public decimal Ar { get; set; }
        public decimal ArToDays { get; set; }
        public decimal Ap { get; set; }
        public decimal ApToDays { get; set; }
        public decimal Inventory { get; set; }
        public decimal InventoryToDays { get; set; }

        public string BsYear { get; set; }
        public string Monthly { get; set; }

        public int OrgCompanySeq { get; set; }
        public string CompanyName { get; set; }

        public int OrgUnionSeq { get; set; }
        public string UnionName { get; set; }
    }
}