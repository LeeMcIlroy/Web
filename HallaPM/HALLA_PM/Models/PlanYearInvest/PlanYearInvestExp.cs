﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class PlanYearInvestExp : PlanYearInvest
    {
        public List<PlanYearInvestSummary> planYearInvestSummaryList { get; set; }
    }
}