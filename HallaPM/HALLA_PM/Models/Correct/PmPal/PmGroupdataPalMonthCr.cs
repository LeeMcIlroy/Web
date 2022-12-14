using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class PmGroupdataPalMonthCr
    {
        public int Seq { get; set; }
        public string GroupdataYear { get; set; }
        public string GroupdataMonth { get; set; }
        public string DataType { get; set; }
        public string MonthlyType { get; set; }
        public decimal Sales { get; set; }
        public decimal Ebit { get; set; }
        public decimal EbitRate { get; set; }
        public decimal Pbt { get; set; }
        public decimal NetProfitTerm { get; set; }

        public decimal SalesCr { get; set; }
        public decimal EbitCr { get; set; }
        public decimal EbitRateCr { get; set; }
        public decimal PbtCr { get; set; }
        public decimal NetProfitTermCr { get; set; }
    }
}