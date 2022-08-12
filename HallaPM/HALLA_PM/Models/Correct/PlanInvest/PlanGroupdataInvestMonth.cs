﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models 
{
    public class PlanGroupdataInvestMonth
    {
        public int Seq { get; set; }
        public string GroupdataYear { get; set; }
        public string GroupdataMonth { get; set; }
        public string DataType { get; set; }
        public decimal Investment { get; set; }
        public decimal Personnel { get; set; }
        public decimal DomesticPersonnel { get; set; }
        public decimal OverseasPersonnel { get; set; } 
    }
}