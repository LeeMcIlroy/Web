using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{ 
    public class PlanGroupdataCashflowMonth
    {
        public int Seq { get; set; }
        public string GroupdataYear { get; set; }
        public string GroupdataMonth { get; set; }
        public string DataType { get; set; }
        public decimal Ebitda { get; set; }
        public decimal Wc { get; set; }
        public decimal SalesEtc { get; set; }
        public decimal NetCapex { get; set; }
        public decimal FinancialCost { get; set; }
        public decimal FinancialSum { get; set; }
        public decimal CreditLine { get; set; }
        public decimal BasicCash { get; set; }
        public decimal Allocation { get; set; }
        public decimal Increase { get; set; }
        public decimal Borrowing { get; set; }
        public decimal Repayment { get; set; }
        public decimal Etc { get; set; }

    }
}