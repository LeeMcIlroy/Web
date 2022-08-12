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
    [RoutePrefix("Plan/Year_Invest")]
    public class YearInvestController : Controller
    {
        OrgUnionRepo orgUnionRepo = new OrgUnionRepo();
        TbOrgCompanyRepo tbOrgCompanyRepo = new TbOrgCompanyRepo();
        PlanYearInvestRepo planYearInvestRepo = new PlanYearInvestRepo();
        PmInvestSumRepo pmInvestSumRepo = new PmInvestSumRepo();

        PageAuthRepo pageAuthRepo = new PageAuthRepo();                 // 권한체크용
        MemberSession mSession = SessionManager.GetMemberSession();     // 사용자정보

        private PlanGroupRepo planGroupRepo = new PlanGroupRepo();
        private PmInvestBusinessRepo pmInvestBusinessRepo = new PmInvestBusinessRepo();
        private PlanYearInvestBusinessRepo planYearInvestBusinessRepo = new PlanYearInvestBusinessRepo();
        private PlanYearInvestSummaryRepo planYearInvestSummaryRepo = new PlanYearInvestSummaryRepo();
        private PlanGroupdataInvestSummaryRepo planGroupdataInvestSummaryRepo = new PlanGroupdataInvestSummaryRepo();

        [Route("Index")]
        public ActionResult Index(Search search)
        {
            string year = SessionManager.GetMemberSession().planYear.First().RegistYear;
            string AuthUserKey = mSession.insaUserV.userKey;
            // 2019.02.08 그룹권한 체크
            List<LevelTwo> lvGroup = pageAuthRepo.GetGroupAuth(new { AuthUserKey = AuthUserKey }).ToList();
            List<LevelTwo> lvUnion = pageAuthRepo.GetUnionAuth(new { AuthUserKey = AuthUserKey }).ToList();
            List<LevelTwo> lvCompany = pageAuthRepo.GetCompanyAuth(new { AuthUserKey = AuthUserKey }).ToList();
            dynamic model = new ExpandoObject();

            // 계열사 리스트
            List<TbOrgCompanyExp> tbOrgCompanyList = (List<TbOrgCompanyExp>)tbOrgCompanyRepo.selectListByPlanYearInvest(new { year = year });

            // 계열사별 Summary 가져오기 
            List<PlanYearInvestExp> planYearInvestList = (List<PlanYearInvestExp>)planYearInvestRepo.selectListExp(new { year = year });

            // 계열사별 Summary 가져오기 후처리 
            tbOrgCompanyList = parsePlanYearInvestSummary(tbOrgCompanyList, planYearInvestList);

            // 전년도 데이터 가져오기 
            tbOrgCompanyList = getPrevPlanYearInvestSummary(tbOrgCompanyList, Convert.ToInt32(year) - 1);

            // 그룹사 통합 데이터 만들기
            List<PlanYearInvestSummary> groupTotalSummaryList = parseGroupTotalSummary(tbOrgCompanyList);
            //model.groupTotalSummaryList_NEW = planGroupdataInvestSummaryRepo.groupSelectList(new { year = year });

            model.lvGroup = lvGroup;
            model.lvUnion = lvUnion;
            model.lvCompany = lvCompany;

            // 화면 발송 모델
            model.groupTotalSummaryList = groupTotalSummaryList;
            model.tbOrgCompanyList = tbOrgCompanyList;
            model.year = year;
            return View("~/Views/Plan/Year_Invest/Index.cshtml", model);
        }

        [Route("NewIndex")]
        public ActionResult NewIndex(Search search)
        {
            string year = SessionManager.GetMemberSession().planYear.First().RegistYear;
            string AuthUserKey = mSession.insaUserV.userKey;
            // 2019.02.08 그룹권한 체크
            List<LevelTwo> lvGroup = pageAuthRepo.GetGroupAuth(new { AuthUserKey = AuthUserKey }).ToList();
            List<LevelTwo> lvUnion = pageAuthRepo.GetUnionAuth(new { AuthUserKey = AuthUserKey }).ToList();
            List<LevelTwo> lvCompany = pageAuthRepo.GetCompanyAuth(new { AuthUserKey = AuthUserKey }).ToList();
            dynamic model = new ExpandoObject();

            // 계열사 리스트
            List<TbOrgCompanyExp> tbOrgCompanyList = (List<TbOrgCompanyExp>)tbOrgCompanyRepo.selectListByPlanYearInvest(new { year = year });

            // 계열사별 Summary 가져오기 
            List<PlanYearInvestExp> planYearInvestList = (List<PlanYearInvestExp>)planYearInvestRepo.selectListExp(new { year = year });

            // 계열사별 Summary 가져오기 후처리 
            tbOrgCompanyList = parsePlanYearInvestSummary(tbOrgCompanyList, planYearInvestList);

            // 전년도 데이터 가져오기 
            tbOrgCompanyList = getPrevPlanYearInvestSummary(tbOrgCompanyList, Convert.ToInt32(year) - 1);

            // 그룹사 통합 데이터 만들기
            List<PlanYearInvestSummary> groupTotalSummaryList = parseGroupTotalSummary(tbOrgCompanyList);
            model.groupTotalSummaryList_NEW = planGroupdataInvestSummaryRepo.groupSelectList(new { year = year });

            model.lvGroup = lvGroup;
            model.lvUnion = lvUnion;
            model.lvCompany = lvCompany;

            // 화면 발송 모델
            model.groupTotalSummaryList = groupTotalSummaryList;
            model.tbOrgCompanyList = tbOrgCompanyList;
            model.year = year;
            return View("~/Views/Plan/Year_Invest/NewIndex.cshtml", model);
        }


        [Route("Index_excel")]
        public ActionResult IndexExcel(Search search)
        {
            string year = SessionManager.GetMemberSession().planYear.First().RegistYear;
            dynamic model = new ExpandoObject();

            // 계열사 리스트
            List<TbOrgCompanyExp> tbOrgCompanyList = (List<TbOrgCompanyExp>)tbOrgCompanyRepo.selectListByPlanYearInvest(new { year = year });

            // 계열사별 Summary 가져오기 
            List<PlanYearInvestExp> planYearInvestList = (List<PlanYearInvestExp>)planYearInvestRepo.selectListExp(new { year = year });

            // 계열사별 Summary 가져오기 후처리 
            tbOrgCompanyList = parsePlanYearInvestSummary(tbOrgCompanyList, planYearInvestList);

            // 전년도 데이터 가져오기 
            tbOrgCompanyList = getPrevPlanYearInvestSummary(tbOrgCompanyList, Convert.ToInt32(year) - 1);

            // 그룹사 통합 데이터 만들기
            List<PlanYearInvestSummary> groupTotalSummaryList = parseGroupTotalSummary(tbOrgCompanyList);

            // 화면 발송 모델
            model.groupTotalSummaryList = groupTotalSummaryList;
            model.tbOrgCompanyList = tbOrgCompanyList;
            model.year = year;
            return View("~/Views/Plan/Year_Invest/Index_excel.cshtml", model);
        }

        [Route("ExcelYearInvest")]
        public ActionResult ExcelYearInvest(Search search)
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
            
            // 작년도 실적 : 12월 누계만 가져온다.
            List<PmInvestBusiness> lastPmB = pmInvestBusinessRepo.selectListPmLastYear(new { year = PlanYear }).Where(w => w.Monthly == "12").Where(w => w.MonthlyType == Define.MONTHLY_TYPE.GetKey("누계")).ToList();
            List<PmInvestSum> lastPmC = pmInvestSumRepo.selectListPmLastYear(new { year = PlanYear }).Where(w => w.Monthly == "12").Where(w => w.MonthlyType == Define.MONTHLY_TYPE.GetKey("누계")).ToList();
            // 당해년도 계획
            List<PlanYearInvestBusiness> thisPnB = planYearInvestBusinessRepo.selectListPnThisYear(new { year = PlanYear }).ToList();
            List<PlanYearInvestSummary> thisPnC = planYearInvestSummaryRepo.selectListPnThisYear(new { year = PlanYear }).ToList();

            

            dynamic model = new ExpandoObject();
            model.chk = chk;
            model.lvGroup = lvGroup;
            model.lvUnion = lvUnion;
            model.lvCompany = lvCompany;

            model.lastPmB = lastPmB;
            model.thisPnB = thisPnB;
            model.lastPmC = lastPmC;
            model.thisPnC = thisPnC; 

            return View("~/Views/Plan/Year_Invest/ExcelYearInvest.cshtml", model);
        }

        [Route("ExcelYearInvest_New")]
        public ActionResult ExcelYearInvest_New(Search search)
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

            // 작년도 실적 : 12월 누계만 가져온다.
            List<PmInvestBusiness> lastPmB = pmInvestBusinessRepo.selectListPmLastYear(new { year = PlanYear }).Where(w => w.Monthly == "12").Where(w => w.MonthlyType == Define.MONTHLY_TYPE.GetKey("누계")).ToList();
            List<PmInvestSum> lastPmC = pmInvestSumRepo.selectListPmLastYear(new { year = PlanYear }).Where(w => w.Monthly == "12").Where(w => w.MonthlyType == Define.MONTHLY_TYPE.GetKey("누계")).ToList();
            // 당해년도 계획
            List<PlanYearInvestBusiness> thisPnB = planYearInvestBusinessRepo.selectListPnThisYear(new { year = PlanYear }).ToList();
            List<PlanYearInvestSummary> thisPnC = planYearInvestSummaryRepo.selectListPnThisYear(new { year = PlanYear }).ToList();



            dynamic model = new ExpandoObject();
            model.chk = chk;
            model.lvGroup = lvGroup;
            model.lvUnion = lvUnion;
            model.lvCompany = lvCompany;

            model.lastPmB = lastPmB;
            model.thisPnB = thisPnB;
            model.lastPmC = lastPmC;
            model.thisPnC = thisPnC;
            model.groupTotalSummaryList_NEW = planGroupdataInvestSummaryRepo.groupSelectList(new { year = PlanYear }).ToList();

            return View("~/Views/Plan/Year_Invest/ExcelYearInvest_New.cshtml", model);
        }

        [Route("ViewYearInvest")]
        public ActionResult ViewYearInvest(Search search)
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

            // 작년도 실적 : 12월 누계만 가져온다.
            List<PmInvestBusiness> lastPmB = pmInvestBusinessRepo.selectListPmLastYear(new { year = PlanYear }).Where(w => w.Monthly == "12").Where(w => w.MonthlyType == Define.MONTHLY_TYPE.GetKey("누계")).ToList();
            List<PmInvestSum> lastPmC = pmInvestSumRepo.selectListPmLastYear(new { year = PlanYear }).Where(w => w.Monthly == "12").Where(w => w.MonthlyType == Define.MONTHLY_TYPE.GetKey("누계")).ToList();
            // 당해년도 계획
            List<PlanYearInvestBusiness> thisPnB = planYearInvestBusinessRepo.selectListPnThisYear(new { year = PlanYear }).ToList();
            List<PlanYearInvestSummary> thisPnC = planYearInvestSummaryRepo.selectListPnThisYear(new { year = PlanYear }).ToList();

            dynamic model = new ExpandoObject();
            model.chk = chk;
            model.lvGroup = lvGroup;
            model.lvUnion = lvUnion;
            model.lvCompany = lvCompany;

            model.lastPmB = lastPmB;
            model.thisPnB = thisPnB;
            model.lastPmC = lastPmC;
            model.thisPnC = thisPnC;

            return View("~/Views/Plan/Year_Invest/ViewYearInvest.cshtml", model);
        }

        public List<TbOrgCompanyExp> parsePlanYearInvestSummary(List<TbOrgCompanyExp> tbOrgCompanyList, List<PlanYearInvestExp> planYearInvestList)
        {
            foreach(var company in tbOrgCompanyList)
            {
                PlanYearInvestExp planYearInvestExp = planYearInvestList.Where(x => x.OrgCompanySeq == company.seq).FirstOrDefault();
                if(planYearInvestExp != null)
                {
                    company.totalPlanYearInvestSummaryList = planYearInvestExp.planYearInvestSummaryList;
                }
            }
            return tbOrgCompanyList;
        }


        public List<TbOrgCompanyExp> getPrevPlanYearInvestSummary(List<TbOrgCompanyExp> tbOrgCompanyList, int year)
        {
            foreach (var company in tbOrgCompanyList)
            {
                company.pmInvestSum = pmInvestSumRepo.selectOnePrevInvestSum(new { orgCompanySeq = company.seq, year = year });
                if (company.pmInvestSum == null)
                {
                    PmInvestSum summary = new PmInvestSum();
                    summary.investYear = year.ToString();
                    summary.Investment = 0;
                    summary.Personnel = 0;
                    company.pmInvestSum = summary;
                }else
                {
                    company.pmInvestSum.investYear = year.ToString();
                }
            }
            return tbOrgCompanyList;
        }
        public List<PlanYearInvestSummary> parseGroupTotalSummary(List<TbOrgCompanyExp> tbOrgCompanyList)
        {
            List<PlanYearInvestSummary> resultList = new List<PlanYearInvestSummary>();
            foreach(var company in tbOrgCompanyList)
            {

                // 전년도 처리
                if(resultList.Where(x => x.YearlyYear == company.pmInvestSum.investYear).FirstOrDefault() != null)
                {
                    resultList.Where(x => x.YearlyYear == company.pmInvestSum.investYear).FirstOrDefault().Investment += company.pmInvestSum.Investment;
                    resultList.Where(x => x.YearlyYear == company.pmInvestSum.investYear).FirstOrDefault().Personnel += company.pmInvestSum.Personnel;
                }else
                {
                    PlanYearInvestSummary info = new PlanYearInvestSummary();
                    info.YearlyYear = company.pmInvestSum.investYear;
                    info.Investment = company.pmInvestSum.Investment;
                    info.Personnel = company.pmInvestSum.Personnel;

                    resultList.Add(info);
                }


                // 당해년 5개년 계획 처리
                foreach (var summary in company.totalPlanYearInvestSummaryList)
                {
                    if(resultList.Where(x => x.YearlyYear == summary.YearlyYear).FirstOrDefault() != null)
                    {
                        resultList.Where(x => x.YearlyYear == summary.YearlyYear).FirstOrDefault().Investment += summary.Investment;
                        resultList.Where(x => x.YearlyYear == summary.YearlyYear).FirstOrDefault().Personnel += summary.Personnel;
                    }else
                    {
                        PlanYearInvestSummary info = new PlanYearInvestSummary();
                        info.YearlyYear = summary.YearlyYear;
                        info.Investment = summary.Investment;
                        info.Personnel = summary.Personnel;

                        resultList.Add(info);
                    }
                }
            }
            return resultList;
        }

    }
}