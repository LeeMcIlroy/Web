using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class PmInvestBusiness
    {
        public int PmInvestSeq { get; set; }
        public int Seq { get; set; }
        public int OrgBusinessSeq { get; set; }
        public int MonthlyType { get; set; }
        public decimal Investment { get; set; } = 0;
        public decimal Personnel { get; set; } = 0;
        public decimal DomesticPersonnel { get; set; } = 0;
        public decimal OverseasPersonnel { get; set; } = 0;


        public decimal InvestmentExp { get; set; } = 0;
        public decimal PersonnelExp { get; set; } = 0;
        public decimal DomesticPersonnelExp { get; set; } = 0;
        public decimal OverseasPersonnelExp { get; set; } = 0;

        public string InvestYear { get; set; }
        public string Monthly { get; set; }

        public int OrgCompanySeq { get; set; }
        public string CompanyName { get; set; }

        public int OrgUnionSeq { get; set; }
        public string UnionName { get; set; }
        
        public string BusinessName { get; set; }
    }
}