using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class PmInvestAdmin
    {
        public int Seq { get; set; }
        public string InvestYear { get; set; }
        public string Monthly { get; set; }
        public int OrgCompanySeq { get; set; }
        public int RegistStatus { get; set; }
        // 2018.01.03 반려사유 추가
        public string RejectReson { get; set; }

        public int afterRegistStatus { get; set; }

        public string CompanyName { get; set; }
        public string UnionName { get; set; }
        public string WriteAble { get; set; }
        public string AuthUserKey { get; set; }
        public string IsUse { get; set; }
        public string ApplyChk { get; set; }

        public List<int> PmInvestBusinessSeq { get; set; }
        public List<decimal> Investment { get; set; }
        public List<decimal> Personnel { get; set; }
        public List<decimal> DomesticPersonnel { get; set; }
        public List<decimal> OverseasPersonnel { get; set; }

        public List<int> PmInvestSumSeq { get; set; }
        public List<decimal> SummaryInvestment { get; set; }
        public List<decimal> SummaryPersonnel { get; set; }
        public List<decimal> SummaryDomesticPersonnel { get; set; }
        public List<decimal> SummaryOverseasPersonnel { get; set; }
    }
}