using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class PmCashFlowCumulativeExcel
    {
        public int PmCashFlowSeq { get; set; }
        public int Seq { get; set; }
        public int Diff { get; set; }
        public decimal Ebitda { get; set; }
        public decimal WcSum { get; set; }
        public decimal Etc { get; set; }
        public decimal NetCapexSum { get; set; }
        public decimal FinancialCost { get; set; }
        public decimal Fcf2 { get; set; }
        public decimal FinancialSum { get; set; }
        public decimal CashSum { get; set; }
        public decimal EndingCash { get; set; }
        public decimal CreditLine { get; set; }
        public decimal AvailableCash { get; set; }


        public string CashFlowYear { get; set; }
        public string Monthly { get; set; }
        public int OrgCompanySeq { get; set; }
        public string CompanyName { get; set; }
    }
}