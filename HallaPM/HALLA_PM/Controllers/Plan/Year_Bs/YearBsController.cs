using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using HALLA_PM.Models;
using System.Dynamic;
using HALLA_PM.Util;
using HALLA_PM.Core;

namespace HALLA_PM.Controllers
{
    //[SystemLoginFilter]
    //[SystemAuthFilter(MenuAuth = 2)]
    [RoutePrefix("Plan/Year_Bs_Finance")]
    public class YearBsController : Controller
    {
        OrgUnionRepo orgUnionRepo = new OrgUnionRepo();
        TbOrgCompanyRepo tbOrgCompanyRepo = new TbOrgCompanyRepo();
        TbPlanYearBsRepo tbPlanYearBsRepo = new TbPlanYearBsRepo();
        PmBsSummaryRepo pmBsSummaryRepo = new PmBsSummaryRepo();
        PlanYearBsSummaryRepo planYearBsSummaryRepo = new PlanYearBsSummaryRepo();
        PlanGroupdataBsSummaryRepo planGroupdataBsSummaryRepo = new PlanGroupdataBsSummaryRepo();

        PageAuthRepo pageAuthRepo = new PageAuthRepo();                 // 권한체크용
        MemberSession mSession = SessionManager.GetMemberSession();     // 사용자정보

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

            //selectListPmLastYear
            var pm = pmBsSummaryRepo.selectListPmLastYear(search).ToList();
            var pn = planYearBsSummaryRepo.selectListPnThisYear(search).ToList();

            dynamic model = new ExpandoObject();
            model.lvGroup = lvGroup;
            model.lvCompany = lvCompany;
            model.pm = pm;
            model.pn = pn;
            return View("~/Views/Plan/Year_Bs/NewIndex.cshtml", model);
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

            //selectListPmLastYear
            var pm = pmBsSummaryRepo.selectListPmLastYear(search).ToList();
            var pn = planYearBsSummaryRepo.selectListPnThisYear(search).ToList();
            //var pn = planYearBsSummaryRepo.selectListPnThisYear(search).ToList();

            dynamic model = new ExpandoObject();
            model.lvGroup = lvGroup;
            model.lvCompany = lvCompany;
            model.pm = pm;
            model.pn = pn;
            model.pnRoic = planGroupdataBsSummaryRepo.groupSelectList(new { Year = search.year });
            return View("~/Views/Plan/Year_Bs/NewIndex2.cshtml", model);
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

            //selectListPmLastYear
            var pm = pmBsSummaryRepo.selectListPmLastYear(search).ToList();
            var pn = planYearBsSummaryRepo.selectListPnThisYear(search).ToList();

            dynamic model = new ExpandoObject();
            model.lvGroup = lvGroup;
            model.lvCompany = lvCompany;
            model.pm = pm;
            model.pn = pn;
            return View("~/Views/Plan/Year_Bs/NewIndex_excel.cshtml", model);
        }

        [Route("ExcelYearBs")]
        public ActionResult ExcelYearBs(Search search)
        {
            string PlanYear = SessionManager.GetMemberSession().planYear.First().RegistYear;
            string TableName = "PLAN_YEAR_BS";
            search.year = PlanYear;
            string AuthUserKey = mSession.insaUserV.userKey;
            // 그룹권한 체크
            List<LevelTwo> lvGroup = pageAuthRepo.GetGroupAuth(new { AuthUserKey = AuthUserKey }).ToList();
            List<LevelTwo> lvUnion = pageAuthRepo.GetUnionAuth(new { AuthUserKey = AuthUserKey }).ToList();
            List<LevelTwo> lvCompany = pageAuthRepo.GetCompanyAuth(new { AuthUserKey = AuthUserKey }).ToList();

            var chk = planGroupRepo.selectListAll(new { }).ToList().Where(w => w.PlanYear == PlanYear).Where(w => w.TableName == TableName).FirstOrDefault();

            List<PmBsSummaryExp> lastPmC = pmBsSummaryRepo.selectListPmLastYear(new { year = PlanYear }).ToList();
            List<PlanYearBsSummaryExp> thisPnC = planYearBsSummaryRepo.selectListPnThisYear(new { year = PlanYear }).ToList();

            dynamic model = new ExpandoObject();
            model.chk = chk;
            model.lvGroup = lvGroup;
            model.lvUnion = lvUnion;
            model.lvCompany = lvCompany;

            model.lastPmC = lastPmC;
            model.thisPnC = thisPnC;

            return View("~/Views/Plan/Year_Bs/ExcelYearBs.cshtml", model);
        }

        [Route("ExcelYearBs_New")]
        public ActionResult ExcelYearBs_New(Search search)
        {
            string PlanYear = SessionManager.GetMemberSession().planYear.First().RegistYear;
            string TableName = "PLAN_YEAR_BS";
            search.year = PlanYear;
            string AuthUserKey = mSession.insaUserV.userKey;
            // 그룹권한 체크
            List<LevelTwo> lvGroup = pageAuthRepo.GetGroupAuth(new { AuthUserKey = AuthUserKey }).ToList();
            List<LevelTwo> lvUnion = pageAuthRepo.GetUnionAuth(new { AuthUserKey = AuthUserKey }).ToList();
            List<LevelTwo> lvCompany = pageAuthRepo.GetCompanyAuth(new { AuthUserKey = AuthUserKey }).ToList();

            var chk = planGroupRepo.selectListAll(new { }).ToList().Where(w => w.PlanYear == PlanYear).Where(w => w.TableName == TableName).FirstOrDefault();

            List<PmBsSummaryExp> lastPmC = pmBsSummaryRepo.selectListPmLastYear(new { year = PlanYear }).ToList();
            List<PlanYearBsSummaryExp> thisPnC = planYearBsSummaryRepo.selectListPnThisYear(new { year = PlanYear }).ToList();

            dynamic model = new ExpandoObject();
            model.chk = chk;
            model.lvGroup = lvGroup;
            model.lvUnion = lvUnion;
            model.lvCompany = lvCompany;

            model.lastPmC = lastPmC;
            model.thisPnC = thisPnC;
            model.GroupPlan = planGroupdataBsSummaryRepo.groupSelectList(new { Year = search.year });

            return View("~/Views/Plan/Year_Bs/ExcelYearBs.cshtml", model);
        }

        [Route("ViewYearBs")]
        public ActionResult ViewYearBs(Search search)
        {
            string PlanYear = SessionManager.GetMemberSession().planYear.First().RegistYear;
            string TableName = "PLAN_YEAR_BS";
            search.year = PlanYear;
            string AuthUserKey = mSession.insaUserV.userKey;
            // 그룹권한 체크
            List<LevelTwo> lvGroup = pageAuthRepo.GetGroupAuth(new { AuthUserKey = AuthUserKey }).ToList();
            List<LevelTwo> lvUnion = pageAuthRepo.GetUnionAuth(new { AuthUserKey = AuthUserKey }).ToList();
            List<LevelTwo> lvCompany = pageAuthRepo.GetCompanyAuth(new { AuthUserKey = AuthUserKey }).ToList();

            var chk = planGroupRepo.selectListAll(new { }).ToList().Where(w => w.PlanYear == PlanYear).Where(w => w.TableName == TableName).FirstOrDefault();

            List<PmBsSummaryExp> lastPmC = pmBsSummaryRepo.selectListPmLastYear(new { year = PlanYear }).ToList();
            List<PlanYearBsSummaryExp> thisPnC = planYearBsSummaryRepo.selectListPnThisYear(new { year = PlanYear }).ToList();

            dynamic model = new ExpandoObject();
            model.chk = chk;
            model.lvGroup = lvGroup;
            model.lvUnion = lvUnion;
            model.lvCompany = lvCompany;

            model.lastPmC = lastPmC;
            model.thisPnC = thisPnC;

            return View("~/Views/Plan/Year_Bs/ViewYearBs.cshtml", model);
        }

        [Route("Index")]
        public ActionResult Index(Search search)
        {
            string year = SessionManager.GetMemberSession().planYear.First().RegistYear;
            dynamic model = new ExpandoObject();

            // 계열사 리스트
            List<TbOrgCompanyExp> tbOrgCompanyList = (List<TbOrgCompanyExp>)tbOrgCompanyRepo.selectListByPlanYearBs(new { year = year });

            // 계열사별 Summary 가져오기 
            List<TbPlanYearBsExp> tbPlanYearBsList = (List<TbPlanYearBsExp>)tbPlanYearBsRepo.selectListExp(new { year = year });

            // 계열사별 Summary 가져오기 후처리 
            tbOrgCompanyList = parsePlanYearBsSummary(tbOrgCompanyList, tbPlanYearBsList);

            // 전년도 데이터 가져오기 
            tbOrgCompanyList = getPrevPlanYearBsSummary(tbOrgCompanyList, Convert.ToInt32(year) -1 );

            // 그룹사 통합 데이터 만들기
            List<PlanYearBsSummary> groupTotalSummaryList = parseGroupTotalSummary(tbOrgCompanyList);




            // 화면 발송 모델 
            model.groupTotalSummaryList = groupTotalSummaryList;
            model.tbOrgCompanyList = tbOrgCompanyList;
            model.year = year;
            return View("~/Views/Plan/Year_Bs/Index.cshtml", model);
        }

        [Route("Index_excel")]
        public ActionResult IndexExcel(Search search)
        {
            string year = SessionManager.GetMemberSession().planYear.First().RegistYear;
            dynamic model = new ExpandoObject();

            // 계열사 리스트
            List<TbOrgCompanyExp> tbOrgCompanyList = (List<TbOrgCompanyExp>)tbOrgCompanyRepo.selectListByPlanYearBs(new { year = year });

            // 계열사별 Summary 가져오기 
            List<TbPlanYearBsExp> tbPlanYearBsList = (List<TbPlanYearBsExp>)tbPlanYearBsRepo.selectListExp(new { year = year });

            // 계열사별 Summary 가져오기 후처리 
            tbOrgCompanyList = parsePlanYearBsSummary(tbOrgCompanyList, tbPlanYearBsList);

            // 전년도 데이터 가져오기 
            tbOrgCompanyList = getPrevPlanYearBsSummary(tbOrgCompanyList, Convert.ToInt32(year) - 1);

            // 그룹사 통합 데이터 만들기
            List<PlanYearBsSummary> groupTotalSummaryList = parseGroupTotalSummary(tbOrgCompanyList);


            // 화면 발송 모델 
            model.groupTotalSummaryList = groupTotalSummaryList;
            model.tbOrgCompanyList = tbOrgCompanyList;
            model.year = year;
            return View("~/Views/Plan/Year_Bs/Index_excel.cshtml", model);
        }

        public List<TbOrgCompanyExp> parsePlanYearBsSummary(List<TbOrgCompanyExp> tbOrgCompanyList, List<TbPlanYearBsExp> tbPlanYearBsList)
        {
            foreach(var company in tbOrgCompanyList)
            {
                TbPlanYearBsExp planYearBsExp = tbPlanYearBsList.Where(x => x.orgCompanySeq == company.seq).FirstOrDefault();
                if(planYearBsExp != null)
                {
                    company.totalPlanYearBsSummaryList = planYearBsExp.planYearBsSummaryList;
                }
            }
            return tbOrgCompanyList;
        }

        public List<TbOrgCompanyExp> getPrevPlanYearBsSummary(List<TbOrgCompanyExp> tbOrgCompanyList, int year)
        {
            foreach(var company in tbOrgCompanyList)
            {
                company.pmBsSummary = pmBsSummaryRepo.selectOnePrevBsSummary(new { orgCompanySeq = company.seq, year = year});
                if(company.pmBsSummary == null)
                {
                    PmBsSummary summary = new PmBsSummary();
                    summary.Assets = 0;
                    summary.Liabilities = 0;
                    summary.Capital = 0;
                    summary.Cash = 0;
                    summary.Loan = 0;
                    summary.LiabilitiesRate = 0;
                    summary.AfterTaxOperationProfit = 0;
                    summary.PainInCapital = 0;
                    summary.Roic = 0;
                    summary.Ar = 0;
                    summary.ArToDays = 0;
                    summary.Ap = 0;
                    summary.ApToDays = 0;
                    summary.Inventory = 0;
                    summary.InventoryToDays = 0;
                    summary.BsYear = year.ToString();

                    company.pmBsSummary = summary;
                }
            }
            return tbOrgCompanyList;
        }

        public List<PlanYearBsSummary> parseGroupTotalSummary(List<TbOrgCompanyExp> tbOrgCompanyList)
        {
            List<PlanYearBsSummary> resultList = new List<PlanYearBsSummary>();

            foreach(var company in tbOrgCompanyList)
            {
                // 전년도 처리
                if (resultList.Where(x => x.YearlyYear == company.pmBsSummary.BsYear).FirstOrDefault() != null)
                {
                    if(company.pmBsSummary.PainInCapital == 0)
                    {
                        resultList.Where(x => x.YearlyYear == company.pmBsSummary.BsYear).FirstOrDefault().Roic += 0;
                    }
                    else
                    {
                        resultList.Where(x => x.YearlyYear == company.pmBsSummary.BsYear).FirstOrDefault().Roic += Math.Round(company.pmBsSummary.AfterTaxOperationProfit / company.pmBsSummary.PainInCapital, 1, MidpointRounding.AwayFromZero);
                    }
                }
                else
                {
                    PlanYearBsSummary info = new PlanYearBsSummary();
                    info.YearlyYear = company.pmBsSummary.BsYear;
                    info.Roic = company.pmBsSummary.Roic;

                    resultList.Add(info);
                }


                // 기준년도 5개년 처리
                foreach (var summary in company.totalPlanYearBsSummaryList)
                {
                    if (resultList.Where(x => x.YearlyYear == summary.YearlyYear).FirstOrDefault() != null)
                    {
                        resultList.Where(x => x.YearlyYear == summary.YearlyYear).FirstOrDefault().Roic += summary.Roic;
                    }
                    else
                    {
                        PlanYearBsSummary info = new PlanYearBsSummary();
                        info.YearlyYear = summary.YearlyYear;
                        info.Roic = summary.Roic;

                        resultList.Add(info);
                    }
                }
            }

            return resultList;
        }
    }
}