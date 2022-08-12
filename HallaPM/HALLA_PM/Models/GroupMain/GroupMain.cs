using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class GroupMain
    {
        public string year { get; set; }
        public string month { get; set; }
        public string unionName { get; set; }
        public int unionSeq { get; set; }

        public string isUse { get; set; }
        public string isDisclosure { get; set; }

        public string companySeq { get; set; } // 추가
        public string companyName { get; set; }
        public int registStatus { get; set; }

        public string ord { get; set; }
        #region << DashBoard >>

        public decimal dashBoardCashFcf { get; set; }
        public decimal DashBoardPlanFcf { get; set; }
        public decimal dashBoardRateFcf { get; set; }
        public decimal dashBoardCashSales { get; set; }
        public decimal DashBoardPlanSales { get; set; }
        
        public decimal dashBoardRateSales { get; set; }
        public decimal dashBoardCashEbit { get; set; }
        public decimal DashBoardCashPlanEbit { get; set; }
        
        public decimal dashBoardCashResultEbit { get; set; }
        public decimal dashBoardRateEbit { get; set; }

        public decimal dashBoardCashPbt { get; set; }
        public decimal DashBoardCashPlanPbt { get; set; }
        public decimal dashBoardRatePbt { get; set; }


        public decimal dashBoardRoic { get; set; }
        public decimal dashBoardplanRoic { get; set; }
        public decimal dashBoardRateRoic { get; set; }

        #endregion

        #region << KPI종합 (KPI Signal) >>

        public int KpiKind { get; set; }
        public decimal kpiSignalRateFcf { get; set; }
        public decimal KpiSignalRateSales { get; set; }
        public decimal KpiSignalRateEbit { get; set; }
        public decimal KpiSignalRatePbt { get; set; }
        public decimal KpiSignalLiabilitiesRate { get; set; }

        public decimal F01 { get; set; }
        public decimal F03 { get; set; }

        public decimal kpiPlanFcf2 { get; set; }
        public decimal kpiResultFcf2 { get; set; }
        public decimal kpiResultSales { get; set; }
        public decimal kpiPlanSales { get; set; }
        public decimal kpiResultEbit { get; set; }
        public decimal kpiPlanEbit { get; set; }
        public decimal kpiResultPbt { get; set; }
        public decimal kpiPlanPbt { get; set; }

        public decimal resultLiabilities { get; set; }
        public decimal resultCapital { get; set; }
        public decimal planLiabilities { get; set; }
        public decimal planCapital { get; set; }

        public decimal kpiRoic { get; set; }
        public decimal kpiPlanRoic { get; set; }

        public decimal AfterTaxOperationProfit { get; set; }
        public decimal PainInCapital { get; set; }

        public decimal planAfterTaxOperationProfit { get; set; }
        public decimal planPainInCapital { get; set; }
        #endregion

        #region << 손익 목표 달성 현황 (KPI X-Y Graph) >>

        public string KpiGraphCompanyName { get; set; }
        public decimal kpiGraphSales { get; set; }
        public decimal kpiGraphSalesRate { get; set; }
        public decimal kpiGraphEbit { get; set; }
        public decimal kpiGraphEbitRate { get; set; }
        public decimal kpiGraphResultRate { get; set; }

        #endregion

        #region << CashFlow >>

        public string groupMainCashFlowValue { get; set; }
        public string groupMainCashFlowName { get; set; }

        #endregion

        #region << 당월 / 누계 손익 >>

        public decimal groupMainPlanSales { get; set; }
        public decimal groupMainResultSales { get; set; }
        public decimal groupMainPlanEbit { get; set; }
        public decimal groupMainResultEbit { get; set; }
        public decimal groupMainBuildSales { get; set; }
        public decimal groupMainCarSales { get; set; }
        public decimal groupMainCompanySales { get; set; }
        public decimal groupMainBuildEbit { get; set; }
        public decimal groupMainCarEbit { get; set; }
        public decimal groupMainCompanyEbit { get; set; }
        public decimal salesCr { get; set; }

        /* 모든회사 당월 손익의 합 */

        public decimal groupMainPlanSalesSum { get; set; }
        public decimal groupMainResultSalesSum { get; set; }
        public decimal groupMainPlanEbitSum { get; set; }
        public decimal groupMainResultEbitSum { get; set; }

        #endregion

        #region << 연간 예상 손익 >>

        public int restSalesKind { get; set; }

        public decimal groupMainExpectPlanSales { get; set; }
        public decimal groupMainExpectResultSales { get; set; }

        public decimal groupMainExpectYearPlanSales { get; set; }
        public decimal groupMainExpectYearResultSales { get; set; }

        public decimal groupMainExpectPlanEbit { get; set; }
        public decimal groupMainExpectResultEbit { get; set; }

        public decimal groupMainExpectYearPlanEbit { get; set; }
        public decimal groupMainExpectYearResultEbit { get; set; }


        public decimal groupMainExpectPlanRestSales { get; set; }
        public decimal groupMainExpectResultRestSales { get; set; }

        public decimal groupMainExpectPlanRestEbit { get; set; }
        public decimal groupMainExpectResultRestEbit { get; set; }

        #endregion

        #region << ROIC >>

        public decimal groupMainRoic { get; set; }
        public decimal groupMainMonthlyRoic { get; set; }

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