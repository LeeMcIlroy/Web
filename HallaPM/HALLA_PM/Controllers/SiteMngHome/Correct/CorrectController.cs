using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

using HALLA_PM.Core;
using HALLA_PM.Util;
using HALLA_PM.Models;
using System.Dynamic; 

namespace HALLA_PM.Controllers.SiteMngHome.Correct
{
    [AdminLoginFilter]
    [AuthAdminFilter(RequestAuthLevel = 2)]
    [RoutePrefix("SiteMngHome/Correct")] 
    public class CorrectController : Controller
    { 
        
        PlanGroupdataYearRepo planGroupdataYear = new PlanGroupdataYearRepo();
        PmGroupdataMonthRepo pmGroupDataMonth = new PmGroupdataMonthRepo();

        [Route("PlanList")]
        public ActionResult PlanList(Search search)
        {
            dynamic model = new ExpandoObject();
            search.AuthUserKey = SessionManager.GetAdminSession().insaUserV.userKey;
            model.list = planGroupdataYear.selectList(search);
            ViewBag.Search = search;
            return View("~/Views/SiteMngHome/Correct/Plan/List.cshtml",model);
        }

        [Route("PlanMonthPalEdit")]
        public ActionResult PlanMonthPalEdit(int GroupDataSeq,string PlanYear, Search search)
        {
            PlanGroupdataPalQuarterRepo planGroupdataPalQuarterRepo = new PlanGroupdataPalQuarterRepo();
            PlanGroupdataPalMonthRepo planGroupdataPalMonthRepo = new PlanGroupdataPalMonthRepo();
            PlanGroupdataPalSummaryRepo planGroupdataPalSummaryRepo = new PlanGroupdataPalSummaryRepo();
            PlanGroupdataPalQuarterCrRepo planGroupdataPalQuarterCrRepo = new PlanGroupdataPalQuarterCrRepo();
            PlanGroupdataPalMonthCrRepo planGroupdataPalMonthCrRepo = new PlanGroupdataPalMonthCrRepo();
            PlanGroupdataPalSummaryCrRepo planGroupdataPalSummaryCrRepo = new PlanGroupdataPalSummaryCrRepo();
            dynamic model = new ExpandoObject();
            model.PlanGroupdataYear = planGroupdataYear.selectOne(new {seq = GroupDataSeq });
            model.PalMonthList = planGroupdataPalMonthRepo.selectList(new { PlanYear });
            model.PalQuarterList = planGroupdataPalQuarterRepo.selectList(new { PlanYear });
            model.PalSummaryList = planGroupdataPalSummaryRepo.selectList(new { PlanYear });
            model.PalMonthListCr = planGroupdataPalMonthCrRepo.selectList(new { PlanYear });
            model.PalQuarterListCr = planGroupdataPalQuarterCrRepo.selectList(new { PlanYear });
            model.PalSummaryListCr = planGroupdataPalSummaryCrRepo.selectList(new { PlanYear });
            model.PlanYear = PlanYear;
            ViewBag.Search = search;
            return View("~/Views/SiteMngHome/Correct/Plan/MonthPalEdit.cshtml", model);
        }
         

        [Route("PlanCashFlowEdit")]
        public ActionResult PlanCashFlowEdi(int GroupDataSeq, string PlanYear, Search search)
        {
            PlanGroupdataCashflowMonthRepo planGroupdataCashflowMonthRepo = new PlanGroupdataCashflowMonthRepo();
            PlanGroupdataCashflowMonthCrRepo planGroupdataCashflowMonthCrRepo = new PlanGroupdataCashflowMonthCrRepo();
            PlanGroupdataCashflowSummaryRepo planGroupdataCashflowSummaryRepo = new PlanGroupdataCashflowSummaryRepo();

            dynamic model = new ExpandoObject();
            model.PlanGroupdataYear = planGroupdataYear.selectOne(new { seq = GroupDataSeq });
            model.CashflowMonthList = planGroupdataCashflowMonthRepo.selectList(new { PlanYear });
            model.CashflowMonthListCr = planGroupdataCashflowMonthCrRepo.selectList(new { PlanYear });
            model.CashflowSummaryList = null;
            model.PlanYear = PlanYear;
            ViewBag.Search = search;
            return View("~/Views/SiteMngHome/Correct/Plan/CashFlowEdit.cshtml", model);
        }

        [Route("PlanBsEdit")]
        public ActionResult PlanBsEdit(int GroupDataSeq, string PlanYear, Search search)
        {
            PlanGroupdataBsMonthRepo planGroupdataBsMonthRepo = new PlanGroupdataBsMonthRepo();
            PlanGroupdataBsSummaryRepo planGroupdataBsSummaryRepo = new PlanGroupdataBsSummaryRepo();
            PlanGroupdataBsMonthCrRepo planGroupdataBsMonthCrRepo = new PlanGroupdataBsMonthCrRepo();
            PlanGroupdataBsSummaryCrRepo planGroupdataBsSummaryCrRepo = new PlanGroupdataBsSummaryCrRepo();
            dynamic model = new ExpandoObject();
            model.PlanGroupdataYear = planGroupdataYear.selectOne(new { seq = GroupDataSeq });
            model.BsMonthList = planGroupdataBsMonthRepo.selectList(new { PlanYear });
            model.BsSummaryList = planGroupdataBsSummaryRepo.selectList(new { PlanYear });
            model.BsMonthListCr = planGroupdataBsMonthCrRepo.selectList(new { PlanYear });
            model.BsSummaryListCr = planGroupdataBsSummaryCrRepo.selectList(new { PlanYear });
            model.PlanYear = PlanYear;
            ViewBag.Search = search;
            return View("~/Views/SiteMngHome/Correct/Plan/BsEdit.cshtml", model);
        }

        [Route("PlanInvestEdit")]
        public ActionResult PlanInvestEdit(int GroupDataSeq, string PlanYear, Search search)
        {
            PlanGroupdataInvestMonthRepo planGroupdataInvestMonthRepo = new PlanGroupdataInvestMonthRepo();
            PlanGroupdataInvestSummaryRepo planGroupdataInvestSummaryRepo = new PlanGroupdataInvestSummaryRepo();
            PlanGroupdataInvestMonthCrRepo planGroupdataInvestMonthCrRepo = new PlanGroupdataInvestMonthCrRepo();
            PlanGroupdataInvestSummaryCrRepo planGroupdataInvestSummaryCrRepo = new PlanGroupdataInvestSummaryCrRepo();
            dynamic model = new ExpandoObject();
            model.PlanGroupdataYear = planGroupdataYear.selectOne(new { seq = GroupDataSeq });         
            model.InvestMonthList = planGroupdataInvestMonthRepo.selectList(new { PlanYear });
            model.InvestSummaryList = planGroupdataInvestSummaryRepo.selectList(new { PlanYear });
            model.InvestMonthListCr = planGroupdataInvestMonthCrRepo.selectList(new { PlanYear });
            model.InvestSummaryListCr = planGroupdataInvestSummaryCrRepo.selectList(new { PlanYear });
            model.PlanYear = PlanYear;
            ViewBag.Search = search;
            return View("~/Views/SiteMngHome/Correct/Plan/InvestEdit.cshtml", model);
        }

        [Route("PerformanceList")]
        public ActionResult PerformanceList(Search search)
        {
            dynamic model = new ExpandoObject();
            search.AuthUserKey = SessionManager.GetAdminSession().insaUserV.userKey;
            model.list = pmGroupDataMonth.selectList(search);
            ViewBag.Search = search; 
            return View("~/Views/SiteMngHome/Correct/Performance/List.cshtml", model);
        }

        [Route("PerformanceMonthPalEdit")]
        public ActionResult PerformanceMonthPalEdit(int GroupDataSeq, string PmYear, string PmMonth, Search search)
        {
            PmGroupdataPalMonthRepo pmGroupdataPalMonthRepo = new PmGroupdataPalMonthRepo();
            PmGroupdataPalMonthCrRepo pmGroupdataPalMonthCrRepo = new PmGroupdataPalMonthCrRepo();
            dynamic model = new ExpandoObject();
            model.PmGroupdataMonth = pmGroupDataMonth.selectOne(new { seq = GroupDataSeq });
            model.PmPalMonthList = pmGroupdataPalMonthRepo.selectList(new { PmYear, PmMonth });
            model.PmPalMonthListCr = pmGroupdataPalMonthCrRepo.selectList(new { PmYear, PmMonth });
            model.PmYear = PmYear;
            model.PmMonth = PmMonth;
            ViewBag.Search = search;
            return View("~/Views/SiteMngHome/Correct/Performance/MonthPalEdit.cshtml", model);
        }

        [Route("PerformanceBsEdit")]
        public ActionResult PerformanceBsEdit(int GroupDataSeq, string PmYear, string PmMonth, Search search)
        {
            PmGroupdataBsMonthRepo pmGroupdataBsMonthRepo = new PmGroupdataBsMonthRepo();
            PmGroupdataBsMonthCrRepo pmGroupdataBsMonthCrRepo = new PmGroupdataBsMonthCrRepo();
            dynamic model = new ExpandoObject();
            model.PmGroupdataMonth = pmGroupDataMonth.selectOne(new { seq = GroupDataSeq });
            model.PmBsMonthList = pmGroupdataBsMonthRepo.selectList(new { PmYear, PmMonth });
            model.PmBsMonthListCr = pmGroupdataBsMonthCrRepo.selectList(new { PmYear, PmMonth });
            model.PmYear = PmYear;
            model.PmMonth = PmMonth;
            ViewBag.Search = search;
            return View("~/Views/SiteMngHome/Correct/Performance/BsEdit.cshtml", model);
        }

        [Route("PerformanceInvestEdit")]
        public ActionResult PerformanceInvestEdit(int GroupDataSeq, string PmYear, string PmMonth, Search search)
        { 
            PmGroupdataInvestMonthRepo pmGroupdataInvestMonthRepo = new PmGroupdataInvestMonthRepo();
            PmGroupdataInvestMonthCrRepo pmGroupdataInvestMonthCrRepo = new PmGroupdataInvestMonthCrRepo();
            dynamic model = new ExpandoObject();
            model.PmGroupdataMonth = pmGroupDataMonth.selectOne(new { seq = GroupDataSeq });
            model.PmMonthList = pmGroupdataInvestMonthRepo.selectList(new { PmYear, PmMonth });
            model.PmMonthListCr = pmGroupdataInvestMonthCrRepo.selectList(new { PmYear, PmMonth });
            model.PmYear = PmYear;
            model.PmMonth = PmMonth;
            ViewBag.Search = search; 
            return View("~/Views/SiteMngHome/Correct/Performance/InvestEdit.cshtml", model);
        }

        [Route("PerformanceCashFlowEdit")]
        public ActionResult PerformanceCashFlowEdit(int GroupDataSeq, string PmYear, string PmMonth, Search search)
        {
            PmGroupdataCashflowMonthRepo pmGroupdataCashflowMonthRepo = new PmGroupdataCashflowMonthRepo();
            PmGroupdataCashflowMonthCrRepo pmGroupdataCashflowMonthCrRepo = new PmGroupdataCashflowMonthCrRepo();
            dynamic model = new ExpandoObject();
            model.PmGroupdataMonth = pmGroupDataMonth.selectOne(new { seq = GroupDataSeq });
            model.PmCashflowMonthList = pmGroupdataCashflowMonthRepo.selectList(new { PmYear, PmMonth });
            model.PmCashflowMonthListCr = pmGroupdataCashflowMonthCrRepo.selectList(new { PmYear, PmMonth });
            model.PmYear = PmYear;
            model.PmMonth = PmMonth;
            ViewBag.Search = search;
            return View("~/Views/SiteMngHome/Correct/Performance/CashFlowEdit.cshtml", model);
        }

        [Route("PerformanceQuarterPalEdit")]
        public ActionResult PerformanceQuarterPalEdit(int GroupDataSeq, string PmYear, string PmMonth, Search search)
        {
            PmGroupdataQuarterPalMonthRepo pmGroupdataQuarterPalMonthRepo = new PmGroupdataQuarterPalMonthRepo();
            PmGroupdataQuarterPalMonthCrRepo pmGroupdataQuarterPalMonthCrRepo = new PmGroupdataQuarterPalMonthCrRepo();
            dynamic model = new ExpandoObject();
            model.PmGroupdataMonth = pmGroupDataMonth.selectOne(new { seq = GroupDataSeq });
            model.PmQuarterPalMonthList = pmGroupdataQuarterPalMonthRepo.selectList(new { PmYear, PmMonth });
            model.PmQuarterPalMonthListCr = pmGroupdataQuarterPalMonthCrRepo.selectList(new { PmYear, PmMonth });
            model.PmYear = PmYear;
            model.PmMonth = PmMonth;
            ViewBag.Search = search;
            return View("~/Views/SiteMngHome/Correct/Performance/QuarterPalEdit.cshtml", model);
        }


    }
}