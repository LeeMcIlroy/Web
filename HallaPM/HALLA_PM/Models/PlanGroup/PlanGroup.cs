using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class PlanGroup
    {
        public int RowNum { get; set; }
        public string PlanYear { get; set; }
        public string MenuName { get; set; }
        public string TableName { get; set; }
        public string RegistType { get; set; }
        public string FinishType { get; set; } 
    }
}