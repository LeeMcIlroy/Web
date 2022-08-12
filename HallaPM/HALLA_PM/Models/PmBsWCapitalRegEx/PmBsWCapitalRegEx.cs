using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class PmBsWCapitalRegEx
    {
        public int PmBsSeq { get; set; }
        public int Seq { get; set; }
        public decimal Ar { get; set; } = 0;
        public decimal ArToDays { get; set; } = 0;
        public decimal Ap { get; set; } = 0;
        public decimal ApToDays { get; set; } = 0;
        public decimal Inventory { get; set; } = 0;
        public decimal InventoryToDays { get; set; } = 0;
    }
}