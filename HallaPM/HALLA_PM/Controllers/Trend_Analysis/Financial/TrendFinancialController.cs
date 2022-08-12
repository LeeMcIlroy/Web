using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

using HALLA_PM.Models;
using HALLA_PM.Core;
using HALLA_PM.Util;

namespace HALLA_PM.Controllers
{
    [RoutePrefix("Trend_Analysis/Financial")]
    public class TrendFinancialController : Controller
    {
        PageAuthRepo pageAuthRepo = new PageAuthRepo();
        TrendBsRepo tBsRepo = new TrendBsRepo();
        MemberSession mSession = SessionManager.GetMemberSession();

        [SystemLoginFilter]
        [SystemAuthFilter(MenuAuth = 3)]
        [Route("Index")]
        public ActionResult Index()
        {
            return View("~/Views/Trend_Analysis/Financial/Index.cshtml");
        }

        [Route("FinancialLevel")]
        public ActionResult FinancialLevel()
        {
            string AuthUserKey = mSession.insaUserV.userKey;

            LevelOne lv1 = new LevelOne();
            LevelTwo lv2 = new LevelTwo();
            LevelThree lv3 = new LevelThree();
            LevelFour lv4 = new LevelFour();

            //lv1.period = DateTime.Now.Year.ToString();
            int nYear = DateTime.Now.Year;
            lv1.period = new Period();
            lv1.period.year = new int[2] { 2016, nYear };
            lv1.period.quater = new int[2] { 2018, nYear };
            lv1.period.month_period = new int[2] { 2018, nYear };
            lv1.period.month_select = new int[2] { 2018, nYear };

            lv1.level = new List<LevelTwo>();
            var lvGroup = pageAuthRepo.GetGroupAuth(new { AuthUserKey = AuthUserKey }).ToList();
            // 2018.12.17 그룹임시 안 보이게 변경
            //if (lvGroup.Count() > 0)
            //{
            //    lv2.id = lvGroup.First().id;
            //    lv2.txt = lvGroup.First().txt;
            //    lv1.level.Add(lv2);
            //}

            var lvUnion = pageAuthRepo.GetUnionAuth(new { AuthUserKey = AuthUserKey }).ToList();

            // 2018.12.18 부문임시 안 보이게 변경
            //if (lvUnion.Count() > 0)
            //{
            //    lv2 = new LevelTwo();
            //    lv2.sub = new List<LevelThree>();

            //    lv2.id = "1";
            //    lv2.txt = "부문";
            //    lv1.level.Add(lv2);
            //    foreach (var item in lvUnion)
            //    {
            //        lv3 = new LevelThree();
            //        lv3.id = item.id;
            //        lv3.txt = item.txt;
            //        lv2.sub.Add(lv3);
            //    }
            //}

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

        [Route("FinancialData")]
        public ActionResult FinancialData(TrendSearch search)
        {

            List<TrendBs> FinancialYear = tBsRepo.GetBsYear(new { }).ToList();
            List<TrendBs> FinancialMonth = tBsRepo.GetBsMonth(new { }).ToList();

            // 그래프
            List<KeyValues> data1 = new List<KeyValues>();
            // 그래프 - 데이터 리스트
            List<Values> roicList = new List<Values>();
            List<Values> lRateList = new List<Values>();
            List<Values> cRateList = new List<Values>();

            // 테이블
            List<TrendDataTable> data4 = new List<TrendDataTable>();

            // 그래프
            List<KeyValues> data6 = new List<KeyValues>();
            // 그래프 - 데이터 리스트
            List<Values> arList = new List<Values>();
            List<Values> apList = new List<Values>();
            List<Values> invList = new List<Values>();

            // 테이블
            List<TrendDataTable> data7 = new List<TrendDataTable>();

            List<TrendBs> FinancailList = new List<TrendBs>();
            // 년도별, 월별
            if (search.yearType == Define.YEAR_TYPE.GetKey("년도"))
            {
                FinancailList = new List<TrendBs>();
                if (search.level0 == Define.LEVEL.GetKey("그룹"))
                {
                    FinancailList = FinancialYear
                        .Where(w => Convert.ToInt32(w.BsYear) >= Convert.ToInt32(search.year_y_from))
                        .Where(w => Convert.ToInt32(w.BsYear) <= Convert.ToInt32(search.year_y_to))
                        .GroupBy(g => new { g.BsYear, g.Monthly })
                        .Select(cl => new TrendBs
                        {
                            BsYear = cl.First().BsYear,
                            Monthly = cl.First().Monthly,
                            Assets = cl.Sum(c => c.Assets),
                            CurrentAssets = cl.Sum(c => c.CurrentAssets),
                            Liabilities = cl.Sum(c => c.Liabilities),
                            CurrentLiabilities = cl.Sum(c => c.CurrentLiabilities),
                            Capital = cl.Sum(c => c.Capital),
                            Cash = cl.Sum(c => c.Cash),
                            Loan = cl.Sum(c => c.Loan),
                            AfterTaxOperationProfit = cl.Sum(c => c.AfterTaxOperationProfit),
                            PainInCapital = cl.Sum(c => c.PainInCapital),
                            Ar = cl.Sum(c => c.Ar),
                            ArToDays = cl.Sum(c => c.ArToDays),
                            Ap = cl.Sum(c => c.Ap),
                            ApToDays = cl.Sum(c => c.ApToDays),
                            Inventory = cl.Sum(c => c.Inventory),
                            InventoryToDays = cl.Sum(c => c.InventoryToDays)
                        })
                        .OrderBy(o => o.BsYear)
                        .ToList();
                }
                else if (search.level0 == Define.LEVEL.GetKey("부문"))
                {
                    FinancailList = FinancialYear
                        .Where(w => w.OrgUnionSeq == Convert.ToInt32(search.level1))
                        .Where(w => Convert.ToInt32(w.BsYear) >= Convert.ToInt32(search.year_y_from))
                        .Where(w => Convert.ToInt32(w.BsYear) <= Convert.ToInt32(search.year_y_to))
                        .GroupBy(g => new { g.BsYear, g.Monthly })
                        .Select(cl => new TrendBs
                        {
                            BsYear = cl.First().BsYear,
                            Monthly = cl.First().Monthly,
                            Assets = cl.Sum(c => c.Assets),
                            CurrentAssets = cl.Sum(c => c.CurrentAssets),
                            Liabilities = cl.Sum(c => c.Liabilities),
                            CurrentLiabilities = cl.Sum(c => c.CurrentLiabilities),
                            Capital = cl.Sum(c => c.Capital),
                            Cash = cl.Sum(c => c.Cash),
                            Loan = cl.Sum(c => c.Loan),
                            AfterTaxOperationProfit = cl.Sum(c => c.AfterTaxOperationProfit),
                            PainInCapital = cl.Sum(c => c.PainInCapital),
                            Ar = cl.Sum(c => c.Ar),
                            ArToDays = cl.Sum(c => c.ArToDays),
                            Ap = cl.Sum(c => c.Ap),
                            ApToDays = cl.Sum(c => c.ApToDays),
                            Inventory = cl.Sum(c => c.Inventory),
                            InventoryToDays = cl.Sum(c => c.InventoryToDays)
                        })
                        .OrderBy(o => o.BsYear)
                        .ToList();
                }
                else if (search.level0 == Define.LEVEL.GetKey("회사"))
                {
                    FinancailList = FinancialYear
                        .Where(w => w.OrgCompanySeq == Convert.ToInt32(search.level1))
                        .Where(w => Convert.ToInt32(w.BsYear) >= Convert.ToInt32(search.year_y_from))
                        .Where(w => Convert.ToInt32(w.BsYear) <= Convert.ToInt32(search.year_y_to))
                        .GroupBy(g => new { g.BsYear, g.Monthly })
                        .Select(cl => new TrendBs
                        {
                            BsYear = cl.First().BsYear,
                            Monthly = cl.First().Monthly,
                            Assets = cl.Sum(c => c.Assets),
                            CurrentAssets = cl.Sum(c => c.CurrentAssets),
                            Liabilities = cl.Sum(c => c.Liabilities),
                            CurrentLiabilities = cl.Sum(c => c.CurrentLiabilities),
                            Capital = cl.Sum(c => c.Capital),
                            Cash = cl.Sum(c => c.Cash),
                            Loan = cl.Sum(c => c.Loan),
                            AfterTaxOperationProfit = cl.Sum(c => c.AfterTaxOperationProfit),
                            PainInCapital = cl.Sum(c => c.PainInCapital),
                            Ar = cl.Sum(c => c.Ar),
                            ArToDays = cl.Sum(c => c.ArToDays),
                            Ap = cl.Sum(c => c.Ap),
                            ApToDays = cl.Sum(c => c.ApToDays),
                            Inventory = cl.Sum(c => c.Inventory),
                            InventoryToDays = cl.Sum(c => c.InventoryToDays)
                        })
                        .OrderBy(o => o.BsYear)
                        .ToList();
                }
            }
            else if (search.yearType == Define.YEAR_TYPE.GetKey("분기"))
            {
                FinancailList = new List<TrendBs>();
                if (search.level0 == Define.LEVEL.GetKey("그룹"))
                {
                    FinancailList = FinancialMonth
                        .Where(w => Convert.ToInt32(w.BsYear) >= Convert.ToInt32(search.quater_y_from))
                        .Where(w => Convert.ToInt32(w.BsYear) <= Convert.ToInt32(search.quater_y_to))
                        .Where(w => search.quater.Contains(w.Qt.ToString()))
                        .GroupBy(g => new { g.BsYear, g.Qt })
                        .Select(cl => new TrendBs
                        {
                            BsYear = cl.First().BsYear,
                            Qt = cl.First().Qt,
                            Assets = cl.Sum(c => c.Assets),
                            CurrentAssets = cl.Sum(c => c.CurrentAssets),
                            Liabilities = cl.Sum(c => c.Liabilities),
                            CurrentLiabilities = cl.Sum(c => c.CurrentLiabilities),
                            Capital = cl.Sum(c => c.Capital),
                            Cash = cl.Sum(c => c.Cash),
                            Loan = cl.Sum(c => c.Loan),
                            AfterTaxOperationProfit = cl.Sum(c => c.AfterTaxOperationProfit),
                            PainInCapital = cl.Sum(c => c.PainInCapital),
                            Ar = cl.Sum(c => c.Ar),
                            ArToDays = cl.Sum(c => c.ArToDays),
                            Ap = cl.Sum(c => c.Ap),
                            ApToDays = cl.Sum(c => c.ApToDays),
                            Inventory = cl.Sum(c => c.Inventory),
                            InventoryToDays = cl.Sum(c => c.InventoryToDays),
                            AnnualSales = cl.Sum(c => c.AnnualSales),
                            AnnualSalesCost = cl.Sum(c => c.AnnualSalesCost),
                            InventoryCost = cl.Sum(c => c.InventoryCost)
                        })
                        .OrderBy(o => o.BsYear)
                        .ThenBy(o => o.Qt)
                        .ToList();
                }
                else if (search.level0 == Define.LEVEL.GetKey("부문"))
                {
                    FinancailList = FinancialMonth
                        .Where(w => w.OrgUnionSeq == Convert.ToInt32(search.level1))
                        .Where(w => Convert.ToInt32(w.BsYear) >= Convert.ToInt32(search.quater_y_from))
                        .Where(w => Convert.ToInt32(w.BsYear) <= Convert.ToInt32(search.quater_y_to))
                        .Where(w => search.quater.Contains(w.Qt.ToString()))
                        .GroupBy(g => new { g.BsYear, g.Qt })
                        .Select(cl => new TrendBs
                        {
                            BsYear = cl.First().BsYear,
                            Qt = cl.First().Qt,
                            Assets = cl.Sum(c => c.Assets),
                            CurrentAssets = cl.Sum(c => c.CurrentAssets),
                            Liabilities = cl.Sum(c => c.Liabilities),
                            CurrentLiabilities = cl.Sum(c => c.CurrentLiabilities),
                            Capital = cl.Sum(c => c.Capital),
                            Cash = cl.Sum(c => c.Cash),
                            Loan = cl.Sum(c => c.Loan),
                            AfterTaxOperationProfit = cl.Sum(c => c.AfterTaxOperationProfit),
                            PainInCapital = cl.Sum(c => c.PainInCapital),
                            Ar = cl.Sum(c => c.Ar),
                            ArToDays = cl.Sum(c => c.ArToDays),
                            Ap = cl.Sum(c => c.Ap),
                            ApToDays = cl.Sum(c => c.ApToDays),
                            Inventory = cl.Sum(c => c.Inventory),
                            InventoryToDays = cl.Sum(c => c.InventoryToDays),
                            AnnualSales = cl.Sum(c => c.AnnualSales),
                            AnnualSalesCost = cl.Sum(c => c.AnnualSalesCost),
                            InventoryCost = cl.Sum(c => c.InventoryCost)
                        })
                        .OrderBy(o => o.BsYear)
                        .ThenBy(o => o.Qt)
                        .ToList();
                }
                else if (search.level0 == Define.LEVEL.GetKey("회사"))
                {
                    FinancailList = FinancialMonth
                        .Where(w => w.OrgCompanySeq == Convert.ToInt32(search.level1))
                        .Where(w => Convert.ToInt32(w.BsYear) >= Convert.ToInt32(search.quater_y_from))
                        .Where(w => Convert.ToInt32(w.BsYear) <= Convert.ToInt32(search.quater_y_to))
                        .Where(w => search.quater.Contains(w.Qt.ToString()))
                        .GroupBy(g => new { g.BsYear, g.Qt })
                        .Select(cl => new TrendBs
                        {
                            BsYear = cl.First().BsYear,
                            Qt = cl.First().Qt,
                            Assets = cl.Sum(c => c.Assets),
                            CurrentAssets = cl.Sum(c => c.CurrentAssets),
                            Liabilities = cl.Sum(c => c.Liabilities),
                            CurrentLiabilities = cl.Sum(c => c.CurrentLiabilities),
                            Capital = cl.Sum(c => c.Capital),
                            Cash = cl.Sum(c => c.Cash),
                            Loan = cl.Sum(c => c.Loan),
                            AfterTaxOperationProfit = cl.Sum(c => c.AfterTaxOperationProfit),
                            PainInCapital = cl.Sum(c => c.PainInCapital),
                            Ar = cl.Sum(c => c.Ar),
                            ArToDays = cl.Sum(c => c.ArToDays),
                            Ap = cl.Sum(c => c.Ap),
                            ApToDays = cl.Sum(c => c.ApToDays),
                            Inventory = cl.Sum(c => c.Inventory),
                            InventoryToDays = cl.Sum(c => c.InventoryToDays),
                            AnnualSales = cl.Sum(c => c.AnnualSales),
                            AnnualSalesCost = cl.Sum(c => c.AnnualSalesCost),
                            InventoryCost = cl.Sum(c => c.InventoryCost)
                        })
                        .OrderBy(o => o.BsYear)
                        .ThenBy(o => o.Qt)
                        .ToList();
                }
            }
            else if (search.yearType == Define.YEAR_TYPE.GetKey("월(기간)"))
            {
                FinancailList = new List<TrendBs>();
                if (search.level0 == Define.LEVEL.GetKey("그룹"))
                {
                    FinancailList = FinancialMonth
                        .Where(w => Convert.ToInt32(w.BsYear + w.Monthly) >= Convert.ToInt32(search.month_period_y_from + search.month_period_m_from))
                        .Where(w => Convert.ToInt32(w.BsYear + w.Monthly) <= Convert.ToInt32(search.month_period_y_to + search.month_period_m_to))
                        .GroupBy(g => g.BsYear + g.Monthly)
                        .Select(cl => new TrendBs
                        {
                            BsYear = cl.First().BsYear,
                            Monthly = cl.First().Monthly,
                            Assets = cl.Sum(c => c.Assets),
                            CurrentAssets = cl.Sum(c => c.CurrentAssets),
                            Liabilities = cl.Sum(c => c.Liabilities),
                            CurrentLiabilities = cl.Sum(c => c.CurrentLiabilities),
                            Capital = cl.Sum(c => c.Capital),
                            Cash = cl.Sum(c => c.Cash),
                            Loan = cl.Sum(c => c.Loan),
                            AfterTaxOperationProfit = cl.Sum(c => c.AfterTaxOperationProfit),
                            PainInCapital = cl.Sum(c => c.PainInCapital),
                            Ar = cl.Sum(c => c.Ar),
                            ArToDays = cl.Sum(c => c.ArToDays),
                            Ap = cl.Sum(c => c.Ap),
                            ApToDays = cl.Sum(c => c.ApToDays),
                            Inventory = cl.Sum(c => c.Inventory),
                            InventoryToDays = cl.Sum(c => c.InventoryToDays),
                            AnnualSales = cl.Sum(c => c.AnnualSales),
                            AnnualSalesCost = cl.Sum(c => c.AnnualSalesCost),
                            InventoryCost = cl.Sum(c => c.InventoryCost)
                        })
                        .OrderBy(o => o.BsYear + o.Monthly)
                        .ToList();
                }
                else if (search.level0 == Define.LEVEL.GetKey("부문"))
                {
                    FinancailList = FinancialMonth
                        .Where(w => w.OrgUnionSeq == Convert.ToInt32(search.level1))
                        .Where(w => Convert.ToInt32(w.BsYear + w.Monthly) >= Convert.ToInt32(search.month_period_y_from + search.month_period_m_from))
                        .Where(w => Convert.ToInt32(w.BsYear + w.Monthly) <= Convert.ToInt32(search.month_period_y_to + search.month_period_m_to))
                        .GroupBy(g => g.BsYear + g.Monthly)
                        .Select(cl => new TrendBs
                        {
                            BsYear = cl.First().BsYear,
                            Monthly = cl.First().Monthly,
                            Assets = cl.Sum(c => c.Assets),
                            CurrentAssets = cl.Sum(c => c.CurrentAssets),
                            Liabilities = cl.Sum(c => c.Liabilities),
                            CurrentLiabilities = cl.Sum(c => c.CurrentLiabilities),
                            Capital = cl.Sum(c => c.Capital),
                            Cash = cl.Sum(c => c.Cash),
                            Loan = cl.Sum(c => c.Loan),
                            AfterTaxOperationProfit = cl.Sum(c => c.AfterTaxOperationProfit),
                            PainInCapital = cl.Sum(c => c.PainInCapital),
                            Ar = cl.Sum(c => c.Ar),
                            ArToDays = cl.Sum(c => c.ArToDays),
                            Ap = cl.Sum(c => c.Ap),
                            ApToDays = cl.Sum(c => c.ApToDays),
                            Inventory = cl.Sum(c => c.Inventory),
                            InventoryToDays = cl.Sum(c => c.InventoryToDays),
                            AnnualSales = cl.Sum(c => c.AnnualSales),
                            AnnualSalesCost = cl.Sum(c => c.AnnualSalesCost),
                            InventoryCost = cl.Sum(c => c.InventoryCost)
                        })
                        .OrderBy(o => o.BsYear + o.Monthly)
                        .ToList();
                }
                else if (search.level0 == Define.LEVEL.GetKey("회사"))
                {
                    FinancailList = FinancialMonth
                        .Where(w => w.OrgCompanySeq == Convert.ToInt32(search.level1))
                        .Where(w => Convert.ToInt32(w.BsYear + w.Monthly) >= Convert.ToInt32(search.month_period_y_from + search.month_period_m_from))
                        .Where(w => Convert.ToInt32(w.BsYear + w.Monthly) <= Convert.ToInt32(search.month_period_y_to + search.month_period_m_to))
                        /*
                        .GroupBy(g => g.BsYear + g.Monthly)
                        .Select(cl => new TrendBs
                        {
                            BsYear = cl.First().BsYear,
                            Monthly = cl.First().Monthly,
                            Assets = cl.Sum(c => c.Assets),
                            Liabilities = cl.Sum(c => c.Liabilities),
                            Capital = cl.Sum(c => c.Capital),
                            Cash = cl.Sum(c => c.Cash),
                            Loan = cl.Sum(c => c.Loan),
                            AfterTaxOperationProfit = cl.Sum(c => c.AfterTaxOperationProfit),
                            PainInCapital = cl.Sum(c => c.PainInCapital),
                            Ar = cl.Sum(c => c.Ar),
                            ArToDays = cl.Sum(c => c.ArToDays),
                            Ap = cl.Sum(c => c.Ap),
                            ApToDays = cl.Sum(c => c.ApToDays),
                            Inventory = cl.Sum(c => c.Inventory)
                        })
                        */
                        .OrderBy(o => o.BsYear + o.Monthly)
                        .ToList();
                }
            }
            else if (search.yearType == Define.YEAR_TYPE.GetKey("월(선택)"))
            {
                FinancailList = new List<TrendBs>();
                if (search.level0 == Define.LEVEL.GetKey("그룹"))
                {
                    FinancailList = FinancialMonth
                        .Where(w => Convert.ToInt32(w.BsYear) >= Convert.ToInt32(search.month_select_y_from))
                        .Where(w => Convert.ToInt32(w.BsYear) <= Convert.ToInt32(search.month_select_y_to))
                        .Where(w => search.month_select_m.Contains(w.Monthly))
                        .GroupBy(g => g.BsYear + g.Monthly)
                        .Select(cl => new TrendBs
                        {
                            BsYear = cl.First().BsYear,
                            Monthly = cl.First().Monthly,
                            Assets = cl.Sum(c => c.Assets),
                            CurrentAssets = cl.Sum(c => c.CurrentAssets),
                            Liabilities = cl.Sum(c => c.Liabilities),
                            CurrentLiabilities = cl.Sum(c => c.CurrentLiabilities),
                            Capital = cl.Sum(c => c.Capital),
                            Cash = cl.Sum(c => c.Cash),
                            Loan = cl.Sum(c => c.Loan),
                            AfterTaxOperationProfit = cl.Sum(c => c.AfterTaxOperationProfit),
                            PainInCapital = cl.Sum(c => c.PainInCapital),
                            Ar = cl.Sum(c => c.Ar),
                            ArToDays = cl.Sum(c => c.ArToDays),
                            Ap = cl.Sum(c => c.Ap),
                            ApToDays = cl.Sum(c => c.ApToDays),
                            Inventory = cl.Sum(c => c.Inventory),
                            InventoryToDays = cl.Sum(c => c.InventoryToDays),
                            AnnualSales = cl.Sum(c => c.AnnualSales),
                            AnnualSalesCost = cl.Sum(c => c.AnnualSalesCost),
                            InventoryCost = cl.Sum(c => c.InventoryCost)
                        })
                        .OrderBy(o => o.BsYear + o.Monthly)
                        .ToList();
                }
                else if (search.level0 == Define.LEVEL.GetKey("부문"))
                {
                    FinancailList = FinancialMonth
                        .Where(w => w.OrgUnionSeq == Convert.ToInt32(search.level1))
                        .Where(w => Convert.ToInt32(w.BsYear) >= Convert.ToInt32(search.month_select_y_from))
                        .Where(w => Convert.ToInt32(w.BsYear) <= Convert.ToInt32(search.month_select_y_to))
                        .Where(w => search.month_select_m.Contains(w.Monthly))
                        .GroupBy(g => g.BsYear + g.Monthly)
                        .Select(cl => new TrendBs
                        {
                            BsYear = cl.First().BsYear,
                            Monthly = cl.First().Monthly,
                            Assets = cl.Sum(c => c.Assets),
                            CurrentAssets = cl.Sum(c => c.CurrentAssets),
                            Liabilities = cl.Sum(c => c.Liabilities),
                            CurrentLiabilities = cl.Sum(c => c.CurrentLiabilities),
                            Capital = cl.Sum(c => c.Capital),
                            Cash = cl.Sum(c => c.Cash),
                            Loan = cl.Sum(c => c.Loan),
                            AfterTaxOperationProfit = cl.Sum(c => c.AfterTaxOperationProfit),
                            PainInCapital = cl.Sum(c => c.PainInCapital),
                            Ar = cl.Sum(c => c.Ar),
                            ArToDays = cl.Sum(c => c.ArToDays),
                            Ap = cl.Sum(c => c.Ap),
                            ApToDays = cl.Sum(c => c.ApToDays),
                            Inventory = cl.Sum(c => c.Inventory),
                            InventoryToDays = cl.Sum(c => c.InventoryToDays),
                            AnnualSales = cl.Sum(c => c.AnnualSales),
                            AnnualSalesCost = cl.Sum(c => c.AnnualSalesCost),
                            InventoryCost = cl.Sum(c => c.InventoryCost)
                        })
                        .OrderBy(o => o.BsYear + o.Monthly)
                        .ToList();
                }
                else if (search.level0 == Define.LEVEL.GetKey("회사"))
                {
                    FinancailList = FinancialMonth
                        .Where(w => w.OrgCompanySeq == Convert.ToInt32(search.level1))
                        .Where(w => Convert.ToInt32(w.BsYear) >= Convert.ToInt32(search.month_select_y_from))
                        .Where(w => Convert.ToInt32(w.BsYear) <= Convert.ToInt32(search.month_select_y_to))
                        .Where(w => search.month_select_m.Contains(w.Monthly))
                        /*
                        .GroupBy(g => g.BsYear + g.Monthly)
                        .Select(cl => new TrendBs
                        {
                            BsYear = cl.First().BsYear,
                            Monthly = cl.First().Monthly,
                            Assets = cl.Sum(c => c.Assets),
                            Liabilities = cl.Sum(c => c.Liabilities),
                            Capital = cl.Sum(c => c.Capital),
                            Cash = cl.Sum(c => c.Cash),
                            Loan = cl.Sum(c => c.Loan),
                            AfterTaxOperationProfit = cl.Sum(c => c.AfterTaxOperationProfit),
                            PainInCapital = cl.Sum(c => c.PainInCapital),
                            Ar = cl.Sum(c => c.Ar),
                            ArToDays = cl.Sum(c => c.ArToDays),
                            Ap = cl.Sum(c => c.Ap),
                            ApToDays = cl.Sum(c => c.ApToDays),
                            Inventory = cl.Sum(c => c.Inventory)
                        })
                        */
                        .OrderBy(o => o.BsYear + o.Monthly)
                        .ToList();
                }
            }


            foreach (var item in FinancailList)
            {
                // 년도별 그래프 데이터
                Values roic = new Values();
                Values lRate = new Values();
                Values cRate = new Values();
                
                string xString = item.BsYear;

                if (search.yearType == Define.YEAR_TYPE.GetKey("분기"))
                {
                    xString = item.BsYear + "." + item.Qt.ToString() + "Q";
                }
                else if (search.yearType == Define.YEAR_TYPE.GetKey("월(기간)"))
                {
                    xString = item.BsYear + "." + item.Monthly;
                }
                else if (search.yearType == Define.YEAR_TYPE.GetKey("월(선택)"))
                {
                    xString = item.BsYear + "." + item.Monthly;
                }
                xString = "'" + xString.Substring(2); // 앞에 두자리 짜름

                if (string.IsNullOrWhiteSpace(item.Monthly)) item.Monthly = "12";

                decimal month = Convert.ToDecimal(item.Monthly);

                roic.x = xString;
                roic.y = item.PainInCapital == 0 ? 0 : Math.Round(WebUtil.NewRoic((item.AfterTaxOperationProfit / item.PainInCapital * 100), month), 1, MidpointRounding.AwayFromZero);
                roicList.Add(roic);
                
                // 총자산 / 총부채
                lRate.x = xString;
                lRate.y = item.Capital == 0 ? 0 : Math.Round((item.Liabilities / item.Capital) * 100, 1, MidpointRounding.AwayFromZero);
                lRateList.Add(lRate);

                cRate.x = xString;
                cRate.y = item.CurrentLiabilities == 0 ? 0 : Math.Round((item.CurrentAssets / item.CurrentLiabilities) * 100, 1, MidpointRounding.AwayFromZero);
                cRateList.Add(cRate);


                TrendDataTable dt = new TrendDataTable();
                dt.year = xString;
                dt.a0 = Math.Round(item.AfterTaxOperationProfit, 0, MidpointRounding.AwayFromZero).ToString();
                dt.a1 = Math.Round(item.PainInCapital, 0, MidpointRounding.AwayFromZero).ToString();
                dt.b0 = Math.Round(item.Assets, 0, MidpointRounding.AwayFromZero).ToString();
                dt.b1 = Math.Round(item.CurrentAssets, 0, MidpointRounding.AwayFromZero).ToString();
                dt.b2 = Math.Round(item.Liabilities, 0, MidpointRounding.AwayFromZero).ToString();
                dt.b3 = Math.Round(item.CurrentLiabilities, 0, MidpointRounding.AwayFromZero).ToString();
                dt.b4 = Math.Round(item.Capital, 0, MidpointRounding.AwayFromZero).ToString();

                data4.Add(dt);

                // 그래프3
                // 년도인경우는 데이터를 그냥 가지고 오고, 그 외에는 계산해야한다(테이블 구조가 년누적 데이터와 월별이 다름)
                Values ar = new Values();
                Values ap = new Values();
                Values inv = new Values();

                if (search.yearType == Define.YEAR_TYPE.GetKey("년도"))
                {
                    ar.x = xString;
                    ar.y = Math.Round(item.ArToDays, 0, MidpointRounding.AwayFromZero);
                    arList.Add(ar);

                    ap.x = xString;
                    ap.y = Math.Round(item.ApToDays, 0, MidpointRounding.AwayFromZero);
                    apList.Add(ap);

                    inv.x = xString;
                    inv.y = Math.Round(item.InventoryToDays, 0, MidpointRounding.AwayFromZero);
                    invList.Add(inv);
                }
                else
                {
                    // ar / 연간매출액 * 365
                    ar.x = xString;
                    ar.y = item.AnnualSales == 0 ? 0 : Math.Round((item.Ar / item.AnnualSales) * 365, 0, MidpointRounding.AwayFromZero);
                    arList.Add(ar);
                    // ap / 연간매출원가 * 365
                    ap.x = xString;
                    ap.y = item.AnnualSalesCost == 0 ? 0 : Math.Round((item.Ap / item.AnnualSalesCost) * 365, 0, MidpointRounding.AwayFromZero);
                    apList.Add(ap);
                    // inv / 연간매출원가 * 365
                    inv.x = xString;
                    inv.y = item.InventoryCost == 0 ? 0 : Math.Round((item.Inventory / item.InventoryCost) * 365, 0, MidpointRounding.AwayFromZero);
                    invList.Add(inv);
                }

                dt = new TrendDataTable();
                dt.year = xString;
                dt.a = Math.Round(item.Ar, 0).ToString();
                dt.b = Math.Round(item.Ap, 0).ToString();
                dt.c = Math.Round(item.Inventory, 0).ToString();
                data7.Add(dt);
            }

            // 데이터 입력 완료 후 항목별로 취합
            var d = new KeyValues();
            d.key = "ROIC";
            d.values = roicList;
            data1.Add(d);

            d = new KeyValues();
            d.key = "부채비율";
            d.values = lRateList;
            data1.Add(d);

            d = new KeyValues();
            d.key = "유동비율";
            d.values = cRateList;
            data1.Add(d);

            d = new KeyValues();
            d.key = "AR T.O. days";
            d.values = arList;
            data6.Add(d);

            d = new KeyValues();
            d.key = "Ap T.O. days";
            d.values = apList;
            data6.Add(d);

            var d6 = new KeyValues();
            d6.key = "Inventory T.O. days";
            d6.values = invList;
            data6.Add(d6);

            return Json( new { data1, data4, data6, data7 }, JsonRequestBehavior.AllowGet);
        }
    }
}