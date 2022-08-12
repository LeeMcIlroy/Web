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

namespace HALLA_PM.Controllers
{
    [SystemLoginFilter]
    [SystemAuthFilter(OrgAuth = 0)]
    [RoutePrefix("Dis")]
    public class DisclosureController : Controller
    {
        GroupMainRepo groupMainRepo = new GroupMainRepo();
        GroupCompanyRepo groupCompanyRepo = new GroupCompanyRepo();
        RegistYearListRepo rYearListRepo = new RegistYearListRepo();

        [Route("DisclosureIndex")]
        public ActionResult DisclosureIndex(Search search)
        {
            List<RegistYearList> registYearPm = rYearListRepo.selectListDisclosure(new { }).ToList();

            var y = registYearPm
            .GroupBy(g => g.RegistYear)
            .Select(cl => new RegistYearList
            {
                RegistYear = cl.First().RegistYear
            }).ToList();

            if (string.IsNullOrWhiteSpace(search.year))
            {
                search.year = y.First().RegistYear;
            }

            var m = registYearPm.Where(w => w.RegistYear == search.year).ToList();

            if (string.IsNullOrWhiteSpace(search.mm))
            {
                search.mm = m.First().RegistMonth;
            }

            if (Convert.ToInt32(search.mm) > Convert.ToInt32(m.First().RegistMonth))
            {
                search.mm = m.First().RegistMonth;
            }

            var year = search.year;
            var preYear = int.Parse(search.year) - 1;
            var month = search.mm;

            dynamic model = new ExpandoObject();

        

            //지주부문/회사부문
            var groupMainDisclosure = groupMainRepo.groupMainDisclosure(new
            {
                Year = year,
                Month = month
            });

            var disclosureItem = groupMainRepo.groupMainDisclosureItem("");
            //공시 데이터
            var disclosureData = groupMainRepo.groupMainDisclosureData(new
            {
                Year = year,
                Month = month
            }); ;


            model.groupMainDisclosure = groupMainDisclosure;
            model.groupMainDisMenu = disclosureItem;
            model.groupMainDisData = disclosureData;

            model.registYearPm = registYearPm;
            ViewBag.search = search;
            return View("~/Views/Dis/DisclosureIndex.cshtml", model);
        }
       
        [Route("DisCompany")]
        public ActionResult DisCompany(Search search)
        {
            List<RegistYearList> registYearPm = rYearListRepo.selectListDisclosure(new { }).ToList();

            var y = registYearPm
            .GroupBy(g => g.RegistYear)
            .Select(cl => new RegistYearList
            {
                RegistYear = cl.First().RegistYear
            }).ToList();

            if (string.IsNullOrWhiteSpace(search.year))
            {
                search.year = y.First().RegistYear;
            }

            var m = registYearPm.Where(w => w.RegistYear == search.year).ToList();

            if (string.IsNullOrWhiteSpace(search.mm))
            {
                search.mm = m.First().RegistMonth;
            }

            if (Convert.ToInt32(search.mm) > Convert.ToInt32(m.Last().RegistMonth))
            {
                search.mm = m.First().RegistMonth;
            }

            var a = search.OrgCompanySeq;
            var CompanySeq = Request.QueryString["Seq"] ?? "1";

            search.OrgCompanySeq = int.Parse(CompanySeq);
            
            // 회사별 데이터
            var disclosureCompanyData = groupMainRepo.CompanyDisclosureData(new { Year = search.year,Seq = CompanySeq });
            // 회사명
            var selectCompanyName = groupCompanyRepo.selectCompanyName(new { Seq = CompanySeq });
            var year = search.year;
            var preYear = int.Parse(search.year) - 1;
            var month = search.mm;
            
            dynamic model = new ExpandoObject();

            var groupMainDisclosure = groupMainRepo.groupMainDisclosure(new
            {
                Year = year,
                Month = month
            });

            model.groupMainDisclosure = groupMainDisclosure;
            model.groupCompanyDisData = disclosureCompanyData;
            model.registYearPm = registYearPm;
            model.selectCompanyName = selectCompanyName;

            ViewBag.search = search;

            return View("~/Views/Dis/DisCompany.cshtml", model);
        }

        #region #.그룹메인 손익 잔여월

        /// <summary>
        /// 그룹메인 / 연간예상손익 / 잔여월 SALES - (계획, 실적)
        /// </summary>
        /// <param name="expectRestSalesList"></param>
        /// <returns>list</returns>
        public List<GroupMain> GroupMainExpectRestSalesList(IEnumerable<GroupMain> expectRestSalesList)
        {
            var list = new List<GroupMain>();
            var resultList = new List<GroupMain>();
            var count = 0;

            foreach (var item in expectRestSalesList)
            {
                var groupMain = new GroupMain();

                if (item.restSalesKind == Define.MONTHLY_TYPE.GetKey("연간"))
                {
                    groupMain.unionName = item.unionName;
                    groupMain.unionSeq = item.unionSeq;
                    groupMain.groupMainExpectPlanRestSales = item.groupMainExpectPlanSales;
                    groupMain.groupMainExpectResultRestSales = item.groupMainExpectResultSales;
                    groupMain.isUse = item.isUse;

                    resultList.Add(groupMain);
                }
                else if (item.restSalesKind == Define.MONTHLY_TYPE.GetKey("누계"))
                {
                    groupMain.unionName = item.unionName;
                    groupMain.unionSeq = item.unionSeq;
                    groupMain.groupMainExpectPlanRestSales = resultList[count].groupMainExpectPlanRestSales - item.groupMainExpectPlanSales;
                    // 2019.03.05 연간예상의 예상값이 0이면 0
                    groupMain.groupMainExpectResultRestSales = resultList[count].groupMainExpectResultRestSales == 0 ? 0 : resultList[count].groupMainExpectResultRestSales - item.groupMainExpectResultSales;
                    groupMain.isUse = item.isUse;

                    list.Add(groupMain);

                    count++;
                }

            }

            return list;
        }

        /// <summary>
        /// 그룹메인 / 연간예상손익 / 잔여월 SALES - (전년)
        /// </summary>
        /// <param name="expectRestSalesList"></param>
        /// <returns></returns>
        public List<GroupMain> GroupMainPreYearExpectRestSalesList(IEnumerable<GroupMain> expectRestSalesList)
        {
            var list = new List<GroupMain>();
            var resultList = new List<GroupMain>();
            var count = 0;

            foreach (var item in expectRestSalesList)
            {
                var groupMain = new GroupMain();

                if (item.restSalesKind == Define.MONTHLY_TYPE.GetKey("연간"))
                {
                    groupMain.unionName = item.unionName;
                    groupMain.unionSeq = item.unionSeq;
                    groupMain.groupMainExpectResultRestSales = item.groupMainExpectResultSales;
                    groupMain.isUse = item.isUse;

                    resultList.Add(groupMain);
                }
                else if (item.restSalesKind == Define.MONTHLY_TYPE.GetKey("누계"))
                {
                    groupMain.unionName = item.unionName;
                    groupMain.unionSeq = item.unionSeq;
                    groupMain.groupMainExpectResultRestSales = resultList[count].groupMainExpectResultRestSales - item.groupMainExpectResultSales;
                    groupMain.isUse = item.isUse;

                    list.Add(groupMain);

                    count++;
                }
            }

            return list;
        }

        /// <summary>
        /// 그룹메인 / 연간예상손익 / 잔여월 EBIT - (계획, 실적)
        /// </summary>
        /// <param name="expectRestEbitList">연간실적,누계실적</param>
        /// <returns></returns>
        public List<GroupMain> GroupMainExpectRestEbitList(IEnumerable<GroupMain> expectRestEbitList)
        {
            var list = new List<GroupMain>();
            var resultList = new List<GroupMain>();
            var count = 0;

            foreach (var item in expectRestEbitList)
            {
                var groupMain = new GroupMain();

                if (item.restSalesKind == Define.MONTHLY_TYPE.GetKey("연간"))
                {
                    groupMain.unionName = item.unionName;
                    groupMain.unionSeq = item.unionSeq;

                    groupMain.groupMainExpectPlanRestEbit = item.groupMainExpectYearPlanEbit;
                    groupMain.groupMainExpectResultRestEbit = item.groupMainExpectYearResultEbit;

                    groupMain.groupMainExpectPlanRestSales = item.groupMainExpectYearPlanSales;
                    groupMain.groupMainExpectResultRestSales = item.groupMainExpectYearResultSales;
                    groupMain.isUse = item.isUse;

                    resultList.Add(groupMain);
                }
                else if (item.restSalesKind == Define.MONTHLY_TYPE.GetKey("누계"))
                {
                    groupMain.unionName = item.unionName;
                    groupMain.unionSeq = item.unionSeq;

                    groupMain.groupMainExpectPlanRestEbit = resultList[count].groupMainExpectPlanRestEbit - item.groupMainExpectYearPlanEbit;
                    // 2019.03.05 연간예상의 예상값이 0이면 0
                    groupMain.groupMainExpectResultRestEbit = resultList[count].groupMainExpectResultRestEbit == 0 ? 0 : resultList[count].groupMainExpectResultRestEbit - item.groupMainExpectYearResultEbit;

                    groupMain.groupMainExpectPlanRestSales = resultList[count].groupMainExpectPlanRestSales - item.groupMainExpectYearPlanSales;
                    // 2019.03.05 연간예상의 예상값이 0이면 0
                    groupMain.groupMainExpectResultRestSales = resultList[count].groupMainExpectResultRestSales == 0 ? 0 : resultList[count].groupMainExpectResultRestSales - item.groupMainExpectYearResultSales;
                    groupMain.isUse = item.isUse;

                    list.Add(groupMain);

                    count++;
                }
            }

            return list;
        }

        /// <summary>
        /// 그룹메인 / 연간예상손익 / 잔여월 EBIT - (전년)
        /// </summary>
        /// <param name="expectRestSalesList"></param>
        /// <returns></returns>
        public List<GroupMain> GroupMainPreYearExpectRestEbitList(IEnumerable<GroupMain> expectRestSalesList)
        {
            var list = new List<GroupMain>();
            var resultList = new List<GroupMain>();
            var count = 0;

            foreach (var item in expectRestSalesList)
            {
                var groupMain = new GroupMain();

                if (item.restSalesKind == Define.MONTHLY_TYPE.GetKey("연간"))
                {
                    groupMain.unionName = item.unionName;
                    groupMain.unionSeq = item.unionSeq;
                    groupMain.groupMainExpectResultRestEbit = item.groupMainExpectResultEbit;
                    groupMain.groupMainExpectResultRestSales = item.groupMainExpectResultSales;
                    groupMain.isUse = item.isUse;

                    resultList.Add(groupMain);
                }
                else if (item.restSalesKind == Define.MONTHLY_TYPE.GetKey("누계"))
                {
                    groupMain.unionName = item.unionName;
                    groupMain.unionSeq = item.unionSeq;
                    groupMain.groupMainExpectResultRestEbit = resultList[count].groupMainExpectResultRestEbit - item.groupMainExpectResultEbit;
                    groupMain.groupMainExpectResultRestSales = resultList[count].groupMainExpectResultRestSales - item.groupMainExpectResultSales;
                    groupMain.isUse = item.isUse;

                    list.Add(groupMain);

                    count++;
                }
            }

            return list;
        }

        /// <summary>
        /// 그룹메인 / 연간예상손익 - Table
        /// </summary>
        /// <param name="expectRestSalesList"></param>
        /// <returns></returns>
        public List<GroupMain> GroupMainExpectRestTable(IEnumerable<GroupMain> expectRestSalesList)
        {
            var list = new List<GroupMain>();
            var resultList = new List<GroupMain>();
            var count = 0;

            foreach (var item in expectRestSalesList)
            {
                var groupMain = new GroupMain();

                if (item.restSalesKind == Define.MONTHLY_TYPE.GetKey("연간"))
                {
                    groupMain.unionName = item.unionName;

                    //계획
                    groupMain.groupMainExpectPlanRestSales = item.groupMainExpectPlanSales;
                    groupMain.groupMainExpectPlanRestEbit = item.groupMainExpectPlanEbit;

                    //실적
                    groupMain.groupMainExpectResultRestSales = item.groupMainExpectResultSales;
                    groupMain.groupMainExpectResultRestEbit = item.groupMainExpectResultEbit;

                    resultList.Add(groupMain);
                }
                else if (item.restSalesKind == Define.MONTHLY_TYPE.GetKey("누계"))
                {
                    groupMain.unionName = item.unionName;

                    //계획
                    groupMain.groupMainExpectPlanRestSales = resultList[count].groupMainExpectPlanRestSales - item.groupMainExpectPlanSales;
                    groupMain.groupMainExpectPlanRestEbit = resultList[count].groupMainExpectPlanRestEbit - item.groupMainExpectPlanEbit;

                    //실적
                    groupMain.groupMainExpectResultRestSales = resultList[count].groupMainExpectResultRestSales - item.groupMainExpectResultSales;
                    groupMain.groupMainExpectResultRestEbit = resultList[count].groupMainExpectResultRestEbit - item.groupMainExpectResultEbit;

                    list.Add(groupMain);

                    count++;
                }
            }

            return list;
        }

        #endregion

        #region #.회사 손익 잔여월

        public List<GroupCompany> companyExpectRestSalesList(IEnumerable<GroupCompany> expectRestSalesList)
        {
            var list = new List<GroupCompany>();
            var resultList = new List<GroupCompany>();
            var count = 0;

            foreach (var item in expectRestSalesList)
            {
                var groupCompany = new GroupCompany();

                if (item.restSalesKind == Define.MONTHLY_TYPE.GetKey("연간"))
                {
                    groupCompany.businessName = item.businessName;
                    groupCompany.businessSeq = item.businessSeq;

                    //Sales
                    groupCompany.companyExpectRestPlanSales = item.companyExpectPlanSales;
                    groupCompany.companyExpectRestResultSales = item.companyExpectResultSales;

                    //Ebit
                    groupCompany.companyExpectRestPlanEbit = item.companyExpectPlanEbit;
                    groupCompany.companyExpectRestResultEbit = item.companyExpectResultEbit;

                    resultList.Add(groupCompany);
                }
                else if (item.restSalesKind == Define.MONTHLY_TYPE.GetKey("누계"))
                {
                    groupCompany.businessName = item.businessName;
                    groupCompany.businessSeq = item.businessSeq;

                    //Sales
                    groupCompany.companyExpectRestPlanSales = resultList[count].companyExpectRestPlanSales - item.companyExpectPlanSales;
                    // 2019.03.05 연간예상의 예상값이 0이면 0
                    groupCompany.companyExpectRestResultSales = resultList[count].companyExpectRestResultSales == 0 ? 0 : resultList[count].companyExpectRestResultSales - item.companyExpectResultSales;

                    //Ebit
                    groupCompany.companyExpectRestPlanEbit = resultList[count].companyExpectRestPlanEbit - item.companyExpectPlanEbit;
                    // 2019.03.05 연간예상의 예상값이 0이면 0
                    groupCompany.companyExpectRestResultEbit = resultList[count].companyExpectRestResultEbit == 0 ? 0 : resultList[count].companyExpectRestResultEbit - item.companyExpectResultEbit;

                    list.Add(groupCompany);

                    count++;
                }
            }

            return list;
        }

        #endregion
    }
}