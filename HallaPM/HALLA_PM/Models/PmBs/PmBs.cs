using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class PmBs : BaseInfo
    {
        public int Seq { get; set; }
        public string BsYear { get; set; }
        public string Monthly { get; set; }
        public int OrgCompanySeq { get; set; }
        public int RegistStatus { get; set; }
        // 2018.01.03 반려사유 추가
        public string RejectReson { get; set; }

        public int RowNum { get; set; }
    }
}