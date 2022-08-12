using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class PmPal : BaseInfo
    {
        public int RowNum { get; set; }
        public int Seq { get; set; }
        public string PalYear { get; set; }
        public string Monthly { get; set; }
        public int OrgCompanySeq { get; set; }
        public int RegistStatus { get; set; }
        // 2018.01.03 반려사유 추가
        public string RejectReson { get; set; }
        public string LiabilitiesRateComment { get; set; }

        public int afterRegistStatus { get; set; }

        public string CompanyName { get; set; }
        public string UnionName { get; set; }
        public string WriteAble { get; set; }
        public string AuthUserKey { get; set; }
        public string IsUse { get; set; }
        public string ApplyChk { get; set; }
    }
}