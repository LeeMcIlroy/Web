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
    [RoutePrefix("SiteMngHome/Performance/Cash_Flow")]
    public class PmCashFlowController : SiteMngBaseController
    {
        [Route("List")]
        public ActionResult List(Search search)
        {
            dynamic model = new ExpandoObject();
            search.AuthUserKey = SessionManager.GetAdminSession().insaUserV.userKey;
            model.list = pmCashFlowRepo.selectList(search);
            model.UnionList = orgUnionRepo.selectList(new { });
            model.OrgCpyList = orgCompanyRepo.selectList(null);
            ViewBag.Search = search;              

            return View("~/Views/SiteMngHome/Performance/Cash_Flow/List.cshtml", model);
        }

        [Route("Write")]
        public ActionResult Write(PmCashFlow entity, Search search)
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");

            // 기본데이터
            var pmCashFlow = pmCashFlowRepo.selectOne(entity);
            // 부문 > 회사 이름
            var orgCompanyName = orgCompanyRepo.selectOne(new { Seq = entity.OrgCompanySeq });


            foreach (var item in Define.CUMULATIVE)
            {
                // 영업활동
                PmCashFlowSales pSales = new PmCashFlowSales();
                pSales.PmCashFlowSeq = entity.Seq;
                pSales.Cumulative = item.Key;
                pSales.OperationProfit = 0;
                pSales.DepreciationCost = 0;
                pSales.CorpTax = 0;
                pSales.Ar = 0;
                pSales.Inv = 0;
                pSales.Ap = 0;
                pSales.Etc = 0;
                pSales.InterestExpense = 0;
                pSales.InterestIncome = 0;

                string where = " WHERE PM_CASH_FLOW_SEQ = @PmCashFlowSeq AND CUMULATIVE = @Cumulative ";
                if (pmCashFlowSalesRepo.count(pSales, where) == 0) pmCashFlowSalesRepo.insert(pSales);

                // 투자활동
                PmCashFlowInvestment pInvestment = new PmCashFlowInvestment();
                pInvestment.PmCashFlowSeq = entity.Seq;
                pInvestment.Cumulative = item.Key;
                pInvestment.Assets = 0;
                pInvestment.EquityInvestment = 0;
                pInvestment.AssetsSale = 0;
                pInvestment.InvestmentEtc = 0;

                if (pmCashFlowInvestmentRepo.count(pInvestment, where) == 0) pmCashFlowInvestmentRepo.insert(pInvestment);

                // 재무활동
                PmCashFlowFinancial pFinancial = new PmCashFlowFinancial();
                pFinancial.PmCashFlowSeq = entity.Seq;
                pFinancial.Cumulative = item.Key;
                pFinancial.Allocation = 0;
                pFinancial.Increase = 0;
                pFinancial.Borrowing = 0;
                pFinancial.Repayment = 0;
                pFinancial.Etc = 0;

                if (pmCashFlowFinancialRepo.count(pFinancial, where) == 0) pmCashFlowFinancialRepo.insert(pFinancial);
            }

            // 상세데이터 가져오기
            var pnSales = planYearCfSalesRepo.selectListYear(new { YearCfYear = pmCashFlow.CashFlowYear, OrgCompanySeq = pmCashFlow.OrgCompanySeq }).ToList();
            var pnInvestment = planYearCfInvestmentRepo.selectListYear(new { YearCfYear = pmCashFlow.CashFlowYear, OrgCompanySeq = pmCashFlow.OrgCompanySeq }).ToList();
            var pnFinancial = planYearCfFinancialRepo.selectListYear(new { YearCfYear = pmCashFlow.CashFlowYear, OrgCompanySeq = pmCashFlow.OrgCompanySeq }).ToList();
            var pnFcf = planYearCfFcfRepo.selectListYear(new { YearCfYear = pmCashFlow.CashFlowYear, OrgCompanySeq = pmCashFlow.OrgCompanySeq }).ToList();
            var pnBeCash = planYearCfBeCashRepo.selectListYear(new { YearCfYear = pmCashFlow.CashFlowYear, OrgCompanySeq = pmCashFlow.OrgCompanySeq }).ToList();
            // 계산하기에서 Sales를 계산하기에 따로 가져올 필요는 없을듯
            //var pnPalSales = planMonthlyPalBusinessMonthlySumRepo.selectListYear(new { MonthlyPalYear = pmCashFlow.CashFlowYear, OrgCompanySeq = pmCashFlow.OrgCompanySeq }).ToList();


            var pmSales = pmCashFlowSalesRepo.selectList(new { PmCashFlowSeq = entity.Seq }).ToList();
            var pmInvestment = pmCashFlowInvestmentRepo.selectList(new { PmCashFlowSeq = entity.Seq }).ToList();
            var pmFinancial = pmCashFlowFinancialRepo.selectList(new { PmCashFlowSeq = entity.Seq }).ToList();
            var pmFcf = pmCashFlowFcfRepo.selectList(new { PmCashFlowSeq = entity.Seq }).ToList();
            var pmBeCash = pmCashFlowBeCashRepo.selectList(new { PmCashFlowSeq = entity.Seq }).ToList();
            //var pmPalSales = pmPalSummaryRepo.selectListYear(new { PalYear = pmCashFlow.CashFlowYear , Monthly = pmCashFlow.Monthly, OrgCompanySeq = pmCashFlow.OrgCompanySeq}).ToList();

            dynamic model = new ExpandoObject();
            model.pmCashFlow = pmCashFlow;
            model.orgCompanyName = orgCompanyName;

            model.pnSales = pnSales;
            model.pnInvestment = pnInvestment;
            model.pnFinancial = pnFinancial;
            model.pnFcf = pnFcf;
            //model.pnPalSales = pnPalSales;
            model.pnBeCash = pnBeCash;

            model.pmSales = pmSales;
            model.pmInvestment = pmInvestment;
            model.pmFinancial = pmFinancial;
            model.pmFcf = pmFcf;
            //model.pmPalSales = pmPalSales;
            model.pmBeCash = pmBeCash;

            ViewBag.Search = search;
            return View("~/Views/SiteMngHome/Performance/Cash_Flow/Write.cshtml", model);
        }

        [Route("Excel_Down")]
        public ActionResult ExcelDown(PmCashFlow entity)
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");

            // 기본데이터
            var pmCashFlow = pmCashFlowRepo.selectOne(entity);
            // 부문 > 회사 이름
            var orgCompanyName = orgCompanyRepo.selectOne(new { Seq = entity.OrgCompanySeq });

            var pmSales = pmCashFlowSalesRepo.selectList(new { PmCashFlowSeq = entity.Seq }).ToList();
            var pmInvestment = pmCashFlowInvestmentRepo.selectList(new { PmCashFlowSeq = entity.Seq }).ToList();
            var pmFinancial = pmCashFlowFinancialRepo.selectList(new { PmCashFlowSeq = entity.Seq }).ToList();

            string fileName = "Cash Flow_" + pmCashFlow.CashFlowYear + "년_" + orgCompanyName.CompanyName;

            int rows = 1, cells = 1;

            using (XLWorkbook wb = new XLWorkbook())
            {
                var wsSales = wb.Worksheets.Add("영업활동");

                // 컬럼 숨기기
                wsSales.Column(1).Hide();
                wsSales.Column(2).Hide();
                wsSales.Column(5).Hide();

                wsSales.Cell(rows, cells).SetValue("ParentSeq").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsSales.Cell(rows, ++cells).SetValue("Seq").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                wsSales.Cell(rows, ++cells).SetValue("년도").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsSales.Cell(rows, ++cells).SetValue("월").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                wsSales.Cell(rows, ++cells).SetValue("누계여부코드").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsSales.Cell(rows, ++cells).SetValue("누계여부").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                wsSales.Cell(rows, ++cells).SetValue("영업이익").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsSales.Cell(rows, ++cells).SetValue("감가비").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsSales.Cell(rows, ++cells).SetValue("법인세비용").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsSales.Cell(rows, ++cells).SetValue("AR변동").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsSales.Cell(rows, ++cells).SetValue("Inv변동").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsSales.Cell(rows, ++cells).SetValue("AP변동").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsSales.Cell(rows, ++cells).SetValue("기타(미지급금외)").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsSales.Cell(rows, ++cells).SetValue("이자비용").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsSales.Cell(rows, ++cells).SetValue("이자수익").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                foreach (var item in pmSales)
                {
                    rows++;
                    cells = 1;

                    wsSales.Cell(rows, cells).SetValue(item.PmCashFlowSeq).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsSales.Cell(rows, ++cells).SetValue(item.Seq).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                    wsSales.Cell(rows, ++cells).SetValue(pmCashFlow.CashFlowYear).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsSales.Cell(rows, ++cells).SetValue(pmCashFlow.Monthly).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                    wsSales.Cell(rows, ++cells).SetValue(item.Cumulative).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsSales.Cell(rows, ++cells).SetValue(Define.CUMULATIVE.GetValue(item.Cumulative)).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);

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
                wsInvestment.Column(5).Hide();

                wsInvestment.Cell(rows, cells).SetValue("ParentSeq").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsInvestment.Cell(rows, ++cells).SetValue("Seq").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                wsInvestment.Cell(rows, ++cells).SetValue("년도").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsInvestment.Cell(rows, ++cells).SetValue("월").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                wsInvestment.Cell(rows, ++cells).SetValue("누계여부코드").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsInvestment.Cell(rows, ++cells).SetValue("누계여부").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                wsInvestment.Cell(rows, ++cells).SetValue("유형/무형자산").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsInvestment.Cell(rows, ++cells).SetValue("지분투자").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsInvestment.Cell(rows, ++cells).SetValue("자산매각").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsInvestment.Cell(rows, ++cells).SetValue("기타").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                foreach (var item in pmInvestment)
                {
                    rows++;
                    cells = 1;

                    wsInvestment.Cell(rows, cells).SetValue(item.PmCashFlowSeq).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsInvestment.Cell(rows, ++cells).SetValue(item.Seq).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                    wsInvestment.Cell(rows, ++cells).SetValue(pmCashFlow.CashFlowYear).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsInvestment.Cell(rows, ++cells).SetValue(pmCashFlow.Monthly).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                    wsInvestment.Cell(rows, ++cells).SetValue(item.Cumulative).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsInvestment.Cell(rows, ++cells).SetValue(Define.CUMULATIVE.GetValue(item.Cumulative)).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                    wsInvestment.Cell(rows, ++cells).SetValue(item.Assets).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsInvestment.Cell(rows, ++cells).SetValue(item.EquityInvestment).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsInvestment.Cell(rows, ++cells).SetValue(item.AssetsSale).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsInvestment.Cell(rows, ++cells).SetValue(item.InvestmentEtc).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                }

                rows = 1;
                cells = 1;
                var wsFinancial = wb.Worksheets.Add("재무활동");

                // 컬럼 숨기기
                wsFinancial.Column(1).Hide();
                wsFinancial.Column(2).Hide();
                wsFinancial.Column(5).Hide();

                wsFinancial.Cell(rows, cells).SetValue("ParentSeq").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsFinancial.Cell(rows, ++cells).SetValue("Seq").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                wsFinancial.Cell(rows, ++cells).SetValue("년도").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsFinancial.Cell(rows, ++cells).SetValue("월").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                wsFinancial.Cell(rows, ++cells).SetValue("누계여부코드").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsFinancial.Cell(rows, ++cells).SetValue("누계여부").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                wsFinancial.Cell(rows, ++cells).SetValue("배당").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsFinancial.Cell(rows, ++cells).SetValue("증자").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsFinancial.Cell(rows, ++cells).SetValue("차입").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsFinancial.Cell(rows, ++cells).SetValue("상환").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsFinancial.Cell(rows, ++cells).SetValue("기타").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                foreach (var item in pmFinancial)
                {
                    rows++;
                    cells = 1;

                    wsFinancial.Cell(rows, cells).SetValue(item.PmCashFlowSeq).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsFinancial.Cell(rows, ++cells).SetValue(item.Seq).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                    wsFinancial.Cell(rows, ++cells).SetValue(pmCashFlow.CashFlowYear).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsFinancial.Cell(rows, ++cells).SetValue(pmCashFlow.Monthly).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                    wsFinancial.Cell(rows, ++cells).SetValue(item.Cumulative).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsFinancial.Cell(rows, ++cells).SetValue(Define.CUMULATIVE.GetValue(item.Cumulative)).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);

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
        }




        [Route("Excel_Down2")]
        public ActionResult ExcelDown2(PmCashFlow entity)
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");

            // 기본데이터
            var pmCashFlow = pmCashFlowRepo.selectOne(entity);
            // 부문 > 회사 이름
            var orgCompanyName = orgCompanyRepo.selectOne(new { Seq = entity.OrgCompanySeq });

            var pmSales = pmCashFlowSalesRepo.selectList(new { PmCashFlowSeq = entity.Seq }).ToList();
            var pmInvestment = pmCashFlowInvestmentRepo.selectList(new { PmCashFlowSeq = entity.Seq }).ToList();
            var pmFinancial = pmCashFlowFinancialRepo.selectList(new { PmCashFlowSeq = entity.Seq }).ToList();
            var pmBeCash = pmCashFlowBeCashRepo.selectList(new { PmCashFlowSeq = entity.Seq }).ToList();

            string fileName = "Cash Flow_" + pmCashFlow.CashFlowYear + "년_" + orgCompanyName.CompanyName;

            int rows = 1, cells = 1;

            using (XLWorkbook wb = new XLWorkbook())
            {
                var wsSales = wb.Worksheets.Add("영업활동");

                // 컬럼 숨기기
               // wsSales.Column(1).Hide();
               // wsSales.Column(2).Hide();
                wsSales.Column(3).Hide();

                //wsSales.Cell(rows, cells).SetValue("ParentSeq").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
               // wsSales.Cell(rows, ++cells).SetValue("Seq").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                wsSales.Cell(rows, cells).SetValue("년도").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsSales.Cell(rows, ++cells).SetValue("월").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                wsSales.Cell(rows, ++cells).SetValue("누계여부코드").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsSales.Cell(rows, ++cells).SetValue("누계여부").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                wsSales.Cell(rows, ++cells).SetValue("영업이익").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsSales.Cell(rows, ++cells).SetValue("감가비").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsSales.Cell(rows, ++cells).SetValue("법인세비용").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsSales.Cell(rows, ++cells).SetValue("AR변동").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsSales.Cell(rows, ++cells).SetValue("Inv변동").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsSales.Cell(rows, ++cells).SetValue("AP변동").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsSales.Cell(rows, ++cells).SetValue("기타(미지급금외)").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsSales.Cell(rows, ++cells).SetValue("이자비용").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsSales.Cell(rows, ++cells).SetValue("이자수익").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                foreach (var item in pmSales)
                {
                    rows++;
                    cells = 1;

                   // wsSales.Cell(rows, cells).SetValue(item.PmCashFlowSeq).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    //wsSales.Cell(rows, ++cells).SetValue(item.Seq).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                    wsSales.Cell(rows, cells).SetValue(pmCashFlow.CashFlowYear).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsSales.Cell(rows, ++cells).SetValue(pmCashFlow.Monthly).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                    wsSales.Cell(rows, ++cells).SetValue(item.Cumulative).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsSales.Cell(rows, ++cells).SetValue(Define.CUMULATIVE.GetValue(item.Cumulative)).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);

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
               // wsInvestment.Column(2).Hide();
                wsInvestment.Column(3).Hide();

                //wsInvestment.Cell(rows, cells).SetValue("ParentSeq").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                //wsInvestment.Cell(rows, ++cells).SetValue("Seq").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                wsInvestment.Cell(rows, cells).SetValue("년도").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsInvestment.Cell(rows, ++cells).SetValue("월").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                wsInvestment.Cell(rows, ++cells).SetValue("누계여부코드").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsInvestment.Cell(rows, ++cells).SetValue("누계여부").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                wsInvestment.Cell(rows, ++cells).SetValue("유형/무형자산").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsInvestment.Cell(rows, ++cells).SetValue("지분투자").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsInvestment.Cell(rows, ++cells).SetValue("자산매각").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsInvestment.Cell(rows, ++cells).SetValue("기타").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                foreach (var item in pmInvestment)
                {
                    rows++;
                    cells = 1;

                   // wsInvestment.Cell(rows, cells).SetValue(item.PmCashFlowSeq).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    //wsInvestment.Cell(rows, ++cells).SetValue(item.Seq).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                    wsInvestment.Cell(rows, cells).SetValue(pmCashFlow.CashFlowYear).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsInvestment.Cell(rows, ++cells).SetValue(pmCashFlow.Monthly).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                    wsInvestment.Cell(rows, ++cells).SetValue(item.Cumulative).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsInvestment.Cell(rows, ++cells).SetValue(Define.CUMULATIVE.GetValue(item.Cumulative)).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                    wsInvestment.Cell(rows, ++cells).SetValue(item.Assets).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsInvestment.Cell(rows, ++cells).SetValue(item.EquityInvestment).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsInvestment.Cell(rows, ++cells).SetValue(item.AssetsSale).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsInvestment.Cell(rows, ++cells).SetValue(item.InvestmentEtc).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                }

                rows = 1;
                cells = 1;
                var wsFinancial = wb.Worksheets.Add("재무활동");

                // 컬럼 숨기기
                //wsFinancial.Column(1).Hide();
                //wsFinancial.Column(2).Hide();
                wsFinancial.Column(3).Hide();

                //wsFinancial.Cell(rows, cells).SetValue("ParentSeq").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                //wsFinancial.Cell(rows, ++cells).SetValue("Seq").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                wsFinancial.Cell(rows, cells).SetValue("년도").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsFinancial.Cell(rows, ++cells).SetValue("월").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                wsFinancial.Cell(rows, ++cells).SetValue("누계여부코드").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsFinancial.Cell(rows, ++cells).SetValue("누계여부").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                wsFinancial.Cell(rows, ++cells).SetValue("배당").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsFinancial.Cell(rows, ++cells).SetValue("증자").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsFinancial.Cell(rows, ++cells).SetValue("차입").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsFinancial.Cell(rows, ++cells).SetValue("상환").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsFinancial.Cell(rows, ++cells).SetValue("기타").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                foreach (var item in pmFinancial)
                {
                    rows++;
                    cells = 1;

                    //wsFinancial.Cell(rows, cells).SetValue(item.PmCashFlowSeq).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    //wsFinancial.Cell(rows, ++cells).SetValue(item.Seq).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                    wsFinancial.Cell(rows, cells).SetValue(pmCashFlow.CashFlowYear).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsFinancial.Cell(rows, ++cells).SetValue(pmCashFlow.Monthly).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                    wsFinancial.Cell(rows, ++cells).SetValue(item.Cumulative).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsFinancial.Cell(rows, ++cells).SetValue(Define.CUMULATIVE.GetValue(item.Cumulative)).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                    wsFinancial.Cell(rows, ++cells).SetValue(item.Allocation).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsFinancial.Cell(rows, ++cells).SetValue(item.Increase).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsFinancial.Cell(rows, ++cells).SetValue(item.Borrowing).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsFinancial.Cell(rows, ++cells).SetValue(item.Repayment).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsFinancial.Cell(rows, ++cells).SetValue(item.Etc).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                }

                rows = 1;
                cells = 1;
                var wsBeCash = wb.Worksheets.Add("기초기말");

                // 컬럼 숨기기
                //wsFinancial.Column(1).Hide();
                //wsFinancial.Column(2).Hide();
                wsBeCash.Column(3).Hide();

                //wsFinancial.Cell(rows, cells).SetValue("ParentSeq").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                //wsFinancial.Cell(rows, ++cells).SetValue("Seq").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                wsBeCash.Cell(rows, cells).SetValue("년도").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsBeCash.Cell(rows, ++cells).SetValue("월").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                wsBeCash.Cell(rows, ++cells).SetValue("누계여부코드").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsBeCash.Cell(rows, ++cells).SetValue("누계여부").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsBeCash.Cell(rows, ++cells).SetValue("Credit Line").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin); 

                if(pmBeCash.Count() == 0)
                {
                     for ( int i = 10 ; i < 30; i+=10 )
                    {
                        rows++;
                        cells = 1;
                        wsBeCash.Cell(rows, cells).SetValue(pmCashFlow.CashFlowYear).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                        wsBeCash.Cell(rows, ++cells).SetValue(pmCashFlow.Monthly).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                        wsBeCash.Cell(rows, ++cells).SetValue(i).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                        wsBeCash.Cell(rows, ++cells).SetValue(Define.CUMULATIVE.GetValue(i)).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                        wsBeCash.Cell(rows, ++cells).SetValue(0).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    }
                }
                foreach (var item in pmBeCash)
                {
                    rows++;
                    cells = 1;

                    //wsFinancial.Cell(rows, cells).SetValue(item.PmCashFlowSeq).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    //wsFinancial.Cell(rows, ++cells).SetValue(item.Seq).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                    wsBeCash.Cell(rows, cells).SetValue(pmCashFlow.CashFlowYear).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsBeCash.Cell(rows, ++cells).SetValue(pmCashFlow.Monthly).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                    wsBeCash.Cell(rows, ++cells).SetValue(item.Cumulative).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    wsBeCash.Cell(rows, ++cells).SetValue(Define.CUMULATIVE.GetValue(item.Cumulative)).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                    wsBeCash.Cell(rows, ++cells).SetValue(item.CreditLine).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                }



                using (MemoryStream mStream = new MemoryStream())
                {
                    wb.SaveAs(mStream);
                    return File(mStream.ToArray(), "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", fileName + ".xlsx");
                }
            }
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
                string filePath = "pmCashFlow";
                var file = fileUtil.FileUpload(ExcelFile, filePath);

                bool bDoubleValue = true;
                ExcelUtil excelUtil = new ExcelUtil();
                var ds = excelUtil.ImportExcelDs(file["FILE_PATH"]);

                List<PmCashFlowSales> pSalesList = new List<PmCashFlowSales>();
                List<PmCashFlowInvestment> pInvestmentList = new List<PmCashFlowInvestment>();
                List<PmCashFlowFinancial> pFinancialList = new List<PmCashFlowFinancial>();

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
                        string cumCode = item.ItemArray.GetValue(4).ToString();
                        string cum = item.ItemArray.GetValue(5).ToString();
                        
                        string OperationProfit = item.ItemArray.GetValue(6).ToString();
                        string DepreciationCost = item.ItemArray.GetValue(7).ToString();
                        string CorpTax = item.ItemArray.GetValue(8).ToString();
                        string Ar = item.ItemArray.GetValue(9).ToString();
                        string Inv = item.ItemArray.GetValue(10).ToString();
                        string Ap = item.ItemArray.GetValue(11).ToString();
                        string Etc = item.ItemArray.GetValue(12).ToString();
                        string InterestExpense = item.ItemArray.GetValue(13).ToString();
                        string InterestIncome = item.ItemArray.GetValue(14).ToString();

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

                        PmCashFlowSales p = new PmCashFlowSales();
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
                        string cumCode = item.ItemArray.GetValue(4).ToString();
                        string cum = item.ItemArray.GetValue(5).ToString();

                        string Assets = item.ItemArray.GetValue(6).ToString();
                        string EquityInvestment = item.ItemArray.GetValue(7).ToString();
                        string AssetsSale = item.ItemArray.GetValue(8).ToString();
                        string Etc = item.ItemArray.GetValue(9).ToString();

                        if (parentSeq != Seq.ToString()) { bDoubleValue = false; break; }       // 현재 코드와 업로드하려는 코드가 다른 경우는 양식이 잘못된것으로 오류
                        //if (!WebUtil.CheckDecimalTwo(Assets)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(EquityInvestment)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(AssetsSale)) { bDoubleValue = false; break; }
                        ////if (!WebUtil.CheckDecimalTwo(Etc)) { bDoubleValue = false; break; }

                        PmCashFlowInvestment p = new PmCashFlowInvestment();
                        p.Seq = Convert.ToInt32(excelSeq);
                        p.Assets = Convert.ToDecimal(Assets);
                        p.EquityInvestment = Convert.ToDecimal(EquityInvestment);
                        p.AssetsSale = Convert.ToDecimal(AssetsSale);
                        p.InvestmentEtc = Convert.ToDecimal(Etc);

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
                        string cumCode = item.ItemArray.GetValue(4).ToString();
                        string cum = item.ItemArray.GetValue(5).ToString();

                        string Allocation = item.ItemArray.GetValue(6).ToString();
                        string Increase = item.ItemArray.GetValue(7).ToString();
                        string Borrowing = item.ItemArray.GetValue(8).ToString();
                        string Repayment = item.ItemArray.GetValue(9).ToString();
                        string Etc = item.ItemArray.GetValue(10).ToString();

                        if (parentSeq != Seq.ToString()) { bDoubleValue = false; break; }       // 현재 코드와 업로드하려는 코드가 다른 경우는 양식이 잘못된것으로 오류
                        //if (!WebUtil.CheckDecimalTwo(Allocation)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(Increase)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(Borrowing)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(Repayment)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(Etc)) { bDoubleValue = false; break; }

                        PmCashFlowFinancial p = new PmCashFlowFinancial();
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
                    pmCashFlowSalesRepo.update(item);
                }
                foreach (var item in pInvestmentList)
                {
                    pmCashFlowInvestmentRepo.update(item);
                }
                foreach (var item in pFinancialList)
                {
                    pmCashFlowFinancialRepo.update(item);
                }

                // 업데이트 완료 후 로그 남기기
                ExcelFileUploadList eFileList = new ExcelFileUploadList();
                eFileList.UserKey = SessionManager.GetAdminSession().insaUserV.userKey;
                eFileList.EmpNo = SessionManager.GetAdminSession().insaUserV.empNo;
                eFileList.AttachTableName = "PM_CASH_FLOW";
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

        [Route("Calculation_One_Action")]
        public ActionResult Calculation_One_Action(PmCashFlowAdmin entity, Search search)
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

        public bool SetInsertFcfAction(PmCashFlowAdmin entity)
        {
            bool bOne = true;

            PmCashFlowFcf pFcf = new PmCashFlowFcf();
            pFcf.PmCashFlowSeq = entity.Seq;
            pmCashFlowFcfRepo.delete(pFcf);
            pmCashFlowFcfRepo.insertCum(pFcf);

            return bOne;
        }

        public bool SetInsertBeCashAction(PmCashFlowAdmin entity)
        {
            bool bOne = true;

            // 기초현금과 CreditLine가 계산값이 아니고 입력 값이기에 최초에는 현금흐름합계의 값을 넣어주면 된다.
            PmCashFlowFcf p = new PmCashFlowFcf();
            p.PmCashFlowSeq = entity.Seq;
            var pFcf = pmCashFlowFcfRepo.selectList(p);

            // 누적실적의 기초현금은 전년도 12월의 Ending Cash
            var pCumBc = pmCashFlowBeCashRepo.selectListBefore(new { YearlyYear = entity.CashFlowYear, OrgCompanySeq = entity.OrgCompanySeq }).FirstOrDefault();
            // 2018.12.13 당월실적 기초현금은 전월의 Ending Cash를 가져오게한다.
            // 전년도 12월의 경우.. 그냥 새로 만듬..
            var pMonBc = pmCashFlowBeCashRepo.selectListBeforeMonth(new { YearlyYear = entity.CashFlowYear, OrgCompanySeq = entity.OrgCompanySeq, Monthly = entity.Monthly }).FirstOrDefault();
            if (entity.Monthly == "01")
            {
                pMonBc = pmCashFlowBeCashRepo.selectListLastYear(new { YearlyYear = entity.CashFlowYear, OrgCompanySeq = entity.OrgCompanySeq, Monthly = entity.Monthly }).FirstOrDefault(); 
            }
            if (pCumBc == null) { pCumBc = new PmCashFlowBeCash(); }
            if (pMonBc == null) { pMonBc = new PmCashFlowBeCash(); }
            pmCashFlowBeCashRepo.delete(new { PmCashFlowSeq = entity.Seq });
            foreach (var item in pFcf)
            {
                // 2018.12.06 누적실적(전년도 12월의 Ending Cash
                PmCashFlowBeCash pBeCash = new PmCashFlowBeCash();
                pBeCash.PmCashFlowSeq = entity.Seq;
                pBeCash.Cumulative = item.Cumulative;
                if (item.Cumulative == Define.CUMULATIVE.GetKey("누계 실적"))
                {
                    pBeCash.BasicCash = pCumBc.EndingCash;
                }
                else
                {
                    pBeCash.BasicCash = pMonBc.EndingCash;
                }
                pBeCash.EndingCash = item.CashSum;
                pBeCash.CreditLine = 0;
                pBeCash.AvailableCash = item.CashSum;

                pmCashFlowBeCashRepo.insertCum(pBeCash);
            }

            return bOne;
        }

        public bool SetUpdateBeCashAction(PmCashFlowAdmin entity)
        {
            bool bOne = true;

            PmCashFlowFcf p = new PmCashFlowFcf();
            p.PmCashFlowSeq = entity.Seq;
            var pFcf = pmCashFlowFcfRepo.selectList(p);

            // 입력한 기초현금 + 현금합계로 EndingCash
            // EndingCash + CreditLine = 가용현금을 완성하여 업데이트 한다.

            // 누적실적의 기초현금은 전년도 12월의 Ending Cash
            var pCumBc = pmCashFlowBeCashRepo.selectListBefore(new { YearlyYear = entity.CashFlowYear, OrgCompanySeq = entity.OrgCompanySeq }).FirstOrDefault();

            // 2018.12.13 당월실적 기초현금은 전월의 Ending Cash를 가져오게한다.
            var pMonBc = pmCashFlowBeCashRepo.selectListBeforeMonth(new { YearlyYear = entity.CashFlowYear, OrgCompanySeq = entity.OrgCompanySeq, Monthly = entity.Monthly }).FirstOrDefault();
            if (pCumBc == null) { pCumBc = new PmCashFlowBeCash(); }
            if (pMonBc == null) { pMonBc = new PmCashFlowBeCash(); }


            for (int i = 0; i < entity.PmCashFlowBeCashSeq.Count(); i++)
            {
                var thisPFcf = pFcf.Where(w => w.Cumulative == entity.Cumulative[i]).First();
                PmCashFlowBeCash pBeCash = new PmCashFlowBeCash();
                pBeCash.Seq = entity.PmCashFlowBeCashSeq[i];
                if (entity.Cumulative[i] == Define.CUMULATIVE.GetKey("누계 실적"))
                {
                    pBeCash.BasicCash = entity.BasicCash[i];
                    pBeCash.EndingCash = pBeCash.BasicCash + thisPFcf.CashSum;
                    pBeCash.CreditLine = entity.CreditLine[i];
                    pBeCash.AvailableCash = pBeCash.EndingCash + pBeCash.CreditLine;

                    //pBeCash.BasicCash = pCumBc.EndingCash;
                    //pBeCash.EndingCash = pCumBc.EndingCash + thisPFcf.CashSum;
                    //pBeCash.CreditLine = entity.CreditLine[i];
                    //pBeCash.AvailableCash = pCumBc.EndingCash + thisPFcf.CashSum + entity.CreditLine[i];
                }
                else
                {
                    pBeCash.BasicCash = entity.BasicCash[i];
                    pBeCash.EndingCash = entity.BasicCash[i] + thisPFcf.CashSum;
                    pBeCash.CreditLine = entity.CreditLine[i];
                    pBeCash.AvailableCash = entity.BasicCash[i] + thisPFcf.CashSum + entity.CreditLine[i];

                    //pBeCash.BasicCash = pMonBc.EndingCash;
                    //pBeCash.EndingCash = pBeCash.BasicCash + thisPFcf.CashSum;
                    //pBeCash.CreditLine = entity.CreditLine[i];
                    //pBeCash.AvailableCash = entity.BasicCash[i] + thisPFcf.CashSum + entity.CreditLine[i];
                }

                pmCashFlowBeCashRepo.update(pBeCash);
            }

            return bOne;
        }

        public bool SetBaseOneAction(PmCashFlowAdmin entity)
        {
            bool bOne = true;

            List<PmCashFlowSales> pSalesList = new List<PmCashFlowSales>();
            List<PmCashFlowInvestment> pInvestmentList = new List<PmCashFlowInvestment>();
            List<PmCashFlowFinancial> pFinancialList = new List<PmCashFlowFinancial>();

            try
            {
                for (int i = 0; i < entity.PmCashFlowSalesSeq.Count(); i++)
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

                    PmCashFlowSales pSales = new PmCashFlowSales();
                    pSales.Seq = entity.PmCashFlowSalesSeq[i];
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

                if(bOne)
                {
                    for (int i = 0; i < entity.PmCashFlowInvestmentSeq.Count(); i++)
                    {
                        if (!WebUtil.CheckDecimalTwo(entity.Assets[i].ToString())) { bOne = false; break; }
                        if (!WebUtil.CheckDecimalTwo(entity.EquityInvestment[i].ToString())) { bOne = false; break; }
                        if (!WebUtil.CheckDecimalTwo(entity.AssetsSale[i].ToString())) { bOne = false; break; }
                        if (!WebUtil.CheckDecimalTwo(entity.InvestmentEtc[i].ToString())) { bOne = false; break; }

                        PmCashFlowInvestment pInvestment = new PmCashFlowInvestment();
                        pInvestment.Seq = entity.PmCashFlowInvestmentSeq[i];
                        pInvestment.Assets = entity.Assets[i];
                        pInvestment.EquityInvestment = entity.EquityInvestment[i];
                        pInvestment.AssetsSale = entity.AssetsSale[i];
                        pInvestment.InvestmentEtc = entity.InvestmentEtc[i];

                        pInvestmentList.Add(pInvestment);
                    }
                }

                if (bOne)
                {
                    for (int i = 0; i < entity.PmCashFlowFinancialSeq.Count(); i++)
                    {
                        if (!WebUtil.CheckDecimalTwo(entity.Allocation[i].ToString())) { bOne = false; break; }
                        if (!WebUtil.CheckDecimalTwo(entity.Increase[i].ToString())) { bOne = false; break; }
                        if (!WebUtil.CheckDecimalTwo(entity.Borrowing[i].ToString())) { bOne = false; break; }
                        if (!WebUtil.CheckDecimalTwo(entity.Repayment[i].ToString())) { bOne = false; break; }
                        if (!WebUtil.CheckDecimalTwo(entity.FinancialEtc[i].ToString())) { bOne = false; break; }

                        PmCashFlowFinancial pFinancial = new PmCashFlowFinancial();
                        pFinancial.Seq = entity.PmCashFlowFinancialSeq[i];
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

            if(bOne)
            {
                foreach (var item in pSalesList)
                {
                    pmCashFlowSalesRepo.update(item);
                }

                foreach (var item in pInvestmentList)
                {
                    pmCashFlowInvestmentRepo.update(item);
                }

                foreach (var item in pFinancialList)
                {
                    pmCashFlowFinancialRepo.update(item);
                }


                PmCashFlow p = new PmCashFlow();
                p.Seq = entity.Seq;
                p.SalesComment = entity.SalesComment;
                p.InvestmentComment = entity.InvestmentComment;
                p.FinancialComment = entity.FinancialComment;
                p.FcfComment = entity.FcfComment;
                p.BeCashComment = entity.BeCashComment;

                pmCashFlowRepo.updateComment(p);
                // 코멘트 업데이트

            }

            return bOne;
        }

        [Route("Calculation_Two_Action")]
        public ActionResult Calculation_Two_Action(PmCashFlowAdmin entity, Search search)
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
            // 계획(10)과 실적(20)을 가져와서 입력해야한다. 
            PmCashFlowCumulative pnCum = pmCashFlowCumulativeRepo.selectOneCumMonPn(new { YearCfYear = entity.CashFlowYear, OrgCompanySeq = entity.OrgCompanySeq, Monthly = entity.Monthly });
            // 계획이 없으면 안되는게 맞지만. 혹시 없다면 체크
            if (pnCum == null) pnCum = new PmCashFlowCumulative();
            var pmCum = pmCashFlowCumulativeRepo.selectOneCumMonPm(new { Seq = entity.Seq});

            pmCashFlowCumulativeRepo.delete(new { PmCashFlowSeq = entity.Seq });
            
            // 계획 월별 합계를 더하는 수식에서 변경된 항목들이 있어서 추가.
            // 누적실적의 기초현금은 전년도 12월의 Ending Cash
            var pCumBc = pmCashFlowBeCashRepo.selectListBefore(new { YearlyYear = entity.CashFlowYear, OrgCompanySeq = entity.OrgCompanySeq }).FirstOrDefault();
            if (pCumBc == null) { pCumBc = new PmCashFlowBeCash(); }

            // 당해년도 계획 CreditLine
            var pnBeCash = planYearCfBeCashRepo.selectListYear(new { YearCfYear = entity.CashFlowYear, OrgCompanySeq = entity.OrgCompanySeq }).ToList();
            var pnBeCashMonth = pnBeCash.Where(w => w.Monthly == entity.Monthly).FirstOrDefault();
            if (pnBeCashMonth == null) pnBeCashMonth = new PlanYearCfBeCash();
            pnCum.EndingCash = pCumBc.EndingCash + pnCum.CashSum;
            pnCum.CreditLine = pnBeCashMonth.CreditLine;
            pnCum.AvailableCash = pnCum.EndingCash + pnCum.CreditLine;

            // 계획 입력
            pnCum.PmCashFlowSeq = entity.Seq;
            pnCum.Diff = Define.DIFF.GetKey("계획");
            pmCashFlowCumulativeRepo.insert(pnCum);

            // 실적 입력
            pmCum.PmCashFlowSeq = entity.Seq;
            pmCum.Diff = Define.DIFF.GetKey("실적");
            pmCashFlowCumulativeRepo.insert(pmCum);
            
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
            //    PmCashFlow p = new PmCashFlow();
            //    p.Seq = entity.Seq;
            //    p.RegistStatus = entity.RegistStatus;
            //    pmCashFlowRepo.updateRegist(p);
            //}

            return RedirectAndPostActionResult.RedirectAndPost("Edit", postData);
        }

        [Route("Edit")]
        public ActionResult Edit(PmCashFlow entity, Search search)
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");
            
            // 기본데이터
            var pmCashFlow = pmCashFlowRepo.selectOne(entity);
            // 부문 > 회사 이름
            var orgCompanyName = orgCompanyRepo.selectOne(new { Seq = entity.OrgCompanySeq });

            // 상세데이터 가져오기
            var pnSales = planYearCfSalesRepo.selectListYear(new { YearCfYear = pmCashFlow.CashFlowYear, OrgCompanySeq = pmCashFlow.OrgCompanySeq }).ToList();
            var pnInvestment = planYearCfInvestmentRepo.selectListYear(new { YearCfYear = pmCashFlow.CashFlowYear, OrgCompanySeq = pmCashFlow.OrgCompanySeq }).ToList();
            var pnFinancial = planYearCfFinancialRepo.selectListYear(new { YearCfYear = pmCashFlow.CashFlowYear, OrgCompanySeq = pmCashFlow.OrgCompanySeq }).ToList();
            var pnFcf = planYearCfFcfRepo.selectListYear(new { YearCfYear = pmCashFlow.CashFlowYear, OrgCompanySeq = pmCashFlow.OrgCompanySeq }).ToList();
            var pnBeCash = planYearCfBeCashRepo.selectListYear(new { YearCfYear = pmCashFlow.CashFlowYear, OrgCompanySeq = pmCashFlow.OrgCompanySeq }).ToList();
            // 계산하기에서 Sales를 계산하기에 따로 가져올 필요는 없을듯
            //var pnPalSales = planMonthlyPalBusinessMonthlySumRepo.selectListYear(new { MonthlyPalYear = pmCashFlow.CashFlowYear, OrgCompanySeq = pmCashFlow.OrgCompanySeq }).ToList();

            // 누적실적의 기초현금(은 전년도 12월의 Ending Cash
            // 기초현금의 누적계획과 누적실적은 같은 전년도 12월의 Endgin Cash를 가져오기에. 누적실적의 값(계산하기에서 가져옴)을 계획에 넣어주면 된다.
            //var pCumBc = pmCashFlowBeCashRepo.selectListBefore(new { YearlyYear = entity.CashFlowYear, OrgCompanySeq = entity.OrgCompanySeq }).FirstOrDefault();


            var pmSales = pmCashFlowSalesRepo.selectList(new { PmCashFlowSeq = entity.Seq }).ToList();
            var pmInvestment = pmCashFlowInvestmentRepo.selectList(new { PmCashFlowSeq = entity.Seq }).ToList();
            var pmFinancial = pmCashFlowFinancialRepo.selectList(new { PmCashFlowSeq = entity.Seq }).ToList();
            var pmFcf = pmCashFlowFcfRepo.selectList(new { PmCashFlowSeq = entity.Seq }).ToList();
            var pmBeCash = pmCashFlowBeCashRepo.selectList(new { PmCashFlowSeq = entity.Seq }).ToList();
            //var pmPalSales = pmPalSummaryRepo.selectListYear(new { PalYear = pmCashFlow.CashFlowYear , Monthly = pmCashFlow.Monthly, OrgCompanySeq = pmCashFlow.OrgCompanySeq}).ToList();
            var pmCumulative = pmCashFlowCumulativeRepo.selectList(new { PmCashFlowSeq = entity.Seq }).ToList();

            dynamic model = new ExpandoObject();
            model.pmCashFlow = pmCashFlow;
            model.orgCompanyName = orgCompanyName;

            model.pnSales = pnSales;
            model.pnInvestment = pnInvestment;
            model.pnFinancial = pnFinancial;
            model.pnFcf = pnFcf;
            //model.pnPalSales = pnPalSales;
            model.pnBeCash = pnBeCash;

            model.pmSales = pmSales;
            model.pmInvestment = pmInvestment;
            model.pmFinancial = pmFinancial;
            model.pmFcf = pmFcf;
            //model.pmPalSales = pmPalSales;
            model.pmBeCash = pmBeCash;
            model.pmCumulative = pmCumulative;

            if (entity.message != null)
            {
                TempData["alert"] = entity.message;
            }

            ViewBag.Search = search;
            return View("~/Views/SiteMngHome/Performance/Cash_Flow/Edit.cshtml", model);
        }


        [Route("Edit2")]
        public ActionResult Edit2(PmCashFlow entity, Search search)
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");

            // 기본데이터
            var pmCashFlow = pmCashFlowRepo.selectOne(entity);
            // 부문 > 회사 이름
            var orgCompanyName = orgCompanyRepo.selectOne(new { Seq = entity.OrgCompanySeq });
            
            var pmCumulative = pmCashFlowCumulativeRepo.selectList(new { PmCashFlowSeq = entity.Seq }).ToList();

            dynamic model = new ExpandoObject();
            model.pmCashFlow = pmCashFlow;
            model.orgCompanyName = orgCompanyName;

            model.pmCumulative = pmCumulative;

            if (entity.message != null)
            {
                TempData["alert"] = entity.message;
            }

            ViewBag.Search = search;
            return View("~/Views/SiteMngHome/Performance/Cash_Flow/Edit2.cshtml", model);
        }

        [Route("Edit_Action")]
        public ActionResult EditAction(PmCashFlowAdmin entity, Search search)
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

            List<PmCashFlowSales> pSalesList = new List<PmCashFlowSales>();
            List<PmCashFlowInvestment> pInvestmentList = new List<PmCashFlowInvestment>();
            List<PmCashFlowFinancial> pFinancialList = new List<PmCashFlowFinancial>();
            List<PmCashFlowFcf> pFcfList = new List<PmCashFlowFcf>();
            List<PmCashFlowBeCash> pBeCashList = new List<PmCashFlowBeCash>();
            List<PmCashFlowCumulative> pCumulativeList = new List<PmCashFlowCumulative>();

            try
            {
                for (int i = 0; i < entity.PmCashFlowSalesSeq.Count(); i++)
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

                    PmCashFlowSales p = new PmCashFlowSales();
                    p.Seq = entity.PmCashFlowSalesSeq[i];
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

                for (int i = 0; i < entity.PmCashFlowInvestmentSeq.Count(); i++)
                {
                    if (!WebUtil.CheckDecimalTwo(entity.Assets[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.EquityInvestment[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.AssetsSale[i].ToString())) { bDoubleValue = false; break; }
                    //if (!WebUtil.CheckDecimalTwo(entity.InvestmentEtc[i].ToString())) { bDoubleValue = false; break; }

                    PmCashFlowInvestment p = new PmCashFlowInvestment();
                    p.Seq = entity.PmCashFlowInvestmentSeq[i];
                    p.Assets = entity.Assets[i];
                    p.EquityInvestment = entity.EquityInvestment[i];
                    p.AssetsSale = entity.AssetsSale[i];
                    p.InvestmentEtc = entity.InvestmentEtc[i];

                    pInvestmentList.Add(p);
                }

                for (int i = 0; i < entity.PmCashFlowFinancialSeq.Count(); i++)
                {
                    if (!WebUtil.CheckDecimalTwo(entity.Allocation[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.Increase[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.Borrowing[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.Repayment[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.FinancialEtc[i].ToString())) { bDoubleValue = false; break; }

                    PmCashFlowFinancial p = new PmCashFlowFinancial();
                    p.Seq = entity.PmCashFlowFinancialSeq[i];
                    p.Allocation = entity.Allocation[i];
                    p.Increase = entity.Increase[i];
                    p.Borrowing = entity.Borrowing[i];
                    p.Repayment = entity.Repayment[i];
                    p.Etc = entity.FinancialEtc[i];

                    pFinancialList.Add(p);
                }

                for (int i = 0; i < entity.PmCashFlowFcfSeq.Count(); i++)
                {
                    if (!WebUtil.CheckDecimalTwo(entity.Fcf1[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.Fcf2[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.Fcf3[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.CashSum[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.FcfSales[i].ToString())) { bDoubleValue = false; break; }

                    PmCashFlowFcf p = new PmCashFlowFcf();
                    p.Seq = entity.PmCashFlowFcfSeq[i];
                    p.Fcf1 = entity.Fcf1[i];
                    p.Fcf2 = entity.Fcf2[i];
                    p.Fcf3 = entity.Fcf3[i];
                    p.CashSum = entity.CashSum[i];
                    p.FcfSales = entity.FcfSales[i];

                    pFcfList.Add(p);
                }

                for (int i = 0; i < entity.PmCashFlowBeCashSeq.Count(); i++)
                {
                    if (!WebUtil.CheckDecimalTwo(entity.BasicCash[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.CreditLine[i].ToString())) { bDoubleValue = false; break; }

                    PmCashFlowBeCash p = new PmCashFlowBeCash();
                    p.Seq = entity.PmCashFlowBeCashSeq[i];
                    p.BasicCash = entity.BasicCash[i];
                    p.CreditLine = entity.CreditLine[i];

                    pBeCashList.Add(p);
                }

                for (int i = 0; i < entity.PmCashFlowCumulativeSeq.Count(); i++)
                {
                    if (!WebUtil.CheckDecimalTwo(entity.CumulativeEbitda[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.CumulativeWcSum[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.CumulativeEtc[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.CumulativeNetCapexSum[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.CumulativeFinancialCost[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.CumulativeFcf2[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.CumulativeFinancialSum[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.CumulativeCashSum[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.CumulativeEndingCash[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.CumulativeCreditLine[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.CumulativeAvailableCash[i].ToString())) { bDoubleValue = false; break; }

                    PmCashFlowCumulative p = new PmCashFlowCumulative();
                    p.Seq = entity.PmCashFlowCumulativeSeq[i];
                    p.Ebitda = entity.CumulativeEbitda[i];
                    p.WcSum = entity.CumulativeWcSum[i];
                    p.Etc = entity.CumulativeEtc[i];
                    p.NetCapexSum = entity.CumulativeNetCapexSum[i];
                    p.FinancialCost = entity.CumulativeFinancialCost[i];
                    p.Fcf2 = entity.CumulativeFcf2[i];
                    p.FinancialSum = entity.CumulativeFinancialSum[i];
                    p.CashSum = entity.CumulativeCashSum[i];
                    p.EndingCash = entity.CumulativeEndingCash[i];
                    p.CreditLine = entity.CumulativeCreditLine[i];
                    p.AvailableCash = entity.CumulativeAvailableCash[i];

                    pCumulativeList.Add(p);
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
                pmCashFlowSalesRepo.update(item);
            }
            foreach (var item in pInvestmentList)
            {
                pmCashFlowInvestmentRepo.update(item);
            }
            foreach (var item in pFinancialList)
            {
                pmCashFlowFinancialRepo.update(item);
            }
            foreach (var item in pFcfList)
            {
                pmCashFlowFcfRepo.update(item);
            }
            foreach (var item in pBeCashList)
            {
                pmCashFlowBeCashRepo.update2(item);
            }
            foreach (var item in pCumulativeList)
            {
                pmCashFlowCumulativeRepo.update(item);
            }

            // 미저장에서 저장으로 변경
            if (entity.RegistStatus == Define.REGIST_STATUS.GetKey("미등록"))
            {
                entity.RegistStatus = Define.REGIST_STATUS.GetKey("저장");
                PmCashFlow p = new PmCashFlow();
                p.Seq = entity.Seq;
                p.RegistStatus = entity.RegistStatus;
                pmCashFlowRepo.updateRegist(p);
            }

            return RedirectAndPostActionResult.RedirectAndPost("Edit", postData);
        }

        /// <summary>
        /// 승인요청, 승인, 반려등의 상태 변경
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        [Route("Regist_Status_Change")]
        public ActionResult RegistStatusChange(PmCashFlow entity, Search search)
        {

            PmConfirmStateViewRepo pmconfirmStateViewRepo = new PmConfirmStateViewRepo();
           
            if (Request.RequestType == "GET") return RedirectToAction("List");

            #region
            Dictionary<string, object> postData = new Dictionary<string, object>();
            postData.Add("Seq", entity.Seq);
            postData.Add("OrgCompanySeq", entity.OrgCompanySeq);
            postData.Add("message", entity.message);
            #endregion

            // 현재 상태값을 변경한다.
            entity.RegistStatus = entity.afterRegistStatus;
            pmCashFlowRepo.updateRegist(entity);

           // 현재의 상태 변경 후 담당자들에게 메일 발송합니다.(2018.11.08)
            var info = pmCashFlowRepo.selectOne(entity);

            MailInfo mInfo = new MailInfo();
            // 2019.01.13 결제라인 추가
            mInfo.Seq = entity.Seq;
            mInfo.ReferUrl = Request.UrlReferrer.AbsolutePath.ToString();
            mInfo.afterRegistStatus = entity.afterRegistStatus;
            mInfo.OrgCompanySeq = entity.OrgCompanySeq;
            mInfo.menuName = "Cash Flow";
            mInfo.year = info.CashFlowYear;
            mInfo.mm = info.Monthly;
            // 2018.01.03 반려사유 추가
            mInfo.RejectReson = entity.RejectReson;

            MailUtilNew.AllComfirmMaillSender(mInfo); /*메일 발송*/
            
            // 최종승인의 경우. 다른 모든 회사와 메뉴가 최종승인 되었는지 체크하여. 푸시알림을 보낸다.
            if (entity.RegistStatus == Define.REGIST_STATUS.GetKey("최종승인"))
            {
                //RegistYearListRepo rYearListRepo = new RegistYearListRepo();
                //List<RegistYearList> registYearPm = rYearListRepo.selectListPm(new { }).ToList();

                //string year = info.CashFlowYear;
                //string month = info.Monthly;

                //var checkRegist = registYearPm.Where(w => w.RegistYear == year && w.RegistMonth == month).ToList();
                //if (checkRegist != null && checkRegist.Count() > 0)
                //{
                //    // 인사디비에서 권한 사용자 가져온다.
                //    var users = insaUserVRepo.selectListAuth().ToList();

                //    PushMaster pushMaster = new PushMaster();
                //    pushMaster.Type = 1;
                //    pushMaster.Title = "-";
                //    pushMaster.Contents = year + "년 " + month + "월 실적등록이 승인되었습니다.";
                //    pushMaster.Link = "";

                //    ApiController api = new ApiController();

                //    List<string> result = api.SendPushServer(pushMaster, users);
                //    if (result[0].ToUpper() == "FALSE")
                //    {
                //        LogUtil.MngError(result[2].ToString() + "[" + year + "." + month);
                //    }
                //}
            }

            return RedirectToAction("List", search);
        }

        [Route("View")]
        public ActionResult view(PmCashFlow entity, Search search)
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");

            // 기본데이터
            var pmCashFlow = pmCashFlowRepo.selectOne(entity);
            // 부문 > 회사 이름
            var orgCompanyName = orgCompanyRepo.selectOne(new { Seq = entity.OrgCompanySeq });

            // 상세데이터 가져오기
            var pnSales = planYearCfSalesRepo.selectListYear(new { YearCfYear = pmCashFlow.CashFlowYear, OrgCompanySeq = pmCashFlow.OrgCompanySeq }).ToList();
            var pnInvestment = planYearCfInvestmentRepo.selectListYear(new { YearCfYear = pmCashFlow.CashFlowYear, OrgCompanySeq = pmCashFlow.OrgCompanySeq }).ToList();
            var pnFinancial = planYearCfFinancialRepo.selectListYear(new { YearCfYear = pmCashFlow.CashFlowYear, OrgCompanySeq = pmCashFlow.OrgCompanySeq }).ToList();
            var pnFcf = planYearCfFcfRepo.selectListYear(new { YearCfYear = pmCashFlow.CashFlowYear, OrgCompanySeq = pmCashFlow.OrgCompanySeq }).ToList();
            var pnBeCash = planYearCfBeCashRepo.selectListYear(new { YearCfYear = pmCashFlow.CashFlowYear, OrgCompanySeq = pmCashFlow.OrgCompanySeq }).ToList();
            // 계산하기에서 Sales를 계산하기에 따로 가져올 필요는 없을듯
            //var pnPalSales = planMonthlyPalBusinessMonthlySumRepo.selectListYear(new { MonthlyPalYear = pmCashFlow.CashFlowYear, OrgCompanySeq = pmCashFlow.OrgCompanySeq }).ToList();


            var pmSales = pmCashFlowSalesRepo.selectList(new { PmCashFlowSeq = entity.Seq }).ToList();
            var pmInvestment = pmCashFlowInvestmentRepo.selectList(new { PmCashFlowSeq = entity.Seq }).ToList();
            var pmFinancial = pmCashFlowFinancialRepo.selectList(new { PmCashFlowSeq = entity.Seq }).ToList();
            var pmFcf = pmCashFlowFcfRepo.selectList(new { PmCashFlowSeq = entity.Seq }).ToList();
            var pmBeCash = pmCashFlowBeCashRepo.selectList(new { PmCashFlowSeq = entity.Seq }).ToList();
            //var pmPalSales = pmPalSummaryRepo.selectListYear(new { PalYear = pmCashFlow.CashFlowYear , Monthly = pmCashFlow.Monthly, OrgCompanySeq = pmCashFlow.OrgCompanySeq}).ToList();
            var pmCumulative = pmCashFlowCumulativeRepo.selectList(new { PmCashFlowSeq = entity.Seq }).ToList();

            dynamic model = new ExpandoObject();
            model.pmCashFlow = pmCashFlow;
            model.orgCompanyName = orgCompanyName;

            model.pnSales = pnSales;
            model.pnInvestment = pnInvestment;
            model.pnFinancial = pnFinancial;
            model.pnFcf = pnFcf;
            //model.pnPalSales = pnPalSales;
            model.pnBeCash = pnBeCash;

            model.pmSales = pmSales;
            model.pmInvestment = pmInvestment;
            model.pmFinancial = pmFinancial;
            model.pmFcf = pmFcf;
            //model.pmPalSales = pmPalSales;
            model.pmBeCash = pmBeCash;
            model.pmCumulative = pmCumulative;

            if (entity.message != null)
            {
                TempData["alert"] = entity.message;
            }

            ViewBag.Search = search;
            return View("~/Views/SiteMngHome/Performance/Cash_Flow/View.cshtml", model);
        }

        [Route("Excel_Upload2")]
        public ActionResult ExcelUpload2(int Seq
                                        , int OrgCompanySeq
                                        , List<int> PmCashFlowSalesSeq
                                        , List<int> PmCashFlowInvestmentSeq
                                        , List<int> PmCashFlowFinancialSeq
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
                string filePath = "pmCashFlow";
                var file = fileUtil.FileUpload(ExcelFile, filePath);

                bool bDoubleValue = true;
                ExcelUtil excelUtil = new ExcelUtil();
                var ds = excelUtil.ImportExcelDs(file["FILE_PATH"]);

                List<PmCashFlowSales> pSalesList = new List<PmCashFlowSales>();
                List<PmCashFlowInvestment> pInvestmentList = new List<PmCashFlowInvestment>();
                List<PmCashFlowFinancial> pFinancialList = new List<PmCashFlowFinancial>();

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
                        string excelSeq = PmCashFlowSalesSeq[j].ToString();

                        string OperationProfit = item.ItemArray.GetValue(4).ToString();
                        string DepreciationCost = item.ItemArray.GetValue(5).ToString();
                        string CorpTax = item.ItemArray.GetValue(6).ToString();
                        string Ar = item.ItemArray.GetValue(7).ToString();
                        string Inv = item.ItemArray.GetValue(8).ToString();
                        string Ap = item.ItemArray.GetValue(9).ToString();
                        string Etc = item.ItemArray.GetValue(10).ToString();
                        string InterestExpense = item.ItemArray.GetValue(11).ToString();
                        string InterestIncome = item.ItemArray.GetValue(12).ToString();
                        // string yearlyYear = item.ItemArray.GetValue(2).ToString();
                        // string monthly = item.ItemArray.GetValue(3).ToString();
                        // string cumCode = item.ItemArray.GetValue(4).ToString();
                        // string cum = item.ItemArray.GetValue(5).ToString();

                        //string OperationProfit = item.ItemArray.GetValue(6).ToString();
                        //string DepreciationCost = item.ItemArray.GetValue(7).ToString();
                        //string CorpTax = item.ItemArray.GetValue(8).ToString();
                        //string Ar = item.ItemArray.GetValue(9).ToString();
                        //string Inv = item.ItemArray.GetValue(10).ToString();
                        //string Ap = item.ItemArray.GetValue(11).ToString();
                        //string Etc = item.ItemArray.GetValue(12).ToString();
                        //string InterestExpense = item.ItemArray.GetValue(13).ToString();
                        //string InterestIncome = item.ItemArray.GetValue(14).ToString();

                        //if (parentSeq != Seq.ToString()) { bDoubleValue = false; break; }       // 현재 코드와 업로드하려는 코드가 다른 경우는 양식이 잘못된것으로 오류
                        //if (!WebUtil.CheckDecimalTwo(OperationProfit)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(DepreciationCost)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(CorpTax)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(Ar)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(Inv)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(Ap)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(Etc)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(InterestExpense)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(InterestIncome)) { bDoubleValue = false; break; }

                        PmCashFlowSales p = new PmCashFlowSales();
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
                        string excelSeq = PmCashFlowInvestmentSeq[j].ToString();

                        string Assets = item.ItemArray.GetValue(4).ToString();
                        string EquityInvestment = item.ItemArray.GetValue(5).ToString();
                        string AssetsSale = item.ItemArray.GetValue(6).ToString();
                        string Etc = item.ItemArray.GetValue(7).ToString();
                        // string yearlyYear = item.ItemArray.GetValue(2).ToString();
                        // string monthly = item.ItemArray.GetValue(3).ToString();
                        //string cumCode = item.ItemArray.GetValue(4).ToString();
                        // string cum = item.ItemArray.GetValue(5).ToString();

                        //string Assets = item.ItemArray.GetValue(6).ToString();
                        //string EquityInvestment = item.ItemArray.GetValue(7).ToString();
                        //string AssetsSale = item.ItemArray.GetValue(8).ToString();
                        //string Etc = item.ItemArray.GetValue(9).ToString();

                        //if (parentSeq != Seq.ToString()) { bDoubleValue = false; break; }       // 현재 코드와 업로드하려는 코드가 다른 경우는 양식이 잘못된것으로 오류
                        //if (!WebUtil.CheckDecimalTwo(Assets)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(EquityInvestment)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(AssetsSale)) { bDoubleValue = false; break; }
                        ////if (!WebUtil.CheckDecimalTwo(Etc)) { bDoubleValue = false; break; }

                        PmCashFlowInvestment p = new PmCashFlowInvestment();
                        p.Seq = Convert.ToInt32(excelSeq);
                        p.Assets = Convert.ToDecimal(Assets);
                        p.EquityInvestment = Convert.ToDecimal(EquityInvestment);
                        p.AssetsSale = Convert.ToDecimal(AssetsSale);
                        p.InvestmentEtc = Convert.ToDecimal(Etc);

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
                        string excelSeq = PmCashFlowFinancialSeq[j].ToString();

                        string Allocation = item.ItemArray.GetValue(4).ToString();
                        string Increase = item.ItemArray.GetValue(5).ToString();
                        string Borrowing = item.ItemArray.GetValue(6).ToString();
                        string Repayment = item.ItemArray.GetValue(7).ToString();
                        string Etc = item.ItemArray.GetValue(8).ToString();
                        //string yearlyYear = item.ItemArray.GetValue(2).ToString();
                        //string monthly = item.ItemArray.GetValue(3).ToString();
                        //string cumCode = item.ItemArray.GetValue(4).ToString();
                        //string cum = item.ItemArray.GetValue(5).ToString();

                        //string Allocation = item.ItemArray.GetValue(6).ToString();
                        //string Increase = item.ItemArray.GetValue(7).ToString();
                        //string Borrowing = item.ItemArray.GetValue(8).ToString();
                        //string Repayment = item.ItemArray.GetValue(9).ToString();
                        //string Etc = item.ItemArray.GetValue(10).ToString();

                        //if (parentSeq != Seq.ToString()) { bDoubleValue = false; break; }       // 현재 코드와 업로드하려는 코드가 다른 경우는 양식이 잘못된것으로 오류
                        //if (!WebUtil.CheckDecimalTwo(Allocation)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(Increase)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(Borrowing)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(Repayment)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(Etc)) { bDoubleValue = false; break; }

                        PmCashFlowFinancial p = new PmCashFlowFinancial();
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
                    pmCashFlowSalesRepo.update(item);
                }
                foreach (var item in pInvestmentList)
                {
                    pmCashFlowInvestmentRepo.update(item);
                }
                foreach (var item in pFinancialList)
                {
                    pmCashFlowFinancialRepo.update(item);
                }

                // 업데이트 완료 후 로그 남기기
                ExcelFileUploadList eFileList = new ExcelFileUploadList();
                eFileList.UserKey = SessionManager.GetAdminSession().insaUserV.userKey;
                eFileList.EmpNo = SessionManager.GetAdminSession().insaUserV.empNo;
                eFileList.AttachTableName = "PM_CASH_FLOW";
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


        [Route("Excel_Upload3")]
        public ActionResult ExcelUpload3(int Seq
                                      , int OrgCompanySeq
                                      , List<int> PmCashFlowSalesSeq
                                      , List<int> PmCashFlowInvestmentSeq
                                      , List<int> PmCashFlowFinancialSeq
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
                string filePath = "pmCashFlow";
                var file = fileUtil.FileUpload(ExcelFile, filePath);

                bool bDoubleValue = true;
                ExcelUtil excelUtil = new ExcelUtil();
                var ds = excelUtil.ImportExcelDs(file["FILE_PATH"]);

                List<PmCashFlowSales> pSalesList = new List<PmCashFlowSales>();
                List<PmCashFlowInvestment> pInvestmentList = new List<PmCashFlowInvestment>();
                List<PmCashFlowFinancial> pFinancialList = new List<PmCashFlowFinancial>();
                List<PmCashFlowBeCash> pBeCashList = new List<PmCashFlowBeCash>();

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

                    if (ds.Tables["기초기말"] == null || ds.Tables["기초기말"].Rows.Count == 0)
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
                        string excelSeq = PmCashFlowSalesSeq[j].ToString();

                        string OperationProfit = item.ItemArray.GetValue(4).ToString();
                        string DepreciationCost = item.ItemArray.GetValue(5).ToString();
                        string CorpTax = item.ItemArray.GetValue(6).ToString();
                        string Ar = item.ItemArray.GetValue(7).ToString();
                        string Inv = item.ItemArray.GetValue(8).ToString();
                        string Ap = item.ItemArray.GetValue(9).ToString();
                        string Etc = item.ItemArray.GetValue(10).ToString();
                        string InterestExpense = item.ItemArray.GetValue(11).ToString();
                        string InterestIncome = item.ItemArray.GetValue(12).ToString();
            

                        PmCashFlowSales p = new PmCashFlowSales();
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
                        string excelSeq = PmCashFlowInvestmentSeq[j].ToString();

                        string Assets = item.ItemArray.GetValue(4).ToString();
                        string EquityInvestment = item.ItemArray.GetValue(5).ToString();
                        string AssetsSale = item.ItemArray.GetValue(6).ToString();
                        string Etc = item.ItemArray.GetValue(7).ToString();
          

                        PmCashFlowInvestment p = new PmCashFlowInvestment();
                        p.Seq = Convert.ToInt32(excelSeq);
                        p.Assets = Convert.ToDecimal(Assets);
                        p.EquityInvestment = Convert.ToDecimal(EquityInvestment);
                        p.AssetsSale = Convert.ToDecimal(AssetsSale);
                        p.InvestmentEtc = Convert.ToDecimal(Etc);

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
                        string excelSeq = PmCashFlowFinancialSeq[j].ToString();

                        string Allocation = item.ItemArray.GetValue(4).ToString();
                        string Increase = item.ItemArray.GetValue(5).ToString();
                        string Borrowing = item.ItemArray.GetValue(6).ToString();
                        string Repayment = item.ItemArray.GetValue(7).ToString();
                        string Etc = item.ItemArray.GetValue(8).ToString();
  

                        PmCashFlowFinancial p = new PmCashFlowFinancial();
                        p.Seq = Convert.ToInt32(excelSeq);
                        p.Allocation = Convert.ToDecimal(Allocation);
                        p.Increase = Convert.ToDecimal(Increase);
                        p.Borrowing = Convert.ToDecimal(Borrowing);
                        p.Repayment = Convert.ToDecimal(Repayment);
                        p.Etc = Convert.ToDecimal(Etc);

                        pFinancialList.Add(p);
                        j += 1;
                    }


                    j = 0;
                    foreach (DataRow item in ds.Tables["기초기말"].Rows)
                    {
                        string Cumulative = item.ItemArray.GetValue(2).ToString();
                        string CreditLine = item.ItemArray.GetValue(4).ToString();                        

                        PmCashFlowBeCash p = new PmCashFlowBeCash(); 
                        p.PmCashFlowSeq = Seq;
                        p.Cumulative = Convert.ToInt32(Cumulative);
                        p.BasicCash = 0;
                        p.AvailableCash = 0;
                        p.EndingCash = 0;
                        p.CreditLine = Convert.ToDecimal(CreditLine); 
                        pBeCashList.Add(p);
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
                    pmCashFlowSalesRepo.update(item);
                }
                foreach (var item in pInvestmentList)
                {
                    pmCashFlowInvestmentRepo.update(item);
                }
                foreach (var item in pFinancialList)
                {
                    pmCashFlowFinancialRepo.update(item);
                }

                foreach (var item in pBeCashList)
                {
                    pmCashFlowBeCashRepo.insertCum2(item);
                }

                // 업데이트 완료 후 로그 남기기
                ExcelFileUploadList eFileList = new ExcelFileUploadList();
                eFileList.UserKey = SessionManager.GetAdminSession().insaUserV.userKey;
                eFileList.EmpNo = SessionManager.GetAdminSession().insaUserV.empNo;
                eFileList.AttachTableName = "PM_CASH_FLOW";
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