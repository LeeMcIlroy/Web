using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

using HALLA_PM.Models;
using HALLA_PM.Core;
using HALLA_PM.Util;
using System.Dynamic;
using System.IO;

namespace HALLA_PM.Controllers
{
    //[SystemLoginFilter]
    //[SystemAuthFilter(MenuAuth = 2)]
    [RoutePrefix("Performance")]
    public class PerformanceController : Controller
    {
        PageAuthRepo pAuthRepo = new PageAuthRepo();
        RegistYearListRepo rYearListRepo = new RegistYearListRepo();

        PmCashFlowCumulativeRepo pmCashFlowRepo = new PmCashFlowCumulativeRepo();
        PmBsSummaryRepo pmBsSummaryRepo = new PmBsSummaryRepo();
        PmBsSummaryExRepo pmBsSummaryExRepo = new PmBsSummaryExRepo();

        PmQuarterPalBusinessRepo pmQuarterPalBusinessRepo = new PmQuarterPalBusinessRepo();
        PmQuarterPalBusinessSummaryRepo pmQuarterPalBusinessSummaryRepo = new PmQuarterPalBusinessSummaryRepo();

        PmPalBusinessRepo pmPalBusinessRepo = new PmPalBusinessRepo();
        PmPalSummaryRepo pmPalSummaryRepo = new PmPalSummaryRepo();

        PlanMonthlyInvestBusinessRepo planMonthlyInvestBusinessRepo = new PlanMonthlyInvestBusinessRepo();
        PlanYearInvestBusinessRepo planYearInvestBusinessRepo = new PlanYearInvestBusinessRepo();
        PmInvestBusinessRepo pmInvestBusinessRepo = new PmInvestBusinessRepo();
        PlanMonthlyInvestSummaryRepo planMonthlyInvestSummaryRepo = new PlanMonthlyInvestSummaryRepo();
        PlanYearInvestSummaryRepo planYearInvestSummaryRepo = new PlanYearInvestSummaryRepo();
        PmInvestSumRepo pmInvestSumRepo = new PmInvestSumRepo();

        [Route("Index")]
        public ActionResult Index(Search search)
        {
            List<LevelTwo> lvCompany = pAuthRepo.GetSystemAuth(new { AuthUserKey = SessionManager.GetMemberSession().insaUserV.userKey }).ToList();
            List<RegistYearList> registYearPm = rYearListRepo.selectListPm(new { }).ToList();

            dynamic model = new ExpandoObject();
            model.lvCompany = lvCompany;
            model.registYearPm = registYearPm;
            ViewBag.search = search;
            return View("~/Views/Performance/Index.cshtml", model);
        }

        [Route("GroupDown")]
        public ActionResult GroupDown(Search search)
        {
            int bType = 0;

            if(search.DownExcelType == "CashFlow")
            {
                bType = Define.BUSINESS_PERFORMANCE_TYPE.GetKey("Cash Flow");
            }
            else if (search.DownExcelType == "Pal")
            {
                bType = Define.BUSINESS_PERFORMANCE_TYPE.GetKey("손익");
            }
            else if (search.DownExcelType == "QuarterPal")
            {
                bType = Define.BUSINESS_PERFORMANCE_TYPE.GetKey("분기별 손익");
            }
            else if (search.DownExcelType == "Bs")
            {
                bType = Define.BUSINESS_PERFORMANCE_TYPE.GetKey("BS");
            }
            else if (search.DownExcelType == "Invest")
            {
                bType = Define.BUSINESS_PERFORMANCE_TYPE.GetKey("투자·인원");
            }

            // 파일 여부 체크
            BusinessPerformanceRepo businessPerformanceRepo = new BusinessPerformanceRepo();
            BusinessPerformance bChk = businessPerformanceRepo.availableCheckInfo(new { year = search.year, month = search.mm, businessType = bType});

            if (bChk == null || bChk.isUse == "N")
            {
                TempData["alert"] = "데이터가 없습니다.";
                return RedirectToAction("Index");
            }
            else
            {
                FileInfoRepo f = new FileInfoRepo();
                var fileInfo = f.selectOne(new { attachTableName = "BUSINESS_PERFORMANCE", attachTableSeq = bChk.seq });

                if (fileInfo == null)
                {
                    TempData["alert"] = "파일이 없습니다.";
                    return RedirectToAction("Index");
                }
                else
                {
                    return File(Path.Combine(Define.FILE_PATH, fileInfo.filePath, fileInfo.fileStoredName), System.Net.Mime.MediaTypeNames.Application.Octet, fileInfo.fileOrgName);
                }
            }

            //return View();
        }

        public JsonResult GroupDownString(Search search)
        {
            int bType = 0;

            if (search.DownExcelType == "CashFlow")
            {
                bType = Define.BUSINESS_PERFORMANCE_TYPE.GetKey("Cash Flow");
            }
            else if (search.DownExcelType == "Pal")
            {
                bType = Define.BUSINESS_PERFORMANCE_TYPE.GetKey("손익");
            }
            else if (search.DownExcelType == "QuarterPal")
            {
                bType = Define.BUSINESS_PERFORMANCE_TYPE.GetKey("분기별 손익");
            }
            else if (search.DownExcelType == "Bs")
            {
                bType = Define.BUSINESS_PERFORMANCE_TYPE.GetKey("BS");
            }
            else if (search.DownExcelType == "Invest")
            {
                bType = Define.BUSINESS_PERFORMANCE_TYPE.GetKey("투자·인원");
            }

            // 파일 여부 체크
            BusinessPerformanceRepo businessPerformanceRepo = new BusinessPerformanceRepo();
            BusinessPerformance bChk = businessPerformanceRepo.availableCheckInfo(new { year = search.year, month = search.mm, businessType = bType });

            if (bChk == null || bChk.isUse == "N")
            {
                return Json(new { success = false, data = "데이터가 없습니다." });
            }
            else
            {
                FileInfoRepo f = new FileInfoRepo();
                var fileInfo = f.selectOne(new { attachTableName = "BUSINESS_PERFORMANCE", attachTableSeq = bChk.seq });

                if (fileInfo == null)
                {
                    return Json(new { success = false, data = "파일이 없습니다." });
                }
                else
                {
                    //return File(Path.Combine(Define.FILE_PATH, fileInfo.filePath, fileInfo.fileStoredName), System.Net.Mime.MediaTypeNames.Application.Octet, fileInfo.fileOrgName);
                    return Json(new { success = true, data = "/Files/" + fileInfo.filePath + "/" + fileInfo.fileStoredName });
                }
            }

            //return View();
        }


        [Route("ExcelDownCashFlow")]
        public ActionResult ExcelDownCashFlow(Search search)
        {
            // 그룹에서 사용시 해당년도 실적을 기준으로 전년도실적, 당해년도계획의 회사 리스트를 조인해줘야한다.

            List<PmCashFlowCumulativeExcel> excel = pmCashFlowRepo.selectListExcel(search).ToList();

            List<PmCashFlowCumulativeExcel> excelCom = excel.Where(w => w.OrgCompanySeq == search.OrgCompanySeq).ToList();
            dynamic model = new ExpandoObject();
            model.excelCom = excelCom;

            return View(model);
        }

        [Route("ExcelDownPal")]
        public ActionResult ExcelDownPal(Search search)
        {
            // 그룹에서 사용시 해당년도 실적을 기준으로 전년도실적, 당해년도계획의 회사 리스트를 조인해줘야한다.


            // Bu별 손익
            List<PmPalBusinessExp> pmThisYearBu = pmPalBusinessRepo.selectListPmThisYear(search).ToList();
            List<PmPalBusinessExp> pmLastYearBu = pmPalBusinessRepo.selectListPmLastYear(search).ToList();
            List<PmPalBusinessExp> pnThisYearBu = pmPalBusinessRepo.selectListPnThisYear(search).ToList();
            // 회사별 손익
            List<PmPalSummaryExp> pmThisYearCom = pmPalSummaryRepo.selectListPmThisYear(search).ToList();
            List<PmPalSummaryExp> pmLastYearCom = pmPalSummaryRepo.selectListPmLastYear(search).ToList();
            List<PmPalSummaryExp> pnThisYearCom = pmPalSummaryRepo.selectListPnThisYear(search).ToList();

            //--------------------------------------- Bu 시작
            // 전년도연간실적
            List<PmPalBusinessExp> pmLastYearBuSumYear = pmLastYearBu.Where(w => w.Monthly == "12").Where(w => w.MonthlyType == Define.MONTHLY_TYPE.GetKey("누계"))
                .Where(w => w.OrgCompanySeq == search.OrgCompanySeq).ToList();

            // 전년도당월누적
            List<PmPalBusinessExp> pmLastYearBuSumMonth = pmLastYearBu.Where(w => w.Monthly == search.mm).Where(w => w.MonthlyType == Define.MONTHLY_TYPE.GetKey("누계"))
                .Where(w => w.OrgCompanySeq == search.OrgCompanySeq).ToList();

            // 전년도당월실적
            List<PmPalBusinessExp> pmLastYearBuMonth = pmLastYearBu.Where(w => w.Monthly == search.mm).Where(w => w.MonthlyType == Define.MONTHLY_TYPE.GetKey("당월"))
                .Where(w => w.OrgCompanySeq == search.OrgCompanySeq).ToList();


            // 당해년도연간계획
            List<PmPalBusinessExp> pnThisYearBuSumYear = pnThisYearBu.Where(w => w.OrgCompanySeq == search.OrgCompanySeq).GroupBy(g => new { g.PalYear, g.OrgUnionSeq, g.OrgCompanySeq, g.OrgBusinessSeq })
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
            List<PmPalBusinessExp> pnThisYearBuSumMonth = pnThisYearBu.Where(w => w.OrgCompanySeq == search.OrgCompanySeq)
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
            List<PmPalBusinessExp> pnThisYearBuMonth = pnThisYearBu.Where(w => w.OrgCompanySeq == search.OrgCompanySeq).Where(w => w.Monthly == search.mm).ToList();


            // 당해년도연간예상
            List<PmPalBusinessExp> pmThisYearBuSumYear = pmThisYearBu.Where(w => w.OrgCompanySeq == search.OrgCompanySeq)
                .Where(w => w.MonthlyType == Define.MONTHLY_TYPE.GetKey("연간")).ToList();

            // 당해년도누적실적
            List<PmPalBusinessExp> pmThisYearBuSumMonth = pmThisYearBu.Where(w => w.OrgCompanySeq == search.OrgCompanySeq)
                .Where(w => w.MonthlyType == Define.MONTHLY_TYPE.GetKey("누계")).ToList();

            // 당해년도당월실적
            List<PmPalBusinessExp> pmThisYearBuMonth = pmThisYearBu.Where(w => w.OrgCompanySeq == search.OrgCompanySeq)
                .Where(w => w.MonthlyType == Define.MONTHLY_TYPE.GetKey("당월")).ToList();
            //--------------------------------------- Bu 끝

            //--------------------------------------- 회사 시작
            // 전년도연간실적
            List<PmPalSummaryExp> pmLastYearComSumYear = pmLastYearCom.Where(w => w.Monthly == "12").Where(w => w.MonthlyType == Define.MONTHLY_TYPE.GetKey("누계"))
                .Where(w => w.OrgCompanySeq == search.OrgCompanySeq).ToList();

            // 전년도당월누적
            List<PmPalSummaryExp> pmLastYearComSumMonth = pmLastYearCom.Where(w => w.Monthly == search.mm).Where(w => w.MonthlyType == Define.MONTHLY_TYPE.GetKey("누계"))
                .Where(w => w.OrgCompanySeq == search.OrgCompanySeq).ToList();

            // 전년도당월실적
            List<PmPalSummaryExp> pmLastYearComMonth = pmLastYearCom.Where(w => w.Monthly == search.mm).Where(w => w.MonthlyType == Define.MONTHLY_TYPE.GetKey("당월"))
                .Where(w => w.OrgCompanySeq == search.OrgCompanySeq).ToList();

            // 당해년도연간계획
            List<PmPalSummaryExp> pnThisYearComSumYear = pnThisYearCom.Where(w => w.OrgCompanySeq == search.OrgCompanySeq).Where(w=>w.Monthly == "99").GroupBy(g => new { g.PalYear, g.OrgUnionSeq, g.OrgCompanySeq })
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
            List<PmPalSummaryExp> pnThisYearComSumMonth = pnThisYearCom.Where(w => w.OrgCompanySeq == search.OrgCompanySeq)
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
            List<PmPalSummaryExp> pnThisYearComMonth = pnThisYearCom.Where(w => w.OrgCompanySeq == search.OrgCompanySeq).Where(w => w.Monthly == search.mm).ToList();


            // 당해년도연간예상
            List<PmPalSummaryExp> pmThisYearComSumYear = pmThisYearCom.Where(w => w.OrgCompanySeq == search.OrgCompanySeq)
                .Where(w => w.MonthlyType == Define.MONTHLY_TYPE.GetKey("연간")).ToList();

            // 당해년도누적실적
            List<PmPalSummaryExp> pmThisYearComSumMonth = pmThisYearCom.Where(w => w.OrgCompanySeq == search.OrgCompanySeq)
                .Where(w => w.MonthlyType == Define.MONTHLY_TYPE.GetKey("누계")).ToList();

            // 당해년도당월실적
            List<PmPalSummaryExp> pmThisYearComMonth = pmThisYearCom.Where(w => w.OrgCompanySeq == search.OrgCompanySeq)
                .Where(w => w.MonthlyType == Define.MONTHLY_TYPE.GetKey("당월")).ToList();


            //--------------------------------------- 회사 끝
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

            return View(model);
        }

        [Route("ExcelDownQuarterPal")]
        public ActionResult ExcelDownQuarterPal(Search search)
        {
            // 그룹에서 사용시 해당년도 실적을 기준으로 전년도실적, 당해년도계획의 회사 리스트를 조인해줘야한다.

            // Bu별 분기손익
            List<PmQuarterPalBusinessExp> pmThisYearBu = pmQuarterPalBusinessRepo.selectListPmThisYear(search).ToList();
            List<PmQuarterPalBusinessExp> pmLastYearBu = pmQuarterPalBusinessRepo.selectListPmLastYear(search).ToList();
            List<PmQuarterPalBusinessExp> pnThisYearBu = pmQuarterPalBusinessRepo.selectListPnThisYear(search).ToList();
            // 회사별 분기손익
            List<PmQuarterPalBusinessSummaryExp> pmThisYear = pmQuarterPalBusinessSummaryRepo.selectListPmThisYear(search).ToList();
            List<PmQuarterPalBusinessSummaryExp> pmLastYear = pmQuarterPalBusinessSummaryRepo.selectListPmLastYear(search).ToList();
            List<PmQuarterPalBusinessSummaryExp> pnThisYear = pmQuarterPalBusinessSummaryRepo.selectListPnThisYear(search).ToList();

            // 해당회사의 Bu
            List<PmQuarterPalBusinessExp> pmThisYearBuCom = pmThisYearBu.Where(w => w.OrgCompanySeq == search.OrgCompanySeq).ToList();
            List<PmQuarterPalBusinessExp> pmLastYearBuCom = pmLastYearBu.Where(w => w.OrgCompanySeq == search.OrgCompanySeq).ToList();
            List<PmQuarterPalBusinessExp> pnThisYearBuCom = pnThisYearBu.Where(w => w.OrgCompanySeq == search.OrgCompanySeq).ToList();
            // 해당회사의 회사
            List<PmQuarterPalBusinessSummaryExp> pmThisYearCom = pmThisYear.Where(w => w.OrgCompanySeq == search.OrgCompanySeq).ToList();
            List<PmQuarterPalBusinessSummaryExp> pmLastYearCom = pmLastYear.Where(w => w.OrgCompanySeq == search.OrgCompanySeq).ToList();
            List<PmQuarterPalBusinessSummaryExp> pnThisYearCom = pnThisYear.Where(w => w.OrgCompanySeq == search.OrgCompanySeq).ToList();

            dynamic model = new ExpandoObject();
            model.pmThisYearBuCom = pmThisYearBuCom;
            model.pmLastYearBuCom = pmLastYearBuCom;
            model.pnThisYearBuCom = pnThisYearBuCom;
            model.pmThisYearCom = pmThisYearCom;
            model.pmLastYearCom = pmLastYearCom;
            model.pnThisYearCom = pnThisYearCom;

            return View(model);
        }

        [Route("ExcelDownBs")]
        public ActionResult ExcelDownBs(Search search)
        {
            // --OrgCompanyRepo.selectListAdminAuth : 회사를 현재 사용하는 회사만 보여줘야 한다면 여기서 체크한다.
            List<PmBsSummaryExp> pmThisYear = pmBsSummaryRepo.selectListPmThisYear(search).ToList();
            List<PmBsSummaryExp> pmLastYear = pmBsSummaryRepo.selectListPmLastYear(search).ToList();
            List<PmBsSummaryExp> pnThisYear = pmBsSummaryRepo.selectListPnThisYear(search).ToList();

            List<PmBsSummaryExp> pmThisYearCom = pmThisYear.Where(w => w.OrgCompanySeq == search.OrgCompanySeq).ToList();
            List<PmBsSummaryExp> pmLastYearCom =pmLastYear.Where(w => w.OrgCompanySeq == search.OrgCompanySeq).ToList();
            List<PmBsSummaryExp> pnThisYearCom = pnThisYear.Where(w => w.OrgCompanySeq == search.OrgCompanySeq).ToList();

            List<PmBsSummaryEx> pmThisYearEx = pmBsSummaryExRepo.selectListPmThisYear(search).ToList();
            List<PmBsSummaryEx> pmLastYearEx = pmBsSummaryExRepo.selectListPmLastYear(search).ToList();
            List<PmBsSummaryEx> pnThisYearEx = pmBsSummaryExRepo.selectListPnThisYear(search).ToList();

            List<PmBsSummaryEx> pmThisYearComEx = pmThisYearEx.Where(w => w.OrgCompanySeq == search.OrgCompanySeq).ToList();
            List<PmBsSummaryEx> pmLastYearComEx = pmLastYearEx.Where(w => w.OrgCompanySeq == search.OrgCompanySeq).ToList();
            List<PmBsSummaryEx> pnThisYearComEx = pnThisYearEx.Where(w => w.OrgCompanySeq == search.OrgCompanySeq).ToList();

            dynamic model = new ExpandoObject();
            model.pmThisYearCom = pmThisYearCom;
            model.pmLastYearCom = pmLastYearCom;
            model.pnThisYearCom = pnThisYearCom;

            model.pmThisYearComEx = pmThisYearComEx;
            model.pmLastYearComEx = pmLastYearComEx;
            model.pnThisYearComEx = pnThisYearComEx;

            return View(model);
        }

        [Route("ExcelDownInvest")]
        public ActionResult ExcelDownInvest(Search search)
        {
            string pmYear = search.year;
            string Monthly = search.mm;

            // 월 계획 Bu
            List<PlanMonthlyInvestBusinessExp> pnThisYearBu = planMonthlyInvestBusinessRepo.selectListPnThisYear(search).Where(w => w.OrgCompanySeq == search.OrgCompanySeq).ToList();
            // 연간계획 Bu
            List<PlanYearInvestBusiness> pnThisYearBuYear = planYearInvestBusinessRepo.selectListThisYear(search).Where(w => w.OrgCompanySeq == search.OrgCompanySeq).ToList();
            // 월 실적 Bu
            List<PmInvestBusiness> pmThisYearBu = pmInvestBusinessRepo.selectListPmThisYear(search).Where(w => w.OrgCompanySeq == search.OrgCompanySeq).ToList();

            // 월 계획 Com
            List<PlanMonthlyInvestSummaryExp> pnThisYearCom = planMonthlyInvestSummaryRepo.selectListPnThisYear(search).Where(w => w.OrgCompanySeq == search.OrgCompanySeq).ToList();
            // 연간계획 Com
            List<PlanYearInvestSummary> pnThisYearComYear = planYearInvestSummaryRepo.selectListPnThisYear(search).Where(w => w.OrgCompanySeq == search.OrgCompanySeq).ToList();
            // 월 실적 Com
            List<PmInvestSum> pmThisYearCom = pmInvestSumRepo.selectListPmThisYear(search).Where(w => w.OrgCompanySeq == search.OrgCompanySeq).ToList();

            search.year = (Convert.ToInt32(pmYear) - 1).ToString();
            // 전년 실적 Bu
            List<PmInvestBusiness> pmLastYearBu = pmInvestBusinessRepo.selectListPmThisYear(search).Where(w => w.OrgCompanySeq == search.OrgCompanySeq).ToList();
            // 전년 실적 Com
            List<PmInvestSum> pmLastYearCom = pmInvestSumRepo.selectListPmThisYear(search).Where(w => w.OrgCompanySeq == search.OrgCompanySeq).ToList();

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
            List<PlanMonthlyInvestBusinessExp> pnThisYearBuCum = pnThisYearBu.Where(w => Convert.ToInt32(w.Monthly) <= Convert.ToInt32(Monthly))
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
                    Personnel = cl.Sum(c => c.Personnel),
                    DomesticPersonnel = cl.Sum(c => c.DomesticPersonnel),
                    OverseasPersonnel = cl.Sum(c => c.OverseasPersonnel)
                }).ToList();
            // Com - (계획)당해년도 연간, 당월, 누계
            pnThisYearComYear = pnThisYearComYear.Where(w => w.YearlyYear == pmYear).ToList();
            List<PlanMonthlyInvestSummaryExp> pnThisYearComMon = pnThisYearCom.Where(w => w.Monthly == Monthly).ToList();
            List<PlanMonthlyInvestSummaryExp> pnThisYearComCum = pnThisYearCom.Where(w => Convert.ToInt32(w.Monthly) <= Convert.ToInt32(Monthly))
                .GroupBy(g => new { g.MonthlyInvestYear, g.OrgUnionSeq, g.OrgCompanySeq })
                .Select(cl => new PlanMonthlyInvestSummaryExp
                {
                    MonthlyInvestYear = cl.First().MonthlyInvestYear,
                    OrgUnionSeq = cl.First().OrgUnionSeq,
                    UnionName = cl.First().UnionName,
                    OrgCompanySeq = cl.First().OrgCompanySeq,
                    CompanyName = cl.First().CompanyName,
                    Investment = cl.Sum(c => c.Investment),
                    Personnel = cl.Sum(c => c.Personnel),
                    DomesticPersonnel = cl.Sum(c => c.DomesticPersonnel),
                    OverseasPersonnel = cl.Sum(c => c.OverseasPersonnel)
                }).ToList();

            // Bu - (실적)당해년도 당월, 누계
            List<PmInvestBusiness> pmThisYearBuMon = pmThisYearBu.Where(w => w.MonthlyType == Define.MONTHLY_TYPE.GetKey("당월")).Where(w => w.Monthly == Monthly).ToList();
            List<PmInvestBusiness> pmThisYearBuCum = pmThisYearBu.Where(w => w.MonthlyType == Define.MONTHLY_TYPE.GetKey("누계")).Where(w => w.Monthly == Monthly).ToList();
            // Com - (실적)당해년도 당월, 누계
            List<PmInvestSum> pmThisYearComMon = pmThisYearCom.Where(w => w.MonthlyType == Define.MONTHLY_TYPE.GetKey("당월")).Where(w => w.Monthly == Monthly).ToList();
            List<PmInvestSum> pmThisYearComCum = pmThisYearCom.Where(w => w.MonthlyType == Define.MONTHLY_TYPE.GetKey("누계")).Where(w => w.Monthly == Monthly).ToList();

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

            return View(model);
        }

        [Route("ViewingCashFlow")]
        public ActionResult ViewingCashFlow(Search search)
        {
            List<PmCashFlowCumulativeExcel> excel = pmCashFlowRepo.selectListExcel(search).ToList();
            List<PmCashFlowCumulativeExcel> excelCom = excel.Where(w => w.OrgCompanySeq == search.OrgCompanySeq).ToList();
            dynamic model = new ExpandoObject();
            model.excelCom = excelCom;
            return View(model);
        }

        [Route("ViewingPal")]
        public ActionResult ViewingPal(Search search)
        {
            // Bu별 손익
            List<PmPalBusinessExp> pmThisYearBu = pmPalBusinessRepo.selectListPmThisYear(search).ToList();
            List<PmPalBusinessExp> pmLastYearBu = pmPalBusinessRepo.selectListPmLastYear(search).ToList();
            List<PmPalBusinessExp> pnThisYearBu = pmPalBusinessRepo.selectListPnThisYear(search).ToList();
            // 회사별 손익
            List<PmPalSummaryExp> pmThisYearCom = pmPalSummaryRepo.selectListPmThisYear(search).ToList();
            List<PmPalSummaryExp> pmLastYearCom = pmPalSummaryRepo.selectListPmLastYear(search).ToList();
            List<PmPalSummaryExp> pnThisYearCom = pmPalSummaryRepo.selectListPnThisYear(search).ToList();

            //--------------------------------------- Bu 시작
            // 전년도연간실적
            List<PmPalBusinessExp> pmLastYearBuSumYear = pmLastYearBu.Where(w => w.Monthly == "12").Where(w => w.MonthlyType == Define.MONTHLY_TYPE.GetKey("누계"))
                .Where(w => w.OrgCompanySeq == search.OrgCompanySeq).ToList();

            // 전년도당월누적
            List<PmPalBusinessExp> pmLastYearBuSumMonth = pmLastYearBu.Where(w => w.Monthly == search.mm).Where(w => w.MonthlyType == Define.MONTHLY_TYPE.GetKey("누계"))
                .Where(w => w.OrgCompanySeq == search.OrgCompanySeq).ToList();

            // 전년도당월실적
            List<PmPalBusinessExp> pmLastYearBuMonth = pmLastYearBu.Where(w => w.Monthly == search.mm).Where(w => w.MonthlyType == Define.MONTHLY_TYPE.GetKey("당월"))
                .Where(w => w.OrgCompanySeq == search.OrgCompanySeq).ToList();


            // 당해년도연간계획
            List<PmPalBusinessExp> pnThisYearBuSumYear = pnThisYearBu.Where(w => w.OrgCompanySeq == search.OrgCompanySeq).GroupBy(g => new { g.PalYear, g.OrgUnionSeq, g.OrgCompanySeq, g.OrgBusinessSeq })
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
            List<PmPalBusinessExp> pnThisYearBuSumMonth = pnThisYearBu.Where(w => w.OrgCompanySeq == search.OrgCompanySeq)
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
            List<PmPalBusinessExp> pnThisYearBuMonth = pnThisYearBu.Where(w => w.OrgCompanySeq == search.OrgCompanySeq).Where(w => w.Monthly == search.mm).ToList();


            // 당해년도연간예상
            List<PmPalBusinessExp> pmThisYearBuSumYear = pmThisYearBu.Where(w => w.OrgCompanySeq == search.OrgCompanySeq)
                .Where(w => w.MonthlyType == Define.MONTHLY_TYPE.GetKey("연간")).ToList();

            // 당해년도누적실적
            List<PmPalBusinessExp> pmThisYearBuSumMonth = pmThisYearBu.Where(w => w.OrgCompanySeq == search.OrgCompanySeq)
                .Where(w => w.MonthlyType == Define.MONTHLY_TYPE.GetKey("누계")).ToList();

            // 당해년도당월실적
            List<PmPalBusinessExp> pmThisYearBuMonth = pmThisYearBu.Where(w => w.OrgCompanySeq == search.OrgCompanySeq)
                .Where(w => w.MonthlyType == Define.MONTHLY_TYPE.GetKey("당월")).ToList();
            //--------------------------------------- Bu 끝

            //--------------------------------------- 회사 시작
            // 전년도연간실적
            List<PmPalSummaryExp> pmLastYearComSumYear = pmLastYearCom.Where(w => w.Monthly == "12").Where(w => w.MonthlyType == Define.MONTHLY_TYPE.GetKey("누계"))
                .Where(w => w.OrgCompanySeq == search.OrgCompanySeq).ToList();

            // 전년도당월누적
            List<PmPalSummaryExp> pmLastYearComSumMonth = pmLastYearCom.Where(w => w.Monthly == search.mm).Where(w => w.MonthlyType == Define.MONTHLY_TYPE.GetKey("누계"))
                .Where(w => w.OrgCompanySeq == search.OrgCompanySeq).ToList();

            // 전년도당월실적
            List<PmPalSummaryExp> pmLastYearComMonth = pmLastYearCom.Where(w => w.Monthly == search.mm).Where(w => w.MonthlyType == Define.MONTHLY_TYPE.GetKey("당월"))
                .Where(w => w.OrgCompanySeq == search.OrgCompanySeq).ToList();

            // 당해년도연간계획
            List<PmPalSummaryExp> pnThisYearComSumYear = pnThisYearCom.Where(w => w.OrgCompanySeq == search.OrgCompanySeq).Where(w => w.Monthly == "99").GroupBy(g => new { g.PalYear, g.OrgUnionSeq, g.OrgCompanySeq })
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
            List<PmPalSummaryExp> pnThisYearComSumMonth = pnThisYearCom.Where(w => w.OrgCompanySeq == search.OrgCompanySeq)
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
            List<PmPalSummaryExp> pnThisYearComMonth = pnThisYearCom.Where(w => w.OrgCompanySeq == search.OrgCompanySeq).Where(w => w.Monthly == search.mm).ToList();


            // 당해년도연간예상
            List<PmPalSummaryExp> pmThisYearComSumYear = pmThisYearCom.Where(w => w.OrgCompanySeq == search.OrgCompanySeq)
                .Where(w => w.MonthlyType == Define.MONTHLY_TYPE.GetKey("연간")).ToList();

            // 당해년도누적실적
            List<PmPalSummaryExp> pmThisYearComSumMonth = pmThisYearCom.Where(w => w.OrgCompanySeq == search.OrgCompanySeq)
                .Where(w => w.MonthlyType == Define.MONTHLY_TYPE.GetKey("누계")).ToList();

            // 당해년도당월실적
            List<PmPalSummaryExp> pmThisYearComMonth = pmThisYearCom.Where(w => w.OrgCompanySeq == search.OrgCompanySeq)
                .Where(w => w.MonthlyType == Define.MONTHLY_TYPE.GetKey("당월")).ToList();


            //--------------------------------------- 회사 끝
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
            return View(model);
        }

        [Route("ViewingQuarterPal")]
        public ActionResult ViewingQuarterPal(Search search)
        {
            // Bu별 분기손익
            List<PmQuarterPalBusinessExp> pmThisYearBu = pmQuarterPalBusinessRepo.selectListPmThisYear(search).ToList();
            List<PmQuarterPalBusinessExp> pmLastYearBu = pmQuarterPalBusinessRepo.selectListPmLastYear(search).ToList();
            List<PmQuarterPalBusinessExp> pnThisYearBu = pmQuarterPalBusinessRepo.selectListPnThisYear(search).ToList();
            // 회사별 분기손익
            List<PmQuarterPalBusinessSummaryExp> pmThisYear = pmQuarterPalBusinessSummaryRepo.selectListPmThisYear(search).ToList();
            List<PmQuarterPalBusinessSummaryExp> pmLastYear = pmQuarterPalBusinessSummaryRepo.selectListPmLastYear(search).ToList();
            List<PmQuarterPalBusinessSummaryExp> pnThisYear = pmQuarterPalBusinessSummaryRepo.selectListPnThisYear(search).ToList();

            // 해당회사의 Bu
            List<PmQuarterPalBusinessExp> pmThisYearBuCom = pmThisYearBu.Where(w => w.OrgCompanySeq == search.OrgCompanySeq).ToList();
            List<PmQuarterPalBusinessExp> pmLastYearBuCom = pmLastYearBu.Where(w => w.OrgCompanySeq == search.OrgCompanySeq).ToList();
            List<PmQuarterPalBusinessExp> pnThisYearBuCom = pnThisYearBu.Where(w => w.OrgCompanySeq == search.OrgCompanySeq).ToList();
            // 해당회사의 회사
            List<PmQuarterPalBusinessSummaryExp> pmThisYearCom = pmThisYear.Where(w => w.OrgCompanySeq == search.OrgCompanySeq).ToList();
            List<PmQuarterPalBusinessSummaryExp> pmLastYearCom = pmLastYear.Where(w => w.OrgCompanySeq == search.OrgCompanySeq).ToList();
            List<PmQuarterPalBusinessSummaryExp> pnThisYearCom = pnThisYear.Where(w => w.OrgCompanySeq == search.OrgCompanySeq).ToList();

            dynamic model = new ExpandoObject();
            model.pmThisYearBuCom = pmThisYearBuCom;
            model.pmLastYearBuCom = pmLastYearBuCom;
            model.pnThisYearBuCom = pnThisYearBuCom;
            model.pmThisYearCom = pmThisYearCom;
            model.pmLastYearCom = pmLastYearCom;
            model.pnThisYearCom = pnThisYearCom;
            return View(model);
        }

        [Route("ViewingBs")]
        public ActionResult ViewingBs(Search search)
        {
            // --OrgCompanyRepo.selectListAdminAuth : 회사를 현재 사용하는 회사만 보여줘야 한다면 여기서 체크한다.
            List<PmBsSummaryExp> pmThisYear = pmBsSummaryRepo.selectListPmThisYear(search).ToList();
            List<PmBsSummaryExp> pmLastYear = pmBsSummaryRepo.selectListPmLastYear(search).ToList();
            List<PmBsSummaryExp> pnThisYear = pmBsSummaryRepo.selectListPnThisYear(search).ToList();

            List<PmBsSummaryExp> pmThisYearCom = pmThisYear.Where(w => w.OrgCompanySeq == search.OrgCompanySeq).ToList();
            List<PmBsSummaryExp> pmLastYearCom = pmLastYear.Where(w => w.OrgCompanySeq == search.OrgCompanySeq).ToList();
            List<PmBsSummaryExp> pnThisYearCom = pnThisYear.Where(w => w.OrgCompanySeq == search.OrgCompanySeq).ToList();

            List<PmBsSummaryEx> pmThisYearEx = pmBsSummaryExRepo.selectListPmThisYear(search).ToList();
            List<PmBsSummaryEx> pmLastYearEx = pmBsSummaryExRepo.selectListPmLastYear(search).ToList();
            List<PmBsSummaryEx> pnThisYearEx = pmBsSummaryExRepo.selectListPnThisYear(search).ToList();

            List<PmBsSummaryEx> pmThisYearComEx = pmThisYearEx.Where(w => w.OrgCompanySeq == search.OrgCompanySeq).ToList();
            List<PmBsSummaryEx> pmLastYearComEx = pmLastYearEx.Where(w => w.OrgCompanySeq == search.OrgCompanySeq).ToList();
            List<PmBsSummaryEx> pnThisYearComEx = pnThisYearEx.Where(w => w.OrgCompanySeq == search.OrgCompanySeq).ToList();

            dynamic model = new ExpandoObject();
            model.pmThisYearCom = pmThisYearCom;
            model.pmLastYearCom = pmLastYearCom;
            model.pnThisYearCom = pnThisYearCom;

            model.pmThisYearComEx = pmThisYearComEx;
            model.pmLastYearComEx = pmLastYearComEx;
            model.pnThisYearComEx = pnThisYearComEx;
            return View(model);
        }

        [Route("ViewingInvest")]
        public ActionResult ViewingInvest(Search search)
        {
            string pmYear = search.year;
            string Monthly = search.mm;

            // 월 계획 Bu
            List<PlanMonthlyInvestBusinessExp> pnThisYearBu = planMonthlyInvestBusinessRepo.selectListPnThisYear(search).Where(w => w.OrgCompanySeq == search.OrgCompanySeq).ToList();
            // 연간계획 Bu
            List<PlanYearInvestBusiness> pnThisYearBuYear = planYearInvestBusinessRepo.selectListThisYear(search).Where(w => w.OrgCompanySeq == search.OrgCompanySeq).ToList();
            // 월 실적 Bu
            List<PmInvestBusiness> pmThisYearBu = pmInvestBusinessRepo.selectListPmThisYear(search).Where(w => w.OrgCompanySeq == search.OrgCompanySeq).ToList();

            // 월 계획 Com
            List<PlanMonthlyInvestSummaryExp> pnThisYearCom = planMonthlyInvestSummaryRepo.selectListPnThisYear(search).Where(w => w.OrgCompanySeq == search.OrgCompanySeq).ToList();
            // 연간계획 Com
            List<PlanYearInvestSummary> pnThisYearComYear = planYearInvestSummaryRepo.selectListPnThisYear(search).Where(w => w.OrgCompanySeq == search.OrgCompanySeq).ToList();
            // 월 실적 Com
            List<PmInvestSum> pmThisYearCom = pmInvestSumRepo.selectListPmThisYear(search).Where(w => w.OrgCompanySeq == search.OrgCompanySeq).ToList();

            search.year = (Convert.ToInt32(pmYear) - 1).ToString();
            // 전년 실적 Bu
            List<PmInvestBusiness> pmLastYearBu = pmInvestBusinessRepo.selectListPmThisYear(search).Where(w => w.OrgCompanySeq == search.OrgCompanySeq).ToList();
            // 전년 실적 Com
            List<PmInvestSum> pmLastYearCom = pmInvestSumRepo.selectListPmThisYear(search).Where(w => w.OrgCompanySeq == search.OrgCompanySeq).ToList();

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
            List<PlanMonthlyInvestBusinessExp> pnThisYearBuCum = pnThisYearBu.Where(w => Convert.ToInt32(w.Monthly) <= Convert.ToInt32(Monthly))
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
                    Personnel = cl.Sum(c => c.Personnel),
                    DomesticPersonnel = cl.Sum(c => c.DomesticPersonnel),
                    OverseasPersonnel = cl.Sum(c => c.OverseasPersonnel)
                }).ToList();
            // Com - (계획)당해년도 연간, 당월, 누계
            pnThisYearComYear = pnThisYearComYear.Where(w => w.YearlyYear == pmYear).ToList();
            List<PlanMonthlyInvestSummaryExp> pnThisYearComMon = pnThisYearCom.Where(w => w.Monthly == Monthly).ToList();
            List<PlanMonthlyInvestSummaryExp> pnThisYearComCum = pnThisYearCom.Where(w => Convert.ToInt32(w.Monthly) <= Convert.ToInt32(Monthly))
                .GroupBy(g => new { g.MonthlyInvestYear, g.OrgUnionSeq, g.OrgCompanySeq })
                .Select(cl => new PlanMonthlyInvestSummaryExp
                {
                    MonthlyInvestYear = cl.First().MonthlyInvestYear,
                    OrgUnionSeq = cl.First().OrgUnionSeq,
                    UnionName = cl.First().UnionName,
                    OrgCompanySeq = cl.First().OrgCompanySeq,
                    CompanyName = cl.First().CompanyName,
                    Investment = cl.Sum(c => c.Investment),
                    Personnel = cl.Sum(c => c.Personnel),
                    DomesticPersonnel = cl.Sum(c => c.DomesticPersonnel),
                    OverseasPersonnel = cl.Sum(c => c.OverseasPersonnel)
                }).ToList();

            // Bu - (실적)당해년도 당월, 누계
            List<PmInvestBusiness> pmThisYearBuMon = pmThisYearBu.Where(w => w.MonthlyType == Define.MONTHLY_TYPE.GetKey("당월")).Where(w => w.Monthly == Monthly).ToList();
            List<PmInvestBusiness> pmThisYearBuCum = pmThisYearBu.Where(w => w.MonthlyType == Define.MONTHLY_TYPE.GetKey("누계")).Where(w => w.Monthly == Monthly).ToList();
            // Com - (실적)당해년도 당월, 누계
            List<PmInvestSum> pmThisYearComMon = pmThisYearCom.Where(w => w.MonthlyType == Define.MONTHLY_TYPE.GetKey("당월")).Where(w => w.Monthly == Monthly).ToList();
            List<PmInvestSum> pmThisYearComCum = pmThisYearCom.Where(w => w.MonthlyType == Define.MONTHLY_TYPE.GetKey("누계")).Where(w => w.Monthly == Monthly).ToList();

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
            return View(model);
        }
    }
}