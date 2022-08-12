using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class PlanYearCfAdmin : BaseInfo
    {
        public int RowNum { get; set; }
        public int Seq { get; set; }
        public string YearCfYear { get; set; }
        public int OrgCompanySeq { get; set; }
        public int RegistStatus { get; set; }

        public int afterRegistStatus { get; set; }

        public string CompanyName { get; set; }
        public string UnionName { get; set; }
        public string WriteAble { get; set; }
        public string AuthUserKey { get; set; }
        public string IsUse { get; set; }
        public string ApplyChk { get; set; }

        // 영업활동
        public List<int> PlanYearCfSalesSeq { get; set; }
        public List<decimal> OperationProfit { get; set; }
        public List<decimal> DepreciationCost { get; set; }
        public List<decimal> CorpTax { get; set; }
        public List<decimal> Ebitda { get; set; }
        public List<decimal> Ar { get; set; }
        public List<decimal> Inv { get; set; }
        public List<decimal> Ap { get; set; }
        public List<decimal> WcSum { get; set; }
        /// <summary>
        /// 영업활동 기타
        /// </summary>
        public List<decimal> Etc { get; set; }
        public List<decimal> InterestExpense { get; set; }
        public List<decimal> InterestIncome { get; set; }
        public List<decimal> FinancialCostSum { get; set; }

        // 투자활동
        public List<int> PlanYearCfInvestmentSeq { get; set; }
        public List<decimal> Assets { get; set; }
        public List<decimal> EquityInvestment { get; set; }
        public List<decimal> AssetsSale { get; set; }
        /// <summary>
        /// 투자활동 기타
        /// </summary>
        public List<decimal> InvestmentEtc { get; set; }
        public List<decimal> NetCapexSum { get; set; }

        // 재무활동
        public List<int> PlanYearCfFinancialSeq { get; set; }
        public List<decimal> Allocation { get; set; }
        public List<decimal> Increase { get; set; }
        public List<decimal> Borrowing { get; set; }
        public List<decimal> Repayment { get; set; }
        /// <summary>
        /// 재무활동 기타
        /// </summary>
        public List<decimal> FinancialEtc { get; set; }
        public List<decimal> FinancialSum { get; set; }

        // FCF
        public List<int> PlanYearCfFcfSeq { get; set; }
        public List<decimal> Fcf1 { get; set; }
        public List<decimal> Fcf2 { get; set; }
        public List<decimal> Fcf3 { get; set; }
        public List<decimal> CashSum { get; set; }
        public List<decimal> Sales { get; set; }
        public List<decimal> FcfSales { get; set; }

        // 기초기말현금
        public List<int> PlanYearCfBeCashSeq { get; set; }
        public List<string> PlanYearCfBeCashYearlyYear { get; set; }
        public List<string> PlanYearCfBeCashMonthly { get; set; }
        public List<decimal> BasicCash { get; set; }
        public List<decimal> EndingCash { get; set; }
        public List<decimal> CreditLine { get; set; }
        public List<decimal> AvailableCash { get; set; }

        // 요약
        public List<int> PlanYearCfSummarySeq { get; set; }
        public List<decimal> SummaryCfSales { get; set; }
        public List<decimal> SummaryCfInvestment { get; set; }
        public List<decimal> SummaryCfFinancial { get; set; }
        public List<decimal> SummaryCfSum { get; set; }
        public List<decimal> SummaryCfEndingCash { get; set; }
        public List<decimal> SummaryCfAvailableCash { get; set; }
        public List<decimal> SummaryFcf1 { get; set; }
        public List<decimal> SummaryFcf2 { get; set; }
        public List<decimal> SummaryFcf3 { get; set; }
    }
}