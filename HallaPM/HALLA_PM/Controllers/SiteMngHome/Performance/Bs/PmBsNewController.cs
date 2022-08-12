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
    [RoutePrefix("SiteMngHome/Performance/BsNew")]
    public class PmBsNewController : SiteMngBaseController
    {
        [Route("List")]
        public ActionResult List(Search search)
        {
            dynamic model = new ExpandoObject();
            search.AuthUserKey = SessionManager.GetAdminSession().insaUserV.userKey;
            model.list = pmBsRepo.selectListExp(search);
            model.UnionList = orgUnionRepo.selectList(new { });
            model.OrgCpyList = orgCompanyRepo.selectList(null);
            ViewBag.Search = search;
            return View("~/Views/SiteMngHome/Performance/BsNew/List.cshtml", model);
        }

        [Route("Write")]
        public ActionResult Write(PmBs entity, Search search)
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");

            // 기본정보
            PmBs pmBs = pmBsRepo.selectOne(entity);
            OrgCompany orgCompanyName = orgCompanyRepo.selectOne(new { Seq = entity.OrgCompanySeq });

            // BSheet
            PmBsBsheet pmBsBsheet = new PmBsBsheet();
            pmBsBsheet.PmBsSeq = entity.Seq;
            string where = " WHERE PM_BS_SEQ = @PmBsSeq ";
            if (pmBsBsheetRepo.count(pmBsBsheet, where) == 0) pmBsBsheetRepo.insert(pmBsBsheet);

            // Roic
            PmBsRoic pMBsRoic = new PmBsRoic();
            pMBsRoic.PmBsSeq = entity.Seq;
            if (pmBsRoicRepo.count(pMBsRoic, where) == 0) pmBsRoicRepo.insert(pMBsRoic);

            // WCapital
            PmBsWCapital pmBsWCapital = new PmBsWCapital();
            pmBsWCapital.PmBsSeq = entity.Seq;
            if (pmBsWCapitalRepo.count(pmBsWCapital, where) == 0) pmBsWCapitalRepo.insert(pmBsWCapital);

            // WCapitalReg
            PmBsWCapitalReg pmBsWCapitalReg = new PmBsWCapitalReg();
            pmBsWCapitalReg.PmBsSeq = entity.Seq;
            if (pmBsWCapitalRegRepo.count(pmBsWCapitalReg, where) == 0) pmBsWCapitalRegRepo.insert(pmBsWCapitalReg);

            // 전년도 기말  실적 BSheet
            PmBsBsheet lastPmBsheet = pmBsBsheetRepo.selectOneYear(new { BsYear = (Convert.ToInt16(pmBs.BsYear) - 1).ToString(), Monthly = "12", OrgCompanySeq = pmBs.OrgCompanySeq });
            // 당해년도 계획 BSheet
            PlanYearBsBsheet thisPnBsheet = planYearBsBsheetRepo.selectOneYear(new { BsYear = pmBs.BsYear, Monthly = pmBs.Monthly, OrgCompanySeq = pmBs.OrgCompanySeq });
            // 당해년도 실적 BSheet
            PmBsBsheet thisPmBsheet = pmBsBsheetRepo.selectOne(new { PmBsSeq = entity.Seq });

            // 전년도 기말  실적 Roic
            PmBsRoic lastPmRoic = pmBsRoicRepo.selectOneYear(new { BsYear = (Convert.ToInt16(pmBs.BsYear) - 1).ToString(), Monthly = "12", OrgCompanySeq = pmBs.OrgCompanySeq });
            // 당해년도 계획 Roic
            PlanYearBsRoic thisPnRoic = planYearBsRoicRepo.selectOneYear(new { BsYear = pmBs.BsYear, Monthly = pmBs.Monthly, OrgCompanySeq = pmBs.OrgCompanySeq });
            // 당해년도 실적 Roic
            PmBsRoic thisPmRoic = pmBsRoicRepo.selectOne(new { PmBsSeq = entity.Seq });

            // 전년도 기말  실적 WCapital
            PmBsWCapital lastPmWCapital = pmBsWCapitalRepo.selectOneYear(new { BsYear = (Convert.ToInt16(pmBs.BsYear) - 1).ToString(), Monthly = "12", OrgCompanySeq = pmBs.OrgCompanySeq });
            // 당해년도 계획 WCapital
            PlanYearBsWCapital thisPnWCapital = planYearBsWCapitalRepo.selectOneYear(new { BsYear = pmBs.BsYear, Monthly = pmBs.Monthly, OrgCompanySeq = pmBs.OrgCompanySeq });
            // 당해년도 실적 WCapital
            PmBsWCapital thisPmWCapital = pmBsWCapitalRepo.selectOne(new { PmBsSeq = entity.Seq });

            // 전년도 기말  실적 WCapitalReg
            PmBsWCapitalReg lastPmWCapitalReg = pmBsWCapitalRegRepo.selectOneYear(new { BsYear = (Convert.ToInt16(pmBs.BsYear) - 1).ToString(), Monthly = "12", OrgCompanySeq = pmBs.OrgCompanySeq });
            // 당해년도 계획 WCapital
            PlanYearBsWCapitalReg thisPnWCapitalReg = planYearBsWCapitalRegRepo.selectOneYear(new { BsYear = pmBs.BsYear, Monthly = pmBs.Monthly, OrgCompanySeq = pmBs.OrgCompanySeq });
            // 당해년도 실적 WCapital
            PmBsWCapitalReg thisPmWCapitalReg = pmBsWCapitalRegRepo.selectOne(new { PmBsSeq = entity.Seq });

            // 전년도 실적 누계
            PmBsSummary lastPmSummary = pmBsSummaryRepo.selectOneYear(new { BsYear = (Convert.ToInt16(pmBs.BsYear) - 1).ToString(), Monthly = "12", OrgCompanySeq = pmBs.OrgCompanySeq });

            dynamic model = new ExpandoObject();
            model.pmBs = pmBs;
            model.orgCompanyName = orgCompanyName;

            model.lastPmBsheet = lastPmBsheet;
            model.thisPnBsheet = thisPnBsheet;
            model.thisPmBsheet = thisPmBsheet;

            model.lastPmRoic = lastPmRoic;
            model.thisPnRoic = thisPnRoic;
            model.thisPmRoic = thisPmRoic;

            model.lastPmWCapital = lastPmWCapital;
            model.thisPnWCapital = thisPnWCapital;
            model.thisPmWCapital = thisPmWCapital;

            model.lastPmWCapitalReg = lastPmWCapitalReg;
            model.thisPnWCapitalReg = thisPnWCapitalReg;
            model.thisPmWCapitalReg = thisPmWCapitalReg;

            model.lastPmSummary = lastPmSummary;

            ViewBag.Search = search;
            return View("~/Views/SiteMngHome/Performance/BsNew/Write.cshtml", model);
        }

        [Route("SalesAccount_Action")]
        public ActionResult SalesAccountAction(PmBsAdmin entity, Search search)
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

            List<PmBsBsheet> pBsheetList = new List<PmBsBsheet>();
            List<PmBsRoic> pRoicList = new List<PmBsRoic>();
            List<PmBsWCapital> pWCapitalList = new List<PmBsWCapital>();
            List<PmBsWCapitalReg> pWCapitalRegList = new List<PmBsWCapitalReg>();

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

                    PmBsBsheet p = new PmBsBsheet();
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

                    PmBsRoic p = new PmBsRoic();
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

                    PmBsWCapital p = new PmBsWCapital();

                    p.Seq = entity.PmBsWCapitalSeq[i];
                    p.AnnualSales = entity.AnnualSales[i];
                    p.AnnualSalesCost = entity.AnnualSalesCost[i];
                    p.InventoryCost = entity.InventoryCost[i];

                    pWCapitalList.Add(p);
                }

                for (int i = 0; i < entity.PmBsWCapitalRegSeq.Count(); i++)
                {
                    PmBsWCapitalReg p = new PmBsWCapitalReg();
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
                pmBsBsheetRepo.update(item);
            }

            foreach (var item in pRoicList)
            {
                item.Roic = WebUtil.NumberRound(item.AfterTaxOperationProfit, item.PainInCapital, 100, 2);
                pmBsRoicRepo.update(item);
            }

            foreach (var item in pWCapitalList)
            {
                pmBsWCapitalRepo.update(item);
            }

            foreach (var item in pWCapitalRegList)
            {
                PmBsWCapital p = pWCapitalList.Where(w => w.PmBsSeq == item.PmBsSeq).First();
                if (p == null) { p = new PmBsWCapital(); }
                item.ArToDays = WebUtil.NumberRound(item.Ar, p.AnnualSales, 365, 2);
                item.ApToDays = WebUtil.NumberRound(item.Ap, p.AnnualSalesCost, 365, 2);
                item.InventoryToDays = WebUtil.NumberRound(item.Inventory, p.InventoryCost, 365, 2);
                pmBsWCapitalRegRepo.update(item);
            }


            return RedirectAndPostActionResult.RedirectAndPost("Write", postData);
        }

        [Route("Calculation_Action")]
        public ActionResult CalculationAction(PmBsAdmin entity, Search search)
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

            List<PmBsBsheet> pBsheetList = new List<PmBsBsheet>();
            List<PmBsRoic> pRoicList = new List<PmBsRoic>();
            List<PmBsWCapital> pWCapitalList = new List<PmBsWCapital>();
            List<PmBsWCapitalReg> pWCapitalRegList = new List<PmBsWCapitalReg>();
            List<PmBsSummary> pSummaryList = new List<PmBsSummary>();

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

                    PmBsBsheet p = new PmBsBsheet();
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

                    PmBsRoic p = new PmBsRoic();
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

                    PmBsWCapital p = new PmBsWCapital();

                    p.Seq = entity.PmBsWCapitalSeq[i];
                    p.AnnualSales = entity.AnnualSales[i];
                    p.AnnualSalesCost = entity.AnnualSalesCost[i];
                    p.InventoryCost = entity.InventoryCost[i];

                    pWCapitalList.Add(p);
                }

                for (int i = 0; i < entity.PmBsWCapitalRegSeq.Count(); i++)
                {
                    PmBsWCapitalReg p = new PmBsWCapitalReg();
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
                pmBsBsheetRepo.update(item);
            }

            foreach (var item in pRoicList)
            {
                item.Roic = WebUtil.NumberRound(item.AfterTaxOperationProfit, item.PainInCapital, 100, 2);
                pmBsRoicRepo.update(item);
            }

            foreach (var item in pWCapitalList)
            {
                pmBsWCapitalRepo.update(item);
            }

            foreach (var item in pWCapitalRegList)
            {
                PmBsWCapital p = pWCapitalList.Where(w => w.PmBsSeq == item.PmBsSeq).First();
                if (p == null) { p = new PmBsWCapital(); }
                item.ArToDays = WebUtil.NumberRound(item.Ar, p.AnnualSales, 365, 2);
                item.ApToDays = WebUtil.NumberRound(item.Ap, p.AnnualSalesCost, 365, 2);
                item.InventoryToDays = WebUtil.NumberRound(item.Inventory, p.InventoryCost, 365, 2);
                pmBsWCapitalRegRepo.update(item);
            }

            // BS요약
            pmBsSummaryRepo.delete(new { PmBsSeq = entity.Seq });
            PmBsSummary pSummary = new PmBsSummary();
            pSummary.PmBsSeq = entity.Seq;
            pmBsSummaryRepo.insertCum(pSummary);

            return RedirectAndPostActionResult.RedirectAndPost("Edit", postData);
        }

        [Route("Regist_Status_Change")]
        public ActionResult RegistStatusChange(PmBsExp entity, Search search)
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");

            #region
            Dictionary<string, object> postData = new Dictionary<string, object>();
            postData.Add("Seq", entity.Seq);
            postData.Add("OrgCompanySeq", entity.OrgCompanySeq);
            postData.Add("message", entity.message);
            #endregion

            // 현재 상태값을 변경한다.   afterRegistStatus
            entity.RegistStatus = entity.afterRegistStatus;
            pmBsRepo.updateRegistStatusByPmBsSeq(entity);

            // 현재의 상태 변경 후 담당자들에게 메일 발송합니다.(2018.11.08)
            var info = pmBsRepo.selectOne(entity);

            MailInfo mInfo = new MailInfo();
            // 2019.01.13 결제라인 추가
            mInfo.Seq = entity.Seq;
            mInfo.ReferUrl = Request.UrlReferrer.AbsolutePath.ToString();
            mInfo.afterRegistStatus = entity.afterRegistStatus;
            mInfo.OrgCompanySeq = entity.OrgCompanySeq;
            mInfo.menuName = "Bs";
            mInfo.year = info.BsYear;
            mInfo.mm = info.Monthly;
            // 2018.01.03 반려사유 추가
            mInfo.RejectReson = entity.RejectReson;
            //MailUtil.RegistStatusMail(mInfo);
            MailUtilNew.AllComfirmMaillSender(mInfo); /*메일 발송*/

            // 최종승인의 경우. 다른 모든 회사와 메뉴가 최종승인 되었는지 체크하여. 푸시알림을 보낸다.
            if (entity.RegistStatus == Define.REGIST_STATUS.GetKey("최종승인"))
            {
                //RegistYearListRepo rYearListRepo = new RegistYearListRepo();
                //List<RegistYearList> registYearPm = rYearListRepo.selectListPm(new { }).ToList();

                //string year = info.BsYear;
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

        [Route("Excel_Down")]
        public ActionResult ExcelDown(PmBsExp entity)
        {
            // 기본정보
            PmBs pmBs = pmBsRepo.selectOne(entity);
            OrgCompany orgCompanyName = orgCompanyRepo.selectOne(new { Seq = entity.OrgCompanySeq });
            string fileName = "BS_" + pmBs.BsYear + "년_" + orgCompanyName.CompanyName;

            PmBsBsheet thisPmBsheet = pmBsBsheetRepo.selectOne(new { PmBsSeq = entity.Seq });
            PmBsRoic thisPmRoic = pmBsRoicRepo.selectOne(new { PmBsSeq = entity.Seq });
            PmBsWCapital thisPmWCapital = pmBsWCapitalRepo.selectOne(new { PmBsSeq = entity.Seq });
            PmBsWCapitalReg thisPmWCapitalReg = pmBsWCapitalRegRepo.selectOne(new { PmBsSeq = entity.Seq });

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
                wsBsheet.Cell(rows, cells).SetValue(thisPmBsheet.PmBsSeq).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsBsheet.Cell(rows, ++cells).SetValue(thisPmBsheet.Seq).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsBsheet.Cell(rows, ++cells).SetValue(pmBs.BsYear).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsBsheet.Cell(rows, ++cells).SetValue(pmBs.Monthly).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsBsheet.Cell(rows, ++cells).SetValue(thisPmBsheet.Assets).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsBsheet.Cell(rows, ++cells).SetValue(thisPmBsheet.CurrentAssets).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsBsheet.Cell(rows, ++cells).SetValue(thisPmBsheet.Liabilities).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsBsheet.Cell(rows, ++cells).SetValue(thisPmBsheet.CurrentLiabilities).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsBsheet.Cell(rows, ++cells).SetValue(thisPmBsheet.Capital).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsBsheet.Cell(rows, ++cells).SetValue(thisPmBsheet.Cash).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsBsheet.Cell(rows, ++cells).SetValue(thisPmBsheet.Loan).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);

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
                wsRoic.Cell(rows, cells).SetValue(thisPmRoic.PmBsSeq).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsRoic.Cell(rows, ++cells).SetValue(thisPmRoic.Seq).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsRoic.Cell(rows, ++cells).SetValue(pmBs.BsYear).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsRoic.Cell(rows, ++cells).SetValue(pmBs.Monthly).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsRoic.Cell(rows, ++cells).SetValue(thisPmRoic.AfterTaxOperationProfit).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsRoic.Cell(rows, ++cells).SetValue(thisPmRoic.PainInCapital).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);

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
                wsWcapital.Cell(rows, cells).SetValue(thisPmWCapital.PmBsSeq).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsWcapital.Cell(rows, ++cells).SetValue(thisPmWCapital.Seq).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsWcapital.Cell(rows, ++cells).SetValue(pmBs.BsYear).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsWcapital.Cell(rows, ++cells).SetValue(thisPmWCapital.AnnualSales).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsWcapital.Cell(rows, ++cells).SetValue(thisPmWCapital.AnnualSalesCost).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsWcapital.Cell(rows, ++cells).SetValue(thisPmWCapital.InventoryCost).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);

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
                wsWcapitalReg.Cell(rows, cells).SetValue(thisPmWCapitalReg.PmBsSeq).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsWcapitalReg.Cell(rows, ++cells).SetValue(thisPmWCapitalReg.Seq).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsWcapitalReg.Cell(rows, ++cells).SetValue(pmBs.BsYear).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsWcapitalReg.Cell(rows, ++cells).SetValue(pmBs.Monthly).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsWcapitalReg.Cell(rows, ++cells).SetValue(thisPmWCapitalReg.Ar).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsWcapitalReg.Cell(rows, ++cells).SetValue(thisPmWCapitalReg.Ap).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsWcapitalReg.Cell(rows, ++cells).SetValue(thisPmWCapitalReg.Inventory).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                using (MemoryStream mStream = new MemoryStream())
                {
                    wb.SaveAs(mStream);
                    return File(mStream.ToArray(), "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", fileName + ".xlsx");
                }
            }
        }



        [Route("Excel_Down2")]
        public ActionResult ExcelDown2(PmBsExp entity)
        {
            // 기본정보
            PmBs pmBs = pmBsRepo.selectOne(entity);
            OrgCompany orgCompanyName = orgCompanyRepo.selectOne(new { Seq = entity.OrgCompanySeq });
            string fileName = "BS_" + pmBs.BsYear + "년_" + orgCompanyName.CompanyName;

            PmBsBsheet thisPmBsheet = pmBsBsheetRepo.selectOne(new { PmBsSeq = entity.Seq });
            PmBsRoic thisPmRoic = pmBsRoicRepo.selectOne(new { PmBsSeq = entity.Seq });
            PmBsWCapital thisPmWCapital = pmBsWCapitalRepo.selectOne(new { PmBsSeq = entity.Seq });
            PmBsWCapitalReg thisPmWCapitalReg = pmBsWCapitalRegRepo.selectOne(new { PmBsSeq = entity.Seq });

            int rows = 1, cells = 1;
            using (XLWorkbook wb = new XLWorkbook())
            {
                var wsBsheet = wb.Worksheets.Add("BSheet");

                // 컬럼 숨기기
                //wsBsheet.Column(1).Hide();
                //wsBsheet.Column(2).Hide();

                //wsBsheet.Cell(rows, cells).SetValue("ParentSeq").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
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
                //wsBsheet.Cell(rows, cells).SetValue(thisPmBsheet.PmBsSeq).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                //wsBsheet.Cell(rows, ++cells).SetValue(thisPmBsheet.Seq).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsBsheet.Cell(rows, cells).SetValue(pmBs.BsYear).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsBsheet.Cell(rows, ++cells).SetValue(pmBs.Monthly).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsBsheet.Cell(rows, ++cells).SetValue(thisPmBsheet.Assets).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsBsheet.Cell(rows, ++cells).SetValue(thisPmBsheet.CurrentAssets).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsBsheet.Cell(rows, ++cells).SetValue(thisPmBsheet.Liabilities).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsBsheet.Cell(rows, ++cells).SetValue(thisPmBsheet.CurrentLiabilities).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsBsheet.Cell(rows, ++cells).SetValue(thisPmBsheet.Capital).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsBsheet.Cell(rows, ++cells).SetValue(thisPmBsheet.Cash).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsBsheet.Cell(rows, ++cells).SetValue(thisPmBsheet.Loan).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);

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
                //wsRoic.Cell(rows, cells).SetValue(thisPmRoic.PmBsSeq).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                //wsRoic.Cell(rows, ++cells).SetValue(thisPmRoic.Seq).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsRoic.Cell(rows, cells).SetValue(pmBs.BsYear).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsRoic.Cell(rows, ++cells).SetValue(pmBs.Monthly).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsRoic.Cell(rows, ++cells).SetValue(thisPmRoic.AfterTaxOperationProfit).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsRoic.Cell(rows, ++cells).SetValue(thisPmRoic.PainInCapital).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);

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
                //wsWcapital.Cell(rows, cells).SetValue(thisPmWCapital.PmBsSeq).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
               // wsWcapital.Cell(rows, ++cells).SetValue(thisPmWCapital.Seq).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsWcapital.Cell(rows, cells).SetValue(pmBs.BsYear).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsWcapital.Cell(rows, ++cells).SetValue(thisPmWCapital.AnnualSales).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsWcapital.Cell(rows, ++cells).SetValue(thisPmWCapital.AnnualSalesCost).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsWcapital.Cell(rows, ++cells).SetValue(thisPmWCapital.InventoryCost).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);

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
                //wsWcapitalReg.Cell(rows, cells).SetValue(thisPmWCapitalReg.PmBsSeq).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                //wsWcapitalReg.Cell(rows, ++cells).SetValue(thisPmWCapitalReg.Seq).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsWcapitalReg.Cell(rows, cells).SetValue(pmBs.BsYear).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsWcapitalReg.Cell(rows, ++cells).SetValue(pmBs.Monthly).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsWcapitalReg.Cell(rows, ++cells).SetValue(thisPmWCapitalReg.Ar).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsWcapitalReg.Cell(rows, ++cells).SetValue(thisPmWCapitalReg.Ap).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsWcapitalReg.Cell(rows, ++cells).SetValue(thisPmWCapitalReg.Inventory).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);

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
                string filePath = "PmBs";
                var file = fileUtil.FileUpload(ExcelFile, filePath);

                bool bDoubleValue = true;
                ExcelUtil excelUtil = new ExcelUtil();
                var ds = excelUtil.ImportExcelDs(file["FILE_PATH"]);

                List<PmBsBsheet> pBsheetList = new List<PmBsBsheet>();
                List<PmBsRoic> pRoicList = new List<PmBsRoic>();
                List<PmBsWCapital> pWCapitalList = new List<PmBsWCapital>();
                List<PmBsWCapitalReg> pWCapitalRegList = new List<PmBsWCapitalReg>();

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

                        PmBsBsheet p = new PmBsBsheet();
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

                        PmBsRoic p = new PmBsRoic();
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

                        PmBsWCapital p = new PmBsWCapital();
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

                        PmBsWCapitalReg p = new PmBsWCapitalReg();
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
                    pmBsBsheetRepo.update(item);
                }

                foreach (var item in pRoicList)
                {
                    item.Roic = WebUtil.NumberRound(item.AfterTaxOperationProfit, item.PainInCapital, 100, 2);
                    pmBsRoicRepo.update(item);
                }

                foreach (var item in pWCapitalList)
                {
                    pmBsWCapitalRepo.update(item);
                }

                foreach (var item in pWCapitalRegList)
                {
                    PmBsWCapital p = pWCapitalList.Where(w => w.PmBsSeq == item.PmBsSeq).First();
                    if (p == null) { p = new PmBsWCapital(); }
                    item.ArToDays = WebUtil.NumberRound(item.Ar, p.AnnualSales, 365, 2);
                    item.ApToDays = WebUtil.NumberRound(item.Ap, p.AnnualSalesCost, 365, 2);
                    item.InventoryToDays = WebUtil.NumberRound(item.Inventory, p.InventoryCost, 365, 2);
                    pmBsWCapitalRegRepo.update(item);
                }

                // 업데이트 완료 후 로그 남기기
                ExcelFileUploadList eFileList = new ExcelFileUploadList();
                eFileList.UserKey = SessionManager.GetAdminSession().insaUserV.userKey;
                eFileList.EmpNo = SessionManager.GetAdminSession().insaUserV.empNo;
                eFileList.AttachTableName = "PM_BS";
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
        public ActionResult Edit(PmBsExp entity, Search search)
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");

            // 기본정보
            PmBs pmBs = pmBsRepo.selectOne(entity);
            // 현재기준 부서 정보.
            List<OrgBusiness> orgBusinessList = orgBusinessRepo.selectListCompany(new { Seq = entity.OrgCompanySeq }).ToList();
            OrgCompany orgCompanyName = orgCompanyRepo.selectOne(new { Seq = entity.OrgCompanySeq });

            // 전년도 기말  실적 BSheet
            PmBsBsheet lastPmBsheet = pmBsBsheetRepo.selectOneYear(new { BsYear = (Convert.ToInt16(pmBs.BsYear) - 1).ToString(), Monthly = "12", OrgCompanySeq = pmBs.OrgCompanySeq });
            // 당해년도 계획 BSheet
            PlanYearBsBsheet thisPnBsheet = planYearBsBsheetRepo.selectOneYear(new { BsYear = pmBs.BsYear, Monthly = pmBs.Monthly, OrgCompanySeq = pmBs.OrgCompanySeq });
            // 당해년도 실적 BSheet
            PmBsBsheet thisPmBsheet = pmBsBsheetRepo.selectOne(new { PmBsSeq = entity.Seq });

            // 전년도 기말  실적 Roic
            PmBsRoic lastPmRoic = pmBsRoicRepo.selectOneYear(new { BsYear = (Convert.ToInt16(pmBs.BsYear) - 1).ToString(), Monthly = "12", OrgCompanySeq = pmBs.OrgCompanySeq });
            // 당해년도 계획 Roic
            PlanYearBsRoic thisPnRoic = planYearBsRoicRepo.selectOneYear(new { BsYear = pmBs.BsYear, Monthly = pmBs.Monthly, OrgCompanySeq = pmBs.OrgCompanySeq });
            // 당해년도 실적 Roic
            PmBsRoic thisPmRoic = pmBsRoicRepo.selectOne(new { PmBsSeq = entity.Seq });

            // 전년도 기말  실적 WCapital
            PmBsWCapital lastPmWCapital = pmBsWCapitalRepo.selectOneYear(new { BsYear = (Convert.ToInt16(pmBs.BsYear) - 1).ToString(), Monthly = "12", OrgCompanySeq = pmBs.OrgCompanySeq });
            // 당해년도 계획 WCapital
            PlanYearBsWCapital thisPnWCapital = planYearBsWCapitalRepo.selectOneYear(new { BsYear = pmBs.BsYear, Monthly = pmBs.Monthly, OrgCompanySeq = pmBs.OrgCompanySeq });
            // 당해년도 실적 WCapital
            PmBsWCapital thisPmWCapital = pmBsWCapitalRepo.selectOne(new { PmBsSeq = entity.Seq });


            // 전년도 기말  실적 WCapitalReg
            PmBsWCapitalReg lastPmWCapitalReg = pmBsWCapitalRegRepo.selectOneYear(new { BsYear = (Convert.ToInt16(pmBs.BsYear) - 1).ToString(), Monthly = "12", OrgCompanySeq = pmBs.OrgCompanySeq });
            // 당해년도 계획 WCapital
            PlanYearBsWCapitalReg thisPnWCapitalReg = planYearBsWCapitalRegRepo.selectOneYear(new { BsYear = pmBs.BsYear, Monthly = pmBs.Monthly, OrgCompanySeq = pmBs.OrgCompanySeq });
            // 당해년도 실적 WCapital
            PmBsWCapitalReg thisPmWCapitalReg = pmBsWCapitalRegRepo.selectOne(new { PmBsSeq = entity.Seq });

            // 전년도 실적 누계
            PmBsSummary lastPmSummary = pmBsSummaryRepo.selectOneYear(new { BsYear = (Convert.ToInt16(pmBs.BsYear) - 1).ToString(), Monthly = "12", OrgCompanySeq = pmBs.OrgCompanySeq });
            PlanYearBsSummary thisPnSummary = planYearBsSummaryRepo.selectOneYear(new { BsYear = pmBs.BsYear, Monthly = pmBs.Monthly, OrgCompanySeq = pmBs.OrgCompanySeq });
            PmBsSummary thisPmSummary = pmBsSummaryRepo.selectOne(new { PmBsSeq = entity.Seq });

            dynamic model = new ExpandoObject();
            model.pmBs = pmBs;
            model.orgCompanyName = orgCompanyName;

            model.lastPmBsheet = lastPmBsheet;
            model.thisPnBsheet = thisPnBsheet;
            model.thisPmBsheet = thisPmBsheet;

            model.lastPmRoic = lastPmRoic;
            model.thisPnRoic = thisPnRoic;
            model.thisPmRoic = thisPmRoic;

            model.lastPmWCapital = lastPmWCapital;
            model.thisPnWCapital = thisPnWCapital;
            model.thisPmWCapital = thisPmWCapital;

            model.lastPmWCapitalReg = lastPmWCapitalReg;
            model.thisPnWCapitalReg = thisPnWCapitalReg;
            model.thisPmWCapitalReg = thisPmWCapitalReg;

            model.lastPmSummary = lastPmSummary;
            model.thisPnSummary = thisPnSummary;
            model.thisPmSummary = thisPmSummary;

            if (entity.message != null)
            {
                TempData["alert"] = entity.message;
            }

            ViewBag.Search = search;
            return View("~/Views/SiteMngHome/Performance/BsNew/Edit.cshtml", model);
        }

        [Route("Edit2")]
        public ActionResult Edit2(PmBsExp entity, Search search)
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");

            // 기본정보
            PmBs pmBs = pmBsRepo.selectOne(entity);
            // 현재기준 부서 정보.
            List<OrgBusiness> orgBusinessList = orgBusinessRepo.selectListCompany(new { Seq = entity.OrgCompanySeq }).ToList();
            OrgCompany orgCompanyName = orgCompanyRepo.selectOne(new { Seq = entity.OrgCompanySeq });
            
            // 전년도 실적 누계
            PmBsSummary lastPmSummary = pmBsSummaryRepo.selectOneYear(new { BsYear = (Convert.ToInt16(pmBs.BsYear) - 1).ToString(), Monthly = "12", OrgCompanySeq = pmBs.OrgCompanySeq });
            PlanYearBsSummary thisPnSummary = planYearBsSummaryRepo.selectOneYear(new { BsYear = pmBs.BsYear, Monthly = pmBs.Monthly, OrgCompanySeq = pmBs.OrgCompanySeq });
            PmBsSummary thisPmSummary = pmBsSummaryRepo.selectOne(new { PmBsSeq = entity.Seq });

            dynamic model = new ExpandoObject();
            model.pmBs = pmBs;
            model.orgCompanyName = orgCompanyName;

            model.lastPmSummary = lastPmSummary;
            model.thisPnSummary = thisPnSummary;
            model.thisPmSummary = thisPmSummary;

            if (entity.message != null)
            {
                TempData["alert"] = entity.message;
            }

            ViewBag.Search = search;
            return View("~/Views/SiteMngHome/Performance/BsNew/Edit2.cshtml", model);
        }

        [Route("Edit_Action")]
        public ActionResult EditAction(PmBsAdmin entity, Search search)
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

            List<PmBsBsheet> pBsheetList = new List<PmBsBsheet>();
            List<PmBsRoic> pRoicList = new List<PmBsRoic>();
            List<PmBsWCapital> pWCapitalList = new List<PmBsWCapital>();
            List<PmBsWCapitalReg> pWCapitalRegList = new List<PmBsWCapitalReg>();
            List<PmBsSummary> pSummaryList = new List<PmBsSummary>();

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

                    PmBsBsheet p = new PmBsBsheet();
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

                    PmBsRoic p = new PmBsRoic();
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

                    PmBsWCapital p = new PmBsWCapital();

                    p.Seq = entity.PmBsWCapitalSeq[i];
                    p.AnnualSales = entity.AnnualSales[i];
                    p.AnnualSalesCost = entity.AnnualSalesCost[i];
                    p.InventoryCost = entity.InventoryCost[i];

                    pWCapitalList.Add(p);
                }

                for (int i = 0; i < entity.PmBsWCapitalRegSeq.Count(); i++)
                {
                    PmBsWCapitalReg p = new PmBsWCapitalReg();
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

                    PmBsSummary pSummary = new PmBsSummary();
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
                pmBsBsheetRepo.update(item);
            }

            foreach (var item in pRoicList)
            {
                item.Roic = WebUtil.NumberRound(item.AfterTaxOperationProfit, item.PainInCapital, 100, 2);
                pmBsRoicRepo.update(item);
            }

            foreach (var item in pWCapitalList)
            {
                pmBsWCapitalRepo.update(item);
            }

            foreach (var item in pWCapitalRegList)
            {
                PmBsWCapital p = pWCapitalList.Where(w => w.PmBsSeq == item.PmBsSeq).First();
                if (p == null) { p = new PmBsWCapital(); }
                item.ArToDays = WebUtil.NumberRound(item.Ar, p.AnnualSales, 365, 2);
                item.ApToDays = WebUtil.NumberRound(item.Ap, p.AnnualSalesCost, 365, 2);
                item.InventoryToDays = WebUtil.NumberRound(item.Inventory, p.InventoryCost, 365, 2);
                pmBsWCapitalRegRepo.update(item);
            }

            foreach (var item in pSummaryList)
            {
                pmBsSummaryRepo.update(item);
            }


            // 미저장에서 저장으로 변경
            if (entity.RegistStatus == Define.REGIST_STATUS.GetKey("미등록"))
            {
                entity.RegistStatus = Define.REGIST_STATUS.GetKey("저장");
                PmBsExp p = new PmBsExp();
                p.Seq = entity.Seq;
                p.RegistStatus = entity.RegistStatus;
                pmBsRepo.updateRegistStatusByPmBsSeq(p);
            }

            return RedirectAndPostActionResult.RedirectAndPost("Edit", postData);
        }

        [Route("View")]
        public ActionResult view(PmBsExp entity, Search search)
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");

            // 기본정보
            PmBs pmBs = pmBsRepo.selectOne(entity);
            // 현재기준 부서 정보.
            List<OrgBusiness> orgBusinessList = orgBusinessRepo.selectListCompany(new { Seq = entity.OrgCompanySeq }).ToList();
            OrgCompany orgCompanyName = orgCompanyRepo.selectOne(new { Seq = entity.OrgCompanySeq });

            // 전년도 기말  실적 BSheet
            PmBsBsheet lastPmBsheet = pmBsBsheetRepo.selectOneYear(new { BsYear = (Convert.ToInt16(pmBs.BsYear) - 1).ToString(), Monthly = "12", OrgCompanySeq = pmBs.OrgCompanySeq });
            // 당해년도 계획 BSheet
            PlanYearBsBsheet thisPnBsheet = planYearBsBsheetRepo.selectOneYear(new { BsYear = pmBs.BsYear, Monthly = pmBs.Monthly, OrgCompanySeq = pmBs.OrgCompanySeq });
            // 당해년도 실적 BSheet
            PmBsBsheet thisPmBsheet = pmBsBsheetRepo.selectOne(new { PmBsSeq = entity.Seq });

            // 전년도 기말  실적 Roic
            PmBsRoic lastPmRoic = pmBsRoicRepo.selectOneYear(new { BsYear = (Convert.ToInt16(pmBs.BsYear) - 1).ToString(), Monthly = "12", OrgCompanySeq = pmBs.OrgCompanySeq });
            // 당해년도 계획 Roic
            PlanYearBsRoic thisPnRoic = planYearBsRoicRepo.selectOneYear(new { BsYear = pmBs.BsYear, Monthly = pmBs.Monthly, OrgCompanySeq = pmBs.OrgCompanySeq });
            // 당해년도 실적 Roic
            PmBsRoic thisPmRoic = pmBsRoicRepo.selectOne(new { PmBsSeq = entity.Seq });

            // 전년도 기말  실적 WCapital
            PmBsWCapital lastPmWCapital = pmBsWCapitalRepo.selectOneYear(new { BsYear = (Convert.ToInt16(pmBs.BsYear) - 1).ToString(), Monthly = "12", OrgCompanySeq = pmBs.OrgCompanySeq });
            // 당해년도 계획 WCapital
            PlanYearBsWCapital thisPnWCapital = planYearBsWCapitalRepo.selectOneYear(new { BsYear = pmBs.BsYear, Monthly = pmBs.Monthly, OrgCompanySeq = pmBs.OrgCompanySeq });
            // 당해년도 실적 WCapital
            PmBsWCapital thisPmWCapital = pmBsWCapitalRepo.selectOne(new { PmBsSeq = entity.Seq });


            // 전년도 기말  실적 WCapitalReg
            PmBsWCapitalReg lastPmWCapitalReg = pmBsWCapitalRegRepo.selectOneYear(new { BsYear = (Convert.ToInt16(pmBs.BsYear) - 1).ToString(), Monthly = "12", OrgCompanySeq = pmBs.OrgCompanySeq });
            // 당해년도 계획 WCapital
            PlanYearBsWCapitalReg thisPnWCapitalReg = planYearBsWCapitalRegRepo.selectOneYear(new { BsYear = pmBs.BsYear, Monthly = pmBs.Monthly, OrgCompanySeq = pmBs.OrgCompanySeq });
            // 당해년도 실적 WCapital
            PmBsWCapitalReg thisPmWCapitalReg = pmBsWCapitalRegRepo.selectOne(new { PmBsSeq = entity.Seq });

            // 전년도 실적 누계
            PmBsSummary lastPmSummary = pmBsSummaryRepo.selectOneYear(new { BsYear = (Convert.ToInt16(pmBs.BsYear) - 1).ToString(), Monthly = "12", OrgCompanySeq = pmBs.OrgCompanySeq });
            PlanYearBsSummary thisPnSummary = planYearBsSummaryRepo.selectOneYear(new { BsYear = pmBs.BsYear, Monthly = pmBs.Monthly, OrgCompanySeq = pmBs.OrgCompanySeq });
            PmBsSummary thisPmSummary = pmBsSummaryRepo.selectOne(new { PmBsSeq = entity.Seq });

            dynamic model = new ExpandoObject();
            model.pmBs = pmBs;
            model.orgCompanyName = orgCompanyName;

            model.lastPmBsheet = lastPmBsheet;
            model.thisPnBsheet = thisPnBsheet;
            model.thisPmBsheet = thisPmBsheet;

            model.lastPmRoic = lastPmRoic;
            model.thisPnRoic = thisPnRoic;
            model.thisPmRoic = thisPmRoic;

            model.lastPmWCapital = lastPmWCapital;
            model.thisPnWCapital = thisPnWCapital;
            model.thisPmWCapital = thisPmWCapital;

            model.lastPmWCapitalReg = lastPmWCapitalReg;
            model.thisPnWCapitalReg = thisPnWCapitalReg;
            model.thisPmWCapitalReg = thisPmWCapitalReg;

            model.lastPmSummary = lastPmSummary;
            model.thisPnSummary = thisPnSummary;
            model.thisPmSummary = thisPmSummary;

            ViewBag.Search = search;
            return View("~/Views/SiteMngHome/Performance/BsNew/View.cshtml", model);
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
                string filePath = "PmBs";
                var file = fileUtil.FileUpload(ExcelFile, filePath);

                bool bDoubleValue = true;
                ExcelUtil excelUtil = new ExcelUtil();
                var ds = excelUtil.ImportExcelDs(file["FILE_PATH"]);

                List<PmBsBsheet> pBsheetList = new List<PmBsBsheet>();
                List<PmBsRoic> pRoicList = new List<PmBsRoic>();
                List<PmBsWCapital> pWCapitalList = new List<PmBsWCapital>();
                List<PmBsWCapitalReg> pWCapitalRegList = new List<PmBsWCapitalReg>();

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
                       // string parentSeq = item.ItemArray.GetValue(0).ToString();
                        string excelSeq = PmBsBsheetSeq.ToString();

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

                        // if (parentSeq != Seq.ToString()) { bDoubleValue = false; break; }       // 현재 코드와 업로드하려는 코드가 다른 경우는 양식이 잘못된것으로 오류
                        //if (!WebUtil.CheckDecimalTwo(Assets)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(CurrentAssets)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(Liabilities)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(CurrentLiabilities)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(Capital)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(Cash)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(Loan)) { bDoubleValue = false; break; }

                        PmBsBsheet p = new PmBsBsheet();
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
                        string excelSeq = PmBsRoicSeq.ToString();

                        string AfterTaxOperationProfit = item.ItemArray.GetValue(2).ToString();
                        string PainInCapital = item.ItemArray.GetValue(3).ToString();
                        //string yearlyYear = item.ItemArray.GetValue(2).ToString();
                        //string monthly = item.ItemArray.GetValue(3).ToString();

                        //string AfterTaxOperationProfit = item.ItemArray.GetValue(4).ToString();
                        //string PainInCapital = item.ItemArray.GetValue(5).ToString();

                        //if (parentSeq != Seq.ToString()) { bDoubleValue = false; break; }       // 현재 코드와 업로드하려는 코드가 다른 경우는 양식이 잘못된것으로 오류
                        //if (!WebUtil.CheckDecimalTwo(AfterTaxOperationProfit)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(PainInCapital)) { bDoubleValue = false; break; }

                        PmBsRoic p = new PmBsRoic();
                        p.Seq = Convert.ToInt32(excelSeq);
                        p.AfterTaxOperationProfit = Convert.ToDecimal(AfterTaxOperationProfit);
                        p.PainInCapital = Convert.ToDecimal(PainInCapital);
                        p.Roic = 0;

                        pRoicList.Add(p);
                    }

                    foreach (DataRow item in ds.Tables["W_Capital"].Rows)
                    {
                        //string parentSeq = item.ItemArray.GetValue(0).ToString();
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

                        PmBsWCapital p = new PmBsWCapital();
                        p.Seq = Convert.ToInt32(excelSeq);
                        p.AnnualSales = Convert.ToDecimal(AnnualSales);
                        p.AnnualSalesCost = Convert.ToDecimal(AnnualSalesCost);
                        p.InventoryCost = Convert.ToDecimal(InventoryCost);
                        pWCapitalList.Add(p);
                    }

                    foreach (DataRow item in ds.Tables["W_Capital_Reg"].Rows)
                    {
                       // string parentSeq = item.ItemArray.GetValue(0).ToString();
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

                        PmBsWCapitalReg p = new PmBsWCapitalReg();
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
                    pmBsBsheetRepo.update(item);
                }

                foreach (var item in pRoicList)
                {
                    item.Roic = WebUtil.NumberRound(item.AfterTaxOperationProfit, item.PainInCapital, 100, 2);
                    pmBsRoicRepo.update(item);
                }

                foreach (var item in pWCapitalList)
                {
                    pmBsWCapitalRepo.update(item);
                }

                foreach (var item in pWCapitalRegList)
                {
                    PmBsWCapital p = pWCapitalList.Where(w => w.PmBsSeq == item.PmBsSeq).First();
                    if (p == null) { p = new PmBsWCapital(); }
                    item.ArToDays = WebUtil.NumberRound(item.Ar, p.AnnualSales, 365, 2);
                    item.ApToDays = WebUtil.NumberRound(item.Ap, p.AnnualSalesCost, 365, 2);
                    item.InventoryToDays = WebUtil.NumberRound(item.Inventory, p.InventoryCost, 365, 2);
                    pmBsWCapitalRegRepo.update(item);
                }

                // 업데이트 완료 후 로그 남기기
                ExcelFileUploadList eFileList = new ExcelFileUploadList();
                eFileList.UserKey = SessionManager.GetAdminSession().insaUserV.userKey;
                eFileList.EmpNo = SessionManager.GetAdminSession().insaUserV.empNo;
                eFileList.AttachTableName = "PM_BS";
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