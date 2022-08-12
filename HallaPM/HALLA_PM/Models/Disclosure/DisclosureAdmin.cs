using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class DisclosureAdmin
    {
        public int RowNum { get; set; }
        public int Seq { get; set; }
        public string CashFlowYear { get; set; }
        public string Monthly { get; set; }
        public int OrgCompanySeq { get; set; }
        public int RegistStatus { get; set; }

        public int afterRegistStatus { get; set; }

        public string CompanyName { get; set; }
        public string UnionName { get; set; }
        public string WriteAble { get; set; }
        public string AuthUserKey { get; set; }
        public string IsUse { get; set; }
        public string ApplyChk { get; set; }

        public string SalesComment { get; set; }
        public string InvestmentComment { get; set; }
        public string FinancialComment { get; set; }
        public string FcfComment { get; set; }
        public string BeCashComment { get; set; }


        public List<int> PmCashFlowSalesSeq { get; set; }
        public List<decimal> OperationProfit { get; set; }
        public List<decimal> DepreciationCost { get; set; }
        public List<decimal> CorpTax { get; set; }
        public List<decimal> Ebitda { get; set; }
        public List<decimal> Ar { get; set; }
        public List<decimal> Inv { get; set; }
        public List<decimal> Ap { get; set; }
        public List<decimal> WcSum { get; set; }
        public List<decimal> Etc { get; set; }
        public List<decimal> InterestExpense { get; set; }
        public List<decimal> InterestIncome { get; set; }
        public List<decimal> FinancialCostSum { get; set; }


        public List<int> PmCashFlowInvestmentSeq { get; set; }
        public List<decimal> Assets { get; set; }
        public List<decimal> EquityInvestment { get; set; }
        public List<decimal> AssetsSale { get; set; }
        public List<decimal> InvestmentEtc { get; set; }
        public List<decimal> NetCapexSum { get; set; }


        public List<int> PmCashFlowFinancialSeq { get; set; }
        public List<decimal> Allocation { get; set; }
        public List<decimal> Increase { get; set; }
        public List<decimal> Borrowing { get; set; }
        public List<decimal> Repayment { get; set; }
        public List<decimal> FinancialEtc { get; set; }
        public List<decimal> FinancialSum { get; set; }



        public List<int> PmCashFlowFcfSeq { get; set; }
        public List<int> Cumulative { get; set; }
        public List<decimal> Fcf1 { get; set; }
        public List<decimal> Fcf2 { get; set; }
        public List<decimal> Fcf3 { get; set; }
        public List<decimal> CashSum { get; set; }
        public List<decimal> Sales { get; set; }
        public List<decimal> FcfSales { get; set; }



        public List<int> PmCashFlowBeCashSeq { get; set; }
        public List<string> PlanYearCfBeCashYearlyYear { get; set; }
        public List<string> PlanYearCfBeCashMonthly { get; set; }
        public List<decimal> BasicCash { get; set; }
        public List<decimal> EndingCash { get; set; }
        public List<decimal> CreditLine { get; set; }
        public List<decimal> AvailableCash { get; set; }


        public List<int> PmCashFlowCumulativeSeq { get; set; }
        public List<decimal> CumulativeEbitda { get; set; }
        public List<decimal> CumulativeWcSum { get; set; }
        public List<decimal> CumulativeEtc { get; set; }
        public List<decimal> CumulativeNetCapexSum { get; set; }
        public List<decimal> CumulativeFinancialCost { get; set; }
        public List<decimal> CumulativeFcf2 { get; set; }
        public List<decimal> CumulativeFAllocation { get; set; }
        public List<decimal> CumulativeFIncrease { get; set; }
        public List<decimal> CumulativeFBorrowing { get; set; }
        public List<decimal> CumulativeFRepayment { get; set; }
        public List<decimal> CumulativeFEtc { get; set; }
        public List<decimal> CumulativeFinancialSum { get; set; }
        public List<decimal> CumulativeCashSum { get; set; }
        public List<decimal> CumulativeEndingCash { get; set; }
        public List<decimal> CumulativeCreditLine { get; set; }
        public List<decimal> CumulativeAvailableCash { get; set; }
    }
}