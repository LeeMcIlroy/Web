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
    [RoutePrefix("Plan/Year_Pal")]
    public class YearPalController : Controller
    {
        PmPalRepo pmPalRepo = new PmPalRepo();
        OrgUnionRepo orgUnionRepo = new OrgUnionRepo();
        PlanYearPalRepo planYearPalRepo = new PlanYearPalRepo();
        TbOrgCompanyRepo tbOrgCompanyRepo = new TbOrgCompanyRepo();
        PmPalSummaryRepo pmPalSummaryRepo = new PmPalSummaryRepo();
        PmPalBusinessRepo pmPalBusinessRepo = new PmPalBusinessRepo();
        PlanYearPalBusinessRepo planYearPalBusinessRepo = new PlanYearPalBusinessRepo();
        PlanYearPalBusinessSummaryRepo planYearPalBusinessSummaryRepo = new PlanYearPalBusinessSummaryRepo();

        PlanGroupdataPalSummaryRepo planGroupdataPalSummaryRepo = new PlanGroupdataPalSummaryRepo();

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

            // 작년도 실적 
            List<PmPalBusinessExp> pmLastYearBu = pmPalBusinessRepo.selectListPmLastYear(search).ToList();
            List<PmPalSummaryExp> pmLastYearCom = pmPalSummaryRepo.selectListPmLastYear(search).ToList();
            // 당해년도 중기계획
            List<PlanYearPalBusinessExp> pnThisYearBu = planYearPalBusinessRepo.selectListPnThisYear(search).ToList();
            List<PlanYearPalBusinessSummaryExp> pnThisYearCom = planYearPalBusinessSummaryRepo.selectListPnThisYear(search).ToList();

            dynamic model = new ExpandoObject();
            model.lvGroup = lvGroup;
            model.lvCompany = lvCompany;
            model.pmLastYearBu = pmLastYearBu;
            model.pmLastYearCom = pmLastYearCom;
            model.pnThisYearBu = pnThisYearBu;
            model.pnThisYearCom = pnThisYearCom;

            return View("~/Views/Plan/Year_Pal/NewIndex.cshtml", model);
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
            List<PmPalBusinessExp> pmLastYearBu = pmPalBusinessRepo.selectListPmLastYear(search).ToList();
            List<PmPalSummaryExp> pmLastYearCom = pmPalSummaryRepo.selectListPmLastYear(search).ToList();
            // 당해년도 중기계획
            List<PlanYearPalBusinessExp> pnThisYearBu = planYearPalBusinessRepo.selectListPnThisYear(search).ToList();
            List<PlanYearPalBusinessSummaryExp> pnThisYearCom = planYearPalBusinessSummaryRepo.selectListPnThisYear(search).ToList();

            dynamic model = new ExpandoObject();
            model.lvGroup = lvGroup;
            model.lvCompany = lvCompany;
            model.pmLastYearBu = pmLastYearBu;
            model.pmLastYearCom = pmLastYearCom;
            model.pnThisYearBu = pnThisYearBu;
            model.pnThisYearCom = pnThisYearCom;
            model.pnGroupData = planGroupdataPalSummaryRepo.selectList(new { PLANYEAR = search.year });

            return View("~/Views/Plan/Year_Pal/NewIndex2.cshtml", model);
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
            List<PmPalBusinessExp> pmLastYearBu = pmPalBusinessRepo.selectListPmLastYear(search).ToList();
            List<PmPalSummaryExp> pmLastYearCom = pmPalSummaryRepo.selectListPmLastYear(search).ToList();
            // 당해년도 중기계획
            List<PlanYearPalBusinessExp> pnThisYearBu = planYearPalBusinessRepo.selectListPnThisYear(search).ToList();
            List<PlanYearPalBusinessSummaryExp> pnThisYearCom = planYearPalBusinessSummaryRepo.selectListPnThisYear(search).ToList();

            dynamic model = new ExpandoObject();
            model.lvGroup = lvGroup;
            model.lvCompany = lvCompany;
            model.pmLastYearBu = pmLastYearBu;
            model.pmLastYearCom = pmLastYearCom;
            model.pnThisYearBu = pnThisYearBu;
            model.pnThisYearCom = pnThisYearCom;

            return View("~/Views/Plan/Year_Pal/NewIndex_excel.cshtml", model);
        }

        [Route("ExcelYearPal")]
        public ActionResult ExcelYearPal(Search search)
        {
            string PlanYear = SessionManager.GetMemberSession().planYear.First().RegistYear;
            string TableName = "PLAN_YEAR_PAL";
            search.year = PlanYear;
            string AuthUserKey = mSession.insaUserV.userKey;
            // 그룹권한 체크
            List<LevelTwo> lvGroup = pageAuthRepo.GetGroupAuth(new { AuthUserKey = AuthUserKey }).ToList();
            List<LevelTwo> lvUnion = pageAuthRepo.GetUnionAuth(new { AuthUserKey = AuthUserKey }).ToList();
            List<LevelTwo> lvCompany = pageAuthRepo.GetCompanyAuth(new { AuthUserKey = AuthUserKey }).ToList();

            var chk = planGroupRepo.selectListAll(new { }).ToList().Where(w => w.PlanYear == PlanYear).Where(w => w.TableName == TableName).FirstOrDefault();
            List<PlanYearPalBusinessExp> lastPnB = planYearPalBusinessRepo.selectListPnThisYear(new { year = Convert.ToInt32(PlanYear) - 1 }).ToList();
            List<PmPalBusinessExp> lastPmB = pmPalBusinessRepo.selectListPmThisYear(new { year = (Convert.ToInt32(PlanYear) - 1), mm = "12" }).Where(w => w.MonthlyType == Define.MONTHLY_TYPE.GetKey("누계")).ToList();
            List<PlanYearPalBusinessExp> thisPnB = planYearPalBusinessRepo.selectListPnThisYear(new { year = PlanYear }).ToList();

            List<PlanYearPalBusinessSummaryExp> lastPnC = planYearPalBusinessSummaryRepo.selectListPnThisYear(new { Year = Convert.ToInt32(PlanYear) - 1 }).ToList();
            List<PmPalSummaryExp> lastPmC = pmPalSummaryRepo.selectListPmLastYear(new { year = PlanYear }).Where(w => w.Monthly == "12").Where(w => w.MonthlyType == Define.MONTHLY_TYPE.GetKey("누계")).ToList();
            List<PlanYearPalBusinessSummaryExp> thisPnC = planYearPalBusinessSummaryRepo.selectListPnThisYear(new { Year = PlanYear }).ToList();

            dynamic model = new ExpandoObject();

            model.chk = chk;
            model.lvGroup = lvGroup;
            model.lvUnion = lvUnion;
            model.lvCompany = lvCompany;

            model.lastPnB = lastPnB;
            model.lastPmB = lastPmB;
            model.thisPnB = thisPnB;

            model.lastPnC = lastPnC;
            model.lastPmC = lastPmC;
            model.thisPnC = thisPnC;
            return View("~/Views/Plan/Year_Pal/ExcelYearPal.cshtml", model);
        }


        [Route("ExcelYearPal_New")]
        public ActionResult ExcelYearPal_New(Search search)
        {
            string PlanYear = SessionManager.GetMemberSession().planYear.First().RegistYear;
            string TableName = "PLAN_YEAR_PAL";
            search.year = PlanYear;
            string AuthUserKey = mSession.insaUserV.userKey;
            // 그룹권한 체크
            List<LevelTwo> lvGroup = pageAuthRepo.GetGroupAuth(new { AuthUserKey = AuthUserKey }).ToList();
            List<LevelTwo> lvUnion = pageAuthRepo.GetUnionAuth(new { AuthUserKey = AuthUserKey }).ToList();
            List<LevelTwo> lvCompany = pageAuthRepo.GetCompanyAuth(new { AuthUserKey = AuthUserKey }).ToList();

            var chk = planGroupRepo.selectListAll(new { }).ToList().Where(w => w.PlanYear == PlanYear).Where(w => w.TableName == TableName).FirstOrDefault();
            List<PlanYearPalBusinessExp> lastPnB = planYearPalBusinessRepo.selectListPnThisYear(new { year = Convert.ToInt32(PlanYear) - 1 }).ToList();
            List<PmPalBusinessExp> lastPmB = pmPalBusinessRepo.selectListPmThisYear(new { year = (Convert.ToInt32(PlanYear) - 1), mm = "12" }).Where(w => w.MonthlyType == Define.MONTHLY_TYPE.GetKey("누계")).ToList();
            List<PlanYearPalBusinessExp> thisPnB = planYearPalBusinessRepo.selectListPnThisYear(new { year = PlanYear }).ToList();

            List<PlanYearPalBusinessSummaryExp> lastPnC = planYearPalBusinessSummaryRepo.selectListPnThisYear(new { Year = Convert.ToInt32(PlanYear) - 1 }).ToList();
            List<PmPalSummaryExp> lastPmC = pmPalSummaryRepo.selectListPmLastYear(new { year = PlanYear }).Where(w => w.Monthly == "12").Where(w => w.MonthlyType == Define.MONTHLY_TYPE.GetKey("누계")).ToList();
            List<PlanYearPalBusinessSummaryExp> thisPnC = planYearPalBusinessSummaryRepo.selectListPnThisYear(new { Year = PlanYear }).ToList();

            dynamic model = new ExpandoObject();

            model.chk = chk;
            model.lvGroup = lvGroup;
            model.lvUnion = lvUnion;
            model.lvCompany = lvCompany;

            model.lastPnB = lastPnB;
            model.lastPmB = lastPmB;
            model.thisPnB = thisPnB;

            model.lastPnC = lastPnC;
            model.lastPmC = lastPmC;
            model.thisPnC = thisPnC;
            model.thisGroupPlan = planGroupdataPalSummaryRepo.selectList(new { PLANYEAR = search.year });
            return View("~/Views/Plan/Year_Pal/ExcelYearPal_New.cshtml", model);
        }

        [Route("ViewYearPal")]
        public ActionResult ViewYearPal(Search search)
        {
            string PlanYear = SessionManager.GetMemberSession().planYear.First().RegistYear;
            string TableName = "PLAN_YEAR_PAL";
            search.year = PlanYear;
            string AuthUserKey = mSession.insaUserV.userKey;
            // 그룹권한 체크
            List<LevelTwo> lvGroup = pageAuthRepo.GetGroupAuth(new { AuthUserKey = AuthUserKey }).ToList();
            List<LevelTwo> lvUnion = pageAuthRepo.GetUnionAuth(new { AuthUserKey = AuthUserKey }).ToList();
            List<LevelTwo> lvCompany = pageAuthRepo.GetCompanyAuth(new { AuthUserKey = AuthUserKey }).ToList();

            var chk = planGroupRepo.selectListAll(new { }).ToList().Where(w => w.PlanYear == PlanYear).Where(w => w.TableName == TableName).FirstOrDefault();
            List<PlanYearPalBusinessExp> lastPnB = planYearPalBusinessRepo.selectListPnThisYear(new { year = Convert.ToInt32(PlanYear) - 1 }).ToList();
            List<PmPalBusinessExp> lastPmB = pmPalBusinessRepo.selectListPmThisYear(new { year = (Convert.ToInt32(PlanYear) - 1), mm = "12" }).Where(w => w.MonthlyType == Define.MONTHLY_TYPE.GetKey("누계")).ToList();
            List<PlanYearPalBusinessExp> thisPnB = planYearPalBusinessRepo.selectListPnThisYear(new { year = PlanYear }).ToList();

            List<PlanYearPalBusinessSummaryExp> lastPnC = planYearPalBusinessSummaryRepo.selectListPnThisYear(new { Year = Convert.ToInt32(PlanYear) - 1 }).ToList();
            List<PmPalSummaryExp> lastPmC = pmPalSummaryRepo.selectListPmLastYear(new { year = PlanYear }).Where(w => w.Monthly == "12").Where(w => w.MonthlyType == Define.MONTHLY_TYPE.GetKey("누계")).ToList();
            List<PlanYearPalBusinessSummaryExp> thisPnC = planYearPalBusinessSummaryRepo.selectListPnThisYear(new { Year = PlanYear }).ToList();

            dynamic model = new ExpandoObject();

            model.chk = chk;
            model.lvGroup = lvGroup;
            model.lvUnion = lvUnion;
            model.lvCompany = lvCompany;

            model.lastPnB = lastPnB;
            model.lastPmB = lastPmB;
            model.thisPnB = thisPnB;

            model.lastPnC = lastPnC;
            model.lastPmC = lastPmC;
            model.thisPnC = thisPnC;
            return View("~/Views/Plan/Year_Pal/ViewYearPal.cshtml", model);
        }

        [Route("Index")]
        public ActionResult Index(Search search)
        {

            string year = SessionManager.GetMemberSession().planYear.First().RegistYear;

            dynamic model = new ExpandoObject();

            string AuthUserKey = mSession.insaUserV.userKey;
            // 그룹권한 체크
            var lvGroup = pageAuthRepo.GetGroupAuth(new { AuthUserKey = AuthUserKey }).ToList();
            var lvCompany = pageAuthRepo.GetCompanyAuth(new { AuthUserKey = AuthUserKey }).ToList();

            // UNION 리스트 
            List<OrgUnionExp> orgUnionList = (List<OrgUnionExp>)orgUnionRepo.selectListExp(new { });

            // 계열사 리스트
            List<TbOrgCompanyExp> tbOrgCompanyList = (List<TbOrgCompanyExp>)tbOrgCompanyRepo.selectListByPlanYearPal(new { year = year });

            // 계열사별 5개년 정보 가져오기
            List<PlanYearPalExp> planYearPalList = planYearPalRepo.selectListExp(new { year = year });

            // 계열사별 5개년 정보 후처리 (총계 값 처리)
            tbOrgCompanyList = parsePlanYearPalBusinessSummary(tbOrgCompanyList, planYearPalList);

            // 기준년도 기준 전년도 실적 데이터 가져오기 (2018년이 기준년도이면 2017년도의 실적 데이터를 가져와서 뿌려줘야 한다.)
            List<PmPalExp> pmPalList = pmPalRepo.selectListExp(new { year = Convert.ToInt32(year) -1 });
            tbOrgCompanyList = parsePmPalBusinessSummary(tbOrgCompanyList, pmPalList, Convert.ToInt32(year) - 1);

            // 계열사별 5개년 정보 후처리 다음으로 그룹 전체의 union 기준으로 매핑
            orgUnionList = parseUnionPlanYearPalBusinessSummary(orgUnionList, tbOrgCompanyList, Convert.ToInt32(year));

            // 그룹 전체의 SUMMARY 
            List<PlanYearPalBusinessSummary> groupTotalSummary = parseGroupTotalSummary(orgUnionList, Convert.ToInt32(year));



            // 도표 년도 : yearPalYear 기준 5개년 정보 : -1 ~ +4년 = 총 6년치
            List<String> yearList = new List<String>();
            yearList.Add((Convert.ToInt32(year) - 1).ToString());
            for(var i = Convert.ToInt32(year); i <= Convert.ToInt32(year) + 4; i++)
            {
                yearList.Add(i.ToString());
            }

            // 화면단 발송 모델
            model.orgUnionList = orgUnionList;
            model.groupTotalSummary = groupTotalSummary;

            model.tbOrgCompanyList = tbOrgCompanyList;
            model.planYearPalList = planYearPalList;
            model.yearList = yearList;
            model.lvGroup = lvGroup;
            model.lvCompany = lvCompany;
            return View("~/Views/Plan/Year_Pal/Index.cshtml", model);
        }


        [Route("Index_excel")]
        public ActionResult IndexExcel(Search search)
        {

            string year = SessionManager.GetMemberSession().planYear.First().RegistYear;

            dynamic model = new ExpandoObject();

            string AuthUserKey = mSession.insaUserV.userKey;
            // 그룹권한 체크
            var lvGroup = pageAuthRepo.GetGroupAuth(new { AuthUserKey = AuthUserKey }).ToList();
            var lvCompany = pageAuthRepo.GetCompanyAuth(new { AuthUserKey = AuthUserKey }).ToList();

            // UNION 리스트 
            List<OrgUnionExp> orgUnionList = (List<OrgUnionExp>)orgUnionRepo.selectListExp(new { });

            // 계열사 리스트
            List<TbOrgCompanyExp> tbOrgCompanyList = (List<TbOrgCompanyExp>)tbOrgCompanyRepo.selectListByPlanYearPal(new { year = year });

            // 계열사별 5개년 정보 가져오기
            List<PlanYearPalExp> planYearPalList = planYearPalRepo.selectListExp(new { year = year });

            // 계열사별 5개년 정보 후처리 (총계 값 처리)
            tbOrgCompanyList = parsePlanYearPalBusinessSummary(tbOrgCompanyList, planYearPalList);

            // 기준년도 기준 전년도 실적 데이터 가져오기 (2018년이 기준년도이면 2017년도의 실적 데이터를 가져와서 뿌려줘야 한다.)
            List<PmPalExp> pmPalList = pmPalRepo.selectListExp(new { year = Convert.ToInt32(year) - 1 });
            tbOrgCompanyList = parsePmPalBusinessSummary(tbOrgCompanyList, pmPalList, Convert.ToInt32(year) - 1);

            // 계열사별 5개년 정보 후처리 다음으로 그룹 전체의 union 기준으로 매핑
            orgUnionList = parseUnionPlanYearPalBusinessSummary(orgUnionList, tbOrgCompanyList, Convert.ToInt32(year));

            // 그룹 전체의 SUMMARY 
            List<PlanYearPalBusinessSummary> groupTotalSummary = parseGroupTotalSummary(orgUnionList, Convert.ToInt32(year));



            // 도표 년도 : yearPalYear 기준 5개년 정보 : -1 ~ +4년 = 총 6년치
            List<String> yearList = new List<String>();
            yearList.Add((Convert.ToInt32(year) - 1).ToString());
            for (var i = Convert.ToInt32(year); i <= Convert.ToInt32(year) + 4; i++)
            {
                yearList.Add(i.ToString());
            }

            // 화면단 발송 모델
            model.orgUnionList = orgUnionList;
            model.groupTotalSummary = groupTotalSummary;

            model.tbOrgCompanyList = tbOrgCompanyList;
            model.planYearPalList = planYearPalList;
            model.yearList = yearList;
            model.lvGroup = lvGroup;
            model.lvCompany = lvCompany;
            return View("~/Views/Plan/Year_Pal/Index_excel.cshtml", model);
        }


        public List<TbOrgCompanyExp> parsePmPalBusinessSummary(List<TbOrgCompanyExp> tbOrgCompanyList, List<PmPalExp> pmPalList, int palYear)
        {
            foreach(var item in tbOrgCompanyList)
            {
                item.totalPmPalBusinessSummary = pmPalSummaryRepo.selectSummaryOne(new { orgCompanySeq = item.seq, palYear = palYear }, palYear);

                if (item.orgBusinessList != null)
                {
                    foreach(var itemSub in item.orgBusinessList)
                    {
                        itemSub.pmPalBusinessSummary = pmPalBusinessRepo.selectSummaryOne(new { orgCompanySeq = item.seq, palYear = palYear, orgBusinessSeq = itemSub.Seq });
                    }
                }
            }
            return tbOrgCompanyList;
        }

        public List<TbOrgCompanyExp> parsePlanYearPalBusinessSummary(List<TbOrgCompanyExp> tbOrgCompanyList, List<PlanYearPalExp> planYearPalList)
        {
            // business 별 합계 처리 
            foreach(var item in tbOrgCompanyList)
            {
                PlanYearPalExp planYearPalExp = planYearPalList.Where(x => x.OrgCompanySeq == item.seq).FirstOrDefault();
                if(planYearPalExp != null && item.orgBusinessList != null)
                {
                    foreach(var itemSub in item.orgBusinessList)
                    {
                        itemSub.planYearPalBusinessSummaryList = (List<PlanYearPalBusinessSummary>)planYearPalBusinessRepo.selectSummaryList(new { planYearPalSeq = planYearPalExp.Seq, orgBusinessSeq = itemSub.Seq });
                    }
                }
            }
            
            // 전체 합계 처리 
            foreach(var item in tbOrgCompanyList)
            {
                PlanYearPalExp planYearPalExp = planYearPalList.Where(x => x.OrgCompanySeq == item.seq).FirstOrDefault();
                if (planYearPalExp != null)
                {
                    // _BUSINESS 테이블에서 처리하지 않고
                    // _BUSINESS_SUMMARY 테이블에서 처리하도록 수정
                    /*
                    item.totalSummaryList = (List<PlanYearPalBusinessSummary>)planYearPalBusinessRepo.selectTotalSummaryList(new { planYearPalSeq = planYearPalExp.Seq });
                    */
                    // 입력된 summary 테이블에서 데이터 가져오도록 함.
                    item.totalPlanYearPalBusinessSummaryList = (List<PlanYearPalBusinessSummary>)planYearPalBusinessSummaryRepo.selectList(new { planYearPalSeq = planYearPalExp.Seq });
                }
            }

            // business 별 통계 처리 
            foreach (var item in tbOrgCompanyList)
            {
                if(item.orgBusinessList != null)
                {
                    foreach(var itemSub in item.orgBusinessList)
                    {
                        if (itemSub.planYearPalBusinessSummaryList != null)
                        {
                            foreach (var itemSubExp in itemSub.planYearPalBusinessSummaryList)
                            {
                                // (EBIT / Sales) * 100
                                if(itemSubExp.sales == 0)
                                {
                                    itemSubExp.rate = 0;
                                }
                                else
                                {
                                    itemSubExp.rate = Math.Round((itemSubExp.ebit / itemSubExp.sales) * 100, 1, MidpointRounding.AwayFromZero);
                                }
                            }
                        }
                    }
                }
            }

            // 전체 통계 처리 
            foreach (var item in tbOrgCompanyList)
            {
                if(item.totalPlanYearPalBusinessSummaryList != null)
                {
                    foreach (var itemSub in item.totalPlanYearPalBusinessSummaryList)
                    {
                        // (EBIT / Sales) * 100
                        if (itemSub.sales == 0)
                        {
                            itemSub.rate = 0;
                        }
                        else
                        {
                            itemSub.rate = Math.Round((itemSub.ebit / itemSub.sales) * 100, 1, MidpointRounding.AwayFromZero);
                        }
                    }
                }

            }
            return tbOrgCompanyList;
        }

        public List<OrgUnionExp> parseUnionPlanYearPalBusinessSummary(List<OrgUnionExp> orgUnionList, List<TbOrgCompanyExp> tbOrgCompanyList, int year)
        {
            foreach(var union in orgUnionList)
            {
                List<PlanYearPalBusinessSummary> procedList = new List<PlanYearPalBusinessSummary>();
                PmPalBusinessSummaryForPlan procedOne = new PmPalBusinessSummaryForPlan();
                List<TbOrgCompanyExp> companyList = tbOrgCompanyList.Where(x => x.orgUnionSeq == union.Seq).ToList();
                foreach(var company in companyList)
                {
                    List<PlanYearPalBusinessSummary> totalSummaryList = company.totalPlanYearPalBusinessSummaryList;
                    if(totalSummaryList != null)
                    {
                        // 전년도 실적 미리 넣기
                        /*
                        foreach(var business in company.orgBusinessList)
                        {
                            if(business.pmPalBusinessSummary != null)
                            {
                                if (union.pmPalBusinessSummary == null)
                                {
                                    PmPalBusinessSummaryForPlan info = new PmPalBusinessSummaryForPlan();
                                    info.sales = business.pmPalBusinessSummary.sales;
                                    info.ebit = business.pmPalBusinessSummary.ebit;
                                    info.orgCompanySeq = business.pmPalBusinessSummary.orgCompanySeq;
                                    info.orgBusinessSeq = business.pmPalBusinessSummary.orgBusinessSeq;
                                    info.yearlyYear = (year-1).ToString();
                                    union.pmPalBusinessSummary = info;
                                }
                                else
                                {
                                    union.pmPalBusinessSummary.sales = union.pmPalBusinessSummary.sales + business.pmPalBusinessSummary.sales;
                                    union.pmPalBusinessSummary.ebit = union.pmPalBusinessSummary.ebit + business.pmPalBusinessSummary.ebit;
                                }
                            }
                        }
                        */
                        if (union.pmPalBusinessSummary == null)
                        {
                            PmPalBusinessSummaryForPlan info = new PmPalBusinessSummaryForPlan();
                            info.sales = company.totalPmPalBusinessSummary.sales;
                            info.ebit = company.totalPmPalBusinessSummary.ebit;
                            info.orgCompanySeq = company.totalPmPalBusinessSummary.orgCompanySeq;
                            info.orgBusinessSeq = company.totalPmPalBusinessSummary.orgBusinessSeq;
                            info.yearlyYear = (year - 1).ToString();
                            union.pmPalBusinessSummary = info;
                        }
                        else
                        {
                            union.pmPalBusinessSummary.sales = union.pmPalBusinessSummary.sales + company.totalPmPalBusinessSummary.sales;
                            union.pmPalBusinessSummary.ebit = union.pmPalBusinessSummary.ebit + company.totalPmPalBusinessSummary.ebit;
                        }

                        foreach (var summary in totalSummaryList)
                        {
                            if (procedList.Where(x => x.yearlyYear == summary.yearlyYear).ToList().Count() > 0)
                            {
                                // 있으면 더하기
                                procedList.Where(x => x.yearlyYear == summary.yearlyYear).FirstOrDefault().sales = procedList.Where(x => x.yearlyYear == summary.yearlyYear).FirstOrDefault().sales + summary.sales;
                                procedList.Where(x => x.yearlyYear == summary.yearlyYear).FirstOrDefault().ebit = procedList.Where(x => x.yearlyYear == summary.yearlyYear).FirstOrDefault().ebit + summary.ebit;
                            }
                            else
                            {
                                // 없으면 만들고 넣기 
                                PlanYearPalBusinessSummary info = new PlanYearPalBusinessSummary();
                                info.sales = summary.sales;
                                info.ebit = summary.ebit;
                                info.orgCompanySeq = summary.orgCompanySeq;
                                info.orgBusinessSeq = summary.orgBusinessSeq;
                                info.yearlyYear = summary.yearlyYear;
                                procedList.Add(info);
                            }
                        }
                    }
                }
                union.planYearPalBusinessSummaryList = procedList;
            }

            foreach(var union in orgUnionList)
            {
                if(union.pmPalBusinessSummary.sales == 0)
                {
                    union.pmPalBusinessSummary.rate = 0;
                }
                else
                {
                    union.pmPalBusinessSummary.rate = Math.Round((union.pmPalBusinessSummary.ebit / union.pmPalBusinessSummary.sales) * 100, 1, MidpointRounding.AwayFromZero);
                }

                foreach (var summary in union.planYearPalBusinessSummaryList)
                {
                    if(summary.sales == 0)
                    {
                        summary.rate = 0;
                    }
                    else
                    {
                        summary.rate = Math.Round((summary.ebit / summary.sales) * 100, 1, MidpointRounding.AwayFromZero);
                    }
                }
            }

            return orgUnionList;
        }

        public List<PlanYearPalBusinessSummary> parseGroupTotalSummary(List<OrgUnionExp> orgUnionList, int year)
        {
            List<PlanYearPalBusinessSummary> resultList = new List<PlanYearPalBusinessSummary>();
            foreach (var union in orgUnionList)
            {
                // 전년도 데이터 추가 
                if (resultList.Where(x => x.yearlyYear == union.pmPalBusinessSummary.yearlyYear).Count() > 0)
                {
                    resultList.Where(x => x.yearlyYear == union.pmPalBusinessSummary.yearlyYear).FirstOrDefault().sales = resultList.Where(x => x.yearlyYear == union.pmPalBusinessSummary.yearlyYear).FirstOrDefault().sales + union.pmPalBusinessSummary.sales;
                    resultList.Where(x => x.yearlyYear == union.pmPalBusinessSummary.yearlyYear).FirstOrDefault().ebit = resultList.Where(x => x.yearlyYear == union.pmPalBusinessSummary.yearlyYear).FirstOrDefault().ebit + union.pmPalBusinessSummary.ebit;
                }
                else
                {
                    PlanYearPalBusinessSummary info = new PlanYearPalBusinessSummary();
                    info.sales = union.pmPalBusinessSummary.sales;
                    info.ebit = union.pmPalBusinessSummary.ebit;
                    info.orgCompanySeq = union.pmPalBusinessSummary.orgCompanySeq;
                    info.orgBusinessSeq = union.pmPalBusinessSummary.orgBusinessSeq;
                    info.yearlyYear = union.pmPalBusinessSummary.yearlyYear;
                    resultList.Add(info);
                }

                foreach (var summary in union.planYearPalBusinessSummaryList)
                {
                    if (resultList.Where(x => x.yearlyYear == summary.yearlyYear).Count() > 0)
                    {
                        // 있으면 더하고
                        resultList.Where(x => x.yearlyYear == summary.yearlyYear).FirstOrDefault().sales = resultList.Where(x => x.yearlyYear == summary.yearlyYear).FirstOrDefault().sales + summary.sales;
                        resultList.Where(x => x.yearlyYear == summary.yearlyYear).FirstOrDefault().ebit = resultList.Where(x => x.yearlyYear == summary.yearlyYear).FirstOrDefault().ebit + summary.ebit;
                    }
                    else
                    {
                        // 없으면 추가하고
                        PlanYearPalBusinessSummary info = new PlanYearPalBusinessSummary();
                        info.sales = summary.sales;
                        info.ebit = summary.ebit;
                        info.orgCompanySeq = summary.orgCompanySeq;
                        info.orgBusinessSeq = summary.orgBusinessSeq;
                        info.yearlyYear = summary.yearlyYear;
                        resultList.Add(info);
                    }
                }
            }

            foreach(var item in resultList)
            {
                if (item.sales == 0)
                {
                    item.rate = 0;
                }
                else
                {
                    item.rate = Math.Round((item.ebit / item.sales) * 100, 1, MidpointRounding.AwayFromZero);
                }
            }

            return resultList;
        }
    }
}
 