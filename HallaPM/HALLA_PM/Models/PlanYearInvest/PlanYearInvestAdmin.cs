using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class PlanYearInvestAdmin:BaseInfo
    {
        public int RowNum { get; set; }
        public int Seq { get; set; }
        public string YearInvestYear { get; set; }
        public int OrgCompanySeq { get; set; }
        public int RegistStatus { get; set; }

        public int afterRegistStatus { get; set; }

        public string CompanyName { get; set; }
        public string UnionName { get; set; }
        public string WriteAble { get; set; }
        public string AuthUserKey { get; set; }
        public string IsUse { get; set; }
        public string ApplyChk { get; set; }

        public List<int> PlanYearInvestBusinessSeq { get; set; }
        public List<decimal> Investment { get; set; }
        public List<decimal> Personnel { get; set; }
        public List<decimal> DomesticPersonnel { get; set; }
        public List<decimal> OverseasPersonnel { get; set; }

        public List<int> PlanYearInvestSummarySeq { get; set; }
        public List<decimal> SummaryInvestment { get; set; }
        public List<decimal> SummaryPersonnel { get; set; }
        public List<decimal> SummaryDomesticPersonnel { get; set; }
        public List<decimal> SummaryOverseasPersonnel { get; set; }
    }
}