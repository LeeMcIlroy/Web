using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class BusinessPerformanceExp : BusinessPerformance
    {
        public List<FileInfo> fileInfoList { get; set; }
    }
}