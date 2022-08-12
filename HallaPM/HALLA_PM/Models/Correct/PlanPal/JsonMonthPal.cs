using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class JsonMonthPal
    {
        public int seq { get; set; }
        public List<PlanGroupdataPalMonth> MonthData { get; set; }
        public List<PlanGroupdataPalQuarter> QuarterData { get; set; }
        public List<PlanGroupdataPalSummary> SummaryData { get; set; }
        public string strComment { get; set; }     
    }
}