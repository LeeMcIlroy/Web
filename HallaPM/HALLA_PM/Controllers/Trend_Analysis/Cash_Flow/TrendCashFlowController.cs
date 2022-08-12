using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

using HALLA_PM.Models;
using HALLA_PM.Core;

namespace HALLA_PM.Controllers
{
    [RoutePrefix("Trend_Analysis/Cash_Flow")]
    public class TrendCashFlowController : Controller
    {
        PageAuthRepo pageAuthRepo = new PageAuthRepo();
        TrendCashFlowRepo tCashFlowRepo = new TrendCashFlowRepo();
        MemberSession mSession = SessionManager.GetMemberSession();

        [SystemLoginFilter]
        [SystemAuthFilter(MenuAuth = 3)]
        [Route("Index")]
        public ActionResult Index()
        {
            return View("~/Views/Trend_Analysis/Cash_Flow/Index.cshtml");
        }

        [Route("CashFlowLevel")]
        public ActionResult CashFlowLevel()
        {
            string AuthUserKey = mSession.insaUserV.userKey;

            LevelOne lv1 = new LevelOne();
            LevelTwo lv2 = new LevelTwo();
            LevelThree lv3 = new LevelThree();
            LevelFour lv4 = new LevelFour();

            int nYear = DateTime.Now.Year;
            lv1.period = new Period();
            lv1.period.year = new int[2] { 2016, nYear };
            lv1.period.quater = new int[2] { 2018, nYear };
            lv1.period.month_period = new int[2] { 2018, nYear };
            lv1.period.month_select = new int[2] { 2018, nYear };

            lv1.level = new List<LevelTwo>();
            var lvGroup = pageAuthRepo.GetGroupAuth(new { AuthUserKey = AuthUserKey }).ToList();
            if (lvGroup.Count() > 0)
            {
                lv2.id = lvGroup.First().id;
                lv2.txt = lvGroup.First().txt;
                lv1.level.Add(lv2);
            }

            var lvUnion = pageAuthRepo.GetUnionAuth(new { AuthUserKey = AuthUserKey }).ToList();

            if (lvUnion.Count() > 0)
            {
                lv2 = new LevelTwo();
                lv2.sub = new List<LevelThree>();

                lv2.id = "1";
                lv2.txt = "부문";
                lv1.level.Add(lv2);
                foreach (var item in lvUnion)
                {
                    lv3 = new LevelThree();
                    lv3.id = item.id;
                    lv3.txt = item.txt;
                    lv2.sub.Add(lv3);
                }
            }

            var lvCompany = pageAuthRepo.GetCompanyAuth(new { AuthUserKey = AuthUserKey }).ToList();

            if (lvCompany.Count() > 0)
            {
                lv2 = new LevelTwo();
                lv2.sub = new List<LevelThree>();

                lv2.id = "2";
                lv2.txt = "회사";
                lv1.level.Add(lv2);
                foreach (var item in lvCompany)
                {
                    lv3 = new LevelThree();
                    lv3.id = item.id;
                    lv3.txt = item.txt;
                    lv2.sub.Add(lv3);
                }
            }

            /*
            var lvBusiness = pageAuthRepo.GetBusinessAuth(new { AuthUserKey = AuthUserKey }).ToList();

            if (lvBusiness.Count() > 0)
            {
                lv2 = new LevelTwo();
                lv2.sub = new List<LevelThree>();
                lv2.id = "3";
                lv2.txt = "Business Unit";
                lv1.level.Add(lv2);
                foreach (var item in lvCompany)
                {
                    lv3 = new LevelThree();
                    lv3.sub = new List<LevelFour>();

                    lv3.id = item.id;
                    lv3.txt = item.txt;
                    lv2.sub.Add(lv3);

                    foreach (var item2 in lvBusiness.Where(w => w.UpId == item.id))
                    {
                        lv4 = new LevelFour();
                        lv4.id = item2.id;
                        lv4.txt = item2.txt;
                        lv3.sub.Add(lv4);
                    }
                }
            }
            */

            return Json(lv1, JsonRequestBehavior.AllowGet);
        }
        
        [Route("CashFlowData")]
        public ActionResult CashFlowData(TrendSearch search)
        {
            // 년도확인용
            /*
            search.level0 = "2";
            search.level1 = "1";
            search.level2 = "none";
            search.yearType = "year";
            search.year_y_from = "2008";
            search.year_y_to = "2018";
            */

            /*
            // 분기확인용
            search.level0 = Define.LEVEL.GetKey("그룹");
            search.level1 = "1";
            search.level2 = "none";
            search.yearType = Define.YEAR_TYPE.GetKey("분기");
            search.quater_y_from = "2016";
            search.quater_y_to = "2018";
            List<string> qt = new List<string>();
            qt.Add("1");
            qt.Add("2");
            search.quater = qt;
            */

            List<TrendCashFlow> CashFlowYear = tCashFlowRepo.GetCashFlowYear(new { }).ToList();
            List<TrendCashFlow> CashFlowMonth = tCashFlowRepo.GetCashFlowMonth(new { }).ToList();

            // 그래프 데이터
            var data1 = new List<KeyValues>();
            // 그래프 데이터 리스트
            List<Values> salesList = new List<Values>();
            List<Values> investList = new List<Values>();
            List<Values> finanicialList = new List<Values>();
            List<Values> fcfList = new List<Values>();
            List<Values> netcfList = new List<Values>();

            var data3 = new List<TrendDataTable>();

            // 그래프 데이터
            var data6 = new List<KeyValues>();
            List<Values> endingList = new List<Values>();
            List<Values> availList = new List<Values>();

            List<TrendCashFlow> CashFlowList = new List<TrendCashFlow>();
            // 년도별, 월별
            if (search.yearType == Define.YEAR_TYPE.GetKey("년도"))
            {
                CashFlowList = new List<TrendCashFlow>();

                if (search.level0 == Define.LEVEL.GetKey("그룹"))
                {
                    //CashFlowList = CashFlowYear.Where(w => Convert.ToInt32(w.CashFlowYear) >= Convert.ToInt32(search.year_y_from)
                    //    && Convert.ToInt32(w.CashFlowYear) <= Convert.ToInt32(search.year_y_to))
                    //    .GroupBy(g => g.CashFlowYear)
                    //    .Select(cl => new TrendCashFlow
                    //    {
                    //        CashFlowYear = cl.First().CashFlowYear,
                    //        Ebitda = cl.Sum(c => c.Ebitda),
                    //        WcSum = cl.Sum(c => c.WcSum),
                    //        Etc = cl.Sum(c => c.Etc),
                    //        NetCapexSum = cl.Sum(c => c.NetCapexSum),
                    //        FinancialCostSum = cl.Sum(c => c.FinancialCostSum),
                    //        Fcf2 = cl.Sum(c => c.Fcf2),
                    //        FinancialSum = cl.Sum(c => c.FinancialSum),
                    //        CashSum = cl.Sum(c => c.CashSum),
                    //        EndingCash = cl.Sum(c => c.EndingCash),
                    //        CreditLine = cl.Sum(c => c.CreditLine),
                    //        AvailableCash = cl.Sum(c => c.AvailableCash),
                    //        Allocation = cl.Sum(c => c.Allocation),
                    //        Increase = cl.Sum(c => c.Increase),
                    //        Borrowing = cl.Sum(c => c.Borrowing),
                    //        Repayment = cl.Sum(c => c.Repayment),
                    //        FinancialEtc = cl.Sum(c => c.FinancialEtc)
                    //    })
                    //    .OrderBy(o => o.CashFlowYear)
                    //    .ToList();
                    CashFlowList = tCashFlowRepo.GetCashFlowYear_NEW(new { PREYEAR = search.year_y_from, ENDYEAR = search.year_y_to }).ToList();
                }
                else if (search.level0 == Define.LEVEL.GetKey("부문"))
                {
                    CashFlowList = CashFlowYear.Where(w => w.OrgUnionSeq == Convert.ToInt32(search.level1))
                        .Where(w => Convert.ToInt32(w.CashFlowYear) >= Convert.ToInt32(search.year_y_from)
                        && Convert.ToInt32(w.CashFlowYear) <= Convert.ToInt32(search.year_y_to))
                        .GroupBy(g => g.CashFlowYear)
                        .Select(cl => new TrendCashFlow
                        {
                            CashFlowYear = cl.First().CashFlowYear,
                            Ebitda = cl.Sum(c => c.Ebitda),
                            WcSum = cl.Sum(c => c.WcSum),
                            Etc = cl.Sum(c => c.Etc),
                            NetCapexSum = cl.Sum(c => c.NetCapexSum),
                            FinancialCostSum = cl.Sum(c => c.FinancialCostSum),
                            Fcf2 = cl.Sum(c => c.Fcf2),
                            FinancialSum = cl.Sum(c => c.FinancialSum),
                            CashSum = cl.Sum(c => c.CashSum),
                            EndingCash = cl.Sum(c => c.EndingCash),
                            CreditLine = cl.Sum(c => c.CreditLine),
                            AvailableCash = cl.Sum(c => c.AvailableCash),
                            Allocation = cl.Sum(c => c.Allocation),
                            Increase = cl.Sum(c => c.Increase),
                            Borrowing = cl.Sum(c => c.Borrowing),
                            Repayment = cl.Sum(c => c.Repayment),
                            FinancialEtc = cl.Sum(c => c.FinancialEtc)
                        })
                        .OrderBy(o => o.CashFlowYear)
                        .ToList();
                }
                else if (search.level0 == Define.LEVEL.GetKey("회사"))
                {
                    CashFlowList = CashFlowYear.Where(w => w.OrgCompanySeq == Convert.ToInt32(search.level1))
                        .Where(w => Convert.ToInt32(w.CashFlowYear) >= Convert.ToInt32(search.year_y_from)
                        && Convert.ToInt32(w.CashFlowYear) <= Convert.ToInt32(search.year_y_to))
                        .GroupBy(g => g.CashFlowYear)
                        .Select(cl => new TrendCashFlow
                        {
                            CashFlowYear = cl.First().CashFlowYear,
                            Ebitda = cl.Sum(c => c.Ebitda),
                            WcSum = cl.Sum(c => c.WcSum),
                            Etc = cl.Sum(c => c.Etc),
                            NetCapexSum = cl.Sum(c => c.NetCapexSum),
                            FinancialCostSum = cl.Sum(c => c.FinancialCostSum),
                            Fcf2 = cl.Sum(c => c.Fcf2),
                            FinancialSum = cl.Sum(c => c.FinancialSum),
                            CashSum = cl.Sum(c => c.CashSum),
                            EndingCash = cl.Sum(c => c.EndingCash),
                            CreditLine = cl.Sum(c => c.CreditLine),
                            AvailableCash = cl.Sum(c => c.AvailableCash),
                            Allocation = cl.Sum(c => c.Allocation),
                            Increase = cl.Sum(c => c.Increase),
                            Borrowing = cl.Sum(c => c.Borrowing),
                            Repayment = cl.Sum(c => c.Repayment),
                            FinancialEtc = cl.Sum(c => c.FinancialEtc)
                        })
                        .OrderBy(o => o.CashFlowYear)
                        .ToList();
                }
            }
            else if (search.yearType == Define.YEAR_TYPE.GetKey("분기"))
            {
                CashFlowList = new List<TrendCashFlow>();

                if (search.level0 == Define.LEVEL.GetKey("그룹"))
                {
                    //CashFlowList = CashFlowMonth.Where(w => Convert.ToInt32(w.CashFlowYear) >= Convert.ToInt32(search.quater_y_from)
                    //    && Convert.ToInt32(w.CashFlowYear) <= Convert.ToInt32(search.quater_y_to))
                    //    .Where(w => search.quater.Contains(w.Qt.ToString()))
                    //    .GroupBy(g => new { g.CashFlowYear, g.Qt })
                    //    .Select(cl => new TrendCashFlow
                    //    {
                    //        CashFlowYear = cl.First().CashFlowYear,
                    //        Qt = cl.First().Qt,
                    //        Ebitda = cl.Sum(c => c.Ebitda),
                    //        WcSum = cl.Sum(c => c.WcSum),
                    //        Etc = cl.Sum(c => c.Etc),
                    //        NetCapexSum = cl.Sum(c => c.NetCapexSum),
                    //        FinancialCostSum = cl.Sum(c => c.FinancialCostSum),
                    //        Fcf2 = cl.Sum(c => c.Fcf2),
                    //        FinancialSum = cl.Sum(c => c.FinancialSum),
                    //        CashSum = cl.Sum(c => c.CashSum),
                    //        EndingCash = cl.Sum(c => c.EndingCash),
                    //        CreditLine = cl.Sum(c => c.CreditLine),
                    //        AvailableCash = cl.Sum(c => c.AvailableCash),
                    //        Allocation = cl.Sum(c => c.Allocation),
                    //        Increase = cl.Sum(c => c.Increase),
                    //        Borrowing = cl.Sum(c => c.Borrowing),
                    //        Repayment = cl.Sum(c => c.Repayment),
                    //        FinancialEtc = cl.Sum(c => c.FinancialEtc)
                    //    })
                    //    .OrderBy(o => o.CashFlowYear)
                    //    .ThenBy(o => o.Qt)
                    //    .ToList();
                    string result = String.Join(",", search.quater.ToArray());               
                CashFlowList = tCashFlowRepo.GetCashFlowMonth_NEW(new { PREYEAR = search.quater_y_from
                                                                        , ENDYEAR = search.quater_y_to
                                                                        , quater = result
                                                                            }, result).ToList();
            }
                else if (search.level0 == Define.LEVEL.GetKey("부문"))
                {
                    CashFlowList = CashFlowMonth.Where(w => w.OrgUnionSeq == Convert.ToInt32(search.level1))
                        .Where(w => Convert.ToInt32(w.CashFlowYear) >= Convert.ToInt32(search.quater_y_from)
                        && Convert.ToInt32(w.CashFlowYear) <= Convert.ToInt32(search.quater_y_to))
                        .Where(w => search.quater.Contains(w.Qt.ToString()))
                        .GroupBy(g => new { g.CashFlowYear, g.Qt })
                        .Select(cl => new TrendCashFlow
                        {
                            CashFlowYear = cl.First().CashFlowYear,
                            Qt = cl.First().Qt,
                            Ebitda = cl.Sum(c => c.Ebitda),
                            WcSum = cl.Sum(c => c.WcSum),
                            Etc = cl.Sum(c => c.Etc),
                            NetCapexSum = cl.Sum(c => c.NetCapexSum),
                            FinancialCostSum = cl.Sum(c => c.FinancialCostSum),
                            Fcf2 = cl.Sum(c => c.Fcf2),
                            FinancialSum = cl.Sum(c => c.FinancialSum),
                            CashSum = cl.Sum(c => c.CashSum),
                            EndingCash = cl.Sum(c => c.EndingCash),
                            CreditLine = cl.Sum(c => c.CreditLine),
                            AvailableCash = cl.Sum(c => c.AvailableCash),
                            Allocation = cl.Sum(c => c.Allocation),
                            Increase = cl.Sum(c => c.Increase),
                            Borrowing = cl.Sum(c => c.Borrowing),
                            Repayment = cl.Sum(c => c.Repayment),
                            FinancialEtc = cl.Sum(c => c.FinancialEtc)
                        })
                        .OrderBy(o => o.CashFlowYear)
                        .ThenBy(o => o.Qt)
                        .ToList();
                }
                else if (search.level0 == Define.LEVEL.GetKey("회사"))
                {
                    CashFlowList = CashFlowMonth.Where(w => w.OrgCompanySeq == Convert.ToInt32(search.level1))
                        .Where(w => Convert.ToInt32(w.CashFlowYear) >= Convert.ToInt32(search.quater_y_from)
                        && Convert.ToInt32(w.CashFlowYear) <= Convert.ToInt32(search.quater_y_to))
                        .Where(w => search.quater.Contains(w.Qt.ToString()))
                        .GroupBy(g => new { g.CashFlowYear, g.Qt })
                        .Select(cl => new TrendCashFlow
                        {
                            CashFlowYear = cl.First().CashFlowYear,
                            Qt = cl.First().Qt,
                            Ebitda = cl.Sum(c => c.Ebitda),
                            WcSum = cl.Sum(c => c.WcSum),
                            Etc = cl.Sum(c => c.Etc),
                            NetCapexSum = cl.Sum(c => c.NetCapexSum),
                            FinancialCostSum = cl.Sum(c => c.FinancialCostSum),
                            Fcf2 = cl.Sum(c => c.Fcf2),
                            FinancialSum = cl.Sum(c => c.FinancialSum),
                            CashSum = cl.Sum(c => c.CashSum),
                            EndingCash = cl.Sum(c => c.EndingCash),
                            CreditLine = cl.Sum(c => c.CreditLine),
                            AvailableCash = cl.Sum(c => c.AvailableCash),
                            Allocation = cl.Sum(c => c.Allocation),
                            Increase = cl.Sum(c => c.Increase),
                            Borrowing = cl.Sum(c => c.Borrowing),
                            Repayment = cl.Sum(c => c.Repayment),
                            FinancialEtc = cl.Sum(c => c.FinancialEtc)
                        })
                        .OrderBy(o => o.CashFlowYear)
                        .ThenBy(o => o.Qt)
                        .ToList();
                }
            }
            else if (search.yearType == Define.YEAR_TYPE.GetKey("월(기간)"))
            {
                CashFlowList = new List<TrendCashFlow>();

                if (search.level0 == Define.LEVEL.GetKey("그룹"))
                {
                    //CashFlowList = CashFlowMonth
                    //    .Where(w => Convert.ToInt32(w.CashFlowYear + w.Monthly) >= Convert.ToInt32(search.month_period_y_from + search.month_period_m_from))
                    //    .Where(w => Convert.ToInt32(w.CashFlowYear + w.Monthly) <= Convert.ToInt32(search.month_period_y_to + search.month_period_m_to))
                    //    .GroupBy(g => g.CashFlowYear + g.Monthly)
                    //    .Select(cl => new TrendCashFlow
                    //    {
                    //        CashFlowYear = cl.First().CashFlowYear,
                    //        Monthly = cl.First().Monthly,
                    //        Ebitda = cl.Sum(c => c.Ebitda),
                    //        WcSum = cl.Sum(c => c.WcSum),
                    //        Etc = cl.Sum(c => c.Etc),
                    //        NetCapexSum = cl.Sum(c => c.NetCapexSum),
                    //        FinancialCostSum = cl.Sum(c => c.FinancialCostSum),
                    //        Fcf2 = cl.Sum(c => c.Fcf2),
                    //        FinancialSum = cl.Sum(c => c.FinancialSum),
                    //        CashSum = cl.Sum(c => c.CashSum),
                    //        EndingCash = cl.Sum(c => c.EndingCash),
                    //        CreditLine = cl.Sum(c => c.CreditLine),
                    //        AvailableCash = cl.Sum(c => c.AvailableCash),
                    //        Allocation = cl.Sum(c => c.Allocation),
                    //        Increase = cl.Sum(c => c.Increase),
                    //        Borrowing = cl.Sum(c => c.Borrowing),
                    //        Repayment = cl.Sum(c => c.Repayment),
                    //        FinancialEtc = cl.Sum(c => c.FinancialEtc)
                    //    })
                    //    .OrderBy(o => o.CashFlowYear + o.Monthly)
                    //    .ToList();

                     CashFlowList = tCashFlowRepo.GetCashFlowMonth_NEW_Month(new { PREYEAR = search.month_period_y_from + search.month_period_m_from
                                                                                    ,ENDYEAR = search.month_period_y_to + search.month_period_m_to } ).ToList();
                }
                else if (search.level0 == Define.LEVEL.GetKey("부문"))
                {
                    CashFlowList = CashFlowMonth.Where(w => w.OrgUnionSeq == Convert.ToInt32(search.level1))
                        .Where(w => Convert.ToInt32(w.CashFlowYear + w.Monthly) >= Convert.ToInt32(search.month_period_y_from + search.month_period_m_from))
                        .Where(w => Convert.ToInt32(w.CashFlowYear + w.Monthly) <= Convert.ToInt32(search.month_period_y_to + search.month_period_m_to))
                        .GroupBy(g => g.CashFlowYear + g.Monthly)
                        .Select(cl => new TrendCashFlow
                        {
                            CashFlowYear = cl.First().CashFlowYear,
                            Monthly = cl.First().Monthly,
                            Ebitda = cl.Sum(c => c.Ebitda),
                            WcSum = cl.Sum(c => c.WcSum),
                            Etc = cl.Sum(c => c.Etc),
                            NetCapexSum = cl.Sum(c => c.NetCapexSum),
                            FinancialCostSum = cl.Sum(c => c.FinancialCostSum),
                            Fcf2 = cl.Sum(c => c.Fcf2),
                            FinancialSum = cl.Sum(c => c.FinancialSum),
                            CashSum = cl.Sum(c => c.CashSum),
                            EndingCash = cl.Sum(c => c.EndingCash),
                            CreditLine = cl.Sum(c => c.CreditLine),
                            AvailableCash = cl.Sum(c => c.AvailableCash),
                            Allocation = cl.Sum(c => c.Allocation),
                            Increase = cl.Sum(c => c.Increase),
                            Borrowing = cl.Sum(c => c.Borrowing),
                            Repayment = cl.Sum(c => c.Repayment),
                            FinancialEtc = cl.Sum(c => c.FinancialEtc)
                        })
                        .OrderBy(o => o.CashFlowYear + o.Monthly)
                        .ToList();
                }
                else if (search.level0 == Define.LEVEL.GetKey("회사"))
                {
                    CashFlowList = CashFlowMonth.Where(w => w.OrgCompanySeq == Convert.ToInt32(search.level1))
                        .Where(w => Convert.ToInt32(w.CashFlowYear + w.Monthly) >= Convert.ToInt32(search.month_period_y_from + search.month_period_m_from))
                        .Where(w => Convert.ToInt32(w.CashFlowYear + w.Monthly) <= Convert.ToInt32(search.month_period_y_to + search.month_period_m_to))
                        .OrderBy(o => o.CashFlowYear + o.Monthly)
                        .ToList();
                }
            }
            else if (search.yearType == Define.YEAR_TYPE.GetKey("월(선택)"))
            {
                CashFlowList = new List<TrendCashFlow>();

                if (search.level0 == Define.LEVEL.GetKey("그룹"))
                {
                    //CashFlowList = CashFlowMonth
                    //    .Where(w => Convert.ToInt32(w.CashFlowYear) >= Convert.ToInt32(search.month_select_y_from))
                    //    .Where(w => Convert.ToInt32(w.CashFlowYear) <= Convert.ToInt32(search.month_select_y_to))
                    //    .Where(w => search.month_select_m.Contains(w.Monthly))
                    //    .GroupBy(g => g.CashFlowYear + g.Monthly)
                    //    .Select(cl => new TrendCashFlow
                    //    {
                    //        CashFlowYear = cl.First().CashFlowYear,
                    //        Monthly = cl.First().Monthly,
                    //        Ebitda = cl.Sum(c => c.Ebitda),
                    //        WcSum = cl.Sum(c => c.WcSum),
                    //        Etc = cl.Sum(c => c.Etc),
                    //        NetCapexSum = cl.Sum(c => c.NetCapexSum),
                    //        FinancialCostSum = cl.Sum(c => c.FinancialCostSum),
                    //        Fcf2 = cl.Sum(c => c.Fcf2),
                    //        FinancialSum = cl.Sum(c => c.FinancialSum),
                    //        CashSum = cl.Sum(c => c.CashSum),
                    //        EndingCash = cl.Sum(c => c.EndingCash),
                    //        CreditLine = cl.Sum(c => c.CreditLine),
                    //        AvailableCash = cl.Sum(c => c.AvailableCash),
                    //        Allocation = cl.Sum(c => c.Allocation),
                    //        Increase = cl.Sum(c => c.Increase),
                    //        Borrowing = cl.Sum(c => c.Borrowing),
                    //        Repayment = cl.Sum(c => c.Repayment),
                    //        FinancialEtc = cl.Sum(c => c.FinancialEtc)
                    //    })
                    //    .OrderBy(o => o.CashFlowYear + o.Monthly)
                    //    .ToList();

                string result = String.Join(",", search.month_select_m.ToArray());
                    //LogUtil.ReportErrorLog(result.ToString() );
                    CashFlowList = tCashFlowRepo.GetCashFlowMonth_NEW_MonthChoice(new { PREYEAR = search.month_select_y_from
                                                                                    ,ENDYEAR = search.month_select_y_to } , result).ToList();
                }
                else if (search.level0 == Define.LEVEL.GetKey("부문"))
                {
                    CashFlowList = CashFlowMonth.Where(w => w.OrgUnionSeq == Convert.ToInt32(search.level1))
                        .Where(w => Convert.ToInt32(w.CashFlowYear) >= Convert.ToInt32(search.month_select_y_from))
                        .Where(w => Convert.ToInt32(w.CashFlowYear) <= Convert.ToInt32(search.month_select_y_to))
                        .Where(w => search.month_select_m.Contains(w.Monthly))
                        .GroupBy(g => g.CashFlowYear + g.Monthly)
                        .Select(cl => new TrendCashFlow
                        {
                            CashFlowYear = cl.First().CashFlowYear,
                            Monthly = cl.First().Monthly,
                            Ebitda = cl.Sum(c => c.Ebitda),
                            WcSum = cl.Sum(c => c.WcSum),
                            Etc = cl.Sum(c => c.Etc),
                            NetCapexSum = cl.Sum(c => c.NetCapexSum),
                            FinancialCostSum = cl.Sum(c => c.FinancialCostSum),
                            Fcf2 = cl.Sum(c => c.Fcf2),
                            FinancialSum = cl.Sum(c => c.FinancialSum),
                            CashSum = cl.Sum(c => c.CashSum),
                            EndingCash = cl.Sum(c => c.EndingCash),
                            CreditLine = cl.Sum(c => c.CreditLine),
                            AvailableCash = cl.Sum(c => c.AvailableCash),
                            Allocation = cl.Sum(c => c.Allocation),
                            Increase = cl.Sum(c => c.Increase),
                            Borrowing = cl.Sum(c => c.Borrowing),
                            Repayment = cl.Sum(c => c.Repayment),
                            FinancialEtc = cl.Sum(c => c.FinancialEtc)
                        })
                        .OrderBy(o => o.CashFlowYear + o.Monthly)
                        .ToList();
                }
                else if (search.level0 == Define.LEVEL.GetKey("회사"))
                {
                    CashFlowList = CashFlowMonth.Where(w => w.OrgCompanySeq == Convert.ToInt32(search.level1))
                        .Where(w => Convert.ToInt32(w.CashFlowYear) >= Convert.ToInt32(search.month_select_y_from))
                        .Where(w => Convert.ToInt32(w.CashFlowYear) <= Convert.ToInt32(search.month_select_y_to))
                        .Where(w => search.month_select_m.Contains(w.Monthly))
                        .OrderBy(o => o.CashFlowYear + o.Monthly)
                        .ToList();
                }
            }



            foreach (var item in CashFlowList)
            {
                // 년도별 그래프 데이터
                Values sales = new Values();
                Values invest = new Values();
                Values finanicial = new Values();
                Values fcf = new Values();
                Values netcf = new Values();

                string xString = item.CashFlowYear;

                if (search.yearType == Define.YEAR_TYPE.GetKey("분기"))
                {
                    xString = item.CashFlowYear + "." + item.Qt.ToString() + "Q";
                }
                else if (search.yearType == Define.YEAR_TYPE.GetKey("월(기간)"))
                {
                    xString = item.CashFlowYear + "." + item.Monthly;
                }
                else if (search.yearType == Define.YEAR_TYPE.GetKey("월(선택)"))
                {
                    xString = item.CashFlowYear + "." + item.Monthly;
                }
                xString = "'" + xString.Substring(2); // 앞에 두자리 짜름


                sales.x = xString;
                sales.y = Math.Round((item.Ebitda + item.WcSum + item.Etc + item.FinancialCostSum), 0, MidpointRounding.AwayFromZero);
                salesList.Add(sales);

                invest.x = xString;
                invest.y = Math.Round(item.NetCapexSum, 0, MidpointRounding.AwayFromZero);
                investList.Add(invest);

                finanicial.x = xString;
                finanicial.y = Math.Round(item.FinancialSum, 0, MidpointRounding.AwayFromZero);
                finanicialList.Add(finanicial);

                fcf.x = xString;
                fcf.y = Math.Round(item.Fcf2, 0, MidpointRounding.AwayFromZero);
                fcfList.Add(fcf);

                netcf.x = xString;
                netcf.y = Math.Round((item.Ebitda + item.WcSum + item.Etc + item.FinancialCostSum
                    + item.NetCapexSum
                    + item.FinancialSum), 0, MidpointRounding.AwayFromZero);
                netcfList.Add(netcf);

                TrendDataTable dt = new TrendDataTable();
                dt.year = xString;
                dt.a0 = Math.Round(item.Ebitda, 0, MidpointRounding.AwayFromZero).ToString();
                dt.a1 = Math.Round(item.WcSum, 0, MidpointRounding.AwayFromZero).ToString();
                dt.a2 = Math.Round(item.FinancialCostSum, 0, MidpointRounding.AwayFromZero).ToString();
                dt.a3 = Math.Round(item.Etc, 0, MidpointRounding.AwayFromZero).ToString();
                dt.b0 = Math.Round(item.NetCapexSum, 0, MidpointRounding.AwayFromZero).ToString();
                //dt.b1 = "0"; // 확인필요 : 투자활동.기타;

                dt.c0 = Math.Round(item.Allocation, 0, MidpointRounding.AwayFromZero).ToString();
                dt.c1 = Math.Round(item.Increase, 0, MidpointRounding.AwayFromZero).ToString();
                dt.c2 = Math.Round(item.Borrowing, 0, MidpointRounding.AwayFromZero).ToString();
                dt.c3 = Math.Round(item.Repayment, 0, MidpointRounding.AwayFromZero).ToString();
                dt.c4 = Math.Round(item.FinancialEtc, 0, MidpointRounding.AwayFromZero).ToString();

                /*
                if (dt.year == "2016")
                {
                    dt.b1 = "0";
                    dt.c0 = "0"; // 년도 요약 가져오는 곳에서는 없다. 배당
                    dt.c1 = "0"; // 년도 요약 가져오는 곳에서는 없다. 증자
                    dt.c2 = "0"; // 년도 요약 가져오는 곳에서는 없다. 차입
                    dt.c3 = "0"; // 년도 요약 가져오는 곳에서는 없다. 상환
                    dt.c4 = "0"; // 년도 요약 가져오는 곳에서는 없다. 기타
                }
                */
                data3.Add(dt);

                // 그래프3
                Values ending = new Values();
                Values avail = new Values();

                ending.x = xString;
                ending.y = Math.Round(item.EndingCash, 0, MidpointRounding.AwayFromZero);
                endingList.Add(ending);

                avail.x = xString;
                avail.y = Math.Round(item.AvailableCash, 0, MidpointRounding.AwayFromZero);
                availList.Add(avail);
            }

            // 데이터 입력 완료 후 항목별로 취합
            var d = new KeyValues();
            d.key = "영업활동";
            d.values = salesList;
            data1.Add(d);

            d = new KeyValues();
            d.key = "투자활동";
            d.values = investList;
            data1.Add(d);

            d = new KeyValues();
            d.key = "재무활동";
            d.values = finanicialList;
            data1.Add(d);

            d = new KeyValues();
            d.key = "FCF";
            d.values = fcfList;
            data1.Add(d);

            d = new KeyValues();
            d.key = "Net C/F";
            d.values = netcfList;
            data1.Add(d);

            var d6 = new KeyValues();
            d6.key = "Ending Cash";
            d6.values = endingList;
            data6.Add(d6);

            d6 = new KeyValues();
            d6.key = "가용현금";
            d6.values = availList;
            data6.Add(d6);

            return Json(new { data1, data3, data6 }, JsonRequestBehavior.AllowGet);
        }
    }
}