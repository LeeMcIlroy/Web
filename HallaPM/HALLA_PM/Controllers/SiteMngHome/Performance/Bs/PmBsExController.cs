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
    [RoutePrefix("SiteMngHome/Performance/BsEx")]
    public class PmBsExController : SiteMngBaseController
    {
        [Route("List")]
        public ActionResult List(Search search)
        {
            dynamic model = new ExpandoObject();
            search.AuthUserKey = SessionManager.GetAdminSession().insaUserV.userKey;
            model.list = pmBsExRepo.selectList(search);
            model.UnionList = null;
            model.OrgCpyList = null;
            ViewBag.Search = search;
            return View("~/Views/SiteMngHome/Performance/BsEx/List.cshtml", model);
        }
        [Route("Write")]
        public ActionResult Write(PmBsEx entity, Search search)
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");

            // 기본정보
            PmBsEx pmBs = pmBsExRepo.selectOne(entity);
            // 현재기준 부서 정보.
            List<OrgBusiness> orgBusinessList = orgBusinessRepo.selectListCompany(new { Seq = entity.OrgCompanySeq }).ToList();
            OrgCompany orgCompanyName = orgCompanyRepo.selectOne(new { Seq = entity.OrgCompanySeq });

            // BSheet
            PmBsBsheetEx pmBsBsheetEx = new PmBsBsheetEx();
            pmBsBsheetEx.PmBsSeq = entity.Seq;
            string where = " WHERE PM_BS_SEQ = @PmBsSeq ";
            if (pmBsBsheetExRepo.count(pmBsBsheetEx, where) == 0) pmBsBsheetExRepo.insert(pmBsBsheetEx);
            
            // Roic
            PmBsRoicEx pMBsRoicEx = new PmBsRoicEx();
            pMBsRoicEx.PmBsSeq = entity.Seq;
            if (pmBsRoicExRepo.count(pMBsRoicEx, where) == 0) pmBsRoicExRepo.insert(pMBsRoicEx);
            //
            // WCapital
            PmBsWCapitalEx pmBsWCapitalEx = new PmBsWCapitalEx();
            pmBsWCapitalEx.PmBsSeq = entity.Seq;
            if (pmBsWCapitalExRepo.count(pmBsWCapitalEx, where) == 0) pmBsWCapitalExRepo.insert(pmBsWCapitalEx);

            // WCapitalReg
            PmBsWCapitalRegEx PmBsWCapitalRegEx = new PmBsWCapitalRegEx();
            PmBsWCapitalRegEx.PmBsSeq = entity.Seq;
            if (pmBsWCapitalRegExRepo.count(PmBsWCapitalRegEx, where) == 0) pmBsWCapitalRegExRepo.insert(PmBsWCapitalRegEx);

            // 전년도 기말  실적 BSheet
            PmBsBsheetEx lastPmBsheetEx = pmBsBsheetExRepo.selectOneYear(new { BsYear = (Convert.ToInt16(pmBs.BsYear) - 1).ToString(), Monthly = "12", OrgCompanySeq = pmBs.OrgCompanySeq });
            // 당해년도 계획 BSheet
            PlanYearBsBsheetEx thisPnBsheetEx = planYearBsBsheetExRepo.selectOneYear(new { BsYear = pmBs.BsYear, Monthly = pmBs.Monthly, OrgCompanySeq = pmBs.OrgCompanySeq });
            // 당해년도 실적 BSheet
            PmBsBsheetEx thisPmBsheetEx = pmBsBsheetExRepo.selectOne(new { PmBsSeq = entity.Seq });

            // 전년도 기말  실적 Roic
            PmBsRoicEx lastPmRoicEx = pmBsRoicExRepo.selectOneYear(new { BsYear = (Convert.ToInt16(pmBs.BsYear) - 1).ToString(), Monthly = "12", OrgCompanySeq = pmBs.OrgCompanySeq });
            // 당해년도 계획 Roic
            PlanYearBsRoicEx thisPnRoicEx = planYearBsRoicExRepo.selectOneYear(new { BsYear = pmBs.BsYear, Monthly = pmBs.Monthly, OrgCompanySeq = pmBs.OrgCompanySeq });
            // 당해년도 실적 Roic
            PmBsRoicEx thisPmRoicEx = pmBsRoicExRepo.selectOne(new { PmBsSeq = entity.Seq });

            // 전년도 기말  실적 WCapital
            PmBsWCapitalEx lastPmWCapitalEx = pmBsWCapitalExRepo.selectOneYear(new { BsYear = (Convert.ToInt16(pmBs.BsYear) - 1).ToString(), Monthly = "12", OrgCompanySeq = pmBs.OrgCompanySeq });
            // 당해년도 계획 WCapital
            PlanYearBsWCapitalEx thisPnWCapitalEx = planYearBsWCapitalExRepo.selectOneYear(new { BsYear = pmBs.BsYear, Monthly = pmBs.Monthly, OrgCompanySeq = pmBs.OrgCompanySeq });
            // 당해년도 실적 WCapital
            PmBsWCapitalEx thisPmWCapitalEx = pmBsWCapitalExRepo.selectOne(new { PmBsSeq = entity.Seq });


            // 전년도 기말  실적 WCapitalReg
            PmBsWCapitalRegEx lastPmWCapitalRegEx = pmBsWCapitalRegExRepo.selectOneYear(new { BsYear = (Convert.ToInt16(pmBs.BsYear) - 1).ToString(), Monthly = "12", OrgCompanySeq = pmBs.OrgCompanySeq });
            // 당해년도 계획 WCapital
            PlanYearBsWCapitalRegEx thisPnWCapitalRegEx = planYearBsWCapitalRegExRepo.selectOneYear(new { BsYear = pmBs.BsYear, Monthly = pmBs.Monthly, OrgCompanySeq = pmBs.OrgCompanySeq });
            // 당해년도 실적 WCapital
            PmBsWCapitalRegEx thisPmWCapitalRegEx = pmBsWCapitalRegExRepo.selectOne(new { PmBsSeq = entity.Seq });

            // 전년도 실적 누계
            PmBsSummaryEx lastPmSummaryEx = pmBsSummaryExRepo.selectOneYear(new { BsYear = (Convert.ToInt16(pmBs.BsYear) - 1).ToString(), Monthly = "12", OrgCompanySeq = pmBs.OrgCompanySeq });

            dynamic model = new ExpandoObject();
            model.pmBs = pmBs;
            model.orgCompanyName = orgCompanyName;

            model.lastPmBsheetEx = lastPmBsheetEx;
            model.thisPnBsheetEx = thisPnBsheetEx;
            model.thisPmBsheetEx = thisPmBsheetEx;

            model.lastPmRoicEx = lastPmRoicEx;
            model.thisPnRoicEx = thisPnRoicEx;
            model.thisPmRoicEx = thisPmRoicEx;

            model.lastPmWCapitalEx = lastPmWCapitalEx;
            model.thisPnWCapitalEx = thisPnWCapitalEx;
            model.thisPmWCapitalEx = thisPmWCapitalEx;

            model.lastPmWCapitalRegEx = lastPmWCapitalRegEx;
            model.thisPnWCapitalRegEx = thisPnWCapitalRegEx;
            model.thisPmWCapitalRegEx = thisPmWCapitalRegEx;
            model.lastPmSummaryEx = lastPmSummaryEx;

            ViewBag.Search = search;
            return View("~/Views/SiteMngHome/Performance/BsEx/Write.cshtml", model);
        }

        [Route("SalesAccount_Action")]
        public ActionResult SalesAccountAction(PmBsExAdmin entity, Search search)
        {
            #region
            Dictionary<string, object> postData = new Dictionary<string, object>();
            postData.Add("Seq", entity.Seq);
            postData.Add("OrgCompanySeq", entity.OrgCompanySeq);
            postData.Add("message", entity.message);
            postData.Add("PageIndex", search.PageIndex);
            #endregion

            // 부서별 데이터 검증(정수 혹은 소수점 2자리까지의 데이터)
            bool bDoubleValue = true;

            List<PmBsBsheetEx> pBsheetList = new List<PmBsBsheetEx>();
            List<PmBsRoicEx> pRoicList = new List<PmBsRoicEx>();
            List<PmBsWCapitalEx> pWCapitalList = new List<PmBsWCapitalEx>();
            List<PmBsWCapitalRegEx> pWCapitalRegList = new List<PmBsWCapitalRegEx>();

            try
            {
                for (int i = 0; i < entity.PmBsBsheetSeq.Count(); i++)
                {
                    if (!WebUtil.CheckDecimalTwo(entity.Assets[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.CurrentAssets[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.Liabilities[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.CurrentLiabilities[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.Capital[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.Cash[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.Loan[i].ToString())) { bDoubleValue = false; break; }

                    PmBsBsheetEx p = new PmBsBsheetEx();
                    p.Seq = entity.PmBsBsheetSeq[i];
                    p.Assets = entity.Assets[i];
                    p.CurrentAssets = entity.CurrentAssets[i];
                    p.Liabilities = entity.Liabilities[i];
                    p.CurrentLiabilities = entity.CurrentLiabilities[i];
                    p.Capital = entity.Capital[i];
                    p.Cash = entity.Cash[i];
                    p.Loan = entity.Loan[i];

                    pBsheetList.Add(p);
                }

                for (int i = 0; i < entity.PmBsRoicSeq.Count(); i++)
                {
                    if (!WebUtil.CheckDecimalTwo(entity.AfterTaxOperationProfit[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.PainInCapital[i].ToString())) { bDoubleValue = false; break; }

                    PmBsRoicEx p = new PmBsRoicEx();
                    p.Seq = entity.PmBsRoicSeq[i];
                    p.AfterTaxOperationProfit = entity.AfterTaxOperationProfit[i];
                    p.PainInCapital = entity.PainInCapital[i];

                    pRoicList.Add(p);
                }

                for (int i = 0; i < entity.PmBsWCapitalSeq.Count(); i++)
                {
                    if (!WebUtil.CheckDecimalTwo(entity.AnnualSales[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.AnnualSalesCost[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.InventoryCost[i].ToString())) { bDoubleValue = false; break; }

                    PmBsWCapitalEx p = new PmBsWCapitalEx();

                    p.Seq = entity.PmBsWCapitalSeq[i];
                    p.AnnualSales = entity.AnnualSales[i];
                    p.AnnualSalesCost = entity.AnnualSalesCost[i];
                    p.InventoryCost = entity.InventoryCost[i];

                    pWCapitalList.Add(p);
                }

                for (int i = 0; i < entity.PmBsWCapitalRegSeq.Count(); i++)
                {
                    PmBsWCapitalRegEx p = new PmBsWCapitalRegEx();
                    p.Seq = entity.PmBsWCapitalRegSeq[i];
                    p.Ar = entity.Ar[i];
                    p.Ap = entity.Ap[i];
                    p.Inventory = entity.Inventory[i];

                    pWCapitalRegList.Add(p);
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

            // 비율은 저장하지 않아도 되나. 기존 작업에 저장이 되길래 그냥 넣었다.
            foreach (var item in pBsheetList)
            {
                item.LiabilitiesRate = WebUtil.NumberRound(item.Liabilities, item.Capital, 100, 2);
                item.CurrentRate = WebUtil.NumberRound(item.CurrentAssets, item.CurrentLiabilities, 100, 2);
                pmBsBsheetExRepo.update(item);
            }

            foreach (var item in pRoicList)
            {
                item.Roic = WebUtil.NumberRound(item.AfterTaxOperationProfit, item.PainInCapital, 100, 2);
                pmBsRoicExRepo.update(item);
            }

            foreach (var item in pWCapitalList)
            {
                pmBsWCapitalExRepo.update(item);
            }

            foreach (var item in pWCapitalRegList)
            {
                PmBsWCapitalEx p = pWCapitalList.Where(w => w.PmBsSeq == item.PmBsSeq).First();
                if (p == null) { p = new PmBsWCapitalEx(); }
                item.ArToDays = WebUtil.NumberRound(item.Ar, p.AnnualSales, 365, 2);
                item.ApToDays = WebUtil.NumberRound(item.Ap, p.AnnualSalesCost, 365, 2);
                item.InventoryToDays = WebUtil.NumberRound(item.Inventory, p.InventoryCost, 365, 2);
                pmBsWCapitalRegExRepo.update(item);
            }

            return RedirectAndPostActionResult.RedirectAndPost("Write", postData);
        }

        [Route("Calculation_Action")]
        public ActionResult CalculationAction(PmBsExAdmin entity, Search search)
        {
            #region
            Dictionary<string, object> postData = new Dictionary<string, object>();
            postData.Add("Seq", entity.Seq);
            postData.Add("OrgCompanySeq", entity.OrgCompanySeq);
            postData.Add("message", entity.message);
            postData.Add("PageIndex", search.PageIndex);
            #endregion

            // 부서별 데이터 검증(정수 혹은 소수점 2자리까지의 데이터)
            bool bDoubleValue = true;

            List<PmBsBsheetEx> pBsheetList = new List<PmBsBsheetEx>();
            List<PmBsRoicEx> pRoicList = new List<PmBsRoicEx>();
            List<PmBsWCapitalEx> pWCapitalList = new List<PmBsWCapitalEx>();
            List<PmBsWCapitalRegEx> pWCapitalRegList = new List<PmBsWCapitalRegEx>();
            List<PmBsSummaryEx> pSummaryList = new List<PmBsSummaryEx>();

            try
            {
                for (int i = 0; i < entity.PmBsBsheetSeq.Count(); i++)
                {
                    if (!WebUtil.CheckDecimalTwo(entity.Assets[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.CurrentAssets[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.Liabilities[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.CurrentLiabilities[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.Capital[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.Cash[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.Loan[i].ToString())) { bDoubleValue = false; break; }

                    PmBsBsheetEx p = new PmBsBsheetEx();
                    p.Seq = entity.PmBsBsheetSeq[i];
                    p.Assets = entity.Assets[i];
                    p.CurrentAssets = entity.CurrentAssets[i];
                    p.Liabilities = entity.Liabilities[i];
                    p.CurrentLiabilities = entity.CurrentLiabilities[i];
                    p.Capital = entity.Capital[i];
                    p.Cash = entity.Cash[i];
                    p.Loan = entity.Loan[i];

                    pBsheetList.Add(p);
                }

                for (int i = 0; i < entity.PmBsRoicSeq.Count(); i++)
                {
                    if (!WebUtil.CheckDecimalTwo(entity.AfterTaxOperationProfit[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.PainInCapital[i].ToString())) { bDoubleValue = false; break; }

                    PmBsRoicEx p = new PmBsRoicEx();
                    p.Seq = entity.PmBsRoicSeq[i];
                    p.AfterTaxOperationProfit = entity.AfterTaxOperationProfit[i];
                    p.PainInCapital = entity.PainInCapital[i];

                    pRoicList.Add(p);
                }

                for (int i = 0; i < entity.PmBsWCapitalSeq.Count(); i++)
                {
                    if (!WebUtil.CheckDecimalTwo(entity.AnnualSales[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.AnnualSalesCost[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.InventoryCost[i].ToString())) { bDoubleValue = false; break; }

                    PmBsWCapitalEx p = new PmBsWCapitalEx();

                    p.Seq = entity.PmBsWCapitalSeq[i];
                    p.AnnualSales = entity.AnnualSales[i];
                    p.AnnualSalesCost = entity.AnnualSalesCost[i];
                    p.InventoryCost = entity.InventoryCost[i];

                    pWCapitalList.Add(p);
                }

                for (int i = 0; i < entity.PmBsWCapitalRegSeq.Count(); i++)
                {
                    PmBsWCapitalRegEx p = new PmBsWCapitalRegEx();
                    p.Seq = entity.PmBsWCapitalRegSeq[i];
                    p.Ar = entity.Ar[i];
                    p.Ap = entity.Ap[i];
                    p.Inventory = entity.Inventory[i];

                    pWCapitalRegList.Add(p);
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

            // 비율은 저장하지 않아도 되나. 기존 작업에 저장이 되길래 그냥 넣었다.
            foreach (var item in pBsheetList)
            {
                item.LiabilitiesRate = WebUtil.NumberRound(item.Liabilities, item.Capital, 100, 2);
                item.CurrentRate = WebUtil.NumberRound(item.CurrentAssets, item.CurrentLiabilities, 100, 2);
                pmBsBsheetExRepo.update(item);
            }

            foreach (var item in pRoicList)
            {
                item.Roic = WebUtil.NumberRound(item.AfterTaxOperationProfit, item.PainInCapital, 100, 2);
                pmBsRoicExRepo.update(item);
            }

            foreach (var item in pWCapitalList)
            {
                pmBsWCapitalExRepo.update(item);
            }

            foreach (var item in pWCapitalRegList)
            {
                PmBsWCapitalEx p = pWCapitalList.Where(w => w.PmBsSeq == item.PmBsSeq).First();
                if (p == null) { p = new PmBsWCapitalEx(); }
                item.ArToDays = WebUtil.NumberRound(item.Ar, p.AnnualSales, 365, 2);
                item.ApToDays = WebUtil.NumberRound(item.Ap, p.AnnualSalesCost, 365, 2);
                item.InventoryToDays = WebUtil.NumberRound(item.Inventory, p.InventoryCost, 365, 2);
                pmBsWCapitalRegExRepo.update(item);
            }

            // BS요약
            pmBsSummaryExRepo.delete(new { PmBsSeq = entity.Seq });
            PmBsSummaryEx pSummary = new PmBsSummaryEx();
            pSummary.PmBsSeq = entity.Seq;
            pmBsSummaryExRepo.insertCum(pSummary);

            return RedirectAndPostActionResult.RedirectAndPost("Edit", postData);
        }

        [Route("Regist_Status_Change")]
        public ActionResult RegistStatusChange(PmBsEx entity, Search search)
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
            pmBsExRepo.updateRegist(entity);

            // 현재의 상태 변경 후 담당자들에게 메일 발송합니다.(2018.11.08)
            var info = pmBsExRepo.selectOne(entity);

            MailInfo mInfo = new MailInfo();
            // 2019.01.13 결제라인 추가
            mInfo.Seq = entity.Seq;
            mInfo.ReferUrl = Request.UrlReferrer.AbsolutePath.ToString();
            mInfo.afterRegistStatus = entity.afterRegistStatus;
            mInfo.OrgCompanySeq = entity.OrgCompanySeq;
            mInfo.menuName = "Bs - (주)한라예외";
            mInfo.year = info.BsYear;
            mInfo.mm = info.Monthly;
            // 2018.01.03 반려사유 추가
            mInfo.RejectReson = entity.RejectReson;
           // MailUtil.RegistStatusMail(mInfo);
            MailUtilNew.AllComfirmMaillSender(mInfo); /*메일 발송*/

            return RedirectToAction("List", search);
        }

        [Route("Excel_Down")]
        public ActionResult ExcelDown(PmBsEx entity)
        {
            // 기본정보
            PmBsEx pmBs = pmBsExRepo.selectOne(entity);
            OrgCompany orgCompanyName = orgCompanyRepo.selectOne(new { Seq = entity.OrgCompanySeq });
            string fileName = "BS_(주)한라예외_" + pmBs.BsYear + "년_" + orgCompanyName.CompanyName;

            PmBsBsheetEx thisPmBsheetEx = pmBsBsheetExRepo.selectOne(new { PmBsSeq = entity.Seq });
            PmBsRoicEx thisPmRoicEx = pmBsRoicExRepo.selectOne(new { PmBsSeq = entity.Seq });
            PmBsWCapitalEx thisPmWCapitalEx = pmBsWCapitalExRepo.selectOne(new { PmBsSeq = entity.Seq });
            PmBsWCapitalRegEx thisPmWCapitalRegEx = pmBsWCapitalRegExRepo.selectOne(new { PmBsSeq = entity.Seq });

            int rows = 1, cells = 1;
            using (XLWorkbook wb = new XLWorkbook())
            {
                var wsBsheet = wb.Worksheets.Add("BSheet");

                // 컬럼 숨기기
                wsBsheet.Column(1).Hide();
                wsBsheet.Column(2).Hide();

                wsBsheet.Cell(rows, cells).SetValue("ParentSeq").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsBsheet.Cell(rows, ++cells).SetValue("Seq").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsBsheet.Cell(rows, ++cells).SetValue("년도").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsBsheet.Cell(rows, ++cells).SetValue("월").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsBsheet.Cell(rows, ++cells).SetValue("총자산").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsBsheet.Cell(rows, ++cells).SetValue("유동자산").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsBsheet.Cell(rows, ++cells).SetValue("총부채").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsBsheet.Cell(rows, ++cells).SetValue("유동부채").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsBsheet.Cell(rows, ++cells).SetValue("총자본").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsBsheet.Cell(rows, ++cells).SetValue("현금").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsBsheet.Cell(rows, ++cells).SetValue("차입금").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                rows++;
                cells = 1;
                wsBsheet.Cell(rows, cells).SetValue(thisPmBsheetEx.PmBsSeq).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsBsheet.Cell(rows, ++cells).SetValue(thisPmBsheetEx.Seq).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsBsheet.Cell(rows, ++cells).SetValue(pmBs.BsYear).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsBsheet.Cell(rows, ++cells).SetValue(pmBs.Monthly).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsBsheet.Cell(rows, ++cells).SetValue(thisPmBsheetEx.Assets).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsBsheet.Cell(rows, ++cells).SetValue(thisPmBsheetEx.CurrentAssets).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsBsheet.Cell(rows, ++cells).SetValue(thisPmBsheetEx.Liabilities).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsBsheet.Cell(rows, ++cells).SetValue(thisPmBsheetEx.CurrentLiabilities).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsBsheet.Cell(rows, ++cells).SetValue(thisPmBsheetEx.Capital).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsBsheet.Cell(rows, ++cells).SetValue(thisPmBsheetEx.Cash).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsBsheet.Cell(rows, ++cells).SetValue(thisPmBsheetEx.Loan).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);

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

                rows++;
                cells = 1;
                wsRoic.Cell(rows, cells).SetValue(thisPmRoicEx.PmBsSeq).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsRoic.Cell(rows, ++cells).SetValue(thisPmRoicEx.Seq).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsRoic.Cell(rows, ++cells).SetValue(pmBs.BsYear).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsRoic.Cell(rows, ++cells).SetValue(pmBs.Monthly).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsRoic.Cell(rows, ++cells).SetValue(thisPmRoicEx.AfterTaxOperationProfit).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsRoic.Cell(rows, ++cells).SetValue(thisPmRoicEx.PainInCapital).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                rows = 1;
                cells = 1;
                var wsWcapital = wb.Worksheets.Add("W_Capital");

                // 컬럼 숨기기
                wsWcapital.Column(1).Hide();
                wsWcapital.Column(2).Hide();

                wsWcapital.Cell(rows, cells).SetValue("ParentSeq").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsWcapital.Cell(rows, ++cells).SetValue("Seq").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsWcapital.Cell(rows, ++cells).SetValue("년도").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsWcapital.Cell(rows, ++cells).SetValue("연간매출액").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsWcapital.Cell(rows, ++cells).SetValue("연간매출원가(AP)").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsWcapital.Cell(rows, ++cells).SetValue("연간매출원가(Inv)").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                rows++;
                cells = 1;
                wsWcapital.Cell(rows, cells).SetValue(thisPmWCapitalEx.PmBsSeq).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsWcapital.Cell(rows, ++cells).SetValue(thisPmWCapitalEx.Seq).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsWcapital.Cell(rows, ++cells).SetValue(pmBs.BsYear).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsWcapital.Cell(rows, ++cells).SetValue(thisPmWCapitalEx.AnnualSales).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsWcapital.Cell(rows, ++cells).SetValue(thisPmWCapitalEx.AnnualSalesCost).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsWcapital.Cell(rows, ++cells).SetValue(thisPmWCapitalEx.InventoryCost).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);

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
                wsWcapitalReg.Cell(rows, ++cells).SetValue("Ap").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsWcapitalReg.Cell(rows, ++cells).SetValue("Inventory").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                rows++;
                cells = 1;
                wsWcapitalReg.Cell(rows, cells).SetValue(thisPmWCapitalRegEx.PmBsSeq).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsWcapitalReg.Cell(rows, ++cells).SetValue(thisPmWCapitalRegEx.Seq).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsWcapitalReg.Cell(rows, ++cells).SetValue(pmBs.BsYear).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsWcapitalReg.Cell(rows, ++cells).SetValue(pmBs.Monthly).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsWcapitalReg.Cell(rows, ++cells).SetValue(thisPmWCapitalRegEx.Ar).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsWcapitalReg.Cell(rows, ++cells).SetValue(thisPmWCapitalRegEx.Ap).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsWcapitalReg.Cell(rows, ++cells).SetValue(thisPmWCapitalRegEx.Inventory).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                using (MemoryStream mStream = new MemoryStream())
                {
                    wb.SaveAs(mStream);
                    return File(mStream.ToArray(), "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", fileName + ".xlsx");
                }
            }
        }



        [Route("Excel_Down2")]
        public ActionResult ExcelDown2(PmBsEx entity)
        {
            // 기본정보
            PmBsEx pmBs = pmBsExRepo.selectOne(entity);
            OrgCompany orgCompanyName = orgCompanyRepo.selectOne(new { Seq = entity.OrgCompanySeq });
            string fileName = "BS_(주)한라예외_" + pmBs.BsYear + "년_" + orgCompanyName.CompanyName;

            PmBsBsheetEx thisPmBsheetEx = pmBsBsheetExRepo.selectOne(new { PmBsSeq = entity.Seq });
            PmBsRoicEx thisPmRoicEx = pmBsRoicExRepo.selectOne(new { PmBsSeq = entity.Seq });
            PmBsWCapitalEx thisPmWCapitalEx = pmBsWCapitalExRepo.selectOne(new { PmBsSeq = entity.Seq });
            PmBsWCapitalRegEx thisPmWCapitalRegEx = pmBsWCapitalRegExRepo.selectOne(new { PmBsSeq = entity.Seq });

            int rows = 1, cells = 1;
            using (XLWorkbook wb = new XLWorkbook())
            {
                var wsBsheet = wb.Worksheets.Add("BSheet");

                // 컬럼 숨기기
                //wsBsheet.Column(1).Hide();
                //wsBsheet.Column(2).Hide();

               // wsBsheet.Cell(rows, cells).SetValue("ParentSeq").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                //wsBsheet.Cell(rows, ++cells).SetValue("Seq").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsBsheet.Cell(rows, cells).SetValue("년도").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsBsheet.Cell(rows, ++cells).SetValue("월").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsBsheet.Cell(rows, ++cells).SetValue("총자산").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsBsheet.Cell(rows, ++cells).SetValue("유동자산").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsBsheet.Cell(rows, ++cells).SetValue("총부채").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsBsheet.Cell(rows, ++cells).SetValue("유동부채").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsBsheet.Cell(rows, ++cells).SetValue("총자본").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsBsheet.Cell(rows, ++cells).SetValue("현금").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsBsheet.Cell(rows, ++cells).SetValue("차입금").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                rows++;
                cells = 1;
                //wsBsheet.Cell(rows, cells).SetValue(thisPmBsheetEx.PmBsSeq).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                //wsBsheet.Cell(rows, ++cells).SetValue(thisPmBsheetEx.Seq).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsBsheet.Cell(rows, cells).SetValue(pmBs.BsYear).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsBsheet.Cell(rows, ++cells).SetValue(pmBs.Monthly).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsBsheet.Cell(rows, ++cells).SetValue(thisPmBsheetEx.Assets).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsBsheet.Cell(rows, ++cells).SetValue(thisPmBsheetEx.CurrentAssets).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsBsheet.Cell(rows, ++cells).SetValue(thisPmBsheetEx.Liabilities).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsBsheet.Cell(rows, ++cells).SetValue(thisPmBsheetEx.CurrentLiabilities).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsBsheet.Cell(rows, ++cells).SetValue(thisPmBsheetEx.Capital).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsBsheet.Cell(rows, ++cells).SetValue(thisPmBsheetEx.Cash).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsBsheet.Cell(rows, ++cells).SetValue(thisPmBsheetEx.Loan).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                rows = 1;
                cells = 1;
                var wsRoic = wb.Worksheets.Add("ROIC");

                // 컬럼 숨기기
                //wsRoic.Column(1).Hide();
                //wsRoic.Column(2).Hide();

                //wsRoic.Cell(rows, cells).SetValue("ParentSeq").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                //wsRoic.Cell(rows, ++cells).SetValue("Seq").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsRoic.Cell(rows, cells).SetValue("년도").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsRoic.Cell(rows, ++cells).SetValue("월").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsRoic.Cell(rows, ++cells).SetValue("세후영업이익").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsRoic.Cell(rows, ++cells).SetValue("투하자본").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                rows++;
                cells = 1;
                //wsRoic.Cell(rows, cells).SetValue(thisPmRoicEx.PmBsSeq).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                //wsRoic.Cell(rows, ++cells).SetValue(thisPmRoicEx.Seq).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsRoic.Cell(rows, cells).SetValue(pmBs.BsYear).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsRoic.Cell(rows, ++cells).SetValue(pmBs.Monthly).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsRoic.Cell(rows, ++cells).SetValue(thisPmRoicEx.AfterTaxOperationProfit).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsRoic.Cell(rows, ++cells).SetValue(thisPmRoicEx.PainInCapital).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                rows = 1;
                cells = 1;
                var wsWcapital = wb.Worksheets.Add("W_Capital");

                // 컬럼 숨기기
                //wsWcapital.Column(1).Hide();
                //wsWcapital.Column(2).Hide();

                //wsWcapital.Cell(rows, cells).SetValue("ParentSeq").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                //wsWcapital.Cell(rows, ++cells).SetValue("Seq").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsWcapital.Cell(rows, cells).SetValue("년도").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsWcapital.Cell(rows, ++cells).SetValue("연간매출액").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsWcapital.Cell(rows, ++cells).SetValue("연간매출원가(AP)").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsWcapital.Cell(rows, ++cells).SetValue("연간매출원가(Inv)").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                rows++;
                cells = 1;
                //wsWcapital.Cell(rows, cells).SetValue(thisPmWCapitalEx.PmBsSeq).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                //wsWcapital.Cell(rows, ++cells).SetValue(thisPmWCapitalEx.Seq).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsWcapital.Cell(rows, cells).SetValue(pmBs.BsYear).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsWcapital.Cell(rows, ++cells).SetValue(thisPmWCapitalEx.AnnualSales).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsWcapital.Cell(rows, ++cells).SetValue(thisPmWCapitalEx.AnnualSalesCost).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsWcapital.Cell(rows, ++cells).SetValue(thisPmWCapitalEx.InventoryCost).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                rows = 1;
                cells = 1;
                var wsWcapitalReg = wb.Worksheets.Add("W_Capital_Reg");

                // 컬럼 숨기기
                //wsWcapitalReg.Column(1).Hide();
                //wsWcapitalReg.Column(2).Hide();

                //wsWcapitalReg.Cell(rows, cells).SetValue("ParentSeq").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                //wsWcapitalReg.Cell(rows, ++cells).SetValue("Seq").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsWcapitalReg.Cell(rows, cells).SetValue("년도").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsWcapitalReg.Cell(rows, ++cells).SetValue("월").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsWcapitalReg.Cell(rows, ++cells).SetValue("Ar").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsWcapitalReg.Cell(rows, ++cells).SetValue("Ap").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsWcapitalReg.Cell(rows, ++cells).SetValue("Inventory").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                rows++;
                cells = 1;
                //wsWcapitalReg.Cell(rows, cells).SetValue(thisPmWCapitalRegEx.PmBsSeq).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                //wsWcapitalReg.Cell(rows, ++cells).SetValue(thisPmWCapitalRegEx.Seq).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsWcapitalReg.Cell(rows, cells).SetValue(pmBs.BsYear).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsWcapitalReg.Cell(rows, ++cells).SetValue(pmBs.Monthly).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsWcapitalReg.Cell(rows, ++cells).SetValue(thisPmWCapitalRegEx.Ar).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsWcapitalReg.Cell(rows, ++cells).SetValue(thisPmWCapitalRegEx.Ap).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsWcapitalReg.Cell(rows, ++cells).SetValue(thisPmWCapitalRegEx.Inventory).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);

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

            bool result = false;
            string resultMsg = ""; if (ExcelFile.ContentLength != 0)
            {
                FileUtil fileUtil = new FileUtil(Define.FILE_PATH);
                string filePath = "PmBsEx";
                var file = fileUtil.FileUpload(ExcelFile, filePath);

                bool bDoubleValue = true;
                ExcelUtil excelUtil = new ExcelUtil();
                var ds = excelUtil.ImportExcelDs(file["FILE_PATH"]);
                
                List<PmBsBsheetEx> pBsheetList = new List<PmBsBsheetEx>();
                List<PmBsRoicEx> pRoicList = new List<PmBsRoicEx>();
                List<PmBsWCapitalEx> pWCapitalList = new List<PmBsWCapitalEx>();
                List<PmBsWCapitalRegEx> pWCapitalRegList = new List<PmBsWCapitalRegEx>();

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

                        if (parentSeq != Seq.ToString()) { bDoubleValue = false; break; }       // 현재 코드와 업로드하려는 코드가 다른 경우는 양식이 잘못된것으로 오류
                        //if (!WebUtil.CheckDecimalTwo(Assets)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(CurrentAssets)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(Liabilities)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(CurrentLiabilities)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(Capital)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(Cash)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(Loan)) { bDoubleValue = false; break; }

                        PmBsBsheetEx p = new PmBsBsheetEx();
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
                        pBsheetList.Add(p);
                    }

                    foreach (DataRow item in ds.Tables["ROIC"].Rows)
                    {
                        string parentSeq = item.ItemArray.GetValue(0).ToString();
                        string excelSeq = item.ItemArray.GetValue(1).ToString();
                        string yearlyYear = item.ItemArray.GetValue(2).ToString();
                        string monthly = item.ItemArray.GetValue(3).ToString();

                        string AfterTaxOperationProfit = item.ItemArray.GetValue(4).ToString();
                        string PainInCapital = item.ItemArray.GetValue(5).ToString();

                        if (parentSeq != Seq.ToString()) { bDoubleValue = false; break; }       // 현재 코드와 업로드하려는 코드가 다른 경우는 양식이 잘못된것으로 오류
                        //if (!WebUtil.CheckDecimalTwo(AfterTaxOperationProfit)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(PainInCapital)) { bDoubleValue = false; break; }

                        PmBsRoicEx p = new PmBsRoicEx();
                        p.Seq = Convert.ToInt32(excelSeq);
                        p.AfterTaxOperationProfit = Convert.ToDecimal(AfterTaxOperationProfit);
                        p.PainInCapital = Convert.ToDecimal(PainInCapital);
                        p.Roic = 0;

                        pRoicList.Add(p);
                    }

                    foreach (DataRow item in ds.Tables["W_Capital"].Rows)
                    {
                        string parentSeq = item.ItemArray.GetValue(0).ToString();
                        string excelSeq = item.ItemArray.GetValue(1).ToString();
                        string yearlyYear = item.ItemArray.GetValue(2).ToString();

                        string AnnualSales = item.ItemArray.GetValue(3).ToString();
                        string AnnualSalesCost = item.ItemArray.GetValue(4).ToString();
                        string InventoryCost = item.ItemArray.GetValue(5).ToString();

                        if (parentSeq != Seq.ToString()) { bDoubleValue = false; break; }       // 현재 코드와 업로드하려는 코드가 다른 경우는 양식이 잘못된것으로 오류
                        //if (!WebUtil.CheckDecimalTwo(AnnualSales)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(AnnualSalesCost)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(InventoryCost)) { bDoubleValue = false; break; }

                        PmBsWCapitalEx p = new PmBsWCapitalEx();
                        p.Seq = Convert.ToInt32(excelSeq);
                        p.AnnualSales = Convert.ToDecimal(AnnualSales);
                        p.AnnualSalesCost = Convert.ToDecimal(AnnualSalesCost);
                        p.InventoryCost = Convert.ToDecimal(InventoryCost);
                        pWCapitalList.Add(p);
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

                        if (parentSeq != Seq.ToString()) { bDoubleValue = false; break; }       // 현재 코드와 업로드하려는 코드가 다른 경우는 양식이 잘못된것으로 오류
                        //if (!WebUtil.CheckDecimalTwo(Ar)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(Ap)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(Inventory)) { bDoubleValue = false; break; }

                        PmBsWCapitalRegEx p = new PmBsWCapitalRegEx();
                        p.Seq = Convert.ToInt32(excelSeq);
                        p.Ar = Convert.ToDecimal(Ar);
                        p.ArToDays = 0;
                        p.Ap = Convert.ToDecimal(Ap);
                        p.ApToDays = 0;
                        p.Inventory = Convert.ToDecimal(Inventory);
                        p.InventoryToDays = 0;

                        pWCapitalRegList.Add(p);
                    }
                }
                catch (Exception)
                {
                    fileUtil.FileDelete(filePath, file["STORED_FILE_NAME"]);
                    result = false;
                    resultMsg = Message.MSG_007_E;
                    return Json(new { success = result, resultMsg = resultMsg }, JsonRequestBehavior.AllowGet);
                }

                if (!bDoubleValue)
                {
                    fileUtil.FileDelete(filePath, file["STORED_FILE_NAME"]);
                    result = false;
                    resultMsg = Message.MSG_007_E;
                    return Json(new { success = result, resultMsg = resultMsg }, JsonRequestBehavior.AllowGet);
                }

                // 비율은 저장하지 않아도 되나. 기존 작업에 저장이 되길래 그냥 넣었다.
                foreach (var item in pBsheetList)
                {
                    item.LiabilitiesRate = WebUtil.NumberRound(item.Liabilities, item.Capital, 100, 2);
                    item.CurrentRate = WebUtil.NumberRound(item.CurrentAssets, item.CurrentLiabilities, 100, 2);
                    pmBsBsheetExRepo.update(item);
                }

                foreach (var item in pRoicList)
                {
                    item.Roic = WebUtil.NumberRound(item.AfterTaxOperationProfit, item.PainInCapital, 100, 2);
                    pmBsRoicExRepo.update(item);
                }

                foreach (var item in pWCapitalList)
                {
                    pmBsWCapitalExRepo.update(item);
                }

                foreach (var item in pWCapitalRegList)
                {
                    PmBsWCapitalEx p = pWCapitalList.Where(w => w.PmBsSeq == item.PmBsSeq).First();
                    if (p == null) { p = new PmBsWCapitalEx(); }
                    item.ArToDays = WebUtil.NumberRound(item.Ar, p.AnnualSales, 365, 2);
                    item.ApToDays = WebUtil.NumberRound(item.Ap, p.AnnualSalesCost, 365, 2);
                    item.InventoryToDays = WebUtil.NumberRound(item.Inventory, p.InventoryCost, 365, 2);
                    pmBsWCapitalRegExRepo.update(item);
                }

                // 업데이트 완료 후 로그 남기기
                ExcelFileUploadList eFileList = new ExcelFileUploadList();
                eFileList.UserKey = SessionManager.GetAdminSession().insaUserV.userKey;
                eFileList.EmpNo = SessionManager.GetAdminSession().insaUserV.empNo;
                eFileList.AttachTableName = "PM_BS_EX";
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

        [Route("Edit")]
        public ActionResult Edit(PmBsEx entity, Search search)
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");

            // 기본정보
            PmBsEx pmBs = pmBsExRepo.selectOne(entity);
            // 현재기준 부서 정보.
            List<OrgBusiness> orgBusinessList = orgBusinessRepo.selectListCompany(new { Seq = entity.OrgCompanySeq }).ToList();
            OrgCompany orgCompanyName = orgCompanyRepo.selectOne(new { Seq = entity.OrgCompanySeq });

            // 전년도 기말  실적 BSheet
            PmBsBsheetEx lastPmBsheetEx = pmBsBsheetExRepo.selectOneYear(new { BsYear = (Convert.ToInt16(pmBs.BsYear) - 1).ToString(), Monthly = "12", OrgCompanySeq = pmBs.OrgCompanySeq });
            // 당해년도 계획 BSheet
            PlanYearBsBsheetEx thisPnBsheetEx = planYearBsBsheetExRepo.selectOneYear(new { BsYear = pmBs.BsYear, Monthly = pmBs.Monthly, OrgCompanySeq = pmBs.OrgCompanySeq });
            // 당해년도 실적 BSheet
            PmBsBsheetEx thisPmBsheetEx = pmBsBsheetExRepo.selectOne(new { PmBsSeq = entity.Seq });

            // 전년도 기말  실적 Roic
            PmBsRoicEx lastPmRoicEx = pmBsRoicExRepo.selectOneYear(new { BsYear = (Convert.ToInt16(pmBs.BsYear) - 1).ToString(), Monthly = "12", OrgCompanySeq = pmBs.OrgCompanySeq });
            // 당해년도 계획 Roic
            PlanYearBsRoicEx thisPnRoicEx = planYearBsRoicExRepo.selectOneYear(new { BsYear = pmBs.BsYear, Monthly = pmBs.Monthly, OrgCompanySeq = pmBs.OrgCompanySeq });
            // 당해년도 실적 Roic
            PmBsRoicEx thisPmRoicEx = pmBsRoicExRepo.selectOne(new { PmBsSeq = entity.Seq });

            // 전년도 기말  실적 WCapital
            PmBsWCapitalEx lastPmWCapitalEx = pmBsWCapitalExRepo.selectOneYear(new { BsYear = (Convert.ToInt16(pmBs.BsYear) - 1).ToString(), Monthly = "12", OrgCompanySeq = pmBs.OrgCompanySeq });
            // 당해년도 계획 WCapital
            PlanYearBsWCapitalEx thisPnWCapitalEx = planYearBsWCapitalExRepo.selectOneYear(new { BsYear = pmBs.BsYear, Monthly = pmBs.Monthly, OrgCompanySeq = pmBs.OrgCompanySeq });
            // 당해년도 실적 WCapital
            PmBsWCapitalEx thisPmWCapitalEx = pmBsWCapitalExRepo.selectOne(new { PmBsSeq = entity.Seq });


            // 전년도 기말  실적 WCapitalReg
            PmBsWCapitalRegEx lastPmWCapitalRegEx = pmBsWCapitalRegExRepo.selectOneYear(new { BsYear = (Convert.ToInt16(pmBs.BsYear) - 1).ToString(), Monthly = "12", OrgCompanySeq = pmBs.OrgCompanySeq });
            // 당해년도 계획 WCapital
            PlanYearBsWCapitalRegEx thisPnWCapitalRegEx = planYearBsWCapitalRegExRepo.selectOneYear(new { BsYear = pmBs.BsYear, Monthly = pmBs.Monthly, OrgCompanySeq = pmBs.OrgCompanySeq });
            // 당해년도 실적 WCapital
            PmBsWCapitalRegEx thisPmWCapitalRegEx = pmBsWCapitalRegExRepo.selectOne(new { PmBsSeq = entity.Seq });

            // 전년도 실적 누계
            PmBsSummaryEx lastPmSummaryEx = pmBsSummaryExRepo.selectOneYear(new { BsYear = (Convert.ToInt16(pmBs.BsYear) - 1).ToString(), Monthly = "12", OrgCompanySeq = pmBs.OrgCompanySeq });
            PlanYearBsSummaryEx thisPnSummaryEx = planYearBsSummaryExRepo.selectOneYear(new { BsYear = pmBs.BsYear, Monthly = pmBs.Monthly, OrgCompanySeq = pmBs.OrgCompanySeq });
            PmBsSummaryEx thisPmSummaryEx = pmBsSummaryExRepo.selectOne(new { PmBsSeq = entity.Seq });

            dynamic model = new ExpandoObject();
            model.pmBs = pmBs;
            model.orgCompanyName = orgCompanyName;

            model.lastPmBsheetEx = lastPmBsheetEx;
            model.thisPnBsheetEx = thisPnBsheetEx;
            model.thisPmBsheetEx = thisPmBsheetEx;

            model.lastPmRoicEx = lastPmRoicEx;
            model.thisPnRoicEx = thisPnRoicEx;
            model.thisPmRoicEx = thisPmRoicEx;

            model.lastPmWCapitalEx = lastPmWCapitalEx;
            model.thisPnWCapitalEx = thisPnWCapitalEx;
            model.thisPmWCapitalEx = thisPmWCapitalEx;

            model.lastPmWCapitalRegEx = lastPmWCapitalRegEx;
            model.thisPnWCapitalRegEx = thisPnWCapitalRegEx;
            model.thisPmWCapitalRegEx = thisPmWCapitalRegEx;

            model.lastPmSummaryEx = lastPmSummaryEx;
            model.thisPnSummaryEx = thisPnSummaryEx;
            model.thisPmSummaryEx = thisPmSummaryEx;

            if (entity.message != null)
            {
                TempData["alert"] = entity.message;
            }

            ViewBag.Search = search;
            return View("~/Views/SiteMngHome/Performance/BsEx/Edit.cshtml", model);
        }

        // 2019.01.08 중간관리자2 프로세스 추가
        [Route("Edit2")]
        public ActionResult Edit2(PmBsEx entity, Search search)
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");

            // 기본정보
            PmBsEx pmBs = pmBsExRepo.selectOne(entity);
            // 현재기준 부서 정보.
            List<OrgBusiness> orgBusinessList = orgBusinessRepo.selectListCompany(new { Seq = entity.OrgCompanySeq }).ToList();
            OrgCompany orgCompanyName = orgCompanyRepo.selectOne(new { Seq = entity.OrgCompanySeq });
            
            // 전년도 실적 누계
            PmBsSummaryEx lastPmSummaryEx = pmBsSummaryExRepo.selectOneYear(new { BsYear = (Convert.ToInt16(pmBs.BsYear) - 1).ToString(), Monthly = "12", OrgCompanySeq = pmBs.OrgCompanySeq });
            PlanYearBsSummaryEx thisPnSummaryEx = planYearBsSummaryExRepo.selectOneYear(new { BsYear = pmBs.BsYear, Monthly = pmBs.Monthly, OrgCompanySeq = pmBs.OrgCompanySeq });
            PmBsSummaryEx thisPmSummaryEx = pmBsSummaryExRepo.selectOne(new { PmBsSeq = entity.Seq });

            dynamic model = new ExpandoObject();
            model.pmBs = pmBs;
            model.orgCompanyName = orgCompanyName;

            model.lastPmSummaryEx = lastPmSummaryEx;
            model.thisPnSummaryEx = thisPnSummaryEx;
            model.thisPmSummaryEx = thisPmSummaryEx;

            if (entity.message != null)
            {
                TempData["alert"] = entity.message;
            }

            ViewBag.Search = search;
            return View("~/Views/SiteMngHome/Performance/BsEx/Edit2.cshtml", model);
        }

        [Route("Edit_Action")]
        public ActionResult EditAction(PmBsExAdmin entity, Search search)
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");

            #region
            Dictionary<string, object> postData = new Dictionary<string, object>();
            postData.Add("Seq", entity.Seq);
            postData.Add("OrgCompanySeq", entity.OrgCompanySeq);
            postData.Add("message", Message.MSG_007_A);
            postData.Add("PageIndex", search.PageIndex);
            #endregion

            // 부서별 데이터 검증(정수 혹은 소수점 2자리까지의 데이터)
            bool bDoubleValue = true;

            List<PmBsBsheetEx> pBsheetList = new List<PmBsBsheetEx>();
            List<PmBsRoicEx> pRoicList = new List<PmBsRoicEx>();
            List<PmBsWCapitalEx> pWCapitalList = new List<PmBsWCapitalEx>();
            List<PmBsWCapitalRegEx> pWCapitalRegList = new List<PmBsWCapitalRegEx>();
            List<PmBsSummaryEx> pSummaryList = new List<PmBsSummaryEx>();

            try
            {
                for (int i = 0; i < entity.PmBsBsheetSeq.Count(); i++)
                {
                    if (!WebUtil.CheckDecimalTwo(entity.Assets[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.CurrentAssets[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.Liabilities[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.CurrentLiabilities[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.Capital[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.Cash[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.Loan[i].ToString())) { bDoubleValue = false; break; }

                    PmBsBsheetEx p = new PmBsBsheetEx();
                    p.Seq = entity.PmBsBsheetSeq[i];
                    p.Assets = entity.Assets[i];
                    p.CurrentAssets = entity.CurrentAssets[i];
                    p.Liabilities = entity.Liabilities[i];
                    p.CurrentLiabilities = entity.CurrentLiabilities[i];
                    p.Capital = entity.Capital[i];
                    p.Cash = entity.Cash[i];
                    p.Loan = entity.Loan[i];

                    pBsheetList.Add(p);
                }

                for (int i = 0; i < entity.PmBsRoicSeq.Count(); i++)
                {
                    if (!WebUtil.CheckDecimalTwo(entity.AfterTaxOperationProfit[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.PainInCapital[i].ToString())) { bDoubleValue = false; break; }

                    PmBsRoicEx p = new PmBsRoicEx();
                    p.Seq = entity.PmBsRoicSeq[i];
                    p.AfterTaxOperationProfit = entity.AfterTaxOperationProfit[i];
                    p.PainInCapital = entity.PainInCapital[i];

                    pRoicList.Add(p);
                }

                for (int i = 0; i < entity.PmBsWCapitalSeq.Count(); i++)
                {
                    if (!WebUtil.CheckDecimalTwo(entity.AnnualSales[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.AnnualSalesCost[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.InventoryCost[i].ToString())) { bDoubleValue = false; break; }

                    PmBsWCapitalEx p = new PmBsWCapitalEx();

                    p.Seq = entity.PmBsWCapitalSeq[i];
                    p.AnnualSales = entity.AnnualSales[i];
                    p.AnnualSalesCost = entity.AnnualSalesCost[i];
                    p.InventoryCost = entity.InventoryCost[i];

                    pWCapitalList.Add(p);
                }

                for (int i = 0; i < entity.PmBsWCapitalRegSeq.Count(); i++)
                {
                    PmBsWCapitalRegEx p = new PmBsWCapitalRegEx();
                    p.Seq = entity.PmBsWCapitalRegSeq[i];
                    p.Ar = entity.Ar[i];
                    p.Ap = entity.Ap[i];
                    p.Inventory = entity.Inventory[i];

                    pWCapitalRegList.Add(p);
                }

                for (int i = 0; i < entity.PmBsSummarySeq.Count(); i++)
                {
                    if (!WebUtil.CheckDecimalTwo(entity.SummaryAssets[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.SummaryLiabilities[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.SummaryCapital[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.SummaryCash[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.SummaryLoan[i].ToString())) { bDoubleValue = false; break; }
                    //if (!WebUtil.CheckDecimalTwo(entity.SummaryLiabilitiesRate[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.SummaryAfterTaxOperationProfit[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.SummaryPainInCapital[i].ToString())) { bDoubleValue = false; break; }
                    //if (!WebUtil.CheckDecimalTwo(entity.SummaryRoic[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.SummaryAr[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.SummaryArToDays[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.SummaryAp[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.SummaryApToDays[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.SummaryInventory[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.SummaryInventoryToDays[i].ToString())) { bDoubleValue = false; break; }

                    PmBsSummaryEx pSummary = new PmBsSummaryEx();
                    pSummary.Seq = entity.PmBsSummarySeq[i];
                    pSummary.Assets = entity.SummaryAssets[i];
                    pSummary.Liabilities = entity.SummaryLiabilities[i];
                    pSummary.Capital = entity.SummaryCapital[i];
                    pSummary.Cash = entity.SummaryCash[i];
                    pSummary.Loan = entity.SummaryLoan[i];
                    //pSummary.LiabilitiesRate = entity.SummaryLiabilitiesRate[i];
                    pSummary.AfterTaxOperationProfit = entity.SummaryAfterTaxOperationProfit[i];
                    pSummary.PainInCapital = entity.SummaryPainInCapital[i];
                    //pSummary.Roic = entity.SummaryRoic[i];
                    pSummary.Ar = entity.SummaryAr[i];
                    pSummary.ArToDays = entity.SummaryArToDays[i];
                    pSummary.Ap = entity.SummaryAp[i];
                    pSummary.ApToDays = entity.SummaryApToDays[i];
                    pSummary.Inventory = entity.SummaryInventory[i];
                    pSummary.InventoryToDays = entity.SummaryInventoryToDays[i];

                    pSummaryList.Add(pSummary);
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

            // 비율은 저장하지 않아도 되나. 기존 작업에 저장이 되길래 그냥 넣었다.
            foreach (var item in pBsheetList)
            {
                item.LiabilitiesRate = WebUtil.NumberRound(item.Liabilities, item.Capital, 100, 2);
                item.CurrentRate = WebUtil.NumberRound(item.CurrentAssets, item.CurrentLiabilities, 100, 2);
                pmBsBsheetExRepo.update(item);
            }

            foreach (var item in pRoicList)
            {
                item.Roic = WebUtil.NumberRound(item.AfterTaxOperationProfit, item.PainInCapital, 100, 2);
                pmBsRoicExRepo.update(item);
            }

            foreach (var item in pWCapitalList)
            {
                pmBsWCapitalExRepo.update(item);
            }

            foreach (var item in pWCapitalRegList)
            {
                PmBsWCapitalEx p = pWCapitalList.Where(w => w.PmBsSeq == item.PmBsSeq).First();
                if (p == null) { p = new PmBsWCapitalEx(); }
                item.ArToDays = WebUtil.NumberRound(item.Ar, p.AnnualSales, 365, 2);
                item.ApToDays = WebUtil.NumberRound(item.Ap, p.AnnualSalesCost, 365, 2);
                item.InventoryToDays = WebUtil.NumberRound(item.Inventory, p.InventoryCost, 365, 2);
                pmBsWCapitalRegExRepo.update(item);
            }

            foreach (var item in pSummaryList)
            {
                pmBsSummaryExRepo.update(item);
            }


            // 미저장에서 저장으로 변경
            if (entity.RegistStatus == Define.REGIST_STATUS.GetKey("미등록"))
            {
                entity.RegistStatus = Define.REGIST_STATUS.GetKey("저장");
                PmBsEx p = new PmBsEx();
                p.Seq = entity.Seq;
                p.RegistStatus = entity.RegistStatus;
                pmBsExRepo.updateRegist(p);
            }

            return RedirectAndPostActionResult.RedirectAndPost("Edit", postData);
        }

        [Route("View")]
        public ActionResult view(PmBsEx entity, Search search)
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");

            // 기본정보
            PmBsEx pmBs = pmBsExRepo.selectOne(entity);
            // 현재기준 부서 정보.
            List<OrgBusiness> orgBusinessList = orgBusinessRepo.selectListCompany(new { Seq = entity.OrgCompanySeq }).ToList();
            OrgCompany orgCompanyName = orgCompanyRepo.selectOne(new { Seq = entity.OrgCompanySeq });

            // 전년도 기말  실적 BSheet
            PmBsBsheetEx lastPmBsheetEx = pmBsBsheetExRepo.selectOneYear(new { BsYear = (Convert.ToInt16(pmBs.BsYear) - 1).ToString(), Monthly = "12", OrgCompanySeq = pmBs.OrgCompanySeq });
            // 당해년도 계획 BSheet
            PlanYearBsBsheetEx thisPnBsheetEx = planYearBsBsheetExRepo.selectOneYear(new { BsYear = pmBs.BsYear, Monthly = pmBs.Monthly, OrgCompanySeq = pmBs.OrgCompanySeq });
            // 당해년도 실적 BSheet
            PmBsBsheetEx thisPmBsheetEx = pmBsBsheetExRepo.selectOne(new { PmBsSeq = entity.Seq });

            // 전년도 기말  실적 Roic
            PmBsRoicEx lastPmRoicEx = pmBsRoicExRepo.selectOneYear(new { BsYear = (Convert.ToInt16(pmBs.BsYear) - 1).ToString(), Monthly = "12", OrgCompanySeq = pmBs.OrgCompanySeq });
            // 당해년도 계획 Roic
            PlanYearBsRoicEx thisPnRoicEx = planYearBsRoicExRepo.selectOneYear(new { BsYear = pmBs.BsYear, Monthly = pmBs.Monthly, OrgCompanySeq = pmBs.OrgCompanySeq });
            // 당해년도 실적 Roic
            PmBsRoicEx thisPmRoicEx = pmBsRoicExRepo.selectOne(new { PmBsSeq = entity.Seq });

            // 전년도 기말  실적 WCapital
            PmBsWCapitalEx lastPmWCapitalEx = pmBsWCapitalExRepo.selectOneYear(new { BsYear = (Convert.ToInt16(pmBs.BsYear) - 1).ToString(), Monthly = "12", OrgCompanySeq = pmBs.OrgCompanySeq });
            // 당해년도 계획 WCapital
            PlanYearBsWCapitalEx thisPnWCapitalEx = planYearBsWCapitalExRepo.selectOneYear(new { BsYear = pmBs.BsYear, Monthly = pmBs.Monthly, OrgCompanySeq = pmBs.OrgCompanySeq });
            // 당해년도 실적 WCapital
            PmBsWCapitalEx thisPmWCapitalEx = pmBsWCapitalExRepo.selectOne(new { PmBsSeq = entity.Seq });


            // 전년도 기말  실적 WCapitalReg
            PmBsWCapitalRegEx lastPmWCapitalRegEx = pmBsWCapitalRegExRepo.selectOneYear(new { BsYear = (Convert.ToInt16(pmBs.BsYear) - 1).ToString(), Monthly = "12", OrgCompanySeq = pmBs.OrgCompanySeq });
            // 당해년도 계획 WCapital
            PlanYearBsWCapitalRegEx thisPnWCapitalRegEx = planYearBsWCapitalRegExRepo.selectOneYear(new { BsYear = pmBs.BsYear, Monthly = pmBs.Monthly, OrgCompanySeq = pmBs.OrgCompanySeq });
            // 당해년도 실적 WCapital
            PmBsWCapitalRegEx thisPmWCapitalRegEx = pmBsWCapitalRegExRepo.selectOne(new { PmBsSeq = entity.Seq });

            // 전년도 실적 누계
            PmBsSummaryEx lastPmSummaryEx = pmBsSummaryExRepo.selectOneYear(new { BsYear = (Convert.ToInt16(pmBs.BsYear) - 1).ToString(), Monthly = "12", OrgCompanySeq = pmBs.OrgCompanySeq });
            PlanYearBsSummaryEx thisPnSummaryEx = planYearBsSummaryExRepo.selectOneYear(new { BsYear = pmBs.BsYear, Monthly = pmBs.Monthly, OrgCompanySeq = pmBs.OrgCompanySeq });
            PmBsSummaryEx thisPmSummaryEx = pmBsSummaryExRepo.selectOne(new { PmBsSeq = entity.Seq });

            dynamic model = new ExpandoObject();
            model.pmBs = pmBs;
            model.orgCompanyName = orgCompanyName;

            model.lastPmBsheetEx = lastPmBsheetEx;
            model.thisPnBsheetEx = thisPnBsheetEx;
            model.thisPmBsheetEx = thisPmBsheetEx;

            model.lastPmRoicEx = lastPmRoicEx;
            model.thisPnRoicEx = thisPnRoicEx;
            model.thisPmRoicEx = thisPmRoicEx;

            model.lastPmWCapitalEx = lastPmWCapitalEx;
            model.thisPnWCapitalEx = thisPnWCapitalEx;
            model.thisPmWCapitalEx = thisPmWCapitalEx;

            model.lastPmWCapitalRegEx = lastPmWCapitalRegEx;
            model.thisPnWCapitalRegEx = thisPnWCapitalRegEx;
            model.thisPmWCapitalRegEx = thisPmWCapitalRegEx;

            model.lastPmSummaryEx = lastPmSummaryEx;
            model.thisPnSummaryEx = thisPnSummaryEx;
            model.thisPmSummaryEx = thisPmSummaryEx;

            ViewBag.Search = search;
            return View("~/Views/SiteMngHome/Performance/BsEx/View.cshtml", model);
        }

        [Route("Excel_Upload2")]
        public ActionResult ExcelUpload2(int Seq
                                        , int OrgCompanySeq
                                        , int PmBsBsheetSeq
                                        , int PmBsRoicSeq
                                        , int PmBsWCapitalSeq
                                        , int PmBsWCapitalRegSeq
                                        , HttpPostedFileBase ExcelFile)
        {

            bool result = false;
            string resultMsg = ""; if (ExcelFile.ContentLength != 0)
            {
                FileUtil fileUtil = new FileUtil(Define.FILE_PATH);
                string filePath = "PmBsEx";
                var file = fileUtil.FileUpload(ExcelFile, filePath);

                bool bDoubleValue = true;
                ExcelUtil excelUtil = new ExcelUtil();
                var ds = excelUtil.ImportExcelDs(file["FILE_PATH"]);

                List<PmBsBsheetEx> pBsheetList = new List<PmBsBsheetEx>();
                List<PmBsRoicEx> pRoicList = new List<PmBsRoicEx>();
                List<PmBsWCapitalEx> pWCapitalList = new List<PmBsWCapitalEx>();
                List<PmBsWCapitalRegEx> pWCapitalRegList = new List<PmBsWCapitalRegEx>();

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
                        //string parentSeq = item.ItemArray.GetValue(0).ToString();
                        string excelSeq = PmBsBsheetSeq.ToString();

                        string Assets = item.ItemArray.GetValue(2).ToString();
                        string CurrentAssets = item.ItemArray.GetValue(3).ToString();
                        string Liabilities = item.ItemArray.GetValue(4).ToString();
                        string CurrentLiabilities = item.ItemArray.GetValue(5).ToString();
                        string Capital = item.ItemArray.GetValue(6).ToString();
                        string Cash = item.ItemArray.GetValue(7).ToString();
                        string Loan = item.ItemArray.GetValue(8).ToString();
                        // string yearlyYear = item.ItemArray.GetValue(2).ToString();
                        //string monthly = item.ItemArray.GetValue(3).ToString();

                        //string Assets = item.ItemArray.GetValue(4).ToString();
                        //string CurrentAssets = item.ItemArray.GetValue(5).ToString();
                        //string Liabilities = item.ItemArray.GetValue(6).ToString();
                        //string CurrentLiabilities = item.ItemArray.GetValue(7).ToString();
                        //string Capital = item.ItemArray.GetValue(8).ToString();
                        //string Cash = item.ItemArray.GetValue(9).ToString();
                        //string Loan = item.ItemArray.GetValue(10).ToString();

                        // if (parentSeq != Seq.ToString()) { bDoubleValue = false; break; }       // 현재 코드와 업로드하려는 코드가 다른 경우는 양식이 잘못된것으로 오류
                        //if (!WebUtil.CheckDecimalTwo(Assets)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(CurrentAssets)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(Liabilities)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(CurrentLiabilities)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(Capital)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(Cash)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(Loan)) { bDoubleValue = false; break; }

                        PmBsBsheetEx p = new PmBsBsheetEx();
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
                        pBsheetList.Add(p);
                    }

                    foreach (DataRow item in ds.Tables["ROIC"].Rows)
                    {
                        //string parentSeq = item.ItemArray.GetValue(0).ToString();
                        string excelSeq = PmBsBsheetSeq.ToString();

                        string AfterTaxOperationProfit = item.ItemArray.GetValue(2).ToString();
                        string PainInCapital = item.ItemArray.GetValue(3).ToString();
                        // string yearlyYear = item.ItemArray.GetValue(2).ToString();
                        // string monthly = item.ItemArray.GetValue(3).ToString();

                        //string AfterTaxOperationProfit = item.ItemArray.GetValue(4).ToString();
                        //string PainInCapital = item.ItemArray.GetValue(5).ToString();

                        //if (parentSeq != Seq.ToString()) { bDoubleValue = false; break; }       // 현재 코드와 업로드하려는 코드가 다른 경우는 양식이 잘못된것으로 오류
                        //if (!WebUtil.CheckDecimalTwo(AfterTaxOperationProfit)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(PainInCapital)) { bDoubleValue = false; break; }

                        PmBsRoicEx p = new PmBsRoicEx();
                        p.Seq = Convert.ToInt32(excelSeq);
                        p.AfterTaxOperationProfit = Convert.ToDecimal(AfterTaxOperationProfit);
                        p.PainInCapital = Convert.ToDecimal(PainInCapital);
                        p.Roic = 0;

                        pRoicList.Add(p);
                    }

                    foreach (DataRow item in ds.Tables["W_Capital"].Rows)
                    {
                       // string parentSeq = item.ItemArray.GetValue(0).ToString();
                        string excelSeq = PmBsWCapitalSeq.ToString();

                        string AnnualSales = item.ItemArray.GetValue(1).ToString();
                        string AnnualSalesCost = item.ItemArray.GetValue(2).ToString();
                        string InventoryCost = item.ItemArray.GetValue(3).ToString();
                        //string yearlyYear = item.ItemArray.GetValue(2).ToString();

                        //string AnnualSales = item.ItemArray.GetValue(3).ToString();
                        //string AnnualSalesCost = item.ItemArray.GetValue(4).ToString();
                        //string InventoryCost = item.ItemArray.GetValue(5).ToString();

                        //if (parentSeq != Seq.ToString()) { bDoubleValue = false; break; }       // 현재 코드와 업로드하려는 코드가 다른 경우는 양식이 잘못된것으로 오류
                        //if (!WebUtil.CheckDecimalTwo(AnnualSales)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(AnnualSalesCost)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(InventoryCost)) { bDoubleValue = false; break; }

                        PmBsWCapitalEx p = new PmBsWCapitalEx();
                        p.Seq = Convert.ToInt32(excelSeq);
                        p.AnnualSales = Convert.ToDecimal(AnnualSales);
                        p.AnnualSalesCost = Convert.ToDecimal(AnnualSalesCost);
                        p.InventoryCost = Convert.ToDecimal(InventoryCost);
                        pWCapitalList.Add(p);
                    }

                    foreach (DataRow item in ds.Tables["W_Capital_Reg"].Rows)
                    {
                        //string parentSeq = item.ItemArray.GetValue(0).ToString();
                        string excelSeq = PmBsWCapitalRegSeq.ToString();

                        string Ar = item.ItemArray.GetValue(2).ToString();
                        string Ap = item.ItemArray.GetValue(3).ToString();
                        string Inventory = item.ItemArray.GetValue(4).ToString();
                        //string yearlyYear = item.ItemArray.GetValue(2).ToString();
                        //string monthly = item.ItemArray.GetValue(3).ToString();

                        //string Ar = item.ItemArray.GetValue(4).ToString();
                        //string Ap = item.ItemArray.GetValue(5).ToString();
                        //string Inventory = item.ItemArray.GetValue(6).ToString();

                        //if (parentSeq != Seq.ToString()) { bDoubleValue = false; break; }       // 현재 코드와 업로드하려는 코드가 다른 경우는 양식이 잘못된것으로 오류
                        //if (!WebUtil.CheckDecimalTwo(Ar)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(Ap)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(Inventory)) { bDoubleValue = false; break; }

                        PmBsWCapitalRegEx p = new PmBsWCapitalRegEx();
                        p.Seq = Convert.ToInt32(excelSeq);
                        p.Ar = Convert.ToDecimal(Ar);
                        p.ArToDays = 0;
                        p.Ap = Convert.ToDecimal(Ap);
                        p.ApToDays = 0;
                        p.Inventory = Convert.ToDecimal(Inventory);
                        p.InventoryToDays = 0;

                        pWCapitalRegList.Add(p);
                    }
                }
                catch (Exception)
                {
                    fileUtil.FileDelete(filePath, file["STORED_FILE_NAME"]);
                    result = false;
                    resultMsg = Message.MSG_007_E;
                    return Json(new { success = result, resultMsg = resultMsg }, JsonRequestBehavior.AllowGet);
                }

                if (!bDoubleValue)
                {
                    fileUtil.FileDelete(filePath, file["STORED_FILE_NAME"]);
                    result = false;
                    resultMsg = Message.MSG_007_E;
                    return Json(new { success = result, resultMsg = resultMsg }, JsonRequestBehavior.AllowGet);
                }

                // 비율은 저장하지 않아도 되나. 기존 작업에 저장이 되길래 그냥 넣었다.
                foreach (var item in pBsheetList)
                {
                    item.LiabilitiesRate = WebUtil.NumberRound(item.Liabilities, item.Capital, 100, 2);
                    item.CurrentRate = WebUtil.NumberRound(item.CurrentAssets, item.CurrentLiabilities, 100, 2);
                    pmBsBsheetExRepo.update(item);
                }

                foreach (var item in pRoicList)
                {
                    item.Roic = WebUtil.NumberRound(item.AfterTaxOperationProfit, item.PainInCapital, 100, 2);
                    pmBsRoicExRepo.update(item);
                }

                foreach (var item in pWCapitalList)
                {
                    pmBsWCapitalExRepo.update(item);
                }

                foreach (var item in pWCapitalRegList)
                {
                    PmBsWCapitalEx p = pWCapitalList.Where(w => w.PmBsSeq == item.PmBsSeq).First();
                    if (p == null) { p = new PmBsWCapitalEx(); }
                    item.ArToDays = WebUtil.NumberRound(item.Ar, p.AnnualSales, 365, 2);
                    item.ApToDays = WebUtil.NumberRound(item.Ap, p.AnnualSalesCost, 365, 2);
                    item.InventoryToDays = WebUtil.NumberRound(item.Inventory, p.InventoryCost, 365, 2);
                    pmBsWCapitalRegExRepo.update(item);
                }

                // 업데이트 완료 후 로그 남기기
                ExcelFileUploadList eFileList = new ExcelFileUploadList();
                eFileList.UserKey = SessionManager.GetAdminSession().insaUserV.userKey;
                eFileList.EmpNo = SessionManager.GetAdminSession().insaUserV.empNo;
                eFileList.AttachTableName = "PM_BS_EX";
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