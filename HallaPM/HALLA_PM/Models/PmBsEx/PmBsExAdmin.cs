using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class PmBsExAdmin
    {
        public int Seq { get; set; }
        public string BsYear { get; set; }
        public string Monthly { get; set; }
        public int OrgCompanySeq { get; set; }
        public int RegistStatus { get; set; }

        public int afterRegistStatus { get; set; }

        public int RowNum { get; set; }
        public string message { get; set; }

        public string CompanyName { get; set; }
        public string UnionName { get; set; }
        public string WriteAble { get; set; }
        public string AuthUserKey { get; set; }
        public string IsUse { get; set; }
        public string ApplyChk { get; set; }

        #region << B/Sheet >>

        public List<int> PmBsBsheetSeq { get; set; }
        public List<string> planMonthly { get; set; }
        public List<decimal> Assets { get; set; }
        public List<decimal> CurrentAssets { get; set; }
        public List<decimal> Liabilities { get; set; }
        public List<decimal> CurrentLiabilities { get; set; }
        public List<decimal> Capital { get; set; }
        public List<decimal> Cash { get; set; }
        public List<decimal> Loan { get; set; }
        public List<decimal> LiabilitiesRate { get; set; }
        public List<decimal> CurrentRate { get; set; }

        #endregion

        #region << ROIC >>

        public List<int> PmBsRoicSeq { get; set; }
        public List<decimal> AfterTaxOperationProfit { get; set; }
        public List<decimal> PainInCapital { get; set; }
        public List<decimal> Roic { get; set; }

        #endregion

        #region << W/Capital >>

        public List<string> BsCapitalYearlyYear { get; set; }
        public List<int> PmBsWCapitalSeq { get; set; }
        public List<decimal> AnnualSales { get; set; }
        public List<decimal> AnnualSalesCost { get; set; }
        public List<decimal> InventoryCost { get; set; }

        #endregion

        #region << W/Capital 등록 >>

        public List<int> PmBsWCapitalRegSeq { get; set; }
        public List<string> BsCapitalRegYearlyYear { get; set; }
        public List<decimal> Ar { get; set; }
        public List<decimal> ArToDays { get; set; }
        public List<decimal> Ap { get; set; }
        public List<decimal> ApToDays { get; set; }
        public List<decimal> Inventory { get; set; }
        public List<decimal> InventoryToDays { get; set; }

        #endregion

        #region << 중기재무계획 요약 >>

        public List<int> PmBsSummarySeq { get; set; }
        public List<decimal> SummaryAssets { get; set; }
        public List<decimal> SummaryLiabilities { get; set; }
        public List<decimal> SummaryCapital { get; set; }
        public List<decimal> SummaryCash { get; set; }
        public List<decimal> SummaryLoan { get; set; }
        public List<decimal> SummaryLiabilitiesRate { get; set; }
        public List<decimal> SummaryAfterTaxOperationProfit { get; set; }
        public List<decimal> SummaryPainInCapital { get; set; }
        public List<decimal> SummaryRoic { get; set; }
        public List<decimal> SummaryAr { get; set; }
        public List<decimal> SummaryArToDays { get; set; }
        public List<decimal> SummaryAp { get; set; }
        public List<decimal> SummaryApToDays { get; set; }
        public List<decimal> SummaryInventory { get; set; }
        public List<decimal> SummaryInventoryToDays { get; set; }

        #endregion
    }
}