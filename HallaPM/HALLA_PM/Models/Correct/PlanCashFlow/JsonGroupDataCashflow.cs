using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class JsonGroupDataCashflow
    {
        public int seq { get; set; }
        public List<PlanGroupdataCashflowMonth> MonthData { get; set; }
        public List<PlanGroupdataCashflowSummary> SummaryData { get; set; }
        public string strComment { get; set; }
    }
}