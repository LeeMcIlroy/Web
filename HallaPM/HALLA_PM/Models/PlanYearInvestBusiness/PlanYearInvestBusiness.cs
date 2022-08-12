﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class PlanYearInvestBusiness
    {
        public int PlanYearInvestSeq { get; set; }
        public int Seq { get; set; }
        public int OrgBusinessSeq { get; set; }
        public string YearlyYear { get; set; }
        //public string Monthly { get; set; }
        public decimal Investment { get; set; }
        public decimal Personnel { get; set; }
        public decimal DomesticPersonnel { get; set; }
        public decimal OverseasPersonnel { get; set; }

        public int OrgCompanySeq { get; set; }
        public string CompanyName { get; set; }
        public string BusinessName { get; set; }

        public int OrgUnionSeq { get; set; }
        public string UnionName { get; set; }
        
    }
}