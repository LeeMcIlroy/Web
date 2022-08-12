using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class PlanYearBsWCapitalRegEx
    {
        public int PlanYearBsSeq { get; set; }
        public int Seq { get; set; }
        public string YearlyYear { get; set; }
        public string Monthly { get; set; }
        public decimal Ar { get; set; }
        public decimal ArToDays { get; set; }
        public decimal Ap { get; set; }
        public decimal ApToDays { get; set; }
        public decimal Inventory { get; set; }
        public decimal InventoryToDays { get; set; }
        public int PlanYearBsWCapitalRegSeq { get; set; }
    }
}