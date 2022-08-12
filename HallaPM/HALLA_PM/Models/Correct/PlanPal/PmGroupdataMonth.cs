using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class PmGroupdataMonth : BaseInfo
    { 
        public int RowNum { get; set; }
        public int Seq { get; set; }
        public string GroupdataYear { get; set; }
        public string GroupdataMonth { get; set; }
        public int RegistStatus { get; set; }
        public string Comment { get; set; }
        public string DataType { get; set; } 
    }
}