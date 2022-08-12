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
    [RoutePrefix("Org")]
    public class OrgController : Controller
    {
        GroupMainRepo groupMainRepo = new GroupMainRepo();
        GroupCompanyRepo groupCompanyRepo = new GroupCompanyRepo();
        RegistYearListRepo rYearListRepo = new RegistYearListRepo();
        PmBsSummaryRepo pmBsSummaryRepo = new PmBsSummaryRepo();
        PmPalSummaryRepo pmPalSummaryRepo = new PmPalSummaryRepo();

        [Route("NewIndex")]
        public ActionResult NewIndex(Search search)
        {
            List<RegistYearList> registYearPm = rYearListRepo.selectListPm(new { }).ToList();

            var y = registYearPm
            .GroupBy(g => g.RegistYear)
            .Select(cl => new RegistYearList
            {
                RegistYear = cl.First().RegistYear
            }).ToList();

            if (string.IsNullOrWhiteSpace(search.year))
            {
                search.year = y.Last().RegistYear;
            }

            var m = registYearPm.Where(w => w.RegistYear == search.year).ToList();

            if (string.IsNullOrWhiteSpace(search.mm))
            {
                search.mm = m.Last().RegistMonth;
            }

            if (Convert.ToInt32(search.mm) > Convert.ToInt32(m.Last().RegistMonth))
            {
                search.mm = m.Last().RegistMonth;
            }

            var year = search.year;
            var preYear = int.Parse(search.year) - 1;
            var month = search.mm;

            dynamic model = new ExpandoObject();

            #region #.Dash Board

            //FCF
            //var groupMainFCF = groupMainRepo.groupMainFCF(new
            //{
            //    Year = year,
            //    Month = month,
            //    Diff = Define.DIFF.GetKey("실적")
            //});
            var groupMainFCFexceptCpn = groupMainRepo.groupMainFCFexcept(new
            {
                Year = year,
                Month = month,
                Diff = Define.DIFF.GetKey("실적")
            });
            var groupMainFCF = (int.Parse(year) > 2018) ? groupMainRepo.groupMainFCF_NEW(new
            {
                Year = year,
                Month = month,
                Diff = Define.DIFF.GetKey("실적")
            }) : groupMainRepo.groupMainFCF(new
            {
                Year = year,
                Month = month,
                Diff = Define.DIFF.GetKey("실적")
            });

            ////SALES(당월,누계)
            //var groupMainSalesList = groupMainRepo.groupMainSales(new
            //{
            //    Year = year,
            //    Month = month,
            //    MonthlyTypeFirst = Define.MONTHLY_TYPE.GetKey("당월"),
            //    MonthlyTypeSecond = Define.MONTHLY_TYPE.GetKey("누계")
            //});

            //SALES(당월,누계)
            var groupMainSalesList = (int.Parse(year) > 2018) ?  groupMainRepo.groupMainSales_NEW(new
            {
                Year = year,
                Month = month,
                MonthlyTypeFirst = Define.MONTHLY_TYPE.GetKey("당월"),
                MonthlyTypeSecond = Define.MONTHLY_TYPE.GetKey("누계")
            }): groupMainRepo.groupMainSales(new
            {
                Year = year,
                Month = month,
                MonthlyTypeFirst = Define.MONTHLY_TYPE.GetKey("당월"),
                MonthlyTypeSecond = Define.MONTHLY_TYPE.GetKey("누계")
            });
            //2022-07-11 추가  SALES(당월,누계 salesCr)

            var pmMonthlyCr = groupMainRepo.groupMainSalesCr(new
            {
                Year = year,
                Month = month,
                MonthlyType = Define.MONTHLY_TYPE.GetKey("누계")
            });
            ////EBIT(당월,누계)
            //var groupMainEbitList = groupMainRepo.groupMainEbit(new
            //{
            //    Year = year,
            //    Month = month,
            //    MonthlyTypeFirst = Define.MONTHLY_TYPE.GetKey("당월"),
            //    MonthlyTypeSecond = Define.MONTHLY_TYPE.GetKey("누계")
            //});

            //EBIT(당월,누계)
            var groupMainEbitList = (int.Parse(year) > 2018) ?  groupMainRepo.groupMainEbit_NEW(new
            {
                Year = year,
                Month = month,
                MonthlyTypeFirst = Define.MONTHLY_TYPE.GetKey("당월"),
                MonthlyTypeSecond = Define.MONTHLY_TYPE.GetKey("누계")
            }): groupMainRepo.groupMainEbit(new
            {
                Year = year,
                Month = month,
                MonthlyTypeFirst = Define.MONTHLY_TYPE.GetKey("당월"),
                MonthlyTypeSecond = Define.MONTHLY_TYPE.GetKey("누계")
            }); 

            //PBT(당월,누계)
            var groupMainPbtList = groupMainRepo.groupMainPbt_NEW(new
            {
                Year = year,
                Month = month,
                MonthlyTypeFirst = Define.MONTHLY_TYPE.GetKey("당월"),
                MonthlyTypeSecond = Define.MONTHLY_TYPE.GetKey("누계")
            }).ToList();

            //ROIC(누계)
            //var groupMainRoic = groupMainRepo.groupMainRoic(new
            //{
            //    Year = year,
            //    Month = month
            //});

            //ROIC(누계)
            var groupMainRoic = (int.Parse(year) > 2018) ? groupMainRepo.groupMainRoic_NEW(new
            {
                Year = year,
                Month = month
            }): groupMainRepo.groupMainRoic(new
            {
                Year = year,
                Month = month
            }); 

            model.groupMainFCF = groupMainFCF;
            model.groupMainSalesList = groupMainSalesList;
            model.groupMainEbitList = groupMainEbitList;
            model.groupMainPbtList = groupMainPbtList;
            model.groupMainRoic = groupMainRoic;
            model.groupMainFCFExcept = groupMainFCFexceptCpn;
            model.groupPmMonthlyCr = pmMonthlyCr;

            #endregion

            #region #.KPI Signal

            //회사 정보
            var groupMainKpiSignalGroup = groupMainRepo.groupMainKpiSignalGroup(new
            {
                Diff = Define.DIFF.GetKey("실적"),
                Year = year,
                Month = month
            });

            //FCF
            var groupMainKpiSignalFCF = groupMainRepo.groupMainKpiSignalFCF(new
            {
                Diff = Define.DIFF.GetKey("실적"),
                Year = year,
                Month = month
            });

            //매출, EBIT, PBT (당월, 매출)
            var groupMainKpiSignal = groupMainRepo.groupMainKpiSignal(new
            {
                Year = year,
                Month = month,
                MonthlyTypeFirst = Define.MONTHLY_TYPE.GetKey("당월"),
                MonthlyTypeSecond = Define.MONTHLY_TYPE.GetKey("누계")
            });

            //부채비율 : 2019.03.27 ROIC 추가
            var kpiSignalLiabilitiesRate = groupMainRepo.groupMainKpiSignalLiabilities(new
            {
                Year = year,
                Month = month
            });

            // 

            //model.KpiSignalGroup = groupMainKpiSignalGroup;

            model.KpiSignalFCF = groupMainKpiSignalFCF;
            model.KpiSignal = groupMainKpiSignal;
            model.kpiSignalLiabilitiesRate = kpiSignalLiabilitiesRate;

            #endregion

            #region #.손익 목표 달성 현황(KPI X-Y Graph)

            var groupMainKpiGraph = groupMainRepo.groupMainKpiGraph(new
            {
                Year = year,
                Month = month,
                MonthlyType = Define.MONTHLY_TYPE.GetKey("누계"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            });

            model.KpiGraph = groupMainKpiGraph;

            #endregion

            #region #.CashFlow

            //var groupMainPlanCashFlow = groupMainRepo.groupMainPlanCashFlow(new
            //{
            //    Cumulative = Define.CUMULATIVE.GetKey("당월 실적"),
            //    Diff = Define.DIFF.GetKey("계획"),
            //    RegistStatus = Define.REGIST_STATUS.GetKey("최종승인"),
            //    Year = year,
            //    Month = month
            //});

            //var groupMainResultCashFlow = groupMainRepo.groupMainResultCashFlow(new
            //{
            //    Cumulative = Define.CUMULATIVE.GetKey("누계 실적"),
            //    Diff = Define.DIFF.GetKey("실적"),
            //    RegistStatus = Define.REGIST_STATUS.GetKey("최종승인"),
            //    Year = year,
            //    Month = month
            //});

            var groupMainPlanCashFlow = (int.Parse(year) > 2018) ? groupMainRepo.groupMainPlanCashFlow_NEW(new
            {
                Cumulative = Define.CUMULATIVE.GetKey("당월 실적"),
                Diff = Define.DIFF.GetKey("계획"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인"),
                Year = year,
                Month = month
            }): groupMainRepo.groupMainPlanCashFlow(new
            {
                Cumulative = Define.CUMULATIVE.GetKey("당월 실적"),
                Diff = Define.DIFF.GetKey("계획"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인"),
                Year = year,
                Month = month
            });

            var groupMainResultCashFlow = (int.Parse(year) > 2018) ? groupMainRepo.groupMainResultCashFlow_NEW(new
            {
                Cumulative = Define.CUMULATIVE.GetKey("누계 실적"),
                Diff = Define.DIFF.GetKey("실적"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인"),
                Year = year,
                Month = month
            }): groupMainRepo.groupMainResultCashFlow(new
            {
                Cumulative = Define.CUMULATIVE.GetKey("누계 실적"),
                Diff = Define.DIFF.GetKey("실적"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인"),
                Year = year,
                Month = month
            }); 


            model.cashFlowResult = groupMainResultCashFlow;
            model.CashFlowPlan = groupMainPlanCashFlow;

            #endregion

            #region #.당월/누계손익

            //당월/누계손익 (당월 - SALES)
            //var salesCalcList = groupMainRepo.groupMainSalesCalc(new
            //{
            //    Year = year,
            //    Month = month,
            //    MonthlyType = Define.MONTHLY_TYPE.GetKey("당월"),
            //    RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            //});
            //당월/누계손익 (당월 - SALES)
            var salesCalcList = (int.Parse(year) > 2018) ? groupMainRepo.groupMainSalesCalc_NEW(new
            {
                Year = year,
                Month = month,
                MonthlyType = Define.MONTHLY_TYPE.GetKey("당월"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            }): groupMainRepo.groupMainSalesCalc(new
            {
                Year = year,
                Month = month,
                MonthlyType = Define.MONTHLY_TYPE.GetKey("당월"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            }); 

            //당월/누계손익 (당월전년 - SALES)
            var preYearSalesCalcList = groupMainRepo.groupMainSalesCalc(new
            {
                Year = preYear,
                Month = month,
                MonthlyType = Define.MONTHLY_TYPE.GetKey("당월"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            });

            //당월/누계손익 SALES 당월 서브차트
            var groupMainSubSalesCalc = groupMainRepo.groupMainSubSalesCalc(new
            {
                Year = year,
                Month = month,
                MonthlyType = Define.MONTHLY_TYPE.GetKey("당월"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            });

            ////당월/누계손익 (당월 - EBIT)
            //var ebitCalcList = groupMainRepo.groupMainEbitCalc(new
            //{
            //    Year = year,
            //    Month = month,
            //    MonthlyType = Define.MONTHLY_TYPE.GetKey("당월"),
            //    RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            //});

            //당월/누계손익 (당월 - EBIT)
            var ebitCalcList = (int.Parse(year) > 2018) ? groupMainRepo.groupMainEbitCalc_NEW(new
            {
                Year = year,
                Month = month,
                MonthlyType = Define.MONTHLY_TYPE.GetKey("당월"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            }): groupMainRepo.groupMainEbitCalc(new
            {
                Year = year,
                Month = month,
                MonthlyType = Define.MONTHLY_TYPE.GetKey("당월"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            });

            //당월/누계손익 (당월전년 - EBIT)
            var preYearEbitCalcList = groupMainRepo.groupMainEbitCalc(new
            {
                Year = preYear,
                Month = month,
                MonthlyType = Define.MONTHLY_TYPE.GetKey("당월"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            });

            //당월/누계손익 EBIT 당월 서브차트
            var groupMainSubEbitCalc = groupMainRepo.groupMainSubEbitCalc(new
            {
                Year = year,
                Month = month,
                MonthlyType = Define.MONTHLY_TYPE.GetKey("당월"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            });

            model.salesCalcList = salesCalcList;
            model.preYearSalesCalcList = preYearSalesCalcList;

            model.salesCalcSubChart = groupMainSubSalesCalc;

            model.ebitCalcList = ebitCalcList;
            model.preYearEbitCalcList = preYearEbitCalcList;

            model.ebitCalcSubChart = groupMainSubEbitCalc;

            ////당월/누계손익 (누계 - SALES)
            //var SalesSumCalc = groupMainRepo.groupMainSalesSumCalc(new
            //{
            //    Year = year,
            //    Month = month,
            //    MonthlyType = Define.MONTHLY_TYPE.GetKey("누계"),
            //    RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            //});

            //당월/누계손익 (누계 - SALES)
            var SalesSumCalc = (int.Parse(year) > 2018) ? groupMainRepo.groupMainSalesSumCalc_NEW(new
            {
                Year = year,
                Month = month,
                MonthlyType = Define.MONTHLY_TYPE.GetKey("누계"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            }): groupMainRepo.groupMainSalesSumCalc(new
            {
                Year = year,
                Month = month,
                MonthlyType = Define.MONTHLY_TYPE.GetKey("누계"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            }); 

            //당월/누계손익 (누계 - SALES)
            var preYearSalesSumCalc = groupMainRepo.groupMainSalesSumCalc(new
            {
                Year = preYear,
                Month = month,
                MonthlyType = Define.MONTHLY_TYPE.GetKey("누계"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            });

            //당월/누계손익 SALES 누계 서브차트
            var groupMainSubSalesSumCalc = groupMainRepo.groupMainSubSalesSumCalc(new
            {
                Year = year,
                Month = month,
                MonthlyType = Define.MONTHLY_TYPE.GetKey("누계"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            });

            ////당월/누계손익 (누계 - EBIT)
            //var ebitSumCalc = groupMainRepo.groupMainEbitSumCalc(new
            //{
            //    Year = year,
            //    Month = month,
            //    MonthlyType = Define.MONTHLY_TYPE.GetKey("누계"),
            //    RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            //});


            //당월/누계손익 (누계 - EBIT)
            var ebitSumCalc = (int.Parse(year) > 2018) ? groupMainRepo.groupMainEbitSumCalc_NEW(new
            {
                Year = year,
                Month = month,
                MonthlyType = Define.MONTHLY_TYPE.GetKey("누계"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            }): groupMainRepo.groupMainEbitSumCalc(new
            {
                Year = year,
                Month = month,
                MonthlyType = Define.MONTHLY_TYPE.GetKey("누계"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            });

            //당월/누계손익 (누계 - EBIT)
            var preYearEbitSumCalc = groupMainRepo.groupMainEbitSumCalc(new
            {
                Year = preYear,
                Month = month,
                MonthlyType = Define.MONTHLY_TYPE.GetKey("누계"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            });

            //당월/누계손익 SALES 누계 서브차트
            var groupMainSubEbitSumCalc = groupMainRepo.groupMainSubEbitSumCalc(new
            {
                Year = year,
                Month = month,
                MonthlyType = Define.MONTHLY_TYPE.GetKey("누계"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            });

            model.SalesSumCalcList = SalesSumCalc;
            model.preYearSalesSumCalcList = preYearSalesSumCalc;

            model.salesSumCalcSubChart = groupMainSubSalesSumCalc;

            model.EbitSumCalcList = ebitSumCalc;
            model.preYearEbitSumCalcList = preYearEbitSumCalc;

            model.ebitSumCalcSubChart = groupMainSubEbitSumCalc;

            #endregion

            #region #.연간예상손익

            ////연간 예상 손익 - Sales누계실적(계획, 실적)
            //var groupMainExpectSales = groupMainRepo.groupMainExpectSales(new
            //{
            //    Year = year,
            //    Month = month,
            //    MonthlyType = Define.MONTHLY_TYPE.GetKey("누계"),
            //    RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            //});

            //연간 예상 손익 - Sales누계실적(계획, 실적)
            var groupMainExpectSales = (int.Parse(year) > 2018) ? groupMainRepo.groupMainExpectSales_NEW(new
            {
                Year = year,
                Month = month,
                MonthlyType = Define.MONTHLY_TYPE.GetKey("누계"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            }): groupMainRepo.groupMainExpectSales(new
            {
                Year = year,
                Month = month,
                MonthlyType = Define.MONTHLY_TYPE.GetKey("누계"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            });

            //연간 예상 손익 - Sales누계실적(전년)
            var preYearExpectSales = groupMainRepo.groupMainPreYearExpectSales(new
            {
                Year = preYear,
                Month = month,
                MonthlyType = Define.MONTHLY_TYPE.GetKey("누계"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            });

            ////연간 예상 손익 - Sales연간예상(계획, 실적)
            //var groupMainExpectYearSales = groupMainRepo.groupMainExpectYearSales(new
            //{
            //    Year = year,
            //    Month = month,
            //    MonthlyType = Define.MONTHLY_TYPE.GetKey("연간"),
            //    RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            //});

            //연간 예상 손익 - Sales연간예상(계획, 실적)
            var groupMainExpectYearSales = (int.Parse(year) > 2018) ?  groupMainRepo.groupMainExpectYearSales_NEW(new
            {
                Year = year,
                Month = month,
                MonthlyType = Define.MONTHLY_TYPE.GetKey("연간"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            }): groupMainRepo.groupMainExpectYearSales(new
            {
                Year = year,
                Month = month,
                MonthlyType = Define.MONTHLY_TYPE.GetKey("연간"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            });

            //연간 예상 손익 - Sales연간예상(전년)
            var groupMainPreYearExpectYearSales = groupMainRepo.groupMainPreYearExpectYearSales(new
            {
                Year = preYear,
                MonthlyType = Define.MONTHLY_TYPE.GetKey("누계"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            });

            //연간 예상 손익 - Sales잔여월(계획, 실적)
            var expectRestSalesList = groupMainRepo.groupMainExpectRestSales(new
            {
                Year = year,
                Month = month,
                MonthlyTypeFirst = Define.MONTHLY_TYPE.GetKey("연간"),
                MonthlyTypeSecond = Define.MONTHLY_TYPE.GetKey("누계"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            });
            //연간 예상 손익 - Sales잔여월(계획, 실적)
            var groupMainExpectRestSales = GroupMainExpectRestSalesList(expectRestSalesList);

            //연간 예상 손익 - Sales잔여월(전년)
            var groupMainPreYearExpectRestSales = groupMainRepo.groupMainPreYearExpectRestSales(new
            {
                Year = preYear,
                Month = month,
                MonthlyTypeFirst = Define.MONTHLY_TYPE.GetKey("누계"),
                MonthlyTypeSecond = Define.MONTHLY_TYPE.GetKey("누계"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            });
            //연간 예상 손익 - Sales잔여월(전년)
            var preYearExpectRestSales = GroupMainPreYearExpectRestSalesList(groupMainPreYearExpectRestSales);

            model.expectSalesList = groupMainExpectSales;
            model.preYearExpectSalesList = preYearExpectSales;

            model.expectYearSalesList = groupMainExpectYearSales;
            model.preYearExpectYearSalesList = groupMainPreYearExpectYearSales;

            model.expectRestSalesList = groupMainExpectRestSales;
            model.preYearExpectRestSalesList = preYearExpectRestSales;

            ////연간 예상 손익 - Ebit누계실적(계획, 실적)
            //var groupMainExpectEbit = groupMainRepo.groupMainExpectEbit(new
            //{
            //    Year = year,
            //    Month = month,
            //    MonthlyType = Define.MONTHLY_TYPE.GetKey("누계"),
            //    RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            //});

            //연간 예상 손익 - Ebit누계실적(계획, 실적)
            var groupMainExpectEbit = (int.Parse(year) > 2018) ? groupMainRepo.groupMainExpectEbit_NEW(new
            {
                Year = year,
                Month = month,
                MonthlyType = Define.MONTHLY_TYPE.GetKey("누계"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            }): groupMainRepo.groupMainExpectEbit(new
            {
                Year = year,
                Month = month,
                MonthlyType = Define.MONTHLY_TYPE.GetKey("누계"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            });

            //연간 예상 손익 - Ebit누계실적(전년)
            var preYearExpectEbit = groupMainRepo.groupMainPreYearExpectEbit(new
            {
                Year = preYear,
                Month = month,
                MonthlyType = Define.MONTHLY_TYPE.GetKey("누계"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            });

            ////연간 예상 손익 - Ebit연간예상(계획, 실적)
            //var groupMainExpectYearEbit = groupMainRepo.groupMainExpectYearEbit(new
            //{
            //    Year = year,
            //    Month = month,
            //    MonthlyType = Define.MONTHLY_TYPE.GetKey("연간"),
            //    RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            //});

            //연간 예상 손익 - Ebit연간예상(계획, 실적)
            var groupMainExpectYearEbit = (int.Parse(year) > 2018) ? groupMainRepo.groupMainExpectYearEbit_NEW(new
            {
                Year = year,
                Month = month,
                MonthlyType = Define.MONTHLY_TYPE.GetKey("연간"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            }): groupMainRepo.groupMainExpectYearEbit(new
            {
                Year = year,
                Month = month,
                MonthlyType = Define.MONTHLY_TYPE.GetKey("연간"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            });

            //연간 예상 손익 - Ebit연간예상(전년)
            var preYearExpectYearEbit = groupMainRepo.groupMainPreYearExpectYearEbit(new
            {
                Year = preYear,
                MonthlyType = Define.MONTHLY_TYPE.GetKey("누계"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            });

            //연간 예상 손익 - Ebit잔여월(계획, 실적) 
            var expectRestEbit = groupMainRepo.groupMainExpectRestEbit(new
            {
                Year = year,
                Month = month,
                MonthlyTypeFirst = Define.MONTHLY_TYPE.GetKey("연간"),
                MonthlyTypeSecond = Define.MONTHLY_TYPE.GetKey("누계"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            });
            //연간 예상 손익 - Ebit잔여월 Result(계획, 실적)
            var groupMainExpectRestEbit = GroupMainExpectRestEbitList(expectRestEbit);

            //연간 예상 손익 - Ebit잔여월(전년)
            var preYearExpectRestEbit = groupMainRepo.groupMainPreYearExpectRestEbit(new
            {
                Year = preYear,
                Month = month,
                MonthlyTypeFirst = Define.MONTHLY_TYPE.GetKey("누계"),
                MonthlyTypeSecond = Define.MONTHLY_TYPE.GetKey("누계"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            });

            //연간 예상 손익 - Ebit잔여월 Result(전년)
            var groupMainPreYearExpectRestEbit = GroupMainPreYearExpectRestEbitList(preYearExpectRestEbit);

            //연간 예상 손익 - Tablehead연간예상
            var groupMainExpectYearHeadTable = groupMainRepo.groupMainExpectYearHeadTable(new
            {
                Year = year,
                Month = month,
                MonthlyType = Define.MONTHLY_TYPE.GetKey("연간"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            });
            //연간 예상 손익 - TableBody연간예상
            var groupMainExpectYearBodyTable = groupMainRepo.groupMainExpectYearBodyTable(new
            {
                Year = year,
                Month = month,
                MonthlyType = Define.MONTHLY_TYPE.GetKey("연간"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            });

            //연간 예상 손익 - TableBody잔여월
            var groupMainExpectYearTable = groupMainRepo.groupMainExpectYearTable(new
            {
                Year = year,
                Month = month,
                MonthlyTypeFirst = Define.MONTHLY_TYPE.GetKey("연간"),
                MonthlyTypeSecond = Define.MONTHLY_TYPE.GetKey("누계"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            });

            //연간 예상 손익 - TableBody잔여월
            var expectYearRestBodyTable = GroupMainExpectRestTable(groupMainExpectYearTable);

            model.expectEbitList = groupMainExpectEbit;
            model.preYearExpectEbitList = preYearExpectEbit;

            model.expectYearEbitList = groupMainExpectYearEbit;
            model.preYearExpectYearEbitList = preYearExpectYearEbit;

            model.expectRestEbitList = groupMainExpectRestEbit;
            model.preYearExpectRestEbit = groupMainPreYearExpectRestEbit;


            model.expectYearHeadTable = groupMainExpectYearHeadTable;
            model.expectYearRestBodyTable = expectYearRestBodyTable;
            model.expectYearBodyTable = groupMainExpectYearBodyTable;

            #endregion

            #region #.ROIC

            //var groupMainPlanRoic = groupMainRepo.groupMainPlanRoic(new
            //{
            //    StartDate = preYear + "12",
            //    EndDate = year + "12",
            //    RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            //});

            var groupMainPlanRoic = (int.Parse(year) > 2018) ? groupMainRepo.groupMainPlanRoic_NEW(new
            {
                //StartDate = preYear + "12",
                //EndDate = year + "12",
                StartYear = preYear ,
                EndYear = year,
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            }): groupMainRepo.groupMainPlanRoic(new
            {
                StartDate = preYear + "12",
                EndDate = year + "12",
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            });

            //var groupMainResultRoic = groupMainRepo.groupMainResultRoic(new
            //{
            //    StartDate = preYear + "12",
            //    EndDate = year + "12",
            //    RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            //});
            var groupMainResultRoic = (int.Parse(year) > 2018) ? groupMainRepo.groupMainResultRoic_NEW(new
            {
                //StartDate = preYear + "12",
                //EndDate = year + "12",
                StartYear = preYear,
                EndYear = year,
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            }): groupMainRepo.groupMainResultRoic(new
            {
                StartDate = preYear + "12",
                EndDate = year + "12",
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            });

            model.groupMainPlanRoic = groupMainPlanRoic;
            model.groupMainResultRoic = groupMainResultRoic;

            #endregion

            #region #.투자/인원

            ////누계 - 계획
            //var investPlanPieChart = groupMainRepo.investPlanPieChart(new
            //{
            //    Yearly = year,
            //    Monthly = month,
            //    RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            //});

            //누계 - 계획
            var investPlanPieChart = (int.Parse(year) > 2018) ? groupMainRepo.investPlanPieChart_NEW(new
            {
                Yearly = year,
                Monthly = month,
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            }): groupMainRepo.investPlanPieChart(new
            {
                Yearly = year,
                Monthly = month,
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            });

            ////누계 - 실적
            //var investResultPieChart = groupMainRepo.investResultPieChart(new
            //{
            //    Yearly = year,
            //    Monthly = month,
            //    MonthlyType = Define.MONTHLY_TYPE.GetKey("누계"),
            //    RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            //});


            //누계 - 실적
            var investResultPieChart = (int.Parse(year) > 2018) ? groupMainRepo.investResultPieChart_NEW(new
            {
                Yearly = year,
                Monthly = month,
                MonthlyType = Define.MONTHLY_TYPE.GetKey("누계"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            }): groupMainRepo.investResultPieChart(new
            {
                Yearly = year,
                Monthly = month,
                MonthlyType = Define.MONTHLY_TYPE.GetKey("누계"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            });

            ////연간 - 계획
            //var investYearPlanPieChart = groupMainRepo.investYearPlanPieChart(new
            //{
            //    Yearly = year,
            //    RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            //});

            //연간 - 계획
            var investYearPlanPieChart = (int.Parse(year) > 2018) ? groupMainRepo.investYearPlanPieChart_NEW(new
            {
                Yearly = year,
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            }): groupMainRepo.investYearPlanPieChart(new
            {
                Yearly = year,
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            });

            ////연간 - 실적 : 실적은 타입 연간이 아니라 누계를 가져와야한다.
            //var investYearResultPieChart = groupMainRepo.investYearResultPieChart(new
            //{
            //    Yearly = year,
            //    Monthly = month,
            //    MonthlyType = Define.MONTHLY_TYPE.GetKey("누계"),
            //    RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            //});


            //연간 - 실적 : 실적은 타입 연간이 아니라 누계를 가져와야한다.
            var investYearResultPieChart = (int.Parse(year) > 2018) ? groupMainRepo.investYearResultPieChart_NEW(new
            {
                Yearly = year,
                Monthly = month,
                MonthlyType = Define.MONTHLY_TYPE.GetKey("누계"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            }): groupMainRepo.investYearResultPieChart(new
            {
                Yearly = year,
                Monthly = month,
                MonthlyType = Define.MONTHLY_TYPE.GetKey("누계"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            });

            ////인원
            //var personnelResultChart = groupMainRepo.personnelResultChart(new
            //{
            //    StartDate = preYear + "12",
            //    EndDate = year + "12",
            //    MonthlyType = Define.MONTHLY_TYPE.GetKey("당월"),
            //    RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            //});
            //인원
            var personnelResultChart = (int.Parse(year) > 2018) ? groupMainRepo.personnelResultChart_NEW(new
            {
                StartDate = preYear ,
                EndDate = year ,
                MonthlyType = Define.MONTHLY_TYPE.GetKey("당월"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            }): groupMainRepo.personnelResultChart(new
            {
                StartDate = preYear + "12",
                EndDate = year + "12",
                MonthlyType = Define.MONTHLY_TYPE.GetKey("당월"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            });

            //누계
            model.investPlanPieChart = investPlanPieChart;
            model.investResultPieChart = investResultPieChart;
            //연간
            model.investYearPlanPieChart = investYearPlanPieChart;
            model.investYearResultPieChart = investYearResultPieChart;
            //인원
            model.personnelResultChart = personnelResultChart;

            #endregion

            model.registYearPm = registYearPm;
            ViewBag.search = search;
            return View("~/Views/Org/NewIndex.cshtml", model);
        }
        [Route("Index")]
        public ActionResult Index(Search search)
        {
            List<RegistYearList> registYearPm = rYearListRepo.selectListPm(new { }).ToList();

            var y = registYearPm
            .GroupBy(g => g.RegistYear)
            .Select(cl => new RegistYearList
            {
                RegistYear = cl.First().RegistYear
            }).ToList();

            if (string.IsNullOrWhiteSpace(search.year))
            {
                search.year = y.Last().RegistYear;
            }

            var m = registYearPm.Where(w => w.RegistYear == search.year).ToList();

            if (string.IsNullOrWhiteSpace(search.mm))
            {
                search.mm = m.Last().RegistMonth;
            }

            if (Convert.ToInt32(search.mm) > Convert.ToInt32(m.Last().RegistMonth))
            {
                search.mm = m.Last().RegistMonth;
            }

            var year = search.year;
            var preYear = int.Parse(search.year) - 1;
            var month = search.mm;

            dynamic model = new ExpandoObject();

            #region #.Dash Board

            //FCF
            var groupMainFCF = groupMainRepo.groupMainFCF(new
            {
                Year = year,
                Month = month,
                Diff = Define.DIFF.GetKey("실적")
            });
            
            //SALES(당월,누계)
            var groupMainSalesList = groupMainRepo.groupMainSales(new
            {
                Year = year,
                Month = month,
                MonthlyTypeFirst = Define.MONTHLY_TYPE.GetKey("당월"),
                MonthlyTypeSecond = Define.MONTHLY_TYPE.GetKey("누계")
            });

            //EBIT(당월,누계)
            var groupMainEbitList = groupMainRepo.groupMainEbit(new
            {
                Year = year,
                Month = month,
                MonthlyTypeFirst = Define.MONTHLY_TYPE.GetKey("당월"),
                MonthlyTypeSecond = Define.MONTHLY_TYPE.GetKey("누계")
            });

            //ROIC(누계)
            var groupMainRoic = groupMainRepo.groupMainRoic(new
            {
                Year = year,
                Month = month
            });

            model.groupMainFCF = groupMainFCF;
            model.groupMainSalesList = groupMainSalesList;
            model.groupMainEbitList = groupMainEbitList;
            model.groupMainRoic = groupMainRoic;

            #endregion

            #region #.KPI Signal

            //회사 정보
            var groupMainKpiSignalGroup = groupMainRepo.groupMainKpiSignalGroup(new
            {
                Diff = Define.DIFF.GetKey("실적"),
                Year = year,
                Month = month
            });

            //FCF
            var groupMainKpiSignalFCF = groupMainRepo.groupMainKpiSignalFCF(new
            {
                Diff = Define.DIFF.GetKey("실적"),
                Year = year,
                Month = month
            });

            //매출, EBIT, PBT (당월, 매출)
            var groupMainKpiSignal = groupMainRepo.groupMainKpiSignal(new
            {
                Year = year,
                Month = month,
                MonthlyTypeFirst = Define.MONTHLY_TYPE.GetKey("당월"),
                MonthlyTypeSecond = Define.MONTHLY_TYPE.GetKey("누계")
            });

            //부채비율 : 2019.03.27 ROIC 추가
            var kpiSignalLiabilitiesRate = groupMainRepo.groupMainKpiSignalLiabilities(new
            {
                Year = year,
                Month = month
            });

            // 

            //model.KpiSignalGroup = groupMainKpiSignalGroup;

            model.KpiSignalFCF = groupMainKpiSignalFCF;
            model.KpiSignal = groupMainKpiSignal;
            model.kpiSignalLiabilitiesRate = kpiSignalLiabilitiesRate;

            #endregion

            #region #.손익 목표 달성 현황(KPI X-Y Graph)

            var groupMainKpiGraph = groupMainRepo.groupMainKpiGraph(new
            {
                Year = year,
                Month = month,
                MonthlyType = Define.MONTHLY_TYPE.GetKey("누계"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            });

            model.KpiGraph = groupMainKpiGraph;

            #endregion

            #region #.CashFlow

            var groupMainPlanCashFlow = groupMainRepo.groupMainPlanCashFlow(new {
                Cumulative = Define.CUMULATIVE.GetKey("당월 실적"),
                Diff = Define.DIFF.GetKey("계획"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인"),
                Year = year,
                Month = month
            });

            var groupMainResultCashFlow = groupMainRepo.groupMainResultCashFlow(new
            {
                Cumulative = Define.CUMULATIVE.GetKey("누계 실적"),
                Diff = Define.DIFF.GetKey("실적"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인"),
                Year = year,
                Month = month
            });

            model.cashFlowResult = groupMainResultCashFlow;
            model.CashFlowPlan = groupMainPlanCashFlow;

            #endregion

            #region #.당월/누계손익

            //당월/누계손익 (당월 - SALES)
            var salesCalcList = groupMainRepo.groupMainSalesCalc(new
            {
                Year = year,
                Month = month,
                MonthlyType = Define.MONTHLY_TYPE.GetKey("당월"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            });

            //당월/누계손익 (당월전년 - SALES)
            var preYearSalesCalcList = groupMainRepo.groupMainSalesCalc(new
            {
                Year = preYear,
                Month = month,
                MonthlyType = Define.MONTHLY_TYPE.GetKey("당월"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            });

            //당월/누계손익 SALES 당월 서브차트
            var groupMainSubSalesCalc = groupMainRepo.groupMainSubSalesCalc(new {
                Year = year,
                Month = month,
                MonthlyType = Define.MONTHLY_TYPE.GetKey("당월"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            });

            //당월/누계손익 (당월 - EBIT)
            var ebitCalcList = groupMainRepo.groupMainEbitCalc(new
            {
                Year = year,
                Month = month,
                MonthlyType = Define.MONTHLY_TYPE.GetKey("당월"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            });

            //당월/누계손익 (당월전년 - EBIT)
            var preYearEbitCalcList = groupMainRepo.groupMainEbitCalc(new
            {
                Year = preYear,
                Month = month,
                MonthlyType = Define.MONTHLY_TYPE.GetKey("당월"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            });

            //당월/누계손익 EBIT 당월 서브차트
            var groupMainSubEbitCalc = groupMainRepo.groupMainSubEbitCalc(new {
                Year = year,
                Month = month,
                MonthlyType = Define.MONTHLY_TYPE.GetKey("당월"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            });

            model.salesCalcList = salesCalcList;
            model.preYearSalesCalcList = preYearSalesCalcList;

            model.salesCalcSubChart = groupMainSubSalesCalc;

            model.ebitCalcList = ebitCalcList;
            model.preYearEbitCalcList = preYearEbitCalcList;

            model.ebitCalcSubChart = groupMainSubEbitCalc;

            //당월/누계손익 (누계 - SALES)
            var SalesSumCalc = groupMainRepo.groupMainSalesSumCalc(new {
                Year = year,
                Month = month,
                MonthlyType = Define.MONTHLY_TYPE.GetKey("누계"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            });

            //당월/누계손익 (누계 - SALES)
            var preYearSalesSumCalc = groupMainRepo.groupMainSalesSumCalc(new
            {
                Year = preYear,
                Month = month,
                MonthlyType = Define.MONTHLY_TYPE.GetKey("누계"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            });

            //당월/누계손익 SALES 누계 서브차트
            var groupMainSubSalesSumCalc = groupMainRepo.groupMainSubSalesSumCalc(new
            {
                Year = year,
                Month = month,
                MonthlyType = Define.MONTHLY_TYPE.GetKey("누계"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            });

            //당월/누계손익 (누계 - EBIT)
            var ebitSumCalc = groupMainRepo.groupMainEbitSumCalc(new
            {
                Year = year,
                Month = month,
                MonthlyType = Define.MONTHLY_TYPE.GetKey("누계"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            });

            //당월/누계손익 (누계 - EBIT)
            var preYearEbitSumCalc = groupMainRepo.groupMainEbitSumCalc(new
            {
                Year = preYear,
                Month = month,
                MonthlyType = Define.MONTHLY_TYPE.GetKey("누계"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            });

            //당월/누계손익 SALES 누계 서브차트
            var groupMainSubEbitSumCalc = groupMainRepo.groupMainSubEbitSumCalc(new
            {
                Year = year,
                Month = month,
                MonthlyType = Define.MONTHLY_TYPE.GetKey("누계"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            });

            model.SalesSumCalcList = SalesSumCalc;
            model.preYearSalesSumCalcList = preYearSalesSumCalc;

            model.salesSumCalcSubChart = groupMainSubSalesSumCalc;

            model.EbitSumCalcList = ebitSumCalc;
            model.preYearEbitSumCalcList = preYearEbitSumCalc;

            model.ebitSumCalcSubChart = groupMainSubEbitSumCalc;

            #endregion

            #region #.연간예상손익

            //연간 예상 손익 - Sales누계실적(계획, 실적)
            var groupMainExpectSales = groupMainRepo.groupMainExpectSales(new
            {
                Year = year,
                Month = month,
                MonthlyType = Define.MONTHLY_TYPE.GetKey("누계"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            });

            //연간 예상 손익 - Sales누계실적(전년)
            var preYearExpectSales = groupMainRepo.groupMainPreYearExpectSales(new
            {
                Year = preYear,
                Month = month,
                MonthlyType = Define.MONTHLY_TYPE.GetKey("누계"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            });

            //연간 예상 손익 - Sales연간예상(계획, 실적)
            var groupMainExpectYearSales = groupMainRepo.groupMainExpectYearSales(new
            {
                Year = year,
                Month = month,
                MonthlyType = Define.MONTHLY_TYPE.GetKey("연간"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            });

            //연간 예상 손익 - Sales연간예상(전년)
            var groupMainPreYearExpectYearSales = groupMainRepo.groupMainPreYearExpectYearSales(new
            {
                Year = preYear,
                MonthlyType = Define.MONTHLY_TYPE.GetKey("누계"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            });

            //연간 예상 손익 - Sales잔여월(계획, 실적)
            var expectRestSalesList = groupMainRepo.groupMainExpectRestSales(new
            {
                Year = year,
                Month = month,
                MonthlyTypeFirst = Define.MONTHLY_TYPE.GetKey("연간"),
                MonthlyTypeSecond = Define.MONTHLY_TYPE.GetKey("누계"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            });
            //연간 예상 손익 - Sales잔여월(계획, 실적)
            var groupMainExpectRestSales = GroupMainExpectRestSalesList(expectRestSalesList);

            //연간 예상 손익 - Sales잔여월(전년)
            var groupMainPreYearExpectRestSales = groupMainRepo.groupMainPreYearExpectRestSales(new
            {
                Year = preYear,
                Month = month,
                MonthlyTypeFirst = Define.MONTHLY_TYPE.GetKey("누계"),
                MonthlyTypeSecond = Define.MONTHLY_TYPE.GetKey("누계"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            });
            //연간 예상 손익 - Sales잔여월(전년)
            var preYearExpectRestSales = GroupMainPreYearExpectRestSalesList(groupMainPreYearExpectRestSales);

            model.expectSalesList = groupMainExpectSales;
            model.preYearExpectSalesList = preYearExpectSales;

            model.expectYearSalesList = groupMainExpectYearSales;
            model.preYearExpectYearSalesList = groupMainPreYearExpectYearSales;

            model.expectRestSalesList = groupMainExpectRestSales;
            model.preYearExpectRestSalesList = preYearExpectRestSales;

            //연간 예상 손익 - Ebit누계실적(계획, 실적)
            var groupMainExpectEbit = groupMainRepo.groupMainExpectEbit(new
            {
                Year = year,
                Month = month,
                MonthlyType = Define.MONTHLY_TYPE.GetKey("누계"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            });

            //연간 예상 손익 - Ebit누계실적(전년)
            var preYearExpectEbit = groupMainRepo.groupMainPreYearExpectEbit(new
            {
                Year = preYear,
                Month = month,
                MonthlyType = Define.MONTHLY_TYPE.GetKey("누계"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            });

            ////연간 예상 손익 - Ebit연간예상(계획, 실적)
            //var groupMainExpectYearEbit = groupMainRepo.groupMainExpectYearEbit(new
            //{
            //    Year = year,
            //    Month = month,
            //    MonthlyType = Define.MONTHLY_TYPE.GetKey("연간"),
            //    RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            //});

            //연간 예상 손익 - Ebit연간예상(계획, 실적)
            var groupMainExpectYearEbit = groupMainRepo.groupMainExpectYearEbit_NEW(new
            {
                Year = year,
                Month = month,
                MonthlyType = Define.MONTHLY_TYPE.GetKey("연간"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            });

            //연간 예상 손익 - Ebit연간예상(전년)
            var preYearExpectYearEbit = groupMainRepo.groupMainPreYearExpectYearEbit(new
            {
                Year = preYear,
                MonthlyType = Define.MONTHLY_TYPE.GetKey("누계"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            });

            //연간 예상 손익 - Ebit잔여월(계획, 실적) 
            var expectRestEbit = groupMainRepo.groupMainExpectRestEbit(new
            {
                Year = year,
                Month = month,
                MonthlyTypeFirst = Define.MONTHLY_TYPE.GetKey("연간"),
                MonthlyTypeSecond = Define.MONTHLY_TYPE.GetKey("누계"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            });
            //연간 예상 손익 - Ebit잔여월 Result(계획, 실적)
            var groupMainExpectRestEbit = GroupMainExpectRestEbitList(expectRestEbit);

            //연간 예상 손익 - Ebit잔여월(전년)
            var preYearExpectRestEbit = groupMainRepo.groupMainPreYearExpectRestEbit(new
            {
                Year = preYear,
                Month = month,
                MonthlyTypeFirst = Define.MONTHLY_TYPE.GetKey("누계"),
                MonthlyTypeSecond = Define.MONTHLY_TYPE.GetKey("누계"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            });

            //연간 예상 손익 - Ebit잔여월 Result(전년)
            var groupMainPreYearExpectRestEbit = GroupMainPreYearExpectRestEbitList(preYearExpectRestEbit);

            //연간 예상 손익 - Tablehead연간예상
            var groupMainExpectYearHeadTable = groupMainRepo.groupMainExpectYearHeadTable(new
            {
                Year = year,
                Month = month,
                MonthlyType = Define.MONTHLY_TYPE.GetKey("연간"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            });
            //연간 예상 손익 - TableBody연간예상
            var groupMainExpectYearBodyTable = groupMainRepo.groupMainExpectYearBodyTable(new
            {
                Year = year,
                Month = month,
                MonthlyType = Define.MONTHLY_TYPE.GetKey("연간"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            });

            //연간 예상 손익 - TableBody잔여월
            var groupMainExpectYearTable = groupMainRepo.groupMainExpectYearTable(new
            {
                Year = year,
                Month = month,
                MonthlyTypeFirst = Define.MONTHLY_TYPE.GetKey("연간"),
                MonthlyTypeSecond = Define.MONTHLY_TYPE.GetKey("누계"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            });

            //연간 예상 손익 - TableBody잔여월
            var expectYearRestBodyTable = GroupMainExpectRestTable(groupMainExpectYearTable);

            model.expectEbitList = groupMainExpectEbit;
            model.preYearExpectEbitList = preYearExpectEbit;

            model.expectYearEbitList = groupMainExpectYearEbit;
            model.preYearExpectYearEbitList = preYearExpectYearEbit;

            model.expectRestEbitList = groupMainExpectRestEbit;
            model.preYearExpectRestEbit = groupMainPreYearExpectRestEbit;

            
            model.expectYearHeadTable = groupMainExpectYearHeadTable;
            model.expectYearRestBodyTable = expectYearRestBodyTable;
            model.expectYearBodyTable = groupMainExpectYearBodyTable;

            #endregion

            #region #.ROIC

            var groupMainPlanRoic = groupMainRepo.groupMainPlanRoic(new
            {
                StartDate = preYear + "12",
                EndDate = year + "12",
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            });

            var groupMainResultRoic = groupMainRepo.groupMainResultRoic(new
            {
                StartDate = preYear + "12",
                EndDate = year + "12",
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            });

            model.groupMainPlanRoic = groupMainPlanRoic;
            model.groupMainResultRoic = groupMainResultRoic;

            #endregion

            #region #.투자/인원

            //누계 - 계획
            var investPlanPieChart = groupMainRepo.investPlanPieChart(new
            {
                Yearly = year,
                Monthly = month,
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            });

            //누계 - 실적
            var investResultPieChart = groupMainRepo.investResultPieChart(new
            {
                Yearly = year,
                Monthly = month,
                MonthlyType = Define.MONTHLY_TYPE.GetKey("누계"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            });

            //연간 - 계획
            var investYearPlanPieChart = groupMainRepo.investYearPlanPieChart(new
            {
                Yearly = year,
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            });

            //연간 - 실적 : 실적은 타입 연간이 아니라 누계를 가져와야한다.
            var investYearResultPieChart = groupMainRepo.investYearResultPieChart(new
            {
                Yearly = year,
                Monthly = month,
                MonthlyType = Define.MONTHLY_TYPE.GetKey("누계"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            });

            //인원
            var personnelResultChart = groupMainRepo.personnelResultChart(new
            {
                StartDate = preYear + "12",
                EndDate = year + "12",
                MonthlyType = Define.MONTHLY_TYPE.GetKey("당월"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            });

            //누계
            model.investPlanPieChart = investPlanPieChart;
            model.investResultPieChart = investResultPieChart;
            //연간
            model.investYearPlanPieChart = investYearPlanPieChart;
            model.investYearResultPieChart = investYearResultPieChart;
            //인원
            model.personnelResultChart = personnelResultChart;

            #endregion

            model.registYearPm = registYearPm;
            ViewBag.search = search;

            return View("~/Views/Org/Index.cshtml", model);
        }

        [Route("Company")]
        public ActionResult Company(Search search)
        {
            List<RegistYearList> registYearPm = rYearListRepo.selectListPm(new { }).ToList();

            var y = registYearPm
            .GroupBy(g => g.RegistYear)
            .Select(cl => new RegistYearList
            {
                RegistYear = cl.First().RegistYear
            }).ToList();

            if (string.IsNullOrWhiteSpace(search.year))
            {
                search.year = y.Last().RegistYear;
            }

            var m = registYearPm.Where(w => w.RegistYear == search.year).ToList();

            if (string.IsNullOrWhiteSpace(search.mm))
            {
                search.mm = m.Last().RegistMonth;
            }

            if (Convert.ToInt32(search.mm) > Convert.ToInt32(m.Last().RegistMonth))
            {
                search.mm = m.Last().RegistMonth;
            }

            var a = search.OrgCompanySeq;
            var CompanySeq = Request.QueryString["Seq"] ?? "1";

            search.OrgCompanySeq = int.Parse(CompanySeq);
            
            // 2019.02.15 만도Bu로 들어온 경우 2018년 12월 이전인 경우 만도데이터, 2019.01월 이후인 경우 만도Bu 데이터가 보이게 변경
            if (Convert.ToInt32(search.year) < 2019)
            {
                if(search.OrgCompanySeq == 14)
                {
                    search.OrgCompanySeq = 3;
                    CompanySeq = "3";
                }
            }

            var selectCompanyName = groupCompanyRepo.selectCompanyName(new { Seq = CompanySeq });
            var year = search.year;
            var preYear = int.Parse(search.year) - 1;
            var month = search.mm;
            
            dynamic model = new ExpandoObject();

            #region #.DashBoard

            //FCF
            var companyFCF = groupCompanyRepo.companyFCF(new
            {
                Year = year,
                Month = month,
                Seq = CompanySeq,
                Diff = Define.DIFF.GetKey("실적")
            });

            //SALES(당월,누계)
            var companySalesList = groupCompanyRepo.companySales(new
            {
                Seq = CompanySeq,
                Year = year,
                Month = month,
                MonthlyTypeFirst = Define.MONTHLY_TYPE.GetKey("당월"),
                MonthlyTypeSecond = Define.MONTHLY_TYPE.GetKey("누계")
            });

            //EBIT(당월,누계)
            var companyEbitList = groupCompanyRepo.companyEbit(new
            {
                Year = year,
                Month = month,
                Seq = CompanySeq,
                MonthlyTypeFirst = Define.MONTHLY_TYPE.GetKey("당월"),
                MonthlyTypeSecond = Define.MONTHLY_TYPE.GetKey("누계")
            });

            //ROIC(누계)
            var companyRoic = groupCompanyRepo.companyRoic(new
            {
                Seq = CompanySeq,
                Year = year,
                Month = month
            });
            
            model.companyFCF = companyFCF;
            model.companySalesList = companySalesList;
            model.companyEbitList = companyEbitList;
            model.companyRoic = companyRoic;

            #endregion

            #region #.CashFlow

            //회사 > Cash Flow(계획)
            var cashFlowList = groupCompanyRepo.companyCashFlow(new
            {
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인"),
                Cumulative = Define.CUMULATIVE.GetKey("당월 실적"),
                Diff = Define.DIFF.GetKey("계획"),
                Seq = CompanySeq,
                Year = year,
                Month = month
            });

            //회사 > Cash Flow(실적)
            var sumCashFlowList = groupCompanyRepo.companySumCashFlow(new
            {
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인"),
                Cumulative = Define.CUMULATIVE.GetKey("누계 실적"),
                Diff = Define.DIFF.GetKey("실적"),
                Seq = CompanySeq,
                Year = year,
                Month = month
            });
            
            model.cashFlowList = cashFlowList;
            model.sumCashFlowList = sumCashFlowList;

            #endregion

            #region #.손익 (당월/누계)

            // 실적비중
            PmPalBusinessRepo pmPalBusinessRepo = new PmPalBusinessRepo();
            var palRate = pmPalBusinessRepo.selectListPalRate(new { }).ToList();

            var monPalRate = palRate.Where(w => w.PalYear == year).Where(w => w.Monthly == month).Where(w => w.MonthlyType == Define.MONTHLY_TYPE.GetKey("당월"))
                .Where(w => w.OrgCompanySeq == Convert.ToInt32(CompanySeq)).ToList();

            var cumPalRate = palRate.Where(w => w.PalYear == year).Where(w => w.Monthly == month).Where(w => w.MonthlyType == Define.MONTHLY_TYPE.GetKey("누계"))
                .Where(w => w.OrgCompanySeq == Convert.ToInt32(CompanySeq)).ToList();

            // 회사 > 손익 
            List<PmPalSummaryExp> companyPalThisPm = pmPalSummaryRepo.selectListPmThisYear(new { year = year, mm = month }).Where(w => w.OrgCompanySeq == int.Parse(CompanySeq)).ToList();
            List<PmPalSummaryExp> companyPalLastPm = pmPalSummaryRepo.selectListPmThisYear(new { year = preYear, mm = month }).Where(w => w.OrgCompanySeq == int.Parse(CompanySeq)).ToList();
            List<PmPalSummaryExp> companyPalThisPn = pmPalSummaryRepo.selectListPnThisYear(new { year = year }).Where(w => w.OrgCompanySeq == int.Parse(CompanySeq)).ToList();
            List<PmPalSummaryExp> companyPalLastPm12 = pmPalSummaryRepo.selectListPmThisYear(new { year = preYear, mm = "12" }).Where(w => w.OrgCompanySeq == int.Parse(CompanySeq)).ToList();

            //회사 > 당월/누계손익 (당월 - SALE)
            var salesCalcList = groupCompanyRepo.companySalesCalc(new
            {
                Year = year,
                Month = month,
                Seq = CompanySeq,
                MonthlyType = Define.MONTHLY_TYPE.GetKey("당월"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            });

            //회사 > 당월/누계손익 (당월 - SALE/전년)
            var preYearSalesCalcList = groupCompanyRepo.companySalesCalc(new
            {
                Year = preYear,
                Month = month,
                Seq = CompanySeq,
                MonthlyType = Define.MONTHLY_TYPE.GetKey("당월"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            });


            //회사 > 당월/누계손익 (당월 - EBIT)
            var ebitCalcList = groupCompanyRepo.companyEbitCalc(new
            {
                Year = year,
                Month = month,
                Seq = CompanySeq,
                MonthlyType = Define.MONTHLY_TYPE.GetKey("당월"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            });

            //당월/누계손익 (당월 - EBIT/전년)
            var preYearEbitCalcList = groupCompanyRepo.companyEbitCalc(new
            {
                Year = preYear,
                Month = month,
                Seq = CompanySeq,
                MonthlyType = Define.MONTHLY_TYPE.GetKey("당월"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            });

            //당월/누계손익 (당월 - TABLE)
            var profitTable = groupCompanyRepo.companyProfitTable(new
            {
                Year = year,
                Month = month,
                Seq = CompanySeq,
                MonthlyType = Define.MONTHLY_TYPE.GetKey("당월")
            });

            //당월/누계손익 (누계 - SALE)
            var salesCalcTotalList = groupCompanyRepo.companySalesCalcTotal(new
            {
                Year = year,
                Month = month,
                Seq = CompanySeq,
                MonthlyType = Define.MONTHLY_TYPE.GetKey("누계"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            });

            //당월/누계손익 (누계 - SALE/전년)
            var preYearSalesCalcTotalList = groupCompanyRepo.companySalesCalcTotal(new
            {
                Year = preYear,
                Month = month,
                Seq = CompanySeq,
                MonthlyType = Define.MONTHLY_TYPE.GetKey("누계"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            });

            //당월/누계손익 (누계 - Ebit)
            var ebitCalcTotalList  = groupCompanyRepo.companyEbitCalcTotal(new
            {
                Year = year,
                Month = month,
                Seq = CompanySeq,
                MonthlyType = Define.MONTHLY_TYPE.GetKey("누계"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            });

            //당월/누계손익 (누계 - Ebit/전년)
            var preYearEbitCalcTotalList = groupCompanyRepo.companyEbitCalcTotal(new
            {
                Year = preYear,
                Month = month,
                Seq = CompanySeq,
                MonthlyType = Define.MONTHLY_TYPE.GetKey("누계"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            });

            //당월/누계손익 (누계 - Table)
            var profitTotalTable = groupCompanyRepo.companyProfitTotalTable(new
            {
                Year = year,
                Month = month,
                Seq = CompanySeq,
                MonthlyType = Define.MONTHLY_TYPE.GetKey("누계")
            });
          

            model.companyPalThisPm = companyPalThisPm;
            model.companyPalLastPm = companyPalLastPm;
            model.companyPalThisPn = companyPalThisPn;
            model.companyPalLastPm12 = companyPalLastPm12;

            model.salesCalcList = salesCalcList;
            model.preYearSalesCalcList = preYearSalesCalcList;

            model.ebitCalcList = ebitCalcList;
            model.preYearEbitCalcList = preYearEbitCalcList;

            model.profitTable = profitTable;

            model.salesCalcTotalList = salesCalcTotalList;
            model.preYearSalesCalcTotalList = preYearSalesCalcTotalList;

            model.ebitCalcTotalList = ebitCalcTotalList;
            model.preYearEbitCalcTotalList = preYearEbitCalcTotalList;

            model.profitTotalTable = profitTotalTable;

            #endregion

            #region #.손익 (연간예상)

            //손익 (연간예상) - Sales, Ebit 누계실적(계획, 실적)
            var companyExpectList = groupCompanyRepo.companyExpect(new
            {
                Year = year,
                Month = month,
                Seq = CompanySeq,
                MonthlyType = Define.MONTHLY_TYPE.GetKey("누계"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            });

            //손익 (연간예상) - Sales, Ebit 누계실적(전년)
            var companyPreYearExpectList = groupCompanyRepo.companyExpect(new
            {
                Year = preYear,
                Month = month,
                Seq = CompanySeq,
                MonthlyType = Define.MONTHLY_TYPE.GetKey("누계"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            });

            //손익(연간예상) - Sales, Ebit 연간실적(계획, 실적)
            var companyExpectYearList = groupCompanyRepo.companyExpectYear(new
            {
                Year = year,
                Month = month,
                Seq = CompanySeq,
                MonthlyType = Define.MONTHLY_TYPE.GetKey("연간"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            });

            //손익(연간예상) - Sales, Ebit 연간실적(전년)
            var companyPreYearExpectYearList = groupCompanyRepo.companyExpectYear(new
            {
                Year = preYear,
                Month = "12",
                Seq = CompanySeq,
                MonthlyType = Define.MONTHLY_TYPE.GetKey("누계"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            });

            //손익(잔여월)
            var expectRestSales = groupCompanyRepo.companyExpectRestSales(new
            {
                Year = year,
                Month = month,
                Seq = CompanySeq,
                MonthlyTypeFirst = Define.MONTHLY_TYPE.GetKey("연간"),
                MonthlyTypeSecond = Define.MONTHLY_TYPE.GetKey("누계"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            });

            //손익 - Sales, Ebit 잔여월
            var expectRestList = companyExpectRestSalesList(expectRestSales);

            //손익 - Sales, Ebit 잔여월(전년)
            var preYearExpectRestSales = groupCompanyRepo.companyExpectRestSales(new
            {
                Year = preYear,
                Month = month,
                Seq = CompanySeq,
                MonthlyTypeFirst = Define.MONTHLY_TYPE.GetKey("연간"),
                MonthlyTypeSecond = Define.MONTHLY_TYPE.GetKey("누계"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            });

            //손익(잔여월 - Sales, Ebit)
            var preYearExpectRestList = companyExpectRestSalesList(preYearExpectRestSales);

            //손익(테이블 헤더)
            var companyExpectHeaderTable = groupCompanyRepo.companyExpectHeaderTable(new
            {
                Year = year,
                Month = month,
                Seq = CompanySeq,
                MonthlyType = Define.MONTHLY_TYPE.GetKey("연간")
            });

            //누계손익
            model.companyExpectList = companyExpectList;
            model.companyPreYearExpectList = companyPreYearExpectList;

            //잔여월
            model.expectRestList = expectRestList;
            model.preYearExpectRestList = preYearExpectRestList;

            //연간예상
            model.companyExpectYearList = companyExpectYearList;
            model.companyPreYearExpectYearList = companyPreYearExpectYearList;

            //Table-해더
            model.companyExpectHeaderTable = companyExpectHeaderTable;

            #endregion

            #region #.재무비율 및 B/S

            //계획
            var companyPlanRoic = groupCompanyRepo.companyPlanRoic(new
            {
                StartDate = preYear + "12",
                EndDate = year + "12",
                Seq = CompanySeq,
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            });

            //실적
            var companyResultRoic = groupCompanyRepo.companyResultRoic(new
            {
                StartDate = preYear + "12",
                EndDate = year + "12",
                Seq = CompanySeq,
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            });

            model.companyPlanRoic = companyPlanRoic;
            model.companyResultRoic = companyResultRoic;

            // 부채비율
            var companyPlanL = groupCompanyRepo.companyPlanLiabilitiesRate(new
            {
                StartDate = preYear + "12",
                EndDate = year + "12",
                Seq = CompanySeq,
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            });

            
            var companyResultL = groupCompanyRepo.companyResultLiabilitesRate(new
            {
                StartDate = preYear + "12",
                EndDate = year + "12",
                Seq = CompanySeq,
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            });

            model.companyPlanL = companyPlanL;
            model.companyResultL = companyResultL;

            //테이블
            List<GroupCompany> pmThisYear = groupCompanyRepo.selectListPmThisYear(search).ToList();
            List<GroupCompany> pmLastYear = groupCompanyRepo.selectListPmLastYear(search).ToList();
            List<GroupCompany> pnThisYear = groupCompanyRepo.selectListPnThisYear(search).ToList();

            List<GroupCompany> pmThisYearCom = pmThisYear.Where(w => w.OrgCompanySeq == int.Parse(CompanySeq)).ToList();
            List<GroupCompany> pmLastYearCom = pmLastYear.Where(w => w.OrgCompanySeq == int.Parse(CompanySeq)).ToList();
            List<GroupCompany> pnThisYearCom = pnThisYear.Where(w => w.OrgCompanySeq == int.Parse(CompanySeq)).ToList();

            List<GroupCompany> pmThisYearEx = groupCompanyRepo.selectListPmThisYearEx(search).ToList();
            List<GroupCompany> pmLastYearEx = groupCompanyRepo.selectListPmLastYearEx(search).ToList();
            List<GroupCompany> pnThisYearEx = groupCompanyRepo.selectListPnThisYearEx(search).ToList();

            List<GroupCompany> pmThisYearComEx = pmThisYearEx.Where(w => w.OrgCompanySeq == int.Parse(CompanySeq)).ToList();
            List<GroupCompany> pmLastYearComEx = pmLastYearEx.Where(w => w.OrgCompanySeq == int.Parse(CompanySeq)).ToList();
            List<GroupCompany> pnThisYearComEx = pnThisYearEx.Where(w => w.OrgCompanySeq == int.Parse(CompanySeq)).ToList();

            model.pmThisYearCom = pmThisYearCom;
            model.pmLastYearCom = pmLastYearCom;
            model.pnThisYearCom = pnThisYearCom;

            model.pmThisYearComEx = pmThisYearComEx;
            model.pmLastYearComEx = pmLastYearComEx;
            model.pnThisYearComEx = pnThisYearComEx;

            #endregion

            model.registYearPm = registYearPm;
            model.selectCompanyName = selectCompanyName;

            #region #.투자/인원

            //누계 - 계획
            var investPlanPieChart = groupCompanyRepo.investPlanPieChart(new
            {
                Seq = CompanySeq,
                Yearly = year,
                Monthly = month,
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            });

            //누계 - 실적
            var investResultPieChart = groupCompanyRepo.investResultPieChart(new
            {
                Seq = CompanySeq,
                Yearly = year,
                Monthly = month,
                MonthlyType = Define.MONTHLY_TYPE.GetKey("누계"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            });

            //연간 - 계획
            var investYearPlanPieChart = groupCompanyRepo.investYearPlanPieChart(new
            {
                Seq = CompanySeq,
                Yearly = year,
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            });

            //연간 - 실적
            var investYearResultPieChart = groupCompanyRepo.investYearResultPieChart(new
            {
                Seq = CompanySeq,
                Yearly = year,
                Monthly = month,
                MonthlyType = Define.MONTHLY_TYPE.GetKey("누계"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            });

            //인원
            var personnelResultChart = groupCompanyRepo.personnelResultChart(new
            {
                Seq = CompanySeq,
                StartDate = preYear + "12",
                EndDate = year + "12",
                MonthlyType = Define.MONTHLY_TYPE.GetKey("당월"),
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인")
            });

            //누계
            model.investPlanPieChart = investPlanPieChart;
            model.investResultPieChart = investResultPieChart;
            //연간
            model.investYearPlanPieChart = investYearPlanPieChart;
            model.investYearResultPieChart = investYearResultPieChart;
            //인원
            model.personnelResultChart = personnelResultChart;

            #endregion


            model.monPalRate = monPalRate;
            model.cumPalRate = cumPalRate;

            ViewBag.search = search;

            return View("~/Views/Org/Company.cshtml", model);
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