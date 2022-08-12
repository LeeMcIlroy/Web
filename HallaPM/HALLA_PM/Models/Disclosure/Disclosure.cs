using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class Disclosure : BaseInfo
    {
        public int RowNum { get; set; }
        public int Seq { get; set; }

        public int Idx { get; set; }
        public int CpnSeq { get; set; }
        public int RegistStatus { get; set; }
        public int afterRegistStatus { get; set; }
        public string UnionName { get; set; }
        public string CompanyName { get; set; }
        public int CompanySeq { get; set; }
        public int UnionSeq { get; set; }

        public string Year { get; set; }
        public string Month { get; set; }
        public string PlanYn { get; set; }

        public string WriteAble { get; set; }
        public string RejectReason { get; set; }

    }
}