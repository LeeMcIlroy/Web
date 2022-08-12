using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class JsonGroupDataPmBs
    {
        public int seq { get; set; }
        public List<PmGroupdataBsMonth> MonthData { get; set; } 
        public string strComment { get; set; }
    }
}