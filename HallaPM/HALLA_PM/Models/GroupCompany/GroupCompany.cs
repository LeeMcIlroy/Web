using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class GroupCompany
    {
        public string year { get; set; }
        public string month { get; set; }
        public string businessName { get; set; }
        public string companyName { get; set; }
        public int businessSeq { get; set; }

        #region << DashBoard >>

        public decimal dashBoardCashFcf { get; set; }
        public decimal DashBoardPlanFcf { get; set; }
        
        public decimal dashBoardRateFcf { get; set; }
        public decimal dashBoardCashSales { get; set; }
        public decimal DashBoardPlanSales { get; set; }
        public decimal dashBoardRateSales { get; set; }
        public decimal dashBoardCashEbit { get; set; }
        public decimal DashBoardCashPlanEbit { get; set; }
        public decimal dashBoardRateEbit { get; set; }
        public decimal dashBoardRoic { get; set; }
        public decimal dashBoardplanRoic { get; set; }

        public decimal dashBoardRateRoic { get; set; }

        #endregion

        #region << CashFlow >>

        public string companyCashFlowValue { get; set; }
        public string companyCashFlowName { get; set; }

        #endregion

        #region << 당월 / 누계 손익 >>

        public decimal companyPlanSales { get; set; }
        public decimal companyResultSales { get; set; }
        public decimal companyTotalSales { get; set; }
        public decimal companyPlanEbit { get; set; }
        public decimal companyResultEbit { get; set; }
        public decimal companyTotalEbit { get; set; }

        #endregion

        #region << 연간 예상 손익 >>

        public int restSalesKind { get; set; }

        public string expectCompanyName { get; set; }
        //Sales - 누계실적
        public decimal companyExpectResultSales { get; set; }
        public decimal companyExpectPlanSales { get; set; }
        public decimal companyExpectTotalSales { get; set; }

        //Sales - 전년 누계실적
        public decimal companyExpectPreYearResultSales { get; set; }
        public decimal companyExpectPreYearPlanSales { get; set; }

        //Sales - 잔여월
        public decimal companyExpectRestResultSales { get; set; }
        public decimal companyExpectRestPlanSales { get; set; }
        public decimal companyExpectRestResultEbit { get; set; }
        public decimal companyExpectRestPlanEbit { get; set; }
        public decimal companyExpectRestTotalSales { get; set; }

        //Sales -  연간예상
        public decimal companyExpectYearPlanSales { get; set; }
        public decimal companyExpectYearResultSales { get; set; }
        public decimal companyExpectYearPlanEbit { get; set; }
        public decimal companyExpectYearResultEbit { get; set; }

        //Sales - 전년 연간예상
        public decimal companyExpectPrevYearResultSales { get; set; }
        public decimal companyExpectPrevYearPlanSales { get; set; }

        public decimal companyExpectResultEbit { get; set; }
        public decimal companyExpectPlanEbit { get; set; }
        public decimal companyExpectTotalEbit { get; set; }

        #endregion

        #region << 재무비율 및 B/S >>

        public decimal companyRoic { get; set; }
        public decimal companyMonthlyRoic { get; set; }

        public int PmBsSeq { get; set; }
        public int Seq { get; set; }
        public decimal Assets { get; set; }
        public decimal Liabilities { get; set; }
        public decimal Capital { get; set; }
        public decimal Cash { get; set; }
        public decimal Loan { get; set; }
        public decimal LiabilitiesRate { get; set; }
        public decimal AfterTaxOperationProfit { get; set; }
        public decimal PainInCapital { get; set; }
        public decimal Roic { get; set; }
        public decimal Ar { get; set; }
        public decimal ArToDays { get; set; }
        public decimal Ap { get; set; }
        public decimal ApToDays { get; set; }
        public decimal Inventory { get; set; }
        public decimal InventoryToDays { get; set; }

        public string bsYear { get; set; }
        public string Monthly { get; set; }

        public int OrgCompanySeq { get; set; }
        //public string CompanyName { get; set; }

        public int OrgUnionSeq { get; set; }
        public string UnionName { get; set; }

        #endregion

        #region << 투자/인원 >>

        public string investYear { get; set; }
        public string monthly { get; set; }
        public int personnel { get; set; }
        public decimal planInvest { get; set; }
        public decimal resultInvest { get; set; }

        #endregion
    }
}
