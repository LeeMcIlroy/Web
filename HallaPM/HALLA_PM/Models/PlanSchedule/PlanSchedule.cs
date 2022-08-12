using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using HALLA_PM.Core;

namespace HALLA_PM.Models
{
    public class PlanSchedule : BaseInfo
    {
        public int RowNum { get; set; }
        public string ScheduleYear { get; set; }
        public string PlanDtStart { get; set; }
        public string PlanDtEnd { get; set; }
        public string ApplyChk { get; set; }
        
        public List<string> RegMonth { get; set; }
        public List<string> RegDtStart { get; set; }
        public List<string> RegDtEnd { get; set; }
    }
}