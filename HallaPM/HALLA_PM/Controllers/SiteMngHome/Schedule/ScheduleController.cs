using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

using HALLA_PM.Core;
using HALLA_PM.Util;
using HALLA_PM.Models;
using System.Dynamic;

namespace HALLA_PM.Controllers.SiteMngHome
{
    [AdminLoginFilter]
    [AuthAdminFilter(RequestAuthLevel = 1)]
    [RoutePrefix("SiteMngHome/Schedule")]
    public class ScheduleController : SiteMngBaseController
    {
        [Route("List")]
        public ActionResult List(Search search)
        {
            dynamic model = new ExpandoObject();
            model.list = planScheduleRepo.selectList(search);
            ViewBag.Search = search;
            return View("~/Views/SiteMngHome/Schedule/List.cshtml", model);
        }

        [Route("Write")]
        public ActionResult Write(Search search)
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");

            dynamic model = new ExpandoObject();
            model.maxYear = planScheduleRepo.selectOneMaxYear(new { });
            ViewBag.Search = search;
            return View("~/Views/SiteMngHome/Schedule/Write.cshtml", model);
        }

        [Route("View")]
        public ActionResult view()
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");

            return View("~/Views/SiteMngHome/Schedule/View.cshtml");
        }

        [Route("Edit")]
        public ActionResult Edit(string ScheduleYear, Search search)
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");

            dynamic model = new ExpandoObject();
            model.Schedule = planScheduleRepo.selectOne(new { ScheduleYear = ScheduleYear });
            model.SchedulePerformance = planSchedulePerformanceRegRepo.selectList(new { ScheduleYear = ScheduleYear });
            ViewBag.Search = search;
            return View("~/Views/SiteMngHome/Schedule/Edit.cshtml", model);
        }

        [Route("Write_Action")]
        public ActionResult WriteAction(PlanSchedule entity, Search search)
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");

            if (string.IsNullOrWhiteSpace(entity.ApplyChk)) entity.ApplyChk = "N";
            if (planScheduleRepo.save(entity) > 0)
            {
                planSchedulePerformanceRegRepo.deleteYear(new { entity.ScheduleYear });
                for (int i = 0; i < entity.RegMonth.Count(); i++)
                {
                    PlanSchedulePerformanceReg pReg = new PlanSchedulePerformanceReg();
                    pReg.ScheduleYear = entity.ScheduleYear;
                    pReg.RegMonth = entity.RegMonth[i];
                    pReg.RegDtStart = entity.RegDtStart[i];
                    pReg.RegDtEnd = entity.RegDtEnd[i];
                    planSchedulePerformanceRegRepo.save(pReg);
                }
                TempData["alert"] = entity.message + "되었습니다.";
            }
            else
            {
                TempData["alert"] = entity.message + "에 실패하였습니다.";
            }

            return RedirectToAction("List", search);
        }

        [Route("Apply_Action")]
        public ActionResult ApplyAction(PlanSchedule entity, Search search)
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");

            var s = planScheduleRepo.selectOne(new { ScheduleYear = entity.ScheduleYear });

            if (s.ApplyChk == "Y")
            {
                TempData["alert"] = "이미 승인요청되었습니다.";
                return RedirectToAction("List");
            }

            // 현재 가진 조직을 가져온다.
            var orgList = orgCompanyRepo.selectListAdminAuth(new { });

            foreach (var org in orgList)
            {
                // 손익월별계획
                PlanMonthlyPal planMonthlyPal = new PlanMonthlyPal();
                planMonthlyPal.MonthlyPalYear = entity.ScheduleYear;
                planMonthlyPal.OrgCompanySeq = org.Seq;
                planMonthlyPal.RegistStatus = Define.REGIST_STATUS.GetKey("미등록");
                var item = planMonthlyPalRepo.selectOneCompany(planMonthlyPal);
                if (item == null) planMonthlyPalRepo.insert(planMonthlyPal);

                // 손익중기계획
                PlanYearPal planYearPal = new PlanYearPal();
                planYearPal.YearPalYear = entity.ScheduleYear;
                planYearPal.OrgCompanySeq = org.Seq;
                planYearPal.RegistStatus = Define.REGIST_STATUS.GetKey("미등록");
                var item2 = planYearPalRepo.selectOneCompany(planYearPal);
                if (item2 == null) planYearPalRepo.insert(planYearPal);

                // 중기BS
                PlanYearBs planYearBs = new PlanYearBs();
                planYearBs.YearBsYear = entity.ScheduleYear;
                planYearBs.OrgCompanySeq = org.Seq;
                planYearBs.RegistStatus = Define.REGIST_STATUS.GetKey("미등록");
                var item3 = planYearBsRepo.selectOneCompany(planYearBs);
                if (item3 == null) planYearBsRepo.insert(planYearBs);

                // 중기BS 예외처리 (주)한라
                if (org.Seq == 6)
                {
                    PlanYearBsEx planYearBsEx = new PlanYearBsEx();
                    planYearBsEx.YearBsYear = entity.ScheduleYear;
                    planYearBsEx.OrgCompanySeq = org.Seq;
                    planYearBsEx.RegistStatus = Define.REGIST_STATUS.GetKey("미등록");
                    var item3_1 = planYearBsExRepo.selectOneCompany(planYearBsEx);
                    if (item3_1 == null) planYearBsExRepo.insert(planYearBsEx);
                }

                // 중기CF
                PlanYearCf planYearCf = new PlanYearCf();
                planYearCf.YearCfYear = entity.ScheduleYear;
                planYearCf.OrgCompanySeq = org.Seq;
                planYearCf.RegistStatus = Define.REGIST_STATUS.GetKey("미등록");
                var item4 = planYearCfRepo.selectOneCompany(planYearCf);
                if (item4 == null) planYearCfRepo.insert(planYearCf);

                // 월별투자인원계획
                PlanMonthlyInvest planMonthlyInvest = new PlanMonthlyInvest();
                planMonthlyInvest.MonthlyInvestYear = entity.ScheduleYear;
                planMonthlyInvest.OrgCompanySeq = org.Seq;
                planMonthlyInvest.RegistStatus = Define.REGIST_STATUS.GetKey("미등록");
                var item11 = planMonthlyInvestRepo.selectOneCompany(planMonthlyInvest);
                if (item11 == null) planMonthlyInvestRepo.insert(planMonthlyInvest);

                 // 중기투자인원계획
                 PlanYearInvest planYearInvest = new PlanYearInvest();
                planYearInvest.YearInvestYear = entity.ScheduleYear;
                planYearInvest.OrgCompanySeq = org.Seq;
                planYearInvest.RegistStatus = Define.REGIST_STATUS.GetKey("미등록");
                var item5 = planYearInvestRepo.selectOneCompany(planYearInvest);
                if (item5 == null) planYearInvestRepo.insert(planYearInvest);

                // 실적은 월별 입력 초기 설정을 1월부터 12월까지
                PmCashFlow pmCashFlow = new PmCashFlow();           // Cash Flow
                PmPal pmPal = new PmPal();                          // 손익
                PmQuarterPal pmQuarterPal = new PmQuarterPal();     // 분기별손익
                PmBs pmBs = new PmBs();                             // BS
                PmBsEx pmBsEx = new PmBsEx();
                PmInvest pmInvest = new PmInvest();                 // 투자인원계획

                for (int i = 1; i <= 12; i++)
                {
                    pmCashFlow.CashFlowYear = entity.ScheduleYear;
                    pmCashFlow.OrgCompanySeq = org.Seq;
                    pmCashFlow.Monthly = i.ToString().PadLeft(2, '0');
                    pmCashFlow.RegistStatus = Define.REGIST_STATUS.GetKey("미등록");
                    var item6 = pmCashFlowRepo.selectOneCompany(pmCashFlow);
                    if (item6 == null) pmCashFlowRepo.insert(pmCashFlow);

                    pmPal.PalYear = entity.ScheduleYear;
                    pmPal.OrgCompanySeq = org.Seq;
                    pmPal.Monthly = i.ToString().PadLeft(2, '0');
                    pmPal.RegistStatus = Define.REGIST_STATUS.GetKey("미등록");
                    var item7 = pmPalRepo.selectOneCompany(pmPal);
                    if (item7 == null) pmPalRepo.insert(pmPal);

                    pmQuarterPal.QuarterPalYear = entity.ScheduleYear;
                    pmQuarterPal.OrgCompanySeq = org.Seq;
                    pmQuarterPal.Monthly = i.ToString().PadLeft(2, '0');
                    pmQuarterPal.RegistStatus = Define.REGIST_STATUS.GetKey("미등록");
                    var item8 = pmQuarterPalRepo.selectOneCompany(pmQuarterPal);
                    if (item8 == null) pmQuarterPalRepo.insert(pmQuarterPal);

                    pmBs.BsYear = entity.ScheduleYear;
                    pmBs.OrgCompanySeq = org.Seq;
                    pmBs.Monthly = i.ToString().PadLeft(2, '0');
                    pmBs.RegistStatus = Define.REGIST_STATUS.GetKey("미등록");
                    var item9 = pmBsRepo.selectOneCompany(pmBs);
                    if (item9 == null) pmBsRepo.insert(pmBs);

                    // (주) 한라 예외 처리
                    if (org.Seq == 6)
                    {
                        pmBsEx.BsYear = entity.ScheduleYear;
                        pmBsEx.OrgCompanySeq = org.Seq;
                        pmBsEx.Monthly = i.ToString().PadLeft(2, '0');
                        pmBsEx.RegistStatus = Define.REGIST_STATUS.GetKey("미등록");
                        var item9_1 = pmBsExRepo.selectOneCompany(pmBsEx);
                        if (item9_1 == null) pmBsExRepo.insert(pmBsEx);
                    }

                    pmInvest.InvestYear = entity.ScheduleYear;
                    pmInvest.OrgCompanySeq = org.Seq;
                    pmInvest.Monthly = i.ToString().PadLeft(2, '0');
                    pmInvest.RegistStatus = Define.REGIST_STATUS.GetKey("미등록");
                    var item10 = pmInvestRepo.selectOneCompany(pmInvest);
                    if (item10 == null) pmInvestRepo.insert(pmInvest);
                }
            }

            var n = planScheduleRepo.save(entity);
            if (n > 0)
            {
                TempData["alert"] = entity.message + "되었습니다.";
            }
            else
            {
                TempData["alert"] = entity.message + "실패 되었습니다.";
            }

            return RedirectToAction("List", search);
        }
    }
}