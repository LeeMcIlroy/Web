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
    [RoutePrefix("SiteMngHome/Performance/Quarter_Pal")]
    public class PmQuarterPalController : SiteMngBaseController
    {
        [Route("List")]
        public ActionResult List(Search search)
        {
            dynamic model = new ExpandoObject();
            search.AuthUserKey = SessionManager.GetAdminSession().insaUserV.userKey;
            model.list = pmQuarterPalRepo.selectList(search);
            model.UnionList = orgUnionRepo.selectList(new { });
            model.OrgCpyList = orgCompanyRepo.selectList(null);
            ViewBag.Search = search;

            return View("~/Views/SiteMngHome/Performance/Quarter_Pal/List.cshtml", model);
        }

        [Route("Write")]
        public ActionResult Write(PmQuarterPal entity, Search search)
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");
            // 기본 정보 가져온다.
            var pmQuarterPal = pmQuarterPalRepo.selectOne(entity);
            // 회사 밑에 부서 정보를 가져온다
            var orgBusinessList = orgBusinessRepo.selectListCompany(new { Seq = entity.OrgCompanySeq });
            //
            var orgCompanyName = orgCompanyRepo.selectOne(new { Seq = entity.OrgCompanySeq });

            foreach (var business in orgBusinessList)
            {
                PmQuarterPalBusiness p = new PmQuarterPalBusiness();

                //값이없을때 1~4분기까지 만들어준다
                for (int i = 1; i <= 4; i++)
                {
                    p.PmQuarterPalSeq = entity.Seq;
                    p.OrgBusinessSeq = business.Seq;
                    p.BusinessYear = pmQuarterPal.QuarterPalYear;
                    p.BusinessQuarter = i;
                    p.Sales = 0;
                    p.Ebit = 0;
                    p.EbitRate = 0;
                    p.Pbt = 0;

                    string where = " WHERE PM_QUARTER_PAL_SEQ = @PmQuarterPalSeq AND ORG_BUSINESS_SEQ = @OrgBusinessSeq AND BUSINESS_QUARTER = @BusinessQuarter";
                    if (pmQuarterPalBusinessRepo.count(p, where) == 0) pmQuarterPalBusinessRepo.insert(p);
                }
            }
            
            //분기별 손익 - 작년 실적
            var QuarterResultLastYearList = pmQuarterPalBusinessRepo.QuarterResultLastYearList(new { Seq  = entity.OrgCompanySeq, YearlyYear = pmQuarterPal.QuarterPalYear, Monthly = pmQuarterPal.Monthly});
            //분기별 손익
            var QuarterPlanLastYearList = pmQuarterPalBusinessRepo.QuarterPlanLastYearList(new { Seq = entity.OrgCompanySeq, YearlyYear = pmQuarterPal.QuarterPalYear });
            //당해년도 예상
            var QuarterExpectThisYearList = pmQuarterPalBusinessRepo.QuarterExpectThisYearList(new { Seq = entity.OrgCompanySeq, YearlyYear = pmQuarterPal.QuarterPalYear, Monthly = pmQuarterPal.Monthly });

            dynamic model = new ExpandoObject();

            model.pmQuarterPal = pmQuarterPal;
            model.orgBusinessList = orgBusinessList;
            model.orgCompanyName = orgCompanyName;

            //분기별 손익 - 작년 실적
            model.QuarterResultLastYearList = QuarterResultLastYearList;
            //분기별 손익 - 작년 계획
            model.QuarterPlanLastYearList = QuarterPlanLastYearList;
            //당해년도 예상
            model.QuarterExpectThisYearList = QuarterExpectThisYearList;

            ViewBag.Search = search;
            return View("~/Views/SiteMngHome/Performance/Quarter_Pal/Write.cshtml", model);
        }

        /// <summary>
        /// 계산하기
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        [Route("Calculation_Action")]
        public ActionResult CalculationAction(PmQuarterAdmin entity, Search search)
        {
            #region
            Dictionary<string, object> postData = new Dictionary<string, object>();
            postData.Add("Seq", entity.Seq);
            postData.Add("OrgCompanySeq", entity.OrgCompanySeq);
            postData.Add("PageIndex", search.PageIndex);
            #endregion

            // 부서별 데이터 검증(정수 혹은 소수점 2자리까지의 데이터)
            bool bDoubleValue = true;
            List<PmQuarterPalBusiness> pBusinessList = new List<PmQuarterPalBusiness>();
            try
            {
                for (int i = 0; i < entity.PmQuarterPalBusinessSeq.Count(); i++)
                {
                    if (!WebUtil.CheckDecimalTwo(entity.Sales[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.Ebit[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.Pbt[i].ToString())) { bDoubleValue = false; break; }

                    PmQuarterPalBusiness p = new PmQuarterPalBusiness();
                    p.Seq = entity.PmQuarterPalBusinessSeq[i];
                    p.Sales = entity.Sales[i];
                    p.Ebit = entity.Ebit[i];
                    p.Pbt = entity.Pbt[i];

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
                PmQuarterPalBusiness p = new PmQuarterPalBusiness();
                p.Seq = pBusinessList[i].Seq;
                p.Sales = pBusinessList[i].Sales;
                p.Ebit = pBusinessList[i].Ebit;
                p.Pbt = pBusinessList[i].Pbt;

                pmQuarterPalBusinessRepo.update(p);
            }

            // 계산하기 하였을 경우 기존 데이터 삭제하여 부서별 데이터의 합계를 다시 입력
            PmQuarterPalBusinessSummary pSum = new PmQuarterPalBusinessSummary();
            pSum.PmQuarterPalBusinessSeq = entity.Seq;
            pSum.BusinessYear = entity.QuarterPalYear;
            pSum.Monthly = entity.Monthly;

            pmQuarterPalBusinessSummaryRepo.delete(pSum);
            pmQuarterPalBusinessSummaryRepo.insert(pSum);

            // 2018.10.29 수정화면에서 저장한 뒤에 저장상태로 변경
            //// 미저장에서 저장으로 변경
            //if (entity.RegistStatus == Define.REGIST_STATUS.GetKey("미등록"))
            //{
            //    entity.RegistStatus = Define.REGIST_STATUS.GetKey("저장");
            //    PmQuarterPal p = new PmQuarterPal();
            //    p.Seq = entity.Seq;
            //    p.RegistStatus = entity.RegistStatus;
            //    pmQuarterPalRepo.updateRegist(p);
            //}
           // return RedirectAndPostActionResult.RedirectAndPost("Edit", postData);
            return RedirectAndPostActionResult.RedirectAndPost("Write2", postData);
        }

        [Route("View")]
        public ActionResult view(PmQuarterPal entity, Search search)
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");
            // 기본 정보 가져온다.
            var pmQuarterPal = pmQuarterPalRepo.selectOne(entity);
            // 회사 밑에 부서 정보를 가져온다
            //var orgBusinessList = orgBusinessRepo.selectListCompany(new { Seq = entity.OrgCompanySeq });
            var orgBusinessList = orgBusinessRepo.selectListAll(new { orgCompanySeq = entity.OrgCompanySeq });
            //
            var orgCompanyName = orgCompanyRepo.selectOne(new { Seq = entity.OrgCompanySeq });

            //분기별 손익 - 작년 실적
            var QuarterResultLastYearList = pmQuarterPalBusinessRepo.QuarterResultLastYearList(new { Seq = entity.OrgCompanySeq, YearlyYear = pmQuarterPal.QuarterPalYear, Monthly = pmQuarterPal.Monthly });
            //분기별 손익 - 당해년도 계획
            var QuarterPlanLastYearList = pmQuarterPalBusinessRepo.QuarterPlanLastYearList(new { Seq = entity.OrgCompanySeq, YearlyYear = pmQuarterPal.QuarterPalYear });
            //분기별 손익 - 당해년도 예상
            var QuarterExpectThisYearList = pmQuarterPalBusinessRepo.QuarterExpectThisYearList(new { Seq = entity.OrgCompanySeq, YearlyYear = pmQuarterPal.QuarterPalYear, Monthly = pmQuarterPal.Monthly });

            //분기별 손익 - 작년 실적
            var QuarterResultLastSummaryYearList = pmQuarterPalBusinessSummaryRepo.QuarterResultLastSummaryYearList(new { Seq = entity.OrgCompanySeq, YearlyYear = pmQuarterPal.QuarterPalYear, Monthly = pmQuarterPal.Monthly });
            //분기별 손익 - 당해 계획
            var QuarterPlanSummaryThisYearList = pmQuarterPalBusinessSummaryRepo.QuarterPlanSummaryThisYearList(new { Seq = entity.OrgCompanySeq, YearlyYear = pmQuarterPal.QuarterPalYear, Monthly = pmQuarterPal.Monthly });
            //분기별 손익 - 당해 계획
            var QuarterExpectSummaryThisYearList = pmQuarterPalBusinessSummaryRepo.QuarterExpectSummaryThisYearList(new { Seq = entity.OrgCompanySeq, YearlyYear = pmQuarterPal.QuarterPalYear, Monthly = pmQuarterPal.Monthly });

            // 현재기준의 Bu만 조인하여 넣는다.
            var orgBusinessList2 = from x in orgBusinessList
                                   join y in QuarterExpectThisYearList on x.Seq equals y.OrgBusinessSeq
                                   group x by new { x.Seq, x.BusinessName } into g
                                   select new OrgBusiness
                                   {
                                       Seq = g.First().Seq,
                                       BusinessName = g.First().BusinessName
                                   };
            orgBusinessList = orgBusinessList2.ToList();

            dynamic model = new ExpandoObject();

            model.pmQuarterPal = pmQuarterPal;
            model.orgBusinessList = orgBusinessList;
            model.orgCompanyName = orgCompanyName;

            //분기별 손익 - 작년 실적
            model.QuarterResultLastYearList = QuarterResultLastYearList;
            //분기별 손익 - 작년 계획
            model.QuarterPlanLastYearList = QuarterPlanLastYearList;
            //당해년도 예상
            model.QuarterExpectThisYearList = QuarterExpectThisYearList;

            //분기별 손익요약 - 작년 실적
            model.QuarterResultLastSummaryYearList = QuarterResultLastSummaryYearList;
            //분기별 손익요약 - 작년 계획
            model.QuarterPlanSummaryThisYearList = QuarterPlanSummaryThisYearList;
            //분기별 손익요약 - 예상 실적
            model.QuarterExpectSummaryThisYearList = QuarterExpectSummaryThisYearList;

            ViewBag.Search = search;
            return View("~/Views/SiteMngHome/Performance/Quarter_Pal/View.cshtml", model);
        }

        [Route("Edit")]
        public ActionResult Edit(PmQuarterPal entity, Search search)
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");
            // 기본 정보 가져온다.
            var pmQuarterPal = pmQuarterPalRepo.selectOne(entity);
            // 회사 밑에 부서 정보를 가져온다
            //var orgBusinessList = orgBusinessRepo.selectListCompany(new { Seq = entity.OrgCompanySeq });
            var orgBusinessList = orgBusinessRepo.selectListAll(new { orgCompanySeq = entity.OrgCompanySeq });
            //
            var orgCompanyName = orgCompanyRepo.selectOne(new { Seq = entity.OrgCompanySeq });

            //분기별 손익 - 작년 실적
            var QuarterResultLastYearList = pmQuarterPalBusinessRepo.QuarterResultLastYearList(new { Seq = entity.OrgCompanySeq, YearlyYear = pmQuarterPal.QuarterPalYear, Monthly = pmQuarterPal.Monthly });
            //분기별 손익 - 당해년도 계획
            var QuarterPlanLastYearList = pmQuarterPalBusinessRepo.QuarterPlanLastYearList(new { Seq = entity.OrgCompanySeq, YearlyYear = pmQuarterPal.QuarterPalYear });
            //분기별 손익 - 당해년도 예상
            var QuarterExpectThisYearList = pmQuarterPalBusinessRepo.QuarterExpectThisYearList(new { Seq = entity.OrgCompanySeq, YearlyYear = pmQuarterPal.QuarterPalYear, Monthly = pmQuarterPal.Monthly });

            //분기별 손익 - 작년 실적
            var QuarterResultLastSummaryYearList = pmQuarterPalBusinessSummaryRepo.QuarterResultLastSummaryYearList(new { Seq = entity.OrgCompanySeq, YearlyYear = pmQuarterPal.QuarterPalYear, Monthly = pmQuarterPal.Monthly });
            //분기별 손익 - 당해 계획
            var QuarterPlanSummaryThisYearList = pmQuarterPalBusinessSummaryRepo.QuarterPlanSummaryThisYearList(new { Seq = entity.OrgCompanySeq, YearlyYear = pmQuarterPal.QuarterPalYear, Monthly = pmQuarterPal.Monthly });
            //분기별 손익 - 당해 계획
            var QuarterExpectSummaryThisYearList = pmQuarterPalBusinessSummaryRepo.QuarterExpectSummaryThisYearList(new { Seq = entity.OrgCompanySeq, YearlyYear = pmQuarterPal.QuarterPalYear, Monthly = pmQuarterPal.Monthly });

            // 현재기준의 Bu만 조인하여 넣는다.
            var orgBusinessList2 = from x in orgBusinessList
                                   join y in QuarterExpectThisYearList on x.Seq equals y.OrgBusinessSeq
                                   group x by new { x.Seq, x.BusinessName } into g
                                   select new OrgBusiness
                                   {
                                       Seq = g.First().Seq,
                                       BusinessName = g.First().BusinessName
                                   };
            orgBusinessList = orgBusinessList2.ToList();

            dynamic model = new ExpandoObject();

            model.pmQuarterPal = pmQuarterPal;
            model.orgBusinessList = orgBusinessList;
            model.orgCompanyName = orgCompanyName;

            //분기별 손익 - 작년 실적
            model.QuarterResultLastYearList = QuarterResultLastYearList;
            //분기별 손익 - 작년 계획
            model.QuarterPlanLastYearList = QuarterPlanLastYearList;
            //당해년도 예상
            model.QuarterExpectThisYearList = QuarterExpectThisYearList;

            //분기별 손익요약 - 작년 실적
            model.QuarterResultLastSummaryYearList = QuarterResultLastSummaryYearList;
            //분기별 손익요약 - 작년 계획
            model.QuarterPlanSummaryThisYearList = QuarterPlanSummaryThisYearList;
            //분기별 손익요약 - 예상 실적
            model.QuarterExpectSummaryThisYearList = QuarterExpectSummaryThisYearList;

            ViewBag.Search = search;
            return View("~/Views/SiteMngHome/Performance/Quarter_Pal/Edit.cshtml", model);
        }

        [Route("Write2")]
        public ActionResult Write2(PmQuarterPal entity, Search search)
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");
            // 기본 정보 가져온다.
            var pmQuarterPal = pmQuarterPalRepo.selectOne(entity);
            // 회사 밑에 부서 정보를 가져온다
            //var orgBusinessList = orgBusinessRepo.selectListCompany(new { Seq = entity.OrgCompanySeq });
            var orgBusinessList = orgBusinessRepo.selectListAll(new { orgCompanySeq = entity.OrgCompanySeq });
            //
            var orgCompanyName = orgCompanyRepo.selectOne(new { Seq = entity.OrgCompanySeq });

            //분기별 손익 - 작년 실적
            var QuarterResultLastYearList = pmQuarterPalBusinessRepo.QuarterResultLastYearList(new { Seq = entity.OrgCompanySeq, YearlyYear = pmQuarterPal.QuarterPalYear, Monthly = pmQuarterPal.Monthly });
            //분기별 손익 - 당해년도 계획
            var QuarterPlanLastYearList = pmQuarterPalBusinessRepo.QuarterPlanLastYearList(new { Seq = entity.OrgCompanySeq, YearlyYear = pmQuarterPal.QuarterPalYear });
            //분기별 손익 - 당해년도 예상
            var QuarterExpectThisYearList = pmQuarterPalBusinessRepo.QuarterExpectThisYearList(new { Seq = entity.OrgCompanySeq, YearlyYear = pmQuarterPal.QuarterPalYear, Monthly = pmQuarterPal.Monthly });

            //분기별 손익 - 작년 실적
            var QuarterResultLastSummaryYearList = pmQuarterPalBusinessSummaryRepo.QuarterResultLastSummaryYearList(new { Seq = entity.OrgCompanySeq, YearlyYear = pmQuarterPal.QuarterPalYear, Monthly = pmQuarterPal.Monthly });
            //분기별 손익 - 당해 계획
            var QuarterPlanSummaryThisYearList = pmQuarterPalBusinessSummaryRepo.QuarterPlanSummaryThisYearList(new { Seq = entity.OrgCompanySeq, YearlyYear = pmQuarterPal.QuarterPalYear, Monthly = pmQuarterPal.Monthly });
            //분기별 손익 - 당해 계획
            var QuarterExpectSummaryThisYearList = pmQuarterPalBusinessSummaryRepo.QuarterExpectSummaryThisYearList(new { Seq = entity.OrgCompanySeq, YearlyYear = pmQuarterPal.QuarterPalYear, Monthly = pmQuarterPal.Monthly });

            // 현재기준의 Bu만 조인하여 넣는다.
            var orgBusinessList2 = from x in orgBusinessList
                                   join y in QuarterExpectThisYearList on x.Seq equals y.OrgBusinessSeq
                                   group x by new { x.Seq, x.BusinessName } into g
                                   select new OrgBusiness
                                   {
                                       Seq = g.First().Seq,
                                       BusinessName = g.First().BusinessName
                                   };
            orgBusinessList = orgBusinessList2.ToList();

            dynamic model = new ExpandoObject();

            model.pmQuarterPal = pmQuarterPal;
            model.orgBusinessList = orgBusinessList;
            model.orgCompanyName = orgCompanyName;

            //분기별 손익 - 작년 실적
            model.QuarterResultLastYearList = QuarterResultLastYearList;
            //분기별 손익 - 작년 계획
            model.QuarterPlanLastYearList = QuarterPlanLastYearList;
            //당해년도 예상
            model.QuarterExpectThisYearList = QuarterExpectThisYearList;

            //분기별 손익요약 - 작년 실적
            model.QuarterResultLastSummaryYearList = QuarterResultLastSummaryYearList;
            //분기별 손익요약 - 작년 계획
            model.QuarterPlanSummaryThisYearList = QuarterPlanSummaryThisYearList;
            //분기별 손익요약 - 예상 실적
            model.QuarterExpectSummaryThisYearList = QuarterExpectSummaryThisYearList;

            ViewBag.Search = search;
            return View("~/Views/SiteMngHome/Performance/Quarter_Pal/Write2.cshtml", model);
        }

        [Route("Edit2")]
        public ActionResult Edit2(PmQuarterPal entity, Search search)
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");
            // 기본 정보 가져온다.
            var pmQuarterPal = pmQuarterPalRepo.selectOne(entity);
            // 회사 밑에 부서 정보를 가져온다
            var orgCompanyName = orgCompanyRepo.selectOne(new { Seq = entity.OrgCompanySeq });
            
            //분기별 손익 - 작년 실적
            var QuarterResultLastSummaryYearList = pmQuarterPalBusinessSummaryRepo.QuarterResultLastSummaryYearList(new { Seq = entity.OrgCompanySeq, YearlyYear = pmQuarterPal.QuarterPalYear, Monthly = pmQuarterPal.Monthly });
            //분기별 손익 - 당해 계획
            var QuarterPlanSummaryThisYearList = pmQuarterPalBusinessSummaryRepo.QuarterPlanSummaryThisYearList(new { Seq = entity.OrgCompanySeq, YearlyYear = pmQuarterPal.QuarterPalYear, Monthly = pmQuarterPal.Monthly });
            //분기별 손익 - 당해 계획
            var QuarterExpectSummaryThisYearList = pmQuarterPalBusinessSummaryRepo.QuarterExpectSummaryThisYearList(new { Seq = entity.OrgCompanySeq, YearlyYear = pmQuarterPal.QuarterPalYear, Monthly = pmQuarterPal.Monthly });
            

            dynamic model = new ExpandoObject();

            model.pmQuarterPal = pmQuarterPal;
            model.orgCompanyName = orgCompanyName;
            
            //분기별 손익요약 - 작년 실적
            model.QuarterResultLastSummaryYearList = QuarterResultLastSummaryYearList;
            //분기별 손익요약 - 작년 계획
            model.QuarterPlanSummaryThisYearList = QuarterPlanSummaryThisYearList;
            //분기별 손익요약 - 예상 실적
            model.QuarterExpectSummaryThisYearList = QuarterExpectSummaryThisYearList;

            ViewBag.Search = search;
            return View("~/Views/SiteMngHome/Performance/Quarter_Pal/Edit2.cshtml", model);
        }

        [Route("Edit_Action")]
        public ActionResult EditAction(PmQuarterAdmin entity, Search search)
        {
            #region
            Dictionary<string, object> postData = new Dictionary<string, object>();
            postData.Add("Seq", entity.Seq);
            postData.Add("OrgCompanySeq", entity.OrgCompanySeq);
            postData.Add("message", Message.MSG_007_A);
            postData.Add("PageIndex", search.PageIndex);
            #endregion

            // 부서별 데이터 검증(정수 혹은 소수점 2자리까지의 데이터)
            bool bDoubleValue = true;
            List<PmQuarterPalBusiness> pBusinessList = new List<PmQuarterPalBusiness>();
            List<PmQuarterPalBusinessSummary> pBusinessSummaryList = new List<PmQuarterPalBusinessSummary>();

            try
            {
                for (int i = 0; i < entity.PmQuarterPalBusinessSeq.Count(); i++)
                {
                    if (!WebUtil.CheckDecimalTwo(entity.Sales[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.Ebit[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.Pbt[i].ToString())) { bDoubleValue = false; break; }

                    PmQuarterPalBusiness p = new PmQuarterPalBusiness();
                    p.Seq = entity.PmQuarterPalBusinessSeq[i];
                    p.Sales = entity.Sales[i];
                    p.Ebit = entity.Ebit[i];
                    p.Pbt = entity.Pbt[i];

                    pBusinessList.Add(p);
                }

                for (int i = 0; i < entity.PmQuarterPalBusinessSummarySeq.Count(); i++)
                {
                    if (!WebUtil.CheckDecimalTwo(entity.Sales[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.Ebit[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.Pbt[i].ToString())) { bDoubleValue = false; break; }

                    PmQuarterPalBusinessSummary p = new PmQuarterPalBusinessSummary();
                    p.Seq = entity.PmQuarterPalBusinessSummarySeq[i];
                    p.Sales = entity.SalesSummary[i];
                    p.Ebit = entity.EbitSummary[i];
                    p.Pbt = entity.PbtSummary[i];
                    p.NetProfitTerm = entity.NetProfitTermSummary[i];

                    pBusinessSummaryList.Add(p);
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
                PmQuarterPalBusiness p = new PmQuarterPalBusiness();
                p.Seq = pBusinessList[i].Seq;
                p.Sales = pBusinessList[i].Sales;
                p.Ebit = pBusinessList[i].Ebit;
                p.Pbt = pBusinessList[i].Pbt;

                pmQuarterPalBusinessRepo.update(p);
            }


            // 요약 데이터 업데이트
            for (int i = 0; i < pBusinessSummaryList.Count(); i++)
            {
                PmQuarterPalBusinessSummary p = new PmQuarterPalBusinessSummary();
                p.Seq = pBusinessSummaryList[i].Seq;
                p.Sales = pBusinessSummaryList[i].Sales;
                p.Ebit = pBusinessSummaryList[i].Ebit;
                p.Pbt = pBusinessSummaryList[i].Pbt;
                p.NetProfitTerm = pBusinessSummaryList[i].NetProfitTerm;

                pmQuarterPalBusinessSummaryRepo.update(p);
            }


            // 미저장에서 저장으로 변경
            if (entity.RegistStatus == Define.REGIST_STATUS.GetKey("미등록"))
            {
                entity.RegistStatus = Define.REGIST_STATUS.GetKey("저장");
                PmQuarterPal p = new PmQuarterPal();
                p.Seq = entity.Seq;
                p.RegistStatus = entity.RegistStatus;
                pmQuarterPalRepo.updateRegist(p);
            }

            return RedirectAndPostActionResult.RedirectAndPost("Edit", postData);
        }


        /// <summary>
        /// 승인요청, 승인, 반려등의 상태 변경
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        [Route("Regist_Status_Change")]
        public ActionResult RegistStatusChange(PmQuarterPal entity, Search search)
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");

            #region
            Dictionary<string, object> postData = new Dictionary<string, object>();
            postData.Add("Seq", entity.Seq);
            postData.Add("OrgCompanySeq", entity.OrgCompanySeq);
            postData.Add("message", entity.message);
            postData.Add("PageIndex", search.PageIndex);
            #endregion

            // 현재 상태값을 변경한다.
            entity.RegistStatus = entity.afterRegistStatus;
            pmQuarterPalRepo.updateRegist(entity);

            // 현재의 상태 변경 후 담당자들에게 메일 발송합니다.(2018.11.08)
            var info = pmQuarterPalRepo.selectOne(entity);

            MailInfo mInfo = new MailInfo();
            // 2019.01.13 결제라인 추가
            mInfo.Seq = entity.Seq;
            mInfo.ReferUrl = Request.UrlReferrer.AbsolutePath.ToString();
            mInfo.afterRegistStatus = entity.afterRegistStatus;
            mInfo.OrgCompanySeq = entity.OrgCompanySeq;
            mInfo.menuName = "분기별 손익";
            mInfo.year = info.QuarterPalYear;
            mInfo.mm = info.Monthly;
            // 2018.01.03 반려사유 추가
            mInfo.RejectReson = entity.RejectReson;
            //MailUtil.RegistStatusMail(mInfo);
            MailUtilNew.AllComfirmMaillSender(mInfo); /*메일 발송*/

            // 최종승인의 경우. 다른 모든 회사와 메뉴가 최종승인 되었는지 체크하여. 푸시알림을 보낸다.
            if (entity.RegistStatus == Define.REGIST_STATUS.GetKey("최종승인"))
            {
                //RegistYearListRepo rYearListRepo = new RegistYearListRepo();
                //List<RegistYearList> registYearPm = rYearListRepo.selectListPm(new { }).ToList();

                //string year = info.QuarterPalYear;
                //string month = info.Monthly;

                //var checkRegist = registYearPm.Where(w => w.RegistYear == year && w.RegistMonth == month).ToList();
                //if (checkRegist != null && checkRegist.Count() > 0)
                //{
                //    // 인사디비에서 권한 사용자 가져온다.
                //    var users = insaUserVRepo.selectListAuth().ToList();

                //    PushMaster pushMaster = new PushMaster();
                //    pushMaster.Type = 1;
                //    pushMaster.Title = "-";
                //    pushMaster.Contents = year + "년 " + month + "월 실적등록이 승인되었습니다.";
                //    pushMaster.Link = "";

                //    ApiController api = new ApiController();

                //    List<string> result = api.SendPushServer(pushMaster, users);
                //    if (result[0].ToUpper() == "FALSE")
                //    {
                //        LogUtil.MngError(result[2].ToString() + "[" + year + "." + month);
                //    }
                //}
            }

            return RedirectToAction("List", search);
        }

        /// <summary>
        /// 엑셀 양식 다운로드
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        [Route("Excel_Down")]
        public ActionResult ExcelDown(PmQuarterPal entity)
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");

            var pmQuarterPal = pmQuarterPalRepo.selectOne(entity);
            var orgCompanyName = orgCompanyRepo.selectOne(new { Seq = entity.OrgCompanySeq });
            var pBusinessList = pmQuarterPalBusinessRepo.selectListExcel(new { PmQuarterPalSeq = entity.Seq });

            string fileName = "분기별손익_" + pmQuarterPal.QuarterPalYear + "년_" + orgCompanyName.CompanyName;

            int rows = 1, cells = 1;

            using (XLWorkbook wb = new XLWorkbook())
            {
                var ws = wb.Worksheets.Add("분기별손익");

                // 해더 선언
                var wsHeader = ws.Cell(rows, cells);
                var wsHeaderStyle = wsHeader.Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                // 컬럼 숨기기
                ws.Column(1).Hide();
                ws.Column(2).Hide();
                ws.Column(4).Hide();

                ws.Cell(rows, cells).SetValue("ParentSeq").Style = wsHeaderStyle;
                ws.Cell(rows, ++cells).SetValue("Seq").Style = wsHeaderStyle;
                ws.Cell(rows, ++cells).SetValue("CompanyName").Style = wsHeaderStyle;
                ws.Cell(rows, ++cells).SetValue("BusinessSeq").Style = wsHeaderStyle;
                ws.Cell(rows, ++cells).SetValue("BusinessName").Style = wsHeaderStyle;
                ws.Cell(rows, ++cells).SetValue("년").Style = wsHeaderStyle;
                ws.Cell(rows, ++cells).SetValue("분기").Style = wsHeaderStyle;
                ws.Cell(rows, ++cells).SetValue("Sales").Style = wsHeaderStyle;
                ws.Cell(rows, ++cells).SetValue("Ebit").Style = wsHeaderStyle;
                ws.Cell(rows, ++cells).SetValue("Pbt").Style = wsHeaderStyle;

                foreach (var item in pBusinessList)
                {
                    rows++;
                    cells = 1;
                    ws.Cell(rows, cells).SetValue(item.PmQuarterPalSeq).Style = wsHeaderStyle.Fill.SetBackgroundColor(XLColor.NoColor);
                    ws.Cell(rows, ++cells).SetValue(item.Seq).Style = wsHeaderStyle.Fill.SetBackgroundColor(XLColor.NoColor);
                    ws.Cell(rows, ++cells).SetValue(item.CompanyName).Style = wsHeaderStyle.Fill.SetBackgroundColor(XLColor.NoColor);
                    ws.Cell(rows, ++cells).SetValue(item.OrgBusinessSeq).Style = wsHeaderStyle.Fill.SetBackgroundColor(XLColor.NoColor);
                    ws.Cell(rows, ++cells).SetValue(item.BusinessName).Style = wsHeaderStyle.Fill.SetBackgroundColor(XLColor.NoColor);
                    ws.Cell(rows, ++cells).SetValue(item.BusinessYear).Style = wsHeaderStyle.Fill.SetBackgroundColor(XLColor.NoColor);
                    ws.Cell(rows, ++cells).SetValue(item.BusinessQuarter).Style = wsHeaderStyle.Fill.SetBackgroundColor(XLColor.NoColor);
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
        /// 엑셀 양식 다운로드
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        [Route("Excel_Down2")]
        public ActionResult ExcelDown2(PmQuarterPal entity)
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");

            var pmQuarterPal = pmQuarterPalRepo.selectOne(entity);
            var orgCompanyName = orgCompanyRepo.selectOne(new { Seq = entity.OrgCompanySeq });
            var pBusinessList = pmQuarterPalBusinessRepo.selectListExcel(new { PmQuarterPalSeq = entity.Seq });
            var pQuarterPalSummaryList = pmQuarterPalBusinessSummaryRepo.selectListExcel(new { PmQuarterPalSeq = entity.Seq });

            string fileName = "분기별손익_" + pmQuarterPal.QuarterPalYear + "년_" + orgCompanyName.CompanyName;

            int rows = 1, cells = 1;

            using (XLWorkbook wb = new XLWorkbook())
            {
                var ws = wb.Worksheets.Add("분기별손익");

                // 해더 선언
                var wsHeader = ws.Cell(rows, cells);
                var wsHeaderStyle = wsHeader.Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                // 컬럼 숨기기
                //ws.Column(1).Hide();
                //ws.Column(2).Hide();
                ws.Column(2).Hide();

                //ws.Cell(rows, cells).SetValue("ParentSeq").Style = wsHeaderStyle;
                //ws.Cell(rows, ++cells).SetValue("Seq").Style = wsHeaderStyle;
                ws.Cell(rows, cells).SetValue("CompanyName").Style = wsHeaderStyle;
                ws.Cell(rows, ++cells).SetValue("BusinessSeq").Style = wsHeaderStyle;
                ws.Cell(rows, ++cells).SetValue("BusinessName").Style = wsHeaderStyle;
                ws.Cell(rows, ++cells).SetValue("년").Style = wsHeaderStyle;
                ws.Cell(rows, ++cells).SetValue("분기").Style = wsHeaderStyle;
                ws.Cell(rows, ++cells).SetValue("Sales").Style = wsHeaderStyle;
                ws.Cell(rows, ++cells).SetValue("Ebit").Style = wsHeaderStyle;
                ws.Cell(rows, ++cells).SetValue("Pbt").Style = wsHeaderStyle;

                foreach (var item in pBusinessList)
                {
                    rows++;
                    cells = 1;
                    //ws.Cell(rows, cells).SetValue(item.PmQuarterPalSeq).Style = wsHeaderStyle.Fill.SetBackgroundColor(XLColor.NoColor);
                    //ws.Cell(rows, ++cells).SetValue(item.Seq).Style = wsHeaderStyle.Fill.SetBackgroundColor(XLColor.NoColor);
                    ws.Cell(rows, cells).SetValue(item.CompanyName).Style = wsHeaderStyle.Fill.SetBackgroundColor(XLColor.NoColor);
                    ws.Cell(rows, ++cells).SetValue(item.OrgBusinessSeq).Style = wsHeaderStyle.Fill.SetBackgroundColor(XLColor.NoColor);
                    ws.Cell(rows, ++cells).SetValue(item.BusinessName).Style = wsHeaderStyle.Fill.SetBackgroundColor(XLColor.NoColor);
                    ws.Cell(rows, ++cells).SetValue(item.BusinessYear).Style = wsHeaderStyle.Fill.SetBackgroundColor(XLColor.NoColor);
                    ws.Cell(rows, ++cells).SetValue(item.BusinessQuarter).Style = wsHeaderStyle.Fill.SetBackgroundColor(XLColor.NoColor);
                    ws.Cell(rows, ++cells).SetValue(item.Sales).Style = wsHeaderStyle.Fill.SetBackgroundColor(XLColor.Yellow);
                    ws.Cell(rows, ++cells).SetValue(item.Ebit).Style = wsHeaderStyle.Fill.SetBackgroundColor(XLColor.Yellow);
                    ws.Cell(rows, ++cells).SetValue(item.Pbt).Style = wsHeaderStyle.Fill.SetBackgroundColor(XLColor.Yellow);
                }

                // 1, 1셀에 색이 입혀져서 마지막에 다시 넣는 걸로 
                rows = 1;
                cells = 1;
                ws.Cell(rows, cells).SetValue("CompanyName").Style = wsHeaderStyle.Border.SetOutsideBorder(XLBorderStyleValues.Thin).Fill.SetBackgroundColor(XLColor.NoColor);

                var wt = wb.Worksheets.Add("분기별손익연결");

                // 해더 선언
                var wtHeader = wt.Cell(rows, cells);
                var wtHeaderStyle = wtHeader.Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                // 컬럼 숨기기
                // ws.Column(1).Hide();
                //ws.Column(2).Hide();

                wt.Cell(rows, cells).SetValue("년").Style = wtHeaderStyle; 
                wt.Cell(rows, ++cells).SetValue("분기").Style = wtHeaderStyle; 
                wt.Cell(rows, ++cells).SetValue("Sales").Style = wtHeaderStyle;
                wt.Cell(rows, ++cells).SetValue("Ebit").Style = wtHeaderStyle;
                wt.Cell(rows, ++cells).SetValue("Pbt").Style = wtHeaderStyle;
                wt.Cell(rows, ++cells).SetValue("당기순이익").Style = wtHeaderStyle;

                if (pQuarterPalSummaryList.Count() == 0)
                {
                    for(int i = 0; i< 4; i++)
                    {
                        rows++;
                        cells = 1;
                        // ws.Cell(rows, cells).SetValue(item.PmPalSeq).Style = wsHeaderStyle.Fill.SetBackgroundColor(XLColor.NoColor);
                        // ws.Cell(rows, ++cells).SetValue(item.Seq).Style = wsHeaderStyle.Fill.SetBackgroundColor(XLColor.NoColor);

                        wt.Cell(rows, cells).SetValue(pmQuarterPal.QuarterPalYear).Style = wtHeaderStyle.Fill.SetBackgroundColor(XLColor.NoColor);
                        wt.Cell(rows, ++cells).SetValue( i + 1).Style = wtHeaderStyle.Fill.SetBackgroundColor(XLColor.NoColor);
                        wt.Cell(rows, ++cells).SetValue(0).Style = wtHeaderStyle.Fill.SetBackgroundColor(XLColor.Yellow);
                        wt.Cell(rows, ++cells).SetValue(0).Style = wtHeaderStyle.Fill.SetBackgroundColor(XLColor.Yellow);
                        wt.Cell(rows, ++cells).SetValue(0).Style = wtHeaderStyle.Fill.SetBackgroundColor(XLColor.Yellow);
                        wt.Cell(rows, ++cells).SetValue(0).Style = wtHeaderStyle.Fill.SetBackgroundColor(XLColor.Yellow);
                    }
                }
                 
                foreach (var item in pQuarterPalSummaryList)
                {
                    rows++;
                    cells = 1;
                    // ws.Cell(rows, cells).SetValue(item.PmPalSeq).Style = wsHeaderStyle.Fill.SetBackgroundColor(XLColor.NoColor);
                    // ws.Cell(rows, ++cells).SetValue(item.Seq).Style = wsHeaderStyle.Fill.SetBackgroundColor(XLColor.NoColor);

                    wt.Cell(rows, cells).SetValue(item.BusinessYear).Style = wtHeaderStyle.Fill.SetBackgroundColor(XLColor.NoColor);
                    wt.Cell(rows, ++cells).SetValue(item.BusinessQuarter).Style = wtHeaderStyle.Fill.SetBackgroundColor(XLColor.NoColor); 
                    wt.Cell(rows, ++cells).SetValue(item.Sales).Style = wtHeaderStyle.Fill.SetBackgroundColor(XLColor.Yellow);
                    wt.Cell(rows, ++cells).SetValue(item.Ebit).Style = wtHeaderStyle.Fill.SetBackgroundColor(XLColor.Yellow);
                    wt.Cell(rows, ++cells).SetValue(item.Pbt).Style = wtHeaderStyle.Fill.SetBackgroundColor(XLColor.Yellow);
                    wt.Cell(rows, ++cells).SetValue(item.NetProfitTerm).Style = wtHeaderStyle.Fill.SetBackgroundColor(XLColor.Yellow);
                }
               

                // 1, 1셀에 색이 입혀져서 마지막에 다시 넣는 걸로 
                rows = 1;
                cells = 1;
                wt.Cell(rows, cells).SetValue("년").Style = wtHeaderStyle.Border.SetOutsideBorder(XLBorderStyleValues.Thin).Fill.SetBackgroundColor(XLColor.NoColor);

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
                string filePath = "PmQuarterPal";
                var file = fileUtil.FileUpload(ExcelFile, filePath);


                bool bDoubleValue = true;
                ExcelUtil excelUtil = new ExcelUtil();
                var dt = excelUtil.ImportExcel(file["FILE_PATH"]);
                List<PmQuarterPalBusiness> pBusinessList = new List<PmQuarterPalBusiness>();
                try
                {
                    foreach (DataRow item in dt.Rows)
                    {
                        string parentSeq = item.ItemArray.GetValue(0).ToString();
                        string excelSeq = item.ItemArray.GetValue(1).ToString();
                        string companyName = item.ItemArray.GetValue(2).ToString();
                        string businessSeq = item.ItemArray.GetValue(3).ToString();
                        string businessName = item.ItemArray.GetValue(4).ToString();
                        string businessYear = item.ItemArray.GetValue(5).ToString();
                        string businessQuarter = item.ItemArray.GetValue(6).ToString();
                        string sales = item.ItemArray.GetValue(7).ToString();
                        string ebit = item.ItemArray.GetValue(8).ToString();
                        string pbt = item.ItemArray.GetValue(9).ToString();
                        if (parentSeq != Seq.ToString()) { bDoubleValue = false; break; }       // 현재 코드와 업로드하려는 코드가 다른 경우는 양식이 잘못된것으로 오류
                        //if (!WebUtil.CheckDecimalTwo(sales)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(ebit)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(pbt)) { bDoubleValue = false; break; }

                        var pBusiness = new PmQuarterPalBusiness();
                        pBusiness.Seq = Convert.ToInt32(excelSeq);
                        pBusiness.Sales = Convert.ToDecimal(sales);
                        pBusiness.Ebit = Convert.ToDecimal(ebit);
                        pBusiness.Pbt = Convert.ToDecimal(pbt);

                        pBusinessList.Add(pBusiness);
                    }
                }
                catch (Exception e)
                {
                    fileUtil.FileDelete(filePath, file["STORED_FILE_NAME"]);
                    result = false;
                    resultMsg = Message.MSG_007_E;
                    return Json(new { success = result, resultMsg = resultMsg }, JsonRequestBehavior.AllowGet);
                }

                if (!bDoubleValue)
                {
                    fileUtil.FileDelete(filePath, file["STORED_FILE_NAME"]);
                    result = false;
                    resultMsg = Message.MSG_007_E;
                    return Json(new { success = result, resultMsg = resultMsg }, JsonRequestBehavior.AllowGet);
                }

                // 문제 없으면 업데이트
                for (int i = 0; i < pBusinessList.Count(); i++)
                {
                    PmQuarterPalBusiness p = new PmQuarterPalBusiness();
                    p.Seq = pBusinessList[i].Seq;
                    p.Sales = pBusinessList[i].Sales;
                    p.Ebit = pBusinessList[i].Ebit;
                    p.Pbt = pBusinessList[i].Pbt;

                    pmQuarterPalBusinessRepo.update(p);
                }

                // 업데이트 완료 후 로그 남기기
                ExcelFileUploadList eFileList = new ExcelFileUploadList();
                eFileList.UserKey = SessionManager.GetAdminSession().insaUserV.userKey;
                eFileList.EmpNo = SessionManager.GetAdminSession().insaUserV.empNo;
                eFileList.AttachTableName = "PM_QUARTER_PAL";
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


        /// <summary>
        /// 양식업로드
        /// </summary>
        /// <param name="Seq"></param>
        /// <param name="OrgCompanySeq"></param>
        /// <param name="ExcelFile"></param>
        /// <returns></returns>
        [Route("Excel_Upload2")]
        public ActionResult ExcelUpload2(int Seq, int OrgCompanySeq,List<int> PmQuarterPalBusinessSeq, HttpPostedFileBase ExcelFile)
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
                string filePath = "PmQuarterPal";
                var file = fileUtil.FileUpload(ExcelFile, filePath);


                bool bDoubleValue = true;
                ExcelUtil excelUtil = new ExcelUtil();
                var dt = excelUtil.ImportExcel(file["FILE_PATH"]);
                List<PmQuarterPalBusiness> pBusinessList = new List<PmQuarterPalBusiness>();
                try
                {
                    int j = 0;
                    foreach (DataRow item in dt.Rows)
                    {
                        //string parentSeq = item.ItemArray.GetValue(0).ToString();
                        string excelSeq = PmQuarterPalBusinessSeq[j].ToString();

                        string sales = item.ItemArray.GetValue(5).ToString();
                        string ebit = item.ItemArray.GetValue(6).ToString();
                        string pbt = item.ItemArray.GetValue(7).ToString();
                        //string companyName = item.ItemArray.GetValue(2).ToString();
                        //string businessSeq = item.ItemArray.GetValue(3).ToString();
                        //string businessName = item.ItemArray.GetValue(4).ToString();
                        //string businessYear = item.ItemArray.GetValue(5).ToString();
                        //string businessQuarter = item.ItemArray.GetValue(6).ToString();
                        //string sales = item.ItemArray.GetValue(7).ToString();
                        //string ebit = item.ItemArray.GetValue(8).ToString();
                        //string pbt = item.ItemArray.GetValue(9).ToString();
                        //if (parentSeq != Seq.ToString()) { bDoubleValue = false; break; }       // 현재 코드와 업로드하려는 코드가 다른 경우는 양식이 잘못된것으로 오류
                        //if (!WebUtil.CheckDecimalTwo(sales)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(ebit)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(pbt)) { bDoubleValue = false; break; }

                        var pBusiness = new PmQuarterPalBusiness();
                        pBusiness.Seq = Convert.ToInt32(excelSeq);
                        pBusiness.Sales = Convert.ToDecimal(sales);
                        pBusiness.Ebit = Convert.ToDecimal(ebit);
                        pBusiness.Pbt = Convert.ToDecimal(pbt);

                        pBusinessList.Add(pBusiness);
                        j += 1;
                    }
                }
                catch (Exception e)
                {
                    fileUtil.FileDelete(filePath, file["STORED_FILE_NAME"]);
                    result = false;
                    resultMsg = Message.MSG_007_E;
                    return Json(new { success = result, resultMsg = resultMsg }, JsonRequestBehavior.AllowGet);
                }

                if (!bDoubleValue)
                {
                    fileUtil.FileDelete(filePath, file["STORED_FILE_NAME"]);
                    result = false;
                    resultMsg = Message.MSG_007_E;
                    return Json(new { success = result, resultMsg = resultMsg }, JsonRequestBehavior.AllowGet);
                }

                // 문제 없으면 업데이트
                for (int i = 0; i < pBusinessList.Count(); i++)
                {
                    PmQuarterPalBusiness p = new PmQuarterPalBusiness();
                    p.Seq = pBusinessList[i].Seq;
                    p.Sales = pBusinessList[i].Sales;
                    p.Ebit = pBusinessList[i].Ebit;
                    p.Pbt = pBusinessList[i].Pbt;

                    pmQuarterPalBusinessRepo.update(p);
                }

                // 업데이트 완료 후 로그 남기기
                ExcelFileUploadList eFileList = new ExcelFileUploadList();
                eFileList.UserKey = SessionManager.GetAdminSession().insaUserV.userKey;
                eFileList.EmpNo = SessionManager.GetAdminSession().insaUserV.empNo;
                eFileList.AttachTableName = "PM_QUARTER_PAL";
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

        /// <summary>
        /// 양식업로드
        /// </summary>
        /// <param name="Seq"></param>
        /// <param name="OrgCompanySeq"></param>
        /// <param name="ExcelFile"></param>
        /// <returns></returns>
        [Route("Excel_Upload3")]
        public ActionResult ExcelUpload3(int Seq, int OrgCompanySeq, string QuarterPalYear, List<int> PmQuarterPalBusinessSeq, HttpPostedFileBase ExcelFile)
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
                string filePath = "PmQuarterPal";
                var file = fileUtil.FileUpload(ExcelFile, filePath);


                bool bDoubleValue = true;
                ExcelUtil excelUtil = new ExcelUtil();
                var dt = excelUtil.ImportExcelDs(file["FILE_PATH"]); 
             
                List<PmQuarterPalBusiness> pBusinessList = new List<PmQuarterPalBusiness>();
                List<PmQuarterPalBusinessSummary> pQuarterPalSummaryList = new List<PmQuarterPalBusinessSummary>();
                try
                {
                    if (dt.Tables["분기별손익"] == null || dt.Tables["분기별손익"].Rows.Count == 0)
                    {
                        // 오류시 파일 삭제
                        fileUtil.FileDelete(filePath, file["STORED_FILE_NAME"]);
                        result = false;
                        resultMsg = Message.MSG_007_E;
                        return Json(new { success = result, resultMsg = resultMsg }, JsonRequestBehavior.AllowGet);
                    }

                    if (dt.Tables["분기별손익연결"] == null || dt.Tables["분기별손익연결"].Rows.Count == 0)
                    {
                        // 오류시 파일 삭제
                        fileUtil.FileDelete(filePath, file["STORED_FILE_NAME"]);
                        result = false;
                        resultMsg = Message.MSG_007_E;
                        return Json(new { success = result, resultMsg = resultMsg }, JsonRequestBehavior.AllowGet);
                    }
                    int j = 0;
                    foreach (DataRow item in dt.Tables["분기별손익"].Rows)
                    {
                        //string parentSeq = item.ItemArray.GetValue(0).ToString();
                        string excelSeq = PmQuarterPalBusinessSeq[j].ToString();

                        string sales = item.ItemArray.GetValue(5).ToString();
                        string ebit = item.ItemArray.GetValue(6).ToString();
                        string pbt = item.ItemArray.GetValue(7).ToString();


                        var pBusiness = new PmQuarterPalBusiness();
                        pBusiness.Seq = Convert.ToInt32(excelSeq);
                        pBusiness.Sales = Convert.ToDecimal(sales);
                        pBusiness.Ebit = Convert.ToDecimal(ebit);
                        pBusiness.Pbt = Convert.ToDecimal(pbt);

                        pBusinessList.Add(pBusiness);
                        j += 1;
                    }

                    j = 0;
                    foreach (DataRow item in dt.Tables["분기별손익연결"].Rows)
                    {
                        //string parentSeq = "0";
                        //string excelSeq = PmPalBusinessSeq[j].ToString();
                        string montyType = item.ItemArray.GetValue(1).ToString();
                        string sales = item.ItemArray.GetValue(2).ToString();
                        string ebit = item.ItemArray.GetValue(3).ToString();
                        string pbt = item.ItemArray.GetValue(4).ToString();
                        string netProfitTerm = item.ItemArray.GetValue(5).ToString();

                        if (!WebUtil.IsDecimal(sales)) { bDoubleValue = false; break; }
                        if (!WebUtil.IsDecimal(ebit)) { bDoubleValue = false; break; }
                        if (!WebUtil.IsDecimal(pbt)) { bDoubleValue = false; break; }
                        if (!WebUtil.IsDecimal(netProfitTerm)) { bDoubleValue = false; break; }

                        var pQuarterPalSummary = new PmQuarterPalBusinessSummary();
                        // pPalSummary.Seq = Convert.ToInt32(excelSeq);
                        pQuarterPalSummary.PmQuarterPalBusinessSeq = Seq;
                        pQuarterPalSummary.BusinessQuarter = Convert.ToInt32(montyType);
                        pQuarterPalSummary.Sales = Convert.ToDecimal(sales);
                        pQuarterPalSummary.Ebit = Convert.ToDecimal(ebit);
                        pQuarterPalSummary.Pbt = Convert.ToDecimal(pbt);
                        pQuarterPalSummary.NetProfitTerm = Convert.ToDecimal(netProfitTerm);

                        pQuarterPalSummaryList.Add(pQuarterPalSummary);
                        j += 1;
                    }
                }
                catch (Exception e)
                {
                    fileUtil.FileDelete(filePath, file["STORED_FILE_NAME"]);
                    result = false;
                    resultMsg = Message.MSG_007_E;
                    return Json(new { success = result, resultMsg = resultMsg }, JsonRequestBehavior.AllowGet);
                }

                if (!bDoubleValue)
                {
                    fileUtil.FileDelete(filePath, file["STORED_FILE_NAME"]);
                    result = false;
                    resultMsg = Message.MSG_007_E;
                    return Json(new { success = result, resultMsg = resultMsg }, JsonRequestBehavior.AllowGet);
                }

                // 문제 없으면 업데이트
                for (int i = 0; i < pBusinessList.Count(); i++)
                {
                    PmQuarterPalBusiness p = new PmQuarterPalBusiness();
                    p.Seq = pBusinessList[i].Seq;
                    p.Sales = pBusinessList[i].Sales;
                    p.Ebit = pBusinessList[i].Ebit;
                    p.Pbt = pBusinessList[i].Pbt;

                    pmQuarterPalBusinessRepo.update(p);
                }

                for (int i = 0; i < pQuarterPalSummaryList.Count(); i++)
                {
                    PmQuarterPalBusinessSummary pSum = new PmQuarterPalBusinessSummary();
                    pSum.PmQuarterPalBusinessSeq = pQuarterPalSummaryList[i].PmQuarterPalBusinessSeq;
                    pSum.BusinessYear = QuarterPalYear;
                    pSum.BusinessQuarter = pQuarterPalSummaryList[i].BusinessQuarter;
                    pSum.Sales = pQuarterPalSummaryList[i].Sales;
                    pSum.Ebit = pQuarterPalSummaryList[i].Ebit;
                    pSum.Pbt = pQuarterPalSummaryList[i].Pbt;
                    pSum.NetProfitTerm = pQuarterPalSummaryList[i].NetProfitTerm;
                    pmQuarterPalBusinessSummaryRepo.insert2(pSum);
                }
                // 업데이트 완료 후 로그 남기기
                ExcelFileUploadList eFileList = new ExcelFileUploadList();
                eFileList.UserKey = SessionManager.GetAdminSession().insaUserV.userKey;
                eFileList.EmpNo = SessionManager.GetAdminSession().insaUserV.empNo;
                eFileList.AttachTableName = "PM_QUARTER_PAL";
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