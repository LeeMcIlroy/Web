using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class PmQuarterAdmin : BaseInfo
    {
        public int RowNum { get; set; }
        public int Seq { get; set; }
        public string QuarterPalYear { get; set; }
        public string Monthly { get; set; }
        public int OrgCompanySeq { get; set; }
        public int RegistStatus { get; set; }
        public string LiabilitiesRateComment { get; set; }

        public int afterRegistStatus { get; set; }

        public string CompanyName { get; set; }
        public string UnionName { get; set; }
        public string WriteAble { get; set; }
        public string AuthUserKey { get; set; }
        public string IsUse { get; set; }
        public string ApplyChk { get; set; }

        public List<int> PmQuarterPalBusinessSeq { get; set; }
        public List<int> PmQuarterPalBusinessSummarySeq { get; set; }

        public List<decimal> Sales { get; set; }
        public List<decimal> Ebit { get; set; }
        public List<decimal> Pbt { get; set; }

        public List<decimal> SalesSummary { get; set; }
        public List<decimal> EbitSummary { get; set; }
        public List<decimal> EbitRateSummary { get; set; }
        public List<decimal> PbtSummary { get; set; }
        public List<decimal> NetProfitTermSummary { get; set; }
    }
}