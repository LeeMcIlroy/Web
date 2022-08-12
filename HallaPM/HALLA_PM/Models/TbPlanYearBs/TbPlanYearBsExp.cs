using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class TbPlanYearBsExp : TbPlanYearBs
    {
        public List<PlanYearBsSummary> planYearBsSummaryList { get; set; }
    }
}