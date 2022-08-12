using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class PlanGroupdataYear : BaseInfo
    {
        public int RowNum { get; set; }
        public int Seq { get; set; }
        public string GroupdataYear { get; set; }
        public int RegistStatus { get; set; }
        public string Comment { get; set; }
        public string DataType { get; set; }
        public string FinishType { get; set; }
    }
}