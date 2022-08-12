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
    [RoutePrefix("SiteMngHome/Plan/Year_Invest")]
    public class PlanYearInvestController : SiteMngBaseController
    {
        [Route("List")]
        public ActionResult List(Search search)
        {
            dynamic model = new ExpandoObject();
            search.AuthUserKey = SessionManager.GetAdminSession().insaUserV.userKey;
            model.list = planYearInvestRepo.selectList(search);
            model.UnionList = orgUnionRepo.selectList(new { });
            model.OrgCpyList = orgCompanyRepo.selectList(null);
            ViewBag.Search = search;
            return View("~/Views/SiteMngHome/Plan/Year_Invest/List.cshtml", model);
        }

        [Route("Write")]
        public ActionResult Write(PlanYearInvest entity, Search search)
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");

            // 중기투자인원계획 - 기본데이터
            var planYearInvest = planYearInvestRepo.selectOne(entity);
            // 해당 회사의 부서 정보
            var orgBusinessList = orgBusinessRepo.selectListCompany(new { Seq = entity.OrgCompanySeq });
            // 부문 > 회사 이름
            var orgCompanyName = orgCompanyRepo.selectOne(new { Seq = entity.OrgCompanySeq });

            // 해당년도의 부서 월별데이터 체크하여 없으면 생성
            foreach (var business in orgBusinessList)
            {
                int thisYear = Convert.ToInt32(planYearInvest.YearInvestYear);
                int lastYear = thisYear + 4;
                for (int i = thisYear; i <= lastYear; i++)
                {
                    PlanYearInvestBusiness p = new PlanYearInvestBusiness();
                    p.PlanYearInvestSeq = entity.Seq;
                    p.OrgBusinessSeq = business.Seq;
                    p.YearlyYear = i.ToString();
                    p.Investment = 0;
                    p.Personnel = 0;
                    p.DomesticPersonnel = 0;
                    p.OverseasPersonnel = 0;

                    string where = " WHERE PLAN_YEAR_INVEST_SEQ = @PlanYearInvestSeq AND ORG_BUSINESS_SEQ = @OrgBusinessSeq AND YEARLY_YEAR = @YearlyYear ";
                    if (planYearInvestBusinessRepo.count(p, where) == 0) planYearInvestBusinessRepo.insert(p);
                }
            }

            // 상세데이터 가져오기
            var lastYearBusinessPm = pmInvestBusinessRepo.selectListBefore(new { InvestYear = planYearInvest.YearInvestYear, OrgCompanySeq = entity.OrgCompanySeq });
            var lastYearBusinessPn = planYearInvestBusinessRepo.selectListYear(new { YearInvestYear = (Convert.ToInt32(planYearInvest.YearInvestYear) - 1).ToString(), OrgCompanySeq = entity.OrgCompanySeq });
            var thisYearBusinessPn = planYearInvestBusinessRepo.selectListYear(new { YearInvestYear = planYearInvest.YearInvestYear, OrgCompanySeq = entity.OrgCompanySeq });
            //var thisYearBusinessPn = planYearInvestBusinessRepo.selectOne(new { });

            dynamic model = new ExpandoObject();
            model.planYearInvest = planYearInvest;
            model.orgBusinessList = orgBusinessList;
            model.orgCompanyName = orgCompanyName;
            model.lastYearBusinessPm = lastYearBusinessPm;
            model.lastYearBusinessPn = lastYearBusinessPn;
            model.thisYearBusinessPn = thisYearBusinessPn;

            ViewBag.Search = search;
            return View("~/Views/SiteMngHome/Plan/Year_Invest/Write.cshtml", model);
        }

        [Route("Excel_Down")]
        public ActionResult ExcelDown(PlanYearInvest entity)
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");

            // 중기투자인원계획 - 기본데이터
            var planYearInvest = planYearInvestRepo.selectOne(entity);
            // 부문 > 회사 이름
            var orgCompanyName = orgCompanyRepo.selectOne(new { Seq = entity.OrgCompanySeq });
            // 부서데이터
            var pBusinessList = planYearInvestBusinessRepo.selectListExcel(new { PlanYearInvestSeq=entity.Seq });

            string fileName = "중기투자인원계획_" + planYearInvest.YearInvestYear + "년_" + orgCompanyName.CompanyName;

            int rows = 1, cells = 1;

            using (XLWorkbook wb = new XLWorkbook())
            {
                var ws = wb.Worksheets.Add("중기투자인원계획");

                // 컬럼 숨기기
                ws.Column(1).Hide();
                ws.Column(2).Hide();
                ws.Column(4).Hide();

                ws.Cell(rows, cells).SetValue("ParentSeq").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                ws.Cell(rows, ++cells).SetValue("Seq").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                ws.Cell(rows, ++cells).SetValue("CompanyName").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                ws.Cell(rows, ++cells).SetValue("BusinessSeq").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                ws.Cell(rows, ++cells).SetValue("BusinessName").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                ws.Cell(rows, ++cells).SetValue("년도").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                ws.Cell(rows, ++cells).SetValue("투자").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                ws.Cell(rows, ++cells).SetValue("인원").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                ws.Cell(rows, ++cells).SetValue("국내인원").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                ws.Cell(rows, ++cells).SetValue("해외인원").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                foreach (var item in pBusinessList)
                {
                    rows++;
                    cells = 1;
                    ws.Cell(rows, cells).SetValue(item.PlanYearInvestSeq).Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin).Fill.SetBackgroundColor(XLColor.NoColor);
                    ws.Cell(rows, ++cells).SetValue(item.Seq).Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin).Fill.SetBackgroundColor(XLColor.NoColor);
                    ws.Cell(rows, ++cells).SetValue(item.CompanyName).Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin).Fill.SetBackgroundColor(XLColor.NoColor);
                    ws.Cell(rows, ++cells).SetValue(item.OrgBusinessSeq).Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin).Fill.SetBackgroundColor(XLColor.NoColor);
                    ws.Cell(rows, ++cells).SetValue(item.BusinessName).Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin).Fill.SetBackgroundColor(XLColor.NoColor);
                    ws.Cell(rows, ++cells).SetValue(item.YearlyYear).Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin).Fill.SetBackgroundColor(XLColor.NoColor);
                    ws.Cell(rows, ++cells).SetValue(item.Investment).Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin).Fill.SetBackgroundColor(XLColor.Yellow);
                    ws.Cell(rows, ++cells).SetValue(item.Personnel).Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin).Fill.SetBackgroundColor(XLColor.Yellow);
                    ws.Cell(rows, ++cells).SetValue(item.DomesticPersonnel).Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin).Fill.SetBackgroundColor(XLColor.Yellow);
                    ws.Cell(rows, ++cells).SetValue(item.OverseasPersonnel).Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin).Fill.SetBackgroundColor(XLColor.Yellow);
                }

                using (MemoryStream mStream = new MemoryStream())
                {
                    wb.SaveAs(mStream);
                    return File(mStream.ToArray(), "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", fileName + ".xlsx");
                }
            }
        }


        [Route("Excel_Down2")]
        public ActionResult ExcelDown2(PlanYearInvest entity)
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");

            // 중기투자인원계획 - 기본데이터
            var planYearInvest = planYearInvestRepo.selectOne(entity);
            // 부문 > 회사 이름
            var orgCompanyName = orgCompanyRepo.selectOne(new { Seq = entity.OrgCompanySeq });
            // 부서데이터
            var pBusinessList = planYearInvestBusinessRepo.selectListExcel(new { PlanYearInvestSeq = entity.Seq });

            string fileName = "중기투자인원계획_" + planYearInvest.YearInvestYear + "년_" + orgCompanyName.CompanyName;

            int rows = 1, cells = 1;

            using (XLWorkbook wb = new XLWorkbook())
            {
                var ws = wb.Worksheets.Add("중기투자인원계획");

                // 컬럼 숨기기
               // ws.Column(1).Hide();
                ws.Column(2).Hide();
                //ws.Column(4).Hide();

               // ws.Cell(rows, cells).SetValue("ParentSeq").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                //ws.Cell(rows, ++cells).SetValue("Seq").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                ws.Cell(rows, cells).SetValue("CompanyName").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                ws.Cell(rows, ++cells).SetValue("BusinessSeq").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                ws.Cell(rows, ++cells).SetValue("BusinessName").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                ws.Cell(rows, ++cells).SetValue("년도").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                ws.Cell(rows, ++cells).SetValue("투자").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                ws.Cell(rows, ++cells).SetValue("인원").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                ws.Cell(rows, ++cells).SetValue("국내인원").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                ws.Cell(rows, ++cells).SetValue("해외인원").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                foreach (var item in pBusinessList)
                {
                    rows++;
                    cells = 1;
                    //ws.Cell(rows, cells).SetValue(item.PlanYearInvestSeq).Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin).Fill.SetBackgroundColor(XLColor.NoColor);
                    //ws.Cell(rows, ++cells).SetValue(item.Seq).Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin).Fill.SetBackgroundColor(XLColor.NoColor);
                    ws.Cell(rows, cells).SetValue(item.CompanyName).Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin).Fill.SetBackgroundColor(XLColor.NoColor);
                    ws.Cell(rows, ++cells).SetValue(item.OrgBusinessSeq).Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin).Fill.SetBackgroundColor(XLColor.NoColor);
                    ws.Cell(rows, ++cells).SetValue(item.BusinessName).Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin).Fill.SetBackgroundColor(XLColor.NoColor);
                    ws.Cell(rows, ++cells).SetValue(item.YearlyYear).Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin).Fill.SetBackgroundColor(XLColor.NoColor);
                    ws.Cell(rows, ++cells).SetValue(item.Investment).Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin).Fill.SetBackgroundColor(XLColor.Yellow);
                    ws.Cell(rows, ++cells).SetValue(item.Personnel).Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin).Fill.SetBackgroundColor(XLColor.Yellow);
                    ws.Cell(rows, ++cells).SetValue(item.DomesticPersonnel).Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin).Fill.SetBackgroundColor(XLColor.Yellow);
                    ws.Cell(rows, ++cells).SetValue(item.OverseasPersonnel).Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin).Fill.SetBackgroundColor(XLColor.Yellow);
                }

                using (MemoryStream mStream = new MemoryStream())
                {
                    wb.SaveAs(mStream);
                    return File(mStream.ToArray(), "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", fileName + ".xlsx");
                }
            }
        }

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
                string filePath = "PlanYearInvest";
                var file = fileUtil.FileUpload(ExcelFile, filePath);

                bool bDoubleValue = true;
                ExcelUtil excelUtil = new ExcelUtil();
                var dt = excelUtil.ImportExcel(file["FILE_PATH"]);
                List<PlanYearInvestBusiness> pBusinessList = new List<PlanYearInvestBusiness>();
                try
                {
                    foreach (DataRow item in dt.Rows)
                    {
                        string parentSeq = item.ItemArray.GetValue(0).ToString();
                        string excelSeq = item.ItemArray.GetValue(1).ToString();
                        string companyName = item.ItemArray.GetValue(2).ToString();
                        string businessSeq = item.ItemArray.GetValue(3).ToString();
                        string businessName = item.ItemArray.GetValue(4).ToString();
                        string YealyYear = item.ItemArray.GetValue(5).ToString();
                        string Investment = item.ItemArray.GetValue(6).ToString();
                        string Personnel = item.ItemArray.GetValue(7).ToString();
                        string DomesticPersonnel = item.ItemArray.GetValue(8).ToString();
                        string OverseasPersonnel = item.ItemArray.GetValue(9).ToString();
                        if (parentSeq != Seq.ToString()) { bDoubleValue = false; break; }       // 현재 코드와 업로드하려는 코드가 다른 경우는 양식이 잘못된것으로 오류
                        //if (!WebUtil.CheckDecimalTwo(Investment)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(Personnel)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(DomesticPersonnel)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(OverseasPersonnel)) { bDoubleValue = false; break; }

                        PlanYearInvestBusiness pBusiness = new PlanYearInvestBusiness();
                        pBusiness.Seq = Convert.ToInt32(excelSeq);
                        pBusiness.Investment = Convert.ToDecimal(Investment);
                        pBusiness.Personnel = Convert.ToDecimal(Personnel);
                        pBusiness.DomesticPersonnel = Convert.ToDecimal(DomesticPersonnel);
                        pBusiness.OverseasPersonnel = Convert.ToDecimal(OverseasPersonnel);

                        pBusinessList.Add(pBusiness);
                    }
                }
                catch (Exception e)
                {
                    // 오류시 파일 삭제
                    fileUtil.FileDelete(filePath, file["STORED_FILE_NAME"]);
                    //LogUtil.MngError(e.ToString());
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
                foreach (var item in pBusinessList)
                {
                    planYearInvestBusinessRepo.update(item);
                }

                // 업데이트 완료 후 로그 남기기
                ExcelFileUploadList eFileList = new ExcelFileUploadList();
                eFileList.UserKey = SessionManager.GetAdminSession().insaUserV.userKey;
                eFileList.EmpNo = SessionManager.GetAdminSession().insaUserV.empNo;
                eFileList.AttachTableName = "PLAN_MONTHLY_INVEST";
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

        [Route("Calculation_Action")]
        public ActionResult CalculationAction(PlanYearInvestAdmin entity, Search search)
        {
            #region
            Dictionary<string, object> postData = new Dictionary<string, object>();
            postData.Add("Seq", entity.Seq);
            postData.Add("OrgCompanySeq", entity.OrgCompanySeq);
            postData.Add("PageIndex", search.PageIndex);
            #endregion

            // 부서별 데이터 검증(정수 혹은 소수점 2자리까지의 데이터)
            bool bDoubleValue = true;
            List<PlanYearInvestBusiness> pBusinessList = new List<PlanYearInvestBusiness>();
            try
            {
                for (int i = 0; i < entity.PlanYearInvestBusinessSeq.Count(); i++)
                {
                    if (!WebUtil.CheckDecimalTwo(entity.Investment[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.Personnel[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.DomesticPersonnel[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.OverseasPersonnel[i].ToString())) { bDoubleValue = false; break; }

                    PlanYearInvestBusiness p = new PlanYearInvestBusiness();
                    p.Seq = entity.PlanYearInvestBusinessSeq[i];
                    p.Investment = entity.Investment[i];
                    p.Personnel = entity.Personnel[i];
                    p.DomesticPersonnel = entity.DomesticPersonnel[i];
                    p.OverseasPersonnel = entity.OverseasPersonnel[i];

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
            else
            {
                TempData["alert"] = Message.MSG_002_A;
            }

            foreach (var item in pBusinessList)
            {
                planYearInvestBusinessRepo.update(item);
            }


            // 계산하기 하였을 경우 기존 데이터 삭제하여 부서별 데이터의 합계를 다시 입력
            PlanYearInvestSummary pSum = new PlanYearInvestSummary();
            pSum.PlanYearInvestSeq = entity.Seq;
            planYearInvestSummaryRepo.delete(pSum);
            planYearInvestSummaryRepo.insertSum(pSum);

            // 2018.10.29 수정화면에서 저장한 뒤에 저장상태로 변경
            //// 미저장에서 저장으로 변경
            //if (entity.RegistStatus == Define.REGIST_STATUS.GetKey("미등록"))
            //{
            //    PlanYearInvest p = new PlanYearInvest();
            //    p.Seq = entity.Seq;
            //    p.RegistStatus = Define.REGIST_STATUS.GetKey("저장");

            //    planYearInvestRepo.updateRegist(p);
            //}

            return RedirectAndPostActionResult.RedirectAndPost("Edit", postData);
        }

        [Route("Edit")]
        public ActionResult Edit(PlanYearInvest entity, Search search)
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");

            // 중기투자인원계획 - 기본데이터
            var planYearInvest = planYearInvestRepo.selectOne(entity);
            // 해당 회사의 부서 정보
            //var orgBusinessList = orgBusinessRepo.selectListCompany(new { Seq = entity.OrgCompanySeq });
            var orgBusinessList = orgBusinessRepo.selectListAll(new { orgCompanySeq = entity.OrgCompanySeq });
            // 부문 > 회사 이름
            var orgCompanyName = orgCompanyRepo.selectOne(new { Seq = entity.OrgCompanySeq });

            // 상세데이터 가져오기
            var lastYearBusinessPm = pmInvestBusinessRepo.selectListBefore(new { InvestYear = planYearInvest.YearInvestYear, OrgCompanySeq = entity.OrgCompanySeq });
            var lastYearBusinessPn = planYearInvestBusinessRepo.selectListYear(new { YearInvestYear = (Convert.ToInt32(planYearInvest.YearInvestYear) - 1).ToString(), OrgCompanySeq = entity.OrgCompanySeq });
            var thisYearBusinessPn = planYearInvestBusinessRepo.selectListYear(new { YearInvestYear = planYearInvest.YearInvestYear, OrgCompanySeq = entity.OrgCompanySeq });

            // 합계데이터 가져오기
            var lastYearSumPm = pmInvestSumRepo.selectListBefore(new { InvestYear = planYearInvest.YearInvestYear, OrgCompanySeq = entity.OrgCompanySeq });
            var lastYearSumPn = planYearInvestSummaryRepo.selectListYear(new { YearInvestYear = (Convert.ToInt32(planYearInvest.YearInvestYear) - 1).ToString(), OrgCompanySeq = entity.OrgCompanySeq });
            var thisYearSumPn = planYearInvestSummaryRepo.selectListYear(new { YearInvestYear = planYearInvest.YearInvestYear, OrgCompanySeq = entity.OrgCompanySeq });

            // 현재기준의 Bu만 조인하여 넣는다.
            var orgBusinessList2 = from x in orgBusinessList
                                   join y in thisYearBusinessPn on x.Seq equals y.OrgBusinessSeq
                                   group x by new { x.Seq, x.BusinessName } into g
                                   select new OrgBusiness
                                   {
                                       Seq = g.First().Seq,
                                       BusinessName = g.First().BusinessName
                                   };
            orgBusinessList = orgBusinessList2.ToList();

            dynamic model = new ExpandoObject();
            model.planYearInvest = planYearInvest;
            model.orgBusinessList = orgBusinessList;
            model.orgCompanyName = orgCompanyName;
            model.lastYearBusinessPm = lastYearBusinessPm;
            model.lastYearBusinessPn = lastYearBusinessPn;
            model.thisYearBusinessPn = thisYearBusinessPn;
            model.lastYearSumPm = lastYearSumPm;
            model.lastYearSumPn = lastYearSumPn;
            model.thisYearSumPn = thisYearSumPn;

            if (entity.message != null)
            {
                TempData["alert"] = entity.message;
            }

            ViewBag.Search = search;
            return View("~/Views/SiteMngHome/Plan/Year_Invest/Edit.cshtml", model);
        }

        [Route("Edit2")]
        public ActionResult Edit2(PlanYearInvest entity, Search search)
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");

            // 중기투자인원계획 - 기본데이터
            var planYearInvest = planYearInvestRepo.selectOne(entity);
            // 부문 > 회사 이름
            var orgCompanyName = orgCompanyRepo.selectOne(new { Seq = entity.OrgCompanySeq });
            
            // 합계데이터 가져오기
            var lastYearSumPm = pmInvestSumRepo.selectListBefore(new { InvestYear = planYearInvest.YearInvestYear, OrgCompanySeq = entity.OrgCompanySeq });
            var lastYearSumPn = planYearInvestSummaryRepo.selectListYear(new { YearInvestYear = (Convert.ToInt32(planYearInvest.YearInvestYear) - 1).ToString(), OrgCompanySeq = entity.OrgCompanySeq });
            var thisYearSumPn = planYearInvestSummaryRepo.selectListYear(new { YearInvestYear = planYearInvest.YearInvestYear, OrgCompanySeq = entity.OrgCompanySeq });
            
            dynamic model = new ExpandoObject();
            model.planYearInvest = planYearInvest;
            model.orgCompanyName = orgCompanyName;
            model.lastYearSumPm = lastYearSumPm;
            model.lastYearSumPn = lastYearSumPn;
            model.thisYearSumPn = thisYearSumPn;

            if (entity.message != null)
            {
                TempData["alert"] = entity.message;
            }

            ViewBag.Search = search;
            return View("~/Views/SiteMngHome/Plan/Year_Invest/Edit2.cshtml", model);
        }

        [Route("Edit_Action")]
        public ActionResult EditAction(PlanYearInvestAdmin entity, Search search)
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");

            #region
            Dictionary<string, object> postData = new Dictionary<string, object>();
            postData.Add("Seq", entity.Seq);
            postData.Add("OrgCompanySeq", entity.OrgCompanySeq);
            postData.Add("message", Message.MSG_007_A);
            postData.Add("PageIndex", search.PageIndex);
            #endregion

            // 부서별 데이터 검증(정수 혹은 소수점 2자리까지의 데이터)
            bool bDoubleValue = true;
            List<PlanYearInvestBusiness> pBusinessList = new List<PlanYearInvestBusiness>();
            List<PlanYearInvestSummary> pSummaryList = new List<PlanYearInvestSummary>();
            try
            {
                for (int i = 0; i < entity.PlanYearInvestBusinessSeq.Count(); i++)
                {
                    if (!WebUtil.CheckDecimalTwo(entity.Investment[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.Personnel[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.DomesticPersonnel[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.OverseasPersonnel[i].ToString())) { bDoubleValue = false; break; }

                    PlanYearInvestBusiness p = new PlanYearInvestBusiness();
                    p.Seq = entity.PlanYearInvestBusinessSeq[i];
                    p.Investment = entity.Investment[i];
                    p.Personnel = entity.Personnel[i];
                    p.DomesticPersonnel = entity.DomesticPersonnel[i];
                    p.OverseasPersonnel = entity.OverseasPersonnel[i];

                    pBusinessList.Add(p);
                }

                for (int i = 0; i < entity.PlanYearInvestSummarySeq.Count(); i++)
                {
                    if (!WebUtil.CheckDecimalTwo(entity.SummaryInvestment[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.SummaryPersonnel[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.SummaryDomesticPersonnel[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.SummaryOverseasPersonnel[i].ToString())) { bDoubleValue = false; break; }

                    PlanYearInvestSummary p = new PlanYearInvestSummary();
                    p.Seq = entity.PlanYearInvestSummarySeq[i];
                    p.Investment = entity.SummaryInvestment[i];
                    p.Personnel = entity.SummaryPersonnel[i];
                    p.DomesticPersonnel = entity.SummaryDomesticPersonnel[i];
                    p.OverseasPersonnel = entity.SummaryOverseasPersonnel[i];

                    pSummaryList.Add(p);
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

            foreach (var item in pBusinessList)
            {
                planYearInvestBusinessRepo.update(item);
            }

            foreach (var item in pSummaryList)
            {
                planYearInvestSummaryRepo.update(item);
            }

            // 미저장에서 저장으로 변경
            if (entity.RegistStatus == Define.REGIST_STATUS.GetKey("미등록"))
            {
                PlanYearInvest p = new PlanYearInvest();
                p.Seq = entity.Seq;
                p.RegistStatus = Define.REGIST_STATUS.GetKey("저장");

                planYearInvestRepo.updateRegist(p);
            }

            return RedirectAndPostActionResult.RedirectAndPost("Edit", postData);
        }


        [Route("Regist_Status_Change")]
        public ActionResult RegistStatusChange(PlanYearInvest entity, Search search)
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
            planYearInvestRepo.updateRegist(entity);

            return RedirectToAction("List", search);
        }

        [Route("View")]
        public ActionResult view(PlanYearInvest entity, Search search)
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");

            // 중기투자인원계획 - 기본데이터
            var planYearInvest = planYearInvestRepo.selectOne(entity);
            // 해당 회사의 부서 정보
            //var orgBusinessList = orgBusinessRepo.selectListCompany(new { Seq = entity.OrgCompanySeq });
            var orgBusinessList = orgBusinessRepo.selectListAll(new { orgCompanySeq = entity.OrgCompanySeq });
            // 부문 > 회사 이름
            var orgCompanyName = orgCompanyRepo.selectOne(new { Seq = entity.OrgCompanySeq });

            // 상세데이터 가져오기
            var lastYearBusinessPm = pmInvestBusinessRepo.selectListBefore(new { InvestYear = planYearInvest.YearInvestYear, OrgCompanySeq = entity.OrgCompanySeq });
            var lastYearBusinessPn = planYearInvestBusinessRepo.selectListYear(new { YearInvestYear = (Convert.ToInt32(planYearInvest.YearInvestYear) - 1).ToString(), OrgCompanySeq = entity.OrgCompanySeq });
            var thisYearBusinessPn = planYearInvestBusinessRepo.selectListYear(new { YearInvestYear = planYearInvest.YearInvestYear, OrgCompanySeq = entity.OrgCompanySeq });

            // 합계데이터 가져오기
            var lastYearSumPm = pmInvestSumRepo.selectListBefore(new { InvestYear = planYearInvest.YearInvestYear, OrgCompanySeq = entity.OrgCompanySeq });
            var lastYearSumPn = planYearInvestSummaryRepo.selectListYear(new { YearInvestYear = (Convert.ToInt32(planYearInvest.YearInvestYear) - 1).ToString(), OrgCompanySeq = entity.OrgCompanySeq });
            var thisYearSumPn = planYearInvestSummaryRepo.selectListYear(new { YearInvestYear = planYearInvest.YearInvestYear, OrgCompanySeq = entity.OrgCompanySeq });

            // 현재기준의 Bu만 조인하여 넣는다.
            var orgBusinessList2 = from x in orgBusinessList
                                   join y in thisYearBusinessPn on x.Seq equals y.OrgBusinessSeq
                                   group x by new { x.Seq, x.BusinessName } into g
                                   select new OrgBusiness
                                   {
                                       Seq = g.First().Seq,
                                       BusinessName = g.First().BusinessName
                                   };
            orgBusinessList = orgBusinessList2.ToList();

            dynamic model = new ExpandoObject();
            model.planYearInvest = planYearInvest;
            model.orgBusinessList = orgBusinessList;
            model.orgCompanyName = orgCompanyName;
            model.lastYearBusinessPm = lastYearBusinessPm;
            model.lastYearBusinessPn = lastYearBusinessPn;
            model.thisYearBusinessPn = thisYearBusinessPn;
            model.lastYearSumPm = lastYearSumPm;
            model.lastYearSumPn = lastYearSumPn;
            model.thisYearSumPn = thisYearSumPn;

            if (entity.message != null)
            {
                TempData["alert"] = entity.message;
            }
            ViewBag.Search = search;
            return View("~/Views/SiteMngHome/Plan/Year_Invest/View.cshtml", model);
        }


        [Route("Excel_Upload2")]
        public ActionResult ExcelUpload2(int Seq, int OrgCompanySeq, List<int> PlanYearInvestBusinessSeq,HttpPostedFileBase ExcelFile)
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
                string filePath = "PlanYearInvest";
                var file = fileUtil.FileUpload(ExcelFile, filePath);

                bool bDoubleValue = true;
                ExcelUtil excelUtil = new ExcelUtil();
                var dt = excelUtil.ImportExcel(file["FILE_PATH"]);
                List<PlanYearInvestBusiness> pBusinessList = new List<PlanYearInvestBusiness>();
                try
                {
                    int j = 0;
                    foreach (DataRow item in dt.Rows)
                    {
                        //string parentSeq = item.ItemArray.GetValue(0).ToString();
                        string excelSeq = PlanYearInvestBusinessSeq[j].ToString();

                        string Investment = item.ItemArray.GetValue(4).ToString();
                        string Personnel = item.ItemArray.GetValue(5).ToString();
                        string DomesticPersonnel = item.ItemArray.GetValue(6).ToString();
                        string OverseasPersonnel = item.ItemArray.GetValue(7).ToString();
                        //string companyName = item.ItemArray.GetValue(2).ToString();
                        //string businessSeq = item.ItemArray.GetValue(3).ToString();
                        //string businessName = item.ItemArray.GetValue(4).ToString();
                        // string YealyYear = item.ItemArray.GetValue(5).ToString();
                        //string Investment = item.ItemArray.GetValue(6).ToString();
                        //string Personnel = item.ItemArray.GetValue(7).ToString();
                        //string DomesticPersonnel = item.ItemArray.GetValue(8).ToString();
                        //string OverseasPersonnel = item.ItemArray.GetValue(9).ToString();
                        //if (parentSeq != Seq.ToString()) { bDoubleValue = false; break; }       // 현재 코드와 업로드하려는 코드가 다른 경우는 양식이 잘못된것으로 오류
                        //if (!WebUtil.CheckDecimalTwo(Investment)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(Personnel)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(DomesticPersonnel)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(OverseasPersonnel)) { bDoubleValue = false; break; }

                        PlanYearInvestBusiness pBusiness = new PlanYearInvestBusiness();
                        pBusiness.Seq = Convert.ToInt32(excelSeq);
                        pBusiness.Investment = Convert.ToDecimal(Investment);
                        pBusiness.Personnel = Convert.ToDecimal(Personnel);
                        pBusiness.DomesticPersonnel = Convert.ToDecimal(DomesticPersonnel);
                        pBusiness.OverseasPersonnel = Convert.ToDecimal(OverseasPersonnel);

                        pBusinessList.Add(pBusiness);
                        j += 1;
                    }
                }
                catch (Exception e)
                {
                    // 오류시 파일 삭제
                    fileUtil.FileDelete(filePath, file["STORED_FILE_NAME"]);
                    //LogUtil.MngError(e.ToString());
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
                foreach (var item in pBusinessList)
                {
                    planYearInvestBusinessRepo.update(item);
                }

                // 업데이트 완료 후 로그 남기기
                ExcelFileUploadList eFileList = new ExcelFileUploadList();
                eFileList.UserKey = SessionManager.GetAdminSession().insaUserV.userKey;
                eFileList.EmpNo = SessionManager.GetAdminSession().insaUserV.empNo;
                eFileList.AttachTableName = "PLAN_MONTHLY_INVEST";
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