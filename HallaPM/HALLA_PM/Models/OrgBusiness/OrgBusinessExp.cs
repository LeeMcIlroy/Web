using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class OrgBusinessExp : OrgBusiness
    {
        public List<PlanYearPalBusinessSummary> planYearPalBusinessSummaryList { get; set; }
        public PmPalBusinessSummaryForPlan pmPalBusinessSummary { get; set; }

        public List<PlanMonthlyPalBusinessMonthlySum> planMonthlyPalBusinessMonthlySumList { get; set; }
    }
}