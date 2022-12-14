using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

using HALLA_PM.Core;
using HALLA_PM.Util;
using HALLA_PM.Models;
using System.Dynamic;
using Fluentx.Mvc;
using ClosedXML.Excel;
using System.IO;
using System.Data;

namespace HALLA_PM.Controllers.SiteMngHome
{
    [AdminLoginFilter]
    [AuthAdminFilter(RequestAuthLevel = 3)]
    [RoutePrefix("SiteMngHome/Plan/Year_Bs")]
    public class PlanYearBsController : SiteMngBaseController
    {
        [Route("List")]
        public ActionResult List(Search search)
        {
            dynamic model = new ExpandoObject();
            search.AuthUserKey = SessionManager.GetAdminSession().insaUserV.userKey;
            model.list = planYearBsRepo.selectList(search);
            model.UnionList = orgUnionRepo.selectList(new { });
            model.OrgCpyList = orgCompanyRepo.selectList(null);
            ViewBag.Search = search;

            return View("~/Views/SiteMngHome/Plan/Year_Bs/List.cshtml", model);
        }

        [Route("Write")]
        public ActionResult Write(PlanYearBs entity, Search search)
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");

            // 기본 정보 가져온다.
            var planYearBs = planYearBsRepo.selectOne(entity);
            // 회사 밑에 부서 정보를 가져온다
            var orgBusinessList = orgBusinessRepo.selectListCompany(new { Seq = entity.OrgCompanySeq });

            var orgCompanyName = orgCompanyRepo.selectOne(new { Seq = entity.OrgCompanySeq });

            int thisYear = Convert.ToInt32(planYearBs.YearBsYear);
            int lastYear = thisYear + 4;

            //B/Sheet
            for (int i = thisYear; i <= lastYear; i++)
            {
                var p = new PlanYearBsBsheet();
                
                p.Assets = 0;
                p.CurrentAssets = 0;
                p.Liabilities = 0;
                p.CurrentLiabilities = 0;
                p.Capital = 0;
                p.Cash = 0;
                p.Loan = 0;
                p.LiabilitiesRate = 0;
                p.CurrentRate = 0;

                if (i == thisYear)
                {
                    for (int j = 1; j <= 12; j++)
                    {
                        p.PlanYearBsSeq = entity.Seq;
                        p.YearlyYear = i.ToString();
                        p.Monthly = j.ToString().PadLeft(2, '0');
                        string where = " WHERE PLAN_YEAR_BS_SEQ = @PlanYearBsSeq AND YEARLY_YEAR = @YearlyYear AND MONTHLY = @Monthly ";
                        if (planYearBsBsheetRepo.count(p, where) == 0) planYearBsBsheetRepo.insert(p);
                    }
                }
                else
                {
                    p.PlanYearBsSeq = entity.Seq;
                    p.YearlyYear = i.ToString();
                    p.Monthly = "99";
                    string where = " WHERE PLAN_YEAR_BS_SEQ = @PlanYearBsSeq AND YEARLY_YEAR = @YearlyYear AND MONTHLY = @Monthly ";
                    if (planYearBsBsheetRepo.count(p, where) == 0) planYearBsBsheetRepo.insert(p);
                }
            }

            //ROIC
            for (int i = thisYear; i <= lastYear; i++)
            {
                var r = new PlanYearBsRoic();
                
                r.YearlyYear = i.ToString();
                //r.Monthly = i.ToString().PadLeft(2, '0');
                r.AfterTaxOperationProfit = 0;
                r.PainInCapital = 0;
                r.Roic = 0;

                if (i == thisYear)
                {
                    for (int j = 1; j <= 12; j++)
                    {
                        r.PlanYearBsSeq = entity.Seq;
                        r.YearlyYear = i.ToString();
                        r.Monthly = j.ToString().PadLeft(2, '0');

                        string where = " WHERE PLAN_YEAR_BS_SEQ = @PlanYearBsSeq AND YEARLY_YEAR = @YearlyYear AND MONTHLY = @Monthly";
                        if (planYearBsRoicRepo.count(r, where) == 0) planYearBsRoicRepo.insert(r);
                    }
                }
                else
                {
                    r.PlanYearBsSeq = entity.Seq;
                    r.YearlyYear = i.ToString();
                    r.Monthly = "99";
                    string where = " WHERE PLAN_YEAR_BS_SEQ = @PlanYearBsSeq AND YEARLY_YEAR = @YearlyYear AND MONTHLY = @Monthly";
                    if (planYearBsRoicRepo.count(r, where) == 0) planYearBsRoicRepo.insert(r);
                }
            }

            //W/Captial
            for (int i = thisYear; i <= lastYear; i++)
            {
                var wc = new PlanYearBsWCapital();

                wc.AnnualSales = 0;
                wc.AnnualSalesCost = 0;
                wc.InventoryCost = 0;
                wc.PlanYearBsSeq = entity.Seq;
                wc.YearlyYear = i.ToString();

                // 2018.12.19 월별데이터 입력가능하게 수정
                if (i == thisYear)
                {
                    for (int j = 1; j <= 12; j++)
                    {
                        wc.Monthly = j.ToString().PadLeft(2, '0');
                        string whereMonth = " WHERE PLAN_YEAR_BS_SEQ = @PlanYearBsSeq AND YEARLY_YEAR = @YearlyYear AND MONTHLY = @Monthly";
                        if (planYearBsWCapitalRepo.count(wc, whereMonth) == 0) planYearBsWCapitalRepo.insert(wc);
                    }

                    // 2019.01.16 연말데이터 입력 안함
                    // 연말데이터 입력
                    //wc.Monthly = "99";
                    //string where = " WHERE PLAN_YEAR_BS_SEQ = @PlanYearBsSeq AND YEARLY_YEAR = @YearlyYear AND MONTHLY = @Monthly";
                    //if (planYearBsWCapitalRepo.count(wc, where) == 0) planYearBsWCapitalRepo.insert(wc);
                }
                else
                {
                    // 연말데이터 입력
                    wc.Monthly = "99";
                    string where = " WHERE PLAN_YEAR_BS_SEQ = @PlanYearBsSeq AND YEARLY_YEAR = @YearlyYear AND MONTHLY = @Monthly";
                    if (planYearBsWCapitalRepo.count(wc, where) == 0) planYearBsWCapitalRepo.insert(wc);
                }               
            }

            // W/Captial - 등록
            for (int i = thisYear; i <= lastYear; i++)
            {
                var wcr = new PlanYearBsWCapitalReg();

                wcr.Ar = 0;
                wcr.ArToDays = 0;
                wcr.Ap = 0;
                wcr.ApToDays = 0;
                wcr.Inventory = 0;
                wcr.InventoryToDays = 0;

                if (i == thisYear)
                {
                    for (int j = 1; j <= 12; j++)
                    {
                        wcr.PlanYearBsSeq = entity.Seq;
                        wcr.YearlyYear = i.ToString();
                        wcr.Monthly = j.ToString().PadLeft(2, '0');

                        string whereMonth = " WHERE PLAN_YEAR_BS_SEQ = @PlanYearBsSeq AND YEARLY_YEAR = @YearlyYear AND MONTHLY = @Monthly";
                        if (planYearBsWCapitalRegRepo.count(wcr, whereMonth) == 0) planYearBsWCapitalRegRepo.insert(wcr);
                    }
                    //wcr.PlanYearBsSeq = entity.Seq;
                    //wcr.YearlyYear = i.ToString();
                    //wcr.Monthly = "99";

                    //string where = " WHERE PLAN_YEAR_BS_SEQ = @PlanYearBsSeq AND YEARLY_YEAR = @YearlyYear AND MONTHLY = @Monthly";
                    //if (planYearBsWCapitalRegRepo.count(wcr, where) == 0) planYearBsWCapitalRegRepo.insert(wcr);
                }
                else
                {
                    wcr.PlanYearBsSeq = entity.Seq;
                    wcr.YearlyYear = i.ToString();
                    wcr.Monthly = "99";

                    string where = " WHERE PLAN_YEAR_BS_SEQ = @PlanYearBsSeq AND YEARLY_YEAR = @YearlyYear AND MONTHLY = @Monthly";
                    if (planYearBsWCapitalRegRepo.count(wcr, where) == 0) planYearBsWCapitalRegRepo.insert(wcr);
                }
            }

            //현재연도
            var nowYear = DateTime.Now.ToString("yyyy");
            //전년도
            var preYear = DateTime.Now.AddYears(-1).ToString("yyyy");

            //(B/Sheet) 전년도 데이터 합 가져오기
            var lastYearSales = planYearBsBsheetRepo.selectListBefore(new { OrgCompanySeq = entity.OrgCompanySeq, YearlyYear = planYearBs.YearBsYear });
            //(B/Sheet) 데이터 가져오기
            var thisYearSales = planYearBsBsheetRepo.selectList(new { PlanYearBsSeq = entity.Seq });

            //(ROIC) 전년도 데이터 합 가져오기
            var lastYearBsRoicList = planYearBsRoicRepo.selectListBefore(new { OrgCompanySeq = entity.OrgCompanySeq, YearlyYear = planYearBs.YearBsYear });
            //(ROIC) 데이터 가져오기
            var thisYearRoicList = planYearBsRoicRepo.selectList(new { PlanYearBsSeq = entity.Seq, YearlyYear = planYearBs.YearBsYear });

            // Wcapital 전년도 데이터 가져오기
            var lastYearBsWcapitalList = planYearBsWCapitalRepo.selectListBefore(new { OrgCompanySeq = entity.OrgCompanySeq, YearlyYear = planYearBs.YearBsYear });
            //(W/Capital) 데이터 가져오기
            var thisYearBsWCapitalList = planYearBsWCapitalRepo.selectList(new { PlanYearBsSeq = entity.Seq, YearlyYear = planYearBs.YearBsYear });

            //(W/Capital)등록 전년도 데이터 합 가져오기
            var lastYearBsWCapital = planYearBsWCapitalRegRepo.selectListBefore(new { OrgCompanySeq = entity.OrgCompanySeq, YearlyYear = planYearBs.YearBsYear });
            //(W/Capital)등록 데이터 가져오기
            var thisYearBsWCapitalRegList = planYearBsWCapitalRegRepo.selectList(new { PlanYearBsSeq = entity.Seq });

            //중기재무계획 요약
            var thisYearSummaryList = planYearBsSummaryRepo.selectList(new { PlanYearBsSeq = entity.Seq });

            // 전년도 실적 중기요약
            List<PmBsSummaryExp> lastYearSummaryList = pmBsSummaryRepo.selectListBefore(new { PlanYearBsSeq = entity.Seq, YearlyYear = planYearBs.YearBsYear }).Where(w => w.OrgCompanySeq == entity.OrgCompanySeq).ToList();

            dynamic model = new ExpandoObject();

            model.planYearBs = planYearBs;
            model.orgCompanyName = orgCompanyName;
            model.orgBusinessList = orgBusinessList;
            //B/Sheet
            model.lastYearSales = lastYearSales;
            model.thisYearSales = thisYearSales;
            //ROIC
            model.lastYearBsRoicList = lastYearBsRoicList;
            model.thisYearRoicList = thisYearRoicList;
            //W/Capital등록
            model.lastYearBsWcapitalList = lastYearBsWcapitalList;
            model.thisYearBsWCapitalList = thisYearBsWCapitalList;

            //W/Capital
            model.lastYearBsWCapital = lastYearBsWCapital;
            model.thisYearBsWCapitalRegList = thisYearBsWCapitalRegList;

            model.thisYearSummaryList = thisYearSummaryList;
            model.lastYearSummaryList = lastYearSummaryList;

            ViewBag.Search = search;
            return View("~/Views/SiteMngHome/Plan/Year_Bs/Write.cshtml", model);
        }

        [Route("Edit")]
        public ActionResult Edit(PlanYearBsAdmin entity, Search search)
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");

            // 기본 정보 가져온다.
            var planYearBs = planYearBsRepo.selectOne(entity);
            // 회사 밑에 부서 정보를 가져온다
            var orgBusinessList = orgBusinessRepo.selectListCompany(new { Seq = entity.OrgCompanySeq });

            var orgCompanyName = orgCompanyRepo.selectOne(new { Seq = entity.OrgCompanySeq });

            int thisYear = Convert.ToInt32(planYearBs.YearBsYear);
            int lastYear = thisYear + 5;
            
            //현재연도
            var nowYear = DateTime.Now.ToString("yyyy");
            //전년도
            var preYear = DateTime.Now.AddYears(-1).ToString("yyyy");

            //(B/Sheet) 전년도 데이터 합 가져오기
            var lastYearSales = planYearBsBsheetRepo.selectListBefore(new { OrgCompanySeq = entity.OrgCompanySeq, YearlyYear = planYearBs.YearBsYear });
            //(B/Sheet) 데이터 가져오기
            var thisYearSales = planYearBsBsheetRepo.selectList(new { PlanYearBsSeq = entity.Seq });

            //(ROIC) 전년도 데이터 합 가져오기
            var lastYearBsRoicList = planYearBsRoicRepo.selectListBefore(new { OrgCompanySeq = entity.OrgCompanySeq, YearlyYear = planYearBs.YearBsYear });
            //(ROIC) 데이터 가져오기
            var thisYearRoicList = planYearBsRoicRepo.selectList(new { PlanYearBsSeq = entity.Seq, YearlyYear = planYearBs.YearBsYear });

            // Wcapital 전년도 데이터 가져오기
            var lastYearBsWcapitalList = planYearBsWCapitalRepo.selectListBefore(new { OrgCompanySeq = entity.OrgCompanySeq, YearlyYear = planYearBs.YearBsYear });
            //(W/Capital) 데이터 가져오기
            var thisYearBsWCapitalList = planYearBsWCapitalRepo.selectList(new { PlanYearBsSeq = entity.Seq, YearlyYear = planYearBs.YearBsYear });

            //(W/Capital)등록 전년도 데이터 합 가져오기
            var lastYearBsWCapital = planYearBsWCapitalRegRepo.selectListBefore(new { OrgCompanySeq = entity.OrgCompanySeq, YearlyYear = planYearBs.YearBsYear });
            //(W/Capital)등록 데이터 가져오기
            var thisYearBsWCapitalRegList = planYearBsWCapitalRegRepo.selectList(new { PlanYearBsSeq = entity.Seq });

            // 전년도 실적 중기요약
            List<PmBsSummaryExp> lastYearSummaryList = pmBsSummaryRepo.selectListBefore(new { PlanYearBsSeq = entity.Seq, YearlyYear = planYearBs.YearBsYear }).Where(w=> w.OrgCompanySeq == entity.OrgCompanySeq).ToList();
            //중기재무계획 요약
            var thisYearSummaryList = planYearBsSummaryRepo.selectList(new { PlanYearBsSeq = entity.Seq });

            dynamic model = new ExpandoObject();

            model.planYearBs = planYearBs;
            model.orgCompanyName = orgCompanyName;
            model.orgBusinessList = orgBusinessList;

            //B/Sheet
            model.lastYearSales = lastYearSales;
            model.thisYearSales = thisYearSales;

            //ROIC
            model.lastYearBsRoicList = lastYearBsRoicList;
            model.thisYearRoicList = thisYearRoicList;

            //W/Capital등록
            model.lastYearBsWcapitalList = lastYearBsWcapitalList;
            model.thisYearBsWCapitalList = thisYearBsWCapitalList;

            //W/Capital
            model.lastYearBsWCapital = lastYearBsWCapital;
            model.thisYearBsWCapitalRegList = thisYearBsWCapitalRegList;

            model.lastYearSummaryList = lastYearSummaryList;
            model.thisYearSummaryList = thisYearSummaryList;

            if (entity.message != null)
            {
                TempData["alert"] = entity.message;
            }

            ViewBag.Search = search;
            return View("~/Views/SiteMngHome/Plan/Year_Bs/Edit.cshtml", model);
        }

        [Route("Edit2")]
        public ActionResult Edit2(PlanYearBsAdmin entity, Search search)
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");

            // 기본 정보 가져온다.
            var planYearBs = planYearBsRepo.selectOne(entity);

            var orgCompanyName = orgCompanyRepo.selectOne(new { Seq = entity.OrgCompanySeq });
            
            // 전년도 실적 중기요약
            List<PmBsSummaryExp> lastYearSummaryList = pmBsSummaryRepo.selectListBefore(new { PlanYearBsSeq = entity.Seq, YearlyYear = planYearBs.YearBsYear }).Where(w => w.OrgCompanySeq == entity.OrgCompanySeq).ToList();
            //중기재무계획 요약
            var thisYearSummaryList = planYearBsSummaryRepo.selectList(new { PlanYearBsSeq = entity.Seq });

            dynamic model = new ExpandoObject();

            model.planYearBs = planYearBs;
            model.orgCompanyName = orgCompanyName;

            model.lastYearSummaryList = lastYearSummaryList;
            model.thisYearSummaryList = thisYearSummaryList;

            if (entity.message != null)
            {
                TempData["alert"] = entity.message;
            }

            ViewBag.Search = search;
            return View("~/Views/SiteMngHome/Plan/Year_Bs/Edit2.cshtml", model);
        }

        [Route("Edit_Action")]
        public ActionResult EditAction(PlanYearBsAdmin entity, Search search)
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");

            #region
            Dictionary<string, object> postData = new Dictionary<string, object>();
            postData.Add("Seq", entity.Seq);
            postData.Add("OrgCompanySeq", entity.OrgCompanySeq);
            postData.Add("message", Message.MSG_007_A);
            postData.Add("PageIndex", search.PageIndex);
            #endregion

            // B/Sheet, ROIC, W/Capital, W/Capital등록
            bool bDoubleValue = true;

            var bsSheetList = new List<PlanYearBsBsheet>();
            var bsRoicList = new List<PlanYearBsRoic>();
            var bsWCapitalList = new List<PlanYearBsWCapital>();
            var bsWCapitalRegList = new List<PlanYearBsWCapitalReg>();
            List<PlanYearBsSummary> bsSummaryList = new List<PlanYearBsSummary>();
            try
            {
                //(B/Sheet)
                for (int i = 0; i < entity.planYearBsBsheetSeq.Count(); i++)
                {
                    var yearBsBsheet = new PlanYearBsBsheet();

                    if (!WebUtil.CheckDecimalTwo(entity.Assets[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.CurrentAssets[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.Liabilities[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.CurrentLiabilities[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.Capital[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.Cash[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.Loan[i].ToString())) { bDoubleValue = false; break; }

                    yearBsBsheet.Seq = entity.planYearBsBsheetSeq[i];
                    yearBsBsheet.Assets = entity.Assets[i];
                    yearBsBsheet.CurrentAssets = entity.CurrentAssets[i];
                    yearBsBsheet.Liabilities = entity.Liabilities[i];
                    yearBsBsheet.CurrentLiabilities = entity.CurrentLiabilities[i];
                    yearBsBsheet.Capital = entity.Capital[i];
                    yearBsBsheet.Cash = entity.Cash[i];
                    yearBsBsheet.Loan = entity.Loan[i];
                    yearBsBsheet.LiabilitiesRate = entity.Capital[i] == 0 ? 0 : entity.Liabilities[i] / entity.Capital[i] * 100;
                    yearBsBsheet.CurrentRate = entity.CurrentLiabilities[i] == 0 ? 0 : entity.CurrentAssets[i] / entity.CurrentLiabilities[i] * 100;

                    bsSheetList.Add(yearBsBsheet);
                }

                //(ROIC)
                for (int i = 0; i < entity.PlanYearBsRoicSeq.Count(); i++)
                {
                    if (!WebUtil.CheckDecimalTwo(entity.AfterTaxOperationProfit[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.PainInCapital[i].ToString())) { bDoubleValue = false; break; }
                    //if (!WebUtil.CheckDecimalTwo(entity.Roic[i].ToString())) { bDoubleValue = false; break; }

                    var yearBsRoic = new PlanYearBsRoic();

                    yearBsRoic.Seq = entity.PlanYearBsRoicSeq[i];
                    yearBsRoic.AfterTaxOperationProfit = entity.AfterTaxOperationProfit[i];
                    yearBsRoic.PainInCapital = entity.PainInCapital[i];
                    yearBsRoic.Roic = WebUtil.NumberRound(entity.AfterTaxOperationProfit[i], entity.PainInCapital[i], 100, 2);

                    bsRoicList.Add(yearBsRoic);
                }

                //(W/Capital)
                for (int i = 0; i < entity.PlanYearBsWCapitalSeq.Count(); i++)
                {
                    if (!WebUtil.CheckDecimalTwo(entity.AnnualSales[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.AnnualSalesCost[i].ToString())) { bDoubleValue = false; break; }

                    var planYearBsWCapital = new PlanYearBsWCapital();

                    planYearBsWCapital.Seq = entity.PlanYearBsWCapitalSeq[i];
                    planYearBsWCapital.AnnualSales = entity.AnnualSales[i];
                    planYearBsWCapital.AnnualSalesCost = entity.AnnualSalesCost[i];
                    planYearBsWCapital.InventoryCost = entity.InventoryCost[i];
                    
                    planYearBsWCapital.YearlyYear = entity.BsCapitalYearlyYear[i];

                    bsWCapitalList.Add(planYearBsWCapital);
                }

                //(W/Capital등록)
                for (int i = 0; i < entity.PlanYearBsCapitalRegSeq.Count(); i++)
                {
                    if (!WebUtil.CheckDecimalTwo(entity.Ar[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.ArToDays[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.Ap[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.ApToDays[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.Inventory[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.InventoryToDays[i].ToString())) { bDoubleValue = false; break; }

                    var yearBsWCapitalReg = new PlanYearBsWCapitalReg();

                    PlanYearBsWCapital wCapital = bsWCapitalList.Where(w => w.YearlyYear == entity.BsCapitalRegYearlyYear[i]).FirstOrDefault();

                    yearBsWCapitalReg.Seq = entity.PlanYearBsCapitalRegSeq[i];
                    yearBsWCapitalReg.Ar = entity.Ar[i];
                    yearBsWCapitalReg.ArToDays = WebUtil.NumberRound(entity.Ar[i], wCapital.AnnualSales, 365, 2);
                    yearBsWCapitalReg.Ap = entity.Ap[i];
                    yearBsWCapitalReg.ApToDays = WebUtil.NumberRound(entity.Ap[i], wCapital.AnnualSalesCost, 365, 2);
                    yearBsWCapitalReg.Inventory = entity.Inventory[i];
                    yearBsWCapitalReg.InventoryToDays = WebUtil.NumberRound(entity.Inventory[i], wCapital.InventoryCost, 365, 2);

                    bsWCapitalRegList.Add(yearBsWCapitalReg);
                }

                // 요약
                for (int i = 0; i < entity.PlanYearBsSummarySeq.Count(); i++)
                {
                    if (!WebUtil.CheckDecimalTwo(entity.SummaryAssets[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.SummaryLiabilities[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.SummaryCapital[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.SummaryCash[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.SummaryLoan[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.SummaryLiabilitiesRate[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.SummaryAfterTaxOperationProfit[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.SummaryPainInCapital[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.SummaryRoic[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.SummaryAr[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.SummaryArToDays[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.SummaryAp[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.SummaryApToDays[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.SummaryInventory[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.SummaryInventoryToDays[i].ToString())) { bDoubleValue = false; break; }

                    PlanYearBsSummary bsSummary = new PlanYearBsSummary();
                    bsSummary.Seq = entity.PlanYearBsSummarySeq[i];
                    bsSummary.Assets = entity.SummaryAssets[i];
                    bsSummary.Liabilities = entity.SummaryLiabilities[i];
                    bsSummary.Capital = entity.SummaryCapital[i];
                    bsSummary.Cash = entity.SummaryCash[i];
                    bsSummary.Loan = entity.SummaryLoan[i];
                    bsSummary.LiabilitiesRate = entity.SummaryLiabilitiesRate[i];
                    bsSummary.AfterTaxOperationProfit = entity.SummaryAfterTaxOperationProfit[i];
                    bsSummary.PainInCapital = entity.SummaryPainInCapital[i];
                    bsSummary.Roic = entity.SummaryRoic[i];
                    bsSummary.Ar = entity.SummaryAr[i];
                    bsSummary.ArToDays = entity.SummaryArToDays[i];
                    bsSummary.Ap = entity.SummaryAp[i];
                    bsSummary.ApToDays = entity.SummaryApToDays[i];
                    bsSummary.Inventory = entity.SummaryInventory[i];
                    bsSummary.InventoryToDays = entity.SummaryInventoryToDays[i];

                    bsSummaryList.Add(bsSummary);
                }
            }
            catch (Exception)
            {
                TempData["alert"] = Message.MSG_002_E;
                return RedirectToAction("List");
            }

            if (!bDoubleValue)
            {
                TempData["alert"] = Message.MSG_002_E;
                return RedirectToAction("List");
            }

            // 업데이트
            // B/Sheet
            foreach (var item in bsSheetList)
            {
                planYearBsBsheetRepo.update(item);
            }

            //ROIC
            foreach (var item in bsRoicList)
            {
                planYearBsRoicRepo.update(item);
            }

            //(W/Capital)
            foreach (var item in bsWCapitalList)
            {
                planYearBsWCapitalRepo.update(item);
            }

            //(W/Capital등록)
            foreach (var item in bsWCapitalRegList)
            {
                planYearBsWCapitalRegRepo.update(item);
            }

            foreach (var item in bsSummaryList)
            {
                planYearBsSummaryRepo.update(item);
            }

            // 미저장에서 저장으로 변경
            if (entity.RegistStatus == Define.REGIST_STATUS.GetKey("미등록"))
            {
                entity.RegistStatus = Define.REGIST_STATUS.GetKey("저장");
                PlanYearBs p = new PlanYearBs();
                p.Seq = entity.Seq;
                p.RegistStatus = entity.RegistStatus;
                planYearBsRepo.updateRegist(p);
            }

            return RedirectAndPostActionResult.RedirectAndPost("Edit", postData);
        }

        [Route("View")]
        public ActionResult view(PlanYearBsAdmin entity, Search search)
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");

            // 기본 정보 가져온다.
            var planYearBs = planYearBsRepo.selectOne(entity);
            // 회사 밑에 부서 정보를 가져온다
            var orgBusinessList = orgBusinessRepo.selectListCompany(new { Seq = entity.OrgCompanySeq });

            var orgCompanyName = orgCompanyRepo.selectOne(new { Seq = entity.OrgCompanySeq });

            int thisYear = Convert.ToInt32(planYearBs.YearBsYear);
            int lastYear = thisYear + 5;

            //현재연도
            var nowYear = DateTime.Now.ToString("yyyy");
            //전년도
            var preYear = DateTime.Now.AddYears(-1).ToString("yyyy");

            //(B/Sheet) 전년도 데이터 합 가져오기
            var lastYearSales = planYearBsBsheetRepo.selectListBefore(new { OrgCompanySeq = entity.OrgCompanySeq, YearlyYear = planYearBs.YearBsYear });
            //(B/Sheet) 데이터 가져오기
            var thisYearSales = planYearBsBsheetRepo.selectList(new { PlanYearBsSeq = entity.Seq });

            //(ROIC) 전년도 데이터 합 가져오기
            var lastYearBsRoicList = planYearBsRoicRepo.selectListBefore(new { OrgCompanySeq = entity.OrgCompanySeq, YearlyYear = planYearBs.YearBsYear });
            //(ROIC) 데이터 가져오기
            var thisYearRoicList = planYearBsRoicRepo.selectList(new { PlanYearBsSeq = entity.Seq, YearlyYear = planYearBs.YearBsYear });

            // Wcapital 전년도 데이터 가져오기
            var lastYearBsWcapitalList = planYearBsWCapitalRepo.selectListBefore(new { OrgCompanySeq = entity.OrgCompanySeq, YearlyYear = planYearBs.YearBsYear });
            //(W/Capital) 데이터 가져오기
            var thisYearBsWCapitalList = planYearBsWCapitalRepo.selectList(new { PlanYearBsSeq = entity.Seq, YearlyYear = planYearBs.YearBsYear });

            //(W/Capital)등록 전년도 데이터 합 가져오기
            var lastYearBsWCapital = planYearBsWCapitalRegRepo.selectListBefore(new { OrgCompanySeq = entity.OrgCompanySeq, YearlyYear = planYearBs.YearBsYear });
            //(W/Capital)등록 데이터 가져오기
            var thisYearBsWCapitalRegList = planYearBsWCapitalRegRepo.selectList(new { PlanYearBsSeq = entity.Seq });

            // 전년도 실적 중기요약
            List<PmBsSummaryExp> lastYearSummaryList = pmBsSummaryRepo.selectListBefore(new { PlanYearBsSeq = entity.Seq, YearlyYear = planYearBs.YearBsYear }).Where(w => w.OrgCompanySeq == entity.OrgCompanySeq).ToList();
            //중기재무계획 요약
            var thisYearSummaryList = planYearBsSummaryRepo.selectList(new { PlanYearBsSeq = entity.Seq });

            dynamic model = new ExpandoObject();

            model.planYearBs = planYearBs;
            model.orgCompanyName = orgCompanyName;
            model.orgBusinessList = orgBusinessList;

            //B/Sheet
            model.lastYearSales = lastYearSales;
            model.thisYearSales = thisYearSales;

            //ROIC
            model.lastYearBsRoicList = lastYearBsRoicList;
            model.thisYearRoicList = thisYearRoicList;

            //W/Capital등록
            model.lastYearBsWcapitalList = lastYearBsWcapitalList;
            model.thisYearBsWCapitalList = thisYearBsWCapitalList;

            //W/Capital
            model.lastYearBsWCapital = lastYearBsWCapital;
            model.thisYearBsWCapitalRegList = thisYearBsWCapitalRegList;

            model.lastYearSummaryList = lastYearSummaryList;
            model.thisYearSummaryList = thisYearSummaryList;

            if (entity.message != null)
            {
                TempData["alert"] = entity.message;
            }

            ViewBag.Search = search;
            return View("~/Views/SiteMngHome/Plan/Year_Bs/View.cshtml", model);
        }

        [Route("SalesAccount_Action")]
        public ActionResult SalesAccountAction(PlanYearBsAdmin entity, Search search)
        {
            #region
            Dictionary<string, object> postData = new Dictionary<string, object>();
            postData.Add("Seq", entity.Seq);
            postData.Add("OrgCompanySeq", entity.OrgCompanySeq);
            postData.Add("PageIndex", search.PageIndex);
            #endregion

            // 부서별 데이터 검증(정수 혹은 소수점 2자리까지의 데이터)
            bool bDoubleValue = true;

            // 2018.10.27 매출액 등록할때 BSheet, Roic 값도 저장하도록 변경
            List<PlanYearBsBsheet> pBsheetList = new List<PlanYearBsBsheet>();
            List<PlanYearBsRoic> pRoicList = new List<PlanYearBsRoic>();

            //(W/Capital)
            var planYearBsWCapitalList = new List<PlanYearBsWCapital>();

            // 매출액 계산
            List<PlanYearBsWCapitalReg> pWcapitalRegList = new List<PlanYearBsWCapitalReg>();

            try
            {
                for (int i = 0; i < entity.planYearBsBsheetSeq.Count(); i++)
                {
                    if (!WebUtil.CheckDecimalTwo(entity.Assets[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.CurrentAssets[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.Liabilities[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.CurrentLiabilities[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.Capital[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.Cash[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.Loan[i].ToString())) { bDoubleValue = false; break; }

                    PlanYearBsBsheet p = new PlanYearBsBsheet();
                    p.Seq = entity.planYearBsBsheetSeq[i];
                    p.Assets = entity.Assets[i];
                    p.CurrentAssets = entity.CurrentAssets[i];
                    p.Liabilities = entity.Liabilities[i];
                    p.CurrentLiabilities = entity.CurrentLiabilities[i];
                    p.Capital = entity.Capital[i];
                    p.Cash = entity.Cash[i];
                    p.Loan = entity.Loan[i];

                    pBsheetList.Add(p);
                }

                for (int i = 0; i < entity.PlanYearBsRoicSeq.Count(); i++)
                {
                    if (!WebUtil.CheckDecimalTwo(entity.AfterTaxOperationProfit[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.PainInCapital[i].ToString())) { bDoubleValue = false; break; }

                    PlanYearBsRoic p = new PlanYearBsRoic();
                    p.Seq = entity.PlanYearBsRoicSeq[i];
                    p.AfterTaxOperationProfit = entity.AfterTaxOperationProfit[i];
                    p.PainInCapital = entity.PainInCapital[i];

                    pRoicList.Add(p);
                }

                for (int i = 0; i < entity.PlanYearBsWCapitalSeq.Count(); i++)
                {
                    if (!WebUtil.CheckDecimalTwo(entity.AnnualSales[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.AnnualSalesCost[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.InventoryCost[i].ToString())) { bDoubleValue = false; break; }
                    
                    var planYearBsWCapital = new PlanYearBsWCapital();

                    planYearBsWCapital.Seq = entity.PlanYearBsWCapitalSeq[i];
                    planYearBsWCapital.YearlyYear = entity.BsCapitalYearlyYear[i];
                    planYearBsWCapital.Monthly = entity.BsCapitalYearlyMonth[i];
                    planYearBsWCapital.AnnualSales = entity.AnnualSales[i];
                    planYearBsWCapital.AnnualSalesCost = entity.AnnualSalesCost[i];
                    planYearBsWCapital.InventoryCost = entity.InventoryCost[i];

                    planYearBsWCapitalList.Add(planYearBsWCapital);
                }

                for (int i = 0; i < entity.PlanYearBsCapitalRegSeq.Count(); i++)
                {
                    PlanYearBsWCapitalReg p = new PlanYearBsWCapitalReg();
                    p.Seq = entity.PlanYearBsCapitalRegSeq[i];
                    p.Ar = entity.Ar[i];
                    p.Ap = entity.Ap[i];
                    p.Inventory = entity.Inventory[i];
                    p.YearlyYear = entity.BsCapitalRegYearlyYear[i];
                    p.Monthly = entity.BsCapitalRegYearlyMonth[i];

                    pWcapitalRegList.Add(p);
                }
            }
            catch (Exception)
            {
                TempData["alert"] = Message.MSG_002_E;
                return RedirectToAction("List");
            }

            if (!bDoubleValue)
            {
                TempData["alert"] = Message.MSG_002_E;
                return RedirectToAction("List");
            }

            foreach (var item in pBsheetList)
            {
                item.LiabilitiesRate = item.Capital == 0 ? 0 : item.Liabilities / item.Capital * 100;
                item.CurrentRate = item.CurrentLiabilities == 0 ? 0 : item.CurrentAssets / item.CurrentLiabilities * 100;
                planYearBsBsheetRepo.update(item);
            }

            foreach (var item in pRoicList)
            {
                item.Roic = item.PainInCapital == 0 ? 0 : item.AfterTaxOperationProfit / item.PainInCapital;
                planYearBsRoicRepo.update(item);
            }

            foreach (var item in planYearBsWCapitalList)
            {
                var planYearBsWCapital = new PlanYearBsWCapital();

                planYearBsWCapital.Seq = item.Seq;
                planYearBsWCapital.AnnualSales = item.AnnualSales;
                planYearBsWCapital.AnnualSalesCost = item.AnnualSalesCost;
                planYearBsWCapital.InventoryCost = item.InventoryCost;
                
                planYearBsWCapitalRepo.update(planYearBsWCapital);
            }

            foreach (var item in pWcapitalRegList)
            {
                PlanYearBsWCapital wCapital = planYearBsWCapitalList.Where(w => w.YearlyYear == item.YearlyYear).Where(w => w.Monthly == item.Monthly).FirstOrDefault();

                item.ArToDays = wCapital.AnnualSales == 0 ? 0 : item.Ar / wCapital.AnnualSales * 365;
                item.ApToDays = wCapital.AnnualSalesCost == 0 ? 0 : item.Ap / wCapital.AnnualSalesCost * 365;
                item.InventoryToDays = wCapital.InventoryCost == 0 ? 0 : item.Inventory / wCapital.InventoryCost * 365;
                planYearBsWCapitalRegRepo.update(item);
            }

            return RedirectAndPostActionResult.RedirectAndPost("Write", postData);
        }

        [Route("Calculation_Action")]
        public ActionResult CalculationAction(PlanYearBsAdmin entity, Search search)
        {
            #region
            Dictionary<string, object> postData = new Dictionary<string, object>();
            postData.Add("Seq", entity.Seq);
            postData.Add("OrgCompanySeq", entity.OrgCompanySeq);
            postData.Add("PageIndex", search.PageIndex);
            #endregion

            // 기본 정보 가져온다.
            var planYearBs = planYearBsRepo.selectOne(entity);
            ////(W/Capital) 데이터 가져오기
            //var thisYearBsWCapitalList = planYearBsWCapitalRepo.selectList(new { PlanYearBsSeq = entity.Seq, YearlyYear = planYearBs.YearBsYear });
            // 부서별 데이터 검증(정수 혹은 소수점 2자리까지의 데이터)
            bool bDoubleValue = true;
            //(B/Sheet)
            var planYearBsBsheetList = new List<PlanYearBsBsheet>();
            //(ROIC)
            var planYearBsRoicList = new List<PlanYearBsRoic>();
            // Wcapital 왜 없나요. 계산하기 눌렀을때 이전값과 다르면 수정해야하는데 ㅠ
            List<PlanYearBsWCapital> pWcapitalList = new List<PlanYearBsWCapital>();

            //(W/Capital등록)
            var planYearBsWCapitalRegList = new List<PlanYearBsWCapitalReg>();
            //중기재무계획 요약
            var planYearBsSummaryList = new List<PlanYearBsSummary>();

            try
            {
                //(B/Sheet)
                for (int i = 0; i < entity.planYearBsBsheetSeq.Count(); i++)
                {
                    var yearBsBsheet = new PlanYearBsBsheet();
                    
                    if (!WebUtil.CheckDecimalTwo(entity.Assets[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.CurrentAssets[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.Liabilities[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.CurrentLiabilities[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.Capital[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.Cash[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.Loan[i].ToString())) { bDoubleValue = false; break; }

                    yearBsBsheet.Seq = entity.planYearBsBsheetSeq[i];
                    yearBsBsheet.Assets = entity.Assets[i];
                    yearBsBsheet.CurrentAssets = entity.CurrentAssets[i];
                    yearBsBsheet.Liabilities = entity.Liabilities[i];
                    yearBsBsheet.CurrentLiabilities = entity.CurrentLiabilities[i];
                    yearBsBsheet.Capital = entity.Capital[i];
                    yearBsBsheet.Cash = entity.Cash[i];
                    yearBsBsheet.Loan = entity.Loan[i];
                    yearBsBsheet.LiabilitiesRate = entity.LiabilitiesRate[i];
                    yearBsBsheet.CurrentRate = entity.CurrentRate[i];

                    planYearBsBsheetList.Add(yearBsBsheet);
                }

                //(ROIC)
                for (int i = 0; i < entity.PlanYearBsRoicSeq.Count(); i++)
                {
                    if (!WebUtil.CheckDecimalTwo(entity.AfterTaxOperationProfit[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.PainInCapital[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.Roic[i].ToString())) { bDoubleValue = false; break; }

                    var yearBsRoic = new PlanYearBsRoic();

                    yearBsRoic.Seq = entity.PlanYearBsRoicSeq[i];
                    yearBsRoic.AfterTaxOperationProfit = entity.AfterTaxOperationProfit[i];
                    yearBsRoic.PainInCapital = entity.PainInCapital[i];
                    yearBsRoic.Roic = entity.Roic[i];

                    planYearBsRoicList.Add(yearBsRoic);
                }


                for (int i = 0; i < entity.PlanYearBsWCapitalSeq.Count(); i++)
                {
                    if (!WebUtil.CheckDecimalTwo(entity.AnnualSales[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.AnnualSalesCost[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.InventoryCost[i].ToString())) { bDoubleValue = false; break; }
                    
                    var planYearBsWCapital = new PlanYearBsWCapital();

                    planYearBsWCapital.Seq = entity.PlanYearBsWCapitalSeq[i];
                    planYearBsWCapital.YearlyYear = entity.BsCapitalYearlyYear[i];
                    planYearBsWCapital.Monthly = entity.BsCapitalYearlyMonth[i];
                    planYearBsWCapital.AnnualSales = entity.AnnualSales[i];
                    planYearBsWCapital.AnnualSalesCost = entity.AnnualSalesCost[i];
                    planYearBsWCapital.InventoryCost = entity.InventoryCost[i];
                    
                    pWcapitalList.Add(planYearBsWCapital);
                }

                for (int i = 0; i < entity.PlanYearBsCapitalRegSeq.Count(); i++)
                {
                    if (!WebUtil.CheckDecimalTwo(entity.Ar[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.Ap[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.Inventory[i].ToString())) { bDoubleValue = false; break; }

                    PlanYearBsWCapitalReg p = new PlanYearBsWCapitalReg();
                    p.Seq = entity.PlanYearBsCapitalRegSeq[i];
                    p.Ar = entity.Ar[i];
                    p.Ap = entity.Ap[i];
                    p.Inventory = entity.Inventory[i];
                    p.YearlyYear = entity.BsCapitalRegYearlyYear[i];
                    p.Monthly = entity.BsCapitalRegYearlyMonth[i];

                    planYearBsWCapitalRegList.Add(p);
                }

                ////(W/Capital)
                //for (int i = 0; i < entity.PlanYearBsCapitalRegSeq.Count(); i++)
                //{
                //    if (!WebUtil.CheckDecimalTwo(entity.Ar[i].ToString())) { bDoubleValue = false; break; }
                //    if (!WebUtil.CheckDecimalTwo(entity.ArToDays[i].ToString())) { bDoubleValue = false; break; }
                //    if (!WebUtil.CheckDecimalTwo(entity.Ap[i].ToString())) { bDoubleValue = false; break; }
                //    if (!WebUtil.CheckDecimalTwo(entity.ApToDays[i].ToString())) { bDoubleValue = false; break; }
                //    if (!WebUtil.CheckDecimalTwo(entity.Inventory[i].ToString())) { bDoubleValue = false; break; }
                //    if (!WebUtil.CheckDecimalTwo(entity.InventoryToDays[i].ToString())) { bDoubleValue = false; break; }

                //    foreach (var item in pWcapitalList)
                //    {
                //        if (entity.YearBsYear == item.YearlyYear)
                //        {
                //            var yearBsWCapitalReg = new PlanYearBsWCapitalReg();

                //            yearBsWCapitalReg.Seq = entity.PlanYearBsCapitalRegSeq[i];
                //            yearBsWCapitalReg.Ar = entity.Ar[i];
                //            yearBsWCapitalReg.ArToDays = WebUtil.NumberRound(entity.Ar[i] / item.AnnualSales * 365, 0);
                //            yearBsWCapitalReg.Ap = entity.Ap[i];
                //            yearBsWCapitalReg.ApToDays = WebUtil.NumberRound(entity.Ap[i] / item.AnnualSalesCost * 365, 0);
                //            yearBsWCapitalReg.Inventory = entity.Inventory[i];
                //            yearBsWCapitalReg.InventoryToDays = WebUtil.NumberRound(entity.Inventory[i] / item.AnnualSalesCost * 365, 0);

                //            planYearBsWCapitalRegList.Add(yearBsWCapitalReg);
                //        }
                //    }
                //}
            }
            catch (Exception)
            {
                TempData["alert"] = Message.MSG_002_E;
                return RedirectToAction("List");
            }

            if (!bDoubleValue)
            {
                TempData["alert"] = Message.MSG_002_E;
                return RedirectToAction("List");
            }
            else
            {
                TempData["alert"] = Message.MSG_002_A;
            }

            // 2018.10.28 수정해야한다.........................
            //B/Sheet 업데이트
            foreach (var item in planYearBsBsheetList)
            {
                var yearBsBsheet = new PlanYearBsBsheet();

                yearBsBsheet.Seq = item.Seq;
                yearBsBsheet.Assets = item.Assets;
                yearBsBsheet.CurrentAssets = item.CurrentAssets;
                yearBsBsheet.Liabilities = item.Liabilities;
                yearBsBsheet.CurrentLiabilities = item.CurrentLiabilities;
                yearBsBsheet.Capital = item.Capital;
                yearBsBsheet.Cash = item.Cash;
                yearBsBsheet.Loan = item.Loan;
                yearBsBsheet.LiabilitiesRate = item.Capital == 0 ? 0 : item.Liabilities / item.Capital * 100;
                yearBsBsheet.CurrentRate = item.CurrentLiabilities == 0 ? 0 : item.CurrentAssets / item.CurrentLiabilities * 100;

                planYearBsBsheetRepo.update(yearBsBsheet);
            }

            //ROIC 업데이트
            foreach (var item in planYearBsRoicList)
            {
                var yearBsRoic = new PlanYearBsRoic();

                yearBsRoic.Seq = item.Seq;
                yearBsRoic.AfterTaxOperationProfit = item.AfterTaxOperationProfit;
                yearBsRoic.PainInCapital = item.PainInCapital;
                yearBsRoic.Roic = item.PainInCapital == 0 ? 0 : item.AfterTaxOperationProfit / item.PainInCapital;

                planYearBsRoicRepo.update(yearBsRoic);
            }


            foreach (var item in pWcapitalList)
            {
                var planYearBsWCapital = new PlanYearBsWCapital();

                planYearBsWCapital.Seq = item.Seq;
                planYearBsWCapital.AnnualSales = item.AnnualSales;
                planYearBsWCapital.AnnualSalesCost = item.AnnualSalesCost;
                planYearBsWCapital.InventoryCost = item.InventoryCost;
                
                planYearBsWCapitalRepo.update(planYearBsWCapital);
            }

            foreach (var item in planYearBsWCapitalRegList)
            {
                PlanYearBsWCapital wCapital = pWcapitalList.Where(w => w.YearlyYear == item.YearlyYear).Where(w => w.Monthly == item.Monthly).FirstOrDefault();

                item.ArToDays = wCapital.AnnualSales == 0 ? 0 : item.Ar / wCapital.AnnualSales * 365;
                item.ApToDays = wCapital.AnnualSalesCost == 0 ? 0 : item.Ap / wCapital.AnnualSalesCost * 365;
                item.InventoryToDays = wCapital.InventoryCost == 0 ? 0 : item.Inventory / wCapital.InventoryCost * 365;
                planYearBsWCapitalRegRepo.update(item);
            }

            ////(W/Bsheet) 업데이트
            //foreach (var item in planYearBsWCapitalRegList)
            //{
            //    var yearBsWCapitalReg = new PlanYearBsWCapitalReg();

            //    yearBsWCapitalReg.Seq = item.Seq;
            //    yearBsWCapitalReg.Ar = item.Ar;
            //    yearBsWCapitalReg.ArToDays = item.ArToDays;
            //    yearBsWCapitalReg.Ap = item.Ap;
            //    yearBsWCapitalReg.ApToDays = item.ApToDays;
            //    yearBsWCapitalReg.Inventory = item.Inventory;
            //    yearBsWCapitalReg.InventoryToDays = item.InventoryToDays;

            //    planYearBsWCapitalRegRepo.update(yearBsWCapitalReg);
            //}

            // 2018.10.28 중기요약 입력한다.
            // 기존 요약 삭제하고 새로운 요약을 넣는다.
            planYearBsSummaryRepo.delete(new { PlanYearBsSeq = entity.Seq });
            PlanYearBsSummary pSummary = new PlanYearBsSummary();
            pSummary.PlanYearBsSeq = entity.Seq;
            planYearBsSummaryRepo.insertCum(pSummary);

            // 2018.10.29 수정화면에서 저장한 뒤에 저장상태로 변경
            //// 미저장에서 저장으로 변경
            //if (entity.RegistStatus == Define.REGIST_STATUS.GetKey("미등록"))
            //{
            //    entity.RegistStatus = Define.REGIST_STATUS.GetKey("저장");
            //    PlanYearBs p = new PlanYearBs();
            //    p.Seq = entity.Seq;
            //    p.RegistStatus = entity.RegistStatus;
            //    planYearBsRepo.updateRegist(p);
            //}

            return RedirectAndPostActionResult.RedirectAndPost("Edit", postData);
        }

        [Route("Regist_Status_Change")]
        public ActionResult RegistStatusChange(PlanYearBs entity, Search search)
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");

            #region
            Dictionary<string, object> postData = new Dictionary<string, object>();
            postData.Add("Seq", entity.Seq);
            postData.Add("OrgCompanySeq", entity.OrgCompanySeq);
            postData.Add("message", entity.message);
            #endregion

            // 현재 상태값을 변경한다.
            entity.RegistStatus = entity.afterRegistStatus;
            planYearBsRepo.updateRegist(entity);

            return RedirectToAction("List", search);
        }

        [Route("Excel_Down")]
        public ActionResult ExcelDown(PlanYearBs entity)
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");

            var planYearBs = planYearBsRepo.selectOne(entity);
            var orgCompanyName = orgCompanyRepo.selectOne(new { Seq = entity.OrgCompanySeq });
            
            var planSales = planYearBsBsheetRepo.selectList(new { PlanYearBsSeq = entity.Seq });
            var planRoic = planYearBsRoicRepo.selectList(new { PlanYearBsSeq = entity.Seq, YearlyYear = planYearBs.YearBsYear });
            var planBsWCapitalList = planYearBsWCapitalRepo.selectList(new { PlanYearBsSeq = entity.Seq, YearlyYear = planYearBs.YearBsYear });
            var planBsWCapitalReg = planYearBsWCapitalRegRepo.selectList(new { PlanYearBsSeq = entity.Seq });

            string fileName = "중기BS_" + planYearBs.YearBsYear + "년_" + orgCompanyName.CompanyName;

            int rows = 1, cells = 1;

            using (XLWorkbook wb = new XLWorkbook())
            {
                var wsSales = wb.Worksheets.Add("BSheet");

                // 컬럼 숨기기
                wsSales.Column(1).Hide();
                wsSales.Column(2).Hide();

                wsSales.Cell(rows, cells).SetValue("ParentSeq").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsSales.Cell(rows, ++cells).SetValue("Seq").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsSales.Cell(rows, ++cells).SetValue("년도").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsSales.Cell(rows, ++cells).SetValue("월").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsSales.Cell(rows, ++cells).SetValue("총자산").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsSales.Cell(rows, ++cells).SetValue("유동자산").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsSales.Cell(rows, ++cells).SetValue("총부채").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsSales.Cell(rows, ++cells).SetValue("유동부채").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsSales.Cell(rows, ++cells).SetValue("총자본").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsSales.Cell(rows, ++cells).SetValue("현금").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsSales.Cell(rows, ++cells).SetValue("차입금").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                //wsSales.Cell(rows, ++cells).SetValue("부채비율").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                //wsSales.Cell(rows, ++cells).SetValue("유동비율").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                foreach (var item in planSales)
                {
                    rows++;
                    cells = 1;
                    wsSales.Cell(rows, cells).SetValue(item.PlanYearBsSeq).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsSales.Cell(rows, ++cells).SetValue(item.Seq).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsSales.Cell(rows, ++cells).SetValue(item.YearlyYear).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsSales.Cell(rows, ++cells).SetValue(item.Monthly).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsSales.Cell(rows, ++cells).SetValue(item.Assets).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsSales.Cell(rows, ++cells).SetValue(item.CurrentAssets).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsSales.Cell(rows, ++cells).SetValue(item.Liabilities).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsSales.Cell(rows, ++cells).SetValue(item.CurrentLiabilities).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsSales.Cell(rows, ++cells).SetValue(item.Capital).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsSales.Cell(rows, ++cells).SetValue(item.Cash).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsSales.Cell(rows, ++cells).SetValue(item.Loan).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    //wsSales.Cell(rows, ++cells).SetValue(item.LiabilitiesRate).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    //wsSales.Cell(rows, ++cells).SetValue(item.CurrentRate).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                }

                rows = 1;
                cells = 1;
                var wsRoic = wb.Worksheets.Add("ROIC");

                // 컬럼 숨기기
                wsRoic.Column(1).Hide();
                wsRoic.Column(2).Hide();

                wsRoic.Cell(rows, cells).SetValue("ParentSeq").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsRoic.Cell(rows, ++cells).SetValue("Seq").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsRoic.Cell(rows, ++cells).SetValue("년도").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsRoic.Cell(rows, ++cells).SetValue("월").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsRoic.Cell(rows, ++cells).SetValue("세후영업이익").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsRoic.Cell(rows, ++cells).SetValue("투하자본").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                //wsRoic.Cell(rows, ++cells).SetValue("ROIC").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                foreach (var item in planRoic)
                {
                    rows++;
                    cells = 1;
                    wsRoic.Cell(rows, cells).SetValue(item.PlanYearBsSeq).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsRoic.Cell(rows, ++cells).SetValue(item.Seq).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsRoic.Cell(rows, ++cells).SetValue(item.YearlyYear).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsRoic.Cell(rows, ++cells).SetValue(item.Monthly).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsRoic.Cell(rows, ++cells).SetValue(item.AfterTaxOperationProfit).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsRoic.Cell(rows, ++cells).SetValue(item.PainInCapital).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    //wsRoic.Cell(rows, ++cells).SetValue(item.Roic).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                }

                rows = 1;
                cells = 1;
                var wsWcapital = wb.Worksheets.Add("W_Capital");

                // 컬럼 숨기기
                wsWcapital.Column(1).Hide();
                wsWcapital.Column(2).Hide();

                wsWcapital.Cell(rows, cells).SetValue("ParentSeq").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsWcapital.Cell(rows, ++cells).SetValue("Seq").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsWcapital.Cell(rows, ++cells).SetValue("년도").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsWcapital.Cell(rows, ++cells).SetValue("월").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsWcapital.Cell(rows, ++cells).SetValue("연간매출액").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsWcapital.Cell(rows, ++cells).SetValue("연간매출원가(AP)").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsWcapital.Cell(rows, ++cells).SetValue("연간매출원가(Inv)").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                foreach (var item in planBsWCapitalList)
                {
                    rows++;
                    cells = 1;
                    wsWcapital.Cell(rows, cells).SetValue(item.PlanYearBsSeq).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsWcapital.Cell(rows, ++cells).SetValue(item.Seq).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsWcapital.Cell(rows, ++cells).SetValue(item.YearlyYear).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsWcapital.Cell(rows, ++cells).SetValue(item.Monthly).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    //wsWcapital.Cell(rows, ++cells).SetValue((item.Monthly == "99" ? "" : item.Monthly)).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsWcapital.Cell(rows, ++cells).SetValue(item.AnnualSales).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsWcapital.Cell(rows, ++cells).SetValue(item.AnnualSalesCost).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsWcapital.Cell(rows, ++cells).SetValue(item.InventoryCost).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    
                }

                rows = 1;
                cells = 1;
                var wsWcapitalReg = wb.Worksheets.Add("W_Capital_Reg");

                // 컬럼 숨기기
                wsWcapitalReg.Column(1).Hide();
                wsWcapitalReg.Column(2).Hide();

                wsWcapitalReg.Cell(rows, cells).SetValue("ParentSeq").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsWcapitalReg.Cell(rows, ++cells).SetValue("Seq").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsWcapitalReg.Cell(rows, ++cells).SetValue("년도").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsWcapitalReg.Cell(rows, ++cells).SetValue("월").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsWcapitalReg.Cell(rows, ++cells).SetValue("Ar").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                //wsWcapitalReg.Cell(rows, ++cells).SetValue("ArToDays").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsWcapitalReg.Cell(rows, ++cells).SetValue("Ap").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                //wsWcapitalReg.Cell(rows, ++cells).SetValue("ApToDays").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsWcapitalReg.Cell(rows, ++cells).SetValue("Inventory").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                //wsWcapitalReg.Cell(rows, ++cells).SetValue("InventoryToDays").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                foreach (var item in planBsWCapitalReg)
                {
                    rows++;
                    cells = 1;
                    wsWcapitalReg.Cell(rows, cells).SetValue(item.PlanYearBsSeq).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsWcapitalReg.Cell(rows, ++cells).SetValue(item.Seq).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsWcapitalReg.Cell(rows, ++cells).SetValue(item.YearlyYear).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsWcapitalReg.Cell(rows, ++cells).SetValue(item.Monthly).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsWcapitalReg.Cell(rows, ++cells).SetValue(item.Ar).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    //wsWcapitalReg.Cell(rows, ++cells).SetValue(item.ArToDays).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsWcapitalReg.Cell(rows, ++cells).SetValue(item.Ap).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    //wsWcapitalReg.Cell(rows, ++cells).SetValue(item.ApToDays).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsWcapitalReg.Cell(rows, ++cells).SetValue(item.Inventory).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    //wsWcapitalReg.Cell(rows, ++cells).SetValue(item.InventoryToDays).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                }

                using (MemoryStream mStream = new MemoryStream())
                {
                    wb.SaveAs(mStream);
                    return File(mStream.ToArray(), "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", fileName + ".xlsx");
                }
            }

            //return View();
        }



        [Route("Excel_Down2")]
        public ActionResult ExcelDown2(PlanYearBs entity)
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");

            var planYearBs = planYearBsRepo.selectOne(entity);
            var orgCompanyName = orgCompanyRepo.selectOne(new { Seq = entity.OrgCompanySeq });

            var planSales = planYearBsBsheetRepo.selectList(new { PlanYearBsSeq = entity.Seq });
            var planRoic = planYearBsRoicRepo.selectList(new { PlanYearBsSeq = entity.Seq, YearlyYear = planYearBs.YearBsYear });
            var planBsWCapitalList = planYearBsWCapitalRepo.selectList(new { PlanYearBsSeq = entity.Seq, YearlyYear = planYearBs.YearBsYear });
            var planBsWCapitalReg = planYearBsWCapitalRegRepo.selectList(new { PlanYearBsSeq = entity.Seq });

            string fileName = "중기BS_" + planYearBs.YearBsYear + "년_" + orgCompanyName.CompanyName;

            int rows = 1, cells = 1;

            using (XLWorkbook wb = new XLWorkbook())
            {
                var wsSales = wb.Worksheets.Add("BSheet");

                // 컬럼 숨기기
              //  wsSales.Column(1).Hide();
               // wsSales.Column(2).Hide();

               // wsSales.Cell(rows, cells).SetValue("ParentSeq").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
               // wsSales.Cell(rows, ++cells).SetValue("Seq").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsSales.Cell(rows, cells).SetValue("년도").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsSales.Cell(rows, ++cells).SetValue("월").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsSales.Cell(rows, ++cells).SetValue("총자산").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsSales.Cell(rows, ++cells).SetValue("유동자산").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsSales.Cell(rows, ++cells).SetValue("총부채").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsSales.Cell(rows, ++cells).SetValue("유동부채").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsSales.Cell(rows, ++cells).SetValue("총자본").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsSales.Cell(rows, ++cells).SetValue("현금").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsSales.Cell(rows, ++cells).SetValue("차입금").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                //wsSales.Cell(rows, ++cells).SetValue("부채비율").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                //wsSales.Cell(rows, ++cells).SetValue("유동비율").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                foreach (var item in planSales)
                {
                    rows++;
                    cells = 1;
                   // wsSales.Cell(rows, cells).SetValue(item.PlanYearBsSeq).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                   // wsSales.Cell(rows, ++cells).SetValue(item.Seq).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsSales.Cell(rows, cells).SetValue(item.YearlyYear).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsSales.Cell(rows, ++cells).SetValue(item.Monthly).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsSales.Cell(rows, ++cells).SetValue(item.Assets).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsSales.Cell(rows, ++cells).SetValue(item.CurrentAssets).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsSales.Cell(rows, ++cells).SetValue(item.Liabilities).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsSales.Cell(rows, ++cells).SetValue(item.CurrentLiabilities).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsSales.Cell(rows, ++cells).SetValue(item.Capital).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsSales.Cell(rows, ++cells).SetValue(item.Cash).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsSales.Cell(rows, ++cells).SetValue(item.Loan).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    //wsSales.Cell(rows, ++cells).SetValue(item.LiabilitiesRate).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    //wsSales.Cell(rows, ++cells).SetValue(item.CurrentRate).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                }

                rows = 1;
                cells = 1;
                var wsRoic = wb.Worksheets.Add("ROIC");

                // 컬럼 숨기기
               // wsRoic.Column(1).Hide();
                //wsRoic.Column(2).Hide();

               // wsRoic.Cell(rows, cells).SetValue("ParentSeq").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                //wsRoic.Cell(rows, ++cells).SetValue("Seq").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsRoic.Cell(rows, cells).SetValue("년도").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsRoic.Cell(rows, ++cells).SetValue("월").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsRoic.Cell(rows, ++cells).SetValue("세후영업이익").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsRoic.Cell(rows, ++cells).SetValue("투하자본").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                //wsRoic.Cell(rows, ++cells).SetValue("ROIC").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                foreach (var item in planRoic)
                {
                    rows++;
                    cells = 1;
                   // wsRoic.Cell(rows, cells).SetValue(item.PlanYearBsSeq).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                   // wsRoic.Cell(rows, ++cells).SetValue(item.Seq).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsRoic.Cell(rows, cells).SetValue(item.YearlyYear).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsRoic.Cell(rows, ++cells).SetValue(item.Monthly).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsRoic.Cell(rows, ++cells).SetValue(item.AfterTaxOperationProfit).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsRoic.Cell(rows, ++cells).SetValue(item.PainInCapital).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    //wsRoic.Cell(rows, ++cells).SetValue(item.Roic).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                }

                rows = 1;
                cells = 1;
                var wsWcapital = wb.Worksheets.Add("W_Capital");

                // 컬럼 숨기기
                //wsWcapital.Column(1).Hide();
                //wsWcapital.Column(2).Hide();

               // wsWcapital.Cell(rows, cells).SetValue("ParentSeq").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
               // wsWcapital.Cell(rows, ++cells).SetValue("Seq").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsWcapital.Cell(rows, cells).SetValue("년도").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsWcapital.Cell(rows, ++cells).SetValue("월").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsWcapital.Cell(rows, ++cells).SetValue("연간매출액").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsWcapital.Cell(rows, ++cells).SetValue("연간매출원가(AP)").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsWcapital.Cell(rows, ++cells).SetValue("연간매출원가(Inv)").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                foreach (var item in planBsWCapitalList)
                {
                    rows++;
                    cells = 1;
                    //wsWcapital.Cell(rows, cells).SetValue(item.PlanYearBsSeq).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    //wsWcapital.Cell(rows, ++cells).SetValue(item.Seq).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsWcapital.Cell(rows, cells).SetValue(item.YearlyYear).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsWcapital.Cell(rows, ++cells).SetValue(item.Monthly).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    //wsWcapital.Cell(rows, ++cells).SetValue((item.Monthly == "99" ? "" : item.Monthly)).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsWcapital.Cell(rows, ++cells).SetValue(item.AnnualSales).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsWcapital.Cell(rows, ++cells).SetValue(item.AnnualSalesCost).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsWcapital.Cell(rows, ++cells).SetValue(item.InventoryCost).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                }

                rows = 1;
                cells = 1;
                var wsWcapitalReg = wb.Worksheets.Add("W_Capital_Reg");

                // 컬럼 숨기기
                //wsWcapitalReg.Column(1).Hide();
                //wsWcapitalReg.Column(2).Hide();

               // wsWcapitalReg.Cell(rows, cells).SetValue("ParentSeq").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
               // wsWcapitalReg.Cell(rows, ++cells).SetValue("Seq").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsWcapitalReg.Cell(rows, cells).SetValue("년도").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsWcapitalReg.Cell(rows, ++cells).SetValue("월").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsWcapitalReg.Cell(rows, ++cells).SetValue("Ar").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                //wsWcapitalReg.Cell(rows, ++cells).SetValue("ArToDays").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsWcapitalReg.Cell(rows, ++cells).SetValue("Ap").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                //wsWcapitalReg.Cell(rows, ++cells).SetValue("ApToDays").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsWcapitalReg.Cell(rows, ++cells).SetValue("Inventory").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                //wsWcapitalReg.Cell(rows, ++cells).SetValue("InventoryToDays").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                foreach (var item in planBsWCapitalReg)
                {
                    rows++;
                    cells = 1;
                    //wsWcapitalReg.Cell(rows, cells).SetValue(item.PlanYearBsSeq).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    //wsWcapitalReg.Cell(rows, ++cells).SetValue(item.Seq).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsWcapitalReg.Cell(rows, cells).SetValue(item.YearlyYear).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsWcapitalReg.Cell(rows, ++cells).SetValue(item.Monthly).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsWcapitalReg.Cell(rows, ++cells).SetValue(item.Ar).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    //wsWcapitalReg.Cell(rows, ++cells).SetValue(item.ArToDays).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsWcapitalReg.Cell(rows, ++cells).SetValue(item.Ap).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    //wsWcapitalReg.Cell(rows, ++cells).SetValue(item.ApToDays).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsWcapitalReg.Cell(rows, ++cells).SetValue(item.Inventory).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    //wsWcapitalReg.Cell(rows, ++cells).SetValue(item.InventoryToDays).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                }

                using (MemoryStream mStream = new MemoryStream())
                {
                    wb.SaveAs(mStream);
                    return File(mStream.ToArray(), "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", fileName + ".xlsx");
                }
            }

            //return View();
        }

        [Route("Excel_Upload")]
        public ActionResult ExcelUpload(int Seq, int OrgCompanySeq, HttpPostedFileBase ExcelFile)
        {
            // 엑셀파일 검증 후
            // 문제가 없다면 엑셀 파일 데이터에 입력
            // 저장 완료되면 엑셀 로그에 데이터 남기고 해당 파일 저장
            // 문제가 있으면 삭제

            bool result = false;
            string resultMsg = "";

            if (ExcelFile.ContentLength != 0)
            {
                FileUtil fileUtil = new FileUtil(Define.FILE_PATH);
                string filePath = "PlanYearBs";
                var file = fileUtil.FileUpload(ExcelFile, filePath);

                bool bDoubleValue = true;
                ExcelUtil excelUtil = new ExcelUtil();
                var ds = excelUtil.ImportExcelDs(file["FILE_PATH"]);

                var pSalesList = new List<PlanYearBsBsheet>();
                var planRoic = new List<PlanYearBsRoic>();
                var pBsWCapital= new List<PlanYearBsWCapital>();
                var pBsWCapitalReg = new List<PlanYearBsWCapitalReg>();

                try
                {
                    // 다운받은 sheet 이름으로 체크 한다.
                    if (ds.Tables["BSheet"] == null || ds.Tables["BSheet"].Rows.Count == 0)
                    {
                        fileUtil.FileDelete(filePath, file["STORED_FILE_NAME"]);
                        result = false;
                        resultMsg = Message.MSG_007_E;
                        return Json(new { success = result, resultMsg = resultMsg }, JsonRequestBehavior.AllowGet);
                    }
                    if (ds.Tables["ROIC"] == null || ds.Tables["ROIC"].Rows.Count == 0)
                    {
                        fileUtil.FileDelete(filePath, file["STORED_FILE_NAME"]);
                        result = false;
                        resultMsg = Message.MSG_007_E;
                        return Json(new { success = result, resultMsg = resultMsg }, JsonRequestBehavior.AllowGet);
                    }
                    if (ds.Tables["W_Capital"] == null || ds.Tables["W_Capital"].Rows.Count == 0)
                    {
                        fileUtil.FileDelete(filePath, file["STORED_FILE_NAME"]);
                        result = false;
                        resultMsg = Message.MSG_007_E;
                        return Json(new { success = result, resultMsg = resultMsg }, JsonRequestBehavior.AllowGet);
                    }
                    if (ds.Tables["W_Capital_Reg"] == null || ds.Tables["W_Capital_Reg"].Rows.Count == 0)
                    {
                        fileUtil.FileDelete(filePath, file["STORED_FILE_NAME"]);
                        result = false;
                        resultMsg = Message.MSG_007_E;
                        return Json(new { success = result, resultMsg = resultMsg }, JsonRequestBehavior.AllowGet);
                    }

                    foreach (DataRow item in ds.Tables["BSheet"].Rows)
                    {
                        string parentSeq = item.ItemArray.GetValue(0).ToString();
                        string excelSeq = item.ItemArray.GetValue(1).ToString();
                        string yearlyYear = item.ItemArray.GetValue(2).ToString();
                        string monthly = item.ItemArray.GetValue(3).ToString();

                        string Assets = item.ItemArray.GetValue(4).ToString();
                        string CurrentAssets = item.ItemArray.GetValue(5).ToString();
                        string Liabilities = item.ItemArray.GetValue(6).ToString();
                        string CurrentLiabilities = item.ItemArray.GetValue(7).ToString();
                        string Capital = item.ItemArray.GetValue(8).ToString();
                        string Cash = item.ItemArray.GetValue(9).ToString();
                        string Loan = item.ItemArray.GetValue(10).ToString();
                        //string LiabilitiesRate = item.ItemArray.GetValue(11).ToString();
                        //string CurrentRate = item.ItemArray.GetValue(12).ToString();

                        if (parentSeq != Seq.ToString()) { bDoubleValue = false; break; }       // 현재 코드와 업로드하려는 코드가 다른 경우는 양식이 잘못된것으로 오류
                        //if (!WebUtil.CheckDecimalTwo(Assets)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(CurrentAssets)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(Liabilities)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(CurrentLiabilities)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(Capital)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(Cash)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(Loan)) { bDoubleValue = false; break; }
                        ////if (!WebUtil.CheckDecimalTwo(LiabilitiesRate)) { bDoubleValue = false; break; }
                        ////if (!WebUtil.CheckDecimalTwo(CurrentRate)) { bDoubleValue = false; break; }

                        var p = new PlanYearBsBsheet();
                        p.Seq = Convert.ToInt32(excelSeq);
                        p.Assets = Convert.ToDecimal(Assets);
                        p.CurrentAssets = Convert.ToDecimal(CurrentAssets);
                        p.Liabilities = Convert.ToDecimal(Liabilities);
                        p.CurrentLiabilities = Convert.ToDecimal(CurrentLiabilities);
                        p.Capital = Convert.ToDecimal(Capital);
                        p.Cash = Convert.ToDecimal(Cash);
                        p.Loan = Convert.ToDecimal(Loan);
                        p.LiabilitiesRate = 0;
                        p.CurrentRate = 0;
                        pSalesList.Add(p);
                    }

                    if (!bDoubleValue)
                    {
                        fileUtil.FileDelete(filePath, file["STORED_FILE_NAME"]);
                        result = false;
                        resultMsg = Message.MSG_007_E;
                        return Json(new { success = result, resultMsg = resultMsg }, JsonRequestBehavior.AllowGet);
                    }

                    foreach (DataRow item in ds.Tables["ROIC"].Rows)
                    {
                        string parentSeq = item.ItemArray.GetValue(0).ToString();
                        string excelSeq = item.ItemArray.GetValue(1).ToString();
                        string yearlyYear = item.ItemArray.GetValue(2).ToString();
                        string monthly = item.ItemArray.GetValue(3).ToString();

                        string AfterTaxOperationProfit = item.ItemArray.GetValue(4).ToString();
                        string PainInCapital = item.ItemArray.GetValue(5).ToString();
                        ////string Roic = item.ItemArray.GetValue(6).ToString();

                        if (parentSeq != Seq.ToString()) { bDoubleValue = false; break; }       // 현재 코드와 업로드하려는 코드가 다른 경우는 양식이 잘못된것으로 오류
                        //if (!WebUtil.CheckDecimalTwo(AfterTaxOperationProfit)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(PainInCapital)) { bDoubleValue = false; break; }
                        ////if (!WebUtil.CheckDecimalTwo(Roic)) { bDoubleValue = false; break; }

                        var p = new PlanYearBsRoic();
                        p.Seq = Convert.ToInt32(excelSeq);
                        p.AfterTaxOperationProfit = Convert.ToDecimal(AfterTaxOperationProfit);
                        p.PainInCapital = Convert.ToDecimal(PainInCapital);
                        p.Roic = 0;

                        planRoic.Add(p);
                    }

                    if (!bDoubleValue)
                    {
                        fileUtil.FileDelete(filePath, file["STORED_FILE_NAME"]);
                        result = false;
                        resultMsg = Message.MSG_007_E;
                        return Json(new { success = result, resultMsg = resultMsg }, JsonRequestBehavior.AllowGet);
                    }

                    foreach (DataRow item in ds.Tables["W_Capital"].Rows)
                    {
                        string parentSeq = item.ItemArray.GetValue(0).ToString();
                        string excelSeq = item.ItemArray.GetValue(1).ToString();
                        string yearlyYear = item.ItemArray.GetValue(2).ToString();
                        string monthly = item.ItemArray.GetValue(3).ToString();

                        string AnnualSales = item.ItemArray.GetValue(4).ToString();
                        string AnnualSalesCost = item.ItemArray.GetValue(5).ToString();
                        string InventoryCost = item.ItemArray.GetValue(6).ToString();
                        
                        if (parentSeq != Seq.ToString()) { bDoubleValue = false; break; }       // 현재 코드와 업로드하려는 코드가 다른 경우는 양식이 잘못된것으로 오류
                        //if (!WebUtil.CheckDecimalTwo(AnnualSales)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(AnnualSalesCost)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(InventoryCost)) { bDoubleValue = false; break; }

                        var p = new PlanYearBsWCapital();
                        p.Seq = Convert.ToInt32(excelSeq);
                        p.AnnualSales = Convert.ToDecimal(AnnualSales);
                        p.AnnualSalesCost = Convert.ToDecimal(AnnualSalesCost);
                        p.InventoryCost = Convert.ToDecimal(InventoryCost);
                        pBsWCapital.Add(p);
                    }

                    if (!bDoubleValue)
                    {
                        fileUtil.FileDelete(filePath, file["STORED_FILE_NAME"]);
                        result = false;
                        resultMsg = Message.MSG_007_E;
                        return Json(new { success = result, resultMsg = resultMsg }, JsonRequestBehavior.AllowGet);
                    }

                    foreach (DataRow item in ds.Tables["W_Capital_Reg"].Rows)
                    {
                        string parentSeq = item.ItemArray.GetValue(0).ToString();
                        string excelSeq = item.ItemArray.GetValue(1).ToString();
                        string yearlyYear = item.ItemArray.GetValue(2).ToString();
                        string monthly = item.ItemArray.GetValue(3).ToString();

                        string Ar = item.ItemArray.GetValue(4).ToString();
                        string Ap = item.ItemArray.GetValue(5).ToString();
                        string Inventory = item.ItemArray.GetValue(6).ToString();

                        //string Ar = item.ItemArray.GetValue(4).ToString();
                        //string ArToDays = item.ItemArray.GetValue(5).ToString();
                        //string Ap = item.ItemArray.GetValue(6).ToString();
                        //string ApToDays = item.ItemArray.GetValue(7).ToString();
                        //string Inventory = item.ItemArray.GetValue(8).ToString();
                        //string InventoryToDays = item.ItemArray.GetValue(9).ToString();

                        if (parentSeq != Seq.ToString()) { bDoubleValue = false; break; }       // 현재 코드와 업로드하려는 코드가 다른 경우는 양식이 잘못된것으로 오류
                        //if (!WebUtil.CheckDecimalTwo(Ar)) { bDoubleValue = false; break; }
                        ////if (!WebUtil.CheckDecimalTwo(ArToDays)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(Ap)) { bDoubleValue = false; break; }
                        ////if (!WebUtil.CheckDecimalTwo(ApToDays)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(Inventory)) { bDoubleValue = false; break; }
                        ////if (!WebUtil.CheckDecimalTwo(InventoryToDays)) { bDoubleValue = false; break; }

                        var p = new PlanYearBsWCapitalReg();
                        p.Seq = Convert.ToInt32(excelSeq);
                        p.Ar = Convert.ToDecimal(Ar);
                        p.ArToDays = 0;
                        p.Ap = Convert.ToDecimal(Ap);
                        p.ApToDays = 0;
                        p.Inventory = Convert.ToDecimal(Inventory);
                        p.InventoryToDays = 0;

                        pBsWCapitalReg.Add(p);
                    }

                    if (!bDoubleValue)
                    {
                        fileUtil.FileDelete(filePath, file["STORED_FILE_NAME"]);
                        result = false;
                        resultMsg = Message.MSG_007_E;
                        return Json(new { success = result, resultMsg = resultMsg }, JsonRequestBehavior.AllowGet);
                    }
                }
                catch (Exception e)
                {
                    // 오류시 파일 삭제
                    fileUtil.FileDelete(filePath, file["STORED_FILE_NAME"]);
                    //LogUtil.MngError(e.ToString());
                    result = false;
                    resultMsg = Message.MSG_007_E;
                    return Json(new { success = result, resultMsg = resultMsg }, JsonRequestBehavior.AllowGet);
                }


                // 문제 없으면 업데이트
                foreach (var item in pSalesList)
                {
                    planYearBsBsheetRepo.update(item);
                }
                foreach (var item in planRoic)
                {
                    planYearBsRoicRepo.update(item);
                }
                foreach (var item in pBsWCapital)
                {
                    planYearBsWCapitalRepo.update(item);
                }
                foreach (var item in pBsWCapitalReg)
                {
                    planYearBsWCapitalRegRepo.update(item);
                }

                // 업데이트 완료 후 로그 남기기
                ExcelFileUploadList eFileList = new ExcelFileUploadList();
                eFileList.UserKey = SessionManager.GetAdminSession().insaUserV.userKey;
                eFileList.EmpNo = SessionManager.GetAdminSession().insaUserV.empNo;
                eFileList.AttachTableName = "PLAN_YEAR_BS";
                eFileList.AttachTableSeq = Seq;
                eFileList.FileInputName = "UploadExcel";
                eFileList.FileOrgName = file["ORIGINAL_FILE_NAME"];
                eFileList.FilePath = filePath;
                eFileList.FileStoredName = file["STORED_FILE_NAME"];
                eFileList.FileSize = file["FILE_SIZE"];

                excelFileUploadListRepo.insert(eFileList);

                result = true;
                resultMsg = Message.MSG_007_A;
            }
            return Json(new { success = result, resultMsg = resultMsg }, JsonRequestBehavior.AllowGet);
        }

        [Route("Excel_Upload2")]
        public ActionResult ExcelUpload2(int Seq
                                        , int OrgCompanySeq
                                        , List<int> PlanYearBsBsheetSeq
                                        , List<int> PlanYearBsRoicSeq
                                        , List<int> PlanYearBsWCapitalSeq
                                        , List<int> PlanYearBsCapitalRegSeq
                                        , HttpPostedFileBase ExcelFile)
        {
            // 엑셀파일 검증 후
            // 문제가 없다면 엑셀 파일 데이터에 입력
            // 저장 완료되면 엑셀 로그에 데이터 남기고 해당 파일 저장
            // 문제가 있으면 삭제

            bool result = false;
            string resultMsg = "";

            if (ExcelFile.ContentLength != 0)
            {
                FileUtil fileUtil = new FileUtil(Define.FILE_PATH);
                string filePath = "PlanYearBs";
                var file = fileUtil.FileUpload(ExcelFile, filePath);

                bool bDoubleValue = true;
                ExcelUtil excelUtil = new ExcelUtil();
                var ds = excelUtil.ImportExcelDs(file["FILE_PATH"]);

                var pSalesList = new List<PlanYearBsBsheet>();
                var planRoic = new List<PlanYearBsRoic>();
                var pBsWCapital = new List<PlanYearBsWCapital>();
                var pBsWCapitalReg = new List<PlanYearBsWCapitalReg>();

                try
                {
                    // 다운받은 sheet 이름으로 체크 한다.
                    if (ds.Tables["BSheet"] == null || ds.Tables["BSheet"].Rows.Count == 0)
                    {
                        fileUtil.FileDelete(filePath, file["STORED_FILE_NAME"]);
                        result = false;
                        resultMsg = Message.MSG_007_E;
                        return Json(new { success = result, resultMsg = resultMsg }, JsonRequestBehavior.AllowGet);
                    }
                    if (ds.Tables["ROIC"] == null || ds.Tables["ROIC"].Rows.Count == 0)
                    {
                        fileUtil.FileDelete(filePath, file["STORED_FILE_NAME"]);
                        result = false;
                        resultMsg = Message.MSG_007_E;
                        return Json(new { success = result, resultMsg = resultMsg }, JsonRequestBehavior.AllowGet);
                    }
                    if (ds.Tables["W_Capital"] == null || ds.Tables["W_Capital"].Rows.Count == 0)
                    {
                        fileUtil.FileDelete(filePath, file["STORED_FILE_NAME"]);
                        result = false;
                        resultMsg = Message.MSG_007_E;
                        return Json(new { success = result, resultMsg = resultMsg }, JsonRequestBehavior.AllowGet);
                    }
                    if (ds.Tables["W_Capital_Reg"] == null || ds.Tables["W_Capital_Reg"].Rows.Count == 0)
                    {
                        fileUtil.FileDelete(filePath, file["STORED_FILE_NAME"]);
                        result = false;
                        resultMsg = Message.MSG_007_E;
                        return Json(new { success = result, resultMsg = resultMsg }, JsonRequestBehavior.AllowGet);
                    }
                    int j = 0;
                    foreach (DataRow item in ds.Tables["BSheet"].Rows)
                    {
                        //string parentSeq = item.ItemArray.GetValue(0).ToString();
                        string excelSeq = PlanYearBsBsheetSeq[j].ToString();

                        string Assets = item.ItemArray.GetValue(2).ToString();
                        string CurrentAssets = item.ItemArray.GetValue(3).ToString();
                        string Liabilities = item.ItemArray.GetValue(4).ToString();
                        string CurrentLiabilities = item.ItemArray.GetValue(5).ToString();
                        string Capital = item.ItemArray.GetValue(6).ToString();
                        string Cash = item.ItemArray.GetValue(7).ToString();
                        string Loan = item.ItemArray.GetValue(8).ToString();
                        // string yearlyYear = item.ItemArray.GetValue(2).ToString();
                        // string monthly = item.ItemArray.GetValue(3).ToString();

                        //string Assets = item.ItemArray.GetValue(4).ToString();
                        //string CurrentAssets = item.ItemArray.GetValue(5).ToString();
                        //string Liabilities = item.ItemArray.GetValue(6).ToString();
                        //string CurrentLiabilities = item.ItemArray.GetValue(7).ToString();
                        //string Capital = item.ItemArray.GetValue(8).ToString();
                        //string Cash = item.ItemArray.GetValue(9).ToString();
                        //string Loan = item.ItemArray.GetValue(10).ToString();
                        //string LiabilitiesRate = item.ItemArray.GetValue(11).ToString();
                        //string CurrentRate = item.ItemArray.GetValue(12).ToString();

                        // if (parentSeq != Seq.ToString()) { bDoubleValue = false; break; }       // 현재 코드와 업로드하려는 코드가 다른 경우는 양식이 잘못된것으로 오류
                        //if (!WebUtil.CheckDecimalTwo(Assets)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(CurrentAssets)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(Liabilities)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(CurrentLiabilities)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(Capital)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(Cash)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(Loan)) { bDoubleValue = false; break; }
                        ////if (!WebUtil.CheckDecimalTwo(LiabilitiesRate)) { bDoubleValue = false; break; }
                        ////if (!WebUtil.CheckDecimalTwo(CurrentRate)) { bDoubleValue = false; break; }

                        var p = new PlanYearBsBsheet();
                        p.Seq = Convert.ToInt32(excelSeq);
                        p.Assets = Convert.ToDecimal(Assets);
                        p.CurrentAssets = Convert.ToDecimal(CurrentAssets);
                        p.Liabilities = Convert.ToDecimal(Liabilities);
                        p.CurrentLiabilities = Convert.ToDecimal(CurrentLiabilities);
                        p.Capital = Convert.ToDecimal(Capital);
                        p.Cash = Convert.ToDecimal(Cash);
                        p.Loan = Convert.ToDecimal(Loan);
                        p.LiabilitiesRate = 0;
                        p.CurrentRate = 0;
                        pSalesList.Add(p);
                        j += 1;
                    }

                    if (!bDoubleValue)
                    {
                        fileUtil.FileDelete(filePath, file["STORED_FILE_NAME"]);
                        result = false;
                        resultMsg = Message.MSG_007_E;
                        return Json(new { success = result, resultMsg = resultMsg }, JsonRequestBehavior.AllowGet);
                    }

                    j = 0;
                    foreach (DataRow item in ds.Tables["ROIC"].Rows)
                    {
                        //string parentSeq = item.ItemArray.GetValue(0).ToString();
                        string excelSeq = PlanYearBsRoicSeq[j].ToString();

                        string AfterTaxOperationProfit = item.ItemArray.GetValue(2).ToString();
                        string PainInCapital = item.ItemArray.GetValue(3).ToString();
                        // string yearlyYear = item.ItemArray.GetValue(2).ToString();
                        //string monthly = item.ItemArray.GetValue(3).ToString();

                        //string AfterTaxOperationProfit = item.ItemArray.GetValue(4).ToString();
                        //string PainInCapital = item.ItemArray.GetValue(5).ToString();
                        ////string Roic = item.ItemArray.GetValue(6).ToString();

                       // if (parentSeq != Seq.ToString()) { bDoubleValue = false; break; }       // 현재 코드와 업로드하려는 코드가 다른 경우는 양식이 잘못된것으로 오류
                        //if (!WebUtil.CheckDecimalTwo(AfterTaxOperationProfit)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(PainInCapital)) { bDoubleValue = false; break; }
                        ////if (!WebUtil.CheckDecimalTwo(Roic)) { bDoubleValue = false; break; }

                        var p = new PlanYearBsRoic();
                        p.Seq = Convert.ToInt32(excelSeq);
                        p.AfterTaxOperationProfit = Convert.ToDecimal(AfterTaxOperationProfit);
                        p.PainInCapital = Convert.ToDecimal(PainInCapital);
                        p.Roic = 0;

                        planRoic.Add(p);
                        j += 1;
                    }

                    if (!bDoubleValue)
                    {
                        fileUtil.FileDelete(filePath, file["STORED_FILE_NAME"]);
                        result = false;
                        resultMsg = Message.MSG_007_E;
                        return Json(new { success = result, resultMsg = resultMsg }, JsonRequestBehavior.AllowGet);
                    }

                    j = 0;
                    foreach (DataRow item in ds.Tables["W_Capital"].Rows)
                    {
                        //string parentSeq = item.ItemArray.GetValue(0).ToString();
                        string excelSeq = PlanYearBsWCapitalSeq[j].ToString();

                        string AnnualSales = item.ItemArray.GetValue(2).ToString();
                        string AnnualSalesCost = item.ItemArray.GetValue(3).ToString();
                        string InventoryCost = item.ItemArray.GetValue(4).ToString();
                        //string yearlyYear = item.ItemArray.GetValue(2).ToString();
                        //string monthly = item.ItemArray.GetValue(3).ToString();

                        //string AnnualSales = item.ItemArray.GetValue(4).ToString();
                        //string AnnualSalesCost = item.ItemArray.GetValue(5).ToString();
                        //string InventoryCost = item.ItemArray.GetValue(6).ToString();

                        // if (parentSeq != Seq.ToString()) { bDoubleValue = false; break; }       // 현재 코드와 업로드하려는 코드가 다른 경우는 양식이 잘못된것으로 오류
                        //if (!WebUtil.CheckDecimalTwo(AnnualSales)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(AnnualSalesCost)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(InventoryCost)) { bDoubleValue = false; break; }

                        var p = new PlanYearBsWCapital();
                        p.Seq = Convert.ToInt32(excelSeq);
                        p.AnnualSales = Convert.ToDecimal(AnnualSales);
                        p.AnnualSalesCost = Convert.ToDecimal(AnnualSalesCost);
                        p.InventoryCost = Convert.ToDecimal(InventoryCost);
                        pBsWCapital.Add(p);
                        j += 1;
                    }

                    if (!bDoubleValue)
                    {
                        fileUtil.FileDelete(filePath, file["STORED_FILE_NAME"]);
                        result = false;
                        resultMsg = Message.MSG_007_E;
                        return Json(new { success = result, resultMsg = resultMsg }, JsonRequestBehavior.AllowGet);
                    }

                    j = 0;
                    foreach (DataRow item in ds.Tables["W_Capital_Reg"].Rows)
                    {
                        //string parentSeq = item.ItemArray.GetValue(0).ToString();
                        string excelSeq = PlanYearBsCapitalRegSeq[j].ToString();

                        string Ar = item.ItemArray.GetValue(2).ToString();
                        string Ap = item.ItemArray.GetValue(3).ToString();
                        string Inventory = item.ItemArray.GetValue(4).ToString();
                        // string yearlyYear = item.ItemArray.GetValue(2).ToString();
                        // string monthly = item.ItemArray.GetValue(3).ToString();

                        //string Ar = item.ItemArray.GetValue(4).ToString();
                        //string Ap = item.ItemArray.GetValue(5).ToString();
                        //string Inventory = item.ItemArray.GetValue(6).ToString();

                        //string Ar = item.ItemArray.GetValue(4).ToString();
                        //string ArToDays = item.ItemArray.GetValue(5).ToString();
                        //string Ap = item.ItemArray.GetValue(6).ToString();
                        //string ApToDays = item.ItemArray.GetValue(7).ToString();
                        //string Inventory = item.ItemArray.GetValue(8).ToString();
                        //string InventoryToDays = item.ItemArray.GetValue(9).ToString();

                        //if (parentSeq != Seq.ToString()) { bDoubleValue = false; break; }       // 현재 코드와 업로드하려는 코드가 다른 경우는 양식이 잘못된것으로 오류
                        //if (!WebUtil.CheckDecimalTwo(Ar)) { bDoubleValue = false; break; }
                        ////if (!WebUtil.CheckDecimalTwo(ArToDays)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(Ap)) { bDoubleValue = false; break; }
                        ////if (!WebUtil.CheckDecimalTwo(ApToDays)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(Inventory)) { bDoubleValue = false; break; }
                        ////if (!WebUtil.CheckDecimalTwo(InventoryToDays)) { bDoubleValue = false; break; }

                        var p = new PlanYearBsWCapitalReg();
                        p.Seq = Convert.ToInt32(excelSeq);
                        p.Ar = Convert.ToDecimal(Ar);
                        p.ArToDays = 0;
                        p.Ap = Convert.ToDecimal(Ap);
                        p.ApToDays = 0;
                        p.Inventory = Convert.ToDecimal(Inventory);
                        p.InventoryToDays = 0;

                        pBsWCapitalReg.Add(p);
                        j += 1;
                    }

                    if (!bDoubleValue)
                    {
                        fileUtil.FileDelete(filePath, file["STORED_FILE_NAME"]);
                        result = false;
                        resultMsg = Message.MSG_007_E;
                        return Json(new { success = result, resultMsg = resultMsg }, JsonRequestBehavior.AllowGet);
                    }
                }
                catch (Exception e)
                {
                    // 오류시 파일 삭제
                    fileUtil.FileDelete(filePath, file["STORED_FILE_NAME"]);
                    //LogUtil.MngError(e.ToString());
                    result = false;
                    resultMsg = Message.MSG_007_E;
                    return Json(new { success = result, resultMsg = resultMsg }, JsonRequestBehavior.AllowGet);
                }


                // 문제 없으면 업데이트
                foreach (var item in pSalesList)
                {
                    planYearBsBsheetRepo.update(item);
                }
                foreach (var item in planRoic)
                {
                    planYearBsRoicRepo.update(item);
                }
                foreach (var item in pBsWCapital)
                {
                    planYearBsWCapitalRepo.update(item);
                }
                foreach (var item in pBsWCapitalReg)
                {
                    planYearBsWCapitalRegRepo.update(item);
                }

                // 업데이트 완료 후 로그 남기기
                ExcelFileUploadList eFileList = new ExcelFileUploadList();
                eFileList.UserKey = SessionManager.GetAdminSession().insaUserV.userKey;
                eFileList.EmpNo = SessionManager.GetAdminSession().insaUserV.empNo;
                eFileList.AttachTableName = "PLAN_YEAR_BS";
                eFileList.AttachTableSeq = Seq;
                eFileList.FileInputName = "UploadExcel";
                eFileList.FileOrgName = file["ORIGINAL_FILE_NAME"];
                eFileList.FilePath = filePath;
                eFileList.FileStoredName = file["STORED_FILE_NAME"];
                eFileList.FileSize = file["FILE_SIZE"];

                excelFileUploadListRepo.insert(eFileList);

                result = true;
                resultMsg = Message.MSG_007_A;
            }
            return Json(new { success = result, resultMsg = resultMsg }, JsonRequestBehavior.AllowGet);
        }
    }
}