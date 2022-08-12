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
    [RoutePrefix("SiteMngHome/Plan/Year_Pal")]
    public class PlanYearPalController : SiteMngBaseController
    {
        [Route("List")]
        public ActionResult List(Search search)
        {
            dynamic model = new ExpandoObject();
            search.AuthUserKey = SessionManager.GetAdminSession().insaUserV.userKey;
            model.list = planYearPalRepo.selectList(search);
            model.UnionList = orgUnionRepo.selectList(new { });
            model.OrgCpyList = orgCompanyRepo.selectList(null);
            ViewBag.Search = search;

            return View("~/Views/SiteMngHome/Plan/Year_Pal/List.cshtml", model);
        }

        [Route("Write")]
        public ActionResult Write(PlanYearPal entity, Search search)
        {
            dynamic model = new ExpandoObject();

            // 손익월별계획 - 기본데이터
            var planYearPal = planYearPalRepo.selectOne(entity);
            // 부문 > 회사 이름
            var orgCompanyName = orgCompanyRepo.selectOne(new { Seq = entity.OrgCompanySeq });
            // 해당 회사의 부서 정보
            var orgBusinessList = orgBusinessRepo.selectListCompany(new { Seq = entity.OrgCompanySeq });

            foreach (var business in orgBusinessList)
            {
                int thisYear = Convert.ToInt32(planYearPal.YearPalYear);
                int lastYear = thisYear + 4;

                // 해당년도의 부서. 년별 데이터 있는지 체크하여 없으면 생성
                for (int i = thisYear; i <= lastYear; i++)
                {
                    var p = new PlanYearPalBusiness();

                    p.PlanYearPalSeq = entity.Seq;
                    p.OrgBusinessSeq = business.Seq;
                    p.YearlyYear = i.ToString();
                    p.Sales = 0;
                    p.Ebit = 0;
                    p.Pbt = 0;

                    string where = " WHERE PLAN_YEAR_PAL_SEQ = @PlanYearPalSeq AND ORG_BUSINESS_SEQ = @OrgBusinessSeq AND YEARLY_YEAR = @YearlyYear";
                    if (planYearPalBusinessRepo.count(p, where) == 0) planYearPalBusinessRepo.insert(p);
                }
            }

            //상세데이터 가지고오기
            var lastYearBusinessPm = pmPalBusinessRepo.selectListBefore(new { YearPalYear = planYearPal.YearPalYear, OrgCompanySeq = entity.OrgCompanySeq });
            var lastYearBusinessPn = planYearPalBusinessRepo.selectListYear(new { YearPalYear = (Convert.ToInt32(planYearPal.YearPalYear) - 1).ToString(), OrgCompanySeq = entity.OrgCompanySeq });
            var thisYearBusinessPn = planYearPalBusinessRepo.selectListYear(new { YearPalYear = planYearPal.YearPalYear, OrgCompanySeq = entity.OrgCompanySeq });

            //var pBusinessList = planYearPalBusinessRepo.selectListWithBefore(new { planYearPalSeq = entity.Seq });

            model.planYearPal = planYearPal;
            model.orgCompanyName = orgCompanyName;
            model.orgBusinessList = orgBusinessList;
            model.lastYearBusinessPm = lastYearBusinessPm;
            model.lastYearBusinessPn = lastYearBusinessPn;
            model.thisYearBusinessPn = thisYearBusinessPn;

            //model.pBusinessList = pBusinessList;

            if (entity.message != null)
            {
                TempData["alert"] = entity.message;
            }
            ViewBag.Search = search;

            return View("~/Views/SiteMngHome/Plan/Year_Pal/Write.cshtml", model);
        }

        /// <summary>
        /// 계산하기
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        [Route("Calculation_Action")]
        public ActionResult CalculationAction(PlanYearPalAdmin entity, Search search)
        {
            #region
            Dictionary<string, object> postData = new Dictionary<string, object>();
            postData.Add("Seq", entity.Seq);
            postData.Add("OrgCompanySeq", entity.OrgCompanySeq);
            postData.Add("PageIndex", search.PageIndex);
            #endregion

            // 부서별 데이터 검증(정수 혹은 소수점 2자리까지의 데이터)
            bool bDoubleValue = true;
            List<PlanYearPalBusiness> pBusinessList = new List<PlanYearPalBusiness>();

            try
            {
                for (int i = 0; i < entity.PlanYearPalBusinessSeq.Count(); i++)
                {
                    if (!WebUtil.CheckDecimalTwo(entity.Sales[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.Ebit[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.Pbt[i].ToString())) { bDoubleValue = false; break; }

                    PlanYearPalBusiness p = new PlanYearPalBusiness();
                    p.Seq = entity.PlanYearPalBusinessSeq[i];
                    p.Sales = entity.Sales[i];
                    p.Ebit = entity.Ebit[i];
                    p.Pbt = entity.Pbt[i];

                    pBusinessList.Add(p);
                }
            }
            catch (Exception)
            {
                TempData["alert"] = Message.MSG_007_E;
                return RedirectToAction("List");

            }

            if (!bDoubleValue)
            {
                TempData["alert"] = Message.MSG_007_E;
                return RedirectToAction("List");
            }

            // 부서별 데이터 업데이트
            foreach (var item in pBusinessList)
            {
                var p = new PlanYearPalBusiness();

                p.Seq = item.Seq;
                p.Sales = item.Sales;
                p.Ebit = item.Ebit;
                p.Pbt = item.Pbt;

                planYearPalBusinessRepo.update(p);
            }

            // 계산하기 하였을 경우 기존 데이터 삭제하여 부서별 데이터의 합계를 다시 입력
            var pSum = new PlanYearPalBusinessSummary();
            pSum.PlanYearPalSeq = entity.Seq;
            planYearPalBusinessSummaryRepo.delete(pSum);
            planYearPalBusinessSummaryRepo.insert(pSum);

            
            // 미저장에서 저장으로 변경
            //if (entity.RegistStatus == Define.REGIST_STATUS.GetKey("미등록"))
            //{
            //    entity.RegistStatus = Define.REGIST_STATUS.GetKey("저장");
            //    planYearPalRepo.updateRegist(entity);
            //}

            return RedirectAndPostActionResult.RedirectAndPost("Edit", postData);
        }

        [Route("View")]
        public ActionResult view(PlanYearPalAdmin entity, Search search)
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");

            var planYearPal = planYearPalRepo.selectOne(entity);
            //var orgBusinessList = orgBusinessRepo.selectListCompany(new { Seq = entity.OrgCompanySeq });
            var orgBusinessList = orgBusinessRepo.selectListAll(new { orgCompanySeq = entity.OrgCompanySeq });
            var orgCompanyName = orgCompanyRepo.selectOne(new { Seq = entity.OrgCompanySeq });
            var pBusinessList = planYearPalBusinessRepo.selectListWithBefore(new { PlanYearPalSeq = entity.Seq });
            var pYearList = planYearPalBusinessSummaryRepo.selectListWithBefore(new { PlanYearPalSeq = entity.Seq });

            //상세데이터 가지고오기
            var lastYearBusinessPm = pmPalBusinessRepo.selectListBefore(new { YearPalYear = planYearPal.YearPalYear, OrgCompanySeq = entity.OrgCompanySeq });
            var lastYearBusinessPn = planYearPalBusinessRepo.selectListYear(new { YearPalYear = (Convert.ToInt32(planYearPal.YearPalYear) - 1).ToString(), OrgCompanySeq = entity.OrgCompanySeq });
            var thisYearBusinessPn = planYearPalBusinessRepo.selectListYear(new { YearPalYear = planYearPal.YearPalYear, OrgCompanySeq = entity.OrgCompanySeq });

            // 합계데이터 가져오기
            var lastYearSumPm = pmPalSummaryRepo.selectListBefore(new { YearPalYear = planYearPal.YearPalYear, OrgCompanySeq = entity.OrgCompanySeq });
            var lastYearSumPn = planYearPalBusinessSummaryRepo.selectListYear(new { YearPalYear = (Convert.ToInt32(planYearPal.YearPalYear) - 1).ToString(), OrgCompanySeq = entity.OrgCompanySeq });
            var thisYearSumPn = planYearPalBusinessSummaryRepo.selectListYear(new { YearPalYear = planYearPal.YearPalYear, OrgCompanySeq = entity.OrgCompanySeq });

            // 현재기준의 Bu만 조인하여 넣는다.
            var orgBusinessList2 = from x in orgBusinessList
                                   join y in thisYearBusinessPn on x.Seq equals y.OrgBusinessSeq
                                   group x by new { x.Seq, x.BusinessName } into g
                                   select new OrgBusiness
                                   {
                                       Seq = g.First().Seq,
                                       BusinessName = g.First().BusinessName
                                   };
            orgBusinessList = orgBusinessList2.ToList();


            dynamic model = new ExpandoObject();
            model.planYearPal = planYearPal;
            model.orgCompanyName = orgCompanyName;
            model.orgBusinessList = orgBusinessList;
            model.pBusinessList = pBusinessList;
            model.pYearList = pYearList;

            model.lastYearBusinessPm = lastYearBusinessPm;
            model.lastYearBusinessPn = lastYearBusinessPn;
            model.thisYearBusinessPn = thisYearBusinessPn;

            model.lastYearSumPm = lastYearSumPm;
            model.lastYearSumPn = lastYearSumPn;
            model.thisYearSumPn = thisYearSumPn;

            if (entity.message != null)
            {
                TempData["alert"] = entity.message;
            }

            ViewBag.Search = search;
            return View("~/Views/SiteMngHome/Plan/Year_Pal/View.cshtml", model);
        }

        [Route("Edit")]
        public ActionResult Edit(PlanYearPal entity, Search search)
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");
            var planYearPal = planYearPalRepo.selectOne(entity);
            //var orgBusinessList = orgBusinessRepo.selectListCompany(new { Seq = entity.OrgCompanySeq });
            var orgBusinessList = orgBusinessRepo.selectListAll(new { orgCompanySeq = entity.OrgCompanySeq });
            var orgCompanyName = orgCompanyRepo.selectOne(new { Seq = entity.OrgCompanySeq });
            var pBusinessList = planYearPalBusinessRepo.selectListWithBefore(new { PlanYearPalSeq = entity.Seq });
            var pYearList = planYearPalBusinessSummaryRepo.selectListWithBefore(new { PlanYearPalSeq = entity.Seq });

            //상세데이터 가지고오기
            var lastYearBusinessPm = pmPalBusinessRepo.selectListBefore(new { YearPalYear = planYearPal.YearPalYear, OrgCompanySeq = entity.OrgCompanySeq });
            var lastYearBusinessPn = planYearPalBusinessRepo.selectListYear(new { YearPalYear = (Convert.ToInt32(planYearPal.YearPalYear) - 1).ToString(), OrgCompanySeq = entity.OrgCompanySeq });
            var thisYearBusinessPn = planYearPalBusinessRepo.selectListYear(new { YearPalYear = planYearPal.YearPalYear, OrgCompanySeq = entity.OrgCompanySeq });

            // 합계데이터 가져오기
            var lastYearSumPm = pmPalSummaryRepo.selectListBefore(new { YearPalYear = planYearPal.YearPalYear, OrgCompanySeq = entity.OrgCompanySeq });
            var lastYearSumPn = planYearPalBusinessSummaryRepo.selectListYear(new { YearPalYear = (Convert.ToInt32(planYearPal.YearPalYear) - 1).ToString(), OrgCompanySeq = entity.OrgCompanySeq });
            var thisYearSumPn = planYearPalBusinessSummaryRepo.selectListYear(new { YearPalYear = planYearPal.YearPalYear, OrgCompanySeq = entity.OrgCompanySeq });

            // 현재기준의 Bu만 조인하여 넣는다.
            var orgBusinessList2 = from x in orgBusinessList
                                   join y in thisYearBusinessPn on x.Seq equals y.OrgBusinessSeq
                                   group x by new { x.Seq, x.BusinessName } into g
                                   select new OrgBusiness
                                   {
                                       Seq = g.First().Seq,
                                       BusinessName = g.First().BusinessName
                                   };
            orgBusinessList = orgBusinessList2.ToList();

            dynamic model = new ExpandoObject();

            model.planYearPal = planYearPal;
            model.orgCompanyName = orgCompanyName;
            model.orgBusinessList = orgBusinessList;
            model.pBusinessList = pBusinessList;
            model.pYearList = pYearList;

            model.lastYearBusinessPm = lastYearBusinessPm;
            model.lastYearBusinessPn = lastYearBusinessPn;
            model.thisYearBusinessPn = thisYearBusinessPn;

            model.lastYearSumPm = lastYearSumPm;
            model.lastYearSumPn = lastYearSumPn;
            model.thisYearSumPn = thisYearSumPn;

            if (entity.message != null)
            {
                TempData["alert"] = entity.message;
            }

            ViewBag.Search = search;
            return View("~/Views/SiteMngHome/Plan/Year_Pal/Edit.cshtml", model);
        }

        [Route("Edit2")]
        public ActionResult Edit2(PlanYearPal entity, Search search)
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");
            var planYearPal = planYearPalRepo.selectOne(entity);
            var orgCompanyName = orgCompanyRepo.selectOne(new { Seq = entity.OrgCompanySeq });

            // 합계데이터 가져오기
            var lastYearSumPm = pmPalSummaryRepo.selectListBefore(new { YearPalYear = planYearPal.YearPalYear, OrgCompanySeq = entity.OrgCompanySeq });
            var lastYearSumPn = planYearPalBusinessSummaryRepo.selectListYear(new { YearPalYear = (Convert.ToInt32(planYearPal.YearPalYear) - 1).ToString(), OrgCompanySeq = entity.OrgCompanySeq });
            var thisYearSumPn = planYearPalBusinessSummaryRepo.selectListYear(new { YearPalYear = planYearPal.YearPalYear, OrgCompanySeq = entity.OrgCompanySeq });
            
            dynamic model = new ExpandoObject();

            model.planYearPal = planYearPal;
            model.orgCompanyName = orgCompanyName;

            model.lastYearSumPm = lastYearSumPm;
            model.lastYearSumPn = lastYearSumPn;
            model.thisYearSumPn = thisYearSumPn;

            if (entity.message != null)
            {
                TempData["alert"] = entity.message;
            }

            ViewBag.Search = search;
            return View("~/Views/SiteMngHome/Plan/Year_Pal/Edit2.cshtml", model);
        }

        [Route("Edit_Action")]
        public ActionResult EditAction(PlanYearPalAdmin entity, Search search)
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
            // 월별 및 분기별 데이터도 같이 검증
            bool bDoubleValue = true;
            var pBusinessList = new List<PlanYearPalBusiness>();
            var pMonthlySumList = new List<PlanYearPalBusinessSummary>();
            
            try
            {
                for (int i = 0; i < entity.PlanYearPalBusinessSeq.Count(); i++)
                {
                    if (!WebUtil.CheckDecimalTwo(entity.Sales[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.Ebit[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.Pbt[i].ToString())) { bDoubleValue = false; break; }

                    PlanYearPalBusiness p = new PlanYearPalBusiness();
                    p.Seq = entity.PlanYearPalBusinessSeq[i];
                    p.Sales = entity.Sales[i];
                    p.Ebit = entity.Ebit[i];
                    p.Pbt = entity.Pbt[i];

                    pBusinessList.Add(p);
                }
                
                for (int i = 0; i < entity.PlanYearPalBusinessSummarySeq.Count(); i++)
                {
                    if (!WebUtil.CheckDecimalTwo(entity.MonthSumSales[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.MonthSumEbit[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.MonthSumPbt[i].ToString())) { bDoubleValue = false; break; }

                    PlanYearPalBusinessSummary pMonthlySum = new PlanYearPalBusinessSummary();
                    pMonthlySum.Seq = entity.PlanYearPalBusinessSummarySeq[i];
                    pMonthlySum.sales = entity.MonthSumSales[i];
                    pMonthlySum.ebit = entity.MonthSumEbit[i];
                    pMonthlySum.pbt = entity.MonthSumPbt[i];

                    pMonthlySumList.Add(pMonthlySum);
                }
            }
            catch (Exception)
            {
                TempData["alert"] = Message.MSG_007_E;
                return RedirectToAction("List");
            }

            if (!bDoubleValue)
            {
                TempData["alert"] = Message.MSG_007_E;
                return RedirectToAction("List");
            }

            // 부서별 데이터 업데이트
            for (int i = 0; i < pBusinessList.Count(); i++)
            {
                var p = new PlanYearPalBusiness();
                p.Seq = pBusinessList[i].Seq;
                p.Sales = pBusinessList[i].Sales;
                p.Ebit = pBusinessList[i].Ebit;
                p.Pbt = pBusinessList[i].Pbt;

                planYearPalBusinessRepo.update(p);
            }

            for (int i = 0; i < pMonthlySumList.Count(); i++)
            {
                var p = new PlanYearPalBusinessSummary();
                p.Seq = pMonthlySumList[i].Seq;
                p.sales = pMonthlySumList[i].sales;
                p.ebit = pMonthlySumList[i].ebit;
                p.pbt = pMonthlySumList[i].pbt;

                planYearPalBusinessSummaryRepo.update(p);
            }
            
            // 미저장에서 저장으로 변경
            if (entity.RegistStatus == Define.REGIST_STATUS.GetKey("미등록"))
            {
                entity.RegistStatus = Define.REGIST_STATUS.GetKey("저장");
                planYearPalRepo.updateRegist(entity);
            }

            return RedirectAndPostActionResult.RedirectAndPost("Edit", postData);
        }

        /// <summary>
        /// 승인요청, 승인, 반려등의 상태 변경
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        [Route("Regist_Status_Change")]
        public ActionResult RegistStatusChange(PlanYearPalAdmin entity, Search search)
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
            planYearPalRepo.updateRegist(entity);

            return RedirectToAction("List", search);
        }

        /// <summary>
        /// 엑셀 양식 다운로드
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        [Route("Excel_Down")]
        public ActionResult ExcelDown(PlanYearPal entity)
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");

            var planYearPal = planYearPalRepo.selectOne(entity);
            var orgCompanyName = orgCompanyRepo.selectOne(new { Seq = entity.OrgCompanySeq });
            var pBusinessList = planYearPalBusinessRepo.selectListExcel(new { PlanYearPalSeq = entity.Seq });

            string fileName = "손익중기계획_" + planYearPal.YearPalYear + "년_" + orgCompanyName.CompanyName;

            int rows = 1, cells = 1;

            using (XLWorkbook wb = new XLWorkbook())
            {
                var ws = wb.Worksheets.Add("손익중기계획");

                // 해더 선언
                var wsHeader = ws.Cell(rows, cells);
                var wsHeaderStyle = wsHeader.Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                // 컬럼 숨기기
                ws.Column(1).Hide();
                ws.Column(2).Hide();
                ws.Column(4).Hide();

                ws.Cell(rows, cells).SetValue("ParentSeq").Style = wsHeaderStyle;
                ws.Cell(rows, ++cells).SetValue("Seq").Style = wsHeaderStyle;
                ws.Cell(rows, ++cells).SetValue("CompanyName").Style = wsHeaderStyle;
                ws.Cell(rows, ++cells).SetValue("BusinessSeq").Style = wsHeaderStyle;
                ws.Cell(rows, ++cells).SetValue("BusinessName").Style = wsHeaderStyle;
                ws.Cell(rows, ++cells).SetValue("년").Style = wsHeaderStyle;
                ws.Cell(rows, ++cells).SetValue("Sales").Style = wsHeaderStyle;
                ws.Cell(rows, ++cells).SetValue("Ebit").Style = wsHeaderStyle;
                ws.Cell(rows, ++cells).SetValue("Pbt").Style = wsHeaderStyle;

                foreach (var item in pBusinessList)
                {
                    rows++;
                    cells = 1;
                    ws.Cell(rows, cells).SetValue(item.PlanYearPalSeq).Style = wsHeaderStyle.Fill.SetBackgroundColor(XLColor.NoColor);
                    ws.Cell(rows, ++cells).SetValue(item.Seq).Style = wsHeaderStyle.Fill.SetBackgroundColor(XLColor.NoColor);
                    ws.Cell(rows, ++cells).SetValue(item.CompanyName).Style = wsHeaderStyle.Fill.SetBackgroundColor(XLColor.NoColor);
                    ws.Cell(rows, ++cells).SetValue(item.OrgBusinessSeq).Style = wsHeaderStyle.Fill.SetBackgroundColor(XLColor.NoColor);
                    ws.Cell(rows, ++cells).SetValue(item.BusinessName).Style = wsHeaderStyle.Fill.SetBackgroundColor(XLColor.NoColor);
                    ws.Cell(rows, ++cells).SetValue(item.YearlyYear).Style = wsHeaderStyle.Fill.SetBackgroundColor(XLColor.NoColor);
                    ws.Cell(rows, ++cells).SetValue(item.Sales).Style = wsHeaderStyle.Fill.SetBackgroundColor(XLColor.Yellow);
                    ws.Cell(rows, ++cells).SetValue(item.Ebit).Style = wsHeaderStyle.Fill.SetBackgroundColor(XLColor.Yellow);
                    ws.Cell(rows, ++cells).SetValue(item.Pbt).Style = wsHeaderStyle.Fill.SetBackgroundColor(XLColor.Yellow);
                }

                // 1, 1셀에 색이 입혀져서 마지막에 다시 넣는 걸로 
                rows = 1;
                cells = 1;
                ws.Cell(rows, cells).SetValue("ParentSeq").Style = wsHeaderStyle.Border.SetOutsideBorder(XLBorderStyleValues.Thin).Fill.SetBackgroundColor(XLColor.NoColor);

                using (MemoryStream mStream = new MemoryStream())
                {
                    wb.SaveAs(mStream);
                    return File(mStream.ToArray(), "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", fileName + ".xlsx");
                }
            }

            /*
            var planMonthlyPal = planMonthlyPalRepo.selectOne(entity);
            var orgCompanyName = orgCompanyRepo.selectOne(new { Seq = entity.OrgCompanySeq });
            var pBusinessList = planMonthlyPalBusinessRepo.selectListExcel(new { PlanMonthlyPalSeq = entity.Seq });

            dynamic model = new ExpandoObject();
            model.planMonthlyPal = planMonthlyPal;
            model.orgCompanyName = orgCompanyName;
            model.pBusinessList = pBusinessList;

            return View("~/Views/SiteMngHome/Plan/Monthly_Pal/Excel.cshtml", model);
            */
        }

        /// <summary>
        /// 엑셀 양식 다운로드
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        [Route("Excel_Down2")]
        public ActionResult ExcelDown2(PlanYearPal entity)
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");

            var planYearPal = planYearPalRepo.selectOne(entity);
            var orgCompanyName = orgCompanyRepo.selectOne(new { Seq = entity.OrgCompanySeq });
            var pBusinessList = planYearPalBusinessRepo.selectListExcel(new { PlanYearPalSeq = entity.Seq });

            string fileName = "손익중기계획_" + planYearPal.YearPalYear + "년_" + orgCompanyName.CompanyName;

            int rows = 1, cells = 1;

            using (XLWorkbook wb = new XLWorkbook())
            {
                var ws = wb.Worksheets.Add("손익중기계획");

                // 해더 선언
                var wsHeader = ws.Cell(rows, cells);
                var wsHeaderStyle = wsHeader.Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                // 컬럼 숨기기
               // ws.Column(1).Hide();
                ws.Column(2).Hide();
               // ws.Column(4).Hide();

                //ws.Cell(rows, cells).SetValue("ParentSeq").Style = wsHeaderStyle;
               // ws.Cell(rows, ++cells).SetValue("Seq").Style = wsHeaderStyle;
                ws.Cell(rows, cells).SetValue("CompanyName").Style = wsHeaderStyle;
                ws.Cell(rows, ++cells).SetValue("BusinessSeq").Style = wsHeaderStyle;
                ws.Cell(rows, ++cells).SetValue("BusinessName").Style = wsHeaderStyle;
                ws.Cell(rows, ++cells).SetValue("년").Style = wsHeaderStyle;
                ws.Cell(rows, ++cells).SetValue("Sales").Style = wsHeaderStyle;
                ws.Cell(rows, ++cells).SetValue("Ebit").Style = wsHeaderStyle;
                ws.Cell(rows, ++cells).SetValue("Pbt").Style = wsHeaderStyle;

                foreach (var item in pBusinessList)
                {
                    rows++;
                    cells = 1;
                    //ws.Cell(rows, cells).SetValue(item.PlanYearPalSeq).Style = wsHeaderStyle.Fill.SetBackgroundColor(XLColor.NoColor);
                    //ws.Cell(rows, ++cells).SetValue(item.Seq).Style = wsHeaderStyle.Fill.SetBackgroundColor(XLColor.NoColor);
                    ws.Cell(rows, cells).SetValue(item.CompanyName).Style = wsHeaderStyle.Fill.SetBackgroundColor(XLColor.NoColor);
                    ws.Cell(rows, ++cells).SetValue(item.OrgBusinessSeq).Style = wsHeaderStyle.Fill.SetBackgroundColor(XLColor.NoColor);
                    ws.Cell(rows, ++cells).SetValue(item.BusinessName).Style = wsHeaderStyle.Fill.SetBackgroundColor(XLColor.NoColor);
                    ws.Cell(rows, ++cells).SetValue(item.YearlyYear).Style = wsHeaderStyle.Fill.SetBackgroundColor(XLColor.NoColor);
                    ws.Cell(rows, ++cells).SetValue(item.Sales).Style = wsHeaderStyle.Fill.SetBackgroundColor(XLColor.Yellow);
                    ws.Cell(rows, ++cells).SetValue(item.Ebit).Style = wsHeaderStyle.Fill.SetBackgroundColor(XLColor.Yellow);
                    ws.Cell(rows, ++cells).SetValue(item.Pbt).Style = wsHeaderStyle.Fill.SetBackgroundColor(XLColor.Yellow);
                }

                // 1, 1셀에 색이 입혀져서 마지막에 다시 넣는 걸로 
                rows = 1;
                cells = 1;
                ws.Cell(rows, cells).SetValue("ParentSeq").Style = wsHeaderStyle.Border.SetOutsideBorder(XLBorderStyleValues.Thin).Fill.SetBackgroundColor(XLColor.NoColor);

                using (MemoryStream mStream = new MemoryStream())
                {
                    wb.SaveAs(mStream);
                    return File(mStream.ToArray(), "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", fileName + ".xlsx");
                }
            }

            /*
            var planMonthlyPal = planMonthlyPalRepo.selectOne(entity);
            var orgCompanyName = orgCompanyRepo.selectOne(new { Seq = entity.OrgCompanySeq });
            var pBusinessList = planMonthlyPalBusinessRepo.selectListExcel(new { PlanMonthlyPalSeq = entity.Seq });

            dynamic model = new ExpandoObject();
            model.planMonthlyPal = planMonthlyPal;
            model.orgCompanyName = orgCompanyName;
            model.pBusinessList = pBusinessList;

            return View("~/Views/SiteMngHome/Plan/Monthly_Pal/Excel.cshtml", model);
            */
        }
        /// <summary>
        /// 양식업로드
        /// </summary>
        /// <param name="Seq"></param>
        /// <param name="OrgCompanySeq"></param>
        /// <param name="ExcelFile"></param>
        /// <returns></returns>
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
                string filePath = "PlanYearPal";
                var file = fileUtil.FileUpload(ExcelFile, filePath);


                bool bDoubleValue = true;
                ExcelUtil excelUtil = new ExcelUtil();
                var dt = excelUtil.ImportExcel(file["FILE_PATH"]);
                List<PlanYearPalBusiness> pBusinessList = new List<PlanYearPalBusiness>();
                try
                {
                    foreach (DataRow item in dt.Rows)
                    {
                        string parentSeq = item.ItemArray.GetValue(0).ToString();
                        string excelSeq = item.ItemArray.GetValue(1).ToString();
                        string companyName = item.ItemArray.GetValue(2).ToString();
                        string businessSeq = item.ItemArray.GetValue(3).ToString();
                        string businessName = item.ItemArray.GetValue(4).ToString();
                        string yearlyYear = item.ItemArray.GetValue(5).ToString();
                        string sales = item.ItemArray.GetValue(6).ToString();
                        string ebit = item.ItemArray.GetValue(7).ToString();
                        string pbt = item.ItemArray.GetValue(8).ToString();
                        if (parentSeq != Seq.ToString()) { bDoubleValue = false; break; }       // 현재 코드와 업로드하려는 코드가 다른 경우는 양식이 잘못된것으로 오류
                        //if (!WebUtil.CheckDecimalTwo(sales)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(ebit)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(pbt)) { bDoubleValue = false; break; }

                        var pBusiness = new PlanYearPalBusiness();
                        pBusiness.Seq = Convert.ToInt32(excelSeq);
                        pBusiness.Sales = Convert.ToDecimal(sales);
                        pBusiness.Ebit = Convert.ToDecimal(ebit);
                        pBusiness.Pbt = Convert.ToDecimal(pbt);

                        pBusinessList.Add(pBusiness);
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

                if (!bDoubleValue)
                {
                    fileUtil.FileDelete(filePath, file["STORED_FILE_NAME"]);
                    result = false;
                    resultMsg = Message.MSG_007_E;
                    return Json(new { success = result, resultMsg = resultMsg }, JsonRequestBehavior.AllowGet);
                }

                // 문제 없으면 업데이트
                for (int i = 0; i < pBusinessList.Count(); i++)
                {
                    PlanYearPalBusiness p = new PlanYearPalBusiness();
                    p.Seq = pBusinessList[i].Seq;
                    p.Sales = pBusinessList[i].Sales;
                    p.Ebit = pBusinessList[i].Ebit;
                    p.Pbt = pBusinessList[i].Pbt;

                    planYearPalBusinessRepo.update(p);
                }

                // 업데이트 완료 후 로그 남기기
                ExcelFileUploadList eFileList = new ExcelFileUploadList();
                eFileList.UserKey = SessionManager.GetAdminSession().insaUserV.userKey;
                eFileList.EmpNo = SessionManager.GetAdminSession().insaUserV.empNo;
                eFileList.AttachTableName = "PLAN_MONTHLY_PAL";
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

        /// <summary>
        /// 양식업로드
        /// </summary>
        /// <param name="Seq"></param>
        /// <param name="OrgCompanySeq"></param>
        /// <param name="ExcelFile"></param>
        /// <returns></returns>
        [Route("Excel_Upload2")]
        public ActionResult ExcelUpload2(int Seq, int OrgCompanySeq, List<int> PlanYearPalBusinessSeq, HttpPostedFileBase ExcelFile)
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
                string filePath = "PlanYearPal";
                var file = fileUtil.FileUpload(ExcelFile, filePath);


                bool bDoubleValue = true;
                ExcelUtil excelUtil = new ExcelUtil();
                var dt = excelUtil.ImportExcel(file["FILE_PATH"]);
                List<PlanYearPalBusiness> pBusinessList = new List<PlanYearPalBusiness>();
                try
                {
                    int j = 0;
                    foreach (DataRow item in dt.Rows)
                    {
                        //string parentSeq = item.ItemArray.GetValue(0).ToString();
                        string excelSeq = PlanYearPalBusinessSeq[j].ToString();

                        string sales = item.ItemArray.GetValue(4).ToString();
                        string ebit = item.ItemArray.GetValue(5).ToString();
                        string pbt = item.ItemArray.GetValue(6).ToString();
                        //string companyName = item.ItemArray.GetValue(2).ToString();
                        //string businessSeq = item.ItemArray.GetValue(3).ToString();
                        //string businessName = item.ItemArray.GetValue(4).ToString();
                        //string yearlyYear = item.ItemArray.GetValue(5).ToString();
                        //string sales = item.ItemArray.GetValue(6).ToString();
                        //string ebit = item.ItemArray.GetValue(7).ToString();
                        //string pbt = item.ItemArray.GetValue(8).ToString();
                        //if (parentSeq != Seq.ToString()) { bDoubleValue = false; break; }       // 현재 코드와 업로드하려는 코드가 다른 경우는 양식이 잘못된것으로 오류
                        //if (!WebUtil.CheckDecimalTwo(sales)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(ebit)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(pbt)) { bDoubleValue = false; break; }

                        var pBusiness = new PlanYearPalBusiness();
                        pBusiness.Seq = Convert.ToInt32(excelSeq);
                        pBusiness.Sales = Convert.ToDecimal(sales);
                        pBusiness.Ebit = Convert.ToDecimal(ebit);
                        pBusiness.Pbt = Convert.ToDecimal(pbt);

                        pBusinessList.Add(pBusiness);
                        j += 1;
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

                if (!bDoubleValue)
                {
                    fileUtil.FileDelete(filePath, file["STORED_FILE_NAME"]);
                    result = false;
                    resultMsg = Message.MSG_007_E;
                    return Json(new { success = result, resultMsg = resultMsg }, JsonRequestBehavior.AllowGet);
                }

                // 문제 없으면 업데이트
                for (int i = 0; i < pBusinessList.Count(); i++)
                {
                    PlanYearPalBusiness p = new PlanYearPalBusiness();
                    p.Seq = pBusinessList[i].Seq;
                    p.Sales = pBusinessList[i].Sales;
                    p.Ebit = pBusinessList[i].Ebit;
                    p.Pbt = pBusinessList[i].Pbt;

                    planYearPalBusinessRepo.update(p);
                }

                // 업데이트 완료 후 로그 남기기
                ExcelFileUploadList eFileList = new ExcelFileUploadList();
                eFileList.UserKey = SessionManager.GetAdminSession().insaUserV.userKey;
                eFileList.EmpNo = SessionManager.GetAdminSession().insaUserV.empNo;
                eFileList.AttachTableName = "PLAN_MONTHLY_PAL";
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

