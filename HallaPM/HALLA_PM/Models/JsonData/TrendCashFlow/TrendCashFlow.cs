using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class TrendCashFlow
    {
        public string CashFlowYear { get; set; }
        public string Monthly { get; set; }
        public int Qt { get; set; }


        public decimal OperationProfit { get; set; }
        public decimal DepreciationCost { get; set; }
        public decimal CorpTax { get; set; }
        public decimal Ebitda { get; set; }
        public decimal Ar { get; set; }
        public decimal Inv { get; set; }
        public decimal Ap { get; set; }
        public decimal WcSum { get; set; }
        public decimal Etc { get; set; }
        public decimal InterestExpense { get; set; }
        public decimal InterestIncome { get; set; }
        public decimal FinancialCostSum { get; set; }
        /// <summary>
        /// 영업활동
        /// </summary>
        public decimal SumSales { get; set; }


        public decimal Assets { get; set; }
        public decimal EquityInvestment { get; set; }
        public decimal AssetsSale { get; set; }
        public decimal NetCapexSum { get; set; }
        /// <summary>
        /// 투자활동
        /// </summary>
        public decimal SumInvestment { get; set; }


        public decimal Allocation { get; set; }
        public decimal Increase { get; set; }
        public decimal Borrowing { get; set; }
        public decimal Repayment { get; set; }
        public decimal FinancialEtc { get; set; }
        public decimal FinancialSum { get; set; }
        /// <summary>
        /// 재무활동
        /// </summary>
        public decimal SumFinancial { get; set; }


        public decimal Fcf1 { get; set; }
        public decimal Fcf2 { get; set; }
        public decimal Fcf3 { get; set; }
        public decimal CashSum { get; set; }
        public decimal FcfSales { get; set; }

        public decimal BasicCash { get; set; }
        public decimal EndingCash { get; set; }
        public decimal CreditLine { get; set; }
        public decimal AvailableCash { get; set; }

        public decimal SumNetCf { get; set; }


        public int OrgCompanySeq { get; set; }
        public string CompanyName { get; set; }
        public int OrgUnionSeq { get; set; }
        public string UnionName { get; set; }

    }
}