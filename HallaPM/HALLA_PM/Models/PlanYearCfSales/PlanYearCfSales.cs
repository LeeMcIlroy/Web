using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class PlanYearCfSales
    {
        public int PlanYearCfSeq { get; set; }
        public int Seq { get; set; }
        public string YearlyYear { get; set; }
        public string Monthly { get; set; }
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

        public string YearCfYear { get; set; }
        public string OrgCompanySeq { get; set; }
    }
}