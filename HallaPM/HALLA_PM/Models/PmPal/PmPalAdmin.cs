using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class PmPalAdmin : BaseInfo
    {
        public int RowNum { get; set; }
        public int Seq { get; set; }
        public string PalYear { get; set; }
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

        public List<int> PmPalSeq { get; set; }
        public List<int> PmPalBusinessSeq { get; set; }
        public List<int> PmPalSummarySeq { get; set; }
        public List<string> monthlyType { get; set; }
        public List<decimal> Sales { get; set; }
        public List<decimal> Ebit { get; set; }
        public List<decimal> EbitRate { get; set; }
        public List<decimal> Pbt { get; set; }

        public List<decimal> SalesSummary { get; set; }
        public List<decimal> EbitSummary { get; set; }
        public List<decimal> EbitRateSummary { get; set; }
        public List<decimal> PbtSummary { get; set; }
        public List<decimal> NetProfitTermSummary { get; set; }

        //손익분석 - 매출차이
        public int MonthlyCount { get; set; }
        public List<int> PmPalAnalysisSeq { get; set; }
        public List<string> MonthlyContent { get; set; }
        public List<decimal> MonthlyValue { get; set; }
        public List<string> CumulativeContent { get; set; }
        public List<decimal> CumulativeValue { get; set; }

        //손익분석 - 영업이익 차이
        public int SalesMonthlyCount { get; set; }
        public List<int> PmPalAnalysisSalesSeq { get; set; }
        public List<string> SalesMonthlyContent { get; set; }
        public List<decimal> SalesMonthlyValue { get; set; }
        public List<string> SalesCumulativeContent { get; set; }
        public List<decimal> SalesCumulativeValue { get; set; }

        //손익분석 - 경상이익 차이
        public int CurrentMonthlyCount { get; set; }
        public List<int> PmPalAnalysisCurrentSeq { get; set; }
        public List<string> CurrentMonthlyContent { get; set; }
        public List<decimal> CurrentMonthlyValue { get; set; }
        public List<string> CurrentCumulativeContent { get; set; }
        public List<decimal> CurrentCumulativeValue { get; set; }

        //손익분석 - 당기순이익 차이
        public int TermMonthlyCount { get; set; }
        public List<string> TermMonthlyContent { get; set; }
        public List<decimal> TermMonthlyValue { get; set; }
        public List<string> TermCumulativeContent { get; set; }
        public List<decimal> TermCumulativeValue { get; set; }

        //연간손익분석 - 매출차이
        public int YealyCount { get; set; }
        public List<int> PmPalYealySeq { get; set; }
        public List<string> DiffMonthlyContent { get; set; }
        public List<decimal> DiffMonthlyValue { get; set; }
        public List<string> DiffYealyContent { get; set; }
        public List<decimal> DiffYealyValue { get; set; }

        //연간손익분석 - 영업이익 차이
        public int SalesYealyCount { get; set; }
        public List<string> DiffSalesMonthlyContent { get; set; }
        public List<decimal> DiffSalesMonthlyValue { get; set; }
        public List<string> DiffSalesYealyContent { get; set; }
        public List<decimal> DiffSalesYealyValue { get; set; }

        //연간손익분석 - 경상이익 차이
        public int CurrentYealyCount { get; set; }
        public List<string> DiffCurrentMonthlyContent { get; set; }
        public List<decimal> DiffCurrentMonthlyValue { get; set; }
        public List<string> DiffCurrentYealyContent { get; set; }
        public List<decimal> DiffCurrentYealyValue { get; set; }

        //연간손익분석 - 당기순 이익
        public int TermYealyCount { get; set; }
        public List<string> DiffTermMonthlyContent { get; set; }
        public List<decimal> DiffTermMonthlyValue { get; set; }
        public List<string> DiffTermYealyContent { get; set; }
        public List<decimal> DiffTermYealyValue { get; set; }
    }
}