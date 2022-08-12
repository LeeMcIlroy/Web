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
    [AuthAdminFilter(RequestAuthLevel = 3)]
    [RoutePrefix("SiteMngHome/Plan/Group")]
    public class PlanGroupController : SiteMngBaseController
    {
        [Route("List")]
        public ActionResult List(Search search)
        {
            dynamic model = new ExpandoObject();
            model.list = planGroupRepo.selectList(search);
            ViewBag.Search = search;
            return View("~/Views/SiteMngHome/Plan/Group/List.cshtml", model);
        }

        [Route("EXCEL_PLAN_MONTHLY_PAL")]
        public ActionResult EXCEL_PLAN_MONTHLY_PAL(string PlanYear, string TableName)
        {
            var chk = planGroupRepo.selectListAll(new { }).ToList().Where(w => w.PlanYear == PlanYear).Where(w => w.TableName == TableName).FirstOrDefault();

            if (chk == null || chk.RegistType == "N")
            {
                TempData["alert"] = "데이터가 취합되지 않았습니다. 회사별 최종승인 여부를 다시 확인해주세요";
                return RedirectToAction("List");
            }

            Search search = new Search();
            search.year = PlanYear;
            List<PlanMonthlyPalBusinessExp> pnBu = planMonthlyPalBusinessRepo.selectListPnThisYear(search).ToList();
            List<PlanMonthlyPalBusinessMonthlySumExp> pnCom = planMonthlyPalBusinessMonthlySumRepo.selectListPnThisYear(search).ToList();

            // 2019년도 이후에는 만도(BU) 이전에는 만도만 나오게 변경
            if (Convert.ToInt32(PlanYear) < 2019)
            {
                pnBu = pnBu.Where(w => w.OrgCompanySeq != 14).ToList();
                pnCom = pnCom.Where(w => w.OrgCompanySeq != 14).ToList();
            }
            else
            {
                pnBu = pnBu.Where(w => w.OrgCompanySeq != 3).ToList();
                pnCom = pnCom.Where(w => w.OrgCompanySeq != 3).ToList();
            }
            dynamic model = new ExpandoObject();
            model.chk = chk;
            model.pnBu = pnBu;
            model.pnCom = pnCom;

            return View("~/Views/SiteMngHome/Plan/Group/ExcelPlanMonthlyPal.cshtml", model);
        }

        [Route("EXCEL_PLAN_YEAR_PAL")]
        public ActionResult EXCEL_PLAN_YEAR_PAL(string PlanYear, string TableName)
        {
            var chk = planGroupRepo.selectListAll(new { }).ToList().Where(w => w.PlanYear == PlanYear).Where(w => w.TableName == TableName).FirstOrDefault();

            if (chk == null || chk.RegistType == "N")
            {
                TempData["alert"] = "데이터가 취합되지 않았습니다. 회사별 최종승인 여부를 다시 확인해주세요";
                return RedirectToAction("List");
            }

            Search search = new Search();
            search.year = PlanYear;

            // 작년도 실적 
            List<PmPalBusinessExp> pmLastYearBu = pmPalBusinessRepo.selectListPmLastYear(search).ToList();
            List<PmPalSummaryExp> pmLastYearCom = pmPalSummaryRepo.selectListPmLastYear(search).ToList();
            // 당해년도 중기계획
            List<PlanYearPalBusinessExp> pnThisYearBu = planYearPalBusinessRepo.selectListPnThisYear(search).ToList();
            List<PlanYearPalBusinessSummaryExp> pnThisYearCom = planYearPalBusinessSummaryRepo.selectListPnThisYear(search).ToList();
            // 2019년도 이후에는 만도(BU) 이전에는 만도만 나오게 변경
            if (Convert.ToInt32(PlanYear) < 2019)
            {
                pnThisYearBu = pnThisYearBu.Where(w => w.OrgCompanySeq != 14).ToList();
                pnThisYearCom = pnThisYearCom.Where(w => w.OrgCompanySeq != 14).ToList();
            }
            else
            {
                pnThisYearBu = pnThisYearBu.Where(w => w.OrgCompanySeq != 3).ToList();
                pnThisYearCom = pnThisYearCom.Where(w => w.OrgCompanySeq != 3).ToList();
            }
            dynamic model = new ExpandoObject();
            model.chk = chk;
            model.pmLastYearBu = pmLastYearBu;
            model.pmLastYearCom = pmLastYearCom;
            model.pnThisYearBu = pnThisYearBu;
            model.pnThisYearCom = pnThisYearCom;

            return View("~/Views/SiteMngHome/Plan/Group/ExcelPlanYearPal.cshtml", model);
        }

        [Route("EXCEL_PLAN_YEAR_INVEST")]
        public ActionResult EXCEL_PLAN_YEAR_INVEST(string PlanYear, string TableName)
        {
            var chk = planGroupRepo.selectListAll(new { }).ToList().Where(w => w.PlanYear == PlanYear).Where(w => w.TableName == TableName).FirstOrDefault();

            if (chk == null || chk.RegistType == "N")
            {
                TempData["alert"] = "데이터가 취합되지 않았습니다. 회사별 최종승인 여부를 다시 확인해주세요";
                return RedirectToAction("List");
            }

            Search search = new Search();
            search.year = PlanYear;

            // 작년도 실적
            List<PmInvestBusiness> pmLastYearBu = pmInvestBusinessRepo.selectListPmLastYear(search).ToList();
            List<PmInvestSum> pmLastYearCom = pmInvestSumRepo.selectListPmLastYear(search).ToList();
            // 당해년도 계획
            List<PlanYearInvestBusiness> pnThisYearBu = planYearInvestBusinessRepo.selectListPnThisYear(search).ToList();
            List<PlanYearInvestSummary> pnThisYearCom = planYearInvestSummaryRepo.selectListPnThisYear(search).ToList();
            
            // 2019년도 이후에는 만도(BU) 이전에는 만도만 나오게 변경
            if (Convert.ToInt32(PlanYear) < 2019)
            {
                pnThisYearBu = pnThisYearBu.Where(w => w.OrgCompanySeq != 14).ToList();
                pnThisYearCom = pnThisYearCom.Where(w => w.OrgCompanySeq != 14).ToList();
            }
            else
            {
                pnThisYearBu = pnThisYearBu.Where(w => w.OrgCompanySeq != 3).ToList();
                pnThisYearCom = pnThisYearCom.Where(w => w.OrgCompanySeq != 3).ToList();
            }
            dynamic model = new ExpandoObject();
            model.chk = chk;
            model.pmLastYearBu = pmLastYearBu;
            model.pmLastYearCom = pmLastYearCom;
            model.pnThisYearBu = pnThisYearBu;
            model.pnThisYearCom = pnThisYearCom;

            return View("~/Views/SiteMngHome/Plan/Group/ExcelPlanYearInvest.cshtml", model);
        }

        [Route("EXCEL_PLAN_YEAR_BS")]
        public ActionResult EXCEL_PLAN_YEAR_BS(string PlanYear, string TableName)
        {
            var chk = planGroupRepo.selectListAll(new { }).ToList().Where(w => w.PlanYear == PlanYear).Where(w => w.TableName == TableName).FirstOrDefault();

            if (chk == null || chk.RegistType == "N")
            {
                TempData["alert"] = "데이터가 취합되지 않았습니다. 회사별 최종승인 여부를 다시 확인해주세요";
                return RedirectToAction("List");
            }

            Search search = new Search();
            search.year = PlanYear;
            search.mm = "12";

            var pm = pmBsSummaryRepo.selectListPmLastYear(search).ToList();
            var pn = planYearBsSummaryRepo.selectListPnThisYear(search).ToList();
            // 2019년도 이후에는 만도(BU) 이전에는 만도만 나오게 변경
            if (Convert.ToInt32(PlanYear) < 2019)
            {
                pm = pm.Where(w => w.OrgCompanySeq != 14).ToList();
                pn = pn.Where(w => w.OrgCompanySeq != 14).ToList();
            }
            else
            {
                pm = pm.Where(w => w.OrgCompanySeq != 3).ToList();
                pn = pn.Where(w => w.OrgCompanySeq != 3).ToList();
            }
            dynamic model = new ExpandoObject();
            model.chk = chk;
            model.pm = pm;
            model.pn = pn;

            return View("~/Views/SiteMngHome/Plan/Group/ExcelPlanYearBs.cshtml", model);
        }

        [Route("EXCEL_PLAN_YEAR_CF")]
        public ActionResult EXCEL_PLAN_YEAR_CF(string PlanYear, string TableName)
        {
            var chk = planGroupRepo.selectListAll(new { }).ToList().Where(w => w.PlanYear == PlanYear).Where(w => w.TableName == TableName).FirstOrDefault();

            if (chk == null || chk.RegistType == "N")
            {
                TempData["alert"] = "데이터가 취합되지 않았습니다. 회사별 최종승인 여부를 다시 확인해주세요";
                return RedirectToAction("List");
            }

            Search search = new Search();
            search.year = PlanYear;

            List<PmCashFlowCumulativeExp> pmLastYear = pmCashFlowCumulativeRepo.selectListpmLastYear(search).ToList();
            List<PlanYearCfSummaryExp> pnThisYear = planYearCfSummaryRepo.selectListpnThisYear(search).ToList();

            // 2019년도 이후에는 만도(BU) 이전에는 만도만 나오게 변경
            if (Convert.ToInt32(PlanYear) < 2019)
            {
                pnThisYear = pnThisYear.Where(w => w.OrgCompanySeq != 14).ToList();
            }
            else
            {
                pnThisYear = pnThisYear.Where(w => w.OrgCompanySeq != 3).ToList();
            }
            dynamic model = new ExpandoObject();
            model.chk = chk;
            model.pmLastYear = pmLastYear;
            model.pnThisYear = pnThisYear;

            return View("~/Views/SiteMngHome/Plan/Group/ExcelPlanYearCf.cshtml", model);
        }

        /// <summary>
        /// 계획 엑셀 다운로드 : 손익월별계획
        /// 양식변경중
        /// </summary>
        /// <param name="PlanYear"></param>
        /// <param name="TableName"></param>
        /// <returns></returns>
        [Route("DOWN_EXCEL_PLAN_MONTHLY_PAL")]
        public ActionResult DOWN_EXCEL_PLAN_MONTHLY_PAL(string PlanYear, string TableName)
        {
            var chk = planGroupRepo.selectListAll(new { }).ToList().Where(w => w.PlanYear == PlanYear).Where(w => w.TableName == TableName).FirstOrDefault();

            if (chk == null || chk.RegistType == "N")
            {
                TempData["alert"] = "데이터가 취합되지 않았습니다. 회사별 최종승인 여부를 다시 확인해주세요";
                return RedirectToAction("List");
            }

            List<PmPalBusinessExp> lastPmB = pmPalBusinessRepo.selectListPmLastYear(new { year = PlanYear }).ToList();
            List<PmPalBusinessExp> thisPnB = pmPalBusinessRepo.selectListPnThisYear(new { year = PlanYear }).ToList();
            List<PmPalSummaryExp> lastPmC = pmPalSummaryRepo.selectListPmLastYear(new { year = PlanYear }).ToList();
            List<PmPalSummaryExp> thisPnC = pmPalSummaryRepo.selectListPnThisYear(new { year = PlanYear }).ToList();

            // 2019년도 이후에는 만도(BU) 이전에는 만도만 나오게 변경
            if (Convert.ToInt32(PlanYear) < 2019)
            {
                thisPnB = thisPnB.Where(w => w.OrgCompanySeq != 14).ToList();
                thisPnC = thisPnC.Where(w => w.OrgCompanySeq != 14).ToList();
            }
            else
            {
                thisPnB = thisPnB.Where(w => w.OrgCompanySeq != 3).ToList();
                thisPnC = thisPnC.Where(w => w.OrgCompanySeq != 3).ToList();
            }
            dynamic model = new ExpandoObject();
            model.chk = chk;
            model.lastPmB = lastPmB;
            model.thisPnB = thisPnB;
            model.lastPmC = lastPmC;
            model.thisPnC = thisPnC;

            return View("~/Views/SiteMngHome/Plan/Group/DownExcelPlanMonthlyPal.cshtml", model);
        }

        /// <summary>
        /// 계획 엑셀 다운로드 : 손익중기계획
        /// 양식변경
        /// </summary>
        /// <param name="PlanYear"></param>
        /// <param name="TableName"></param>
        /// <returns></returns>
        [Route("DOWN_EXCEL_PLAN_YEAR_PAL")]
        public ActionResult DOWN_EXCEL_PLAN_YEAR_PAL(string PlanYear, string TableName)
        {
            var chk = planGroupRepo.selectListAll(new { }).ToList().Where(w => w.PlanYear == PlanYear).Where(w => w.TableName == TableName).FirstOrDefault();

            if (chk == null || chk.RegistType == "N")
            {
                TempData["alert"] = "데이터가 취합되지 않았습니다. 회사별 최종승인 여부를 다시 확인해주세요";
                return RedirectToAction("List");
            }

            List<PlanYearPalBusinessExp> lastPnB = planYearPalBusinessRepo.selectListPnThisYear(new { year = Convert.ToInt32(PlanYear) - 1 }).ToList();
            List<PmPalBusinessExp> lastPmB = pmPalBusinessRepo.selectListPmThisYear(new { year = (Convert.ToInt32(PlanYear) - 1), mm = "12" }).Where(w => w.MonthlyType == Define.MONTHLY_TYPE.GetKey("누계")).ToList();
            List<PlanYearPalBusinessExp> thisPnB = planYearPalBusinessRepo.selectListPnThisYear(new { year = PlanYear }).ToList();

            List<PlanYearPalBusinessSummaryExp> lastPnC = planYearPalBusinessSummaryRepo.selectListPnThisYear(new { Year = Convert.ToInt32(PlanYear) - 1 }).ToList();
            List<PmPalSummaryExp> lastPmC = pmPalSummaryRepo.selectListPmLastYear(new { year = PlanYear }).Where(w=> w.Monthly == "12" ).Where(w => w.MonthlyType == Define.MONTHLY_TYPE.GetKey("누계")).ToList();
            List<PlanYearPalBusinessSummaryExp> thisPnC = planYearPalBusinessSummaryRepo.selectListPnThisYear(new { Year = PlanYear }).ToList();


            // 2019년도 이후에는 만도(BU) 이전에는 만도만 나오게 변경
            if (Convert.ToInt32(PlanYear) < 2019)
            {
                thisPnB = thisPnB.Where(w => w.OrgCompanySeq != 14).ToList();
                thisPnC = thisPnC.Where(w => w.OrgCompanySeq != 14).ToList();
            }
            else
            {
                thisPnB = thisPnB.Where(w => w.OrgCompanySeq != 3).ToList();
                thisPnC = thisPnC.Where(w => w.OrgCompanySeq != 3).ToList();
            }
            dynamic model = new ExpandoObject();

            model.chk = chk;
            model.lastPnB = lastPnB;
            model.lastPmB = lastPmB;
            model.thisPnB = thisPnB;

            model.lastPnC = lastPnC;
            model.lastPmC = lastPmC;
            model.thisPnC = thisPnC;

            return View("~/Views/SiteMngHome/Plan/Group/DownExcelPlanYearPal.cshtml", model);
        }

        /// <summary>
        /// 계획 엑셀 다운로드 : 월별투자인원계획
        /// 양식신규추가
        /// </summary>
        /// <param name="PlanYear"></param>
        /// <param name="TableName"></param>
        /// <returns></returns>
        [Route("DOWN_EXCEL_PLAN_MONTHLY_INVEST")]
        public ActionResult DOWN_EXCEL_PLAN_MONTHLY_INVEST(string PlanYear, string TableName)
        {
            var chk = planGroupRepo.selectListAll(new { }).ToList().Where(w => w.PlanYear == PlanYear).Where(w => w.TableName == TableName).FirstOrDefault();

            if (chk == null || chk.RegistType == "N")
            {
                TempData["alert"] = "데이터가 취합되지 않았습니다. 회사별 최종승인 여부를 다시 확인해주세요";
                return RedirectToAction("List");
            }

            List<PlanMonthlyInvestBusinessExp> thisPnB = planMonthlyInvestBusinessRepo.selectListPnThisYear(new { year = PlanYear }).ToList();
            List<PlanMonthlyInvestSummaryExp> thisPnC = planMonthlyInvestSummaryRepo.selectListPnThisYear(new { year = PlanYear }).ToList();


            // 2019년도 이후에는 만도(BU) 이전에는 만도만 나오게 변경
            if (Convert.ToInt32(PlanYear) < 2019)
            {
                thisPnB = thisPnB.Where(w => w.OrgCompanySeq != 14).ToList();
                thisPnC = thisPnC.Where(w => w.OrgCompanySeq != 14).ToList();
            }
            else
            {
                thisPnB = thisPnB.Where(w => w.OrgCompanySeq != 3).Where(w => w.OrgCompanySeq != 14).Where(w => w.OrgCompanySeq != 19).Where(w => w.OrgCompanySeq != 4).ToList();
                thisPnC = thisPnC.Where(w => w.OrgCompanySeq != 3).Where(w => w.OrgCompanySeq != 14).Where(w => w.OrgCompanySeq != 19).Where(w => w.OrgCompanySeq != 4).ToList();
            }

            dynamic model = new ExpandoObject();
            model.chk = chk;

            model.thisPnB = thisPnB;
            model.thisPnC = thisPnC;

            return View("~/Views/SiteMngHome/Plan/Group/DownExcelPlanMonthlyInvest.cshtml", model);
        }

        [Route("DOWN_EXCEL_PLAN_YEAR_BS")]
        public ActionResult DOWN_EXCEL_PLAN_YEAR_BS(string PlanYear, string TableName)
        {
            var chk = planGroupRepo.selectListAll(new { }).ToList().Where(w => w.PlanYear == PlanYear).Where(w => w.TableName == TableName).FirstOrDefault();

            if (chk == null || chk.RegistType == "N")
            {
                TempData["alert"] = "데이터가 취합되지 않았습니다. 회사별 최종승인 여부를 다시 확인해주세요";
                return RedirectToAction("List");
            }

            List<PmBsSummaryExp> lastPmC = pmBsSummaryRepo.selectListPmLastYear(new { year = PlanYear }).ToList();
            List<PlanYearBsSummaryExp> thisPnC = planYearBsSummaryRepo.selectListPnThisYear(new { year = PlanYear }).ToList();


            // 2019년도 이후에는 만도(BU) 이전에는 만도만 나오게 변경
            if (Convert.ToInt32(PlanYear) < 2019)
            {
                thisPnC = thisPnC.Where(w => w.OrgCompanySeq != 14).ToList();
            }
            else
            {
                thisPnC = thisPnC.Where(w => w.OrgCompanySeq != 3).Where(w => w.OrgCompanySeq != 14).Where(w => w.OrgCompanySeq != 19).Where(w => w.OrgCompanySeq != 4).ToList();
            }
            lastPmC =lastPmC.Where(w => w.OrgCompanySeq != 14).Where(w => w.OrgCompanySeq != 19).Where(w => w.OrgCompanySeq != 4).ToList();
            dynamic model = new ExpandoObject();
            model.chk = chk;
            model.lastPmC = lastPmC;
            model.thisPnC = thisPnC;

            return View("~/Views/SiteMngHome/Plan/Group/DownExcelPlanYearBs.cshtml", model);
        }

        [Route("DOWN_EXCEL_PLAN_YEAR_CF")]
        public ActionResult DOWN_EXCEL_PLAN_YEAR_CF(string PlanYear, string TableName)
        {
            var chk = planGroupRepo.selectListAll(new { }).ToList().Where(w => w.PlanYear == PlanYear).Where(w => w.TableName == TableName).FirstOrDefault();

            if (chk == null || chk.RegistType == "N")
            {
                TempData["alert"] = "데이터가 취합되지 않았습니다. 회사별 최종승인 여부를 다시 확인해주세요";
                return RedirectToAction("List");
            }

            // 2019.02.07 관리자화면과 동일하게 데이터 가져오게 변경
            List<PmCashFlowCumulativeExp> lastPmC = pmCashFlowCumulativeRepo.selectListLastYearPn2(new { YearlyYear = PlanYear }).ToList();
            List<PmCashFlowCumulative> lastPmC2 = pmCashFlowCumulativeRepo.selectListLastYear2(new { Year = PlanYear }).ToList();

            //List<PmCashFlowCumulativeExp> lastPmC = pmCashFlowCumulativeRepo.selectListpmLastYear(new { year = PlanYear }).ToList();
            List<PlanYearCfSummaryExp> thisPnC = planYearCfSummaryRepo.selectListpnThisYear(new { year = PlanYear }).ToList();


            // 2019년도 이후에는 만도(BU) 이전에는 만도만 나오게 변경
            if (Convert.ToInt32(PlanYear) < 2019)
            {
                thisPnC = thisPnC.Where(w => w.OrgCompanySeq != 14).ToList();
            }
            else
            {
                thisPnC = thisPnC.Where(w => w.OrgCompanySeq != 3).Where(w => w.OrgCompanySeq != 14).Where(w => w.OrgCompanySeq != 19).Where(w => w.OrgCompanySeq != 4).ToList();
            }
            lastPmC = lastPmC.Where(w => w.OrgCompanySeq != 14).Where(w => w.OrgCompanySeq != 19).Where(w => w.OrgCompanySeq != 4).ToList();
            lastPmC2 = lastPmC2.Where(w => w.OrgCompanySeq != 14).Where(w => w.OrgCompanySeq != 19).Where(w => w.OrgCompanySeq != 4).ToList();


            dynamic model = new ExpandoObject();
            model.chk = chk;
            model.lastPmC = lastPmC;
            model.lastPmC2 = lastPmC2;
            model.thisPnC = thisPnC;
            return View("~/Views/SiteMngHome/Plan/Group/DownExcelPlanYearCf.cshtml", model);
        }

        [Route("DOWN_EXCEL_PLAN_YEAR_INVEST")]
        public ActionResult DOWN_EXCEL_PLAN_YEAR_INVEST(string PlanYear, string TableName)
        {
            var chk = planGroupRepo.selectListAll(new { }).ToList().Where(w => w.PlanYear == PlanYear).Where(w => w.TableName == TableName).FirstOrDefault();

            if (chk == null || chk.RegistType == "N")
            {
                TempData["alert"] = "데이터가 취합되지 않았습니다. 회사별 최종승인 여부를 다시 확인해주세요";
                return RedirectToAction("List");
            }

            // 작년도 실적 : 12월 누계만 가져온다.
            List<PmInvestBusiness> lastPmB = pmInvestBusinessRepo.selectListPmLastYear(new { year = PlanYear }).Where(w=>w.Monthly == "12").Where(w=>w.MonthlyType== Define.MONTHLY_TYPE.GetKey("누계")).ToList();
            List<PmInvestSum> lastPmC = pmInvestSumRepo.selectListPmLastYear(new { year = PlanYear }).Where(w => w.Monthly == "12").Where(w => w.MonthlyType == Define.MONTHLY_TYPE.GetKey("누계")).ToList();
            // 당해년도 계획
            List<PlanYearInvestBusiness> thisPnB = planYearInvestBusinessRepo.selectListPnThisYear(new { year = PlanYear }).ToList();
            List<PlanYearInvestSummary> thisPnC = planYearInvestSummaryRepo.selectListPnThisYear(new { year = PlanYear }).ToList();
            
            // 2019년도 이후에는 만도(BU) 이전에는 만도만 나오게 변경
            if (Convert.ToInt32(PlanYear) < 2019)
            {
                thisPnB = thisPnB.Where(w => w.OrgCompanySeq != 14).ToList();
                thisPnC = thisPnC.Where(w => w.OrgCompanySeq != 14).ToList();
            }
            else
            {
                thisPnB = thisPnB.Where(w => w.OrgCompanySeq != 3).Where(w => w.OrgCompanySeq != 14).Where(w => w.OrgCompanySeq != 19).Where(w => w.OrgCompanySeq != 4).ToList();
                thisPnC = thisPnC.Where(w => w.OrgCompanySeq != 3).Where(w => w.OrgCompanySeq != 14).Where(w => w.OrgCompanySeq != 19).Where(w => w.OrgCompanySeq != 4).ToList();
            }
            lastPmC = lastPmC.Where(w => w.OrgCompanySeq != 14).Where(w => w.OrgCompanySeq != 19).Where(w => w.OrgCompanySeq != 4).ToList();
            lastPmB = lastPmB.Where(w => w.OrgCompanySeq != 14).Where(w => w.OrgCompanySeq != 19).Where(w => w.OrgCompanySeq != 4).ToList();

            dynamic model = new ExpandoObject();
            model.chk = chk;
            model.lastPmB = lastPmB;
            model.thisPnB = thisPnB;
            model.lastPmC = lastPmC;
            model.thisPnC = thisPnC;


            return View("~/Views/SiteMngHome/Plan/Group/DownExcelPlanYearInvest.cshtml", model);
        }
    }
}