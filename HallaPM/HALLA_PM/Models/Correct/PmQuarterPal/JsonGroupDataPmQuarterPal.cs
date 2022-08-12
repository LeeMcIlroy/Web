using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class JsonGroupDataPmQuarterPal
    {
        public int seq { get; set; }
        public List<PmGroupdataQuarterPalMonth> MonthData { get; set; }
        public string strComment { get; set; }
    }
}