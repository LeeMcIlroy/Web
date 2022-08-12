using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class DisclosureItem : BaseInfo
    {
        public int RowNum { get; set; }
        public int Seq { get; set; }
        public string DisName { get; set; }

        public string IsUse { get; set; }
        
    }
}