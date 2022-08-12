using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class JsonGroupDataBs
    {
        
        public int seq { get; set; }
        public List<PlanGroupdataBsMonth> MonthData { get; set; }
        public List<PlanGroupdataBsSummary> SummaryData { get; set; }
        public string strComment { get; set; }
        
    }
}