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
    //[SystemLoginFilter]
    //[SystemAuthFilter(MenuAuth = 2)]
    [RoutePrefix("Plan/Monthly_Pal")]
    public class MonthlyPalController : Controller
    {

        OrgUnionRepo orgUnionRepo = new OrgUnionRepo();
        TbOrgCompanyRepo tbOrgCompanyRepo = new TbOrgCompanyRepo();
        TbPlanMonthlyPalRepo tbPlanMonthlyPalRepo = new TbPlanMonthlyPalRepo();
        TbPlanMonthlyPalBusinessRepo tbPlanMonthlyPalBusinessRepo = new TbPlanMonthlyPalBusinessRepo();
        PlanMonthlyPalBusinessMonthlySumRepo planMonthlyPalBusinessMonthlySumRepo = new PlanMonthlyPalBusinessMonthlySumRepo();

        PlanMonthlyPalBusinessRepo pMonthlyPalBusinessRepo = new PlanMonthlyPalBusinessRepo();
        PlanGroupdataPalMonthRepo planGroupdataPalMonthRepo = new PlanGroupdataPalMonthRepo();

        PageAuthRepo pageAuthRepo = new PageAuthRepo();                 // 권한체크용
        MemberSession mSession = SessionManager.GetMemberSession();     // 사용자정보

        private PmPalBusinessRepo pmPalBusinessRepo = new PmPalBusinessRepo();
        private PmPalSummaryRepo pmPalSummaryRepo = new PmPalSummaryRepo();
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

            List<PlanMonthlyPalBusinessExp> pnBu = pMonthlyPalBusinessRepo.selectListPnThisYear(search).ToList();
            List<PlanMonthlyPalBusinessMonthlySumExp> pnCom = planMonthlyPalBusinessMonthlySumRepo.selectListPnThisYear(search).ToList();

            dynamic model = new ExpandoObject();
            model.lvGroup = lvGroup;
            model.lvCompany = lvCompany;
            model.pnBu = pnBu;
            model.pnCom = pnCom;

            ViewBag.search = search;
            return View("~/Views/Plan/Monthly_Pal/NewIndex.cshtml", model);
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

            List<PlanMonthlyPalBusinessExp> pnBu = pMonthlyPalBusinessRepo.selectListPnThisYear(search).ToList();
            List<PlanMonthlyPalBusinessMonthlySumExp> pnCom = planMonthlyPalBusinessMonthlySumRepo.selectListPnThisYear(search).ToList();
            

            dynamic model = new ExpandoObject();
            model.lvGroup = lvGroup;
            model.lvCompany = lvCompany;
            model.pnBu = pnBu;
            model.pnCom = pnCom;
            model.pnGroupMonthData = planGroupdataPalMonthRepo.selectList(new { PLANYEAR=search.year });

            ViewBag.search = search;
            return View("~/Views/Plan/Monthly_Pal/NewIndex2.cshtml", model);
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

            List<PlanMonthlyPalBusinessExp> pnBu = pMonthlyPalBusinessRepo.selectListPnThisYear(search).ToList();
            List<PlanMonthlyPalBusinessMonthlySumExp> pnCom = planMonthlyPalBusinessMonthlySumRepo.selectListPnThisYear(search).ToList();

            dynamic model = new ExpandoObject();
            model.lvGroup = lvGroup;
            model.lvCompany = lvCompany;
            model.pnBu = pnBu;
            model.pnCom = pnCom;

            ViewBag.search = search;
            return View("~/Views/Plan/Monthly_Pal/NewIndex_excel.cshtml", model);
        }

        [Route("ExcelMonthlyPal")]
        public ActionResult ExcelMonthlyPal(Search search)
        {
            string PlanYear = SessionManager.GetMemberSession().planYear.First().RegistYear;
            string TableName = "PLAN_MONTHLY_PAL";
            search.year = PlanYear;
            string AuthUserKey = mSession.insaUserV.userKey;
            // 그룹권한 체크
            List<LevelTwo> lvGroup = pageAuthRepo.GetGroupAuth(new { AuthUserKey = AuthUserKey }).ToList();
            List<LevelTwo> lvUnion = pageAuthRepo.GetUnionAuth(new { AuthUserKey = AuthUserKey }).ToList();
            List<LevelTwo> lvCompany = pageAuthRepo.GetCompanyAuth(new { AuthUserKey = AuthUserKey }).ToList();

            var chk = planGroupRepo.selectListAll(new { }).ToList().Where(w => w.PlanYear == PlanYear).Where(w => w.TableName == TableName).FirstOrDefault();
            List<PmPalBusinessExp> lastPmB = pmPalBusinessRepo.selectListPmLastYear(new { year = PlanYear }).ToList();
            List<PmPalBusinessExp> thisPnB = pmPalBusinessRepo.selectListPnThisYear(new { year = PlanYear }).ToList();
            List<PmPalSummaryExp> lastPmC = pmPalSummaryRepo.selectListPmLastYear(new { year = PlanYear }).ToList();
            List<PmPalSummaryExp> thisPnC = pmPalSummaryRepo.selectListPnThisYear(new { year = PlanYear }).ToList();
            dynamic model = new ExpandoObject();

            model.chk = chk;

            model.lvGroup = lvGroup;
            model.lvUnion = lvUnion;
            model.lvCompany = lvCompany;

            model.lastPmB = lastPmB;
            model.thisPnB = thisPnB;
            model.lastPmC = lastPmC;
            model.thisPnC = thisPnC;

            return View("~/Views/Plan/Monthly_Pal/ExcelMonthlyPal.cshtml", model);
        }

        [Route("ExcelMonthlyPal_New")]
        public ActionResult ExcelMonthlyPal_New(Search search)
        {
            string PlanYear = SessionManager.GetMemberSession().planYear.First().RegistYear;
            string TableName = "PLAN_MONTHLY_PAL";
            search.year = PlanYear;
            string AuthUserKey = mSession.insaUserV.userKey;
            // 그룹권한 체크
            List<LevelTwo> lvGroup = pageAuthRepo.GetGroupAuth(new { AuthUserKey = AuthUserKey }).ToList();
            List<LevelTwo> lvUnion = pageAuthRepo.GetUnionAuth(new { AuthUserKey = AuthUserKey }).ToList();
            List<LevelTwo> lvCompany = pageAuthRepo.GetCompanyAuth(new { AuthUserKey = AuthUserKey }).ToList();

            var chk = planGroupRepo.selectListAll(new { }).ToList().Where(w => w.PlanYear == PlanYear).Where(w => w.TableName == TableName).FirstOrDefault();
            List<PmPalBusinessExp> lastPmB = pmPalBusinessRepo.selectListPmLastYear(new { year = PlanYear }).ToList();
            List<PmPalBusinessExp> thisPnB = pmPalBusinessRepo.selectListPnThisYear(new { year = PlanYear }).ToList();
            List<PmPalSummaryExp> lastPmC = pmPalSummaryRepo.selectListPmLastYear(new { year = PlanYear }).ToList();
            List<PmPalSummaryExp> thisPnC = pmPalSummaryRepo.selectListPnThisYear(new { year = PlanYear }).ToList();
            dynamic model = new ExpandoObject();

            model.chk = chk;

            model.lvGroup = lvGroup;
            model.lvUnion = lvUnion;
            model.lvCompany = lvCompany;

            model.lastPmB = lastPmB;
            model.thisPnB = thisPnB;
            model.lastPmC = lastPmC;
            model.thisPnC = thisPnC;
            model.thisGroupPlan = planGroupdataPalMonthRepo.selectList(new { PLANYEAR = search.year });
            return View("~/Views/Plan/Monthly_Pal/ExcelMonthlyPal_New.cshtml", model);
        }

        [Route("ViewMonthlyPal")]
        public ActionResult ViewMonthlyPal(Search search)
        {
            string PlanYear = SessionManager.GetMemberSession().planYear.First().RegistYear;
            string TableName = "PLAN_MONTHLY_PAL";
            search.year = PlanYear;
            string AuthUserKey = mSession.insaUserV.userKey;
            // 그룹권한 체크
            List<LevelTwo> lvGroup = pageAuthRepo.GetGroupAuth(new { AuthUserKey = AuthUserKey }).ToList();
            List<LevelTwo> lvUnion = pageAuthRepo.GetUnionAuth(new { AuthUserKey = AuthUserKey }).ToList();
            List<LevelTwo> lvCompany = pageAuthRepo.GetCompanyAuth(new { AuthUserKey = AuthUserKey }).ToList();

            var chk = planGroupRepo.selectListAll(new { }).ToList().Where(w => w.PlanYear == PlanYear).Where(w => w.TableName == TableName).FirstOrDefault();
            List<PmPalBusinessExp> lastPmB = pmPalBusinessRepo.selectListPmLastYear(new { year = PlanYear }).ToList();
            List<PmPalBusinessExp> thisPnB = pmPalBusinessRepo.selectListPnThisYear(new { year = PlanYear }).ToList();
            List<PmPalSummaryExp> lastPmC = pmPalSummaryRepo.selectListPmLastYear(new { year = PlanYear }).ToList();
            List<PmPalSummaryExp> thisPnC = pmPalSummaryRepo.selectListPnThisYear(new { year = PlanYear }).ToList();
            dynamic model = new ExpandoObject();

            model.chk = chk;

            model.lvGroup = lvGroup;
            model.lvUnion = lvUnion;
            model.lvCompany = lvCompany;

            model.lastPmB = lastPmB;
            model.thisPnB = thisPnB;
            model.lastPmC = lastPmC;
            model.thisPnC = thisPnC;

            return View("~/Views/Plan/Monthly_Pal/ViewMonthlyPal.cshtml", model);
        }




        [Route("Index")]
        public ActionResult Index(Search search)
        {
            string year = SessionManager.GetMemberSession().planYear.First().RegistYear;
            dynamic model = new ExpandoObject();

            // UNION 리스트 
            List<OrgUnionExp> orgUnionList = (List<OrgUnionExp>)orgUnionRepo.selectListExp(new { });

            // 계열사 리스트
            List<TbOrgCompanyExp> tbOrgCompanyList = (List<TbOrgCompanyExp>)tbOrgCompanyRepo.selectListByPlanMonthlyPal(new { year = year });

            // 월별 정보 가져오기 
            List<TbPlanMonthlyPalExp> tbPlanMonthlyPalList = tbPlanMonthlyPalRepo.selectListExp(new { year = year });

            // 월별정보 후처리
            tbOrgCompanyList = parsePlanMonthlyPalBusinessSummary(tbOrgCompanyList, tbPlanMonthlyPalList);

            // UNION 기준 데이터 매핑 (그룹사 전체)
            orgUnionList = parseUnionPlanMonthlyPalBusinessSummary(orgUnionList, tbOrgCompanyList);

            // 그룹 전체의 SUMMARY
            List<PlanMonthlyPalBusinessMonthlySum> groupTotalSummary = parseGroupTotalSummary(orgUnionList);

            model.orgUnionList = orgUnionList;
            model.groupTotalSummary = groupTotalSummary;

            model.tbOrgCompanyList = tbOrgCompanyList;
            model.tbPlanMonthlyPalList = tbPlanMonthlyPalList;

            return View("~/Views/Plan/Monthly_Pal/Index.cshtml", model);
        }


        [Route("Index_excel")]
        public ActionResult IndexExcel(Search search)
        {
            string year = SessionManager.GetMemberSession().planYear.First().RegistYear;
            dynamic model = new ExpandoObject();

            // UNION 리스트 
            List<OrgUnionExp> orgUnionList = (List<OrgUnionExp>)orgUnionRepo.selectListExp(new { });

            // 계열사 리스트
            List<TbOrgCompanyExp> tbOrgCompanyList = (List<TbOrgCompanyExp>)tbOrgCompanyRepo.selectListByPlanMonthlyPal(new { year = year });

            // 월별 정보 가져오기 
            List<TbPlanMonthlyPalExp> tbPlanMonthlyPalList = tbPlanMonthlyPalRepo.selectListExp(new { year = year });

            // 월별정보 후처리
            tbOrgCompanyList = parsePlanMonthlyPalBusinessSummary(tbOrgCompanyList, tbPlanMonthlyPalList);

            // UNION 기준 데이터 매핑 (그룹사 전체)
            orgUnionList = parseUnionPlanMonthlyPalBusinessSummary(orgUnionList, tbOrgCompanyList);

            // 그룹 전체의 SUMMARY
            List<PlanMonthlyPalBusinessMonthlySum> groupTotalSummary = parseGroupTotalSummary(orgUnionList);

            model.orgUnionList = orgUnionList;
            model.groupTotalSummary = groupTotalSummary;

            model.tbOrgCompanyList = tbOrgCompanyList;
            model.tbPlanMonthlyPalList = tbPlanMonthlyPalList;

            return View("~/Views/Plan/Monthly_Pal/Index_excel.cshtml", model);
        }


        public List<TbOrgCompanyExp> parsePlanMonthlyPalBusinessSummary(List<TbOrgCompanyExp> tbOrgCompanyList, List<TbPlanMonthlyPalExp> tbPlanMonthlyPalList)
        {
            // business 별 합계 처리
            foreach(var company in tbOrgCompanyList)
            {
                TbPlanMonthlyPalExp tbPlanMonthlyPalExp = tbPlanMonthlyPalList.Where(x => x.orgCompanySeq == company.seq).FirstOrDefault();
                if(tbPlanMonthlyPalExp != null && company.orgBusinessList != null)
                {
                    foreach(var business in company.orgBusinessList)
                    {
                        business.planMonthlyPalBusinessMonthlySumList = (List<PlanMonthlyPalBusinessMonthlySum>)tbPlanMonthlyPalBusinessRepo.selectSummaryList(new { planMonthlyPalSeq = tbPlanMonthlyPalExp.seq, orgBusinessSeq = business.Seq });
                    }
                }
            }

            // 전체 합계 처리
            foreach(var company in tbOrgCompanyList)
            {
                TbPlanMonthlyPalExp tbPlanMonthlyPalExp = tbPlanMonthlyPalList.Where(x => x.orgCompanySeq == company.seq).FirstOrDefault();
                if(tbPlanMonthlyPalExp != null)
                {
                    company.totalPlanMonthlyPalBusinessSummaryList = (List<PlanMonthlyPalBusinessMonthlySum>)planMonthlyPalBusinessMonthlySumRepo.selectListExp(new { planMonthlyPalSeq = tbPlanMonthlyPalExp.seq });
                }
            }

            // 전체 통계 처리
            foreach (var company in tbOrgCompanyList)
            {
                if(company.orgBusinessList != null)
                {
                    foreach(var business in company.orgBusinessList)
                    {
                        if(business.planMonthlyPalBusinessMonthlySumList != null)
                        {
                            foreach(var summary in business.planMonthlyPalBusinessMonthlySumList)
                            {
                                summary.EbitRate = Math.Round((summary.Ebit / summary.Sales) * 100, 1, MidpointRounding.AwayFromZero);
                            }
                        }
                    }
                }
            }

            // business별 통계 처리
            foreach(var company in tbOrgCompanyList)
            {
                if(company.totalPlanMonthlyPalBusinessSummaryList != null)
                {
                    foreach(var summary in company.totalPlanMonthlyPalBusinessSummaryList)
                    {
                        summary.EbitRate = Math.Round((summary.Ebit / summary.Sales) * 100, 1, MidpointRounding.AwayFromZero);
                    }
                }
            }

            return tbOrgCompanyList;
        }

        public List<OrgUnionExp> parseUnionPlanMonthlyPalBusinessSummary(List<OrgUnionExp> orgUnionList, List<TbOrgCompanyExp> tbOrgCompanyList)
        {

            foreach(var union in orgUnionList)
            {
                List<PlanMonthlyPalBusinessMonthlySum> procedList = new List<PlanMonthlyPalBusinessMonthlySum>();
                List<TbOrgCompanyExp> companyList = tbOrgCompanyList.Where(x => x.orgUnionSeq == union.Seq).ToList();
                foreach(var company in companyList)
                {
                    List<PlanMonthlyPalBusinessMonthlySum> totalSummaryList = company.totalPlanMonthlyPalBusinessSummaryList;
                    if(totalSummaryList != null)
                    {
                        foreach(var summary in totalSummaryList)
                        {
                            if(procedList.Where(x => x.Monthly == summary.Monthly).ToList().Count() > 0)
                            {
                                procedList.Where(x => x.Monthly == summary.Monthly).FirstOrDefault().Sales = procedList.Where(x => x.Monthly == summary.Monthly).FirstOrDefault().Sales + summary.Sales;

                                procedList.Where(x => x.Monthly == summary.Monthly).FirstOrDefault().Ebit = procedList.Where(x => x.Monthly == summary.Monthly).FirstOrDefault().Ebit + summary.Ebit;
                            }
                            else
                            {
                                PlanMonthlyPalBusinessMonthlySum info = new PlanMonthlyPalBusinessMonthlySum();
                                info.Sales = summary.Sales;
                                info.Ebit = summary.Ebit;
                                info.Monthly = summary.Monthly;
                                procedList.Add(info);
                            }
                        }
                    }
                }
                union.planMonthlyPalBusinessSummaryList = procedList;
            }

            foreach(var union in orgUnionList)
            {
                foreach(var summary in union.planMonthlyPalBusinessSummaryList)
                {
                    summary.EbitRate = Math.Round((summary.Ebit / summary.Sales) * 100, 1, MidpointRounding.AwayFromZero);
                }
            }

            return orgUnionList;
        }

        public List<PlanMonthlyPalBusinessMonthlySum> parseGroupTotalSummary(List<OrgUnionExp> orgUnionList)
        {
            List<PlanMonthlyPalBusinessMonthlySum> resultList = new List<PlanMonthlyPalBusinessMonthlySum>();
            foreach(var union in orgUnionList)
            {
                foreach(var summary in union.planMonthlyPalBusinessSummaryList)
                {
                    if(resultList.Where(x => x.Monthly == summary.Monthly).Count() > 0)
                    {
                        resultList.Where(x => x.Monthly == summary.Monthly).FirstOrDefault().Sales = resultList.Where(x => x.Monthly == summary.Monthly).FirstOrDefault().Sales + summary.Sales;

                        resultList.Where(x => x.Monthly == summary.Monthly).FirstOrDefault().Ebit = resultList.Where(x => x.Monthly == summary.Monthly).FirstOrDefault().Ebit + summary.Ebit;
                    }
                    else
                    {
                        PlanMonthlyPalBusinessMonthlySum info = new PlanMonthlyPalBusinessMonthlySum();
                        info.Sales = summary.Sales;
                        info.Ebit = summary.Ebit;
                        info.Monthly = summary.Monthly;
                        resultList.Add(info);
                    }
                }
            }

            foreach(var item in resultList)
            {
                item.EbitRate = Math.Round((item.Ebit / item.Sales) * 100, 1, MidpointRounding.AwayFromZero);
            }

            return resultList;
        }
    }
}