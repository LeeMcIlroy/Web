using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class PlanYearPalAdmin : BaseInfo
    {
        public int RowNum { get; set; }
        public int Seq { get; set; }
        public string YearPalYear { get; set; }
        public int OrgCompanySeq { get; set; }
        public int RegistStatus { get; set; }

        public int afterRegistStatus { get; set; }

        public string CompanyName { get; set; }
        public string UnionName { get; set; }
        public string WriteAble { get; set; }
        public string AuthUserKey { get; set; }
        public string IsUse { get; set; }
        public string ApplyChk { get; set; }

        //
        public List<int> PlanYearPalBusinessSeq { get; set; }
        public List<decimal> Sales { get; set; }
        public List<decimal> Ebit { get; set; }
        public List<decimal> Pbt { get; set; }

        //손익요약
        public List<int> PlanYearPalBusinessSummarySeq { get; set; }
        public List<decimal> MonthSumSales { get; set; }
        public List<decimal> MonthSumEbit { get; set; }
        public List<decimal> MonthSumPbt { get; set; }
        

    }
}