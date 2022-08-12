using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class JsonGroupDataInvest
    {
        public int seq { get; set; }
        public List<PlanGroupdataInvestMonth> MonthData { get; set; } 
        public List<PlanGroupdataInvestSummary> SummaryData { get; set; }
        public string strComment { get; set; }
    }
}