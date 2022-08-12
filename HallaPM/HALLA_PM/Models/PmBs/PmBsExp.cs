using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class PmBsExp : PmBs
    {
        public int afterRegistStatus { get; set; }
        public string CompanyName { get; set; }
        public string UnionName { get; set; }
        public string WriteAble { get; set; }
        public string AuthUserKey { get; set; }
        public string IsUse { get; set; }
        public string ApplyChk { get; set; }
    }
}