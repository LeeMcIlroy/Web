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

namespace HALLA_PM.Controllers.SiteMngHome
{
    [AdminLoginFilter]
    [AuthAdminFilter(RequestAuthLevel = 1)]
    [RoutePrefix("SiteMngHome/Performance/Group")]
    public class PmGroupController : SiteMngBaseController
    {
        [Route("List")]
        public ActionResult List(Search search)
        {
            dynamic model = new ExpandoObject();
            model.list = pmGroupRepo.selectList(search);
            ViewBag.Search = search;
            return View("~/Views/SiteMngHome/Performance/Group/List.cshtml", model);
        }

        [Route("EXCEL_PM_CASH_FLOW")]
        public ActionResult EXCEL_PM_CASH_FLOW(string pmYear, string Monthly, string TableName)
        {
            var chk = pmGroupRepo.selectListAll(new { }).ToList().Where(w => w.PmYear == pmYear).Where(w => w.Monthly == Monthly).Where(w => w.TableName == TableName).FirstOrDefault();

            if (chk == null || chk.RegistType == "N")
            {
                TempData["alert"] = "데이터가 취합되지 않았습니다. 회사별 최종승인 여부를 다시 확인해주세요";
                return RedirectToAction("List");
            }

            Search search = new Search();
            search.year = pmYear;
            search.mm = Monthly;
            // ExcelPmCashFlow
            List<PmCashFlowCumulativeExcel> excelCom = pmCashFlowCumulativeRepo.selectListExcel(search).ToList();

            // 2019.03.26 : 2019년도 이후에는 만도(BU) 이전에는 만도만 나오게 변경
            if (Convert.ToInt32(pmYear) < 2019)
            {
                excelCom = excelCom.Where(w => w.OrgCompanySeq != 14).ToList();
            }
            else
            {
                excelCom = excelCom.Where(w => w.OrgCompanySeq != 3).Where(w => w.OrgCompanySeq != 14).Where(w => w.OrgCompanySeq != 19).ToList();
            }
            dynamic model = new ExpandoObject();
            model.excelCom = excelCom;

            return View("~/Views/SiteMngHome/Performance/Group/ExcelPmCashFlow.cshtml", model);
        }

        [Route("EXCEL_PM_PAL")]
        public ActionResult EXCEL_PM_PAL(string pmYear, string Monthly, string TableName)
        {
            var chk = pmGroupRepo.selectListAll(new { }).ToList().Where(w => w.PmYear == pmYear).Where(w => w.Monthly == Monthly).Where(w => w.TableName == TableName).FirstOrDefault();

            if (chk == null || chk.RegistType == "N")
            {
                TempData["alert"] = "데이터가 취합되지 않았습니다. 회사별 최종승인 여부를 다시 확인해주세요";
                return RedirectToAction("List");
            }

            Search search = new Search();
            search.year = pmYear;
            search.mm = Monthly;
            // ExcelPmPal
            // Bu별 손익
            List<PmPalBusinessExp> pmThisYearBu = pmPalBusinessRepo.selectListPmThisYear(search).ToList();
            List<PmPalBusinessExp> pmLastYearBu = pmPalBusinessRepo.selectListPmLastYear(search).ToList();
            List<PmPalBusinessExp> pnThisYearBu = pmPalBusinessRepo.selectListPnThisYear(search).ToList();
            // 회사별 손익
            List<PmPalSummaryExp> pmThisYearCom = pmPalSummaryRepo.selectListPmThisYear(search).ToList();
            List<PmPalSummaryExp> pmLastYearCom = pmPalSummaryRepo.selectListPmLastYear(search).ToList();
            List<PmPalSummaryExp> pnThisYearCom = pmPalSummaryRepo.selectListPnThisYear(search).ToList();

            //- Bu
            // 전년도 연간 실적
            List<PmPalBusinessExp> pmLastYearBuSumYear = pmLastYearBu.Where(w => w.Monthly == "12").Where(w => w.MonthlyType == Define.MONTHLY_TYPE.GetKey("누계")).ToList();
            // 전년도 당월 누적
            List<PmPalBusinessExp> pmLastYearBuSumMonth = pmLastYearBu.Where(w => w.Monthly == search.mm).Where(w => w.MonthlyType == Define.MONTHLY_TYPE.GetKey("누계")).ToList();
            // 전년도 당월 실적
            List<PmPalBusinessExp> pmLastYearBuMonth = pmLastYearBu.Where(w => w.Monthly == search.mm).Where(w => w.MonthlyType == Define.MONTHLY_TYPE.GetKey("당월")).ToList();

            // 당해년도연간계획
            List<PmPalBusinessExp> pnThisYearBuSumYear = pnThisYearBu.GroupBy(g => new { g.PalYear, g.OrgUnionSeq, g.OrgCompanySeq, g.OrgBusinessSeq })
                .Select(cl => new PmPalBusinessExp
                {
                    PalYear = cl.First().PalYear,
                    OrgUnionSeq = cl.First().OrgUnionSeq,
                    UnionName = cl.First().UnionName,
                    OrgCompanySeq = cl.First().OrgCompanySeq,
                    CompanyName = cl.First().CompanyName,
                    OrgBusinessSeq = cl.First().OrgBusinessSeq,
                    BusinessName = cl.First().BusinessName,
                    Sales = cl.Sum(c => c.Sales),
                    Ebit = cl.Sum(c => c.Ebit),
                    Pbt = cl.Sum(c => c.Pbt)
                }).ToList();
            // 당해년도누적계획
            List<PmPalBusinessExp> pnThisYearBuSumMonth = pnThisYearBu
                .Where(w => Convert.ToInt32(w.Monthly) <= Convert.ToInt32(search.mm)).GroupBy(g => new { g.PalYear, g.OrgUnionSeq, g.OrgCompanySeq, g.OrgBusinessSeq })
                .Select(cl => new PmPalBusinessExp
                {
                    PalYear = cl.First().PalYear,
                    OrgUnionSeq = cl.First().OrgUnionSeq,
                    UnionName = cl.First().UnionName,
                    OrgCompanySeq = cl.First().OrgCompanySeq,
                    CompanyName = cl.First().CompanyName,
                    OrgBusinessSeq = cl.First().OrgBusinessSeq,
                    BusinessName = cl.First().BusinessName,
                    Sales = cl.Sum(c => c.Sales),
                    Ebit = cl.Sum(c => c.Ebit),
                    Pbt = cl.Sum(c => c.Pbt)
                }).ToList();
            // 당해년도당월계획
            List<PmPalBusinessExp> pnThisYearBuMonth = pnThisYearBu.Where(w => w.Monthly == search.mm).ToList();

            // 당해년도연간예상
            List<PmPalBusinessExp> pmThisYearBuSumYear = pmThisYearBu.Where(w => w.MonthlyType == Define.MONTHLY_TYPE.GetKey("연간")).ToList();
            // 당해년도누적실적
            List<PmPalBusinessExp> pmThisYearBuSumMonth = pmThisYearBu.Where(w => w.MonthlyType == Define.MONTHLY_TYPE.GetKey("누계")).ToList();
            // 당해년도당월실적
            List<PmPalBusinessExp> pmThisYearBuMonth = pmThisYearBu.Where(w => w.MonthlyType == Define.MONTHLY_TYPE.GetKey("당월")).ToList();
            //- Bu

            //--------------------------------------- 회사 시작
            // 전년도연간실적
            List<PmPalSummaryExp> pmLastYearComSumYear = pmLastYearCom.Where(w => w.Monthly == "12").Where(w => w.MonthlyType == Define.MONTHLY_TYPE.GetKey("누계")).ToList();
            // 전년도당월누적
            List<PmPalSummaryExp> pmLastYearComSumMonth = pmLastYearCom.Where(w => w.Monthly == search.mm).Where(w => w.MonthlyType == Define.MONTHLY_TYPE.GetKey("누계")).ToList();
            // 전년도당월실적
            List<PmPalSummaryExp> pmLastYearComMonth = pmLastYearCom.Where(w => w.Monthly == search.mm).Where(w => w.MonthlyType == Define.MONTHLY_TYPE.GetKey("당월")).ToList();

            // 당해년도연간계획
            List<PmPalSummaryExp> pnThisYearComSumYear = pnThisYearCom.Where(w => w.Monthly == "99").GroupBy(g => new { g.PalYear, g.OrgUnionSeq, g.OrgCompanySeq })
                .Select(cl => new PmPalSummaryExp
                {
                    PalYear = cl.First().PalYear,
                    OrgUnionSeq = cl.First().OrgUnionSeq,
                    UnionName = cl.First().UnionName,
                    OrgCompanySeq = cl.First().OrgCompanySeq,
                    CompanyName = cl.First().CompanyName,
                    Sales = cl.Sum(c => c.Sales),
                    Ebit = cl.Sum(c => c.Ebit),
                    Pbt = cl.Sum(c => c.Pbt)
                }).ToList();
            // 당해년도누적계획
            List<PmPalSummaryExp> pnThisYearComSumMonth = pnThisYearCom
                .Where(w => Convert.ToInt32(w.Monthly) <= Convert.ToInt32(search.mm)).GroupBy(g => new { g.PalYear, g.OrgUnionSeq, g.OrgCompanySeq })
                .Select(cl => new PmPalSummaryExp
                {
                    PalYear = cl.First().PalYear,
                    OrgUnionSeq = cl.First().OrgUnionSeq,
                    UnionName = cl.First().UnionName,
                    OrgCompanySeq = cl.First().OrgCompanySeq,
                    CompanyName = cl.First().CompanyName,
                    Sales = cl.Sum(c => c.Sales),
                    Ebit = cl.Sum(c => c.Ebit),
                    Pbt = cl.Sum(c => c.Pbt)
                }).ToList();
            // 당해년도당월계획
            List<PmPalSummaryExp> pnThisYearComMonth = pnThisYearCom.Where(w => w.Monthly == search.mm).ToList();

            // 당해년도연간예상
            List<PmPalSummaryExp> pmThisYearComSumYear = pmThisYearCom.Where(w => w.MonthlyType == Define.MONTHLY_TYPE.GetKey("연간")).ToList();
            // 당해년도누적실적
            List<PmPalSummaryExp> pmThisYearComSumMonth = pmThisYearCom.Where(w => w.MonthlyType == Define.MONTHLY_TYPE.GetKey("누계")).ToList();
            // 당해년도당월실적
            List<PmPalSummaryExp> pmThisYearComMonth = pmThisYearCom.Where(w => w.MonthlyType == Define.MONTHLY_TYPE.GetKey("당월")).ToList();
            //--------------------------------------- 회사 끝

            // 2019.03.26 : 2019년도 이후에는 만도(BU) 이전에는 만도만 나오게 변경
            if (Convert.ToInt32(pmYear) < 2019)
            {
                pmLastYearBuSumYear = pmLastYearBuSumYear.Where(w => w.OrgCompanySeq != 14).ToList();
                pmLastYearBuSumMonth = pmLastYearBuSumMonth.Where(w => w.OrgCompanySeq != 14).ToList();
                pmLastYearBuMonth = pmLastYearBuMonth.Where(w => w.OrgCompanySeq != 14).ToList();

                pnThisYearBuSumYear = pnThisYearBuSumYear.Where(w => w.OrgCompanySeq != 14).ToList();
                pnThisYearBuSumMonth = pnThisYearBuSumMonth.Where(w => w.OrgCompanySeq != 14).ToList();
                pnThisYearBuMonth = pnThisYearBuMonth.Where(w => w.OrgCompanySeq != 14).ToList();

                pmThisYearBuSumYear = pmThisYearBuSumYear.Where(w => w.OrgCompanySeq != 14).ToList();
                pmThisYearBuSumMonth = pmThisYearBuSumMonth.Where(w => w.OrgCompanySeq != 14).ToList();
                pmThisYearBuMonth = pmThisYearBuMonth.Where(w => w.OrgCompanySeq != 14).ToList();

                pmLastYearComSumYear = pmLastYearComSumYear.Where(w => w.OrgCompanySeq != 14).ToList();
                pmLastYearComSumMonth = pmLastYearComSumMonth.Where(w => w.OrgCompanySeq != 14).ToList();
                pmLastYearComMonth = pmLastYearComMonth.Where(w => w.OrgCompanySeq != 14).ToList();

                pnThisYearComSumYear = pnThisYearComSumYear.Where(w => w.OrgCompanySeq != 14).ToList();
                pnThisYearComSumMonth = pnThisYearComSumMonth.Where(w => w.OrgCompanySeq != 14).ToList();
                pnThisYearComMonth = pnThisYearComMonth.Where(w => w.OrgCompanySeq != 14).ToList();

                pmThisYearComSumYear = pmThisYearComSumYear.Where(w => w.OrgCompanySeq != 14).ToList();
                pmThisYearComSumMonth = pmThisYearComSumMonth.Where(w => w.OrgCompanySeq != 14).ToList();
                pmThisYearComMonth = pmThisYearComMonth.Where(w => w.OrgCompanySeq != 14).ToList();
            }
            else
            {
                pmLastYearBuSumYear = pmLastYearBuSumYear.Where(w => w.OrgCompanySeq != 3).ToList();
                pmLastYearBuSumMonth = pmLastYearBuSumMonth.Where(w => w.OrgCompanySeq != 3).ToList();
                pmLastYearBuMonth = pmLastYearBuMonth.Where(w => w.OrgCompanySeq != 3).ToList();

                pnThisYearBuSumYear = pnThisYearBuSumYear.Where(w => w.OrgCompanySeq != 3).Where(w => w.OrgCompanySeq != 14).Where(w => w.OrgCompanySeq != 19).ToList();
                pnThisYearBuSumMonth = pnThisYearBuSumMonth.Where(w => w.OrgCompanySeq != 3).Where(w => w.OrgCompanySeq != 14).Where(w => w.OrgCompanySeq != 19).ToList();
                pnThisYearBuMonth = pnThisYearBuMonth.Where(w => w.OrgCompanySeq != 3).Where(w => w.OrgCompanySeq != 14).Where(w => w.OrgCompanySeq != 19).ToList();

                pmThisYearBuSumYear = pmThisYearBuSumYear.Where(w => w.OrgCompanySeq != 3).Where(w => w.OrgCompanySeq != 14).Where(w => w.OrgCompanySeq != 19).ToList();
                pmThisYearBuSumMonth = pmThisYearBuSumMonth.Where(w => w.OrgCompanySeq != 3).Where(w => w.OrgCompanySeq != 14).Where(w => w.OrgCompanySeq != 19).ToList();
                pmThisYearBuMonth = pmThisYearBuMonth.Where(w => w.OrgCompanySeq != 3).Where(w => w.OrgCompanySeq != 14).Where(w => w.OrgCompanySeq != 19).ToList();

                pmLastYearComSumYear = pmLastYearComSumYear.Where(w => w.OrgCompanySeq != 3).ToList();
                pmLastYearComSumMonth = pmLastYearComSumMonth.Where(w => w.OrgCompanySeq != 3).ToList();
                pmLastYearComMonth = pmLastYearComMonth.Where(w => w.OrgCompanySeq != 3).ToList();

                pnThisYearComSumYear = pnThisYearComSumYear.Where(w => w.OrgCompanySeq != 3).Where(w => w.OrgCompanySeq != 14).Where(w => w.OrgCompanySeq != 19).ToList();
                pnThisYearComSumMonth = pnThisYearComSumMonth.Where(w => w.OrgCompanySeq != 3).Where(w => w.OrgCompanySeq != 14).Where(w => w.OrgCompanySeq != 19).ToList();
                pnThisYearComMonth = pnThisYearComMonth.Where(w => w.OrgCompanySeq != 3).Where(w => w.OrgCompanySeq != 14).Where(w => w.OrgCompanySeq != 19).ToList();

                pmThisYearComSumYear = pmThisYearComSumYear.Where(w => w.OrgCompanySeq != 3).Where(w => w.OrgCompanySeq != 14).Where(w => w.OrgCompanySeq != 19).ToList();
                pmThisYearComSumMonth = pmThisYearComSumMonth.Where(w => w.OrgCompanySeq != 3).Where(w => w.OrgCompanySeq != 14).Where(w => w.OrgCompanySeq != 19).ToList();
                pmThisYearComMonth = pmThisYearComMonth.Where(w => w.OrgCompanySeq != 3).Where(w => w.OrgCompanySeq != 14).Where(w => w.OrgCompanySeq != 19).ToList();
            }

            dynamic model = new ExpandoObject();
            model.pmLastYearBuSumYear = pmLastYearBuSumYear;
            model.pmLastYearBuSumMonth = pmLastYearBuSumMonth;
            model.pmLastYearBuMonth = pmLastYearBuMonth;

            model.pnThisYearBuSumYear = pnThisYearBuSumYear;
            model.pnThisYearBuSumMonth = pnThisYearBuSumMonth;
            model.pnThisYearBuMonth = pnThisYearBuMonth;

            model.pmThisYearBuSumYear = pmThisYearBuSumYear;
            model.pmThisYearBuSumMonth = pmThisYearBuSumMonth;
            model.pmThisYearBuMonth = pmThisYearBuMonth;

            model.pmLastYearComSumYear = pmLastYearComSumYear;
            model.pmLastYearComSumMonth = pmLastYearComSumMonth;
            model.pmLastYearComMonth = pmLastYearComMonth;

            model.pnThisYearComSumYear = pnThisYearComSumYear;
            model.pnThisYearComSumMonth = pnThisYearComSumMonth;
            model.pnThisYearComMonth = pnThisYearComMonth;

            model.pmThisYearComSumYear = pmThisYearComSumYear;
            model.pmThisYearComSumMonth = pmThisYearComSumMonth;
            model.pmThisYearComMonth = pmThisYearComMonth;
            ViewBag.Search = search;
            return View("~/Views/SiteMngHome/Performance/Group/ExcelPmPal.cshtml", model);
        }

        [Route("EXCEL_PM_QUARTER_PAL")]
        public ActionResult EXCEL_PM_QUARTER_PAL(string pmYear, string Monthly, string TableName)
        {
            var chk = pmGroupRepo.selectListAll(new { }).ToList().Where(w => w.PmYear == pmYear).Where(w => w.Monthly == Monthly).Where(w => w.TableName == TableName).FirstOrDefault();

            if (chk == null || chk.RegistType == "N")
            {
                TempData["alert"] = "데이터가 취합되지 않았습니다. 회사별 최종승인 여부를 다시 확인해주세요";
                return RedirectToAction("List");
            }

            Search search = new Search();
            search.year = pmYear;
            search.mm = Monthly;
            // ExcelPmQuarterPal

            // Bu별 분기손익
            List<PmQuarterPalBusinessExp> pmThisYearBuCom = pmQuarterPalBusinessRepo.selectListPmThisYear(search).ToList();
            List<PmQuarterPalBusinessExp> pmLastYearBuCom = pmQuarterPalBusinessRepo.selectListPmLastYear(search).ToList();
            List<PmQuarterPalBusinessExp> pnThisYearBuCom = pmQuarterPalBusinessRepo.selectListPnThisYear(search).ToList();
            // 회사별 분기손익
            List<PmQuarterPalBusinessSummaryExp> pmThisYearCom = pmQuarterPalBusinessSummaryRepo.selectListPmThisYear(search).ToList();
            List<PmQuarterPalBusinessSummaryExp> pmLastYearCom = pmQuarterPalBusinessSummaryRepo.selectListPmLastYear(search).ToList();
            List<PmQuarterPalBusinessSummaryExp> pnThisYearCom = pmQuarterPalBusinessSummaryRepo.selectListPnThisYear(search).ToList();

            //// 해당회사의 Bu
            //List<PmQuarterPalBusinessExp> pmThisYearBuCom = pmThisYearBu.Where(w => w.OrgCompanySeq == search.OrgCompanySeq).ToList();
            //List<PmQuarterPalBusinessExp> pmLastYearBuCom = pmLastYearBu.Where(w => w.OrgCompanySeq == search.OrgCompanySeq).ToList();
            //List<PmQuarterPalBusinessExp> pnThisYearBuCom = pnThisYearBu.Where(w => w.OrgCompanySeq == search.OrgCompanySeq).ToList();
            //// 해당회사의 회사
            //List<PmQuarterPalBusinessSummaryExp> pmThisYearCom = pmThisYear.Where(w => w.OrgCompanySeq == search.OrgCompanySeq).ToList();
            //List<PmQuarterPalBusinessSummaryExp> pmLastYearCom = pmLastYear.Where(w => w.OrgCompanySeq == search.OrgCompanySeq).ToList();
            //List<PmQuarterPalBusinessSummaryExp> pnThisYearCom = pnThisYear.Where(w => w.OrgCompanySeq == search.OrgCompanySeq).ToList();

            // 2019.03.26 : 2019년도 이후에는 만도(BU) 이전에는 만도만 나오게 변경
            if (Convert.ToInt32(pmYear) < 2019)
            {
                pmThisYearBuCom = pmThisYearBuCom.Where(w => w.OrgCompanySeq != 14).ToList();
                pmLastYearBuCom = pmLastYearBuCom.Where(w => w.OrgCompanySeq != 14).ToList();
                pnThisYearBuCom = pnThisYearBuCom.Where(w => w.OrgCompanySeq != 14).ToList();
                pmThisYearCom = pmThisYearCom.Where(w => w.OrgCompanySeq != 14).ToList();
                pmLastYearCom = pmLastYearCom.Where(w => w.OrgCompanySeq != 14).ToList();
                pnThisYearCom = pnThisYearCom.Where(w => w.OrgCompanySeq != 14).ToList();
            }
            else
            {
                pmThisYearBuCom = pmThisYearBuCom.Where(w => w.OrgCompanySeq != 3).Where(w => w.OrgCompanySeq != 14).Where(w => w.OrgCompanySeq != 19).ToList();
                pmLastYearBuCom = pmLastYearBuCom.Where(w => w.OrgCompanySeq != 3).ToList();
                pnThisYearBuCom = pnThisYearBuCom.Where(w => w.OrgCompanySeq != 3).Where(w => w.OrgCompanySeq != 14).Where(w => w.OrgCompanySeq != 19).ToList();
                pmThisYearCom = pmThisYearCom.Where(w => w.OrgCompanySeq != 3).Where(w => w.OrgCompanySeq != 14).Where(w => w.OrgCompanySeq != 19).ToList();
                pmLastYearCom = pmLastYearCom.Where(w => w.OrgCompanySeq != 3).ToList();
                pnThisYearCom = pnThisYearCom.Where(w => w.OrgCompanySeq != 3).Where(w => w.OrgCompanySeq != 14).Where(w => w.OrgCompanySeq != 19).ToList();
            }

            dynamic model = new ExpandoObject();
            model.pmThisYearBuCom = pmThisYearBuCom;
            model.pmLastYearBuCom = pmLastYearBuCom;
            model.pnThisYearBuCom = pnThisYearBuCom;
            model.pmThisYearCom = pmThisYearCom;
            model.pmLastYearCom = pmLastYearCom;
            model.pnThisYearCom = pnThisYearCom;

            return View("~/Views/SiteMngHome/Performance/Group/ExcelPmQuarterPal.cshtml", model);
        }

        [Route("EXCEL_PM_BS")]
        public ActionResult EXCEL_PM_BS(string pmYear, string Monthly, string TableName)
        {
            var chk = pmGroupRepo.selectListAll(new { }).ToList().Where(w => w.PmYear == pmYear).Where(w => w.Monthly == Monthly).Where(w => w.TableName == TableName).FirstOrDefault();

            if (chk == null || chk.RegistType == "N")
            {
                TempData["alert"] = "데이터가 취합되지 않았습니다. 회사별 최종승인 여부를 다시 확인해주세요";
                return RedirectToAction("List");
            }

            Search search = new Search();
            search.year = pmYear;
            search.mm = Monthly;
            List<PmBsSummaryExp> pmThisYearCom = pmBsSummaryRepo.selectListPmThisYear(search).ToList();
            List<PmBsSummaryExp> pmLastYearCom = pmBsSummaryRepo.selectListPmLastYear(search).ToList();
            List<PmBsSummaryExp> pnThisYearCom = pmBsSummaryRepo.selectListPnThisYear(search).ToList();
            // ExcelPmBs

            // 2019.03.26 : 2019년도 이후에는 만도(BU) 이전에는 만도만 나오게 변경
            if (Convert.ToInt32(pmYear) < 2019)
            {
                pmThisYearCom = pmThisYearCom.Where(w => w.OrgCompanySeq != 14).ToList();
                pmLastYearCom = pmLastYearCom.Where(w => w.OrgCompanySeq != 14).ToList();
                pnThisYearCom = pnThisYearCom.Where(w => w.OrgCompanySeq != 14).ToList();
            }
            else
            {
                pmThisYearCom = pmThisYearCom.Where(w => w.OrgCompanySeq != 3).Where(w => w.OrgCompanySeq != 14).Where(w => w.OrgCompanySeq != 19).ToList();
                pmLastYearCom = pmLastYearCom.Where(w => w.OrgCompanySeq != 3).ToList();
                pnThisYearCom = pnThisYearCom.Where(w => w.OrgCompanySeq != 3).Where(w => w.OrgCompanySeq != 14).Where(w => w.OrgCompanySeq != 19).ToList();
            }
            dynamic model = new ExpandoObject();
            model.pmThisYearCom = pmThisYearCom;
            model.pmLastYearCom = pmLastYearCom;
            model.pnThisYearCom = pnThisYearCom;
            
            return View("~/Views/SiteMngHome/Performance/Group/ExcelPmBs.cshtml", model);
        }

        [Route("EXCEL_PM_INVEST")]
        public ActionResult EXCEL_PM_INVEST(string pmYear, string Monthly, string TableName)
        {
            var chk = pmGroupRepo.selectListAll(new { }).ToList().Where(w => w.PmYear == pmYear).Where(w => w.Monthly == Monthly).Where(w => w.TableName == TableName).FirstOrDefault();

            if (chk == null || chk.RegistType == "N")
            {
                TempData["alert"] = "데이터가 취합되지 않았습니다. 회사별 최종승인 여부를 다시 확인해주세요";
                return RedirectToAction("List");
            }

            Search search = new Search();
            search.year = pmYear;
            search.mm = Monthly;

            // -------------- 기초데이터
            // 월 계획 Bu
            List<PlanMonthlyInvestBusinessExp> pnThisYearBu = planMonthlyInvestBusinessRepo.selectListPnThisYear(search).ToList();
            // 연간계획 Bu
            List<PlanYearInvestBusiness> pnThisYearBuYear = planYearInvestBusinessRepo.selectListThisYear(search).ToList();
            // 월 실적 Bu
            List<PmInvestBusiness> pmThisYearBu = pmInvestBusinessRepo.selectListPmThisYear(search).ToList();

            // 월 계획 Com
            List<PlanMonthlyInvestSummaryExp> pnThisYearCom = planMonthlyInvestSummaryRepo.selectListPnThisYear(search).ToList();
            // 연간계획 Com
            List<PlanYearInvestSummary> pnThisYearComYear = planYearInvestSummaryRepo.selectListPnThisYear(search).ToList();
            // 월 실적 Com
            List<PmInvestSum> pmThisYearCom = pmInvestSumRepo.selectListPmThisYear(search).ToList();

            search.year = (Convert.ToInt32( pmYear) - 1).ToString();
            // 전년 실적 Bu
            List<PmInvestBusiness> pmLastYearBu = pmInvestBusinessRepo.selectListPmThisYear(search).ToList();
            // 전년 실적 Com
            List<PmInvestSum> pmLastYearCom = pmInvestSumRepo.selectListPmThisYear(search).ToList();

            // ------------- 추가 계산
            // Bu - (실적)전년도 연간, 당월, 누계
            List<PmInvestBusiness> pmLastYearBuYear = pmLastYearBu.Where(w => w.MonthlyType == Define.MONTHLY_TYPE.GetKey("누계")).Where(w => w.Monthly == "12").ToList();
            List<PmInvestBusiness> pmLastYearBuMon = pmLastYearBu.Where(w => w.MonthlyType == Define.MONTHLY_TYPE.GetKey("당월")).Where(w => w.Monthly == Monthly).ToList();
            List<PmInvestBusiness> pmLastYearBuCum = pmLastYearBu.Where(w => w.MonthlyType == Define.MONTHLY_TYPE.GetKey("누계")).Where(w => w.Monthly == Monthly).ToList();
            // Com - (실적)전년도 연간, 당월, 누계
            List<PmInvestSum> pmLastYearComYear = pmLastYearCom.Where(w => w.MonthlyType == Define.MONTHLY_TYPE.GetKey("누계")).Where(w => w.Monthly == "12").ToList();
            List<PmInvestSum> pmLastYearComMon = pmLastYearCom.Where(w => w.MonthlyType == Define.MONTHLY_TYPE.GetKey("당월")).Where(w => w.Monthly == Monthly).ToList();
            List<PmInvestSum> pmLastYearComCum = pmLastYearCom.Where(w => w.MonthlyType == Define.MONTHLY_TYPE.GetKey("누계")).Where(w => w.Monthly == Monthly).ToList();

            // Bu - (계획)당해년도 연간, 당월, 누계
            pnThisYearBuYear = pnThisYearBuYear.Where(w => w.YearlyYear == pmYear).ToList();
            List<PlanMonthlyInvestBusinessExp> pnThisYearBuMon = pnThisYearBu.Where(w => w.Monthly == Monthly).ToList();
            // 2018.12.14 투자만 합계. 인원, 국내, 해외는 해당월
            List<PlanMonthlyInvestBusinessExp> pnThisYearBuCum = pnThisYearBu.Where(w => Convert.ToInt32(w.Monthly) <= Convert.ToInt32(Monthly)).OrderBy(o => o.Monthly)
                .GroupBy(g => new { g.MonthlyInvestYear, g.OrgUnionSeq, g.OrgCompanySeq, g.OrgBusinessSeq })
                .Select(cl => new PlanMonthlyInvestBusinessExp
                {
                    MonthlyInvestYear = cl.First().MonthlyInvestYear,
                    OrgUnionSeq = cl.First().OrgUnionSeq,
                    UnionName = cl.First().UnionName,
                    OrgCompanySeq = cl.First().OrgCompanySeq,
                    CompanyName = cl.First().CompanyName,
                    OrgBusinessSeq = cl.First().OrgBusinessSeq,
                    BusinessName = cl.First().BusinessName,
                    Investment = cl.Sum(c => c.Investment),
                    Personnel = cl.Last().Personnel,
                    DomesticPersonnel = cl.Last().DomesticPersonnel,
                    OverseasPersonnel = cl.Last().OverseasPersonnel
                    /*
                    Personnel = cl.Sum(c => c.Personnel),
                    DomesticPersonnel = cl.Sum(c => c.DomesticPersonnel),
                    OverseasPersonnel = cl.Sum(c => c.OverseasPersonnel)
                    */
                }).ToList();
            // Com - (계획)당해년도 연간, 당월, 누계
            pnThisYearComYear = pnThisYearComYear.Where(w => w.YearlyYear == pmYear).ToList();
            List<PlanMonthlyInvestSummaryExp> pnThisYearComMon = pnThisYearCom.Where(w => w.Monthly == Monthly).ToList();
            // 2018.12.14  투자만 합계. 인원, 국내, 해외는 해당월
            List<PlanMonthlyInvestSummaryExp> pnThisYearComCum = pnThisYearCom.Where(w => Convert.ToInt32(w.Monthly) <= Convert.ToInt32(Monthly)).OrderBy(o => o.Monthly)
                .GroupBy(g => new { g.MonthlyInvestYear, g.OrgUnionSeq, g.OrgCompanySeq })
                .Select(cl => new PlanMonthlyInvestSummaryExp
                {
                    MonthlyInvestYear = cl.First().MonthlyInvestYear,
                    OrgUnionSeq = cl.First().OrgUnionSeq,
                    UnionName = cl.First().UnionName,
                    OrgCompanySeq = cl.First().OrgCompanySeq,
                    CompanyName = cl.First().CompanyName,
                    Investment = cl.Sum(c => c.Investment),
                    Personnel = cl.Last().Personnel,
                    DomesticPersonnel = cl.Last().DomesticPersonnel,
                    OverseasPersonnel = cl.Last().OverseasPersonnel
                    /*
                    Personnel = cl.Sum(c => c.Personnel),
                    DomesticPersonnel = cl.Sum(c => c.DomesticPersonnel),
                    OverseasPersonnel = cl.Sum(c => c.OverseasPersonnel)
                    */
                }).ToList();

            // Bu - (실적)당해년도 당월, 누계
            List<PmInvestBusiness> pmThisYearBuMon = pmThisYearBu.Where(w => w.MonthlyType == Define.MONTHLY_TYPE.GetKey("당월")).Where(w => w.Monthly == Monthly).ToList();
            List<PmInvestBusiness> pmThisYearBuCum = pmThisYearBu.Where(w => w.MonthlyType == Define.MONTHLY_TYPE.GetKey("누계")).Where(w => w.Monthly == Monthly).ToList();
            // Com - (실적)당해년도 당월, 누계
            List<PmInvestSum> pmThisYearComMon = pmThisYearCom.Where(w => w.MonthlyType == Define.MONTHLY_TYPE.GetKey("당월")).Where(w => w.Monthly == Monthly).ToList();
            List<PmInvestSum> pmThisYearComCum = pmThisYearCom.Where(w => w.MonthlyType == Define.MONTHLY_TYPE.GetKey("누계")).Where(w => w.Monthly == Monthly).ToList();


            // 2019.03.26 : 2019년도 이후에는 만도(BU) 이전에는 만도만 나오게 변경
            if (Convert.ToInt32(pmYear) < 2019)
            {
                pmLastYearBuYear = pmLastYearBuYear.Where(w => w.OrgCompanySeq != 14).ToList();
                pmLastYearBuMon = pmLastYearBuMon.Where(w => w.OrgCompanySeq != 14).ToList();
                pmLastYearBuCum = pmLastYearBuCum.Where(w => w.OrgCompanySeq != 14).ToList();

                pmLastYearComYear = pmLastYearComYear.Where(w => w.OrgCompanySeq != 14).ToList();
                pmLastYearComMon = pmLastYearComMon.Where(w => w.OrgCompanySeq != 14).ToList();
                pmLastYearComCum = pmLastYearComCum.Where(w => w.OrgCompanySeq != 14).ToList();

                pnThisYearBuYear = pnThisYearBuYear.Where(w => w.OrgCompanySeq != 14).ToList();
                pnThisYearBuMon = pnThisYearBuMon.Where(w => w.OrgCompanySeq != 14).ToList();
                pnThisYearBuCum = pnThisYearBuCum.Where(w => w.OrgCompanySeq != 14).ToList();

                pnThisYearComYear = pnThisYearComYear.Where(w => w.OrgCompanySeq != 14).ToList();
                pnThisYearComMon = pnThisYearComMon.Where(w => w.OrgCompanySeq != 14).ToList();
                pnThisYearComCum = pnThisYearComCum.Where(w => w.OrgCompanySeq != 14).ToList();

                pmThisYearBuMon = pmThisYearBuMon.Where(w => w.OrgCompanySeq != 14).ToList();
                pmThisYearBuCum = pmThisYearBuCum.Where(w => w.OrgCompanySeq != 14).ToList();

                pmThisYearComMon = pmThisYearComMon.Where(w => w.OrgCompanySeq != 14).ToList();
                pmThisYearComCum = pmThisYearComCum.Where(w => w.OrgCompanySeq != 14).ToList();
            }
            else
            {
                pmLastYearBuYear = pmLastYearBuYear.Where(w => w.OrgCompanySeq != 3).ToList();
                pmLastYearBuMon = pmLastYearBuMon.Where(w => w.OrgCompanySeq != 3).ToList();
                pmLastYearBuCum = pmLastYearBuCum.Where(w => w.OrgCompanySeq != 3).ToList();

                pmLastYearComYear = pmLastYearComYear.Where(w => w.OrgCompanySeq != 3).ToList();
                pmLastYearComMon = pmLastYearComMon.Where(w => w.OrgCompanySeq != 3).ToList();
                pmLastYearComCum = pmLastYearComCum.Where(w => w.OrgCompanySeq != 3).ToList();

                pnThisYearBuYear = pnThisYearBuYear.Where(w => w.OrgCompanySeq != 3).Where(w => w.OrgCompanySeq != 14).Where(w => w.OrgCompanySeq != 19).ToList();
                pnThisYearBuMon = pnThisYearBuMon.Where(w => w.OrgCompanySeq != 3).Where(w => w.OrgCompanySeq != 14).Where(w => w.OrgCompanySeq != 19).ToList();
                pnThisYearBuCum = pnThisYearBuCum.Where(w => w.OrgCompanySeq != 3).Where(w => w.OrgCompanySeq != 14).Where(w => w.OrgCompanySeq != 19).ToList();

                pnThisYearComYear = pnThisYearComYear.Where(w => w.OrgCompanySeq != 3).Where(w => w.OrgCompanySeq != 14).Where(w => w.OrgCompanySeq != 19).ToList();
                pnThisYearComMon = pnThisYearComMon.Where(w => w.OrgCompanySeq != 3).Where(w => w.OrgCompanySeq != 14).Where(w => w.OrgCompanySeq != 19).ToList();
                pnThisYearComCum = pnThisYearComCum.Where(w => w.OrgCompanySeq != 3).Where(w => w.OrgCompanySeq != 14).Where(w => w.OrgCompanySeq != 19).ToList();

                pmThisYearBuMon = pmThisYearBuMon.Where(w => w.OrgCompanySeq != 3).Where(w => w.OrgCompanySeq != 14).Where(w => w.OrgCompanySeq != 19).ToList();
                pmThisYearBuCum = pmThisYearBuCum.Where(w => w.OrgCompanySeq != 3).Where(w => w.OrgCompanySeq != 14).Where(w => w.OrgCompanySeq != 19).ToList();

                pmThisYearComMon = pmThisYearComMon.Where(w => w.OrgCompanySeq != 3).Where(w => w.OrgCompanySeq != 14).Where(w => w.OrgCompanySeq != 19).ToList();
                pmThisYearComCum = pmThisYearComCum.Where(w => w.OrgCompanySeq != 3).Where(w => w.OrgCompanySeq != 14).Where(w => w.OrgCompanySeq != 19).ToList();
            }

            // ExcelPmInvest
            dynamic model = new ExpandoObject();
            model.pmLastYearBuYear = pmLastYearBuYear;
            model.pmLastYearBuMon = pmLastYearBuMon;
            model.pmLastYearBuCum = pmLastYearBuCum;

            model.pmLastYearComYear = pmLastYearComYear;
            model.pmLastYearComMon = pmLastYearComMon;
            model.pmLastYearComCum = pmLastYearComCum;

            model.pnThisYearBuYear = pnThisYearBuYear;
            model.pnThisYearBuMon = pnThisYearBuMon;
            model.pnThisYearBuCum = pnThisYearBuCum;

            model.pnThisYearComYear = pnThisYearComYear;
            model.pnThisYearComMon = pnThisYearComMon;
            model.pnThisYearComCum = pnThisYearComCum;

            model.pmThisYearBuMon = pmThisYearBuMon;
            model.pmThisYearBuCum = pmThisYearBuCum;

            model.pmThisYearComMon = pmThisYearComMon;
            model.pmThisYearComCum = pmThisYearComCum;

            return View("~/Views/SiteMngHome/Performance/Group/ExcelPmInvest.cshtml", model);
        }
    }
}