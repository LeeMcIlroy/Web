using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class TbOrgCompanyExp : TbOrgCompany
    {
        public List<OrgBusinessExp> orgBusinessList { get; set; }
        public List<PlanYearPalBusinessSummary> totalPlanYearPalBusinessSummaryList { get; set; }
        public PmPalBusinessSummaryForPlan totalPmPalBusinessSummary { get; set; }

        public List<PlanMonthlyPalBusinessMonthlySum> totalPlanMonthlyPalBusinessSummaryList { get; set; }
        public List<PlanYearCfSummary> totalPlanYearCfSummaryList { get; set; }

        public PmCashFlowCumulativeSummary pmCashFlowCumulativeSummary { get; set; }
        public List<PmCashFlowCumulativeSummary> pmCashFlowCumulativeDiffSummaryList { get; set; }

        public List<PlanYearBsSummary> totalPlanYearBsSummaryList { get; set; }
        public PmBsSummary pmBsSummary { get; set; }


        public List<PlanYearInvestSummary> totalPlanYearInvestSummaryList { get; set; }
        public PmInvestSum pmInvestSum { get; set; }
    }
}