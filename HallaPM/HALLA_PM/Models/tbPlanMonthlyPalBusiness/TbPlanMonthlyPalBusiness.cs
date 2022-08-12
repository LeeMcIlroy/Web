using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class TbPlanMonthlyPalBusiness
    {
        public int planMonthlyPalSeq { get; set; }
        public int seq { get; set; }
        public int orgBusinessSeq { get; set; }
        public string monthly { get; set; }
        public decimal sales { get; set; }
        public decimal ebit { get; set; }
        public decimal ebitRate { get; set; }
        public decimal pbt { get; set; }
    }
}