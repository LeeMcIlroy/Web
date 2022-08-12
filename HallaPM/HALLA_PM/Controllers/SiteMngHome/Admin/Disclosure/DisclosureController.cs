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
    [RoutePrefix("SiteMngHome/Admin/Disclosure")]
    public class DisclosureController : SiteMngBaseController
    {
        /// <summary>
        /// 리스트
        /// </summary>
        /// <returns></returns>
        [Route("List")]
        public ActionResult List(Search search)
        {
            dynamic model = new ExpandoObject();
            model.disclosureItemCount = disclosureItemRepo.count(search);
            model.disclosureDetailCount = disclosureDetailRepo.count(search);
            model.list = disclosureTitleRepo.selectList(search);

            ViewBag.Search = search;
            return View("~/Views/SiteMngHome/Admin/Disclosure/List.cshtml", model);
        }

        /// <summary>
        /// 공시항목 등록
        /// </summary>
        /// <returns></returns>
        [Route("DisclosureItem_Write")]
        public ActionResult DisclosureItemWrite()
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");

            return View("~/Views/SiteMngHome/Admin/Disclosure/DisclosureItem_Write.cshtml");
        }

        /// <summary>
        /// 공시항목 수정
        /// </summary>
        /// <param name="seq"></param>
        /// <returns></returns>
        [Route("DisclosureItem_Edit")]
        public ActionResult DisclosureItemEdit(int? Seq)
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");
            if (Seq == null || Seq == 0) return RedirectToAction("List");

            dynamic model = new ExpandoObject();
            model.DisItemList = disclosureItemRepo.selectOne(new { Seq = Seq });
            return View("~/Views/SiteMngHome/Admin/Disclosure/DisclosureItem_Edit.cshtml", model);
        }

        /// <summary>
        /// 공시항목 저장
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        [Route("DisclosureItem_Write_Action")]
        public ActionResult DisclosureItemWriteAction(DisclosureItem entity)
        {
            if (disclosureItemRepo.save(entity) > 0)
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
        /// 공시항목 삭제
        /// </summary>
        /// <param name="Seq"></param>
        /// <returns></returns>
        [Route("DisclosureItem_Delete_Action")]
        public ActionResult DisclosureItemDeleteAction(int Seq)
        {
            var disDetail = disclosureDetailRepo.selectListUnion(new { Seq = Seq });
            var disTitle = disclosureTitleRepo.selectListUnion(new { Seq = Seq });

            if (disDetail != null && disDetail.Count() > 0 || disTitle != null && disTitle.Count() > 0)
            {
                TempData["alert"] = "하위 항목 삭제 후 삭제 가능합니다.";

            }
            else
            {
                disclosureItemRepo.delete(new { Seq = Seq });
                TempData["alert"] = "공시항목이 삭제되었습니다.";
            }

            return RedirectToAction("List");

        }

        /// <summary>
        /// 공시항목 중복확인
        /// </summary>
        /// <param name="DisName"></param>
        /// <returns></returns>
        [Route("DisclosureItem_Duplicate_Ajax")]
        public ActionResult DisclosureItemDuplicateAjax(string DisName)
        {
            if (disclosureItemRepo.selectDuplicate(new { DisName = DisName }) > 0)
            {
                return Json(new { success = false }, JsonRequestBehavior.DenyGet);
            }
            else
            {
                return Json(new { success = true }, JsonRequestBehavior.DenyGet);
            }
        }

        /// <summary>
        /// 세부항목등록
        /// </summary>
        /// <returns></returns>
        [Route("DisclosureDetail_Write")]
        public ActionResult DisclosureDetailWrite()
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");

            dynamic model = new ExpandoObject();
            model.disItemList = disclosureItemRepo.selectList(new { });
            //model.YearList = planScheduleRepo.selectListAll();
            return View("~/Views/SiteMngHome/Admin/Disclosure/DisclosureDetail_Write.cshtml", model);
        }

        /// <summary>
        /// 세부항목수정
        /// </summary>
        /// <returns></returns>
        [Route("DisclosureDetail_Edit")]
        public ActionResult DisclosureDetailEdit(int? Seq)
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");
            if (Seq == null || Seq == 0) return RedirectToAction("List");

            dynamic model = new ExpandoObject();
            model.disItemList = disclosureItemRepo.selectList(new { });
            model.detail = disclosureDetailRepo.selectOne(new { Seq = Seq });
            //model.YearList = planScheduleRepo.selectListAll();
            return View("~/Views/SiteMngHome/Admin/Disclosure/DisclosureDetail_Edit.cshtml", model);
        }

        /// <summary>
        /// 세부항목저장
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        [Route("DisclosureDetail_Write_Action")]
        public ActionResult DisclosureDetailWriteAction(DisclosureDetail entity)
        {
            int seq = disclosureDetailRepo.save(entity);
            if (seq > 0)
            {
                TempData["alert"] = entity.message + "되었습니다.";

                //var maxYear  = planScheduleRepo.selectOneMaxYear(new { });

                //bool isFirst = true;
                //// 사용 미사용에 따라 데이터 입력 혹은 삭제
                //if (entity.IsUse == "Y")
                //{
                //    for (int i = Convert.ToInt32(entity.UseYear); i < Convert.ToInt32(maxYear.ScheduleYear); i++)
                //    {
                //        //계획이 있는지 체크하여 계획을 넣어준다.

                //        // 손익월별계획
                //        PlanMonthlyPal planMonthlyPal = new PlanMonthlyPal();
                //        planMonthlyPal.MonthlyPalYear = i.ToString();
                //        planMonthlyPal.OrgCompanySeq = seq;
                //        planMonthlyPal.RegistStatus = Define.REGIST_STATUS.GetKey("미등록");
                //        var item = planMonthlyPalRepo.selectOneCompany(planMonthlyPal);
                //        if (item == null) planMonthlyPalRepo.insert(planMonthlyPal);

                //        // 손익중기계획
                //        PlanYearPal planYearPal = new PlanYearPal();
                //        planYearPal.YearPalYear = i.ToString();
                //        planYearPal.OrgCompanySeq = seq;
                //        planYearPal.RegistStatus = Define.REGIST_STATUS.GetKey("미등록");
                //        var item2 = planYearPalRepo.selectOneCompany(planYearPal);
                //        if (item2 == null) planYearPalRepo.insert(planYearPal);

                //        // 중기BS
                //        PlanYearBs planYearBs = new PlanYearBs();
                //        planYearBs.YearBsYear = i.ToString();
                //        planYearBs.OrgCompanySeq = seq;
                //        planYearBs.RegistStatus = Define.REGIST_STATUS.GetKey("미등록");
                //        var item3 = planYearBsRepo.selectOneCompany(planYearBs);
                //        if (item3 == null) planYearBsRepo.insert(planYearBs);

                //        // 중기CF
                //        PlanYearCf planYearCf = new PlanYearCf();
                //        planYearCf.YearCfYear = i.ToString();
                //        planYearCf.OrgCompanySeq = seq;
                //        planYearCf.RegistStatus = Define.REGIST_STATUS.GetKey("미등록");
                //        var item4 = planYearCfRepo.selectOneCompany(planYearCf);
                //        if (item4 == null) planYearCfRepo.insert(planYearCf);

                //        // 월별투자인원계획
                //        PlanMonthlyInvest planMonthlyInvest = new PlanMonthlyInvest();
                //        planMonthlyInvest.MonthlyInvestYear = i.ToString();
                //        planMonthlyInvest.OrgCompanySeq = seq;
                //        planMonthlyInvest.RegistStatus = Define.REGIST_STATUS.GetKey("미등록");
                //        var item11 = planMonthlyInvestRepo.selectOneCompany(planMonthlyInvest);
                //        if (item11 == null) planMonthlyInvestRepo.insert(planMonthlyInvest);

                //        // 중기투자인원계획
                //        PlanYearInvest planYearInvest = new PlanYearInvest();
                //        planYearInvest.YearInvestYear = i.ToString();
                //        planYearInvest.OrgCompanySeq = seq;
                //        planYearInvest.RegistStatus = Define.REGIST_STATUS.GetKey("미등록");
                //        var item5 = planYearInvestRepo.selectOneCompany(planYearInvest);
                //        if (item5 == null) planYearInvestRepo.insert(planYearInvest);

                //        if (i.ToString() != entity.UseYear) { isFirst = false; }

                //        // 실적은 월별 입력 초기 설정을 1월부터 12월까지
                //        PmCashFlow pmCashFlow = new PmCashFlow();           // Cash Flow
                //        PmPal pmPal = new PmPal();                          // 손익
                //        PmQuarterPal pmQuarterPal = new PmQuarterPal();     // 분기별손익
                //        PmBs pmBs = new PmBs();                             // BS
                //        PmBsEx pmBsEx = new PmBsEx();
                //        PmInvest pmInvest = new PmInvest();                 // 투자인원계획

                //        int startMonth = isFirst ? Convert.ToInt32(entity.UseMonth) : 1;
                //        for (int j = startMonth; j <= 12; j++)
                //        {
                //            pmCashFlow.CashFlowYear = i.ToString();
                //            pmCashFlow.OrgCompanySeq = seq;
                //            pmCashFlow.Monthly = j.ToString().PadLeft(2, '0');
                //            pmCashFlow.RegistStatus = Define.REGIST_STATUS.GetKey("미등록");
                //            var item6 = pmCashFlowRepo.selectOneCompany(pmCashFlow);
                //            if (item6 == null) pmCashFlowRepo.insert(pmCashFlow);

                //            pmPal.PalYear = i.ToString();
                //            pmPal.OrgCompanySeq = seq;
                //            pmPal.Monthly = j.ToString().PadLeft(2, '0');
                //            pmPal.RegistStatus = Define.REGIST_STATUS.GetKey("미등록");
                //            var item7 = pmPalRepo.selectOneCompany(pmPal);
                //            if (item7 == null) pmPalRepo.insert(pmPal);

                //            pmQuarterPal.QuarterPalYear = i.ToString();
                //            pmQuarterPal.OrgCompanySeq = seq;
                //            pmQuarterPal.Monthly = j.ToString().PadLeft(2, '0');
                //            pmQuarterPal.RegistStatus = Define.REGIST_STATUS.GetKey("미등록");
                //            var item8 = pmQuarterPalRepo.selectOneCompany(pmQuarterPal);
                //            if (item8 == null) pmQuarterPalRepo.insert(pmQuarterPal);

                //            pmBs.BsYear = i.ToString();
                //            pmBs.OrgCompanySeq = seq;
                //            pmBs.Monthly = j.ToString().PadLeft(2, '0');
                //            pmBs.RegistStatus = Define.REGIST_STATUS.GetKey("미등록");
                //            var item9 = pmBsRepo.selectOneCompany(pmBs);
                //            if (item9 == null) pmBsRepo.insert(pmBs);

                //            pmInvest.InvestYear = i.ToString();
                //            pmInvest.OrgCompanySeq = seq;
                //            pmInvest.Monthly = j.ToString().PadLeft(2, '0');
                //            pmInvest.RegistStatus = Define.REGIST_STATUS.GetKey("미등록");
                //            var item10 = pmInvestRepo.selectOneCompany(pmInvest);
                //            if (item10 == null) pmInvestRepo.insert(pmInvest);
                //        }

                //    }
                //}
                //else
                //{
                //    // 실적은 월별 입력 초기 설정을 1월부터 12월까지\
                //    pmCashFlowRepo.deleteOrg(new { Year = entity.UseYear, Month = entity.UseMonth, OrgCompanySeq = entity.Seq });
                //    pmPalRepo.deleteOrg(new { Year = entity.UseYear, Month = entity.UseMonth, OrgCompanySeq = entity.Seq });
                //    pmQuarterPalRepo.deleteOrg(new { Year = entity.UseYear, Month = entity.UseMonth, OrgCompanySeq = entity.Seq });
                //    pmBsRepo.deleteOrg(new { Year = entity.UseYear, Month = entity.UseMonth, OrgCompanySeq = entity.Seq });
                //    pmInvestRepo.deleteOrg(new { Year = entity.UseYear, Month = entity.UseMonth, OrgCompanySeq = entity.Seq });
                //}
            }
            else
            {
                TempData["alert"] = entity.message + "에 실패했습니다.";
            }
            //entity.UserKey = mng
            return RedirectToAction("List");
        }
        
        /// <summary>
        /// 세부항목삭제
        /// </summary>
        /// <param name="Seq"></param>
        /// <returns></returns>
        [Route("DisclosureDetail_Delete_Action")]
        public ActionResult DisclosureDetailDeleteAction(int Seq/*, string UseYear, string UseMonth*/)
        {
            var disTitle = disclosureTitleRepo.selectListDetail(new { Seq = Seq });

            if (disTitle != null && disTitle.Count() > 0)
            {
                TempData["alert"] = "하위 항목 삭제 후 삭제 가능합니다.";

                //foreach (var item in orgBusiness)
                //{
                //    orgBusinessRepo.delete(new { Seq = item.Seq });
                //}
            }
            else
            {
                disclosureDetailRepo.delete(new { Seq = Seq });

                TempData["alert"] = "세부항목이 삭제되었습니다.";

            }

            //var maxYear = planScheduleRepo.selectOneMaxYear(new { });

            //var entity = orgCompanyRepo.selectOne(new { Seq });
            //entity.UseYear = UseYear;
            //entity.UseMonth = UseMonth;

            // 실적은 월별 입력 초기 설정을 1월부터 12월까지\
            //pmCashFlowRepo.deleteOrg(new { Year = entity.UseYear, Month = entity.UseMonth, OrgCompanySeq = entity.Seq });
            //pmPalRepo.deleteOrg(new { Year = entity.UseYear, Month = entity.UseMonth, OrgCompanySeq = entity.Seq });
            //pmQuarterPalRepo.deleteOrg(new { Year = entity.UseYear, Month = entity.UseMonth, OrgCompanySeq = entity.Seq });
            //pmBsRepo.deleteOrg(new { Year = entity.UseYear, Month = entity.UseMonth, OrgCompanySeq = entity.Seq });
            //pmInvestRepo.deleteOrg(new { Year = entity.UseYear, Month = entity.UseMonth, OrgCompanySeq = entity.Seq });

            //if (orgCompanyRepo.delete(new { Seq = Seq}) == -1)
            //{
            //    TempData["alert"] = "삭제에 실패했습니다.";
            //}
            //else
            //{
            //    TempData["alert"] = "조직이 삭제되었습니다.";
            //}
            return RedirectToAction("List");
        }

        /// <summary>
        /// 세부항목 중복확인
        /// </summary>
        /// <param name="DetailName"></param>
        /// <returns></returns>
        [Route("DisclosureDetail_Duplicate_Ajax")]
        public ActionResult DisclosureDetailDuplicateAjax(string DetailName, int DisItemSeq)
        {
            if (disclosureDetailRepo.selectDuplicate(new { DetailName = DetailName, DisItemSeq = DisItemSeq }) > 0)
            {
                return Json(new { success = false }, JsonRequestBehavior.DenyGet);
            }
            else
            {
                return Json(new { success = true }, JsonRequestBehavior.DenyGet);
            }
        }


        [Route("DisclosureTitle_Write")]
        public ActionResult DisclosureTitleWrite()
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");

            dynamic model = new ExpandoObject();
            model.disItemList = disclosureItemRepo.selectList(new { });
            return View("~/Views/SiteMngHome/Admin/Disclosure/DisclosureTitle_Write.cshtml", model);
        }

        [Route("DisclosureTitle_Edit")]
        public ActionResult DisclosureTitleEdit(int? Seq,int? DisItemSeq)
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");
            if (Seq == null || Seq == 0) return RedirectToAction("List");

            var title = disclosureTitleRepo.selectOne(new { Seq = Seq });
            dynamic model = new ExpandoObject();
            model.title = title;

            var disItemList = disclosureItemRepo.selectOne(new { Seq = DisItemSeq });
            model.disItem = disItemList;
            model.disItemList = disclosureItemRepo.selectList(new { });

            model.detailList = disclosureDetailRepo.selectList(new { DisItemSeq = disItemList.Seq });
            return View("~/Views/SiteMngHome/Admin/Disclosure/DisclosureTitle_Edit.cshtml", model);
        }

        [Route("DisclosureTitle_Write_Action")]
        public ActionResult DisclosureTitleWriteAction(DisclosureTitle entity)
        {
            if (disclosureTitleRepo.save(entity) > 0)
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
        /// 공시제목 삭제
        /// </summary>
        /// <param name="Seq"></param>
        /// <returns></returns>
        [Route("DisclosureTitle_Delete_Action")]
        public ActionResult DisclosureTitleDeleteAction(int Seq)
        {
            if (disclosureTitleRepo.delete(new { Seq = Seq }) == -1)
            {
                TempData["alert"] = "삭제에 실패했습니다.";
            }
            else
            {
                TempData["alert"] = "공시제목이 삭제되었습니다.";
            }
            return RedirectToAction("List");
        }

        /// <summary>
        /// 공시제목 중복확인
        /// </summary>
        /// <param name="Title"></param>
        /// <returns></returns>
        [Route("DisclosureTitle_Duplicate_Ajax")]
        public ActionResult DisclosureTitleDuplicateAjax(string Title, int DetailSeq)
        {
            if (disclosureTitleRepo.selectDuplicate(new { Title = Title, DetailSeq = DetailSeq }) > 0)
            {
                return Json(new { success = false }, JsonRequestBehavior.DenyGet);
            }
            else
            {
                return Json(new { success = true }, JsonRequestBehavior.DenyGet);
            }
        }

        [Route("DisclosureDetail_Ajax")]
        public ActionResult DisclosureDetailAjax(int? DisItemSeq)
        {
            if (DisItemSeq == null || DisItemSeq == 0)
            {
                return Json(new { success = false, list = new JsonResult() }, JsonRequestBehavior.DenyGet);
            }
            else
            {
                List<DisclosureDetail> detail = disclosureDetailRepo.selectList(new { DisItemSeq = DisItemSeq }).ToList();
                return Json(new { success = true, list = detail }, JsonRequestBehavior.DenyGet);
            }
        }
    }
}