using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class PmQuarterPalBusiness
    {
        public int PmQuarterPalSeq { get; set; }
        public int Seq { get; set; }
        public int OrgBusinessSeq { get; set; }
        public string CompanyName { get; set; }
        public string BusinessName { get; set;}
        public string BusinessYear { get; set; }
        public int BusinessQuarter { get; set; }
        public int PmQuarterPalBusinessSeq { get; set; }
        public decimal Sales { get; set; }
        public decimal Ebit { get; set; }
        public decimal EbitRate { get; set; }
        public decimal Pbt { get; set; }
    }
}