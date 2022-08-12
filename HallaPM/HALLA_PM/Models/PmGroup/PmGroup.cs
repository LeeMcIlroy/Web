using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class PmGroup
    {
        public int RowNum { get; set; }
        public string PmYear { get; set; }
        public string Monthly { get; set; }
        public string MenuName { get; set; }
        public string TableName { get; set; }
        public string RegistType { get; set; }
        public string FinishType { get; set; }

        public string CreateDate { get; set; }
        public string CompanyName { get; set; }
    }
}