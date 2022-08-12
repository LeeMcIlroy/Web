using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class PmPalBusiness
    {
        public int PmPalSeq { get; set; }
        public int Seq { get; set; }
        public int OrgCompanySeq { get; set; }
        public int OrgBusinessSeq { get; set; }
        public string MonthlyType { get; set; }
        public string YearlyYear { get; set; }
        public string Monthly { get; set; }
        public decimal Sales { get; set; }
        public decimal Ebit { get; set; }
        public decimal EbitRate { get; set; }
        public decimal Pbt { get; set; }

        public decimal planSales { get; set; }
        public decimal planEbit { get; set; }
        public decimal planEbitRate { get; set; }
        public decimal planPbt { get; set; }

        public int kind { get; set; }
        public int PmPalBussinessSeq { get; set; }
        public string CompanyName { get; set; }
        public string BusinessName { get; set; }
        public string PalYear { get; set; }

    }
}