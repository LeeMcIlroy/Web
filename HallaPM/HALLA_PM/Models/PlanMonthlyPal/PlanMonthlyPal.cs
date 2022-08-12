using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class PlanMonthlyPal : BaseInfo
    {
        public int RowNum { get; set; }
        public int Seq { get; set; }
        public string MonthlyPalYear { get; set; }
        public int OrgCompanySeq { get; set; }
        public int RegistStatus { get; set; }

        public int afterRegistStatus { get; set; }

        public string CompanyName { get; set; }
        public string UnionName { get; set; }
        public string WriteAble { get; set; }
        public string AuthUserKey { get; set; }
        public string IsUse { get; set; }
        public string ApplyChk { get; set; }

        public List<int> PlanMonthlyPalBusinessSeq { get; set; }
        public List<decimal> Sales { get; set; }
        public List<decimal> Ebit { get; set; }
        public List<decimal> Pbt { get; set; }

        public List<int> PlanMonthlyPalBusinessMonthlySumSeq { get; set; }
        public List<decimal> MonthSumSales { get; set; }
        public List<decimal> MonthSumEbit { get; set; }
        public List<decimal> MonthSumPbt { get; set; }


        public List<int> PlanMonthlyPalBusinessQuarterSumSeq { get; set; }
        public List<decimal> QuarterSumSales { get; set; }
        public List<decimal> QuarterSumEbit { get; set; }
        public List<decimal> QuarterSumPbt { get; set; }
    }
}