using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class PlanYearCfExp : PlanYearCf
    {
        public List<PlanYearCfSummary> planYearCfSummaryList { get; set; }
    }
}