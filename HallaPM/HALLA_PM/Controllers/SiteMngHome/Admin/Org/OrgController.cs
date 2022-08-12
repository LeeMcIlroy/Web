using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

using HALLA_PM.Core;
using HALLA_PM.Util;
using HALLA_PM.Models;
using System.Dynamic;

namespace HALLA_PM.Controllers.SiteMngHome
{
    /// <summary>
    /// 조직관리 컨트롤러
    /// </summary>
    [AdminLoginFilter]
    [AuthAdminFilter(RequestAuthLevel = 1)]
    [RoutePrefix("SiteMngHome/Admin/Org")]
    public class OrgController : SiteMngBaseController
    {
        /// <summary>
        /// 리스트
        /// </summary>
        /// <returns></returns>
        [Route("List")]
        public ActionResult List(Search search)
        {
            dynamic model = new ExpandoObject();
            model.UnionCount = orgUnionRepo.count(search);
            model.companyCount = orgCompanyRepo.count(search);
            model.list = orgBusinessRepo.selectList(search);

            ViewBag.Search = search;
            return View("~/Views/SiteMngHome/Admin/Org/List.cshtml", model);
        }

        /// <summary>
        /// 부문등록
        /// </summary>
        /// <returns></returns>
        [Route("Union_Write")]
        public ActionResult UnionWrite()
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");

            return View("~/Views/SiteMngHome/Admin/Org/Union_Write.cshtml");
        }

        /// <summary>
        /// 부문수정
        /// </summary>
        /// <param name="seq"></param>
        /// <returns></returns>
        [Route("Union_Edit")]
        public ActionResult UnionEdit(int? Seq)
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");
            if (Seq == null || Seq == 0) return RedirectToAction("List");

            dynamic model = new ExpandoObject();
            model.org = orgUnionRepo.selectOne(new { Seq = Seq });
            return View("~/Views/SiteMngHome/Admin/Org/Union_Edit.cshtml", model);
        }

        /// <summary>
        /// 부문저장
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        [Route("Union_Write_Action")]
        public ActionResult UnionWriteAction(OrgUnion entity)
        {
            if (orgUnionRepo.save(entity) > 0)
            {
                TempData["alert"] = entity.message + "되었습니다.";
            }
            else
            {
                TempData["alert"] = entity.message + "에 실패했습니다.";
            }
            //entity.UserKey = mng
            return RedirectToAction("List");
        }

        /// <summary>
        /// 부문삭제
        /// </summary>
        /// <param name="Seq"></param>
        /// <returns></returns>
        [Route("Union_Delete_Action")]
        public ActionResult UnionDeleteAction(int Seq)
        {
            var orgBusiness = orgBusinessRepo.selectListUnion(new { Seq = Seq });

            if (orgBusiness != null && orgBusiness.Count() > 0)
            {
                foreach (var item in orgBusiness)
                {
                    orgBusinessRepo.delete(new { Seq = item.Seq });
                }
            }

            var orgCom = orgCompanyRepo.selectListUnion(new { Seq = Seq });

            if (orgCom != null && orgCom.Count() > 0)
            {
                foreach (var item in orgCom)
                {
                    orgCompanyRepo.delete(new { Seq = item.Seq });
                }
            }

            if (orgUnionRepo.delete(new { Seq = Seq }) == -1)
            {
                TempData["alert"] = "삭제에 실패했습니다.";
            }
            else
            {
                TempData["alert"] = "조직이 삭제되었습니다.";
            }
            return RedirectToAction("List");
        }

        /// <summary>
        /// 부문중복확인
        /// </summary>
        /// <param name="UnionName"></param>
        /// <returns></returns>
        [Route("Union_Duplicate_Ajax")]
        public ActionResult UnionDuplicateAjax(string UnionName)
        {
            if (orgUnionRepo.selectDuplicate(new { UnionName = UnionName }) > 0)
            {
                return Json(new { success = false }, JsonRequestBehavior.DenyGet);
            }
            else
            {
                return Json(new { success = true }, JsonRequestBehavior.DenyGet);
            }
        }

        /// <summary>
        /// 회사등록
        /// </summary>
        /// <returns></returns>
        [Route("Company_Write")]
        public ActionResult CompanyWrite()
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");

            dynamic model = new ExpandoObject();
            model.UnionList = orgUnionRepo.selectList(new { });
            model.YearList = planScheduleRepo.selectListAll();
            return View("~/Views/SiteMngHome/Admin/Org/Company_Write.cshtml", model);
        }

        /// <summary>
        /// 회사수정
        /// </summary>
        /// <returns></returns>
        [Route("Company_Edit")]
        public ActionResult CompanyEdit(int? Seq)
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");
            if (Seq == null || Seq == 0) return RedirectToAction("List");

            dynamic model = new ExpandoObject();
            model.org = orgCompanyRepo.selectOne(new { Seq = Seq });
            model.UnionList = orgUnionRepo.selectList(new { });
            model.YearList = planScheduleRepo.selectListAll();
            return View("~/Views/SiteMngHome/Admin/Org/Company_Edit.cshtml", model);
        }

        /// <summary>
        /// 회사저장
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        [Route("Company_Write_Action")]
        public ActionResult CompanyWriteAction(OrgCompany entity)
        {
            int seq = orgCompanyRepo.save(entity);
            if (seq > 0)
            {
                TempData["alert"] = entity.message + "되었습니다.";

                int selectYear = 0;
                var maxYear  = planScheduleRepo.selectOneMaxYear(new { });
                var disMaxYear = disclosureRepo.selectOneDisclosureMaxYear(new{ });
                if(disMaxYear.Year == "" || disMaxYear.Year == null)
                {
                    selectYear = Convert.ToInt32(entity.UseDisYear);
                }         
                else
                {
                    selectYear = Convert.ToInt32(disMaxYear.Year);
                }

                bool isFirst = true;
                // 사용 미사용에 따라 데이터 입력 혹은 삭제
                if (entity.IsUse == "Y" && entity.UseYear != "" && entity.UseMonth !="")
                {
                    for (int i = Convert.ToInt32(entity.UseYear); i < Convert.ToInt32(maxYear.ScheduleYear); i++)
                    {
                        //계획이 있는지 체크하여 계획을 넣어준다.

                        // 손익월별계획
                        PlanMonthlyPal planMonthlyPal = new PlanMonthlyPal();
                        planMonthlyPal.MonthlyPalYear = i.ToString();
                        planMonthlyPal.OrgCompanySeq = seq;
                        planMonthlyPal.RegistStatus = Define.REGIST_STATUS.GetKey("미등록");
                        var item = planMonthlyPalRepo.selectOneCompany(planMonthlyPal);
                        if (item == null) planMonthlyPalRepo.insert(planMonthlyPal);

                        // 손익중기계획
                        PlanYearPal planYearPal = new PlanYearPal();
                        planYearPal.YearPalYear = i.ToString();
                        planYearPal.OrgCompanySeq = seq;
                        planYearPal.RegistStatus = Define.REGIST_STATUS.GetKey("미등록");
                        var item2 = planYearPalRepo.selectOneCompany(planYearPal);
                        if (item2 == null) planYearPalRepo.insert(planYearPal);

                        // 중기BS
                        PlanYearBs planYearBs = new PlanYearBs();
                        planYearBs.YearBsYear = i.ToString();
                        planYearBs.OrgCompanySeq = seq;
                        planYearBs.RegistStatus = Define.REGIST_STATUS.GetKey("미등록");
                        var item3 = planYearBsRepo.selectOneCompany(planYearBs);
                        if (item3 == null) planYearBsRepo.insert(planYearBs);

                        // 중기CF
                        PlanYearCf planYearCf = new PlanYearCf();
                        planYearCf.YearCfYear = i.ToString();
                        planYearCf.OrgCompanySeq = seq;
                        planYearCf.RegistStatus = Define.REGIST_STATUS.GetKey("미등록");
                        var item4 = planYearCfRepo.selectOneCompany(planYearCf);
                        if (item4 == null) planYearCfRepo.insert(planYearCf);

                        // 월별투자인원계획
                        PlanMonthlyInvest planMonthlyInvest = new PlanMonthlyInvest();
                        planMonthlyInvest.MonthlyInvestYear = i.ToString();
                        planMonthlyInvest.OrgCompanySeq = seq;
                        planMonthlyInvest.RegistStatus = Define.REGIST_STATUS.GetKey("미등록");
                        var item11 = planMonthlyInvestRepo.selectOneCompany(planMonthlyInvest);
                        if (item11 == null) planMonthlyInvestRepo.insert(planMonthlyInvest);

                        // 중기투자인원계획
                        PlanYearInvest planYearInvest = new PlanYearInvest();
                        planYearInvest.YearInvestYear = i.ToString();
                        planYearInvest.OrgCompanySeq = seq;
                        planYearInvest.RegistStatus = Define.REGIST_STATUS.GetKey("미등록");
                        var item5 = planYearInvestRepo.selectOneCompany(planYearInvest);
                        if (item5 == null) planYearInvestRepo.insert(planYearInvest);

                        if (i.ToString() != entity.UseYear) { isFirst = false; }

                        // 실적은 월별 입력 초기 설정을 1월부터 12월까지
                        PmCashFlow pmCashFlow = new PmCashFlow();           // Cash Flow
                        PmPal pmPal = new PmPal();                          // 손익
                        PmQuarterPal pmQuarterPal = new PmQuarterPal();     // 분기별손익
                        PmBs pmBs = new PmBs();                             // BS
                        PmBsEx pmBsEx = new PmBsEx();
                        PmInvest pmInvest = new PmInvest();                 // 투자인원계획

                        int startMonth = isFirst ? Convert.ToInt32(entity.UseMonth) : 1;
                        for (int j = startMonth; j <= 12; j++)
                        {
                            pmCashFlow.CashFlowYear = i.ToString();
                            pmCashFlow.OrgCompanySeq = seq;
                            pmCashFlow.Monthly = j.ToString().PadLeft(2, '0');
                            pmCashFlow.RegistStatus = Define.REGIST_STATUS.GetKey("미등록");
                            var item6 = pmCashFlowRepo.selectOneCompany(pmCashFlow);
                            if (item6 == null) pmCashFlowRepo.insert(pmCashFlow);

                            pmPal.PalYear = i.ToString();
                            pmPal.OrgCompanySeq = seq;
                            pmPal.Monthly = j.ToString().PadLeft(2, '0');
                            pmPal.RegistStatus = Define.REGIST_STATUS.GetKey("미등록");
                            var item7 = pmPalRepo.selectOneCompany(pmPal);
                            if (item7 == null) pmPalRepo.insert(pmPal);

                            pmQuarterPal.QuarterPalYear = i.ToString();
                            pmQuarterPal.OrgCompanySeq = seq;
                            pmQuarterPal.Monthly = j.ToString().PadLeft(2, '0');
                            pmQuarterPal.RegistStatus = Define.REGIST_STATUS.GetKey("미등록");
                            var item8 = pmQuarterPalRepo.selectOneCompany(pmQuarterPal);
                            if (item8 == null) pmQuarterPalRepo.insert(pmQuarterPal);

                            pmBs.BsYear = i.ToString();
                            pmBs.OrgCompanySeq = seq;
                            pmBs.Monthly = j.ToString().PadLeft(2, '0');
                            pmBs.RegistStatus = Define.REGIST_STATUS.GetKey("미등록");
                            var item9 = pmBsRepo.selectOneCompany(pmBs);
                            if (item9 == null) pmBsRepo.insert(pmBs);

                            pmInvest.InvestYear = i.ToString();
                            pmInvest.OrgCompanySeq = seq;
                            pmInvest.Monthly = j.ToString().PadLeft(2, '0');
                            pmInvest.RegistStatus = Define.REGIST_STATUS.GetKey("미등록");
                            var item10 = pmInvestRepo.selectOneCompany(pmInvest);
                            if (item10 == null) pmInvestRepo.insert(pmInvest);
                        }

                    }
                }
                else
                {
                    // 실적은 월별 입력 초기 설정을 1월부터 12월까지\
                    pmCashFlowRepo.deleteOrg(new { Year = entity.UseYear, Month = entity.UseMonth, OrgCompanySeq = entity.Seq });
                    pmPalRepo.deleteOrg(new { Year = entity.UseYear, Month = entity.UseMonth, OrgCompanySeq = entity.Seq });
                    pmQuarterPalRepo.deleteOrg(new { Year = entity.UseYear, Month = entity.UseMonth, OrgCompanySeq = entity.Seq });
                    pmBsRepo.deleteOrg(new { Year = entity.UseYear, Month = entity.UseMonth, OrgCompanySeq = entity.Seq });
                    pmInvestRepo.deleteOrg(new { Year = entity.UseYear, Month = entity.UseMonth, OrgCompanySeq = entity.Seq });
                }
            }
            else
            {
                TempData["alert"] = entity.message + "에 실패했습니다.";
            }
            //entity.UserKey = mng
            return RedirectToAction("List");
        }
        
        /// <summary>
        /// 회사삭제
        /// </summary>
        /// <param name="Seq"></param>
        /// <returns></returns>
        [Route("Company_Delete_Action")]
        public ActionResult CompanyDeleteAction(int Seq, string UseYear, string UseMonth)
        {
            var orgBusiness = orgBusinessRepo.selectListCompany(new { Seq = Seq });

            if (orgBusiness != null && orgBusiness.Count() > 0)
            {
                foreach (var item in orgBusiness)
                {
                    orgBusinessRepo.delete(new { Seq = item.Seq });
                }
            }

            var maxYear = planScheduleRepo.selectOneMaxYear(new { });

            var entity = orgCompanyRepo.selectOne(new { Seq });
            entity.UseYear = UseYear;
            entity.UseMonth = UseMonth;

            // 실적은 월별 입력 초기 설정을 1월부터 12월까지\
            pmCashFlowRepo.deleteOrg(new { Year = entity.UseYear, Month = entity.UseMonth, OrgCompanySeq = entity.Seq });
            pmPalRepo.deleteOrg(new { Year = entity.UseYear, Month = entity.UseMonth, OrgCompanySeq = entity.Seq });
            pmQuarterPalRepo.deleteOrg(new { Year = entity.UseYear, Month = entity.UseMonth, OrgCompanySeq = entity.Seq });
            pmBsRepo.deleteOrg(new { Year = entity.UseYear, Month = entity.UseMonth, OrgCompanySeq = entity.Seq });
            pmInvestRepo.deleteOrg(new { Year = entity.UseYear, Month = entity.UseMonth, OrgCompanySeq = entity.Seq });

            if (orgCompanyRepo.delete(new { Seq = Seq}) == -1)
            {
                TempData["alert"] = "삭제에 실패했습니다.";
            }
            else
            {
                TempData["alert"] = "조직이 삭제되었습니다.";
            }
            return RedirectToAction("List");
        }

        /// <summary>
        /// 회사중복확인
        /// </summary>
        /// <param name="CompanyName"></param>
        /// <returns></returns>
        [Route("Company_Duplicate_Ajax")]
        public ActionResult CompanyDuplicateAjax(string CompanyName, int OrgUnionSeq)
        {
            if (orgCompanyRepo.selectDuplicate(new { CompanyName = CompanyName, OrgUnionSeq = OrgUnionSeq }) > 0)
            {
                return Json(new { success = false }, JsonRequestBehavior.DenyGet);
            }
            else
            {
                return Json(new { success = true }, JsonRequestBehavior.DenyGet);
            }
        }
        /// <summary>
        /// 공시사용여부 상태 변경
        /// </summary>
        /// <returns></returns>
        [Route("CompanyDisclosureUpdate")]
        public ActionResult CompanyDisclosureUpdate(int Seq, string UseDisMonth, string UseDisYear, string IsDisclosure)
        {


            bool result = false;
            string resultMsg = "";

            orgCompanyRepo.disclosureUpdate(new { Seq = Seq, IsDisclosure = IsDisclosure});

            result = true;
            if(IsDisclosure == "Y")
            {
                resultMsg = Message.MSG_008_E;
            }
            else
            {
                resultMsg = Message.MSG_008_R;

            }

            return Json(new { success = result, resultMsg = resultMsg }, JsonRequestBehavior.AllowGet);
        }
        /// <summary>
        /// 공시사용년월 변경
        /// </summary>
        /// <returns></returns>
        [Route("DisclosureUseDateUpdate")]
        public ActionResult DisclosureUseDateUpdate(int Seq, string UseDisMonth, string UseDisYear)
        {


            bool result = false;
            string resultMsg = "";

            orgCompanyRepo.disclosureUseDateUpdate(new { Seq = Seq, UseDisMonth = UseDisMonth, UseDisYear = UseDisYear });

            result = true;
            resultMsg = Message.MSG_008_T;

            

            return Json(new { success = result, resultMsg = resultMsg }, JsonRequestBehavior.AllowGet);
        }
        [Route("Business_Write")]
        public ActionResult BusinessWrite()
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");

            dynamic model = new ExpandoObject();
            model.UnionList = orgUnionRepo.selectList(new { });
            return View("~/Views/SiteMngHome/Admin/Org/Business_Write.cshtml", model);
        }

        [Route("Business_Edit")]
        public ActionResult BusinessEdit(int? Seq)
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");
            if (Seq == null || Seq == 0) return RedirectToAction("List");

            var org = orgBusinessRepo.selectOne(new { Seq = Seq });
            dynamic model = new ExpandoObject();
            model.org = org;
            model.UnionList = orgUnionRepo.selectList(new { });
            model.CompanyList = orgCompanyRepo.selectList(new { OrgUnionSeq = org.OrgUnionSeq });
            return View("~/Views/SiteMngHome/Admin/Org/Business_Edit.cshtml", model);
        }

        [Route("Business_Write_Action")]
        public ActionResult BusinessWriteAction(OrgBusiness entity)
        {
            if (orgBusinessRepo.save(entity) > 0)
            {
                TempData["alert"] = entity.message + "되었습니다.";
            }
            else
            {
                TempData["alert"] = entity.message + "에 실패했습니다.";
            }
            //entity.UserKey = mng
            return RedirectToAction("List");
        }

        /// <summary>
        /// Business삭제
        /// </summary>
        /// <param name="Seq"></param>
        /// <returns></returns>
        [Route("Business_Delete_Action")]
        public ActionResult BusinessDeleteAction(int Seq)
        {
            if (orgBusinessRepo.delete(new { Seq = Seq }) == -1)
            {
                TempData["alert"] = "삭제에 실패했습니다.";
            }
            else
            {
                TempData["alert"] = "조직이 삭제되었습니다.";
            }
            return RedirectToAction("List");
        }

        /// <summary>
        /// Business중복확인
        /// </summary>
        /// <param name="BusinessName"></param>
        /// <returns></returns>
        [Route("Business_Duplicate_Ajax")]
        public ActionResult BusinessDuplicateAjax(string BusinessName, int OrgCompanySeq)
        {
            if (orgBusinessRepo.selectDuplicate(new { BusinessName = BusinessName, OrgCompanySeq = OrgCompanySeq }) > 0)
            {
                return Json(new { success = false }, JsonRequestBehavior.DenyGet);
            }
            else
            {
                return Json(new { success = true }, JsonRequestBehavior.DenyGet);
            }
        }

        [Route("Company_Ajax")]
        public ActionResult CompanyAjax(int? OrgUnionSeq)
        {
            if (OrgUnionSeq == null || OrgUnionSeq == 0)
            {
                return Json(new { success = false, list = new JsonResult() }, JsonRequestBehavior.DenyGet);
            }
            else
            {
                List<OrgCompany> orgCom = orgCompanyRepo.selectList(new { OrgUnionSeq = OrgUnionSeq }).ToList();
                return Json(new { success = true, list = orgCom }, JsonRequestBehavior.DenyGet);
            }
        }
    }
}