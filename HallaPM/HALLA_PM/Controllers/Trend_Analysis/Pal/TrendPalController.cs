using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

using HALLA_PM.Models;
using HALLA_PM.Core;

namespace HALLA_PM.Controllers
{
    [RoutePrefix("Trend_Analysis/Pal")]
    public class TrendPalController : Controller
    {
        PageAuthRepo pageAuthRepo = new PageAuthRepo();
        TrendPalRepo tPalRepo = new TrendPalRepo();
        MemberSession mSession = SessionManager.GetMemberSession();

        [SystemLoginFilter]
        [SystemAuthFilter(MenuAuth = 3)]
        [Route("Index")]
        public ActionResult Index()
        {
            return View("~/Views/Trend_Analysis/Pal/Index.cshtml");
        }

        [Route("PalLevel")]
        public ActionResult PalLevel()
        {
            string AuthUserKey = mSession.insaUserV.userKey;

            LevelOne lv1 = new LevelOne();
            LevelTwo lv2 = new LevelTwo();
            LevelThree lv3 = new LevelThree();
            LevelFour lv4 = new LevelFour();

            //lv1.period = DateTime.Now.Year.ToString();
            int nYear = DateTime.Now.Year;
            lv1.period = new Period();
            lv1.period.year = new int[2] { 2008, nYear };
            lv1.period.quater = new int[2] { 2017, nYear };
            lv1.period.month_period = new int[2] { 2017, nYear };
            lv1.period.month_select = new int[2] { 2017, nYear };

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

            return Json(lv1, JsonRequestBehavior.AllowGet);
        }

        [Route("PalData")]
        public ActionResult PalData(TrendSearch search)
        {
            // EbitRate = (Ebit / Sales) * 100

            List<TrendPal> PalUnionCompany = tPalRepo.GetPalUnionCompany(new { }).ToList();
            List<TrendPal> PalBusiness = tPalRepo.GetPalBusiness(new { }).ToList();

            List<KeyValues> data1 = new List<KeyValues>();
            List<Values> salesList = new List<Values>();

            List<KeyValues> data2 = new List<KeyValues>();
            List<Values> ebitList = new List<Values>();
            List<Values> pbtList = new List<Values>();

            List<TrendPal> PalList = new List<TrendPal>();

            // 현재 모든 데이터는 소수점 2자리까지의 데이터를 모두 합친다.(자르지 않고)
            if (search.yearType == Define.YEAR_TYPE.GetKey("년도"))
            {
                PalList = new List<TrendPal>();

                if (search.level0 == Define.LEVEL.GetKey("그룹"))
                {
                    // .Where(w => w.NoZ == 1) : NoZ가 1이면 해당년도의 제일 마지막 월의 누적 데이터이다. : 년도별 데이터에서 마직막 월의 누적 데이터를 체크한다.
                    //PalList = PalUnionCompany
                    //    .Where(w => Convert.ToInt32(w.PalYear) >= Convert.ToInt32(search.year_y_from))
                    //    .Where(w => Convert.ToInt32(w.PalYear) <= Convert.ToInt32(search.year_y_to))
                    //    .Where(w => w.NoZ == 1)
                    //    .GroupBy(g => g.PalYear)
                    //    .Select(cl => new TrendPal
                    //    {
                    //        PalYear = cl.First().PalYear,
                    //        Sales = cl.Sum(c => c.Sales),
                    //        Ebit = cl.Sum(c => c.Ebit),
                    //        Pbt = cl.Sum(c => c.Pbt)
                    //    })
                    //    .OrderBy(o => o.PalYear)
                    //    .ToList();
                    PalList = tPalRepo.GetPalUnionCompany_NEW(new {PREYEAR = search.year_y_from ,ENDYEAR = search.year_y_to }).ToList();
                }
                else if (search.level0 == Define.LEVEL.GetKey("부문"))
                {
                    PalList = PalUnionCompany
                        .Where(w => w.OrgUnionSeq == Convert.ToInt32(search.level1))
                        .Where(w => Convert.ToInt32(w.PalYear) >= Convert.ToInt32(search.year_y_from))
                        .Where(w => Convert.ToInt32(w.PalYear) <= Convert.ToInt32(search.year_y_to))
                        .Where(w => w.NoZ == 1)
                        .GroupBy(g => g.PalYear)
                        .Select(cl => new TrendPal
                        {
                            PalYear = cl.First().PalYear,
                            Sales = cl.Sum(c => c.Sales),
                            Ebit = cl.Sum(c => c.Ebit),
                            Pbt = cl.Sum(c => c.Pbt)
                        })
                        .OrderBy(o => o.PalYear)
                        .ToList();
                }
                else if (search.level0 == Define.LEVEL.GetKey("회사"))
                {
                    PalList = PalUnionCompany
                        .Where(w => w.OrgCompanySeq == Convert.ToInt32(search.level1))
                        .Where(w => Convert.ToInt32(w.PalYear) >= Convert.ToInt32(search.year_y_from))
                        .Where(w => Convert.ToInt32(w.PalYear) <= Convert.ToInt32(search.year_y_to))
                        .Where(w => w.NoZ == 1)
                        .GroupBy(g => g.PalYear)
                        .Select(cl => new TrendPal
                        {
                            PalYear = cl.First().PalYear,
                            Sales = cl.Sum(c => c.Sales),
                            Ebit = cl.Sum(c => c.Ebit),
                            Pbt = cl.Sum(c => c.Pbt)
                        })
                        .OrderBy(o => o.PalYear)
                        .ToList();
                }
                else if (search.level0 == Define.LEVEL.GetKey("BU"))
                {
                    PalList = PalBusiness
                        .Where(w => w.OrgBusinessSeq == Convert.ToInt32(search.level2))
                        .Where(w => Convert.ToInt32(w.PalYear) >= Convert.ToInt32(search.year_y_from))
                        .Where(w => Convert.ToInt32(w.PalYear) <= Convert.ToInt32(search.year_y_to))
                        .Where(w => w.NoZ == 1)
                        .GroupBy(g => g.PalYear)
                        .Select(cl => new TrendPal
                        {
                            PalYear = cl.First().PalYear,
                            Sales = cl.Sum(c => c.Sales),
                            Ebit = cl.Sum(c => c.Ebit),
                            Pbt = cl.Sum(c => c.Pbt)
                        })
                        .OrderBy(o => o.PalYear)
                        .ToList();
                }
            }
            else if (search.yearType == Define.YEAR_TYPE.GetKey("분기"))
            {
                PalList = new List<TrendPal>();
                if (search.level0 == Define.LEVEL.GetKey("그룹"))
                {
                    //PalList = PalUnionCompany
                    //    .Where(w => Convert.ToInt32(w.PalYear) >= Convert.ToInt32(search.quater_y_from))
                    //    .Where(w => Convert.ToInt32(w.PalYear) <= Convert.ToInt32(search.quater_y_to))
                    //    .Where(w => search.quater.Contains(w.Qt.ToString()))
                    //    .Where(w => w.MonthlyType == Define.MONTHLY_TYPE.GetKey("당월"))
                    //    .GroupBy(g => new { g.PalYear, g.Qt })
                    //    .Select(cl => new TrendPal
                    //    {
                    //        PalYear = cl.First().PalYear,
                    //        Qt = cl.First().Qt,
                    //        Sales = cl.Sum(c => c.Sales),
                    //        Ebit = cl.Sum(c => c.Ebit),
                    //        Pbt = cl.Sum(c => c.Pbt)
                    //    })
                    //    .OrderBy(o => o.PalYear)
                    //    .ThenBy(t => t.Qt)
                    //    .ToList();
                    string result = String.Join(",", search.quater.ToArray());
                    PalList = tPalRepo.GetPalUnionCompany_NEW_Quater(new { quater_y_from = search.quater_y_from
                                                                                    ,quater_y_to = search.quater_y_to
                                                                                    ,quater = result}, result).ToList();
                }
                else if (search.level0 == Define.LEVEL.GetKey("부문"))
                {
                    PalList = PalUnionCompany
                        .Where(w => w.OrgUnionSeq == Convert.ToInt32(search.level1))
                        .Where(w => Convert.ToInt32(w.PalYear) >= Convert.ToInt32(search.quater_y_from))
                        .Where(w => Convert.ToInt32(w.PalYear) <= Convert.ToInt32(search.quater_y_to))
                        .Where(w => search.quater.Contains(w.Qt.ToString()))
                        .Where(w => w.MonthlyType == Define.MONTHLY_TYPE.GetKey("당월"))
                        .GroupBy(g => new { g.PalYear, g.Qt })
                        .Select(cl => new TrendPal
                        {
                            PalYear = cl.First().PalYear,
                            Qt = cl.First().Qt,
                            Sales = cl.Sum(c => c.Sales),
                            Ebit = cl.Sum(c => c.Ebit),
                            Pbt = cl.Sum(c => c.Pbt)
                        })
                        .OrderBy(o => o.PalYear)
                        .ThenBy(t => t.Qt)
                        .ToList();
                }
                else if (search.level0 == Define.LEVEL.GetKey("회사"))
                {
                    PalList = PalUnionCompany
                        .Where(w => w.OrgCompanySeq == Convert.ToInt32(search.level1))
                        .Where(w => Convert.ToInt32(w.PalYear) >= Convert.ToInt32(search.quater_y_from))
                        .Where(w => Convert.ToInt32(w.PalYear) <= Convert.ToInt32(search.quater_y_to))
                        .Where(w => search.quater.Contains(w.Qt.ToString()))
                        .Where(w => w.MonthlyType == Define.MONTHLY_TYPE.GetKey("당월"))
                        .GroupBy(g => new { g.PalYear, g.Qt })
                        .Select(cl => new TrendPal
                        {
                            PalYear = cl.First().PalYear,
                            Qt = cl.First().Qt,
                            Sales = cl.Sum(c => c.Sales),
                            Ebit = cl.Sum(c => c.Ebit),
                            Pbt = cl.Sum(c => c.Pbt)
                        })
                        .OrderBy(o => o.PalYear)
                        .ThenBy(t => t.Qt)
                        .ToList();
                }
                else if (search.level0 == Define.LEVEL.GetKey("BU"))
                {
                    PalList = PalBusiness
                        .Where(w => w.OrgBusinessSeq == Convert.ToInt32(search.level2))
                        .Where(w => Convert.ToInt32(w.PalYear) >= Convert.ToInt32(search.quater_y_from))
                        .Where(w => Convert.ToInt32(w.PalYear) <= Convert.ToInt32(search.quater_y_to))
                        .Where(w => search.quater.Contains(w.Qt.ToString()))
                        .Where(w => w.MonthlyType == Define.MONTHLY_TYPE.GetKey("당월"))
                        .GroupBy(g => new { g.PalYear, g.Qt })
                        .Select(cl => new TrendPal
                        {
                            PalYear = cl.First().PalYear,
                            Qt = cl.First().Qt,
                            Sales = cl.Sum(c => c.Sales),
                            Ebit = cl.Sum(c => c.Ebit),
                            Pbt = cl.Sum(c => c.Pbt)
                        })
                        .OrderBy(o => o.PalYear)
                        .ThenBy(t => t.Qt)
                        .ToList();
                }
            }
            else if (search.yearType == Define.YEAR_TYPE.GetKey("월(기간)"))
            {
                PalList = new List<TrendPal>();
                if (search.level0 == Define.LEVEL.GetKey("그룹"))
                {
                    //PalList = PalUnionCompany
                    //    .Where(w => Convert.ToInt32(w.PalYear + w.Monthly) >= Convert.ToInt32(search.month_period_y_from + search.month_period_m_from))
                    //    .Where(w => Convert.ToInt32(w.PalYear + w.Monthly) <= Convert.ToInt32(search.month_period_y_to + search.month_period_m_to))
                    //    .Where(w => w.MonthlyType == Define.MONTHLY_TYPE.GetKey("당월"))
                    //    .GroupBy(g => g.PalYear + g.Monthly)
                    //    .Select(cl => new TrendPal
                    //    {
                    //        PalYear = cl.First().PalYear,
                    //        Monthly = cl.First().Monthly,
                    //        Sales = cl.Sum(c => c.Sales),
                    //        Ebit = cl.Sum(c => c.Ebit),
                    //        Pbt = cl.Sum(c => c.Pbt)
                    //    })
                    //    .OrderBy(o => o.PalYear + o.Monthly)
                    //    .ToList();
                    PalList = tPalRepo.GetPalUnionCompany_NEW_Month(new { PREYEAR = search.month_period_y_from + search.month_period_m_from
                                                                                    ,ENDYEAR = search.month_period_y_to + search.month_period_m_to } ).ToList();
                }
                else if (search.level0 == Define.LEVEL.GetKey("부문"))
                {
                    PalList = PalUnionCompany
                        .Where(w => w.OrgUnionSeq == Convert.ToInt32(search.level1))
                        .Where(w => Convert.ToInt32(w.PalYear + w.Monthly) >= Convert.ToInt32(search.month_period_y_from + search.month_period_m_from))
                        .Where(w => Convert.ToInt32(w.PalYear + w.Monthly) <= Convert.ToInt32(search.month_period_y_to + search.month_period_m_to))
                        .Where(w => w.MonthlyType == Define.MONTHLY_TYPE.GetKey("당월"))
                        .GroupBy(g => g.PalYear + g.Monthly)
                        .Select(cl => new TrendPal
                        {
                            PalYear = cl.First().PalYear,
                            Monthly = cl.First().Monthly,
                            Sales = cl.Sum(c => c.Sales),
                            Ebit = cl.Sum(c => c.Ebit),
                            Pbt = cl.Sum(c => c.Pbt)
                        })
                        .OrderBy(o => o.PalYear + o.Monthly)
                        .ToList();
                }
                else if (search.level0 == Define.LEVEL.GetKey("회사"))
                {
                    PalList = PalUnionCompany
                        .Where(w => w.OrgCompanySeq == Convert.ToInt32(search.level1))
                        .Where(w => Convert.ToInt32(w.PalYear + w.Monthly) >= Convert.ToInt32(search.month_period_y_from + search.month_period_m_from))
                        .Where(w => Convert.ToInt32(w.PalYear + w.Monthly) <= Convert.ToInt32(search.month_period_y_to + search.month_period_m_to))
                        .Where(w => w.MonthlyType == Define.MONTHLY_TYPE.GetKey("당월"))
                        .GroupBy(g => g.PalYear + g.Monthly)
                        .Select(cl => new TrendPal
                        {
                            PalYear = cl.First().PalYear,
                            Monthly = cl.First().Monthly,
                            Sales = cl.Sum(c => c.Sales),
                            Ebit = cl.Sum(c => c.Ebit),
                            Pbt = cl.Sum(c => c.Pbt)
                        })
                        .OrderBy(o => o.PalYear + o.Monthly)
                        .ToList();
                }
                else if (search.level0 == Define.LEVEL.GetKey("BU"))
                {
                    PalList = PalBusiness
                        .Where(w => w.OrgBusinessSeq == Convert.ToInt32(search.level2))
                        .Where(w => Convert.ToInt32(w.PalYear + w.Monthly) >= Convert.ToInt32(search.month_period_y_from + search.month_period_m_from))
                        .Where(w => Convert.ToInt32(w.PalYear + w.Monthly) <= Convert.ToInt32(search.month_period_y_to + search.month_period_m_to))
                        .Where(w => w.MonthlyType == Define.MONTHLY_TYPE.GetKey("당월"))
                        /*.GroupBy(g => g.PalYear + g.Monthly)
                        .Select(cl => new TrendPal
                        {
                            PalYear = cl.First().PalYear,
                            Monthly = cl.First().Monthly,
                            Sales = cl.Sum(c => c.Sales),
                            Ebit = cl.Sum(c => c.Ebit),
                            Pbt = cl.Sum(c => c.Pbt)
                        })*/
                        .OrderBy(o => o.PalYear + o.Monthly)
                        .ToList();
                }
            }

            else if (search.yearType == Define.YEAR_TYPE.GetKey("월(선택)"))
            {
                PalList = new List<TrendPal>();
                if (search.level0 == Define.LEVEL.GetKey("그룹"))
                {
                    //PalList = PalUnionCompany
                    //    .Where(w => Convert.ToInt32(w.PalYear) >= Convert.ToInt32(search.month_select_y_from))
                    //    .Where(w => Convert.ToInt32(w.PalYear) <= Convert.ToInt32(search.month_select_y_to))
                    //    .Where(w => w.MonthlyType == Define.MONTHLY_TYPE.GetKey("당월"))
                    //    .Where(w => search.month_select_m.Contains(w.Monthly))
                    //    .GroupBy(g => g.PalYear + g.Monthly)
                    //    .Select(cl => new TrendPal
                    //    {
                    //        PalYear = cl.First().PalYear,
                    //        Monthly = cl.First().Monthly,
                    //        Sales = cl.Sum(c => c.Sales),
                    //        Ebit = cl.Sum(c => c.Ebit),
                    //        Pbt = cl.Sum(c => c.Pbt)
                    //    })
                    //    .OrderBy(o => o.PalYear + o.Monthly)
                    //    .ToList();
                    string result = String.Join(",", search.month_select_m.ToArray());
                    //LogUtil.ReportErrorLog(result.ToString() );
                    PalList = tPalRepo.GetPalUnionCompany_NEW_MonthChoice(new { PREYEAR = search.month_select_y_from
                                                                                    ,ENDYEAR = search.month_select_y_to } , result).ToList();
                }
                else if (search.level0 == Define.LEVEL.GetKey("부문"))
                {
                    PalList = PalUnionCompany
                        .Where(w => w.OrgUnionSeq == Convert.ToInt32(search.level1))
                        .Where(w => Convert.ToInt32(w.PalYear) >= Convert.ToInt32(search.month_select_y_from))
                        .Where(w => Convert.ToInt32(w.PalYear) <= Convert.ToInt32(search.month_select_y_to))
                        .Where(w => w.MonthlyType == Define.MONTHLY_TYPE.GetKey("당월"))
                        .Where(w => search.month_select_m.Contains(w.Monthly))
                        .GroupBy(g => g.PalYear + g.Monthly)
                        .Select(cl => new TrendPal
                        {
                            PalYear = cl.First().PalYear,
                            Monthly = cl.First().Monthly,
                            Sales = cl.Sum(c => c.Sales),
                            Ebit = cl.Sum(c => c.Ebit),
                            Pbt = cl.Sum(c => c.Pbt)
                        })
                        .OrderBy(o => o.PalYear + o.Monthly)
                        .ToList();
                }
                else if (search.level0 == Define.LEVEL.GetKey("회사"))
                {
                    PalList = PalUnionCompany
                        .Where(w => w.OrgCompanySeq == Convert.ToInt32(search.level1))
                        .Where(w => Convert.ToInt32(w.PalYear) >= Convert.ToInt32(search.month_select_y_from))
                        .Where(w => Convert.ToInt32(w.PalYear) <= Convert.ToInt32(search.month_select_y_to))
                        .Where(w => w.MonthlyType == Define.MONTHLY_TYPE.GetKey("당월"))
                        .Where(w => search.month_select_m.Contains(w.Monthly))
                        .GroupBy(g => g.PalYear + g.Monthly)
                        .Select(cl => new TrendPal
                        {
                            PalYear = cl.First().PalYear,
                            Monthly = cl.First().Monthly,
                            Sales = cl.Sum(c => c.Sales),
                            Ebit = cl.Sum(c => c.Ebit),
                            Pbt = cl.Sum(c => c.Pbt)
                        })
                        .OrderBy(o => o.PalYear + o.Monthly)
                        .ToList();
                }
                else if (search.level0 == Define.LEVEL.GetKey("BU"))
                {
                    PalList = PalBusiness
                        .Where(w => w.OrgBusinessSeq == Convert.ToInt32(search.level2))
                        .Where(w => Convert.ToInt32(w.PalYear) >= Convert.ToInt32(search.month_select_y_from))
                        .Where(w => Convert.ToInt32(w.PalYear) <= Convert.ToInt32(search.month_select_y_to))
                        .Where(w => w.MonthlyType == Define.MONTHLY_TYPE.GetKey("당월"))
                        .Where(w => search.month_select_m.Contains(w.Monthly))
                        /*.GroupBy(g => g.PalYear + g.Monthly)
                        .Select(cl => new TrendPal
                        {
                            PalYear = cl.First().PalYear,
                            Monthly = cl.First().Monthly,
                            Sales = cl.Sum(c => c.Sales),
                            Ebit = cl.Sum(c => c.Ebit),
                            Pbt = cl.Sum(c => c.Pbt)
                        })*/
                        .OrderBy(o => o.PalYear + o.Monthly)
                        .ToList();
                }
            }


            foreach (var item in PalList)
            {
                // 년도별 그래프 데이터
                Values sales = new Values();
                Values ebit = new Values();
                Values pbt = new Values();
                
                string xString = item.PalYear;

                if (search.yearType == Define.YEAR_TYPE.GetKey("분기"))
                {
                    xString = item.PalYear + "." + item.Qt.ToString() + "Q";
                }
                else if (search.yearType == Define.YEAR_TYPE.GetKey("월(기간)"))
                {
                    xString = item.PalYear + "." + item.Monthly;
                }
                else if (search.yearType == Define.YEAR_TYPE.GetKey("월(선택)"))
                {
                    xString = item.PalYear + "." + item.Monthly;
                }
                xString = "'" + xString.Substring(2); // 앞에 두자리 짜름

                sales.x = xString;
                sales.y = Math.Round(item.Sales, 0, MidpointRounding.AwayFromZero);
                salesList.Add(sales);

                ebit.x = xString;
                ebit.y = Math.Round(item.Ebit, 0, MidpointRounding.AwayFromZero);
                ebit.p = item.Sales == 0 ? 0 : Math.Round((item.Ebit / item.Sales) * 100, 1, MidpointRounding.AwayFromZero);
                //Math.Round(12, 324, 2, MidpointRounding.AwayFromZero);
                ebitList.Add(ebit);

                pbt.x = xString;
                pbt.y = Math.Round(item.Pbt, 0, MidpointRounding.AwayFromZero);
                pbtList.Add(pbt);
            }

            // 데이터 입력 완료 후 항목별로 취합
            var d = new KeyValues();
            d.key = "Sales";
            d.values = salesList;
            data1.Add(d);

            d = new KeyValues();
            d.key = "EBIT(%)";
            d.values = ebitList;
            data2.Add(d);

            d = new KeyValues();
            d.key = "PBT";
            d.values = pbtList;
            data2.Add(d);

            return Json(new { data1, data2 }, JsonRequestBehavior.AllowGet);
        }
    }
}