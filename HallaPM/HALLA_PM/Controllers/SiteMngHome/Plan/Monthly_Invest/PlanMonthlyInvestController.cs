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
    [RoutePrefix("SiteMngHome/Plan/Monthly_Invest")]
    public class PlanMonthlyInvestController : SiteMngBaseController
    {
        [Route("List")]
        public ActionResult List(Search search)
        {
            dynamic model = new ExpandoObject();
            search.AuthUserKey = SessionManager.GetAdminSession().insaUserV.userKey;
            model.list = planMonthlyInvestRepo.selectList(search);
            model.UnionList = orgUnionRepo.selectList(new { });
            model.OrgCpyList = orgCompanyRepo.selectList(null);
            ViewBag.Search = search;

            return View("~/Views/SiteMngHome/Plan/Monthly_Invest/List.cshtml", model);
        }

        [Route("Write")]
        public ActionResult Write(PlanMonthlyInvest entity, Search search)
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");

            // 기본데이터
            var planMonthlyInvest = planMonthlyInvestRepo.selectOne(entity);
            // 해당 회사의 부서 정보
            var orgBusinessList = orgBusinessRepo.selectListCompany(new { Seq = entity.OrgCompanySeq });
            // 부문 > 회사 이름
            var orgCompanyName = orgCompanyRepo.selectOne(new { Seq = entity.OrgCompanySeq });

            foreach (var business in orgBusinessList)
            {
                PlanMonthlyInvestBusiness p = new PlanMonthlyInvestBusiness();
                for (int i = 1; i <= 12; i++)
                {
                    p.PlanMonthlyInvestSeq = entity.Seq;
                    p.OrgBusinessSeq = business.Seq;
                    p.Monthly = i.ToString().PadLeft(2, '0');
                    p.Investment = 0;
                    p.Personnel = 0;
                    p.DomesticPersonnel = 0;
                    p.OverseasPersonnel = 0;
                    string where = " WHERE PLAN_MONTHLY_INVEST_SEQ = @PlanMonthlyInvestSeq AND ORG_BUSINESS_SEQ = @OrgBusinessSeq AND MONTHLY = @Monthly";
                    if (planMonthlyInvestBusinessRepo.count(p, where) == 0) planMonthlyInvestBusinessRepo.insert(p);
                }
            }

            // 상세데이터 가져오기
            var pBusinessList = planMonthlyInvestBusinessRepo.selectListBofore(new { PlanMonthlyInvestSeq = entity.Seq });
            dynamic model = new ExpandoObject();
            model.planMonthlyInvest = planMonthlyInvest;
            model.orgCompanyName = orgCompanyName;
            model.orgBusinessList = orgBusinessList;
            model.pBusinessList = pBusinessList;

            if (entity.message != null)
            {
                TempData["alert"] = entity.message;
            }
            ViewBag.Search = search;
            return View("~/Views/SiteMngHome/Plan/Monthly_Invest/Write.cshtml", model);
        }

        [Route("Excel_Down")]
        public ActionResult ExcelDown(PlanMonthlyInvest entity)
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");

            var planMonthlyInvest = planMonthlyInvestRepo.selectOne(entity);
            var orgCompanyName = orgCompanyRepo.selectOne(new { Seq = entity.OrgCompanySeq });
            var pBusinessList = planMonthlyInvestBusinessRepo.selectListExcel(new { PlanMonthlyInvestSeq = entity.Seq });



            string fileName = "월별투자인원계획_" + planMonthlyInvest.MonthlyInvestYear + "년_" + orgCompanyName.CompanyName;

            int rows = 1, cells = 1;

            using (XLWorkbook wb = new XLWorkbook())
            {
                var ws = wb.Worksheets.Add("월별투자인원계획");

                // 컬럼 숨기기
                ws.Column(1).Hide();
                ws.Column(2).Hide();
                ws.Column(4).Hide();

                ws.Cell(rows, cells).SetValue("ParentSeq").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                ws.Cell(rows, ++cells).SetValue("Seq").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                ws.Cell(rows, ++cells).SetValue("CompanyName").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                ws.Cell(rows, ++cells).SetValue("BusinessSeq").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                ws.Cell(rows, ++cells).SetValue("BusinessName").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                ws.Cell(rows, ++cells).SetValue("월").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                ws.Cell(rows, ++cells).SetValue("투자").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                ws.Cell(rows, ++cells).SetValue("인원").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                ws.Cell(rows, ++cells).SetValue("국내인원").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                ws.Cell(rows, ++cells).SetValue("해외인원").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                foreach (var item in pBusinessList)
                {
                    rows++;
                    cells = 1;
                    ws.Cell(rows, cells).SetValue(item.PlanMonthlyInvestSeq).Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin).Fill.SetBackgroundColor(XLColor.NoColor);
                    ws.Cell(rows, ++cells).SetValue(item.Seq).Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin).Fill.SetBackgroundColor(XLColor.NoColor);
                    ws.Cell(rows, ++cells).SetValue(item.CompanyName).Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin).Fill.SetBackgroundColor(XLColor.NoColor);
                    ws.Cell(rows, ++cells).SetValue(item.OrgBusinessSeq).Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin).Fill.SetBackgroundColor(XLColor.NoColor);
                    ws.Cell(rows, ++cells).SetValue(item.BusinessName).Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin).Fill.SetBackgroundColor(XLColor.NoColor);
                    ws.Cell(rows, ++cells).SetValue(item.Monthly).Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin).Fill.SetBackgroundColor(XLColor.NoColor);
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
        public ActionResult ExcelDown2(PlanMonthlyInvest entity)
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");

            var planMonthlyInvest = planMonthlyInvestRepo.selectOne(entity);
            var orgCompanyName = orgCompanyRepo.selectOne(new { Seq = entity.OrgCompanySeq });
            var pBusinessList = planMonthlyInvestBusinessRepo.selectListExcel(new { PlanMonthlyInvestSeq = entity.Seq });



            string fileName = "월별투자인원계획_" + planMonthlyInvest.MonthlyInvestYear + "년_" + orgCompanyName.CompanyName;

            int rows = 1, cells = 1;

            using (XLWorkbook wb = new XLWorkbook())
            {
                var ws = wb.Worksheets.Add("월별투자인원계획");

                // 컬럼 숨기기
                //ws.Column(1).Hide();
                ws.Column(2).Hide();
                //ws.Column(4).Hide();

                //ws.Cell(rows, cells).SetValue("ParentSeq").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                //ws.Cell(rows, ++cells).SetValue("Seq").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                ws.Cell(rows, cells).SetValue("CompanyName").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                ws.Cell(rows, ++cells).SetValue("BusinessSeq").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                ws.Cell(rows, ++cells).SetValue("BusinessName").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                ws.Cell(rows, ++cells).SetValue("월").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                ws.Cell(rows, ++cells).SetValue("투자").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                ws.Cell(rows, ++cells).SetValue("인원").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                ws.Cell(rows, ++cells).SetValue("국내인원").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                ws.Cell(rows, ++cells).SetValue("해외인원").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                foreach (var item in pBusinessList)
                {
                    rows++;
                    cells = 1;
                    //ws.Cell(rows, cells).SetValue(item.PlanMonthlyInvestSeq).Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin).Fill.SetBackgroundColor(XLColor.NoColor);
                    //ws.Cell(rows, ++cells).SetValue(item.Seq).Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin).Fill.SetBackgroundColor(XLColor.NoColor);
                    ws.Cell(rows, cells).SetValue(item.CompanyName).Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin).Fill.SetBackgroundColor(XLColor.NoColor);
                    ws.Cell(rows, ++cells).SetValue(item.OrgBusinessSeq).Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin).Fill.SetBackgroundColor(XLColor.NoColor);
                    ws.Cell(rows, ++cells).SetValue(item.BusinessName).Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin).Fill.SetBackgroundColor(XLColor.NoColor);
                    ws.Cell(rows, ++cells).SetValue(item.Monthly).Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin).Fill.SetBackgroundColor(XLColor.NoColor);
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
                string filePath = "PlanMonthlyInvest";
                var file = fileUtil.FileUpload(ExcelFile, filePath);

                bool bDoubleValue = true;
                ExcelUtil excelUtil = new ExcelUtil();
                var dt = excelUtil.ImportExcel(file["FILE_PATH"]);
                List<PlanMonthlyInvestBusiness> pBusinessList = new List<PlanMonthlyInvestBusiness>();
                try
                {
                    foreach (DataRow item in dt.Rows)
                    {
                        string parentSeq = item.ItemArray.GetValue(0).ToString();
                        string excelSeq = item.ItemArray.GetValue(1).ToString();
                        string companyName = item.ItemArray.GetValue(2).ToString();
                        string businessSeq = item.ItemArray.GetValue(3).ToString();
                        string businessName = item.ItemArray.GetValue(4).ToString();
                        string month = item.ItemArray.GetValue(5).ToString();
                        string Investment = item.ItemArray.GetValue(6).ToString();
                        string Personnel = item.ItemArray.GetValue(7).ToString();
                        string DomesticPersonnel = item.ItemArray.GetValue(8).ToString();
                        string OverseasPersonnel = item.ItemArray.GetValue(9).ToString();
                        if (parentSeq != Seq.ToString()) { bDoubleValue = false; break; }       // 현재 코드와 업로드하려는 코드가 다른 경우는 양식이 잘못된것으로 오류
                        //if (!WebUtil.CheckDecimalTwo(Investment)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(Personnel)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(DomesticPersonnel)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(OverseasPersonnel)) { bDoubleValue = false; break; }

                        PlanMonthlyInvestBusiness pBusiness = new PlanMonthlyInvestBusiness();
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
                    planMonthlyInvestBusinessRepo.update(item);
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
        public ActionResult CalculationAction(PlanMonthlyInvestAdmin entity, Search search)
        {
            #region
            Dictionary<string, object> postData = new Dictionary<string, object>();
            postData.Add("Seq", entity.Seq);
            postData.Add("OrgCompanySeq", entity.OrgCompanySeq);
            postData.Add("PageIndex", search.PageIndex);
            #endregion

            // 부서별 데이터 검증(정수 혹은 소수점 2자리까지의 데이터)
            bool bDoubleValue = true;
            List<PlanMonthlyInvestBusiness> pBusinessList = new List<PlanMonthlyInvestBusiness>();
            try
            {
                for (int i = 0; i < entity.PlanMonthlyInvestBusinessSeq.Count(); i++)
                {
                    if (!WebUtil.CheckDecimalTwo(entity.Investment[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.Personnel[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.DomesticPersonnel[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.OverseasPersonnel[i].ToString())) { bDoubleValue = false; break; }

                    PlanMonthlyInvestBusiness p = new PlanMonthlyInvestBusiness();
                    p.Seq = entity.PlanMonthlyInvestBusinessSeq[i];
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

            foreach (var item in pBusinessList)
            {
                planMonthlyInvestBusinessRepo.update(item);
            }

            // 계산하기 하였을 경우 기존 데이터 삭제하여 부서별 데이터의 합계를 다시 입력
            PlanMonthlyInvestSummary pSum = new PlanMonthlyInvestSummary();
            pSum.PlanMonthlyInvestSeq = entity.Seq;
            planMonthlyInvestSummaryRepo.delete(pSum);
            planMonthlyInvestSummaryRepo.insertSum(pSum);

            // 2018.10.29 수정화면에서 저장한 뒤에 저장상태로 변경
            ////미저장에서 저장으로 변경
            //if (entity.RegistStatus == Define.REGIST_STATUS.GetKey("미등록"))
            //{
            //    PlanMonthlyInvest p = new PlanMonthlyInvest();
            //    p.Seq = entity.Seq;
            //    p.RegistStatus = Define.REGIST_STATUS.GetKey("저장");

            //    planMonthlyInvestRepo.updateRegist(p);
            //}

            return RedirectAndPostActionResult.RedirectAndPost("Edit", postData);
        }

        [Route("Edit")]
        public ActionResult Edit(PlanMonthlyInvest entity, Search search)
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");

            // 기본데이터
            var planMonthlyInvest = planMonthlyInvestRepo.selectOne(entity);
            // 해당 회사의 부서 정보
            //var orgBusinessList = orgBusinessRepo.selectListCompany(new { Seq = entity.OrgCompanySeq });
            var orgBusinessList = orgBusinessRepo.selectListAll(new { orgCompanySeq = entity.OrgCompanySeq });

            // 부문 > 회사 이름
            var orgCompanyName = orgCompanyRepo.selectOne(new { Seq = entity.OrgCompanySeq });
            // 상세데이터 가져오기
            var pBusinessList = planMonthlyInvestBusinessRepo.selectListBofore(new { PlanMonthlyInvestSeq = entity.Seq });
            // 합계 가져오기
            var pSummaryList = planMonthlyInvestSummaryRepo.selectListBefore(new { PlanMonthlyInvestSeq = entity.Seq });

            // 현재기준의 Bu만 조인하여 넣는다.
            var orgBusinessList2 = from x in orgBusinessList
                                   join y in pBusinessList on x.Seq equals y.OrgBusinessSeq
                                   group x by new { x.Seq, x.BusinessName } into g
                                   select new OrgBusiness
                                   {
                                       Seq = g.First().Seq,
                                       BusinessName = g.First().BusinessName
                                   };
            orgBusinessList = orgBusinessList2.ToList();

            dynamic model = new ExpandoObject();
            model.planMonthlyInvest = planMonthlyInvest;
            model.orgBusinessList = orgBusinessList;
            model.orgCompanyName = orgCompanyName;
            model.pBusinessList = pBusinessList;
            model.pSummaryList = pSummaryList;

            if (entity.message != null)
            {
                TempData["alert"] = entity.message;
            }
            ViewBag.Search = search;
            return View("~/Views/SiteMngHome/Plan/Monthly_Invest/Edit.cshtml", model);
        }

        [Route("Edit2")]
        public ActionResult Edit2(PlanMonthlyInvest entity, Search search)
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");

            // 기본데이터
            var planMonthlyInvest = planMonthlyInvestRepo.selectOne(entity);

            // 부문 > 회사 이름
            var orgCompanyName = orgCompanyRepo.selectOne(new { Seq = entity.OrgCompanySeq });
            // 합계 가져오기
            var pSummaryList = planMonthlyInvestSummaryRepo.selectListBefore(new { PlanMonthlyInvestSeq = entity.Seq });
            

            dynamic model = new ExpandoObject();
            model.planMonthlyInvest = planMonthlyInvest;
            model.orgCompanyName = orgCompanyName;
            model.pSummaryList = pSummaryList;

            if (entity.message != null)
            {
                TempData["alert"] = entity.message;
            }
            ViewBag.Search = search;
            return View("~/Views/SiteMngHome/Plan/Monthly_Invest/Edit2.cshtml", model);
        }

        [Route("Edit_Action")]
        public ActionResult EditAction(PlanMonthlyInvestAdmin entity, Search search)
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
            // 월별 및 분기별 데이터도 같이 검증
            bool bDoubleValue = true;
            List<PlanMonthlyInvestBusiness> pBusinessList = new List<PlanMonthlyInvestBusiness>();
            List<PlanMonthlyInvestSummary> pSummaryList = new List<PlanMonthlyInvestSummary>();


            try
            {
                for (int i = 0; i < entity.PlanMonthlyInvestBusinessSeq.Count(); i++)
                {
                    if (!WebUtil.CheckDecimalTwo(entity.Investment[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.Personnel[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.DomesticPersonnel[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.OverseasPersonnel[i].ToString())) { bDoubleValue = false; break; }

                    PlanMonthlyInvestBusiness p = new PlanMonthlyInvestBusiness();
                    p.Seq = entity.PlanMonthlyInvestBusinessSeq[i];
                    p.Investment = entity.Investment[i];
                    p.Personnel = entity.Personnel[i];
                    p.DomesticPersonnel = entity.DomesticPersonnel[i];
                    p.OverseasPersonnel = entity.OverseasPersonnel[i];

                    pBusinessList.Add(p);
                }

                for (int i = 0; i < entity.PlanMonthlyInvestSummarySeq.Count(); i++)
                {
                    if (!WebUtil.CheckDecimalTwo(entity.SummaryInvestment[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.SummaryPersonnel[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.SummaryDomesticPersonnel[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.SummaryOverseasPersonnel[i].ToString())) { bDoubleValue = false; break; }

                    PlanMonthlyInvestSummary p = new PlanMonthlyInvestSummary();
                    p.Seq = entity.PlanMonthlyInvestSummarySeq[i];
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
                planMonthlyInvestBusinessRepo.update(item);
            }

            foreach (var item in pSummaryList)
            {
                planMonthlyInvestSummaryRepo.update(item);
            }

            // 미저장에서 저장으로 변경
            if (entity.RegistStatus == Define.REGIST_STATUS.GetKey("미등록"))
            {
                PlanMonthlyInvest p = new PlanMonthlyInvest();
                p.Seq = entity.Seq;
                p.RegistStatus = Define.REGIST_STATUS.GetKey("저장");

                planMonthlyInvestRepo.updateRegist(p);
            }

            return RedirectAndPostActionResult.RedirectAndPost("Edit", postData);
        }

        [Route("Regist_Status_Change")]
        public ActionResult RegistStatusChange(PlanMonthlyInvest entity, Search search)
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
            planMonthlyInvestRepo.updateRegist(entity);

            return RedirectToAction("List", search);
        }

        [Route("View")]
        public ActionResult view(PlanMonthlyInvest entity, Search search)
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");

            // 기본데이터
            var planMonthlyInvest = planMonthlyInvestRepo.selectOne(entity);
            // 해당 회사의 부서 정보
            //var orgBusinessList = orgBusinessRepo.selectListCompany(new { Seq = entity.OrgCompanySeq });
            var orgBusinessList = orgBusinessRepo.selectListAll(new { orgCompanySeq = entity.OrgCompanySeq });
            // 부문 > 회사 이름
            var orgCompanyName = orgCompanyRepo.selectOne(new { Seq = entity.OrgCompanySeq });
            // 상세데이터 가져오기
            var pBusinessList = planMonthlyInvestBusinessRepo.selectListBofore(new { PlanMonthlyInvestSeq = entity.Seq });
            // 합계 가져오기
            var pSummaryList = planMonthlyInvestSummaryRepo.selectListBefore(new { PlanMonthlyInvestSeq = entity.Seq });

            // 현재기준의 Bu만 조인하여 넣는다.
            var orgBusinessList2 = from x in orgBusinessList
                                   join y in pBusinessList on x.Seq equals y.OrgBusinessSeq
                                   group x by new { x.Seq, x.BusinessName } into g
                                   select new OrgBusiness
                                   {
                                       Seq = g.First().Seq,
                                       BusinessName = g.First().BusinessName
                                   };
            orgBusinessList = orgBusinessList2.ToList();

            dynamic model = new ExpandoObject();
            model.planMonthlyInvest = planMonthlyInvest;
            model.orgBusinessList = orgBusinessList;
            model.orgCompanyName = orgCompanyName;
            model.pBusinessList = pBusinessList;
            model.pSummaryList = pSummaryList;

            if (entity.message != null)
            {
                TempData["alert"] = entity.message;
            }
            ViewBag.Search = search;
            return View("~/Views/SiteMngHome/Plan/Monthly_Invest/View.cshtml", model);
        }
         
       [Route("Excel_Upload2")]
        public ActionResult ExcelUpload2(int Seq, int OrgCompanySeq,List<int> PlanMonthlyInvestBusinessSeq, HttpPostedFileBase ExcelFile)
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
                string filePath = "PlanMonthlyInvest";
                var file = fileUtil.FileUpload(ExcelFile, filePath);

                bool bDoubleValue = true;
                ExcelUtil excelUtil = new ExcelUtil();
                var dt = excelUtil.ImportExcel(file["FILE_PATH"]);
                List<PlanMonthlyInvestBusiness> pBusinessList = new List<PlanMonthlyInvestBusiness>();
                try
                {
                    int j = 0;
                    foreach (DataRow item in dt.Rows)
                    {
                        //string parentSeq = item.ItemArray.GetValue(0).ToString();
                        string excelSeq = PlanMonthlyInvestBusinessSeq[j].ToString();

                        string Investment = item.ItemArray.GetValue(4).ToString();
                        string Personnel = item.ItemArray.GetValue(5).ToString();
                        string DomesticPersonnel = item.ItemArray.GetValue(6).ToString();
                        string OverseasPersonnel = item.ItemArray.GetValue(7).ToString();
                        //string companyName = item.ItemArray.GetValue(2).ToString();
                        //string businessSeq = item.ItemArray.GetValue(3).ToString();
                        //string businessName = item.ItemArray.GetValue(4).ToString();
                        //string month = item.ItemArray.GetValue(5).ToString();
                        //string Investment = item.ItemArray.GetValue(6).ToString();
                        //string Personnel = item.ItemArray.GetValue(7).ToString();
                        //string DomesticPersonnel = item.ItemArray.GetValue(8).ToString();
                        //string OverseasPersonnel = item.ItemArray.GetValue(9).ToString();
                        //if (parentSeq != Seq.ToString()) { bDoubleValue = false; break; }       // 현재 코드와 업로드하려는 코드가 다른 경우는 양식이 잘못된것으로 오류
                        //if (!WebUtil.CheckDecimalTwo(Investment)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(Personnel)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(DomesticPersonnel)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(OverseasPersonnel)) { bDoubleValue = false; break; }

                        PlanMonthlyInvestBusiness pBusiness = new PlanMonthlyInvestBusiness();
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
                    planMonthlyInvestBusinessRepo.update(item);
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