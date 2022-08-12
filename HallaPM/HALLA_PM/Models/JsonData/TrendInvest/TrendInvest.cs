using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class TrendInvest
    {
        public string InvestYear { get; set; }
        public string Monthly { get; set; }
        public int Qt { get; set; }
        public int NoZ { get; set; }
        public int MonthlyType { get; set; }


        public decimal Investment { get; set; }
        public decimal Personnel { get; set; }
        public decimal DomesticPersonnel { get; set; }
        public decimal OverseasPersonnel { get; set; }


        public int OrgBusinessSeq { get; set; }
        public string BusinessName { get; set; }
        public int OrgCompanySeq { get; set; }
        public string CompanyName { get; set; }
        public int OrgUnionSeq { get; set; }
        public string UnionName { get; set; }
    }
}