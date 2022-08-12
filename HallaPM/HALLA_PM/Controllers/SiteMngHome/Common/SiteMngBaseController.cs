using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

using HALLA_PM.Models;

namespace HALLA_PM.Controllers.SiteMngHome
{
    public class SiteMngBaseController : Controller
    {
        /// <summary>
        /// 인사디비의 사원정보
        /// </summary>
        public InsaUserVRepo insaUserVRepo = new InsaUserVRepo();

        public InsaDeptVRepo insaDeptVRepo = new InsaDeptVRepo();

        /// <summary>
        /// 로그인 로그
        /// </summary>
        public AdminAccessLogRepo adminAccessLogRepo = new AdminAccessLogRepo();

        /// <summary>
        /// 조직관리 > 부문
        /// </summary>
        public OrgUnionRepo orgUnionRepo = new OrgUnionRepo();

        /// <summary>
        /// 조직관리 > 회사
        /// </summary>
        public OrgCompanyRepo orgCompanyRepo = new OrgCompanyRepo();

        /// <summary>
        /// 조직관리 > 부문
        /// </summary>
        public OrgBusinessRepo orgBusinessRepo = new OrgBusinessRepo();

        /// <summary>
        /// 공시관리 > 공시항목
        /// </summary>
        public DisclosureItemRepo disclosureItemRepo = new DisclosureItemRepo();

        /// <summary>
        /// 공시관리 > 세부항목
        /// </summary>
        public DisclosureDetailRepo disclosureDetailRepo = new DisclosureDetailRepo();

        /// <summary>
        /// 공시관리 > 공시제목
        /// </summary>
        public DisclosureTitleRepo disclosureTitleRepo = new DisclosureTitleRepo();

        /// <summary>
        /// 공시관리 > 공시등록
        /// </summary>
        public DisclosureRepo disclosureRepo = new DisclosureRepo();

        /// <summary>
        /// 관리자권한관리
        /// </summary>
        public AdminAuthRepo adminAuthRepo = new AdminAuthRepo();

        /// <summary>
        /// 관리자권한관리 > 조직권한
        /// </summary>
        public AdminOrgAuthRepo adminOrgAuthRepo = new AdminOrgAuthRepo();

        /// <summary>
        /// 시스템권한관리
        /// </summary>
        public SystemAuthRepo systemAuthRepo = new SystemAuthRepo();

        /// <summary>
        /// 시스템권한관리 > 메뉴권한
        /// </summary>
        public SystemMenuAuthRepo systemMenuAuthRepo = new SystemMenuAuthRepo();

        /// <summary>
        /// 시스템권한관리 > 조직권한
        /// </summary>
        public SystemOrgAuthRepo systemOrgAuthRepo = new SystemOrgAuthRepo();

        /// <summary>
        /// 등록일정계획
        /// </summary>
        public PlanScheduleRepo planScheduleRepo = new PlanScheduleRepo();

        /// <summary>
        /// 등록일정계획 > 실적등록
        /// </summary>
        public PlanSchedulePerformanceRegRepo planSchedulePerformanceRegRepo = new PlanSchedulePerformanceRegRepo();

        /// <summary>
        /// 사업계획 > 손익월별계획
        /// </summary>
        public PlanMonthlyPalRepo planMonthlyPalRepo = new PlanMonthlyPalRepo();

        /// <summary>
        /// 사업계획 > 손익월별계획 > 부서별
        /// </summary>
        public PlanMonthlyPalBusinessRepo planMonthlyPalBusinessRepo = new PlanMonthlyPalBusinessRepo();

        /// <summary>
        /// 사업계획 > 손익월별계획 > 월별손익요약
        /// </summary>
        public PlanMonthlyPalBusinessMonthlySumRepo planMonthlyPalBusinessMonthlySumRepo = new PlanMonthlyPalBusinessMonthlySumRepo();

        /// <summary>
        /// 사업계획 > 손익월별계획 > 분기별손익요약
        /// </summary>
        public PlanMonthlyPalBusinessQuarterSumRepo planMonthlyPalBusinessQuarterSumRepo = new PlanMonthlyPalBusinessQuarterSumRepo();

        /// <summary>
        /// 사업계획 > 손익중기계획
        /// </summary>
        public PlanYearPalRepo planYearPalRepo = new PlanYearPalRepo();

        /// <summary>
        /// 사업계획 > 손익중기계획 > 부서별
        /// </summary>
        public PlanYearPalBusinessRepo planYearPalBusinessRepo = new PlanYearPalBusinessRepo();

        /// <summary>
        /// 사업계획 > 손익중기계획 > 월별요약
        /// </summary>
        public PlanYearPalBusinessSummaryRepo planYearPalBusinessSummaryRepo = new PlanYearPalBusinessSummaryRepo();

        /// <summary>
        /// 사업계획 > 중기BS
        /// </summary>
        public PlanYearBsRepo planYearBsRepo = new PlanYearBsRepo();

        public PlanYearBsExRepo planYearBsExRepo = new PlanYearBsExRepo();


        /// <summary>
        /// 사업계획 > 중기 BS > B/Sheet
        /// </summary>
        public PlanYearBsBsheetRepo planYearBsBsheetRepo = new PlanYearBsBsheetRepo();
        public PlanYearBsBsheetExRepo planYearBsBsheetExRepo = new PlanYearBsBsheetExRepo();

        /// <summary>
        /// 사업계획 > 중기 BS > ROIC
        /// </summary>
        public PlanYearBsRoicRepo planYearBsRoicRepo = new PlanYearBsRoicRepo();
        public PlanYearBsRoicExRepo planYearBsRoicExRepo = new PlanYearBsRoicExRepo();

        /// <summary>
        /// 사업계획 > 중기 BS > W/Capital
        /// </summary>
        public PlanYearBsWCapitalRepo planYearBsWCapitalRepo = new PlanYearBsWCapitalRepo();
        public PlanYearBsWCapitalExRepo planYearBsWCapitalExRepo = new PlanYearBsWCapitalExRepo();

        /// <summary>
        /// 사업계획 > 중기 BS > W/Capital등록
        /// </summary>
        public PlanYearBsWCapitalRegRepo planYearBsWCapitalRegRepo = new PlanYearBsWCapitalRegRepo();
        public PlanYearBsWCapitalRegExRepo planYearBsWCapitalRegExRepo = new PlanYearBsWCapitalRegExRepo();

        /// <summary>
        /// 사업계획 > 중기 BS > 중기재무계획요약
        /// </summary>
        public PlanYearBsSummaryRepo planYearBsSummaryRepo = new PlanYearBsSummaryRepo();
        public PlanYearBsSummaryExRepo planYearBsSummaryExRepo = new PlanYearBsSummaryExRepo();
        
        /// <summary>
        /// 사업계획 > 중기CF
        /// </summary>
        public PlanYearCfRepo planYearCfRepo = new PlanYearCfRepo();

        /// <summary>
        /// 사업계획 > 중기CF - 영업활동
        /// </summary>
        public PlanYearCfSalesRepo planYearCfSalesRepo = new PlanYearCfSalesRepo();

        /// <summary>
        /// 사업계획 > 중기CF - 투자활동
        /// </summary>
        public PlanYearCfInvestmentRepo planYearCfInvestmentRepo = new PlanYearCfInvestmentRepo();

        /// <summary>
        /// 사업계획 > 중기CF - 재무활동
        /// </summary>
        public PlanYearCfFinancialRepo planYearCfFinancialRepo = new PlanYearCfFinancialRepo();

        /// <summary>
        /// 사업계획 > 중기CF - FCF
        /// </summary>
        public PlanYearCfFcfRepo planYearCfFcfRepo = new PlanYearCfFcfRepo();

        /// <summary>
        /// 사업계획 > 중기CF - 기초기말
        /// </summary>
        public PlanYearCfBeCashRepo planYearCfBeCashRepo = new PlanYearCfBeCashRepo();

        /// <summary>
        /// 사업계획 > 중기CF - 요약
        /// </summary>
        public PlanYearCfSummaryRepo planYearCfSummaryRepo = new PlanYearCfSummaryRepo();

        /// <summary>
        /// 사업계획 > 월별투자인원계획
        /// </summary>
        public PlanMonthlyInvestRepo planMonthlyInvestRepo = new PlanMonthlyInvestRepo();

        public PlanMonthlyInvestBusinessRepo planMonthlyInvestBusinessRepo = new PlanMonthlyInvestBusinessRepo();

        public PlanMonthlyInvestSummaryRepo planMonthlyInvestSummaryRepo = new PlanMonthlyInvestSummaryRepo();

        /// <summary>
        /// 사업계획 > 중기투자인원계획
        /// </summary>
        public PlanYearInvestRepo planYearInvestRepo = new PlanYearInvestRepo();

        public PlanYearInvestBusinessRepo planYearInvestBusinessRepo = new PlanYearInvestBusinessRepo();

        public PlanYearInvestSummaryRepo planYearInvestSummaryRepo = new PlanYearInvestSummaryRepo();

        /// <summary>
        /// 그룹데이터 요약
        /// </summary>
        public PlanGroupRepo planGroupRepo = new PlanGroupRepo();

        /// <summary>
        /// 경영실적 > Cash Flow
        /// </summary>
        public PmCashFlowRepo pmCashFlowRepo = new PmCashFlowRepo();

        /// <summary>
        /// 경영실적 > Cash Flow - 영업활동
        /// </summary>
        public PmCashFlowSalesRepo pmCashFlowSalesRepo = new PmCashFlowSalesRepo();

        /// <summary>
        /// 경영실적 > Cash Flow - 투자활동
        /// </summary>
        public PmCashFlowInvestmentRepo pmCashFlowInvestmentRepo = new PmCashFlowInvestmentRepo();

        /// <summary>
        /// 경영실적 > Cash Flow - 재무활동
        /// </summary>
        public PmCashFlowFinancialRepo pmCashFlowFinancialRepo = new PmCashFlowFinancialRepo();

        /// <summary>
        /// 경영실적 > Cash Flow - 기초기말
        /// </summary>
        public PmCashFlowBeCashRepo pmCashFlowBeCashRepo = new PmCashFlowBeCashRepo();

        /// <summary>
        /// 경영실적 > Cash Flow - FCF
        /// </summary>
        public PmCashFlowFcfRepo pmCashFlowFcfRepo = new PmCashFlowFcfRepo();

        /// <summary>
        /// 경영실적 > Cash Flow - 요약
        /// </summary>
        public PmCashFlowCumulativeRepo pmCashFlowCumulativeRepo = new PmCashFlowCumulativeRepo();

        /// <summary>
        /// 경영실적 > 손익
        /// </summary>
        public PmPalRepo pmPalRepo = new PmPalRepo();

        public PmPalBusinessRepo pmPalBusinessRepo = new PmPalBusinessRepo();

        public PmPalSummaryRepo pmPalSummaryRepo = new PmPalSummaryRepo();

        public PmPalAnalysisRepo pmPalAnalysisRepo = new PmPalAnalysisRepo();

        public PmPalYealyAnalysisRepo pmPalYealyAnalysisRepo = new PmPalYealyAnalysisRepo();

        /// <summary>
        /// 경영실적 > 분기별 손익
        /// </summary>
        public PmQuarterPalRepo pmQuarterPalRepo = new PmQuarterPalRepo();

        public PmQuarterPalBusinessRepo pmQuarterPalBusinessRepo = new PmQuarterPalBusinessRepo();

        public PmQuarterPalBusinessSummaryRepo pmQuarterPalBusinessSummaryRepo = new PmQuarterPalBusinessSummaryRepo();

        /// <summary>
        /// 경영실적 > BS
        /// </summary>
        public PmBsRepo pmBsRepo = new PmBsRepo();
        public PmBsBsheetRepo pmBsBsheetRepo = new PmBsBsheetRepo();
        public PmBsRoicRepo pmBsRoicRepo = new PmBsRoicRepo();
        public PmBsWCapitalRepo pmBsWCapitalRepo = new PmBsWCapitalRepo();
        public PmBsWCapitalRegRepo pmBsWCapitalRegRepo = new PmBsWCapitalRegRepo();
        public PmBsSummaryRepo pmBsSummaryRepo = new PmBsSummaryRepo();

        public PmBsExRepo pmBsExRepo = new PmBsExRepo();
        public PmBsBsheetExRepo pmBsBsheetExRepo = new PmBsBsheetExRepo();
        public PmBsRoicExRepo pmBsRoicExRepo = new PmBsRoicExRepo();
        public PmBsWCapitalExRepo pmBsWCapitalExRepo = new PmBsWCapitalExRepo();
        public PmBsWCapitalRegExRepo pmBsWCapitalRegExRepo = new PmBsWCapitalRegExRepo();
        public PmBsSummaryExRepo pmBsSummaryExRepo = new PmBsSummaryExRepo();


        /// <summary>
        /// 경영실적 > 투자인원계획
        /// </summary>
        public PmInvestRepo pmInvestRepo = new PmInvestRepo();

        public PmInvestBusinessRepo pmInvestBusinessRepo = new PmInvestBusinessRepo();

        public PmInvestSumRepo pmInvestSumRepo = new PmInvestSumRepo();


        public PmGroupRepo pmGroupRepo = new PmGroupRepo();

        public ExcelFileUploadListRepo excelFileUploadListRepo = new ExcelFileUploadListRepo();
    }
}