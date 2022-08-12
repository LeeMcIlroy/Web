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
    [RoutePrefix("SiteMngHome/Plan/Monthly_Pal")]
    public class PlanMonthlyPalController : SiteMngBaseController
    {
        [Route("List")]
        public ActionResult List(Search search)
        {
            dynamic model = new ExpandoObject();
            search.AuthUserKey = SessionManager.GetAdminSession().insaUserV.userKey;
            model.list = planMonthlyPalRepo.selectList(search);
            model.UnionList = orgUnionRepo.selectList(new { });
            model.OrgCpyList = orgCompanyRepo.selectList(null);
            ViewBag.Search = search;
            return View("~/Views/SiteMngHome/Plan/Monthly_Pal/List.cshtml", model);
        }

        [Route("Write")]
        public ActionResult Write(PlanMonthlyPal entity, Search search)
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");

            // 손역월별계획 - 기본데이터
            var planMonthlyPal = planMonthlyPalRepo.selectOne(entity);
            // 해당 회사의 부서 정보
            var orgBusinessList = orgBusinessRepo.selectListCompany(new { Seq = entity.OrgCompanySeq});
            // 부문 > 회사 이름
            var orgCompanyName = orgCompanyRepo.selectOne(new { Seq = entity.OrgCompanySeq });

            // 해당년도의 부서. 월별데이터 있는지 체크하여 없으면 생성
            foreach (var business in orgBusinessList)
            {
                PlanMonthlyPalBusiness p = new PlanMonthlyPalBusiness();
                for (int i = 1; i <= 12; i++)
                {
                    p.PlanMonthlyPalSeq = entity.Seq;
                    p.OrgBusinessSeq = business.Seq;
                    p.Monthly = i.ToString().PadLeft(2, '0');
                    p.Sales = 0;
                    p.Ebit = 0;
                    p.Pbt = 0;
                    string where = " WHERE PLAN_MONTHLY_PAL_SEQ = @PlanMonthlyPalSeq AND ORG_BUSINESS_SEQ = @OrgBusinessSeq AND MONTHLY = @Monthly";
                    if (planMonthlyPalBusinessRepo.count(p, where) == 0) planMonthlyPalBusinessRepo.insert(p);
                }
            }

            // 상세데이터 가져오기
            var pBusinessList = planMonthlyPalBusinessRepo.selectListWithBofore(new { PlanMonthlyPalSeq = entity.Seq });
            dynamic model = new ExpandoObject();
            model.planMonthlyPal = planMonthlyPal;
            model.orgCompanyName = orgCompanyName;
            model.orgBusinessList = orgBusinessList;
            model.pBusinessList = pBusinessList;
            
            if (entity.message != null)
            {
                TempData["alert"] = entity.message;
            }

            ViewBag.Search = search;

            return View("~/Views/SiteMngHome/Plan/Monthly_Pal/Write.cshtml", model);
        }

        /// <summary>
        /// 계산하기
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        [Route("Calculation_Action")]
        public ActionResult CalculationAction(PlanMonthlyPal entity, Search search)
        {
            #region
            Dictionary<string, object> postData = new Dictionary<string, object>();
            postData.Add("Seq", entity.Seq);
            postData.Add("OrgCompanySeq", entity.OrgCompanySeq);
            postData.Add("PageIndex", search.PageIndex);
            postData.Add("searchCpySeq", search.searchCpySeq);
            postData.Add("searchYear", search.searchYear);
            #endregion

            // 부서별 데이터 검증(정수 혹은 소수점 2자리까지의 데이터)
            bool bDoubleValue = true;
            List <PlanMonthlyPalBusiness> pBusinessList = new List<PlanMonthlyPalBusiness>();
            try
            {
                for (int i = 0; i < entity.PlanMonthlyPalBusinessSeq.Count(); i++)
                {
                    if (!WebUtil.CheckDecimalTwo(entity.Sales[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.Ebit[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.Pbt[i].ToString())) { bDoubleValue = false; break; }
                    
                    PlanMonthlyPalBusiness p = new PlanMonthlyPalBusiness();
                    p.Seq = entity.PlanMonthlyPalBusinessSeq[i];
                    p.Sales = entity.Sales[i];
                    p.Ebit = entity.Ebit[i];
                    p.Pbt = entity.Pbt[i];

                    pBusinessList.Add(p);
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
            else
            {
                TempData["alert"] = Message.MSG_002_A;
            }
            
            // 부서별 데이터 업데이트
            for (int i = 0; i < pBusinessList.Count(); i++)
            {
                PlanMonthlyPalBusiness p = new PlanMonthlyPalBusiness();
                p.Seq = pBusinessList[i].Seq;
                p.Sales = pBusinessList[i].Sales;
                p.Ebit = pBusinessList[i].Ebit;
                p.Pbt = pBusinessList[i].Pbt;

                planMonthlyPalBusinessRepo.update(p);
            }

            // 계산하기 하였을 경우 기존 데이터 삭제하여 부서별 데이터의 합계를 다시 입력
            PlanMonthlyPalBusinessMonthlySum pSum = new PlanMonthlyPalBusinessMonthlySum();
            pSum.PlanMonthlyPalSeq = entity.Seq;
            planMonthlyPalBusinessMonthlySumRepo.delete(pSum);
            planMonthlyPalBusinessMonthlySumRepo.insert(pSum);

            PlanMonthlyPalBusinessQuarterSum pQSum = new PlanMonthlyPalBusinessQuarterSum();
            pQSum.PlanMonthlyPalSeq = entity.Seq;
            planMonthlyPalBusinessQuarterSumRepo.delete(pQSum);
            planMonthlyPalBusinessQuarterSumRepo.insert(pQSum);

            // 2018.10.29 수정화면에서 저장한 뒤에 저장상태로 변경
            //// 미저장에서 저장으로 변경
            //if (entity.RegistStatus == Define.REGIST_STATUS.GetKey("미등록"))
            //{
            //    entity.RegistStatus = Define.REGIST_STATUS.GetKey("저장");
            //    planMonthlyPalRepo.updateRegist(entity);
            //}

            return RedirectAndPostActionResult.RedirectAndPost("Edit", postData);
        }

        [Route("View")]
        public ActionResult view(PlanMonthlyPal entity, Search search)
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");

            var planMonthlyPal = planMonthlyPalRepo.selectOne(entity);
            //var orgBusinessList = orgBusinessRepo.selectListCompany(new { Seq = entity.OrgCompanySeq });
            var orgBusinessList = orgBusinessRepo.selectListAll(new { orgCompanySeq = entity.OrgCompanySeq });
            var orgCompanyName = orgCompanyRepo.selectOne(new { Seq = entity.OrgCompanySeq });
            var pBusinessList = planMonthlyPalBusinessRepo.selectListWithBofore(new { PlanMonthlyPalSeq = entity.Seq });
            var pMonthlyList = planMonthlyPalBusinessMonthlySumRepo.selectListWithBofore(new { PlanMonthlyPalSeq = entity.Seq });
            var pQuarterList = planMonthlyPalBusinessQuarterSumRepo.selectListWithBofore(new { PlanMonthlyPalSeq = entity.Seq });

            // 현재기준의 Bu만 조인하여 넣는다.
            var orgBusinessList2 = from x in orgBusinessList
                                   join y in pBusinessList on x.Seq equals y.OrgBusinessSeq
                                   group x by new { x.Seq, x.BusinessName } into g
                                   select new OrgBusiness
                                   {
                                       Seq = g.First().Seq,
                                       BusinessName = g.First().BusinessName
                                   };
            orgBusinessList = orgBusinessList2.ToList();
            
            dynamic model = new ExpandoObject();
            model.planMonthlyPal = planMonthlyPal;
            model.orgCompanyName = orgCompanyName;
            model.orgBusinessList = orgBusinessList;
            model.pBusinessList = pBusinessList;
            model.pMonthlyList = pMonthlyList;
            model.pQuarterList = pQuarterList;

            if (entity.message != null)
            {
                TempData["alert"] = entity.message;
            }
            ViewBag.Search = search;
            return View("~/Views/SiteMngHome/Plan/Monthly_Pal/View.cshtml", model);
        }

        [Route("Edit")]
        public ActionResult Edit(PlanMonthlyPal entity, Search search)
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");

            var planMonthlyPal = planMonthlyPalRepo.selectOne(entity);
            //var orgBusinessList = orgBusinessRepo.selectListCompany(new { Seq = entity.OrgCompanySeq });
            var orgBusinessList = orgBusinessRepo.selectListAll(new { orgCompanySeq = entity.OrgCompanySeq });
            var orgCompanyName = orgCompanyRepo.selectOne(new { Seq = entity.OrgCompanySeq });
            var pBusinessList = planMonthlyPalBusinessRepo.selectListWithBofore(new { PlanMonthlyPalSeq = entity.Seq });
            var pMonthlyList = planMonthlyPalBusinessMonthlySumRepo.selectListWithBofore(new { PlanMonthlyPalSeq = entity.Seq });
            var pQuarterList = planMonthlyPalBusinessQuarterSumRepo.selectListWithBofore(new { PlanMonthlyPalSeq = entity.Seq });

            // 현재기준의 Bu만 조인하여 넣는다.
            var orgBusinessList2 = from x in orgBusinessList
                                   join y in pBusinessList on x.Seq equals y.OrgBusinessSeq
                                   group x by new { x.Seq, x.BusinessName } into g
                                   select new OrgBusiness
                                   {
                                       Seq = g.First().Seq,
                                       BusinessName = g.First().BusinessName
                                   };
            orgBusinessList = orgBusinessList2.ToList();

            dynamic model = new ExpandoObject();
            model.planMonthlyPal = planMonthlyPal;
            model.orgCompanyName = orgCompanyName;
            model.orgBusinessList = orgBusinessList;
            model.pBusinessList = pBusinessList;
            model.pMonthlyList = pMonthlyList;
            model.pQuarterList = pQuarterList;

            if (entity.message != null)
            {
                TempData["alert"] = entity.message;
            }

            ViewBag.Search = search;
            return View("~/Views/SiteMngHome/Plan/Monthly_Pal/Edit.cshtml", model);
        }

        [Route("Edit2")]
        public ActionResult Edit2(PlanMonthlyPal entity, Search search)
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");

            var planMonthlyPal = planMonthlyPalRepo.selectOne(entity);
            var orgCompanyName = orgCompanyRepo.selectOne(new { Seq = entity.OrgCompanySeq });
            var pMonthlyList = planMonthlyPalBusinessMonthlySumRepo.selectListWithBofore(new { PlanMonthlyPalSeq = entity.Seq });
            var pQuarterList = planMonthlyPalBusinessQuarterSumRepo.selectListWithBofore(new { PlanMonthlyPalSeq = entity.Seq });
            

            dynamic model = new ExpandoObject();
            model.planMonthlyPal = planMonthlyPal;
            model.orgCompanyName = orgCompanyName;
            model.pMonthlyList = pMonthlyList;
            model.pQuarterList = pQuarterList;

            if (entity.message != null)
            {
                TempData["alert"] = entity.message;
            }

            ViewBag.Search = search;
            return View("~/Views/SiteMngHome/Plan/Monthly_Pal/Edit2.cshtml", model);
        }

        [Route("Edit_Action")]
        public ActionResult EditAction(PlanMonthlyPal entity, Search search)
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");

            #region
            Dictionary<string, object> postData = new Dictionary<string, object>();
            postData.Add("Seq", entity.Seq);
            postData.Add("OrgCompanySeq", entity.OrgCompanySeq);
            postData.Add("message", Message.MSG_007_A);
            postData.Add("PageIndex", search.PageIndex);
            postData.Add("searchCpySeq",search.searchCpySeq);
            postData.Add("searchYear", search.searchYear);
            #endregion

            // 부서별 데이터 검증(정수 혹은 소수점 2자리까지의 데이터)
            // 월별 및 분기별 데이터도 같이 검증
            bool bDoubleValue = true;
            List<PlanMonthlyPalBusiness> pBusinessList = new List<PlanMonthlyPalBusiness>();
            List<PlanMonthlyPalBusinessMonthlySum> pMonthlySumList = new List<PlanMonthlyPalBusinessMonthlySum>();
            List<PlanMonthlyPalBusinessQuarterSum> pQuarterSumList = new List<PlanMonthlyPalBusinessQuarterSum>();
            try
            {
                for (int i = 0; i < entity.PlanMonthlyPalBusinessSeq.Count(); i++)
                {
                    if (!WebUtil.CheckDecimalTwo(entity.Sales[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.Ebit[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.Pbt[i].ToString())) { bDoubleValue = false; break; }

                    PlanMonthlyPalBusiness p = new PlanMonthlyPalBusiness();
                    p.Seq = entity.PlanMonthlyPalBusinessSeq[i];
                    p.Sales = entity.Sales[i];
                    p.Ebit = entity.Ebit[i];
                    p.Pbt = entity.Pbt[i];

                    pBusinessList.Add(p);
                }

                for (int i = 0; i < entity.PlanMonthlyPalBusinessMonthlySumSeq.Count(); i++)
                {
                    if (!WebUtil.CheckDecimalTwo(entity.MonthSumSales[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.MonthSumEbit[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.MonthSumPbt[i].ToString())) { bDoubleValue = false; break; }

                    PlanMonthlyPalBusinessMonthlySum pMonthlySum = new PlanMonthlyPalBusinessMonthlySum();
                    pMonthlySum.Seq = entity.PlanMonthlyPalBusinessMonthlySumSeq[i];
                    pMonthlySum.Sales = entity.MonthSumSales[i];
                    pMonthlySum.Ebit = entity.MonthSumEbit[i];
                    pMonthlySum.Pbt = entity.MonthSumPbt[i];

                    pMonthlySumList.Add(pMonthlySum);
                }

                for (int i = 0; i < entity.PlanMonthlyPalBusinessQuarterSumSeq.Count(); i++)
                {
                    if (!WebUtil.CheckDecimalTwo(entity.MonthSumSales[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.MonthSumEbit[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.MonthSumPbt[i].ToString())) { bDoubleValue = false; break; }

                    PlanMonthlyPalBusinessQuarterSum pQuarterSum = new PlanMonthlyPalBusinessQuarterSum();
                    pQuarterSum.Seq = entity.PlanMonthlyPalBusinessQuarterSumSeq[i];
                    pQuarterSum.Sales = entity.QuarterSumSales[i];
                    pQuarterSum.Ebit = entity.QuarterSumEbit[i];
                    pQuarterSum.Pbt = entity.QuarterSumPbt[i];

                    pQuarterSumList.Add(pQuarterSum);
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

            // 부서별 데이터 업데이트
            for (int i = 0; i < pBusinessList.Count(); i++)
            {
                PlanMonthlyPalBusiness p = new PlanMonthlyPalBusiness();
                p.Seq = pBusinessList[i].Seq;
                p.Sales = pBusinessList[i].Sales;
                p.Ebit = pBusinessList[i].Ebit;
                p.Pbt = pBusinessList[i].Pbt;

                planMonthlyPalBusinessRepo.update(p);
            }

            for (int i = 0; i < pMonthlySumList.Count(); i++)
            {
                PlanMonthlyPalBusinessMonthlySum p = new PlanMonthlyPalBusinessMonthlySum();
                p.Seq = pMonthlySumList[i].Seq;
                p.Sales = pMonthlySumList[i].Sales;
                p.Ebit = pMonthlySumList[i].Ebit;
                p.Pbt = pMonthlySumList[i].Pbt;

                planMonthlyPalBusinessMonthlySumRepo.update(p);
            }

            for (int i = 0; i < pQuarterSumList.Count(); i++)
            {
                PlanMonthlyPalBusinessQuarterSum p = new PlanMonthlyPalBusinessQuarterSum();
                p.Seq = pQuarterSumList[i].Seq;
                p.Sales = pQuarterSumList[i].Sales;
                p.Ebit = pQuarterSumList[i].Ebit;
                p.Pbt = pQuarterSumList[i].Pbt;

                planMonthlyPalBusinessQuarterSumRepo.update(p);
            }

            // 미저장에서 저장으로 변경
            if (entity.RegistStatus == Define.REGIST_STATUS.GetKey("미등록"))
            {
                entity.RegistStatus = Define.REGIST_STATUS.GetKey("저장");
                planMonthlyPalRepo.updateRegist(entity);
            }
           // ViewBag.Search = search;
            return RedirectAndPostActionResult.RedirectAndPost("Edit", postData);
        }

        /// <summary>
        /// 승인요청, 승인, 반려등의 상태 변경
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        [Route("Regist_Status_Change")]
        public ActionResult RegistStatusChange(PlanMonthlyPal entity, Search search)
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");
            
            #region
            Dictionary<string, object> postData = new Dictionary<string, object>();
            postData.Add("Seq", entity.Seq);
            postData.Add("OrgCompanySeq", entity.OrgCompanySeq);
            postData.Add("message", entity.message);
            postData.Add("searchCpySeq", search.searchCpySeq);
            postData.Add("searchYear", search.searchYear);
            #endregion

            // 현재 상태값을 변경한다.
            entity.RegistStatus = entity.afterRegistStatus;
            planMonthlyPalRepo.updateRegist(entity);

            return RedirectToAction("List", search);
        }

        /// <summary>
        /// 엑셀 양식 다운로드
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        [Route("Excel_Down")]
        public ActionResult ExcelDown(PlanMonthlyPal entity)
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");

            var planMonthlyPal = planMonthlyPalRepo.selectOne(entity);
            var orgCompanyName = orgCompanyRepo.selectOne(new { Seq = entity.OrgCompanySeq });
            var pBusinessList = planMonthlyPalBusinessRepo.selectListExcel(new { PlanMonthlyPalSeq = entity.Seq });

            string fileName = "손익월별계획_" + planMonthlyPal.MonthlyPalYear + "년_" + orgCompanyName.CompanyName;

            int rows = 1, cells = 1;

            using (XLWorkbook  wb = new XLWorkbook())
            {
                var ws = wb.Worksheets.Add("손익월별계획");

                // 컬럼 숨기기
                ws.Column(1).Hide();
                ws.Column(2).Hide();
                ws.Column(4).Hide();

                ws.Cell(rows, cells).SetValue("ParentSeq").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                ws.Cell(rows, ++cells).SetValue("Seq").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                ws.Cell(rows, ++cells).SetValue("CompanyName").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                ws.Cell(rows, ++cells).SetValue("BusinessSeq").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                ws.Cell(rows, ++cells).SetValue("BusinessName").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                ws.Cell(rows, ++cells).SetValue("월").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                ws.Cell(rows, ++cells).SetValue("Sales").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                ws.Cell(rows, ++cells).SetValue("Ebit").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                ws.Cell(rows, ++cells).SetValue("Pbt").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                foreach (var item in pBusinessList)
                {
                    rows++;
                    cells = 1;
                    ws.Cell(rows, cells).SetValue(item.PlanMonthlyPalSeq).Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin).Fill.SetBackgroundColor(XLColor.NoColor);
                    ws.Cell(rows, ++cells).SetValue(item.Seq).Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin).Fill.SetBackgroundColor(XLColor.NoColor);
                    ws.Cell(rows, ++cells).SetValue(item.CompanyName).Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin).Fill.SetBackgroundColor(XLColor.NoColor);
                    ws.Cell(rows, ++cells).SetValue(item.OrgBusinessSeq).Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin).Fill.SetBackgroundColor(XLColor.NoColor);
                    ws.Cell(rows, ++cells).SetValue(item.BusinessName).Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin).Fill.SetBackgroundColor(XLColor.NoColor);
                    ws.Cell(rows, ++cells).SetValue(item.Monthly).Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin).Fill.SetBackgroundColor(XLColor.NoColor);
                    ws.Cell(rows, ++cells).SetValue(item.Sales).Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin).Fill.SetBackgroundColor(XLColor.Yellow);
                    ws.Cell(rows, ++cells).SetValue(item.Ebit).Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin).Fill.SetBackgroundColor(XLColor.Yellow);
                    ws.Cell(rows, ++cells).SetValue(item.Pbt).Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin).Fill.SetBackgroundColor(XLColor.Yellow);
                }
                                
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

        [Route("Excel_Down2")]
        public ActionResult ExcelDown2(PlanMonthlyPal entity)
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");

            var planMonthlyPal = planMonthlyPalRepo.selectOne(entity);
            var orgCompanyName = orgCompanyRepo.selectOne(new { Seq = entity.OrgCompanySeq });
            var pBusinessList = planMonthlyPalBusinessRepo.selectListExcel(new { PlanMonthlyPalSeq = entity.Seq });

            string fileName = "손익월별계획_" + planMonthlyPal.MonthlyPalYear + "년_" + orgCompanyName.CompanyName;

            int rows = 1, cells = 1;

            using (XLWorkbook wb = new XLWorkbook())
            {
                var ws = wb.Worksheets.Add("손익월별계획");

                // 컬럼 숨기기
                //ws.Column(1).Hide();
               // ws.Column(2).Hide();
               ws.Column(2).Hide();

                //ws.Cell(rows, cells).SetValue("ParentSeq").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
               // ws.Cell(rows, ++cells).SetValue("Seq").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                ws.Cell(rows, cells).SetValue("CompanyName").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                ws.Cell(rows, ++cells).SetValue("BusinessSeq").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                ws.Cell(rows, ++cells).SetValue("BusinessName").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                ws.Cell(rows, ++cells).SetValue("월").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                ws.Cell(rows, ++cells).SetValue("Sales").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                ws.Cell(rows, ++cells).SetValue("Ebit").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                ws.Cell(rows, ++cells).SetValue("Pbt").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                foreach (var item in pBusinessList)
                {
                    rows++;
                    cells = 1;
                   // ws.Cell(rows, cells).SetValue(item.PlanMonthlyPalSeq).Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin).Fill.SetBackgroundColor(XLColor.NoColor);
                   // ws.Cell(rows, ++cells).SetValue(item.Seq).Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin).Fill.SetBackgroundColor(XLColor.NoColor);
                    ws.Cell(rows, cells).SetValue(item.CompanyName).Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin).Fill.SetBackgroundColor(XLColor.NoColor);
                    ws.Cell(rows, ++cells).SetValue(item.OrgBusinessSeq).Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin).Fill.SetBackgroundColor(XLColor.NoColor);
                    ws.Cell(rows, ++cells).SetValue(item.BusinessName).Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin).Fill.SetBackgroundColor(XLColor.NoColor);
                    ws.Cell(rows, ++cells).SetValue(item.Monthly).Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin).Fill.SetBackgroundColor(XLColor.NoColor);
                    ws.Cell(rows, ++cells).SetValue(item.Sales).Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin).Fill.SetBackgroundColor(XLColor.Yellow);
                    ws.Cell(rows, ++cells).SetValue(item.Ebit).Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin).Fill.SetBackgroundColor(XLColor.Yellow);
                    ws.Cell(rows, ++cells).SetValue(item.Pbt).Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin).Fill.SetBackgroundColor(XLColor.Yellow);
                }

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
                string filePath = "PlanMonthlyPal";
                var file = fileUtil.FileUpload(ExcelFile, filePath);
                
               

                bool bDoubleValue = true;
                ExcelUtil excelUtil = new ExcelUtil();
                var dt = excelUtil.ImportExcel(file["FILE_PATH"]);
                List<PlanMonthlyPalBusiness> pBusinessList = new List<PlanMonthlyPalBusiness>();
                try
                {
                    foreach (DataRow item in dt.Rows)
                    {
                        string parentSeq = item.ItemArray.GetValue(0).ToString();
                        string excelSeq = item.ItemArray.GetValue(1).ToString();
                        string companyName = item.ItemArray.GetValue(2).ToString();
                        string businessSeq = item.ItemArray.GetValue(3).ToString();
                        string businessName = item.ItemArray.GetValue(4).ToString();
                        string month = item.ItemArray.GetValue(5).ToString();
                        string sales = item.ItemArray.GetValue(6).ToString();
                        string ebit = item.ItemArray.GetValue(7).ToString();
                        string pbt = item.ItemArray.GetValue(8).ToString();
                        if (parentSeq != Seq.ToString()) { bDoubleValue = false; break; }       // 현재 코드와 업로드하려는 코드가 다른 경우는 양식이 잘못된것으로 오류
                        //if (!WebUtil.CheckDecimalTwo(sales)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(ebit)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(pbt)) { bDoubleValue = false; break; }

                        PlanMonthlyPalBusiness pBusiness = new PlanMonthlyPalBusiness();
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
                    PlanMonthlyPalBusiness p = new PlanMonthlyPalBusiness();
                    p.Seq = pBusinessList[i].Seq;
                    p.Sales = pBusinessList[i].Sales;
                    p.Ebit = pBusinessList[i].Ebit;
                    p.Pbt = pBusinessList[i].Pbt;

                    planMonthlyPalBusinessRepo.update(p);
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
        public ActionResult ExcelUpload2(int Seq, int OrgCompanySeq, List<int> PlanMonthlyPalBusinessSeq, HttpPostedFileBase ExcelFile)
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
                string filePath = "PlanMonthlyPal";
                var file = fileUtil.FileUpload(ExcelFile, filePath);


                bool bDoubleValue = true;
                ExcelUtil excelUtil = new ExcelUtil();
                var dt = excelUtil.ImportExcel(file["FILE_PATH"]);
                List<PlanMonthlyPalBusiness> pBusinessList = new List<PlanMonthlyPalBusiness>();
                try
                {
                    int j = 0;
                    foreach (DataRow item in dt.Rows)
                    {
                        
                       // string parentSeq = item.ItemArray.GetValue(0).ToString();
                        string excelSeq = PlanMonthlyPalBusinessSeq[j].ToString();
                        // string companyName = item.ItemArray.GetValue(2).ToString();
                        // string businessSeq = item.ItemArray.GetValue(3).ToString();
                        // string businessName = item.ItemArray.GetValue(4).ToString();
                        // string month = item.ItemArray.GetValue(5).ToString();
                        //string sales = item.ItemArray.GetValue(6).ToString();
                        //string ebit = item.ItemArray.GetValue(7).ToString();
                        //string pbt = item.ItemArray.GetValue(8).ToString();
                        // if (parentSeq != Seq.ToString()) { bDoubleValue = false; break; }       // 현재 코드와 업로드하려는 코드가 다른 경우는 양식이 잘못된것으로 오류
                        //if (!WebUtil.CheckDecimalTwo(sales)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(ebit)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(pbt)) { bDoubleValue = false; break; }

                        string sales = item.ItemArray.GetValue(4).ToString();
                        string ebit = item.ItemArray.GetValue(5).ToString();
                        string pbt = item.ItemArray.GetValue(6).ToString();

                        PlanMonthlyPalBusiness pBusiness = new PlanMonthlyPalBusiness();
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
                    PlanMonthlyPalBusiness p = new PlanMonthlyPalBusiness();
                    p.Seq = pBusinessList[i].Seq;
                    p.Sales = pBusinessList[i].Sales;
                    p.Ebit = pBusinessList[i].Ebit;
                    p.Pbt = pBusinessList[i].Pbt;

                    planMonthlyPalBusinessRepo.update(p);
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