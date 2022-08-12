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
    [RoutePrefix("Trend_Analysis/Invest")]
    public class TrendInvestController : Controller
    {
        PageAuthRepo pageAuthRepo = new PageAuthRepo();
        TrendInvestRepo tInvestRepo = new TrendInvestRepo();
        MemberSession mSession = SessionManager.GetMemberSession();

        [SystemLoginFilter]
        [SystemAuthFilter(MenuAuth = 3)]
        [Route("Index")]
        public ActionResult Index()
        {
            return View("~/Views/Trend_Analysis/Invest/Index.cshtml");
        }

        [Route("InvestLevel")]
        public ActionResult InvestLevel()
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

        public static string GetYearTitle(string yearType, string year, string qt, string monthly)
        {
            string xString = year;
            
            if (yearType == Define.YEAR_TYPE.GetKey("분기"))
            {
                xString = year + "." + qt.ToString() + "Q";
            }
            else if (yearType == Define.YEAR_TYPE.GetKey("월(기간)"))
            {
                xString = year + "." + monthly;
            }
            else if (yearType == Define.YEAR_TYPE.GetKey("월(선택)"))
            {
                xString = year + "." + monthly;
            }
            xString = "'" + xString.Substring(2); // 앞에 두자리 짜름
            return xString;
        }

        [Route("InvestData")]
        public ActionResult InvestData(TrendSearch search)
        {
            List<TrendInvest> InvestUnionCompany = tInvestRepo.GetInvestUnionCompany(new { }).ToList();
            //List<TrendInvest> InvestUnionCompany = tInvestRepo.GetInvestUnionCompany_NEW(search).ToList();
            List<TrendInvest> InvestBusiness = tInvestRepo.GetInvestBusiness(new { }).ToList();

            // 그래프1
            List<KeyValues> data1 = new List<KeyValues>();
            List<Values> investList = new List<Values>();

            // 그래프2
            List<KeyValues> data2 = new List<KeyValues>();
            List<Values> personnelList = new List<Values>();

            // 테이블
            List<TrendDataTable> data5 = new List<TrendDataTable>();

            List<TrendInvest> InvestList = new List<TrendInvest>();

            // 2018.11.14 표에 데이터는 회사레벨까지만 표현한다. 국내인원, 해외인원만
            if (search.yearType == Define.YEAR_TYPE.GetKey("년도"))
            {
                InvestList = new List<TrendInvest>();
                if (search.level0 == Define.LEVEL.GetKey("그룹"))
                {
                    //InvestList = InvestUnionCompany
                    //    .Where(w => Convert.ToInt32(w.InvestYear) >= Convert.ToInt32(search.year_y_from))
                    //    .Where(w => Convert.ToInt32(w.InvestYear) <= Convert.ToInt32(search.year_y_to))
                    //    .Where(w => w.NoZ == 1)
                    //    .GroupBy(g => g.InvestYear)
                    //    .Select(cl => new TrendInvest
                    //    {
                    //        InvestYear = cl.First().InvestYear,
                    //        Investment = cl.Sum(c => c.Investment),
                    //        Personnel = cl.Sum(c => c.Personnel),
                    //        DomesticPersonnel = cl.Sum(c => c.DomesticPersonnel),
                    //        OverseasPersonnel = cl.Sum(c => c.OverseasPersonnel)
                    //    })
                    //    .OrderBy(o => o.InvestYear)
                    //    .ToList();

                   
                    InvestList = tInvestRepo.GetInvestUnionCompany_NEW(search).ToList();


                }
                else if (search.level0 == Define.LEVEL.GetKey("부문"))
                {
                    InvestList = InvestUnionCompany
                        .Where(w => w.OrgUnionSeq == Convert.ToInt32(search.level1))
                        .Where(w => Convert.ToInt32(w.InvestYear) >= Convert.ToInt32(search.year_y_from))
                        .Where(w => Convert.ToInt32(w.InvestYear) <= Convert.ToInt32(search.year_y_to))
                        .Where(w => w.NoZ == 1)
                        .GroupBy(g => g.InvestYear)
                        .Select(cl => new TrendInvest
                        {
                            InvestYear = cl.First().InvestYear,
                            Investment = cl.Sum(c => c.Investment),
                            Personnel = cl.Sum(c => c.Personnel),
                            DomesticPersonnel = cl.Sum(c => c.DomesticPersonnel),
                            OverseasPersonnel = cl.Sum(c => c.OverseasPersonnel)
                        })
                        .OrderBy(o => o.InvestYear)
                        .ToList();
                }
                else if (search.level0 == Define.LEVEL.GetKey("회사"))
                {
                    InvestList = InvestUnionCompany
                        .Where(w => w.OrgCompanySeq == Convert.ToInt32(search.level1))
                        .Where(w => Convert.ToInt32(w.InvestYear) >= Convert.ToInt32(search.year_y_from))
                        .Where(w => Convert.ToInt32(w.InvestYear) <= Convert.ToInt32(search.year_y_to))
                        .Where(w => w.NoZ == 1)
                        /*
                        .GroupBy(g => g.InvestYear)
                        .Select(cl => new TrendInvest
                        {
                            InvestYear = cl.First().InvestYear,
                            Investment = cl.Sum(c => c.Investment),
                            Personnel = cl.Sum(c => c.Personnel)
                        })
                        */
                        .OrderBy(o => o.InvestYear)
                        .ToList();
                }
                else if (search.level0 == Define.LEVEL.GetKey("BU"))
                {
                    InvestList = InvestBusiness
                        .Where(w => w.OrgBusinessSeq == Convert.ToInt32(search.level2))
                        .Where(w => Convert.ToInt32(w.InvestYear) >= Convert.ToInt32(search.year_y_from))
                        .Where(w => Convert.ToInt32(w.InvestYear) <= Convert.ToInt32(search.year_y_to))
                        .Where(w => w.NoZ == 1)
                        /*
                        .GroupBy(g => g.InvestYear)
                        .Select(cl => new TrendInvest
                        {
                            InvestYear = cl.First().InvestYear,
                            Investment = cl.Sum(c => c.Investment),
                            Personnel = cl.Sum(c => c.Personnel)
                        })
                        */
                        .OrderBy(o => o.InvestYear)
                        .ToList();
                }

            }
            else if (search.yearType == Define.YEAR_TYPE.GetKey("분기"))
            {
                InvestList = new List<TrendInvest>();
                if (search.level0 == Define.LEVEL.GetKey("그룹"))
                {
                    //InvestList = InvestUnionCompany
                    //    .Where(w => Convert.ToInt32(w.InvestYear) >= Convert.ToInt32(search.quater_y_from))
                    //    .Where(w => Convert.ToInt32(w.InvestYear) <= Convert.ToInt32(search.quater_y_to))
                    //    .Where(w => search.quater.Contains(w.Qt.ToString()))
                    //    .Where(w => w.MonthlyType == Define.MONTHLY_TYPE.GetKey("당월"))
                    //    .GroupBy(g => new { g.InvestYear, g.Qt })
                    //    .Select(cl => new TrendInvest
                    //    {
                    //        InvestYear = cl.First().InvestYear,
                    //        Qt = cl.First().Qt,
                    //        Investment = cl.Sum(c => c.Investment),
                    //        Personnel = cl.Sum(c => c.Personnel),
                    //        DomesticPersonnel = cl.Sum(c => c.DomesticPersonnel),
                    //        OverseasPersonnel = cl.Sum(c => c.OverseasPersonnel)
                    //    })
                    //    .OrderBy(o => o.InvestYear)
                    //    .ThenBy(t => t.Qt)
                    //    .ToList();

                    string result = String.Join(",", search.quater.ToArray());
                    //LogUtil.ReportErrorLog(result.ToString() + "quater_y_from =" + search.quater_y_from + " quater_y_to =" + search.quater_y_to);                       
                    InvestList = tInvestRepo.GetInvestUnionCompany_NEW_Quater(new { quater_y_from = search.quater_y_from
                                                                                    ,quater_y_to = search.quater_y_to
                                                                                    ,quater = result}, result).ToList();
                }
                else if (search.level0 == Define.LEVEL.GetKey("부문"))
                {
                    InvestList = InvestUnionCompany
                        .Where(w => w.OrgUnionSeq == Convert.ToInt32(search.level1))
                        .Where(w => Convert.ToInt32(w.InvestYear) >= Convert.ToInt32(search.quater_y_from))
                        .Where(w => Convert.ToInt32(w.InvestYear) <= Convert.ToInt32(search.quater_y_to))
                        .Where(w => search.quater.Contains(w.Qt.ToString()))
                        .Where(w => w.MonthlyType == Define.MONTHLY_TYPE.GetKey("당월"))
                        .GroupBy(g => new { g.InvestYear, g.Qt })
                        .Select(cl => new TrendInvest
                        {
                            InvestYear = cl.First().InvestYear,
                            Qt = cl.First().Qt,
                            Investment = cl.Sum(c => c.Investment),
                            Personnel = cl.Sum(c => c.Personnel),
                            DomesticPersonnel = cl.Sum(c => c.DomesticPersonnel),
                            OverseasPersonnel = cl.Sum(c => c.OverseasPersonnel)
                        })
                        .OrderBy(o => o.InvestYear)
                        .ThenBy(t => t.Qt)
                        .ToList();
                }
                else if (search.level0 == Define.LEVEL.GetKey("회사"))
                {
                    InvestList = InvestUnionCompany
                        .Where(w => w.OrgCompanySeq == Convert.ToInt32(search.level1))
                        .Where(w => Convert.ToInt32(w.InvestYear) >= Convert.ToInt32(search.quater_y_from))
                        .Where(w => Convert.ToInt32(w.InvestYear) <= Convert.ToInt32(search.quater_y_to))
                        .Where(w => search.quater.Contains(w.Qt.ToString()))
                        .Where(w => w.MonthlyType == Define.MONTHLY_TYPE.GetKey("당월"))
                        .GroupBy(g => new { g.InvestYear, g.Qt })
                        .Select(cl => new TrendInvest
                        {
                            InvestYear = cl.First().InvestYear,
                            Qt = cl.First().Qt,
                            Investment = cl.Sum(c => c.Investment),
                            Personnel = cl.Sum(c => c.Personnel),
                            DomesticPersonnel = cl.Sum(c => c.DomesticPersonnel),
                            OverseasPersonnel = cl.Sum(c => c.OverseasPersonnel)
                        })
                        .OrderBy(o => o.InvestYear)
                        .ThenBy(t => t.Qt)
                        .ToList();
                }
                else if (search.level0 == Define.LEVEL.GetKey("BU"))
                {
                    InvestList = InvestBusiness
                        .Where(w => w.OrgBusinessSeq == Convert.ToInt32(search.level2))
                        .Where(w => Convert.ToInt32(w.InvestYear) >= Convert.ToInt32(search.quater_y_from))
                        .Where(w => Convert.ToInt32(w.InvestYear) <= Convert.ToInt32(search.quater_y_to))
                        .Where(w => search.quater.Contains(w.Qt.ToString()))
                        .Where(w => w.MonthlyType == Define.MONTHLY_TYPE.GetKey("당월"))
                        .GroupBy(g => new { g.InvestYear, g.Qt })
                        .Select(cl => new TrendInvest
                        {
                            InvestYear = cl.First().InvestYear,
                            Qt = cl.First().Qt,
                            Investment = cl.Sum(c => c.Investment),
                            Personnel = cl.Sum(c => c.Personnel)
                        })
                        .OrderBy(o => o.InvestYear)
                        .ThenBy(t => t.Qt)
                        .ToList();
                }
            }
            else if (search.yearType == Define.YEAR_TYPE.GetKey("월(기간)"))
            {
                InvestList = new List<TrendInvest>();
                if (search.level0 == Define.LEVEL.GetKey("그룹"))
                {
                    //InvestList = InvestUnionCompany
                    //    .Where(w => Convert.ToInt32(w.InvestYear + w.Monthly) >= Convert.ToInt32(search.month_period_y_from + search.month_period_m_from))
                    //    .Where(w => Convert.ToInt32(w.InvestYear + w.Monthly) <= Convert.ToInt32(search.month_period_y_to + search.month_period_m_to))
                    //    .Where(w => w.MonthlyType == Define.MONTHLY_TYPE.GetKey("당월"))
                    //    .GroupBy(g => new { g.InvestYear, g.Monthly })
                    //    .Select(cl => new TrendInvest
                    //    {
                    //        InvestYear = cl.First().InvestYear,
                    //        Monthly = cl.First().Monthly,
                    //        Investment = cl.Sum(c => c.Investment),
                    //        Personnel = cl.Sum(c => c.Personnel),
                    //        DomesticPersonnel = cl.Sum(c => c.DomesticPersonnel),
                    //        OverseasPersonnel = cl.Sum(c => c.OverseasPersonnel)
                    //    })
                    //    .OrderBy(o => o.InvestYear)
                    //    .ThenBy(o => o.Monthly)
                    //    .ToList();
                    InvestList = tInvestRepo.GetInvestUnionCompany_NEW_Month(new { PREYEAR = search.month_period_y_from + search.month_period_m_from
                                                                                    ,ENDYEAR = search.month_period_y_to + search.month_period_m_to } ).ToList();
                }
                else if (search.level0 == Define.LEVEL.GetKey("부문"))
                {
                    InvestList = InvestUnionCompany
                        .Where(w => w.OrgUnionSeq == Convert.ToInt32(search.level1))
                        .Where(w => Convert.ToInt32(w.InvestYear + w.Monthly) >= Convert.ToInt32(search.month_period_y_from + search.month_period_m_from))
                        .Where(w => Convert.ToInt32(w.InvestYear + w.Monthly) <= Convert.ToInt32(search.month_period_y_to + search.month_period_m_to))
                        .Where(w => w.MonthlyType == Define.MONTHLY_TYPE.GetKey("당월"))
                        .GroupBy(g => new { g.InvestYear, g.Monthly })
                        .Select(cl => new TrendInvest
                        {
                            InvestYear = cl.First().InvestYear,
                            Monthly = cl.First().Monthly,
                            Investment = cl.Sum(c => c.Investment),
                            Personnel = cl.Sum(c => c.Personnel),
                            DomesticPersonnel = cl.Sum(c => c.DomesticPersonnel),
                            OverseasPersonnel = cl.Sum(c => c.OverseasPersonnel)
                        })
                        .OrderBy(o => o.InvestYear)
                        .ThenBy(o => o.Monthly)
                        .ToList();
                }
                else if (search.level0 == Define.LEVEL.GetKey("회사"))
                {
                    InvestList = InvestUnionCompany
                        .Where(w => w.OrgCompanySeq == Convert.ToInt32(search.level1))
                        .Where(w => Convert.ToInt32(w.InvestYear + w.Monthly) >= Convert.ToInt32(search.month_period_y_from + search.month_period_m_from))
                        .Where(w => Convert.ToInt32(w.InvestYear + w.Monthly) <= Convert.ToInt32(search.month_period_y_to + search.month_period_m_to))
                        .Where(w => w.MonthlyType == Define.MONTHLY_TYPE.GetKey("당월"))
                        /*
                        .GroupBy(g => new { g.InvestYear, g.Monthly })
                        .Select(cl => new TrendInvest
                        {
                            InvestYear = cl.First().InvestYear,
                            Monthly = cl.First().Monthly,
                            Investment = cl.Sum(c => c.Investment),
                            Personnel = cl.Sum(c => c.Personnel)
                        })
                        */
                        .OrderBy(o => o.InvestYear)
                        .ThenBy(o => o.Monthly)
                        .ToList();
                }
                else if (search.level0 == Define.LEVEL.GetKey("BU"))
                {
                    InvestList = InvestBusiness
                        .Where(w => w.OrgBusinessSeq == Convert.ToInt32(search.level2))
                        .Where(w => Convert.ToInt32(w.InvestYear + w.Monthly) >= Convert.ToInt32(search.month_period_y_from + search.month_period_m_from))
                        .Where(w => Convert.ToInt32(w.InvestYear + w.Monthly) <= Convert.ToInt32(search.month_period_y_to + search.month_period_m_to))
                        .Where(w => w.MonthlyType == Define.MONTHLY_TYPE.GetKey("당월"))
                        /*
                        .GroupBy(g => new { g.InvestYear, g.Monthly })
                        .Select(cl => new TrendInvest
                        {
                            InvestYear = cl.First().InvestYear,
                            Monthly = cl.First().Monthly,
                            Investment = cl.Sum(c => c.Investment),
                            Personnel = cl.Sum(c => c.Personnel)
                        })
                        */
                        .OrderBy(o => o.InvestYear)
                        .ThenBy(o => o.Monthly)
                        .ToList();
                }
            }
            else if (search.yearType == Define.YEAR_TYPE.GetKey("월(선택)"))
            {
                InvestList = new List<TrendInvest>();
                if (search.level0 == Define.LEVEL.GetKey("그룹"))
                {
                    //InvestList = InvestUnionCompany
                    //    .Where(w => Convert.ToInt32(w.InvestYear) >= Convert.ToInt32(search.month_select_y_from))
                    //    .Where(w => Convert.ToInt32(w.InvestYear) <= Convert.ToInt32(search.month_select_y_to))
                    //    .Where(w => search.month_select_m.Contains(w.Monthly))
                    //    .Where(w => w.MonthlyType == Define.MONTHLY_TYPE.GetKey("당월"))
                    //    .GroupBy(g => new { g.InvestYear, g.Monthly })
                    //    .Select(cl => new TrendInvest
                    //    {
                    //        InvestYear = cl.First().InvestYear,
                    //        Monthly = cl.First().Monthly,
                    //        Investment = cl.Sum(c => c.Investment),
                    //        Personnel = cl.Sum(c => c.Personnel),
                    //        DomesticPersonnel = cl.Sum(c => c.DomesticPersonnel),
                    //        OverseasPersonnel = cl.Sum(c => c.OverseasPersonnel)
                    //    })
                    //    .OrderBy(o => o.InvestYear)
                    //    .ThenBy(o => o.Monthly)
                    //    .ToList();
                    string result = String.Join(",", search.month_select_m.ToArray());
                    //LogUtil.ReportErrorLog(result.ToString() );
                    InvestList = tInvestRepo.GetInvestUnionCompany_NEW_MonthChoice(new { PREYEAR = search.month_select_y_from
                                                                                    ,ENDYEAR = search.month_select_y_to } , result).ToList();
                }
                else if (search.level0 == Define.LEVEL.GetKey("부문"))
                {
                    InvestList = InvestUnionCompany
                        .Where(w => w.OrgUnionSeq == Convert.ToInt32(search.level1))
                        .Where(w => Convert.ToInt32(w.InvestYear) >= Convert.ToInt32(search.month_select_y_from))
                        .Where(w => Convert.ToInt32(w.InvestYear) <= Convert.ToInt32(search.month_select_y_to))
                        .Where(w => search.month_select_m.Contains(w.Monthly))
                        .Where(w => w.MonthlyType == Define.MONTHLY_TYPE.GetKey("당월"))
                        .GroupBy(g => new { g.InvestYear, g.Monthly })
                        .Select(cl => new TrendInvest
                        {
                            InvestYear = cl.First().InvestYear,
                            Monthly = cl.First().Monthly,
                            Investment = cl.Sum(c => c.Investment),
                            Personnel = cl.Sum(c => c.Personnel),
                            DomesticPersonnel = cl.Sum(c => c.DomesticPersonnel),
                            OverseasPersonnel = cl.Sum(c => c.OverseasPersonnel)
                        })
                        .OrderBy(o => o.InvestYear)
                        .ThenBy(o => o.Monthly)
                        .ToList();
                }
                else if (search.level0 == Define.LEVEL.GetKey("회사"))
                {
                    InvestList = InvestUnionCompany
                        .Where(w => w.OrgCompanySeq == Convert.ToInt32(search.level1))
                        .Where(w => Convert.ToInt32(w.InvestYear) >= Convert.ToInt32(search.month_select_y_from))
                        .Where(w => Convert.ToInt32(w.InvestYear) <= Convert.ToInt32(search.month_select_y_to))
                        .Where(w => search.month_select_m.Contains(w.Monthly))
                        .Where(w => w.MonthlyType == Define.MONTHLY_TYPE.GetKey("당월"))
                        /*
                        .GroupBy(g => new { g.InvestYear, g.Monthly })
                        .Select(cl => new TrendInvest
                        {
                            InvestYear = cl.First().InvestYear,
                            Monthly = cl.First().Monthly,
                            Investment = cl.Sum(c => c.Investment),
                            Personnel = cl.Sum(c => c.Personnel)
                        })
                        */
                        .OrderBy(o => o.InvestYear)
                        .ThenBy(o => o.Monthly)
                        .ToList();
                }
                else if (search.level0 == Define.LEVEL.GetKey("BU"))
                {
                    InvestList = InvestBusiness
                        .Where(w => w.OrgBusinessSeq == Convert.ToInt32(search.level2))
                        .Where(w => Convert.ToInt32(w.InvestYear) >= Convert.ToInt32(search.month_select_y_from))
                        .Where(w => Convert.ToInt32(w.InvestYear) <= Convert.ToInt32(search.month_select_y_to))
                        .Where(w => search.month_select_m.Contains(w.Monthly))
                        .Where(w => w.MonthlyType == Define.MONTHLY_TYPE.GetKey("당월"))
                        /*
                        .GroupBy(g => new { g.InvestYear, g.Monthly })
                        .Select(cl => new TrendInvest
                        {
                            InvestYear = cl.First().InvestYear,
                            Monthly = cl.First().Monthly,
                            Investment = cl.Sum(c => c.Investment),
                            Personnel = cl.Sum(c => c.Personnel)
                        })
                        */
                        .OrderBy(o => o.InvestYear)
                        .ThenBy(o => o.Monthly)
                        .ToList();
                }
            }

            foreach (var item in InvestList)
            {
                Values invest = new Values();
                Values personnel = new Values();

                string xString = GetYearTitle(search.yearType, item.InvestYear, item.Qt.ToString(), item.Monthly);

                /*
                if (search.yearType == Define.YEAR_TYPE.GetKey("분기"))
                {
                    xString = item.InvestYear + "년 " + item.Qt.ToString() + "분기";
                }
                else if (search.yearType == Define.YEAR_TYPE.GetKey("월(기간)"))
                {
                    xString = item.InvestYear + "년 " + Convert.ToInt32(item.Monthly).ToString() + "월";
                }
                else if (search.yearType == Define.YEAR_TYPE.GetKey("월(선택)"))
                {
                    xString = item.InvestYear + "년 " + Convert.ToInt32(item.Monthly).ToString() + "월";
                }
                */

                invest.x = xString;
                invest.y = Math.Round(item.Investment, 0, MidpointRounding.AwayFromZero);
                investList.Add(invest);

                personnel.x = xString;
                personnel.y = Math.Round(item.Personnel, 0, MidpointRounding.AwayFromZero);
                personnelList.Add(personnel);

                TrendDataTable dt = new TrendDataTable();
                dt.year = xString;
                dt.a = Math.Round(item.DomesticPersonnel, 0, MidpointRounding.AwayFromZero).ToString();
                dt.b = Math.Round(item.OverseasPersonnel, 0, MidpointRounding.AwayFromZero).ToString();
                data5.Add(dt);
            }

            var d = new KeyValues();
            d.key = "투자";
            d.values = investList;
            data1.Add(d);

            d = new KeyValues();
            d.key = "인원";
            d.values = personnelList;
            data2.Add(d);

            return Json(new { data1, data2, data5}, JsonRequestBehavior.AllowGet);
        }
    }
}