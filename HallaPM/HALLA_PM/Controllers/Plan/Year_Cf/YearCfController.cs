using HALLA_PM.Models;
using HALLA_PM.Util;
using System;
using System.Collections.Generic;
using System.Dynamic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using HALLA_PM.Core;

namespace HALLA_PM.Controllers
{
    [SystemLoginFilter]
    [SystemAuthFilter(MenuAuth = 2)]
    [RoutePrefix("Plan/Year_Cf")]
    public class YearCfController : Controller
    {

        TbOrgCompanyRepo tbOrgCompanyRepo = new TbOrgCompanyRepo();
        PlanYearCfRepo planYearCfRepo = new PlanYearCfRepo();
        PmCashFlowRepo pmCashFlowRepo = new PmCashFlowRepo();
        OrgUnionRepo orgUnionRepo = new OrgUnionRepo();

        PageAuthRepo pageAuthRepo = new PageAuthRepo();                 // 권한체크용
        MemberSession mSession = SessionManager.GetMemberSession();     // 사용자정보

        PmCashFlowCumulativeRepo pmCashFlowCumulativeRepo = new PmCashFlowCumulativeRepo();
        PlanYearCfSummaryRepo planYearCfSummaryRepo = new PlanYearCfSummaryRepo();
        PlanGroupdataCashflowSummaryRepo planGroupdataCashflowSummaryRepo = new PlanGroupdataCashflowSummaryRepo();
        private PlanGroupRepo planGroupRepo = new PlanGroupRepo();

        [Route("NewIndex")]
        public ActionResult NewIndex(Search search)
        {
            string year = SessionManager.GetMemberSession().planYear.First().RegistYear;
            search.year = year;
            string AuthUserKey = mSession.insaUserV.userKey;
            // 그룹권한 체크
            var lvGroup = pageAuthRepo.GetGroupAuth(new { AuthUserKey = AuthUserKey }).ToList();
            var lvCompany = pageAuthRepo.GetCompanyAuth(new { AuthUserKey = AuthUserKey }).ToList();

            // 작년도 실적
            List<PmCashFlowCumulativeExp> pmLastYear = pmCashFlowCumulativeRepo.selectListpmLastYear(search).ToList();
            List<PlanYearCfSummaryExp> pnThisYear = planYearCfSummaryRepo.selectListpnThisYear(search).ToList();

            dynamic model = new ExpandoObject();
            model.lvGroup = lvGroup;
            model.lvCompany = lvCompany;
            model.pmLastYear = pmLastYear;
            model.pnThisYear = pnThisYear;

            return View("~/Views/Plan/Year_Cf/NewIndex.cshtml", model);
        }

        [Route("NewIndex2")]
        public ActionResult NewIndex2(Search search)
        {
            string year = SessionManager.GetMemberSession().planYear.First().RegistYear;
            search.year = year;
            string AuthUserKey = mSession.insaUserV.userKey;
            // 그룹권한 체크
            var lvGroup = pageAuthRepo.GetGroupAuth(new { AuthUserKey = AuthUserKey }).ToList();
            var lvCompany = pageAuthRepo.GetCompanyAuth(new { AuthUserKey = AuthUserKey }).ToList();

            // 작년도 실적
            List<PmCashFlowCumulativeExp> pmLastYear = pmCashFlowCumulativeRepo.selectListpmLastYear(search).ToList();
            List<PlanYearCfSummaryExp> pnThisYear = planYearCfSummaryRepo.selectListpnThisYear(search).ToList();
            

            dynamic model = new ExpandoObject();
            model.lvGroup = lvGroup;
            model.lvCompany = lvCompany;
            model.pmLastYear = pmLastYear;
            model.pnThisYear = pnThisYear;  
            model.pnCashFlow = planGroupdataCashflowSummaryRepo.selectList(new { PLANYEAR = search.year });

            return View("~/Views/Plan/Year_Cf/NewIndex2.cshtml", model);
        }

        [Route("NewIndex_excel")]
        public ActionResult NewIndex_excel(Search search)
        {
            string year = SessionManager.GetMemberSession().planYear.First().RegistYear;
            search.year = year;
            string AuthUserKey = mSession.insaUserV.userKey;
            // 그룹권한 체크
            var lvGroup = pageAuthRepo.GetGroupAuth(new { AuthUserKey = AuthUserKey }).ToList();
            var lvCompany = pageAuthRepo.GetCompanyAuth(new { AuthUserKey = AuthUserKey }).ToList();

            // 작년도 실적
            List<PmCashFlowCumulativeExp> pmLastYear = pmCashFlowCumulativeRepo.selectListpmLastYear(search).ToList();
            List<PlanYearCfSummaryExp> pnThisYear = planYearCfSummaryRepo.selectListpnThisYear(search).ToList();

            dynamic model = new ExpandoObject();
            model.lvGroup = lvGroup;
            model.lvCompany = lvCompany;
            model.pmLastYear = pmLastYear;
            model.pnThisYear = pnThisYear;

            return View("~/Views/Plan/Year_Cf/NewIndex_excel.cshtml", model);
        }

        [Route("ExcelYearCf")]
        public ActionResult ExcelYearCf(Search search)
        {
            string PlanYear = SessionManager.GetMemberSession().planYear.First().RegistYear;
            string TableName = "PLAN_YEAR_CF";
            search.year = PlanYear;
            string AuthUserKey = mSession.insaUserV.userKey;
            // 그룹권한 체크
            List<LevelTwo> lvGroup = pageAuthRepo.GetGroupAuth(new { AuthUserKey = AuthUserKey }).ToList();
            List<LevelTwo> lvUnion = pageAuthRepo.GetUnionAuth(new { AuthUserKey = AuthUserKey }).ToList();
            List<LevelTwo> lvCompany = pageAuthRepo.GetCompanyAuth(new { AuthUserKey = AuthUserKey }).ToList();

            var chk = planGroupRepo.selectListAll(new { }).ToList().Where(w => w.PlanYear == PlanYear).Where(w => w.TableName == TableName).FirstOrDefault();

            // 2019.02.07 관리자화면과 동일하게 데이터 가져오게 변경
            List<PmCashFlowCumulativeExp> lastPmC = pmCashFlowCumulativeRepo.selectListLastYearPn2(new { YearlyYear = PlanYear }).ToList();
            List<PmCashFlowCumulative> lastPmC2 = pmCashFlowCumulativeRepo.selectListLastYear2(new { Year = PlanYear }).ToList();

            //List<PmCashFlowCumulativeExp> lastPmC = pmCashFlowCumulativeRepo.selectListpmLastYear(new { year = PlanYear }).ToList();
            List<PlanYearCfSummaryExp> thisPnC = planYearCfSummaryRepo.selectListpnThisYear(new { year = PlanYear }).ToList();

            dynamic model = new ExpandoObject();
            model.chk = chk;
            model.lvGroup = lvGroup;
            model.lvUnion = lvUnion;
            model.lvCompany = lvCompany;

            model.lastPmC = lastPmC;
            model.lastPmC2 = lastPmC2;
            model.thisPnC = thisPnC;

            return View("~/Views/Plan/Year_Cf/ExcelYearCf.cshtml", model);
        }

        [Route("ExcelYearCf_New")]
        public ActionResult ExcelYearCf_New(Search search)
        {
            string PlanYear = SessionManager.GetMemberSession().planYear.First().RegistYear;
            string TableName = "PLAN_YEAR_CF";
            search.year = PlanYear;
            string AuthUserKey = mSession.insaUserV.userKey;
            // 그룹권한 체크
            List<LevelTwo> lvGroup = pageAuthRepo.GetGroupAuth(new { AuthUserKey = AuthUserKey }).ToList();
            List<LevelTwo> lvUnion = pageAuthRepo.GetUnionAuth(new { AuthUserKey = AuthUserKey }).ToList();
            List<LevelTwo> lvCompany = pageAuthRepo.GetCompanyAuth(new { AuthUserKey = AuthUserKey }).ToList();

            var chk = planGroupRepo.selectListAll(new { }).ToList().Where(w => w.PlanYear == PlanYear).Where(w => w.TableName == TableName).FirstOrDefault();

            // 2019.02.07 관리자화면과 동일하게 데이터 가져오게 변경
            List<PmCashFlowCumulativeExp> lastPmC = pmCashFlowCumulativeRepo.selectListLastYearPn2(new { YearlyYear = PlanYear }).ToList();
            List<PmCashFlowCumulative> lastPmC2 = pmCashFlowCumulativeRepo.selectListLastYear2(new { Year = PlanYear }).ToList();

            //List<PmCashFlowCumulativeExp> lastPmC = pmCashFlowCumulativeRepo.selectListpmLastYear(new { year = PlanYear }).ToList();
            List<PlanYearCfSummaryExp> thisPnC = planYearCfSummaryRepo.selectListpnThisYear(new { year = PlanYear }).ToList();

            dynamic model = new ExpandoObject();
            model.chk = chk;
            model.lvGroup = lvGroup;
            model.lvUnion = lvUnion;
            model.lvCompany = lvCompany;

            model.lastPmC = lastPmC;
            model.lastPmC2 = lastPmC2;
            model.thisPnC = thisPnC;
            model.thisGroupPlan = planGroupdataCashflowSummaryRepo.selectList(new { PLANYEAR = search.year });

            return View("~/Views/Plan/Year_Cf/ExcelYearCf_New.cshtml", model);
        }

        [Route("ViewYearCf")]
        public ActionResult ViewYearCf(Search search)
        {
            string PlanYear = SessionManager.GetMemberSession().planYear.First().RegistYear;
            string TableName = "PLAN_YEAR_CF";
            search.year = PlanYear;
            string AuthUserKey = mSession.insaUserV.userKey;
            // 그룹권한 체크
            List<LevelTwo> lvGroup = pageAuthRepo.GetGroupAuth(new { AuthUserKey = AuthUserKey }).ToList();
            List<LevelTwo> lvUnion = pageAuthRepo.GetUnionAuth(new { AuthUserKey = AuthUserKey }).ToList();
            List<LevelTwo> lvCompany = pageAuthRepo.GetCompanyAuth(new { AuthUserKey = AuthUserKey }).ToList();

            var chk = planGroupRepo.selectListAll(new { }).ToList().Where(w => w.PlanYear == PlanYear).Where(w => w.TableName == TableName).FirstOrDefault();

            // 2019.02.07 관리자화면과 동일하게 데이터 가져오게 변경
            List<PmCashFlowCumulativeExp> lastPmC = pmCashFlowCumulativeRepo.selectListLastYearPn2(new { YearlyYear = PlanYear }).ToList();
            List<PmCashFlowCumulative> lastPmC2 = pmCashFlowCumulativeRepo.selectListLastYear2(new { Year = PlanYear }).ToList();

            //List<PmCashFlowCumulativeExp> lastPmC = pmCashFlowCumulativeRepo.selectListpmLastYear(new { year = PlanYear }).ToList();
            List<PlanYearCfSummaryExp> thisPnC = planYearCfSummaryRepo.selectListpnThisYear(new { year = PlanYear }).ToList();

            dynamic model = new ExpandoObject();
            model.chk = chk;
            model.lvGroup = lvGroup;
            model.lvUnion = lvUnion;
            model.lvCompany = lvCompany;

            model.lastPmC = lastPmC;
            model.lastPmC2 = lastPmC2;
            model.thisPnC = thisPnC;

            return View("~/Views/Plan/Year_Cf/ViewYearCf.cshtml", model);
        }

        [Route("Index")]
        public ActionResult Index(Search search)
        {

            string year = SessionManager.GetMemberSession().planYear.First().RegistYear;

            dynamic model = new ExpandoObject();

            // UNION 리스트 
            List<OrgUnionExp> orgUnionList = (List<OrgUnionExp>)orgUnionRepo.selectListExp(new { });

            // 계열사 리스트
            List<TbOrgCompanyExp> tbOrgCompanyList = (List<TbOrgCompanyExp>)tbOrgCompanyRepo.selectListByPlanYearCf(new { year = year });

            // 하단 도표 데이터 가져오기 
            // 현재년도 기준으로 5개년 정보 가져오기 
            List<PlanYearCfExp> planYearCfList = (List<PlanYearCfExp>)planYearCfRepo.selectListExp(new { year = year });

            // 계열사 별 5개년 정보 처리 
            tbOrgCompanyList = parsePlanYearCfSummary(tbOrgCompanyList, planYearCfList);

            // 현재년도 기준 전년도 실적 가져오기 : tbOrgCompanyList 매핑 
            tbOrgCompanyList = getPrevPlanYearCfSummary(tbOrgCompanyList, Convert.ToInt32(year)-1);

            // 전년대비 데이터 처리 
            tbOrgCompanyList = parsePlanYearCfDiffSummary(tbOrgCompanyList);

            // 그룹사 전체에 대한 데이터 처리
            List<PlanYearCfSummary> groupTotalSummaryList = parseGroupTotalSummary(tbOrgCompanyList);

            // 화면 발송 모델
            model.tbOrgCompanyList = tbOrgCompanyList;
            model.groupTotalSummaryList = groupTotalSummaryList;
            model.year = year;
            return View("~/Views/Plan/Year_Cf/Index.cshtml", model);
        }


        [Route("Index_excel")]
        public ActionResult IndexExcel(Search search)
        {

            string year = SessionManager.GetMemberSession().planYear.First().RegistYear;

            dynamic model = new ExpandoObject();

            // UNION 리스트 
            List<OrgUnionExp> orgUnionList = (List<OrgUnionExp>)orgUnionRepo.selectListExp(new { });

            // 계열사 리스트
            List<TbOrgCompanyExp> tbOrgCompanyList = (List<TbOrgCompanyExp>)tbOrgCompanyRepo.selectListByPlanYearCf(new { year = year });

            // 하단 도표 데이터 가져오기 
            // 현재년도 기준으로 5개년 정보 가져오기 
            List<PlanYearCfExp> planYearCfList = (List<PlanYearCfExp>)planYearCfRepo.selectListExp(new { year = year });

            // 계열사 별 5개년 정보 처리 
            tbOrgCompanyList = parsePlanYearCfSummary(tbOrgCompanyList, planYearCfList);

            // 현재년도 기준 전년도 실적 가져오기 : tbOrgCompanyList 매핑 
            tbOrgCompanyList = getPrevPlanYearCfSummary(tbOrgCompanyList, Convert.ToInt32(year) - 1);

            // 전년대비 데이터 처리 
            tbOrgCompanyList = parsePlanYearCfDiffSummary(tbOrgCompanyList);

            // 그룹사 전체에 대한 데이터 처리
            List<PlanYearCfSummary> groupTotalSummaryList = parseGroupTotalSummary(tbOrgCompanyList);

            // 화면 발송 모델
            model.tbOrgCompanyList = tbOrgCompanyList;
            model.groupTotalSummaryList = groupTotalSummaryList;
            model.year = year;
            return View("~/Views/Plan/Year_Cf/Index_excel.cshtml", model);
        }

        public List<TbOrgCompanyExp> parsePlanYearCfSummary(List<TbOrgCompanyExp> tbOrgCompanyList, List<PlanYearCfExp> planYearCfList)
        {
            foreach(var company in tbOrgCompanyList)
            {
                PlanYearCfExp planYearCfExp = planYearCfList.Where(x => x.OrgCompanySeq == company.seq).FirstOrDefault();
                if(planYearCfExp != null)
                {
                    company.totalPlanYearCfSummaryList = planYearCfExp.planYearCfSummaryList;
                }
            }

            return tbOrgCompanyList;
        }

        public List<TbOrgCompanyExp> getPrevPlanYearCfSummary(List<TbOrgCompanyExp> tbOrgCompanyList, int year)
        {
            foreach(var company in tbOrgCompanyList)
            {
                company.pmCashFlowCumulativeSummary = pmCashFlowRepo.selectOnePrevCashFlowSummary(new { year = year, orgCompanySeq = company.seq });
                if(company.pmCashFlowCumulativeSummary == null)
                {
                    PmCashFlowCumulativeSummary summary = new PmCashFlowCumulativeSummary();
                    summary.cashFlowYear = year.ToString();
                    summary.endingCash = 0;
                    summary.availableCash = 0;
                    summary.fcf2 = 0;
                    summary.ebitda = 0;
                    summary.wcSum = 0;
                    summary.etc = 0;
                    summary.financialCost = 0;
                    summary.netCapexSum = 0;

                    company.pmCashFlowCumulativeSummary = summary;
                }
            }
            return tbOrgCompanyList;
        }

        public List<TbOrgCompanyExp> parsePlanYearCfDiffSummary(List<TbOrgCompanyExp> tbOrgCompanyList)
        {
            
            foreach (var company in tbOrgCompanyList)
            {
                List<PmCashFlowCumulativeSummary> diffSummaryList = new List<PmCashFlowCumulativeSummary>();
                for (int i = 0; i < company.totalPlanYearCfSummaryList.Count() ; i++)
                {
                    PmCashFlowCumulativeSummary summary = new PmCashFlowCumulativeSummary();
                    if (i == 0)
                    {
                        // 전년 company.pmCashFlowCumulativeSummary
                        // 현재 company.totalPlanYearCfSummaryList[i]
                        summary.sales = company.pmCashFlowCumulativeSummary.ebitda + company.pmCashFlowCumulativeSummary.wcSum + company.pmCashFlowCumulativeSummary.etc + company.pmCashFlowCumulativeSummary.financialCost;

                        summary.sales = Math.Round(company.totalPlanYearCfSummaryList[i].CfSales - company.pmCashFlowCumulativeSummary.sales, 2, MidpointRounding.AwayFromZero);
                        summary.investment = Math.Round(company.totalPlanYearCfSummaryList[i].CfInvestment - company.pmCashFlowCumulativeSummary.netCapexSum, 2, MidpointRounding.AwayFromZero);

                        summary.endingCash = Math.Round(company.totalPlanYearCfSummaryList[i].CfEndingCash - company.pmCashFlowCumulativeSummary.endingCash, 2, MidpointRounding.AwayFromZero);
                        summary.availableCash = Math.Round(company.totalPlanYearCfSummaryList[i].CfAvailableCash - company.pmCashFlowCumulativeSummary.availableCash, 2, MidpointRounding.AwayFromZero);
                        summary.fcf2 = Math.Round(company.totalPlanYearCfSummaryList[i].Fcf2 - company.pmCashFlowCumulativeSummary.fcf2, 2, MidpointRounding.AwayFromZero);
                        summary.cashFlowYear = company.totalPlanYearCfSummaryList[i].YearlyYear;
                        diffSummaryList.Add(summary);
                    }
                    else
                    {
                        summary.sales = Math.Round(company.totalPlanYearCfSummaryList[i].CfSales - company.totalPlanYearCfSummaryList[i-1].CfSales, 2, MidpointRounding.AwayFromZero);
                        summary.investment = Math.Round(company.totalPlanYearCfSummaryList[i].CfInvestment - company.totalPlanYearCfSummaryList[i-1].CfInvestment, 2, MidpointRounding.AwayFromZero);

                        summary.endingCash = Math.Round(company.totalPlanYearCfSummaryList[i].CfEndingCash - company.totalPlanYearCfSummaryList[i-1].CfEndingCash, 2, MidpointRounding.AwayFromZero);
                        summary.availableCash = Math.Round(company.totalPlanYearCfSummaryList[i].CfAvailableCash - company.totalPlanYearCfSummaryList[i-1].CfAvailableCash, 2, MidpointRounding.AwayFromZero);
                        summary.fcf2 = Math.Round(company.totalPlanYearCfSummaryList[i].Fcf2 - company.totalPlanYearCfSummaryList[i-1].Fcf2, 2, MidpointRounding.AwayFromZero);
                        summary.cashFlowYear = company.totalPlanYearCfSummaryList[i].YearlyYear;
                        diffSummaryList.Add(summary);
                    }
                }
                company.pmCashFlowCumulativeDiffSummaryList = diffSummaryList;
            }

            return tbOrgCompanyList;
        }

        public List<PlanYearCfSummary> parseGroupTotalSummary(List<TbOrgCompanyExp> tbOrgComanyList)
        {
            List<PlanYearCfSummary> resultList = new List<PlanYearCfSummary>();

            foreach(var company in tbOrgComanyList)
            {
                // 전년도 처리
                if (resultList.Where(x => x.YearlyYear == company.pmCashFlowCumulativeSummary.cashFlowYear).FirstOrDefault() != null)
                {
                    resultList.Where(x => x.YearlyYear == company.pmCashFlowCumulativeSummary.cashFlowYear).FirstOrDefault().YearlyYear = company.pmCashFlowCumulativeSummary.cashFlowYear;
                    resultList.Where(x => x.YearlyYear == company.pmCashFlowCumulativeSummary.cashFlowYear).FirstOrDefault().CfSales += company.pmCashFlowCumulativeSummary.ebitda + company.pmCashFlowCumulativeSummary.wcSum + company.pmCashFlowCumulativeSummary.etc + company.pmCashFlowCumulativeSummary.financialCost;
                    resultList.Where(x => x.YearlyYear == company.pmCashFlowCumulativeSummary.cashFlowYear).FirstOrDefault().CfInvestment += company.pmCashFlowCumulativeSummary.netCapexSum;
                    resultList.Where(x => x.YearlyYear == company.pmCashFlowCumulativeSummary.cashFlowYear).FirstOrDefault().Fcf2 += company.pmCashFlowCumulativeSummary.fcf2;
                }
                else
                {
                    PlanYearCfSummary info = new PlanYearCfSummary();
                    info.YearlyYear = company.pmCashFlowCumulativeSummary.cashFlowYear;
                    info.CfSales = company.pmCashFlowCumulativeSummary.ebitda + company.pmCashFlowCumulativeSummary.wcSum + company.pmCashFlowCumulativeSummary.etc + company.pmCashFlowCumulativeSummary.financialCost;
                    info.CfInvestment = company.pmCashFlowCumulativeSummary.netCapexSum;
                    info.Fcf2 = company.pmCashFlowCumulativeSummary.fcf2;
                    resultList.Add(info);
                }

                // 기준년도 5개년 처리 
                foreach (var summary in company.totalPlanYearCfSummaryList)
                {
                    if (resultList.Where(x => x.YearlyYear == summary.YearlyYear).FirstOrDefault() != null)
                    {
                        resultList.Where(x => x.YearlyYear == summary.YearlyYear).FirstOrDefault().CfSales += summary.CfSales;
                        resultList.Where(x => x.YearlyYear == summary.YearlyYear).FirstOrDefault().CfInvestment += summary.CfInvestment;
                        resultList.Where(x => x.YearlyYear == summary.YearlyYear).FirstOrDefault().CfFinancial += summary.CfFinancial;
                        resultList.Where(x => x.YearlyYear == summary.YearlyYear).FirstOrDefault().CfSum += summary.CfSum;
                        resultList.Where(x => x.YearlyYear == summary.YearlyYear).FirstOrDefault().CfEndingCash += summary.CfEndingCash;
                        resultList.Where(x => x.YearlyYear == summary.YearlyYear).FirstOrDefault().CfAvailableCash += summary.CfAvailableCash;
                        resultList.Where(x => x.YearlyYear == summary.YearlyYear).FirstOrDefault().Fcf1 += summary.Fcf1;
                        resultList.Where(x => x.YearlyYear == summary.YearlyYear).FirstOrDefault().Fcf2 += summary.Fcf2;
                        resultList.Where(x => x.YearlyYear == summary.YearlyYear).FirstOrDefault().Fcf3 += summary.Fcf3;
                    }
                    else
                    {
                        PlanYearCfSummary info = new PlanYearCfSummary();
                        info.YearlyYear = summary.YearlyYear;
                        info.CfSales = summary.CfSales;
                        info.CfInvestment = summary.CfInvestment;
                        info.CfFinancial = summary.CfFinancial;
                        info.CfSum = summary.CfSum;
                        info.CfEndingCash = summary.CfEndingCash;
                        info.CfAvailableCash = summary.CfAvailableCash;
                        info.Fcf1 = summary.Fcf1;
                        info.Fcf2 = summary.Fcf2;
                        info.Fcf3 = summary.Fcf3;
                        resultList.Add(info);
                    }
                }
            }

            return resultList;
        }
    }
}