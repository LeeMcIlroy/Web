using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class PmBsWCapitalEx
    {
        public int PmBsSeq { get; set; }
        public int Seq { get; set; }
        public decimal AnnualSales { get; set; }
        public decimal AnnualSalesCost { get; set; }
        public decimal InventoryCost { get; set; }
    }
}