using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class PmBsSummaryEx
    {
        public int PmBsSeq { get; set; }
        public int Seq { get; set; }
        public decimal Assets { get; set; } = 0;
        public decimal Liabilities { get; set; } = 0;
        public decimal Capital { get; set; } = 0;
        public decimal Cash { get; set; } = 0;
        public decimal Loan { get; set; } = 0;
        public decimal LiabilitiesRate { get; set; } = 0;
        public decimal AfterTaxOperationProfit { get; set; } = 0;
        public decimal PainInCapital { get; set; } = 0;
        public decimal Roic { get; set; } = 0;
        public decimal RoicYear { get; set; } = 0;
        public decimal Ar { get; set; } = 0;
        public decimal ArToDays { get; set; } = 0;
        public decimal Ap { get; set; } = 0;
        public decimal ApToDays { get; set; } = 0;
        public decimal Inventory { get; set; } = 0;
        public decimal InventoryToDays { get; set; } = 0;

        public string BsYear { get; set; }
        public string Monthly { get; set; }

        public int OrgCompanySeq { get; set; }
        public string CompanyName { get; set; }

        public int OrgUnionSeq { get; set; }
        public string UnionName { get; set; }
    }
}