using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class OrgUnion : BaseInfo
    {
        public int RowNum { get; set; }
        public int Seq { get; set; }
        public string UnionName { get; set; }
        public string IsUse { get; set; }


        public string IsDisclosure { get; set; }

    }
}