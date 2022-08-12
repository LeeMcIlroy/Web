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
    [RoutePrefix("SiteMngHome/Plan/Year_Cf")]
    public class PlanYearCfController : SiteMngBaseController
    {
        [Route("List")]
        public ActionResult List(Search search)
        {
            dynamic model = new ExpandoObject();
            search.AuthUserKey = SessionManager.GetAdminSession().insaUserV.userKey;
            model.list = planYearCfRepo.selectList(search);
            model.UnionList = orgUnionRepo.selectList(new { });
            model.OrgCpyList = orgCompanyRepo.selectList(null);
            ViewBag.Search = search;
            return View("~/Views/SiteMngHome/Plan/Year_Cf/List.cshtml", model);
        }

        [Route("Write")]
        public ActionResult Write(PlanYearCf entity, Search search)
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");

            // 중기CF - 기본데이터
            var planYearCf = planYearCfRepo.selectOne(entity);
            // 부문 > 회사 이름
            var orgCompanyName = orgCompanyRepo.selectOne(new { Seq = entity.OrgCompanySeq });


            int thisYear = Convert.ToInt32(planYearCf.YearCfYear);
            int lastYear = thisYear + 4;
            // [영업활동, 투자활동, 재무활동]등의 데이터 0으로 입력(기초데이터 생성)
            // 영업활동
            for (int i = thisYear; i <= lastYear; i++)
            {
                PlanYearCfSales p = new PlanYearCfSales();
                p.OperationProfit = 0;
                p.DepreciationCost = 0;
                p.CorpTax = 0;
                //pSales.Ebitda = 0;
                p.Ar = 0;
                p.Inv = 0;
                p.Ap = 0;
                //pSales.WcSum = 0;
                p.Etc = 0;
                p.InterestExpense = 0;
                p.InterestIncome = 0;
                //p.FinancialCostSum = 0;

                // 현재 년도는 1-12월을 넣는다. 합계는 없다.
                if (i == thisYear)
                {
                    for (int j = 1; j <= 12; j++)
                    {
                        p.PlanYearCfSeq = entity.Seq;
                        p.YearlyYear = i.ToString();
                        p.Monthly = j.ToString().PadLeft(2, '0');
                        string where = " WHERE PLAN_YEAR_CF_SEQ = @PlanYearCfSeq AND YEARLY_YEAR = @YearlyYear AND MONTHLY = @Monthly ";
                        if (planYearCfSalesRepo.count(p, where) == 0) planYearCfSalesRepo.insert(p);
                    }
                }
                else
                {
                    p.PlanYearCfSeq = entity.Seq;
                    p.YearlyYear = i.ToString();
                    p.Monthly = "99";
                    string where = " WHERE PLAN_YEAR_CF_SEQ = @PlanYearCfSeq AND YEARLY_YEAR = @YearlyYear AND MONTHLY = @Monthly ";
                    if (planYearCfSalesRepo.count(p, where) == 0) planYearCfSalesRepo.insert(p);
                }
            }

            // 투자활동
            for (int i = thisYear; i <= lastYear; i++)
            {
                PlanYearCfInvestment p = new PlanYearCfInvestment();
                p.Assets = 0;
                p.EquityInvestment = 0;
                p.AssetsSale = 0;
                p.Etc = 0;
                //p.NetCapexSum = 0;

                if (i == thisYear)
                {
                    for (int j = 1; j <= 12; j++)
                    {
                        p.PlanYearCfSeq = entity.Seq;
                        p.YearlyYear = i.ToString();
                        p.Monthly = j.ToString().PadLeft(2, '0');
                        string where = " WHERE PLAN_YEAR_CF_SEQ = @PlanYearCfSeq AND YEARLY_YEAR = @YearlyYear AND MONTHLY = @Monthly ";
                        if (planYearCfInvestmentRepo.count(p, where) == 0) planYearCfInvestmentRepo.insert(p);
                    }
                }
                else
                {
                    p.PlanYearCfSeq = entity.Seq;
                    p.YearlyYear = i.ToString();
                    p.Monthly = "99";
                    string where = " WHERE PLAN_YEAR_CF_SEQ = @PlanYearCfSeq AND YEARLY_YEAR = @YearlyYear AND MONTHLY = @Monthly ";
                    if (planYearCfInvestmentRepo.count(p, where) == 0) planYearCfInvestmentRepo.insert(p);
                }
            }

            // 재무활동
            for (int i = thisYear; i <= lastYear; i++)
            {
                PlanYearCfFinancial p = new PlanYearCfFinancial();
                p.Allocation = 0;
                p.Increase = 0;
                p.Borrowing = 0;
                p.Repayment = 0;
                p.Etc = 0;
                //p.FinancialSum = 0;

                if (i == thisYear)
                {
                    for (int j = 1; j <= 12; j++)
                    {
                        p.PlanYearCfSeq = entity.Seq;
                        p.YearlyYear = i.ToString();
                        p.Monthly = j.ToString().PadLeft(2, '0');
                        string where = " WHERE PLAN_YEAR_CF_SEQ = @PlanYearCfSeq AND YEARLY_YEAR = @YearlyYear AND MONTHLY = @Monthly ";
                        if (planYearCfFinancialRepo.count(p, where) == 0) planYearCfFinancialRepo.insert(p);
                    }
                }
                else
                {
                    p.PlanYearCfSeq = entity.Seq;
                    p.YearlyYear = i.ToString();
                    p.Monthly = "99";
                    string where = " WHERE PLAN_YEAR_CF_SEQ = @PlanYearCfSeq AND YEARLY_YEAR = @YearlyYear AND MONTHLY = @Monthly ";
                    if (planYearCfFinancialRepo.count(p, where) == 0) planYearCfFinancialRepo.insert(p);
                }
            }

            // 상세데이터 가져오기
            var lastYearSales = pmCashFlowSalesRepo.selectListBefore(new { YearlyYear = planYearCf.YearCfYear, OrgCompanySeq = planYearCf.OrgCompanySeq });
            var thisYearSales = planYearCfSalesRepo.selectList(new { PlanYearCfSeq = entity.Seq });
            var lastYearInvestment = pmCashFlowInvestmentRepo.selectListBefore(new { YearlyYear = planYearCf.YearCfYear, OrgCompanySeq = planYearCf.OrgCompanySeq });
            var thisYearInvestment = planYearCfInvestmentRepo.selectList(new { PlanYearCfSeq = entity.Seq });
            var lastYearFinancial = pmCashFlowFinancialRepo.selectListBefore(new { YearlyYear = planYearCf.YearCfYear, OrgCompanySeq = planYearCf.OrgCompanySeq });
            var thisYearFinancial = planYearCfFinancialRepo.selectList(new { PlanYearCfSeq = entity.Seq });
            var lastYearFcf = pmCashFlowFcfRepo.selectListBefore(new { YearlyYear = planYearCf.YearCfYear, OrgCompanySeq = planYearCf.OrgCompanySeq });
            var lastYesaSales = pmPalSummaryRepo.selectListPmLastYear(new { Year = planYearCf.YearCfYear }).Where(w => w.Monthly == "12").Where(w => w.OrgCompanySeq == planYearCf.OrgCompanySeq).ToList();
            var thisYearFcf = planYearCfFcfRepo.selectList(new { PlanYearCfSeq = entity.Seq });
            var lastYearBeCash = pmCashFlowBeCashRepo.selectListBefore(new { YearlyYear = planYearCf.YearCfYear, OrgCompanySeq = planYearCf.OrgCompanySeq });
            var thisYearBeCash = planYearCfBeCashRepo.selectList(new { PlanYearCfSeq = entity.Seq });

            dynamic model = new ExpandoObject();
            model.planYearCf = planYearCf;
            model.orgCompanyName = orgCompanyName;
            model.lastYearSales = lastYearSales;
            model.thisYearSales = thisYearSales;
            model.lastYearInvestment = lastYearInvestment;
            model.thisYearInvestment = thisYearInvestment;
            model.lastYearFinancial = lastYearFinancial;
            model.thisYearFinancial = thisYearFinancial;
            model.lastYearFcf = lastYearFcf;
            model.lastYesaSales = lastYesaSales;
            model.thisYearFcf = thisYearFcf;
            model.lastYearBeCash = lastYearBeCash;
            model.thisYearBeCash = thisYearBeCash;

            ViewBag.Search = search;
            return View("~/Views/SiteMngHome/Plan/Year_Cf/Write.cshtml", model);
        }

        [Route("Calculation_One_Action")]
        public ActionResult Calculation_One_Action(PlanYearCfAdmin entity, Search search)
        {
            #region
            Dictionary<string, object> postData = new Dictionary<string, object>();
            postData.Add("Seq", entity.Seq);
            postData.Add("OrgCompanySeq", entity.OrgCompanySeq);
            postData.Add("PageIndex", search.PageIndex);
            #endregion

            bool bOne = SetBaseOneAction(entity);
            if (!bOne)
            {
                TempData["alert"] = Message.MSG_002_E;
                return RedirectToAction("List");
            }
            bOne = SetInsertFcfAction(entity);
            if (!bOne)
            {
                TempData["alert"] = Message.MSG_002_E;
                return RedirectToAction("List");
            }
            bOne = SetInsertBeCashAction(entity);

            if (!bOne)
            {
                TempData["alert"] = Message.MSG_002_E;
                return RedirectToAction("List");
            }
            else
            {
                TempData["alert"] = Message.MSG_002_A;
            }

            return RedirectAndPostActionResult.RedirectAndPost("Write", postData);
        }

        public bool SetInsertFcfAction(PlanYearCfAdmin entity)
        {
            bool bOne = true;

            // FCF
            PlanYearCfFcf pFcf = new PlanYearCfFcf();
            pFcf.PlanYearCfSeq = entity.Seq;
            pFcf.YearlyYear = entity.YearCfYear;
            planYearCfFcfRepo.delete(pFcf);
            planYearCfFcfRepo.insertCum(pFcf);

            return bOne;
        }

        public bool SetInsertBeCashAction(PlanYearCfAdmin entity)
        {
            bool bOne = true;

            int thisYear = Convert.ToInt32(entity.YearCfYear);
            int lastYear = thisYear + 4;

            // fcf 정보 : 현금흐름합계
            var thisYearMonCashSum = planYearCfFcfRepo.selectList(new { PlanYearCfSeq = entity.Seq }).ToList();
            // 기초기말현금
            planYearCfBeCashRepo.delete(new { PlanYearCfSeq = entity.Seq });
            for (int i = thisYear; i <= lastYear; i++)
            {
                PlanYearCfBeCash pBeCash = new PlanYearCfBeCash();

                if (i == thisYear)
                {
                    for (int j = 1; j <= 12; j++)
                    {
                        pBeCash.PlanYearCfSeq = entity.Seq;
                        pBeCash.YearlyYear = i.ToString();
                        pBeCash.Monthly = j.ToString().PadLeft(2, '0');

                        // 해당월의 현금흐릅합계
                        var monCashSum = thisYearMonCashSum.Where(w => w.YearlyYear == i.ToString()).Where(w => w.Monthly == j.ToString().PadLeft(2, '0')).FirstOrDefault();

                        if (pBeCash.Monthly == "01")
                        {
                            // 전년도 12월 엔딩캐쉬 가져오기 : 누계실적을 가져온다.(2018.11.19)
                            var lastYearBeCash = pmCashFlowBeCashRepo.selectListLastYear(new { YearlyYear = i.ToString(), OrgCompanySeq = entity.OrgCompanySeq });
                            pBeCash.BasicCash = lastYearBeCash.FirstOrDefault() == null ? 0 : lastYearBeCash.FirstOrDefault().EndingCash;
                            pBeCash.EndingCash = pBeCash.BasicCash + monCashSum.CashSum;
                            pBeCash.CreditLine = 0;
                            pBeCash.AvailableCash = pBeCash.EndingCash + pBeCash.CreditLine;

                            planYearCfBeCashRepo.insert(pBeCash);

                        }
                        else if (pBeCash.Monthly == "12")
                        {
                            var lastMonBeCash = planYearCfBeCashRepo.selectOneLastMonth(new { PlanYearCfSeq = pBeCash.PlanYearCfSeq, YearlyYear = pBeCash.YearlyYear, Monthly = (j - 1).ToString().PadLeft(2, '0') });
                            pBeCash.BasicCash = lastMonBeCash.EndingCash;
                            pBeCash.EndingCash = pBeCash.BasicCash + monCashSum.CashSum;
                            pBeCash.CreditLine = 0;
                            pBeCash.AvailableCash = pBeCash.EndingCash + pBeCash.CreditLine;

                            planYearCfBeCashRepo.insert(pBeCash);

                            var thisBeCash = planYearCfBeCashRepo.selectList(new { PlanYearCfSeq = entity.Seq }).ToList();
                            // 당해년도의 합계 구하기
                            // 당해 합계는 당해년도 12월걸 넣는걸로 변경. 2018.10.04
                            //var thisYearBeCash = thisBeCash.Where(w => w.YearlyYear == i.ToString())
                            //    .GroupBy(g => g.YearlyYear)
                            //    .Select(cl => new PlanYearCfBeCash
                            //    {
                            //        YearlyYear = cl.First().YearlyYear,
                            //        BasicCash = cl.Sum(c => c.BasicCash),
                            //        EndingCash = cl.Sum(c => c.EndingCash),
                            //        CreditLine = cl.Sum(c => c.CreditLine),
                            //        AvailableCash = cl.Sum(c => c.AvailableCash)
                            //    }).FirstOrDefault();

                            //pBeCash.Monthly = "99";
                            //pBeCash.BasicCash = thisYearBeCash.BasicCash;
                            //pBeCash.EndingCash = thisYearBeCash.EndingCash;
                            //pBeCash.CreditLine = thisYearBeCash.CreditLine;
                            //pBeCash.AvailableCash = thisYearBeCash.AvailableCash;

                            // 전년도 12월 엔딩캐쉬 가져오기 : 누계실적을 가져온다.(2018.11.19)
                            var lastYearBeCash = pmCashFlowBeCashRepo.selectListLastYear(new { YearlyYear = i.ToString(), OrgCompanySeq = entity.OrgCompanySeq }).FirstOrDefault();
                            if (lastYearBeCash == null) { lastYearBeCash = new PmCashFlowBeCash();   }
                            // 당해년도 합계의 기초현금은 전년도 실적(12월)에 Ending Cash를 가져오는 걸로 변경
                            pBeCash.Monthly = "99";
                            pBeCash.BasicCash = lastYearBeCash.EndingCash;
                            pBeCash.EndingCash = pBeCash.BasicCash + monCashSum.CashSum;
                            pBeCash.CreditLine = 0;
                            pBeCash.AvailableCash = pBeCash.EndingCash + pBeCash.CreditLine;

                            planYearCfBeCashRepo.insert(pBeCash);
                        }
                        else
                        {
                            var lastMonBeCash = planYearCfBeCashRepo.selectOneLastMonth(new { PlanYearCfSeq = pBeCash.PlanYearCfSeq, YearlyYear = pBeCash.YearlyYear, Monthly = (j - 1).ToString().PadLeft(2, '0') });
                            pBeCash.BasicCash = lastMonBeCash.EndingCash;
                            pBeCash.EndingCash = pBeCash.BasicCash + monCashSum.CashSum;
                            pBeCash.CreditLine = 0;
                            pBeCash.AvailableCash = pBeCash.EndingCash + pBeCash.CreditLine;

                            planYearCfBeCashRepo.insert(pBeCash);
                        }
                    }
                }
                else
                {
                    var thisBeCash = planYearCfBeCashRepo.selectList(new { PlanYearCfSeq = entity.Seq }).ToList();
                    pBeCash.PlanYearCfSeq = entity.Seq;
                    pBeCash.YearlyYear = i.ToString();
                    pBeCash.Monthly = "99";
                    // 년도 계획
                    var lastYearBeCash = thisBeCash.Where(w => w.YearlyYear == (i - 1).ToString()).Where(w => w.Monthly == pBeCash.Monthly).FirstOrDefault();
                    //var thisYearCashSum = thisYearMonCashSum.Where(w => w.YearlyYear == (i - 1).ToString()).Where(w => w.Monthly == pBeCash.Monthly).FirstOrDefault();
                    var thisYearCashSum = thisYearMonCashSum.Where(w => w.YearlyYear == (i).ToString()).Where(w => w.Monthly == pBeCash.Monthly).FirstOrDefault();
                    if (lastYearBeCash == null) { lastYearBeCash = new PlanYearCfBeCash(); }

                    pBeCash.BasicCash = lastYearBeCash.EndingCash;
                    pBeCash.EndingCash = pBeCash.BasicCash + thisYearCashSum.CashSum;
                    pBeCash.CreditLine = 0;
                    pBeCash.AvailableCash = pBeCash.EndingCash + pBeCash.CreditLine;

                    planYearCfBeCashRepo.insert(pBeCash);
                }
            }

            return bOne;
        }

        public bool SetUpdateBeCashAction(PlanYearCfAdmin entity)
        {
            bool bOne = true;

            // fcf 정보 : 현금흐름합계
            var thisYearMonCashSum = planYearCfFcfRepo.selectList(new { PlanYearCfSeq = entity.Seq }).ToList();

            for (int i = 0; i < entity.PlanYearCfBeCashSeq.Count(); i++)
            {
                string yearlyYear = entity.PlanYearCfBeCashYearlyYear[i];
                string monthly = entity.PlanYearCfBeCashMonthly[i];
                // 해당월의 현금흐릅합계
                var monCashSum = thisYearMonCashSum.Where(w => w.YearlyYear == yearlyYear).Where(w => w.Monthly == monthly).FirstOrDefault();

                PlanYearCfBeCash p = new PlanYearCfBeCash();
                p.Seq = entity.PlanYearCfBeCashSeq[i];
                p.CreditLine = entity.CreditLine[i];

                if (yearlyYear == entity.YearCfYear && monthly == "01")
                {
                    // 전년도 12월 엔딩캐쉬 가져오기 : 누계실적을 가져온다.(2018.11.19)
                    var lastYearBeCash = pmCashFlowBeCashRepo.selectListLastYear(new { YearlyYear = yearlyYear, OrgCompanySeq = entity.OrgCompanySeq });
                    p.BasicCash = lastYearBeCash.FirstOrDefault() == null ? 0 : lastYearBeCash.FirstOrDefault().EndingCash;
                    p.EndingCash = p.BasicCash + monCashSum.CashSum;
                    p.AvailableCash = p.BasicCash + p.CreditLine;

                    planYearCfBeCashRepo.update(p);
                }
                else if (yearlyYear == entity.YearCfYear && monthly == "99")
                {
                    //var thisBeCash = planYearCfBeCashRepo.selectList(new { PlanYearCfSeq = entity.Seq }).ToList();
                    //// 당해년도의 합계 구하기
                    //var thisYearBeCash = thisBeCash.Where(w => w.YearlyYear == yearlyYear)
                    //            .GroupBy(g => g.YearlyYear)
                    //            .Select(cl => new PlanYearCfBeCash
                    //            {
                    //                YearlyYear = cl.First().YearlyYear,
                    //                BasicCash = cl.Sum(c => c.BasicCash),
                    //                EndingCash = cl.Sum(c => c.EndingCash),
                    //                CreditLine = cl.Sum(c => c.CreditLine),
                    //                AvailableCash = cl.Sum(c => c.AvailableCash)
                    //            }).FirstOrDefault();

                    //p.BasicCash = thisYearBeCash.BasicCash;
                    //p.EndingCash = thisYearBeCash.EndingCash;
                    //p.CreditLine = thisYearBeCash.CreditLine;
                    //p.AvailableCash = thisYearBeCash.AvailableCash;


                    var lastYearBeCash = pmCashFlowBeCashRepo.selectListLastYear(new { YearlyYear = yearlyYear, OrgCompanySeq = entity.OrgCompanySeq });
                    p.BasicCash = lastYearBeCash.FirstOrDefault() == null ? 0 : lastYearBeCash.FirstOrDefault().EndingCash;
                    p.EndingCash = p.BasicCash + monCashSum.CashSum;

                    //var lastMonBeCash = planYearCfBeCashRepo.selectOneLastMonth(new { PlanYearCfSeq = entity.Seq, YearlyYear = yearlyYear, Monthly = "12" });
                    //p.BasicCash = lastMonBeCash.EndingCash;
                    //p.EndingCash = p.BasicCash + monCashSum.CashSum;
                    p.AvailableCash = p.EndingCash + p.CreditLine;

                    planYearCfBeCashRepo.update(p);
                }
                else if (yearlyYear != entity.YearCfYear && monthly == "99")
                {
                    var thisBeCash = planYearCfBeCashRepo.selectList(new { PlanYearCfSeq = entity.Seq }).ToList();
                    // 년도 계획
                    var lastYearBeCash = thisBeCash.Where(w => w.YearlyYear == (Convert.ToInt32(yearlyYear) - 1).ToString()).Where(w => w.Monthly == monthly).FirstOrDefault();
                    // 당해년도 현금흐름합계와 계산
                    var thisYearCashSum = thisYearMonCashSum.Where(w => w.YearlyYear == (Convert.ToInt32(yearlyYear)).ToString()).Where(w => w.Monthly == monthly).FirstOrDefault();
                    p.BasicCash = lastYearBeCash.EndingCash;
                    p.EndingCash = p.BasicCash + thisYearCashSum.CashSum;
                    p.AvailableCash = p.EndingCash + p.CreditLine;

                    planYearCfBeCashRepo.update(p);
                }
                else
                {
                    var lastMonBeCash = planYearCfBeCashRepo.selectOneLastMonth(new { PlanYearCfSeq = entity.Seq, YearlyYear = yearlyYear, Monthly = (Convert.ToInt32(monthly) - 1).ToString().PadLeft(2, '0') });
                    p.BasicCash = lastMonBeCash.EndingCash;
                    p.EndingCash = p.BasicCash + monCashSum.CashSum;
                    p.AvailableCash = p.EndingCash + p.CreditLine;

                    planYearCfBeCashRepo.update(p);
                }

            }

            return bOne;
        }

        public bool SetBaseOneAction(PlanYearCfAdmin entity)
        {
            bool bOne = true;

            List<PlanYearCfSales> pSalesList = new List<PlanYearCfSales>();
            List<PlanYearCfInvestment> pInvestmentList = new List<PlanYearCfInvestment>();
            List<PlanYearCfFinancial> pFinancialList = new List<PlanYearCfFinancial>();
            try
            {
                for (int i = 0; i < entity.PlanYearCfSalesSeq.Count(); i++)
                {
                    if (!WebUtil.CheckDecimalTwo(entity.OperationProfit[i].ToString())) { bOne = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.DepreciationCost[i].ToString())) { bOne = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.CorpTax[i].ToString())) { bOne = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.Ar[i].ToString())) { bOne = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.Inv[i].ToString())) { bOne = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.Ap[i].ToString())) { bOne = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.Etc[i].ToString())) { bOne = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.InterestExpense[i].ToString())) { bOne = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.InterestIncome[i].ToString())) { bOne = false; break; }

                    PlanYearCfSales pSales = new PlanYearCfSales();
                    pSales.Seq = entity.PlanYearCfSalesSeq[i];
                    pSales.OperationProfit = entity.OperationProfit[i];
                    pSales.DepreciationCost = entity.DepreciationCost[i];
                    pSales.CorpTax = entity.CorpTax[i];
                    pSales.Ar = entity.Ar[i];
                    pSales.Inv = entity.Inv[i];
                    pSales.Ap = entity.Ap[i];
                    pSales.Etc = entity.Etc[i];
                    pSales.InterestExpense = entity.InterestExpense[i];
                    pSales.InterestIncome = entity.InterestIncome[i];

                    pSalesList.Add(pSales);
                }

                if (bOne)
                {
                    for (int i = 0; i < entity.PlanYearCfInvestmentSeq.Count(); i++)
                    {
                        if (!WebUtil.CheckDecimalTwo(entity.Assets[i].ToString())) { bOne = false; break; }
                        if (!WebUtil.CheckDecimalTwo(entity.EquityInvestment[i].ToString())) { bOne = false; break; }
                        if (!WebUtil.CheckDecimalTwo(entity.AssetsSale[i].ToString())) { bOne = false; break; }
                        if (!WebUtil.CheckDecimalTwo(entity.InvestmentEtc[i].ToString())) { bOne = false; break; }

                        PlanYearCfInvestment pInvestment = new PlanYearCfInvestment();
                        pInvestment.Seq = entity.PlanYearCfInvestmentSeq[i];
                        pInvestment.Assets = entity.Assets[i];
                        pInvestment.EquityInvestment = entity.EquityInvestment[i];
                        pInvestment.AssetsSale = entity.AssetsSale[i];
                        pInvestment.Etc = entity.InvestmentEtc[i];

                        pInvestmentList.Add(pInvestment);
                    }
                }

                if (bOne)
                {
                    for (int i = 0; i < entity.PlanYearCfFinancialSeq.Count(); i++)
                    {
                        if (!WebUtil.CheckDecimalTwo(entity.Allocation[i].ToString())) { bOne = false; break; }
                        if (!WebUtil.CheckDecimalTwo(entity.Increase[i].ToString())) { bOne = false; break; }
                        if (!WebUtil.CheckDecimalTwo(entity.Borrowing[i].ToString())) { bOne = false; break; }
                        if (!WebUtil.CheckDecimalTwo(entity.Repayment[i].ToString())) { bOne = false; break; }
                        if (!WebUtil.CheckDecimalTwo(entity.FinancialEtc[i].ToString())) { bOne = false; break; }

                        PlanYearCfFinancial pFinancial = new PlanYearCfFinancial();
                        pFinancial.Seq = entity.PlanYearCfFinancialSeq[i];
                        pFinancial.Allocation = entity.Allocation[i];
                        pFinancial.Increase = entity.Increase[i];
                        pFinancial.Borrowing = entity.Borrowing[i];
                        pFinancial.Repayment = entity.Repayment[i];
                        pFinancial.Etc = entity.FinancialEtc[i];

                        pFinancialList.Add(pFinancial);
                    }
                }
            }
            catch (Exception)
            {
                bOne = false;
            }

            if (bOne)
            {
                foreach (var item in pSalesList)
                {
                    PlanYearCfSales p = new PlanYearCfSales();
                    p.Seq = item.Seq;
                    p.OperationProfit = item.OperationProfit;
                    p.DepreciationCost = item.DepreciationCost;
                    p.CorpTax = item.CorpTax;
                    p.Ar = item.Ar;
                    p.Inv = item.Inv;
                    p.Ap = item.Ap;
                    p.Etc = item.Etc;
                    p.InterestExpense = item.InterestExpense;
                    p.InterestIncome = item.InterestIncome;

                    planYearCfSalesRepo.update(p);
                }

                foreach (var item in pInvestmentList)
                {
                    PlanYearCfInvestment p = new PlanYearCfInvestment();
                    p.Seq = item.Seq;
                    p.Assets = item.Assets;
                    p.EquityInvestment = item.EquityInvestment;
                    p.AssetsSale = item.AssetsSale;
                    p.Etc = item.Etc;

                    planYearCfInvestmentRepo.update(p);
                }

                foreach (var item in pFinancialList)
                {
                    PlanYearCfFinancial p = new PlanYearCfFinancial();
                    p.Seq = item.Seq;
                    p.Allocation = item.Allocation;
                    p.Increase = item.Increase;
                    p.Borrowing = item.Borrowing;
                    p.Repayment = item.Repayment;
                    p.Etc = item.Etc;

                    planYearCfFinancialRepo.update(p);
                }
            }

            return bOne;
        }

        [Route("Calculation_Two_Action")]
        public ActionResult Calculation_Two_Action(PlanYearCfAdmin entity, Search search)
        {
            #region
            Dictionary<string, object> postData = new Dictionary<string, object>();
            postData.Add("Seq", entity.Seq);
            postData.Add("OrgCompanySeq", entity.OrgCompanySeq);
            postData.Add("PageIndex", search.PageIndex);
            #endregion

            bool bOne = SetBaseOneAction(entity);
            if (!bOne)
            {
                TempData["alert"] = Message.MSG_002_E;
                return RedirectToAction("List");
            }
            bOne = SetInsertFcfAction(entity);

            bOne = SetUpdateBeCashAction(entity);

            // 요약
            PlanYearCfSummary pSummary = new PlanYearCfSummary();
            pSummary.PlanYearCfSeq = entity.Seq;
            planYearCfSummaryRepo.delete(new { PlanYearCfSeq = entity.Seq });
            planYearCfSummaryRepo.insertCum(pSummary);
            // 전년도 실적
            var pLast = pmCashFlowCumulativeRepo.selectListLastYearPn(new { YearlyYear = entity.YearCfYear, OrgCompanySeq = entity.OrgCompanySeq }).FirstOrDefault();
            var pThis = planYearCfSummaryRepo.selectList(new { PlanYearCfSeq = entity.Seq }).Where(w => w.Yearly == "THIS");
            foreach (var item in pThis)
            {
                PlanYearCfSummary pLastInsert = new PlanYearCfSummary();
                if (item.YearlyYear == entity.YearCfYear)
                {
                    pLastInsert.PlanYearCfSeq = entity.Seq;
                    pLastInsert.Yearly = "LAST";
                    pLastInsert.YearlyYear = item.YearlyYear;
                    pLastInsert.CfSales = item.CfSales - (pLast == null ? 0 : pLast.CfSales);
                    pLastInsert.CfInvestment = item.CfInvestment - (pLast == null ? 0 : pLast.CfInvestment);
                    pLastInsert.CfFinancial = item.CfFinancial - (pLast == null ? 0 : pLast.CfFinancial);
                    pLastInsert.CfEndingCash = item.CfEndingCash - (pLast == null ? 0 : pLast.CfEndingCash);
                    pLastInsert.CfAvailableCash = item.CfAvailableCash - (pLast == null ? 0 : pLast.CfAvailableCash);
                    pLastInsert.Fcf1 = item.Fcf1 - (pLast == null ? 0 : pLast.Fcf1);
                    pLastInsert.Fcf2 = item.Fcf2 - (pLast == null ? 0 : pLast.Fcf2);
                    pLastInsert.Fcf3 = item.Fcf3 - (pLast == null ? 0 : pLast.Fcf3);

                    planYearCfSummaryRepo.insert(pLastInsert);
                }
                else
                {
                    var vLast = pThis.Where(w => w.YearlyYear == (Convert.ToInt32(item.YearlyYear) - 1).ToString()).FirstOrDefault();

                    pLastInsert.PlanYearCfSeq = entity.Seq;
                    pLastInsert.Yearly = "LAST";
                    pLastInsert.YearlyYear = item.YearlyYear;
                    pLastInsert.CfSales = item.CfSales - (vLast == null ? 0 : vLast.CfSales);
                    pLastInsert.CfInvestment = item.CfInvestment - (vLast == null ? 0 : vLast.CfInvestment);
                    pLastInsert.CfFinancial = item.CfFinancial - (vLast == null ? 0 : vLast.CfFinancial);
                    pLastInsert.CfEndingCash = item.CfEndingCash - (vLast == null ? 0 : vLast.CfEndingCash);
                    pLastInsert.CfAvailableCash = item.CfAvailableCash - (vLast == null ? 0 : vLast.CfAvailableCash);
                    pLastInsert.Fcf1 = item.Fcf1 - (vLast == null ? 0 : vLast.Fcf1);
                    pLastInsert.Fcf2 = item.Fcf2 - (vLast == null ? 0 : vLast.Fcf2);
                    pLastInsert.Fcf3 = item.Fcf3 - (vLast == null ? 0 : vLast.Fcf3);

                    planYearCfSummaryRepo.insert(pLastInsert);
                }
            }

            if (!bOne)
            {
                TempData["alert"] = Message.MSG_002_E;
                return RedirectToAction("List");
            }
            else
            {
                TempData["alert"] = Message.MSG_002_A;
            }

            // 2018.10.29 수정화면에서 저장한 뒤에 저장상태로 변경
            //// 미저장에서 저장으로 변경
            //if (entity.RegistStatus == Define.REGIST_STATUS.GetKey("미등록"))
            //{
            //    entity.RegistStatus = Define.REGIST_STATUS.GetKey("저장");
            //    PlanYearCf p = new PlanYearCf();
            //    p.Seq = entity.Seq;
            //    p.RegistStatus = entity.RegistStatus;
            //    planYearCfRepo.updateRegist(p);
            //}

            return RedirectAndPostActionResult.RedirectAndPost("Edit", postData);
        }

        [Route("View")]
        public ActionResult view(PlanYearCf entity, Search search)
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");

            // 중기CF - 기본데이터
            var planYearCf = planYearCfRepo.selectOne(entity);
            // 부문 > 회사 이름
            var orgCompanyName = orgCompanyRepo.selectOne(new { Seq = entity.OrgCompanySeq });

            // 상세데이터 가져오기
            var lastYearSales = pmCashFlowSalesRepo.selectListBefore(new { YearlyYear = planYearCf.YearCfYear, OrgCompanySeq = planYearCf.OrgCompanySeq });
            var thisYearSales = planYearCfSalesRepo.selectList(new { PlanYearCfSeq = entity.Seq });
            var lastYearInvestment = pmCashFlowInvestmentRepo.selectListBefore(new { YearlyYear = planYearCf.YearCfYear, OrgCompanySeq = planYearCf.OrgCompanySeq });
            var thisYearInvestment = planYearCfInvestmentRepo.selectList(new { PlanYearCfSeq = entity.Seq });
            var lastYearFinancial = pmCashFlowFinancialRepo.selectListBefore(new { YearlyYear = planYearCf.YearCfYear, OrgCompanySeq = planYearCf.OrgCompanySeq });
            var thisYearFinancial = planYearCfFinancialRepo.selectList(new { PlanYearCfSeq = entity.Seq });
            var lastYearFcf = pmCashFlowFcfRepo.selectListBefore(new { YearlyYear = planYearCf.YearCfYear, OrgCompanySeq = planYearCf.OrgCompanySeq });
            var lastYesaSales = pmPalSummaryRepo.selectListPmLastYear(new { Year = planYearCf.YearCfYear }).Where(w => w.Monthly == "12").Where(w => w.OrgCompanySeq == planYearCf.OrgCompanySeq).ToList();
            var thisYearFcf = planYearCfFcfRepo.selectList(new { PlanYearCfSeq = entity.Seq });
            var lastYearBeCash = pmCashFlowBeCashRepo.selectListBefore(new { YearlyYear = planYearCf.YearCfYear, OrgCompanySeq = planYearCf.OrgCompanySeq });
            var thisYearBeCash = planYearCfBeCashRepo.selectList(new { PlanYearCfSeq = entity.Seq });
            var lastYearSummary = pmCashFlowCumulativeRepo.selectListLastYearPn(new { YearlyYear = planYearCf.YearCfYear, OrgCompanySeq = planYearCf.OrgCompanySeq });
            // 2018.12.12 작년도 실적 요약 가져오는 항목 일부 변경
            var lastYearSummary2 = pmCashFlowCumulativeRepo.selectListLastYear(new { Year = planYearCf.YearCfYear, OrgCompanySeq = planYearCf.OrgCompanySeq });
            var thisYearSummary = planYearCfSummaryRepo.selectList(new { PlanYearCfSeq = entity.Seq });

            dynamic model = new ExpandoObject();
            model.planYearCf = planYearCf;
            model.orgCompanyName = orgCompanyName;
            model.lastYearSales = lastYearSales;
            model.thisYearSales = thisYearSales;
            model.lastYearInvestment = lastYearInvestment;
            model.thisYearInvestment = thisYearInvestment;
            model.lastYearFinancial = lastYearFinancial;
            model.thisYearFinancial = thisYearFinancial;
            model.lastYearFcf = lastYearFcf;
            model.lastYesaSales = lastYesaSales;
            model.thisYearFcf = thisYearFcf;
            model.lastYearBeCash = lastYearBeCash;
            model.thisYearBeCash = thisYearBeCash;
            model.lastYearSummary = lastYearSummary;
            model.thisYearSummary = thisYearSummary;
            model.lastYearSummary2 = lastYearSummary2;

            if (entity.message != null)
            {
                TempData["alert"] = entity.message;
            }

            ViewBag.Search = search;
            return View("~/Views/SiteMngHome/Plan/Year_Cf/View.cshtml", model);
        }

        [Route("Edit")]
        public ActionResult Edit(PlanYearCf entity, Search search)
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");

            // 중기CF - 기본데이터
            var planYearCf = planYearCfRepo.selectOne(entity);
            // 부문 > 회사 이름
            var orgCompanyName = orgCompanyRepo.selectOne(new { Seq = entity.OrgCompanySeq });

            // 상세데이터 가져오기
            var lastYearSales = pmCashFlowSalesRepo.selectListBefore(new { YearlyYear = planYearCf.YearCfYear, OrgCompanySeq = planYearCf.OrgCompanySeq });
            var thisYearSales = planYearCfSalesRepo.selectList(new { PlanYearCfSeq = entity.Seq });
            var lastYearInvestment = pmCashFlowInvestmentRepo.selectListBefore(new { YearlyYear = planYearCf.YearCfYear, OrgCompanySeq = planYearCf.OrgCompanySeq });
            var thisYearInvestment = planYearCfInvestmentRepo.selectList(new { PlanYearCfSeq = entity.Seq });
            var lastYearFinancial = pmCashFlowFinancialRepo.selectListBefore(new { YearlyYear = planYearCf.YearCfYear, OrgCompanySeq = planYearCf.OrgCompanySeq });
            var thisYearFinancial = planYearCfFinancialRepo.selectList(new { PlanYearCfSeq = entity.Seq });
            var lastYearFcf = pmCashFlowFcfRepo.selectListBefore(new { YearlyYear = planYearCf.YearCfYear, OrgCompanySeq = planYearCf.OrgCompanySeq });
            var lastYesaSales = pmPalSummaryRepo.selectListPmLastYear(new { Year = planYearCf.YearCfYear }).Where(w => w.Monthly == "12").Where(w => w.OrgCompanySeq == planYearCf.OrgCompanySeq).ToList();
            var thisYearFcf = planYearCfFcfRepo.selectList(new { PlanYearCfSeq = entity.Seq });
            var lastYearBeCash = pmCashFlowBeCashRepo.selectListBefore(new { YearlyYear = planYearCf.YearCfYear, OrgCompanySeq = planYearCf.OrgCompanySeq });
            var thisYearBeCash = planYearCfBeCashRepo.selectList(new { PlanYearCfSeq = entity.Seq });
            var lastYearSummary = pmCashFlowCumulativeRepo.selectListLastYearPn(new { YearlyYear = planYearCf.YearCfYear, OrgCompanySeq = planYearCf.OrgCompanySeq });
            // 2018.12.12 작년도 실적 요약 가져오는 항목 일부 변경
            var lastYearSummary2 = pmCashFlowCumulativeRepo.selectListLastYear(new { Year = planYearCf.YearCfYear, OrgCompanySeq = planYearCf.OrgCompanySeq });
            var thisYearSummary = planYearCfSummaryRepo.selectList(new { PlanYearCfSeq = entity.Seq });

            dynamic model = new ExpandoObject();
            model.planYearCf = planYearCf;
            model.orgCompanyName = orgCompanyName;
            model.lastYearSales = lastYearSales;
            model.thisYearSales = thisYearSales;
            model.lastYearInvestment = lastYearInvestment;
            model.thisYearInvestment = thisYearInvestment;
            model.lastYearFinancial = lastYearFinancial;
            model.thisYearFinancial = thisYearFinancial;
            model.lastYearFcf = lastYearFcf;
            model.lastYesaSales = lastYesaSales;
            model.thisYearFcf = thisYearFcf;
            model.lastYearBeCash = lastYearBeCash;
            model.thisYearBeCash = thisYearBeCash;
            model.lastYearSummary = lastYearSummary;
            model.thisYearSummary = thisYearSummary;
            model.lastYearSummary2 = lastYearSummary2;

            if (entity.message != null)
            {
                TempData["alert"] = entity.message;
            }

            ViewBag.Search = search;
            return View("~/Views/SiteMngHome/Plan/Year_Cf/Edit.cshtml", model);
        }

        [Route("Edit2")]
        public ActionResult Edit2(PlanYearCf entity, Search search)
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");

            // 중기CF - 기본데이터
            var planYearCf = planYearCfRepo.selectOne(entity);
            // 부문 > 회사 이름
            var orgCompanyName = orgCompanyRepo.selectOne(new { Seq = entity.OrgCompanySeq });
            
            var lastYearSummary = pmCashFlowCumulativeRepo.selectListLastYearPn(new { YearlyYear = planYearCf.YearCfYear, OrgCompanySeq = planYearCf.OrgCompanySeq });
            // 2018.12.12 작년도 실적 요약 가져오는 항목 일부 변경
            var lastYearSummary2 = pmCashFlowCumulativeRepo.selectListLastYear(new { Year = planYearCf.YearCfYear, OrgCompanySeq = planYearCf.OrgCompanySeq });
            var thisYearSummary = planYearCfSummaryRepo.selectList(new { PlanYearCfSeq = entity.Seq });

            dynamic model = new ExpandoObject();
            model.planYearCf = planYearCf;
            model.orgCompanyName = orgCompanyName;

            model.lastYearSummary = lastYearSummary;
            model.thisYearSummary = thisYearSummary;
            model.lastYearSummary2 = lastYearSummary2;

            if (entity.message != null)
            {
                TempData["alert"] = entity.message;
            }

            ViewBag.Search = search;
            return View("~/Views/SiteMngHome/Plan/Year_Cf/Edit2.cshtml", model);
        }

        [Route("Edit_Action")]
        public ActionResult EditAction(PlanYearCfAdmin entity, Search search)
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");

            #region
            Dictionary<string, object> postData = new Dictionary<string, object>();
            postData.Add("Seq", entity.Seq);
            postData.Add("OrgCompanySeq", entity.OrgCompanySeq);
            postData.Add("message", Message.MSG_007_A);
            postData.Add("PageIndex", search.PageIndex);
            #endregion

            // 영업활동, 투자활동, 재무활동, FCF, 기초기말현금, 요약 저장
            bool bDoubleValue = true;

            List<PlanYearCfSales> pSalesList = new List<PlanYearCfSales>();
            List<PlanYearCfInvestment> pInvestmentList = new List<PlanYearCfInvestment>();
            List<PlanYearCfFinancial> pFinancialList = new List<PlanYearCfFinancial>();
            List<PlanYearCfFcf> pFcfList = new List<PlanYearCfFcf>();
            List<PlanYearCfBeCash> pBeCashList = new List<PlanYearCfBeCash>();
            List<PlanYearCfSummary> pSummaryList = new List<PlanYearCfSummary>();
            
            try
            {
                for (int i = 0; i < entity.PlanYearCfSalesSeq.Count(); i++)
                {
                    if (!WebUtil.CheckDecimalTwo(entity.OperationProfit[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.DepreciationCost[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.CorpTax[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.Ar[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.Inv[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.Ap[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.Etc[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.InterestExpense[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.InterestIncome[i].ToString())) { bDoubleValue = false; break; }

                    PlanYearCfSales p = new PlanYearCfSales();
                    p.Seq = entity.PlanYearCfSalesSeq[i];
                    p.OperationProfit = entity.OperationProfit[i];
                    p.DepreciationCost = entity.DepreciationCost[i];
                    p.CorpTax = entity.CorpTax[i];
                    p.Ar = entity.Ar[i];
                    p.Inv = entity.Inv[i];
                    p.Ap = entity.Ap[i];
                    p.Etc = entity.Etc[i];
                    p.InterestExpense = entity.InterestExpense[i];
                    p.InterestIncome = entity.InterestIncome[i];

                    pSalesList.Add(p);
                }

                for (int i = 0; i < entity.PlanYearCfInvestmentSeq.Count(); i++)
                {
                    if (!WebUtil.CheckDecimalTwo(entity.Assets[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.EquityInvestment[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.AssetsSale[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.InvestmentEtc[i].ToString())) { bDoubleValue = false; break; }

                    PlanYearCfInvestment p = new PlanYearCfInvestment();
                    p.Seq = entity.PlanYearCfInvestmentSeq[i];
                    p.Assets = entity.Assets[i];
                    p.EquityInvestment = entity.EquityInvestment[i];
                    p.AssetsSale = entity.AssetsSale[i];
                    p.Etc = entity.InvestmentEtc[i];

                    pInvestmentList.Add(p);
                }

                for (int i = 0; i < entity.PlanYearCfFinancialSeq.Count(); i++)
                {
                    if (!WebUtil.CheckDecimalTwo(entity.Allocation[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.Increase[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.Borrowing[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.Repayment[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.FinancialEtc[i].ToString())) { bDoubleValue = false; break; }

                    PlanYearCfFinancial p = new PlanYearCfFinancial();
                    p.Seq = entity.PlanYearCfFinancialSeq[i];
                    p.Allocation = entity.Allocation[i];
                    p.Increase = entity.Increase[i];
                    p.Borrowing = entity.Borrowing[i];
                    p.Repayment = entity.Repayment[i];
                    p.Etc = entity.FinancialEtc[i];

                    pFinancialList.Add(p);
                }

                for (int i = 0; i < entity.PlanYearCfFcfSeq.Count(); i++)
                {
                    if (!WebUtil.CheckDecimalTwo(entity.FcfSales[i].ToString())) { bDoubleValue = false; break; }

                    PlanYearCfFcf p = new PlanYearCfFcf();
                    p.Seq = entity.PlanYearCfFcfSeq[i];
                    p.FcfSales = entity.FcfSales[i];

                    pFcfList.Add(p);
                }

                for (int i = 0; i < entity.PlanYearCfBeCashSeq.Count(); i++)
                {
                    //if (!WebUtil.CheckDecimalTwo(entity.BasicCash[i].ToString())) { bDoubleValue = false; break; }
                    //if (!WebUtil.CheckDecimalTwo(entity.EndingCash[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.CreditLine[i].ToString())) { bDoubleValue = false; break; }
                    //if (!WebUtil.CheckDecimalTwo(entity.AvailableCash[i].ToString())) { bDoubleValue = false; break; }

                    PlanYearCfBeCash p = new PlanYearCfBeCash();
                    p.Seq = entity.PlanYearCfBeCashSeq[i];
                    p.CreditLine = entity.CreditLine[i];

                    pBeCashList.Add(p);
                }

                for (int i = 0; i < entity.PlanYearCfSummarySeq.Count(); i++)
                {
                    if (!WebUtil.CheckDecimalTwo(entity.SummaryCfSales[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.SummaryCfInvestment[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.SummaryCfFinancial[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.SummaryCfEndingCash[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.SummaryCfAvailableCash[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.SummaryFcf1[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.SummaryFcf2[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.SummaryFcf3[i].ToString())) { bDoubleValue = false; break; }

                    PlanYearCfSummary p = new PlanYearCfSummary();
                    p.Seq = entity.PlanYearCfSummarySeq[i];
                    p.CfSales = entity.SummaryCfSales[i];
                    p.CfInvestment = entity.SummaryCfInvestment[i];
                    p.CfFinancial = entity.SummaryCfFinancial[i];
                    p.CfEndingCash = entity.SummaryCfEndingCash[i];
                    p.CfAvailableCash = entity.SummaryCfAvailableCash[i];
                    p.Fcf1 = entity.SummaryFcf1[i];
                    p.Fcf2 = entity.SummaryFcf2[i];
                    p.Fcf3 = entity.SummaryFcf3[i];

                    pSummaryList.Add(p);
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
            foreach (var item in pSalesList)
            {
                planYearCfSalesRepo.update(item);
            }
            foreach (var item in pInvestmentList)
            {
                planYearCfInvestmentRepo.update(item);
            }
            foreach (var item in pFinancialList)
            {
                planYearCfFinancialRepo.update(item);
            }
            foreach (var item in pFcfList)
            {
                planYearCfFcfRepo.update2(item);
            }
            foreach (var item in pBeCashList)
            {
                planYearCfBeCashRepo.updateCum(item);
            }
            foreach (var item in pSummaryList)
            {
                planYearCfSummaryRepo.update(item);
            }

            // 미저장에서 저장으로 변경
            if (entity.RegistStatus == Define.REGIST_STATUS.GetKey("미등록"))
            {
                entity.RegistStatus = Define.REGIST_STATUS.GetKey("저장");
                PlanYearCf p = new PlanYearCf();
                p.Seq = entity.Seq;
                p.RegistStatus = entity.RegistStatus;
                planYearCfRepo.updateRegist(p);
            }

            return RedirectAndPostActionResult.RedirectAndPost("Edit", postData);
        }

        /// <summary>
        /// 승인요청, 승인, 반려등의 상태 변경
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        [Route("Regist_Status_Change")]
        public ActionResult RegistStatusChange(PlanYearCf entity, Search search)
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
            planYearCfRepo.updateRegist(entity);

            return RedirectToAction("List", search);
        }

        [Route("Excel_Down")]
        public ActionResult ExcelDown(PlanYearCf entity)
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");

            var planYearCf = planYearCfRepo.selectOne(entity);
            var orgCompanyName = orgCompanyRepo.selectOne(new { Seq = entity.OrgCompanySeq });

            var planSales = planYearCfSalesRepo.selectList(new { PlanYearCfSeq = entity.Seq }).ToList();
            var planInvestment = planYearCfInvestmentRepo.selectList(new { PlanYearCfSeq = entity.Seq }).ToList();
            var planFinancial = planYearCfFinancialRepo.selectList(new { PlanYearCfSeq = entity.Seq }).ToList();

            string fileName = "중기CF" + planYearCf.YearCfYear + "년_" + orgCompanyName.CompanyName;

            int rows = 1, cells = 1;

            using (XLWorkbook wb = new XLWorkbook())
            {
                var wsSales = wb.Worksheets.Add("영업활동");

                // 컬럼 숨기기
                wsSales.Column(1).Hide();
                wsSales.Column(2).Hide();

                wsSales.Cell(rows, cells).SetValue("ParentSeq").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsSales.Cell(rows, ++cells).SetValue("Seq").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsSales.Cell(rows, ++cells).SetValue("년도").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsSales.Cell(rows, ++cells).SetValue("월").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsSales.Cell(rows, ++cells).SetValue("영업이익").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsSales.Cell(rows, ++cells).SetValue("감가비").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsSales.Cell(rows, ++cells).SetValue("법인세비용").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsSales.Cell(rows, ++cells).SetValue("AR변동").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsSales.Cell(rows, ++cells).SetValue("Inv변동").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsSales.Cell(rows, ++cells).SetValue("AP변동").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsSales.Cell(rows, ++cells).SetValue("기타(미지급금외)").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsSales.Cell(rows, ++cells).SetValue("이자비용").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsSales.Cell(rows, ++cells).SetValue("이자수익").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                foreach (var item in planSales)
                {
                    rows++;
                    cells = 1;
                    wsSales.Cell(rows, cells).SetValue(item.PlanYearCfSeq).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsSales.Cell(rows, ++cells).SetValue(item.Seq).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsSales.Cell(rows, ++cells).SetValue(item.YearlyYear).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsSales.Cell(rows, ++cells).SetValue(item.Monthly).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsSales.Cell(rows, ++cells).SetValue(item.OperationProfit).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsSales.Cell(rows, ++cells).SetValue(item.DepreciationCost).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsSales.Cell(rows, ++cells).SetValue(item.CorpTax).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsSales.Cell(rows, ++cells).SetValue(item.Ar).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsSales.Cell(rows, ++cells).SetValue(item.Inv).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsSales.Cell(rows, ++cells).SetValue(item.Ap).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsSales.Cell(rows, ++cells).SetValue(item.Etc).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsSales.Cell(rows, ++cells).SetValue(item.InterestExpense).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsSales.Cell(rows, ++cells).SetValue(item.InterestIncome).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                }

                rows = 1;
                cells = 1;
                var wsInvestment = wb.Worksheets.Add("투자활동");

                // 컬럼 숨기기
                wsInvestment.Column(1).Hide();
                wsInvestment.Column(2).Hide();

                wsInvestment.Cell(rows, cells).SetValue("ParentSeq").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsInvestment.Cell(rows, ++cells).SetValue("Seq").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsInvestment.Cell(rows, ++cells).SetValue("년도").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsInvestment.Cell(rows, ++cells).SetValue("월").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsInvestment.Cell(rows, ++cells).SetValue("유형/무형자산").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsInvestment.Cell(rows, ++cells).SetValue("지분투자").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsInvestment.Cell(rows, ++cells).SetValue("자산매각").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsInvestment.Cell(rows, ++cells).SetValue("기타").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                foreach (var item in planInvestment)
                {
                    rows++;
                    cells = 1;
                    wsInvestment.Cell(rows, cells).SetValue(item.PlanYearCfSeq).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsInvestment.Cell(rows, ++cells).SetValue(item.Seq).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsInvestment.Cell(rows, ++cells).SetValue(item.YearlyYear).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsInvestment.Cell(rows, ++cells).SetValue(item.Monthly).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsInvestment.Cell(rows, ++cells).SetValue(item.Assets).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsInvestment.Cell(rows, ++cells).SetValue(item.EquityInvestment).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsInvestment.Cell(rows, ++cells).SetValue(item.AssetsSale).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsInvestment.Cell(rows, ++cells).SetValue(item.Etc).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                }
                
                rows = 1;
                cells = 1;
                var wsFinancial = wb.Worksheets.Add("재무활동");

                // 컬럼 숨기기
                wsFinancial.Column(1).Hide();
                wsFinancial.Column(2).Hide();

                wsFinancial.Cell(rows, cells).SetValue("ParentSeq").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsFinancial.Cell(rows, ++cells).SetValue("Seq").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsFinancial.Cell(rows, ++cells).SetValue("년도").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsFinancial.Cell(rows, ++cells).SetValue("월").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsFinancial.Cell(rows, ++cells).SetValue("배당").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsFinancial.Cell(rows, ++cells).SetValue("증자").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsFinancial.Cell(rows, ++cells).SetValue("차입").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsFinancial.Cell(rows, ++cells).SetValue("상환").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsFinancial.Cell(rows, ++cells).SetValue("기타").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                foreach (var item in planFinancial)
                {
                    rows++;
                    cells = 1;
                    wsFinancial.Cell(rows, cells).SetValue(item.PlanYearCfSeq).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsFinancial.Cell(rows, ++cells).SetValue(item.Seq).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsFinancial.Cell(rows, ++cells).SetValue(item.YearlyYear).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsFinancial.Cell(rows, ++cells).SetValue(item.Monthly).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsFinancial.Cell(rows, ++cells).SetValue(item.Allocation).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsFinancial.Cell(rows, ++cells).SetValue(item.Increase).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsFinancial.Cell(rows, ++cells).SetValue(item.Borrowing).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsFinancial.Cell(rows, ++cells).SetValue(item.Repayment).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsFinancial.Cell(rows, ++cells).SetValue(item.Etc).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
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
        public ActionResult ExcelDown2(PlanYearCf entity)
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");

            var planYearCf = planYearCfRepo.selectOne(entity);
            var orgCompanyName = orgCompanyRepo.selectOne(new { Seq = entity.OrgCompanySeq });

            var planSales = planYearCfSalesRepo.selectList(new { PlanYearCfSeq = entity.Seq }).ToList();
            var planInvestment = planYearCfInvestmentRepo.selectList(new { PlanYearCfSeq = entity.Seq }).ToList();
            var planFinancial = planYearCfFinancialRepo.selectList(new { PlanYearCfSeq = entity.Seq }).ToList();

            string fileName = "중기CF" + planYearCf.YearCfYear + "년_" + orgCompanyName.CompanyName;

            int rows = 1, cells = 1;

            using (XLWorkbook wb = new XLWorkbook())
            {
                var wsSales = wb.Worksheets.Add("영업활동");

                // 컬럼 숨기기
               // wsSales.Column(1).Hide();
                //wsSales.Column(2).Hide();

               // wsSales.Cell(rows, cells).SetValue("ParentSeq").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
               // wsSales.Cell(rows, ++cells).SetValue("Seq").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsSales.Cell(rows, cells).SetValue("년도").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsSales.Cell(rows, ++cells).SetValue("월").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsSales.Cell(rows, ++cells).SetValue("영업이익").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsSales.Cell(rows, ++cells).SetValue("감가비").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsSales.Cell(rows, ++cells).SetValue("법인세비용").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsSales.Cell(rows, ++cells).SetValue("AR변동").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsSales.Cell(rows, ++cells).SetValue("Inv변동").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsSales.Cell(rows, ++cells).SetValue("AP변동").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsSales.Cell(rows, ++cells).SetValue("기타(미지급금외)").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsSales.Cell(rows, ++cells).SetValue("이자비용").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsSales.Cell(rows, ++cells).SetValue("이자수익").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                foreach (var item in planSales)
                {
                    rows++;
                    cells = 1;
                    //wsSales.Cell(rows, cells).SetValue(item.PlanYearCfSeq).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    //wsSales.Cell(rows, ++cells).SetValue(item.Seq).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsSales.Cell(rows, cells).SetValue(item.YearlyYear).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsSales.Cell(rows, ++cells).SetValue(item.Monthly).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsSales.Cell(rows, ++cells).SetValue(item.OperationProfit).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsSales.Cell(rows, ++cells).SetValue(item.DepreciationCost).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsSales.Cell(rows, ++cells).SetValue(item.CorpTax).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsSales.Cell(rows, ++cells).SetValue(item.Ar).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsSales.Cell(rows, ++cells).SetValue(item.Inv).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsSales.Cell(rows, ++cells).SetValue(item.Ap).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsSales.Cell(rows, ++cells).SetValue(item.Etc).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsSales.Cell(rows, ++cells).SetValue(item.InterestExpense).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsSales.Cell(rows, ++cells).SetValue(item.InterestIncome).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                }

                rows = 1;
                cells = 1;
                var wsInvestment = wb.Worksheets.Add("투자활동");

                // 컬럼 숨기기
                //wsInvestment.Column(1).Hide();
                //wsInvestment.Column(2).Hide();

                //wsInvestment.Cell(rows, cells).SetValue("ParentSeq").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                //wsInvestment.Cell(rows, ++cells).SetValue("Seq").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsInvestment.Cell(rows, cells).SetValue("년도").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsInvestment.Cell(rows, ++cells).SetValue("월").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsInvestment.Cell(rows, ++cells).SetValue("유형/무형자산").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsInvestment.Cell(rows, ++cells).SetValue("지분투자").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsInvestment.Cell(rows, ++cells).SetValue("자산매각").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsInvestment.Cell(rows, ++cells).SetValue("기타").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                foreach (var item in planInvestment)
                {
                    rows++;
                    cells = 1;
                    //wsInvestment.Cell(rows, cells).SetValue(item.PlanYearCfSeq).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    //wsInvestment.Cell(rows, ++cells).SetValue(item.Seq).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsInvestment.Cell(rows, cells).SetValue(item.YearlyYear).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsInvestment.Cell(rows, ++cells).SetValue(item.Monthly).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsInvestment.Cell(rows, ++cells).SetValue(item.Assets).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsInvestment.Cell(rows, ++cells).SetValue(item.EquityInvestment).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsInvestment.Cell(rows, ++cells).SetValue(item.AssetsSale).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsInvestment.Cell(rows, ++cells).SetValue(item.Etc).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                }

                rows = 1;
                cells = 1;
                var wsFinancial = wb.Worksheets.Add("재무활동");

                // 컬럼 숨기기
                //wsFinancial.Column(1).Hide();
                //wsFinancial.Column(2).Hide();

               // wsFinancial.Cell(rows, cells).SetValue("ParentSeq").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                //wsFinancial.Cell(rows, ++cells).SetValue("Seq").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsFinancial.Cell(rows, cells).SetValue("년도").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsFinancial.Cell(rows, ++cells).SetValue("월").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsFinancial.Cell(rows, ++cells).SetValue("배당").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsFinancial.Cell(rows, ++cells).SetValue("증자").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsFinancial.Cell(rows, ++cells).SetValue("차입").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsFinancial.Cell(rows, ++cells).SetValue("상환").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsFinancial.Cell(rows, ++cells).SetValue("기타").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                foreach (var item in planFinancial)
                {
                    rows++;
                    cells = 1;
                   // wsFinancial.Cell(rows, cells).SetValue(item.PlanYearCfSeq).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    //wsFinancial.Cell(rows, ++cells).SetValue(item.Seq).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsFinancial.Cell(rows, cells).SetValue(item.YearlyYear).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsFinancial.Cell(rows, ++cells).SetValue(item.Monthly).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsFinancial.Cell(rows, ++cells).SetValue(item.Allocation).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsFinancial.Cell(rows, ++cells).SetValue(item.Increase).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsFinancial.Cell(rows, ++cells).SetValue(item.Borrowing).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsFinancial.Cell(rows, ++cells).SetValue(item.Repayment).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsFinancial.Cell(rows, ++cells).SetValue(item.Etc).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
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

            if(ExcelFile.ContentLength!=0)
            {
                FileUtil fileUtil = new FileUtil(Define.FILE_PATH);
                string filePath = "PlanYearCf";
                var file = fileUtil.FileUpload(ExcelFile, filePath);

                bool bDoubleValue = true;
                ExcelUtil excelUtil = new ExcelUtil();
                var ds = excelUtil.ImportExcelDs(file["FILE_PATH"]);

                List<PlanYearCfSales> pSalesList = new List<PlanYearCfSales>();
                List<PlanYearCfInvestment> pInvestmentList = new List<PlanYearCfInvestment>();
                List<PlanYearCfFinancial> pFinancialList = new List<PlanYearCfFinancial>();

                try
                {
                    // 다운받은 sheet 이름으로 체크 한다.
                    if (ds.Tables["영업활동"] == null || ds.Tables["영업활동"].Rows.Count == 0)
                    {
                        // 오류시 파일 삭제
                        fileUtil.FileDelete(filePath, file["STORED_FILE_NAME"]);
                        result = false;
                        resultMsg = Message.MSG_007_E;
                        return Json(new { success = result, resultMsg = resultMsg }, JsonRequestBehavior.AllowGet);
                    }
                    if (ds.Tables["투자활동"] == null || ds.Tables["투자활동"].Rows.Count == 0)
                    {
                        // 오류시 파일 삭제
                        fileUtil.FileDelete(filePath, file["STORED_FILE_NAME"]);
                        result = false;
                        resultMsg = Message.MSG_007_E;
                        return Json(new { success = result, resultMsg = resultMsg }, JsonRequestBehavior.AllowGet);
                    }
                    if (ds.Tables["재무활동"] == null || ds.Tables["재무활동"].Rows.Count == 0)
                    {
                        // 오류시 파일 삭제
                        fileUtil.FileDelete(filePath, file["STORED_FILE_NAME"]);
                        result = false;
                        resultMsg = Message.MSG_007_E;
                        return Json(new { success = result, resultMsg = resultMsg }, JsonRequestBehavior.AllowGet);
                    }

                    foreach (DataRow item in ds.Tables["영업활동"].Rows)
                    {
                        string parentSeq = item.ItemArray.GetValue(0).ToString();
                        string excelSeq = item.ItemArray.GetValue(1).ToString();
                        string yearlyYear = item.ItemArray.GetValue(2).ToString();
                        string monthly = item.ItemArray.GetValue(3).ToString();

                        string OperationProfit = item.ItemArray.GetValue(4).ToString();
                        string DepreciationCost = item.ItemArray.GetValue(5).ToString();
                        string CorpTax = item.ItemArray.GetValue(6).ToString();
                        string Ar = item.ItemArray.GetValue(7).ToString();
                        string Inv = item.ItemArray.GetValue(8).ToString();
                        string Ap = item.ItemArray.GetValue(9).ToString();
                        string Etc = item.ItemArray.GetValue(10).ToString();
                        string InterestExpense = item.ItemArray.GetValue(11).ToString();
                        string InterestIncome = item.ItemArray.GetValue(12).ToString();

                        if (parentSeq != Seq.ToString()) { bDoubleValue = false; break; }       // 현재 코드와 업로드하려는 코드가 다른 경우는 양식이 잘못된것으로 오류
                        //if (!WebUtil.CheckDecimalTwo(OperationProfit)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(DepreciationCost)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(CorpTax)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(Ar)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(Inv)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(Ap)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(Etc)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(InterestExpense)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(InterestIncome)) { bDoubleValue = false; break; }

                        PlanYearCfSales p = new PlanYearCfSales();
                        p.Seq = Convert.ToInt32(excelSeq);
                        p.OperationProfit = Convert.ToDecimal(OperationProfit);
                        p.DepreciationCost = Convert.ToDecimal(DepreciationCost);
                        p.CorpTax = Convert.ToDecimal(CorpTax);
                        p.Ar = Convert.ToDecimal(Ar);
                        p.Inv = Convert.ToDecimal(Inv);
                        p.Ap = Convert.ToDecimal(Ap);
                        p.Etc = Convert.ToDecimal(Etc);
                        p.InterestExpense = Convert.ToDecimal(InterestExpense);
                        p.InterestIncome = Convert.ToDecimal(InterestIncome);
                        pSalesList.Add(p);
                    }

                    if (!bDoubleValue)
                    {
                        // 오류시 파일 삭제
                        fileUtil.FileDelete(filePath, file["STORED_FILE_NAME"]);
                        result = false;
                        resultMsg = Message.MSG_007_E;
                        return Json(new { success = result, resultMsg = resultMsg }, JsonRequestBehavior.AllowGet);
                    }

                    foreach (DataRow item in ds.Tables["투자활동"].Rows)
                    {
                        string parentSeq = item.ItemArray.GetValue(0).ToString();
                        string excelSeq = item.ItemArray.GetValue(1).ToString();
                        string yearlyYear = item.ItemArray.GetValue(2).ToString();
                        string monthly = item.ItemArray.GetValue(3).ToString();

                        string Assets = item.ItemArray.GetValue(4).ToString();
                        string EquityInvestment = item.ItemArray.GetValue(5).ToString();
                        string AssetsSale = item.ItemArray.GetValue(6).ToString();
                        string Etc = item.ItemArray.GetValue(7).ToString();

                        if (parentSeq != Seq.ToString()) { bDoubleValue = false; break; }       // 현재 코드와 업로드하려는 코드가 다른 경우는 양식이 잘못된것으로 오류
                        //if (!WebUtil.CheckDecimalTwo(Assets)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(EquityInvestment)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(AssetsSale)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(Etc)) { bDoubleValue = false; break; }

                        PlanYearCfInvestment p = new PlanYearCfInvestment();
                        p.Seq = Convert.ToInt32(excelSeq);
                        p.Assets = Convert.ToDecimal(Assets);
                        p.EquityInvestment = Convert.ToDecimal(EquityInvestment);
                        p.AssetsSale = Convert.ToDecimal(AssetsSale);
                        p.Etc = Convert.ToDecimal(Etc);

                        pInvestmentList.Add(p);
                    }
                    
                    if (!bDoubleValue)
                    {
                        // 오류시 파일 삭제
                        fileUtil.FileDelete(filePath, file["STORED_FILE_NAME"]);
                        result = false;
                        resultMsg = Message.MSG_007_E;
                        return Json(new { success = result, resultMsg = resultMsg }, JsonRequestBehavior.AllowGet);
                    }

                    foreach (DataRow item in ds.Tables["재무활동"].Rows)
                    {
                        string parentSeq = item.ItemArray.GetValue(0).ToString();
                        string excelSeq = item.ItemArray.GetValue(1).ToString();
                        string yearlyYear = item.ItemArray.GetValue(2).ToString();
                        string monthly = item.ItemArray.GetValue(3).ToString();

                        string Allocation = item.ItemArray.GetValue(4).ToString();
                        string Increase = item.ItemArray.GetValue(5).ToString();
                        string Borrowing = item.ItemArray.GetValue(6).ToString();
                        string Repayment = item.ItemArray.GetValue(7).ToString();
                        string Etc = item.ItemArray.GetValue(8).ToString();

                        if (parentSeq != Seq.ToString()) { bDoubleValue = false; break; }       // 현재 코드와 업로드하려는 코드가 다른 경우는 양식이 잘못된것으로 오류
                        //if (!WebUtil.CheckDecimalTwo(Allocation)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(Increase)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(Borrowing)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(Repayment)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(Etc)) { bDoubleValue = false; break; }

                        PlanYearCfFinancial p = new PlanYearCfFinancial();
                        p.Seq = Convert.ToInt32(excelSeq);
                        p.Allocation = Convert.ToDecimal(Allocation);
                        p.Increase = Convert.ToDecimal(Increase);
                        p.Borrowing = Convert.ToDecimal(Borrowing);
                        p.Repayment = Convert.ToDecimal(Repayment);
                        p.Etc = Convert.ToDecimal(Etc);

                        pFinancialList.Add(p);
                    }

                    if (!bDoubleValue)
                    {
                        // 오류시 파일 삭제
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
                    planYearCfSalesRepo.update(item);
                }
                foreach (var item in pInvestmentList)
                {
                    planYearCfInvestmentRepo.update(item);
                }
                foreach (var item in pFinancialList)
                {
                    planYearCfFinancialRepo.update(item);
                }

                // 업데이트 완료 후 로그 남기기
                ExcelFileUploadList eFileList = new ExcelFileUploadList();
                eFileList.UserKey = SessionManager.GetAdminSession().insaUserV.userKey;
                eFileList.EmpNo = SessionManager.GetAdminSession().insaUserV.empNo;
                eFileList.AttachTableName = "PLAN_YEAR_CF";
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
                                         , List<int> PlanYearCfSalesSeq
                                        , List<int> PlanYearCfInvestmentSeq
                                        , List<int> PlanYearCfFinancialSeq 
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
                string filePath = "PlanYearCf";
                var file = fileUtil.FileUpload(ExcelFile, filePath);

                bool bDoubleValue = true;
                ExcelUtil excelUtil = new ExcelUtil();
                var ds = excelUtil.ImportExcelDs(file["FILE_PATH"]);

                List<PlanYearCfSales> pSalesList = new List<PlanYearCfSales>();
                List<PlanYearCfInvestment> pInvestmentList = new List<PlanYearCfInvestment>();
                List<PlanYearCfFinancial> pFinancialList = new List<PlanYearCfFinancial>();

                try
                {
                    // 다운받은 sheet 이름으로 체크 한다.
                    if (ds.Tables["영업활동"] == null || ds.Tables["영업활동"].Rows.Count == 0)
                    {
                        // 오류시 파일 삭제
                        fileUtil.FileDelete(filePath, file["STORED_FILE_NAME"]);
                        result = false;
                        resultMsg = Message.MSG_007_E;
                        return Json(new { success = result, resultMsg = resultMsg }, JsonRequestBehavior.AllowGet);
                    }
                    if (ds.Tables["투자활동"] == null || ds.Tables["투자활동"].Rows.Count == 0)
                    {
                        // 오류시 파일 삭제
                        fileUtil.FileDelete(filePath, file["STORED_FILE_NAME"]);
                        result = false;
                        resultMsg = Message.MSG_007_E;
                        return Json(new { success = result, resultMsg = resultMsg }, JsonRequestBehavior.AllowGet);
                    }
                    if (ds.Tables["재무활동"] == null || ds.Tables["재무활동"].Rows.Count == 0)
                    {
                        // 오류시 파일 삭제
                        fileUtil.FileDelete(filePath, file["STORED_FILE_NAME"]);
                        result = false;
                        resultMsg = Message.MSG_007_E;
                        return Json(new { success = result, resultMsg = resultMsg }, JsonRequestBehavior.AllowGet);
                    }

                    int j = 0;
                    foreach (DataRow item in ds.Tables["영업활동"].Rows)
                    {
                        //string parentSeq = item.ItemArray.GetValue(0).ToString();
                        string excelSeq = PlanYearCfSalesSeq[j].ToString();

                        string OperationProfit = item.ItemArray.GetValue(2).ToString();
                        string DepreciationCost = item.ItemArray.GetValue(3).ToString();
                        string CorpTax = item.ItemArray.GetValue(4).ToString();
                        string Ar = item.ItemArray.GetValue(5).ToString();
                        string Inv = item.ItemArray.GetValue(6).ToString();
                        string Ap = item.ItemArray.GetValue(7).ToString();
                        string Etc = item.ItemArray.GetValue(8).ToString();
                        string InterestExpense = item.ItemArray.GetValue(9).ToString();
                        string InterestIncome = item.ItemArray.GetValue(10).ToString();
                        //string yearlyYear = item.ItemArray.GetValue(2).ToString();
                        // string monthly = item.ItemArray.GetValue(3).ToString();

                        //string OperationProfit = item.ItemArray.GetValue(4).ToString();
                        //string DepreciationCost = item.ItemArray.GetValue(5).ToString();
                        //string CorpTax = item.ItemArray.GetValue(6).ToString();
                        //string Ar = item.ItemArray.GetValue(7).ToString();
                        //string Inv = item.ItemArray.GetValue(8).ToString();
                        //string Ap = item.ItemArray.GetValue(9).ToString();
                        //string Etc = item.ItemArray.GetValue(10).ToString();
                        //string InterestExpense = item.ItemArray.GetValue(11).ToString();
                        //string InterestIncome = item.ItemArray.GetValue(12).ToString();

                        // if (parentSeq != Seq.ToString()) { bDoubleValue = false; break; }       // 현재 코드와 업로드하려는 코드가 다른 경우는 양식이 잘못된것으로 오류
                        //if (!WebUtil.CheckDecimalTwo(OperationProfit)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(DepreciationCost)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(CorpTax)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(Ar)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(Inv)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(Ap)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(Etc)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(InterestExpense)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(InterestIncome)) { bDoubleValue = false; break; }

                        PlanYearCfSales p = new PlanYearCfSales();
                        p.Seq = Convert.ToInt32(excelSeq);
                        p.OperationProfit = Convert.ToDecimal(OperationProfit);
                        p.DepreciationCost = Convert.ToDecimal(DepreciationCost);
                        p.CorpTax = Convert.ToDecimal(CorpTax);
                        p.Ar = Convert.ToDecimal(Ar);
                        p.Inv = Convert.ToDecimal(Inv);
                        p.Ap = Convert.ToDecimal(Ap);
                        p.Etc = Convert.ToDecimal(Etc);
                        p.InterestExpense = Convert.ToDecimal(InterestExpense);
                        p.InterestIncome = Convert.ToDecimal(InterestIncome);
                        pSalesList.Add(p);
                        j += 1;
                    }

                    if (!bDoubleValue)
                    {
                        // 오류시 파일 삭제
                        fileUtil.FileDelete(filePath, file["STORED_FILE_NAME"]);
                        result = false;
                        resultMsg = Message.MSG_007_E;
                        return Json(new { success = result, resultMsg = resultMsg }, JsonRequestBehavior.AllowGet);
                    }

                    j = 0;
                    foreach (DataRow item in ds.Tables["투자활동"].Rows)
                    {
                        //string parentSeq = item.ItemArray.GetValue(0).ToString();
                        string excelSeq = PlanYearCfInvestmentSeq[j].ToString();

                        string Assets = item.ItemArray.GetValue(2).ToString();
                        string EquityInvestment = item.ItemArray.GetValue(3).ToString();
                        string AssetsSale = item.ItemArray.GetValue(4).ToString();
                        string Etc = item.ItemArray.GetValue(5).ToString();
                        //string yearlyYear = item.ItemArray.GetValue(2).ToString();
                        // string monthly = item.ItemArray.GetValue(3).ToString();

                        //string Assets = item.ItemArray.GetValue(4).ToString();
                        //string EquityInvestment = item.ItemArray.GetValue(5).ToString();
                        //string AssetsSale = item.ItemArray.GetValue(6).ToString();
                        //string Etc = item.ItemArray.GetValue(7).ToString();

                        //if (parentSeq != Seq.ToString()) { bDoubleValue = false; break; }       // 현재 코드와 업로드하려는 코드가 다른 경우는 양식이 잘못된것으로 오류
                        //if (!WebUtil.CheckDecimalTwo(Assets)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(EquityInvestment)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(AssetsSale)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(Etc)) { bDoubleValue = false; break; }

                        PlanYearCfInvestment p = new PlanYearCfInvestment();
                        p.Seq = Convert.ToInt32(excelSeq);
                        p.Assets = Convert.ToDecimal(Assets);
                        p.EquityInvestment = Convert.ToDecimal(EquityInvestment);
                        p.AssetsSale = Convert.ToDecimal(AssetsSale);
                        p.Etc = Convert.ToDecimal(Etc);

                        pInvestmentList.Add(p);
                        j += 1;
                    }

                    if (!bDoubleValue)
                    {
                        // 오류시 파일 삭제
                        fileUtil.FileDelete(filePath, file["STORED_FILE_NAME"]);
                        result = false;
                        resultMsg = Message.MSG_007_E;
                        return Json(new { success = result, resultMsg = resultMsg }, JsonRequestBehavior.AllowGet);
                    }

                    j = 0;
                    foreach (DataRow item in ds.Tables["재무활동"].Rows)
                    {
                        //string parentSeq = item.ItemArray.GetValue(0).ToString();
                        string excelSeq = PlanYearCfFinancialSeq[j].ToString();

                        string Allocation = item.ItemArray.GetValue(2).ToString();
                        string Increase = item.ItemArray.GetValue(3).ToString();
                        string Borrowing = item.ItemArray.GetValue(4).ToString();
                        string Repayment = item.ItemArray.GetValue(5).ToString();
                        string Etc = item.ItemArray.GetValue(6).ToString();

                        //string yearlyYear = item.ItemArray.GetValue(2).ToString();
                        //string monthly = item.ItemArray.GetValue(3).ToString();

                        //string Allocation = item.ItemArray.GetValue(4).ToString();
                        //string Increase = item.ItemArray.GetValue(5).ToString();
                        //string Borrowing = item.ItemArray.GetValue(6).ToString();
                        //string Repayment = item.ItemArray.GetValue(7).ToString();
                        //string Etc = item.ItemArray.GetValue(8).ToString();

                        //if (parentSeq != Seq.ToString()) { bDoubleValue = false; break; }       // 현재 코드와 업로드하려는 코드가 다른 경우는 양식이 잘못된것으로 오류
                        //if (!WebUtil.CheckDecimalTwo(Allocation)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(Increase)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(Borrowing)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(Repayment)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(Etc)) { bDoubleValue = false; break; }

                        PlanYearCfFinancial p = new PlanYearCfFinancial();
                        p.Seq = Convert.ToInt32(excelSeq);
                        p.Allocation = Convert.ToDecimal(Allocation);
                        p.Increase = Convert.ToDecimal(Increase);
                        p.Borrowing = Convert.ToDecimal(Borrowing);
                        p.Repayment = Convert.ToDecimal(Repayment);
                        p.Etc = Convert.ToDecimal(Etc);

                        pFinancialList.Add(p);
                        j += 1;
                    }

                    if (!bDoubleValue)
                    {
                        // 오류시 파일 삭제
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
                    planYearCfSalesRepo.update(item);
                }
                foreach (var item in pInvestmentList)
                {
                    planYearCfInvestmentRepo.update(item);
                }
                foreach (var item in pFinancialList)
                {
                    planYearCfFinancialRepo.update(item);
                }

                // 업데이트 완료 후 로그 남기기
                ExcelFileUploadList eFileList = new ExcelFileUploadList();
                eFileList.UserKey = SessionManager.GetAdminSession().insaUserV.userKey;
                eFileList.EmpNo = SessionManager.GetAdminSession().insaUserV.empNo;
                eFileList.AttachTableName = "PLAN_YEAR_CF";
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