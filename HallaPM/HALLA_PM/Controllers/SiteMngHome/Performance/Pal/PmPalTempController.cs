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
    [RoutePrefix("SiteMngHome/Performance/PalTemp")]
    public class PmPalTempController : SiteMngBaseController
    {
        [Route("List")]
        public ActionResult List(Search search)
        {
            dynamic model = new ExpandoObject();
            search.AuthUserKey = SessionManager.GetAdminSession().insaUserV.userKey;
            model.list = pmPalRepo.selectListTemp(search);
            ViewBag.Search = search;

            return View("~/Views/SiteMngHome/Performance/PalTemp/List.cshtml", model);
        }

        [Route("Write")]
        public ActionResult Write(PmPal entity)
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");

            // 기본 정보 가져온다.
            var pmPal = pmPalRepo.selectOne(entity);
            // 회사 밑에 부서 정보를 가져온다
            var orgBusinessList = orgBusinessRepo.selectListAll(new { OrgCompanySeq = entity.OrgCompanySeq });

            var orgCompanyName = orgCompanyRepo.selectOne(new { Seq = entity.OrgCompanySeq });


            foreach (var business in orgBusinessList)
            {
                PmPalBusiness p = new PmPalBusiness();

                //당월, 누계, 예상 값을 넣기때문에 3번의 루프문을 돈다.
                for (int i = 1; i <= 3; i++)
                {
                    var monthlyType = 0;
                    if (i == 1)
                    {
                        monthlyType = Define.MONTHLY_TYPE.GetKey("당월"); //당월실적
                    }
                    else if (i == 2)
                    {
                        monthlyType = Define.MONTHLY_TYPE.GetKey("누계"); //누계
                    }
                    else if (i == 3)
                    {
                        monthlyType = Define.MONTHLY_TYPE.GetKey("연간"); ; //예상
                    }

                    p.PmPalSeq = entity.Seq;
                    p.OrgBusinessSeq = business.Seq;
                    p.MonthlyType = monthlyType.ToString();
                    p.Sales = 0;
                    p.Ebit = 0;
                    p.EbitRate = 0;
                    p.Pbt = 0;
                    p.Monthly = pmPal.Monthly;
                    p.YearlyYear = pmPal.PalYear;

                    string where = " WHERE PM_PAL_SEQ = @PmPalSeq AND ORG_BUSINESS_SEQ = @OrgBusinessSeq AND MONTHLY_TYPE =" + monthlyType;
                    if (pmPalBusinessRepo.count(p, where) == 0) pmPalBusinessRepo.insert(p);
                }
            }

            //계획
            var selectListPlanThisYear = pmPalBusinessRepo.selectListPlanThisYear(new { YearlyYear = pmPal.PalYear, Monthly = pmPal.Monthly, Seq = pmPal.OrgCompanySeq });

            // 전년도 - 연간, 당월, 누계
            var selectListLastYear = pmPalBusinessRepo.selectListLastYear(new { YearlyYear = pmPal.PalYear, Monthly = pmPal.Monthly, Seq = pmPal.OrgCompanySeq });

            // 해당년도 - 당월계획
            var selectListPlanMonthlyThisYear = pmPalBusinessRepo.selectListPlanMonthlyThisYear(new { YearlyYear = pmPal.PalYear, Monthly = pmPal.Monthly, Seq = pmPal.OrgCompanySeq });
            // 해당년도 - 당월누계
            var selectListMonthlyThisYear = pmPalBusinessRepo.selectListMonthlyThisYear(new { YearlyYear = pmPal.PalYear, Monthly = pmPal.Monthly, Seq = pmPal.OrgCompanySeq });

            // 해당년도 - 계획
            var selectListMonthlyPlanThisYear = pmPalBusinessRepo.selectListMonthlyPlanThisYear(new { YearlyYear = pmPal.PalYear, Monthly = pmPal.Monthly, Seq = pmPal.OrgCompanySeq });
            // 해당년도 - 누계실적
            var selectListMonthlyCountThisYear = pmPalBusinessRepo.selectListMonthlyCountThisYear(new { YearlyYear = pmPal.PalYear, Monthly = pmPal.Monthly, Seq = pmPal.OrgCompanySeq });

            // 해당년도 - 연간계획
            var selectListExpectPlanThisYear = pmPalBusinessRepo.selectListExpectPlanThisYear(new { YearlyYear = pmPal.PalYear, Seq = pmPal.OrgCompanySeq });
            // 해당년도 - 연간실적
            var selectListExpectThisYear = pmPalBusinessRepo.selectListExpectThisYear(new { YearlyYear = pmPal.PalYear, Monthly = pmPal.Monthly, Seq = pmPal.OrgCompanySeq });


            dynamic model = new ExpandoObject();

            model.pmPal = pmPal;
            model.orgBusinessList = orgBusinessList;
            model.orgCompanyName = orgCompanyName;

            //전년도 - 연간, 당월, 누계
            model.selectListLastYear = selectListLastYear;

            //계획
            model.selectListPlanThisYear = selectListPlanThisYear;

            //해당년도 - 계획
            model.selectListPlanMonthlyThisYear = selectListPlanMonthlyThisYear;
            //해당년도 - 누계실적
            model.selectListMonthlyThisYear = selectListMonthlyThisYear;

            model.selectListMonthlyPlanThisYear = selectListMonthlyPlanThisYear;
            model.selectListMonthlyCountThisYear = selectListMonthlyCountThisYear;

            //해당연도 - 연간계획, 연간실적
            model.selectListExpectPlanThisYear = selectListExpectPlanThisYear;
            model.selectListExpectThisYear = selectListExpectThisYear;

            return View("~/Views/SiteMngHome/Performance/PalTemp/Write.cshtml", model);
        }

        /// <summary>
        /// 계산하기
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        [Route("Calculation_Action")]
        public ActionResult CalculationAction(PmPalAdmin entity)
        {
            #region
            Dictionary<string, object> postData = new Dictionary<string, object>();
            postData.Add("Seq", entity.Seq);
            postData.Add("OrgCompanySeq", entity.OrgCompanySeq);
            #endregion

            // 부서별 데이터 검증(정수 혹은 소수점 2자리까지의 데이터)
            bool bDoubleValue = true;
            List<PmPalBusiness> pBusinessList = new List<PmPalBusiness>();
            try
            {
                for (int i = 0; i < entity.PmPalBusinessSeq.Count(); i++)
                {
                    if (!WebUtil.CheckDecimalTwo(entity.Sales[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.Ebit[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.Pbt[i].ToString())) { bDoubleValue = false; break; }

                    PmPalBusiness p = new PmPalBusiness();
                    p.Seq = entity.PmPalBusinessSeq[i];
                    p.Sales = entity.Sales[i];
                    p.Ebit = entity.Ebit[i];
                    p.Pbt = entity.Pbt[i];
                    p.MonthlyType = entity.monthlyType[i];

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

            // 부서별 데이터 업데이트
            for (int i = 0; i < pBusinessList.Count(); i++)
            {
                PmPalBusiness p = new PmPalBusiness();
                p.Seq = pBusinessList[i].Seq;
                p.Sales = pBusinessList[i].Sales;
                p.Ebit = pBusinessList[i].Ebit;
                p.Pbt = pBusinessList[i].Pbt;
                //p.MonthlyType = pBusinessList[i].MonthlyType;

                pmPalBusinessRepo.update(p);
            }

            // 계산하기 하였을 경우 기존 데이터 삭제하여 부서별 데이터의 합계를 다시 입력
            PmPalSummary pSum = new PmPalSummary();
            pSum.PmPalSeq = entity.Seq;
            pSum.PalYear = entity.PalYear;
            pSum.Monthly = entity.Monthly;

            pmPalSummaryRepo.delete(pSum);
            pmPalSummaryRepo.insert(pSum);

            //// 미저장에서 저장으로 변경
            //if (entity.RegistStatus == Define.REGIST_STATUS.GetKey("미등록"))
            //{
            //    entity.RegistStatus = Define.REGIST_STATUS.GetKey("저장");
            //    PmPal p = new PmPal();
            //    p.Seq = entity.Seq;
            //    p.RegistStatus = entity.RegistStatus;
            //    pmPalRepo.updateRegist(p);
            //}

            return RedirectAndPostActionResult.RedirectAndPost("Edit", postData);
        }

        [Route("View")]
        public ActionResult view(PmPal entity)
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");

            // 기본 정보 가져온다.
            var pmPal = pmPalRepo.selectOne(entity);
            // 회사 밑에 부서 정보를 가져온다
            //var orgBusinessList = orgBusinessRepo.selectListCompany(new { Seq = entity.OrgCompanySeq });
            var orgBusinessList = orgBusinessRepo.selectListAll(new { orgCompanySeq = entity.OrgCompanySeq });

            var orgCompanyName = orgCompanyRepo.selectOne(new { Seq = entity.OrgCompanySeq });

            //계획
            var selectListPlanThisYear = pmPalBusinessRepo.selectListPlanThisYear(new { YearlyYear = pmPal.PalYear, Monthly = pmPal.Monthly, Seq = pmPal.OrgCompanySeq });

            // 전년도 - 연간, 당월, 누계
            var selectListLastYear = pmPalBusinessRepo.selectListLastYear(new { YearlyYear = pmPal.PalYear, Monthly = pmPal.Monthly, Seq = pmPal.OrgCompanySeq });

            // 해당년도 - 당월계획
            var selectListPlanMonthlyThisYear = pmPalBusinessRepo.selectListPlanMonthlyThisYear(new { YearlyYear = pmPal.PalYear, Monthly = pmPal.Monthly, Seq = pmPal.OrgCompanySeq });
            // 해당년도 - 당월누계
            var selectListMonthlyThisYear = pmPalBusinessRepo.selectListMonthlyThisYear(new { YearlyYear = pmPal.PalYear, Monthly = pmPal.Monthly, Seq = pmPal.OrgCompanySeq });

            // 해당년도 - 계획
            var selectListMonthlyPlanThisYear = pmPalBusinessRepo.selectListMonthlyPlanThisYear(new { YearlyYear = pmPal.PalYear, Monthly = pmPal.Monthly, Seq = pmPal.OrgCompanySeq });
            // 해당년도 - 누계실적
            var selectListMonthlyCountThisYear = pmPalBusinessRepo.selectListMonthlyCountThisYear(new { YearlyYear = pmPal.PalYear, Monthly = pmPal.Monthly, Seq = pmPal.OrgCompanySeq });

            // 해당년도 - 연간계획
            var selectListExpectPlanThisYear = pmPalBusinessRepo.selectListExpectPlanThisYear(new { YearlyYear = pmPal.PalYear, Seq = pmPal.OrgCompanySeq });
            // 해당년도 - 연간실적
            var selectListExpectThisYear = pmPalBusinessRepo.selectListExpectThisYear(new { YearlyYear = pmPal.PalYear, Monthly = pmPal.Monthly, Seq = pmPal.OrgCompanySeq });

            // 현재기준의 Bu만 조인하여 넣는다.
            var orgBusinessList2 = from x in orgBusinessList
                                   join y in selectListMonthlyThisYear on x.Seq equals y.OrgBusinessSeq
                                   group x by new { x.Seq, x.BusinessName } into g
                                   select new OrgBusiness
                                   {
                                       Seq = g.First().Seq,
                                       BusinessName = g.First().BusinessName
                                   };
            orgBusinessList = orgBusinessList2.ToList();


            //손익요약(전년도) - 연간, 당월, 누계
            var selectListSummaryYear = pmPalSummaryRepo.selectListSummaryYear(new { YearlyYear = pmPal.PalYear, Monthly = pmPal.Monthly, Seq = pmPal.OrgCompanySeq });
            //손익요약 - 당월계획
            var selectListPlanSummaryThisYear = pmPalSummaryRepo.selectListPlanSummaryThisYear(new { YearlyYear = pmPal.PalYear, Monthly = pmPal.Monthly, Seq = pmPal.OrgCompanySeq });
            //손익요약 - 당월실적
            var selectListPmPalMonthlySummary = pmPalSummaryRepo.selectListPmPalSummaryThisYear(new
            {
                Seq = pmPal.Seq,
                MonthlyType = Define.MONTHLY_TYPE.GetKey("당월"),
                YearlyYear = pmPal.PalYear,
                Monthly = pmPal.Monthly
            });

            //손익요약 - 당월누계
            var selectListSumSummaryThisYear = pmPalSummaryRepo.selectListSumSummaryThisYear(new { YearlyYear = pmPal.PalYear, Monthly = pmPal.Monthly, Seq = pmPal.OrgCompanySeq });
            //손익요약 - 누계실적
            var selectListPmPalMonthlyResultSummary = pmPalSummaryRepo.selectListPmPalSummaryThisYear(new
            {
                Seq = pmPal.Seq,
                MonthlyType = Define.MONTHLY_TYPE.GetKey("누계"),
                YearlyYear = pmPal.PalYear,
                Monthly = pmPal.Monthly
            });

            //손익요약 - 연간계획
            var selectListExpectSummaryThisYear = pmPalSummaryRepo.selectListExpectThisYear(new { YearlyYear = pmPal.PalYear, Seq = pmPal.OrgCompanySeq });
            //손익요약 - 연간실적
            var selectListExpectResultSummary = pmPalSummaryRepo.selectListPmPalSummaryThisYear(new
            {
                Seq = pmPal.Seq,
                MonthlyType = Define.MONTHLY_TYPE.GetKey("연간"),
                YearlyYear = pmPal.PalYear,
                Monthly = pmPal.Monthly
            });

            //손익분석 - 매출차이
            var selectListAnalysisMonthlyContent = pmPalBusinessRepo.selectListAnalysisMonthlyContent(new
            {
                YearlyYear = pmPal.PalYear,
                Monthly = pmPal.Monthly,
                Seq = pmPal.Seq,
                Analysis = Define.ANALYSIS.GetKey("매출 차이")
            });

            //손익분석 - 영업이익 차이
            var selectListAnalysisMonthlySalesContent = pmPalBusinessRepo.selectListAnalysisMonthlyContent(new
            {
                YearlyYear = pmPal.PalYear,
                Monthly = pmPal.Monthly,
                Seq = pmPal.Seq,
                Analysis = Define.ANALYSIS.GetKey("영업이익 차이")
            });

            //손익분석 - 경상이익 차이
            var selectListAnalysisMonthlyCurrentContent = pmPalBusinessRepo.selectListAnalysisMonthlyContent(new
            {
                YearlyYear = pmPal.PalYear,
                Monthly = pmPal.Monthly,
                Seq = pmPal.Seq,
                Analysis = Define.ANALYSIS.GetKey("경상이익 차이")
            });

            //손익분석 - 당기순이익 차이
            var selectListAnalysisMonthlyTermContent = pmPalBusinessRepo.selectListAnalysisMonthlyContent(new
            {
                YearlyYear = pmPal.PalYear,
                Monthly = pmPal.Monthly,
                Seq = pmPal.Seq,
                Analysis = Define.ANALYSIS.GetKey("당기순이익 차이")
            });

            //연간손익분석 - 매출차이
            var selectListYearAnalysisMonthlyContent = pmPalYealyAnalysisRepo.selectListYearAnalysisMonthlyContent(new
            {
                YearlyYear = pmPal.PalYear,
                Monthly = pmPal.Monthly,
                Seq = pmPal.Seq,
                Analysis = Define.ANALYSIS.GetKey("매출 차이")
            });

            //연간손익분석 - 영업이익 차이
            var selectListYearAnalysisMonthlySalesContent = pmPalYealyAnalysisRepo.selectListYearAnalysisMonthlyContent(new
            {
                YearlyYear = pmPal.PalYear,
                Monthly = pmPal.Monthly,
                Seq = pmPal.Seq,
                Analysis = Define.ANALYSIS.GetKey("영업이익 차이")
            });

            //연간손익분석 - 경상이익 차이
            var selectListYearAnalysisMonthlyCurrentContent = pmPalYealyAnalysisRepo.selectListYearAnalysisMonthlyContent(new
            {
                YearlyYear = pmPal.PalYear,
                Monthly = pmPal.Monthly,
                Seq = pmPal.Seq,
                Analysis = Define.ANALYSIS.GetKey("경상이익 차이")
            });

            //연간손익분석 - 당기순이익 차이
            var selectListYearAnalysisMonthlyTermContent = pmPalYealyAnalysisRepo.selectListYearAnalysisMonthlyContent(new
            {
                YearlyYear = pmPal.PalYear,
                Monthly = pmPal.Monthly,
                Seq = pmPal.Seq,
                Analysis = Define.ANALYSIS.GetKey("당기순이익 차이")
            });

            dynamic model = new ExpandoObject();

            model.pmPal = pmPal;
            model.orgBusinessList = orgBusinessList;
            model.orgCompanyName = orgCompanyName;

            //전년도 - 연간, 당월, 누계
            model.selectListLastYear = selectListLastYear;

            //계획
            model.selectListPlanThisYear = selectListPlanThisYear;

            //해당년도 - 계획
            model.selectListPlanMonthlyThisYear = selectListPlanMonthlyThisYear;
            //해당년도 - 누계실적
            model.selectListMonthlyThisYear = selectListMonthlyThisYear;

            model.selectListMonthlyPlanThisYear = selectListMonthlyPlanThisYear;
            model.selectListMonthlyCountThisYear = selectListMonthlyCountThisYear;

            //해당연도 - 연간계획, 연간실적
            model.selectListExpectPlanThisYear = selectListExpectPlanThisYear;
            model.selectListExpectThisYear = selectListExpectThisYear;

            //전년도 손익 요약 - 연간, 당월, 누계
            model.selectListSummaryYear = selectListSummaryYear;

            //손익 요약 - 당월계획
            model.selectListPlanSummaryThisYear = selectListPlanSummaryThisYear;
            //손익 요약 - 당월실적
            model.selectListPmPalMonthlySummary = selectListPmPalMonthlySummary;

            //손익 요약 - 누계계획
            model.selectListSumSummaryThisYear = selectListSumSummaryThisYear;
            //손익 요약 - 누계실적
            model.selectListPmPalMonthlyResultSummary = selectListPmPalMonthlyResultSummary;

            //손익 요약 - 연간계획
            model.selectListExpectSummaryThisYear = selectListExpectSummaryThisYear;
            //손익 요약 = 연간실적
            model.selectListExpectResultSummary = selectListExpectResultSummary;

            //손익 분석 - 매출차이
            model.selectListAnalysisMonthlyContent = selectListAnalysisMonthlyContent;
            //손익 분석 - 영업이익 차이
            model.selectListAnalysisMonthlySalesContent = selectListAnalysisMonthlySalesContent;
            //손익 분석 - 경상이익 차이
            model.selectListAnalysisMonthlyCurrentContent = selectListAnalysisMonthlyCurrentContent;
            //손익 분석 - 당기순이익 차이
            model.selectListAnalysisMonthlyTermContent = selectListAnalysisMonthlyTermContent;


            //연간 손익 분석 - 매출차이
            model.selectListYearAnalysisMonthlyContent = selectListYearAnalysisMonthlyContent;
            //연간 손익 분석 - 영업이익 차이
            model.selectListYearAnalysisMonthlySalesContent = selectListYearAnalysisMonthlySalesContent;
            //연간 손익 분석 - 경상이익 차이
            model.selectListYearAnalysisMonthlyCurrentContent = selectListYearAnalysisMonthlyCurrentContent;
            //연간 손익 분석 - 당기순이익 차이
            model.selectListYearAnalysisMonthlyTermContent = selectListYearAnalysisMonthlyTermContent;

            return View("~/Views/SiteMngHome/Performance/PalTemp/View.cshtml", model);
        }

        [Route("Edit")]
        public ActionResult Edit(PmPal entity)
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");

            // 기본 정보 가져온다.
            var pmPal = pmPalRepo.selectOne(entity);
            // 회사 밑에 부서 정보를 가져온다
            //var orgBusinessList = orgBusinessRepo.selectListCompany(new { Seq = entity.OrgCompanySeq });
            var orgBusinessList = orgBusinessRepo.selectListAll(new { orgCompanySeq = entity.OrgCompanySeq });

            var orgCompanyName = orgCompanyRepo.selectOne(new { Seq = entity.OrgCompanySeq });

            //계획
            var selectListPlanThisYear = pmPalBusinessRepo.selectListPlanThisYear(new { YearlyYear = pmPal.PalYear, Monthly = pmPal.Monthly, Seq = pmPal.OrgCompanySeq });

            // 전년도 - 연간, 당월, 누계
            var selectListLastYear = pmPalBusinessRepo.selectListLastYear(new { YearlyYear = pmPal.PalYear, Monthly = pmPal.Monthly, Seq = pmPal.OrgCompanySeq });

            // 해당년도 - 당월계획
            var selectListPlanMonthlyThisYear = pmPalBusinessRepo.selectListPlanMonthlyThisYear(new { YearlyYear = pmPal.PalYear, Monthly = pmPal.Monthly, Seq = pmPal.OrgCompanySeq });
            // 해당년도 - 당월실적
            var selectListMonthlyThisYear = pmPalBusinessRepo.selectListMonthlyThisYear(new { YearlyYear = pmPal.PalYear, Monthly = pmPal.Monthly, Seq = pmPal.OrgCompanySeq });

            // 해당년도 - 계획
            var selectListMonthlyPlanThisYear = pmPalBusinessRepo.selectListMonthlyPlanThisYear(new { YearlyYear = pmPal.PalYear, Monthly = pmPal.Monthly, Seq = pmPal.OrgCompanySeq });
            // 해당년도 - 누계실적
            var selectListMonthlyCountThisYear = pmPalBusinessRepo.selectListMonthlyCountThisYear(new { YearlyYear = pmPal.PalYear, Monthly = pmPal.Monthly, Seq = pmPal.OrgCompanySeq });

            // 해당년도 - 연간계획
            var selectListExpectPlanThisYear = pmPalBusinessRepo.selectListExpectPlanThisYear(new { YearlyYear = pmPal.PalYear, Seq = pmPal.OrgCompanySeq });
            // 해당년도 - 연간실적
            var selectListExpectThisYear = pmPalBusinessRepo.selectListExpectThisYear(new { YearlyYear = pmPal.PalYear, Monthly = pmPal.Monthly, Seq = pmPal.OrgCompanySeq });

            // 현재기준의 Bu만 조인하여 넣는다.
            var orgBusinessList2 = from x in orgBusinessList
                                   join y in selectListMonthlyThisYear on x.Seq equals y.OrgBusinessSeq
                                   group x by new { x.Seq, x.BusinessName } into g
                                   select new OrgBusiness
                                   {
                                       Seq = g.First().Seq,
                                       BusinessName = g.First().BusinessName
                                   };
            orgBusinessList = orgBusinessList2.ToList();

            //손익요약(전년도) - 연간, 당월, 누계
            var selectListSummaryYear = pmPalSummaryRepo.selectListSummaryYear(new { YearlyYear = pmPal.PalYear, Monthly = pmPal.Monthly, Seq = pmPal.OrgCompanySeq });
            //손익요약 - 당월계획
            var selectListPlanSummaryThisYear = pmPalSummaryRepo.selectListPlanSummaryThisYear(new { YearlyYear = pmPal.PalYear, Monthly = pmPal.Monthly, Seq = pmPal.OrgCompanySeq });
            //손익요약 - 당월실적
            var selectListPmPalMonthlySummary = pmPalSummaryRepo.selectListPmPalSummaryThisYear(new
            {
                Seq = pmPal.Seq,
                MonthlyType = Define.MONTHLY_TYPE.GetKey("당월"),
                YearlyYear = pmPal.PalYear,
                Monthly = pmPal.Monthly
            });

            //손익요약 - 당월누계
            var selectListSumSummaryThisYear = pmPalSummaryRepo.selectListSumSummaryThisYear(new { YearlyYear = pmPal.PalYear, Monthly = pmPal.Monthly, Seq = pmPal.OrgCompanySeq });
            //손익요약 - 누계실적
            var selectListPmPalMonthlyResultSummary = pmPalSummaryRepo.selectListPmPalSummaryThisYear(new
            {
                Seq = pmPal.Seq,
                MonthlyType = Define.MONTHLY_TYPE.GetKey("누계"),
                YearlyYear = pmPal.PalYear,
                Monthly = pmPal.Monthly
            });

            //손익요약 - 연간계획
            var selectListExpectSummaryThisYear = pmPalSummaryRepo.selectListExpectThisYear(new { YearlyYear = pmPal.PalYear, Seq = pmPal.OrgCompanySeq });
            //손익요약 - 연간실적
            var selectListExpectResultSummary = pmPalSummaryRepo.selectListPmPalSummaryThisYear(new
            {
                Seq = pmPal.Seq,
                MonthlyType = Define.MONTHLY_TYPE.GetKey("연간"),
                YearlyYear = pmPal.PalYear,
                Monthly = pmPal.Monthly
            });

            #region #.손익분석

            //손익분석 - 매출차이
            IEnumerable<PmPalAnalysis> selectListAnalysisMonthlyContent = null;
            //손익분석 - 영업이익 차이
            IEnumerable<PmPalAnalysis> selectListAnalysisMonthlySalesContent = null;
            //손익분석 - 경상이익 차이
            IEnumerable<PmPalAnalysis> selectListAnalysisMonthlyCurrentContent = null;
            //손익분석 - 당기순이익 차이
            IEnumerable<PmPalAnalysis> selectListAnalysisMonthlyTermContent = null;

            //손익분석 - 매출차이
            selectListAnalysisMonthlyContent = pmPalBusinessRepo.selectListAnalysisMonthlyContent(new
            {
                YearlyYear = pmPal.PalYear,
                Monthly = pmPal.Monthly,
                Seq = pmPal.Seq,
                Analysis = Define.ANALYSIS.GetKey("매출 차이")
            });

            //데이터가 없을시 전월 데이터를 바인딩 합니다.
            if (selectListAnalysisMonthlyContent == null || selectListAnalysisMonthlyContent.Count() == 0)
            {
                if (pmPal.Monthly == "01")
                {
                    //손익분석 - 매출차이
                    selectListAnalysisMonthlyContent = pmPalBusinessRepo.selectListAnalysisMonthlyContent(new
                    {
                        YearlyYear = Convert.ToInt32(pmPal.PalYear) - 1,
                        Monthly = 12,
                        Seq = pmPal.Seq,
                        Analysis = Define.ANALYSIS.GetKey("매출 차이")
                    });
                }
                else
                {
                    //손익분석 - 매출차이
                    selectListAnalysisMonthlyContent = pmPalBusinessRepo.selectListAnalysisMonthlyContent(new
                    {
                        YearlyYear = pmPal.PalYear,
                        Monthly = Convert.ToInt32(pmPal.Monthly) - 1,
                        Seq = pmPal.Seq,
                        Analysis = Define.ANALYSIS.GetKey("매출 차이")
                    });
                }
            }

            //손익분석 - 영업이익 차이
            selectListAnalysisMonthlySalesContent = pmPalBusinessRepo.selectListAnalysisMonthlyContent(new
            {
                YearlyYear = pmPal.PalYear,
                Monthly = pmPal.Monthly,
                Seq = pmPal.Seq,
                Analysis = Define.ANALYSIS.GetKey("영업이익 차이")
            });

            //데이터가 없을시 전월 데이터를 바인딩 합니다.
            if (selectListAnalysisMonthlySalesContent == null || selectListAnalysisMonthlySalesContent.Count() == 0)
            {
                if (pmPal.Monthly == "01")
                {
                    //손익분석 - 매출차이
                    selectListAnalysisMonthlySalesContent = pmPalBusinessRepo.selectListAnalysisMonthlyContent(new
                    {
                        YearlyYear = Convert.ToInt32(pmPal.PalYear) - 1,
                        Monthly = 12,
                        Seq = pmPal.Seq,
                        Analysis = Define.ANALYSIS.GetKey("영업이익 차이")
                    });
                }
                else
                {
                    //손익분석 - 매출차이
                    selectListAnalysisMonthlySalesContent = pmPalBusinessRepo.selectListAnalysisMonthlyContent(new
                    {
                        YearlyYear = pmPal.PalYear,
                        Monthly = Convert.ToInt32(pmPal.Monthly) - 1,
                        Seq = pmPal.Seq,
                        Analysis = Define.ANALYSIS.GetKey("영업이익 차이")
                    });
                }
            }

            //손익분석 - 경상이익 차이
            selectListAnalysisMonthlyCurrentContent = pmPalBusinessRepo.selectListAnalysisMonthlyContent(new
            {
                YearlyYear = pmPal.PalYear,
                Monthly = pmPal.Monthly,
                Seq = pmPal.Seq,
                Analysis = Define.ANALYSIS.GetKey("경상이익 차이")
            });

            //데이터가 없을시 전월 데이터를 바인딩 합니다.
            if (selectListAnalysisMonthlyCurrentContent == null || selectListAnalysisMonthlyCurrentContent.Count() == 0)
            {
                if (pmPal.Monthly == "01")
                {
                    //손익분석 - 매출차이
                    selectListAnalysisMonthlyCurrentContent = pmPalBusinessRepo.selectListAnalysisMonthlyContent(new
                    {
                        YearlyYear = Convert.ToInt32(pmPal.PalYear) - 1,
                        Monthly = 12,
                        Seq = pmPal.Seq,
                        Analysis = Define.ANALYSIS.GetKey("경상이익 차이")
                    });
                }
                else
                {
                    //손익분석 - 매출차이
                    selectListAnalysisMonthlyCurrentContent = pmPalBusinessRepo.selectListAnalysisMonthlyContent(new
                    {
                        YearlyYear = pmPal.PalYear,
                        Monthly = Convert.ToInt32(pmPal.Monthly) - 1,
                        Seq = pmPal.Seq,
                        Analysis = Define.ANALYSIS.GetKey("경상이익 차이")
                    });
                }
            }

            //손익분석 - 당기순이익 차이
            selectListAnalysisMonthlyTermContent = pmPalBusinessRepo.selectListAnalysisMonthlyContent(new
            {
                YearlyYear = pmPal.PalYear,
                Monthly = pmPal.Monthly,
                Seq = pmPal.Seq,
                Analysis = Define.ANALYSIS.GetKey("당기순이익 차이")
            });

            //데이터가 없을시 전월 데이터를 바인딩 합니다.
            if (selectListAnalysisMonthlyTermContent == null || selectListAnalysisMonthlyTermContent.Count() == 0)
            {
                if (pmPal.Monthly == "01")
                {
                    //손익분석 - 매출차이
                    selectListAnalysisMonthlyTermContent = pmPalBusinessRepo.selectListAnalysisMonthlyContent(new
                    {
                        YearlyYear = Convert.ToInt32(pmPal.PalYear) - 1,
                        Monthly = 12,
                        Seq = pmPal.Seq,
                        Analysis = Define.ANALYSIS.GetKey("당기순이익 차이")
                    });
                }
                else
                {
                    //손익분석 - 매출차이
                    selectListAnalysisMonthlyTermContent = pmPalBusinessRepo.selectListAnalysisMonthlyContent(new
                    {
                        YearlyYear = pmPal.PalYear,
                        Monthly = Convert.ToInt32(pmPal.Monthly) - 1,
                        Seq = pmPal.Seq,
                        Analysis = Define.ANALYSIS.GetKey("당기순이익 차이")
                    });
                }
            }

            #endregion

            #region #.연간손익분석

            //연간손익분석 - 매출차이
            IEnumerable<PmPalYealyAnalysis> selectListYearAnalysisMonthlyContent = null;
            //연간손익분석 - 영업이익 차이
            IEnumerable<PmPalYealyAnalysis> selectListYearAnalysisMonthlySalesContent = null;
            //연간손익분석 - 경상이익 차이
            IEnumerable<PmPalYealyAnalysis> selectListYearAnalysisMonthlyCurrentContent = null;
            //연간손익분석 - 당기순이익 차이
            IEnumerable<PmPalYealyAnalysis> selectListYearAnalysisMonthlyTermContent = null;

            //연간손익분석 - 매출차이
            selectListYearAnalysisMonthlyContent = pmPalYealyAnalysisRepo.selectListYearAnalysisMonthlyContent(new
            {
                YearlyYear = pmPal.PalYear,
                Monthly = pmPal.Monthly,
                Seq = pmPal.Seq,
                Analysis = Define.ANALYSIS.GetKey("매출 차이")
            });

            //데이터가 없을시 전월 데이터를 바인딩 합니다.
            if (selectListYearAnalysisMonthlyContent == null || selectListYearAnalysisMonthlyContent.Count() == 0)
            {
                if (pmPal.Monthly == "01")
                {
                    //손익분석 - 매출차이
                    selectListYearAnalysisMonthlyContent = pmPalYealyAnalysisRepo.selectListYearAnalysisMonthlyContent(new
                    {
                        YearlyYear = Convert.ToInt32(pmPal.PalYear) - 1,
                        Monthly = 12,
                        Seq = pmPal.Seq,
                        Analysis = Define.ANALYSIS.GetKey("매출 차이")
                    });
                }
                else
                {
                    //손익분석 - 매출차이
                    selectListYearAnalysisMonthlyContent = pmPalYealyAnalysisRepo.selectListYearAnalysisMonthlyContent(new
                    {
                        YearlyYear = pmPal.PalYear,
                        Monthly = Convert.ToInt32(pmPal.Monthly) - 1,
                        Seq = pmPal.Seq,
                        Analysis = Define.ANALYSIS.GetKey("매출 차이")
                    });
                }
            }

            //연간손익분석 - 영업이익 차이
            selectListYearAnalysisMonthlySalesContent = pmPalYealyAnalysisRepo.selectListYearAnalysisMonthlyContent(new
            {
                YearlyYear = pmPal.PalYear,
                Monthly = pmPal.Monthly,
                Seq = pmPal.Seq,
                Analysis = Define.ANALYSIS.GetKey("영업이익 차이")
            });

            //데이터가 없을시 전월 데이터를 바인딩 합니다.
            if (selectListYearAnalysisMonthlySalesContent == null || selectListYearAnalysisMonthlySalesContent.Count() == 0)
            {
                if (pmPal.Monthly == "01")
                {
                    //손익분석 - 영업이익 차이
                    selectListYearAnalysisMonthlySalesContent = pmPalYealyAnalysisRepo.selectListYearAnalysisMonthlyContent(new
                    {
                        YearlyYear = Convert.ToInt32(pmPal.PalYear) - 1,
                        Monthly = 12,
                        Seq = pmPal.Seq,
                        Analysis = Define.ANALYSIS.GetKey("영업이익 차이")
                    });
                }
                else
                {
                    //손익분석 - 영업이익 차이
                    selectListYearAnalysisMonthlySalesContent = pmPalYealyAnalysisRepo.selectListYearAnalysisMonthlyContent(new
                    {
                        YearlyYear = pmPal.PalYear,
                        Monthly = Convert.ToInt32(pmPal.Monthly) - 1,
                        Seq = pmPal.Seq,
                        Analysis = Define.ANALYSIS.GetKey("영업이익 차이")
                    });
                }
            }

            //연간손익분석 - 경상이익 차이
            selectListYearAnalysisMonthlyCurrentContent = pmPalYealyAnalysisRepo.selectListYearAnalysisMonthlyContent(new
            {
                YearlyYear = pmPal.PalYear,
                Monthly = pmPal.Monthly,
                Seq = pmPal.Seq,
                Analysis = Define.ANALYSIS.GetKey("경상이익 차이")
            });

            //데이터가 없을시 전월 데이터를 바인딩 합니다.
            if (selectListYearAnalysisMonthlyCurrentContent == null || selectListYearAnalysisMonthlyCurrentContent.Count() == 0)
            {
                if (pmPal.Monthly == "01")
                {
                    //연간손익분석 - 경상이익 차이
                    selectListYearAnalysisMonthlyCurrentContent = pmPalYealyAnalysisRepo.selectListYearAnalysisMonthlyContent(new
                    {
                        YearlyYear = Convert.ToInt32(pmPal.PalYear) - 1,
                        Monthly = 12,
                        Seq = pmPal.Seq,
                        Analysis = Define.ANALYSIS.GetKey("경상이익 차이")
                    });
                }
                else
                {
                    //연간손익분석 - 경상이익 차이
                    selectListYearAnalysisMonthlyCurrentContent = pmPalYealyAnalysisRepo.selectListYearAnalysisMonthlyContent(new
                    {
                        YearlyYear = pmPal.PalYear,
                        Monthly = Convert.ToInt32(pmPal.Monthly) - 1,
                        Seq = pmPal.Seq,
                        Analysis = Define.ANALYSIS.GetKey("경상이익 차이")
                    });
                }
            }

            //연간손익분석 - 당기순이익 차이
            selectListYearAnalysisMonthlyTermContent = pmPalYealyAnalysisRepo.selectListYearAnalysisMonthlyContent(new
            {
                YearlyYear = pmPal.PalYear,
                Monthly = pmPal.Monthly,
                Seq = pmPal.Seq,
                Analysis = Define.ANALYSIS.GetKey("당기순이익 차이")
            });

            //데이터가 없을시 전월 데이터를 바인딩 합니다.
            if (selectListYearAnalysisMonthlyTermContent == null || selectListYearAnalysisMonthlyTermContent.Count() == 0)
            {
                if (pmPal.Monthly == "01")
                {
                    //연간손익분석 - 당기순이익 차이
                    selectListYearAnalysisMonthlyTermContent = pmPalYealyAnalysisRepo.selectListYearAnalysisMonthlyContent(new
                    {
                        YearlyYear = Convert.ToInt32(pmPal.PalYear) - 1,
                        Monthly = 12,
                        Seq = pmPal.Seq,
                        Analysis = Define.ANALYSIS.GetKey("당기순이익 차이")
                    });
                }
                else
                {
                    //연간손익분석 - 당기순이익 차이
                    selectListYearAnalysisMonthlyTermContent = pmPalYealyAnalysisRepo.selectListYearAnalysisMonthlyContent(new
                    {
                        YearlyYear = pmPal.PalYear,
                        Monthly = Convert.ToInt32(pmPal.Monthly) - 1,
                        Seq = pmPal.Seq,
                        Analysis = Define.ANALYSIS.GetKey("당기순이익 차이")
                    });
                }
            }

            #endregion

            dynamic model = new ExpandoObject();

            model.pmPal = pmPal;
            model.orgBusinessList = orgBusinessList;
            model.orgCompanyName = orgCompanyName;

            //전년도 - 연간, 당월, 누계
            model.selectListLastYear = selectListLastYear;

            //계획
            model.selectListPlanThisYear = selectListPlanThisYear;

            //해당년도 - 계획
            model.selectListPlanMonthlyThisYear = selectListPlanMonthlyThisYear;
            //해당년도 - 실적
            model.selectListMonthlyThisYear = selectListMonthlyThisYear;

            model.selectListMonthlyPlanThisYear = selectListMonthlyPlanThisYear;
            model.selectListMonthlyCountThisYear = selectListMonthlyCountThisYear;

            //해당연도 - 연간계획, 연간실적
            model.selectListExpectPlanThisYear = selectListExpectPlanThisYear;
            model.selectListExpectThisYear = selectListExpectThisYear;

            //전년도 손익 요약 - 연간, 당월, 누계
            model.selectListSummaryYear = selectListSummaryYear;

            //손익 요약 - 당월계획
            model.selectListPlanSummaryThisYear = selectListPlanSummaryThisYear;
            //손익 요약 - 당월실적
            model.selectListPmPalMonthlySummary = selectListPmPalMonthlySummary;

            //손익 요약 - 누계계획
            model.selectListSumSummaryThisYear = selectListSumSummaryThisYear;
            //손익 요약 - 누계실적
            model.selectListPmPalMonthlyResultSummary = selectListPmPalMonthlyResultSummary;

            //손익 요약 - 연간계획
            model.selectListExpectSummaryThisYear = selectListExpectSummaryThisYear;
            //손익 요약 = 연간실적
            model.selectListExpectResultSummary = selectListExpectResultSummary;

            //손익분석 - 매출차이
            model.selectListAnalysisMonthlyContent = selectListAnalysisMonthlyContent;
            //손익분석 - 영업이익 차이
            model.selectListAnalysisMonthlySalesContent = selectListAnalysisMonthlySalesContent;
            //손익분석 - 경상이익 차이
            model.selectListAnalysisMonthlyCurrentContent = selectListAnalysisMonthlyCurrentContent;
            //손익분석 - 당기손이익 차이
            model.selectListAnalysisMonthlyTermContent = selectListAnalysisMonthlyTermContent;

            //연간손익분석 - 매출차이
            model.selectListYearAnalysisMonthlyContent = selectListYearAnalysisMonthlyContent;
            //연간손익분석 - 영업이익 차이
            model.selectListYearAnalysisMonthlySalesContent = selectListYearAnalysisMonthlySalesContent;
            //연간손익분석 - 경상이익 차이
            model.selectListYearAnalysisMonthlyCurrentContent = selectListYearAnalysisMonthlyCurrentContent;
            //연간손익분석 - 당기순이익 차이
            model.selectListYearAnalysisMonthlyTermContent = selectListYearAnalysisMonthlyTermContent;


            return View("~/Views/SiteMngHome/Performance/PalTemp/Edit.cshtml", model);
        }

        [Route("Edit_Action")]
        public ActionResult EditAction(PmPalAdmin entity)
        {
            #region
            Dictionary<string, object> postData = new Dictionary<string, object>();
            postData.Add("Seq", entity.Seq);
            postData.Add("OrgCompanySeq", entity.OrgCompanySeq);
            #endregion

            // 부서별 데이터 검증(정수 혹은 소수점 2자리까지의 데이터)
            bool bDoubleValue = true;
            List<PmPalBusiness> pBusinessList = new List<PmPalBusiness>();
            List<PmPalSummary> pBusinessSummaryList = new List<PmPalSummary>();

            try
            {
                for (int i = 0; i < entity.PmPalBusinessSeq.Count(); i++)
                {
                    if (!WebUtil.CheckDecimalTwo(entity.Sales[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.Ebit[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.Pbt[i].ToString())) { bDoubleValue = false; break; }

                    PmPalBusiness p = new PmPalBusiness();
                    p.Seq = entity.PmPalBusinessSeq[i];
                    p.Sales = entity.Sales[i];
                    p.Ebit = entity.Ebit[i];
                    p.Pbt = entity.Pbt[i];
                    p.MonthlyType = entity.monthlyType[i];

                    pBusinessList.Add(p);
                }


                for (int i = 0; i < entity.PmPalSummarySeq.Count(); i++)
                {
                    if (!WebUtil.CheckDecimalTwo(entity.SalesSummary[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.EbitSummary[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.PbtSummary[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.NetProfitTermSummary[i].ToString())) { bDoubleValue = false; break; }

                    PmPalSummary p = new PmPalSummary();

                    p.Seq = entity.PmPalSummarySeq[i];
                    p.Sales = entity.SalesSummary[i];
                    p.Ebit = entity.EbitSummary[i];
                    p.Pbt = entity.PbtSummary[i];
                    p.NetProfitTerm = entity.NetProfitTermSummary[i];

                    pBusinessSummaryList.Add(p);
                }

                #region #.손익분석

                //손익분석 - 매출차이
                PmPalAnalysis d1 = new PmPalAnalysis();
                d1.PalYear = entity.PalYear;
                d1.Monthly = entity.Monthly;
                d1.Analysis = Define.ANALYSIS.GetKey("매출 차이");
                pmPalAnalysisRepo.delete(d1);

                for (int i = 0; i <= entity.MonthlyCount - 1; i++)
                {
                    PmPalAnalysis p = new PmPalAnalysis();

                    p.PmPalSeq = entity.Seq;
                    p.Analysis = Define.ANALYSIS.GetKey("매출 차이");
                    p.MonthlyContent = entity.MonthlyContent[i] ?? string.Empty;
                    p.MonthlyValue = (decimal?)entity.MonthlyValue[i] ?? 0;
                    p.CumulativeContent = entity.CumulativeContent[i] ?? string.Empty;
                    p.CumulativeValue = (decimal?)entity.CumulativeValue[i] ?? 0;

                    pmPalAnalysisRepo.insert(p);
                }

                //손익분석 - 영업이익 차이
                PmPalAnalysis d2 = new PmPalAnalysis();
                d2.PalYear = entity.PalYear;
                d2.Monthly = entity.Monthly;
                d2.Analysis = Define.ANALYSIS.GetKey("영업이익 차이");
                pmPalAnalysisRepo.delete(d2);

                for (int i = 0; i <= entity.SalesMonthlyCount - 1; i++)
                {
                    PmPalAnalysis p = new PmPalAnalysis();

                    p.PmPalSeq = entity.Seq;
                    p.Analysis = Define.ANALYSIS.GetKey("영업이익 차이");
                    p.MonthlyContent = entity.SalesMonthlyContent[i] ?? string.Empty;
                    p.MonthlyValue = (decimal?)entity.SalesMonthlyValue[i] ?? 0;
                    p.CumulativeContent = entity.SalesCumulativeContent[i] ?? string.Empty;
                    p.CumulativeValue = (decimal?)entity.SalesCumulativeValue[i] ?? 0;

                    pmPalAnalysisRepo.insert(p);
                }

                //손익분석 - 경상이익 차이
                PmPalAnalysis d3 = new PmPalAnalysis();
                d3.PalYear = entity.PalYear;
                d3.Monthly = entity.Monthly;
                d3.Analysis = Define.ANALYSIS.GetKey("경상이익 차이");
                pmPalAnalysisRepo.delete(d3);

                for (int i = 0; i <= entity.CurrentMonthlyCount - 1; i++)
                {
                    PmPalAnalysis p = new PmPalAnalysis();

                    p.PmPalSeq = entity.Seq;
                    p.Analysis = Define.ANALYSIS.GetKey("경상이익 차이");
                    p.MonthlyContent = entity.CurrentMonthlyContent[i] ?? string.Empty;
                    p.MonthlyValue = (decimal?)entity.CurrentMonthlyValue[i] ?? 0;
                    p.CumulativeContent = entity.CurrentCumulativeContent[i] ?? string.Empty;
                    p.CumulativeValue = (decimal?)entity.CurrentCumulativeValue[i] ?? 0;

                    pmPalAnalysisRepo.insert(p);
                }

                //손익분석 - 당기순이익 차이
                PmPalAnalysis d4 = new PmPalAnalysis();
                d4.PalYear = entity.PalYear;
                d4.Monthly = entity.Monthly;
                d4.Analysis = Define.ANALYSIS.GetKey("당기순이익 차이");
                pmPalAnalysisRepo.delete(d4);

                for (int i = 0; i <= entity.TermMonthlyCount - 1; i++)
                {
                    PmPalAnalysis p = new PmPalAnalysis();

                    p.PmPalSeq = entity.Seq;
                    p.Analysis = Define.ANALYSIS.GetKey("당기순이익 차이");
                    p.MonthlyContent = entity.TermMonthlyContent[i] ?? string.Empty;
                    p.MonthlyValue = (decimal?)entity.TermMonthlyValue[i] ?? 0;
                    p.CumulativeContent = entity.TermCumulativeContent[i] ?? string.Empty;
                    p.CumulativeValue = (decimal?)entity.TermCumulativeValue[i] ?? 0;

                    pmPalAnalysisRepo.insert(p);
                }


                #endregion

                #region #.연간예상분석

                //연간손익분석 - 매출차이
                PmPalYealyAnalysis dy1 = new PmPalYealyAnalysis();
                dy1.PalYear = entity.PalYear;
                dy1.Monthly = entity.Monthly;
                dy1.Analysis = Define.ANALYSIS.GetKey("매출 차이");
                pmPalYealyAnalysisRepo.delete(dy1);

                for (int i = 0; i <= entity.YealyCount - 1; i++)
                {
                    PmPalYealyAnalysis p = new PmPalYealyAnalysis();

                    p.PmPalSeq = entity.Seq;
                    p.Analysis = Define.ANALYSIS.GetKey("매출 차이");
                    p.MonthlyContent = entity.DiffMonthlyContent[i] ?? "0";
                    p.MonthlyValue = (decimal?)entity.DiffMonthlyValue[i] ?? 0;
                    p.YealyContent = entity.DiffYealyContent[i] ?? "0";
                    p.YealyValue = (decimal?)entity.DiffYealyValue[i] ?? 0;

                    pmPalYealyAnalysisRepo.insert(p);
                }


                //연간손익분석 - 영업이익 차이
                PmPalYealyAnalysis dy2 = new PmPalYealyAnalysis();
                dy2.PalYear = entity.PalYear;
                dy2.Monthly = entity.Monthly;
                dy2.Analysis = Define.ANALYSIS.GetKey("영업이익 차이");
                pmPalYealyAnalysisRepo.delete(dy2);

                for (int i = 0; i <= entity.SalesYealyCount - 1; i++)
                {
                    PmPalYealyAnalysis p = new PmPalYealyAnalysis();

                    p.PmPalSeq = entity.Seq;
                    p.Analysis = Define.ANALYSIS.GetKey("영업이익 차이");
                    p.MonthlyContent = entity.DiffSalesMonthlyContent[i] ?? string.Empty;
                    p.MonthlyValue = (decimal?)entity.DiffSalesMonthlyValue[i] ?? 0;
                    p.YealyContent = entity.DiffSalesYealyContent[i] ?? string.Empty;
                    p.YealyValue = (decimal?)entity.DiffSalesYealyValue[i] ?? 0;

                    pmPalYealyAnalysisRepo.insert(p);
                }


                //연간손익분석 - 경상이익 차이 
                PmPalYealyAnalysis dy3 = new PmPalYealyAnalysis();
                dy3.PalYear = entity.PalYear;
                dy3.Monthly = entity.Monthly;
                dy3.Analysis = Define.ANALYSIS.GetKey("경상이익 차이");
                pmPalYealyAnalysisRepo.delete(dy3);

                for (int i = 0; i <= entity.CurrentYealyCount - 1; i++)
                {
                    PmPalYealyAnalysis p = new PmPalYealyAnalysis();

                    p.PmPalSeq = entity.Seq;
                    p.Analysis = Define.ANALYSIS.GetKey("경상이익 차이");
                    p.MonthlyContent = entity.DiffCurrentMonthlyContent[i] ?? string.Empty;
                    p.MonthlyValue = (decimal?)entity.DiffCurrentMonthlyValue[i] ?? 0;
                    p.YealyContent = entity.DiffCurrentYealyContent[i] ?? string.Empty;
                    p.YealyValue = (decimal?)entity.DiffCurrentYealyValue[i] ?? 0;

                    pmPalYealyAnalysisRepo.insert(p);
                }

                //연간손익분석 - 당기순이익 차이
                PmPalYealyAnalysis dy4 = new PmPalYealyAnalysis();
                dy4.PalYear = entity.PalYear;
                dy4.Monthly = entity.Monthly;
                dy4.Analysis = Define.ANALYSIS.GetKey("당기순이익 차이");
                pmPalYealyAnalysisRepo.delete(dy4);

                for (int i = 0; i <= entity.TermYealyCount - 1; i++)
                {
                    PmPalYealyAnalysis p = new PmPalYealyAnalysis();

                    p.PmPalSeq = entity.Seq;
                    p.Analysis = Define.ANALYSIS.GetKey("당기순이익 차이");
                    p.MonthlyContent = entity.DiffTermMonthlyContent[i] ?? string.Empty;
                    p.MonthlyValue = (decimal?)entity.DiffTermMonthlyValue[i] ?? 0;
                    p.YealyContent = entity.DiffTermYealyContent[i] ?? string.Empty;
                    p.YealyValue = (decimal?)entity.DiffTermYealyValue[i] ?? 0;


                    pmPalYealyAnalysisRepo.insert(p);
                }

                #endregion
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
                PmPalBusiness p = new PmPalBusiness();
                p.Seq = pBusinessList[i].Seq;
                p.Sales = pBusinessList[i].Sales;
                p.Ebit = pBusinessList[i].Ebit;
                p.Pbt = pBusinessList[i].Pbt;
                p.MonthlyType = pBusinessList[i].MonthlyType;

                pmPalBusinessRepo.update(p);
            }

            //요약 업데이트
            for (int i = 0; i < pBusinessSummaryList.Count(); i++)
            {
                PmPalSummary p = new PmPalSummary();

                p.Seq = entity.PmPalSummarySeq[i];
                p.Sales = entity.SalesSummary[i];
                p.Ebit = entity.EbitSummary[i];
                p.Pbt = entity.PbtSummary[i];
                p.NetProfitTerm = entity.NetProfitTermSummary[i];
                p.LiabilitiesRateComment = entity.LiabilitiesRateComment;
                pmPalSummaryRepo.update(p);
            }


            // 미저장에서 저장으로 변경
            if (entity.RegistStatus == Define.REGIST_STATUS.GetKey("미등록"))
            {
                entity.RegistStatus = Define.REGIST_STATUS.GetKey("저장");
                PmPal p = new PmPal();
                p.Seq = entity.Seq;
                p.RegistStatus = entity.RegistStatus;
                pmPalRepo.updateRegist(p);
            }

            return RedirectAndPostActionResult.RedirectAndPost("Edit", postData);
        }

        /// <summary>
        /// 승인요청, 승인, 반려등의 상태 변경
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        [Route("Regist_Status_Change")]
        public ActionResult RegistStatusChange(PmPal entity)
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");

            #region
            Dictionary<string, object> postData = new Dictionary<string, object>();
            postData.Add("Seq", entity.Seq);
            postData.Add("OrgCompanySeq", entity.OrgCompanySeq);
            postData.Add("message", entity.message);
            #endregion

            // 현재 상태값을 변경한다.
            entity.RegistStatus = entity.afterRegistStatus;
            pmPalRepo.updateRegist(entity);

            // 현재의 상태 변경 후 담당자들에게 메일 발송합니다.(2018.11.08)
            var info = pmPalRepo.selectOne(entity);

            MailInfo mInfo = new MailInfo();
            mInfo.afterRegistStatus = entity.afterRegistStatus;
            mInfo.OrgCompanySeq = entity.OrgCompanySeq;
            mInfo.menuName = "손익";
            mInfo.year = info.PalYear;
            mInfo.mm = info.Monthly;
            MailUtil.RegistStatusMail(mInfo);

            return RedirectToAction("List");
        }

        /// <summary>
        /// 엑셀 양식 다운로드
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        [Route("Excel_Down")]
        public ActionResult ExcelDown(PmPal entity)
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");

            var pmPal = pmPalRepo.selectOne(entity);
            var orgCompanyName = orgCompanyRepo.selectOne(new { Seq = entity.OrgCompanySeq });
            var pBusinessList = pmPalBusinessRepo.selectListExcel(new { PmPalSeq = entity.Seq });

            string fileName = "손익_" + pmPal.PalYear + "년_" + orgCompanyName.CompanyName;

            int rows = 1, cells = 1;

            using (XLWorkbook wb = new XLWorkbook())
            {
                var ws = wb.Worksheets.Add("손익");

                // 해더 선언
                var wsHeader = ws.Cell(rows, cells);
                var wsHeaderStyle = wsHeader.Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                ws.Cell(rows, cells).SetValue("ParentSeq").Style = wsHeaderStyle;
                ws.Cell(rows, ++cells).SetValue("Seq").Style = wsHeaderStyle;
                ws.Cell(rows, ++cells).SetValue("CompanyName").Style = wsHeaderStyle;
                ws.Cell(rows, ++cells).SetValue("BusinessSeq").Style = wsHeaderStyle;
                ws.Cell(rows, ++cells).SetValue("BusinessName").Style = wsHeaderStyle;
                ws.Cell(rows, ++cells).SetValue("년").Style = wsHeaderStyle;
                ws.Cell(rows, ++cells).SetValue("월").Style = wsHeaderStyle;
                ws.Cell(rows, ++cells).SetValue("월_누계_연간").Style = wsHeaderStyle;
                ws.Cell(rows, ++cells).SetValue("Sales").Style = wsHeaderStyle;
                ws.Cell(rows, ++cells).SetValue("Ebit").Style = wsHeaderStyle;
                ws.Cell(rows, ++cells).SetValue("Pbt").Style = wsHeaderStyle;

                foreach (var item in pBusinessList)
                {
                    rows++;
                    cells = 1;
                    ws.Cell(rows, cells).SetValue(item.PmPalSeq).Style = wsHeaderStyle.Fill.SetBackgroundColor(XLColor.NoColor);
                    ws.Cell(rows, ++cells).SetValue(item.Seq).Style = wsHeaderStyle.Fill.SetBackgroundColor(XLColor.NoColor);
                    ws.Cell(rows, ++cells).SetValue(item.CompanyName).Style = wsHeaderStyle.Fill.SetBackgroundColor(XLColor.NoColor);
                    ws.Cell(rows, ++cells).SetValue(item.OrgBusinessSeq).Style = wsHeaderStyle.Fill.SetBackgroundColor(XLColor.NoColor);
                    ws.Cell(rows, ++cells).SetValue(item.BusinessName).Style = wsHeaderStyle.Fill.SetBackgroundColor(XLColor.NoColor);
                    ws.Cell(rows, ++cells).SetValue(item.PalYear).Style = wsHeaderStyle.Fill.SetBackgroundColor(XLColor.NoColor);
                    ws.Cell(rows, ++cells).SetValue(item.Monthly).Style = wsHeaderStyle.Fill.SetBackgroundColor(XLColor.NoColor);
                    ws.Cell(rows, ++cells).SetValue(Define.MONTHLY_TYPE.GetValue(int.Parse(item.MonthlyType))).Style = wsHeaderStyle.Fill.SetBackgroundColor(XLColor.NoColor);
                    ws.Cell(rows, ++cells).SetValue(item.Sales).Style = wsHeaderStyle.Fill.SetBackgroundColor(XLColor.Yellow);
                    ws.Cell(rows, ++cells).SetValue(item.Ebit).Style = wsHeaderStyle.Fill.SetBackgroundColor(XLColor.Yellow);
                    ws.Cell(rows, ++cells).SetValue(item.Pbt).Style = wsHeaderStyle.Fill.SetBackgroundColor(XLColor.Yellow);
                }

                // 1, 1셀에 색이 입혀져서 마지막에 다시 넣는 걸로 
                rows = 1;
                cells = 1;
                ws.Cell(rows, cells).SetValue("ParentSeq").Style = wsHeaderStyle.Border.SetOutsideBorder(XLBorderStyleValues.Thin).Fill.SetBackgroundColor(XLColor.NoColor);

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
                string filePath = "PmPal";
                var file = fileUtil.FileUpload(ExcelFile, filePath);


                bool bDoubleValue = true;
                ExcelUtil excelUtil = new ExcelUtil();
                var dt = excelUtil.ImportExcel(file["FILE_PATH"]);
                List<PmPalBusiness> pBusinessList = new List<PmPalBusiness>();
                try
                {
                    foreach (DataRow item in dt.Rows)
                    {
                        string parentSeq = item.ItemArray.GetValue(0).ToString();
                        string excelSeq = item.ItemArray.GetValue(1).ToString();
                        string companyName = item.ItemArray.GetValue(2).ToString();
                        string businessSeq = item.ItemArray.GetValue(3).ToString();
                        string businessName = item.ItemArray.GetValue(4).ToString();
                        string PalYear = item.ItemArray.GetValue(5).ToString();
                        string Monthly = item.ItemArray.GetValue(6).ToString();
                        string MonthlyType = item.ItemArray.GetValue(7).ToString();
                        string sales = item.ItemArray.GetValue(8).ToString();
                        string ebit = item.ItemArray.GetValue(9).ToString();
                        string pbt = item.ItemArray.GetValue(10).ToString();
                        if (parentSeq != Seq.ToString()) { bDoubleValue = false; break; }       // 현재 코드와 업로드하려는 코드가 다른 경우는 양식이 잘못된것으로 오류
                        if (!WebUtil.CheckDecimalTwo(sales)) { bDoubleValue = false; break; }
                        if (!WebUtil.CheckDecimalTwo(ebit)) { bDoubleValue = false; break; }
                        if (!WebUtil.CheckDecimalTwo(pbt)) { bDoubleValue = false; break; }

                        var pBusiness = new PmPalBusiness();
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
                    LogUtil.MngError(e.ToString());
                    result = false;
                    resultMsg = Message.MSG_007_E;
                }

                if (!bDoubleValue)
                {
                    TempData["alert"] = Message.MSG_007_E;
                    return RedirectToAction("List");
                }

                // 문제 없으면 업데이트
                for (int i = 0; i < pBusinessList.Count(); i++)
                {
                    PmPalBusiness p = new PmPalBusiness();
                    p.Seq = pBusinessList[i].Seq;
                    p.Sales = pBusinessList[i].Sales;
                    p.Ebit = pBusinessList[i].Ebit;
                    p.Pbt = pBusinessList[i].Pbt;

                    pmPalBusinessRepo.update(p);
                }

                // 업데이트 완료 후 로그 남기기
                ExcelFileUploadList eFileList = new ExcelFileUploadList();
                eFileList.UserKey = SessionManager.GetAdminSession().insaUserV.userKey;
                eFileList.EmpNo = SessionManager.GetAdminSession().insaUserV.empNo;
                eFileList.AttachTableName = "PM_PAL";
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