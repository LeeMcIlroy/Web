using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class PmCashFlowCumulativeExp
    {
        public string CashFlowYear { get; set; }
        public decimal CfSales { get; set; }
        public decimal CfInvestment { get; set; }
        public decimal CfFinancial { get; set; }
        public decimal CfSum { get; set; }
        public decimal CfEndingCash { get; set; }
        public decimal CfAvailableCash { get; set; }
        public decimal Fcf1 { get; set; }
        public decimal Fcf2 { get; set; }
        public decimal Fcf3 { get; set; }

        public int OrgCompanySeq { get; set; }
        public string CompanyName { get; set; }

        public int OrgUnionSeq { get; set; }
        public string UnionName { get; set; }
    }
}