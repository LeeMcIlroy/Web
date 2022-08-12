using ClosedXML.Excel;
using HALLA_PM.Core;
using HALLA_PM.Models;
using HALLA_PM.Util;
using System;
using System.Collections.Generic;
using System.Data;
using System.Dynamic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace HALLA_PM.Controllers.SiteMngHome
{

    [AdminLoginFilter]
    [AuthAdminFilter(RequestAuthLevel = 3)]
    [RoutePrefix("SiteMngHome/Performance/Bs")]
    public class PmBsController : SiteMngBaseController
    {
        [Route("List")]
        public ActionResult List(Search search)
        {
            dynamic model = new ExpandoObject();
            search.AuthUserKey = SessionManager.GetAdminSession().insaUserV.userKey;
            model.list = pmBsRepo.selectListExp(search);
            ViewBag.Search = search;
            return View("~/Views/SiteMngHome/Performance/Bs/List.cshtml", model);
            TempData.Remove("alert");
        }

        [Route("Write")]
        public ActionResult Write(PmBs entity)
        {
            dynamic model = new ExpandoObject();
            
            // 기본데이터 (pmBs.Monthly / pmBs.BsYear)
            var pmBs = pmBsRepo.selectOne(entity);

            // 부문 > 회사 이름
            var orgCompany = orgCompanyRepo.selectOne(new { Seq = pmBs.OrgCompanySeq });

            // Write로 접근하였지만 기 등록된 데이터가 있는 경우 Edit로 이동시키자.
            if(pmBsBsheetRepo.selectOneByPmBsSeq(new { PmBsSeq = pmBs.Seq }) != null
                && pmBsRoicRepo.selectOneByPmBsSeq(new { PmBsSeq = pmBs.Seq}) != null
                && pmBsWCapitalRepo.selectOneByPmBsSeq(new { PmBsSeq = pmBs.Seq}) != null)
            {
                return Redirect("/SiteMngHome/Performance/Bs/Edit?seq="+entity.Seq);
            }
            
            //////////////////////////////////////////////////////////////////////////////////
            // B/Sheet
            // 1. 전년도 기말 실적 : PM_BS_BSHEET
            //    전년도 pmBs 조회 해서 처리해야 함. >>>> bs_year, monthly, org_company_seq
            var prevPmBs = pmBsRepo.selectOneForPrev(new { bsYear = Convert.ToInt32(pmBs.BsYear) - 1, monthly = pmBs.Monthly, OrgCompanySeq = pmBs.OrgCompanySeq });
            if(prevPmBs == null) {
                model.pmBsBsheet = new PmBsBsheet();
            }
            else {
                var pmBsBsheet = pmBsBsheetRepo.selectOneByPmBsSeq(new { PmBsSeq = prevPmBs.Seq });
                if(pmBsBsheet == null) { pmBsBsheet = new PmBsBsheet(); }
                model.pmBsBsheet = pmBsBsheet;
            }

            // 2. 당해 월 계획 : PLAN_YEAR_BS_BSHEET
            var planYearBsSheet = planYearBsBsheetRepo.nowYearBsSheetOneExp(new { yearBsYear = pmBs.BsYear, monthly = pmBs.Monthly, OrgCompanySeq = orgCompany.Seq });
            if(planYearBsSheet == null) { planYearBsSheet = new PlanYearBsBsheet(); }

            //////////////////////////////////////////////////////////////////////////////////
            // ROIC
            // 1. 전년도 실적 : PM_BS_ROIC
            //    전년도 pmBs 정보 이용해야 함.
            if(prevPmBs == null)
            {
                model.pmBsRoic = new PmBsRoic();
            }else
            {
                var pmBsRoic = pmBsRoicRepo.selectOneByPmBsSeq(new { PmBsSeq = prevPmBs.Seq });
                if(pmBsRoic == null) { pmBsRoic = new PmBsRoic(); }
                model.pmBsRoic = pmBsRoic;
            }

            // 2. 당해 월 계획 : PLAN_YEAR_BS_ROIC
            var planYearBsRoic = planYearBsRoicRepo.nowYearBsRoicOneExp(new { yearBsYear = pmBs.BsYear, monthly = pmBs.Monthly, OrgCompanySeq = orgCompany.Seq });
            if(planYearBsRoic == null) { planYearBsRoic = new Models.PlanYearBsRoic(); }

            //////////////////////////////////////////////////////////////////////////////////
            // W/Capital

            // 뷰 전달 모델
            model.pmBs = pmBs;
            model.orgCompany = orgCompany;
            model.planYearBsSheet = planYearBsSheet;
            model.planYearBsRoic = planYearBsRoic;
            model.excel = "N";

            // Temp Data
            model.uploadedPmBsBsheet = new PmBsBsheet();
            model.uploadedPmBsRoic = new PmBsRoic();
            model.uploadedPmBsWCapital = new PmBsWCapital();

            TempData.Remove("alert");
            return View("~/Views/SiteMngHome/Performance/Bs/Write.cshtml", model);
        }

        [HttpPost]
        [AcceptVerbs(HttpVerbs.Post), ValidateInput(false)]
        [Route("WriteAction")]
        public ActionResult writeAction(int seq, PmBsBsheet pmBsBsheet, PmBsRoic pmBsRoic, PmBsWCapital pmBsWcapital)
        {
            TempData["alert"] = "정상적으로 처리되었습니다.";

            if(pmBsBsheetRepo.save(pmBsBsheet) == -1)
            {
                TempData["alert"] = "등록에 실패하였습니다.\\n(B/Sheet 데이터 저장 오류)";
            }
            if(pmBsRoicRepo.save(pmBsRoic) == -1)
            {
                TempData["alert"] = "등록에 실패하였습니다.\\n(ROIC 데이터 저장 오류)";
            }
            if(pmBsWCapitalRepo.save(pmBsWcapital) == -1)
            {
                TempData["alert"] = "등록에 실패하였습니다.\\n(W/Capital 데이터 저장 오류)";
            }

            return Redirect("/SiteMngHome/Performance/Bs/Edit?seq=" + seq);
        }

        [Route("ExcelDownAction")]
        public ActionResult excelDownAction(PmBs entity)
        {
            // 기본데이터 (pmBs.Monthly / pmBs.BsYear)
            var pmBs = pmBsRepo.selectOne(entity);
            var orgCompany = orgCompanyRepo.selectOne(new { Seq = pmBs.OrgCompanySeq });
            string fileName = "PM_BS_" + pmBs.BsYear + "년_" + orgCompany.CompanyName;

            int rows = 1, cells = 1;
            using (XLWorkbook wb = new XLWorkbook())
            {


                var nowYear = pmBs.BsYear;
                var nowMonth = pmBs.Monthly;

                // 기 등록된 데이터 가져오기
                var currentPmBsBsheet = pmBsBsheetRepo.selectOneByPmBsSeq(new { PmBsSeq = pmBs.Seq });
                var currentPmBsRoic = pmBsRoicRepo.selectOneByPmBsSeq(new { PmBsSeq = pmBs.Seq });
                var currentPmBsWCapital = pmBsWCapitalRepo.selectOneByPmBsSeq(new { PmBsSeq = pmBs.Seq });

                // BHSEET 영역
                var sheetByBSheet = wb.Worksheets.Add("BSHEET");
                sheetByBSheet.Cell(rows, cells).SetValue("년도").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                sheetByBSheet.Cell(rows, ++cells).SetValue("월").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                sheetByBSheet.Cell(rows, ++cells).SetValue("총자산").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                sheetByBSheet.Cell(rows, ++cells).SetValue("유동자산").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                sheetByBSheet.Cell(rows, ++cells).SetValue("총부채").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                sheetByBSheet.Cell(rows, ++cells).SetValue("유동부채").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                sheetByBSheet.Cell(rows, ++cells).SetValue("총자본").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                sheetByBSheet.Cell(rows, ++cells).SetValue("현금").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                sheetByBSheet.Cell(rows, ++cells).SetValue("차입금").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                cells = 1;
                if(currentPmBsBsheet != null)
                {
                    sheetByBSheet.Cell(++rows, cells).SetValue(nowYear).Style.Fill.SetBackgroundColor(XLColor.White).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    sheetByBSheet.Cell(rows, ++cells).SetValue(nowMonth).Style.Fill.SetBackgroundColor(XLColor.White).Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                    sheetByBSheet.Cell(rows, ++cells).SetValue(currentPmBsBsheet.Assets).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    sheetByBSheet.Cell(rows, ++cells).SetValue(currentPmBsBsheet.CurrentAssets).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    sheetByBSheet.Cell(rows, ++cells).SetValue(currentPmBsBsheet.Liabilities).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    sheetByBSheet.Cell(rows, ++cells).SetValue(currentPmBsBsheet.CurrentLiabilities).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    sheetByBSheet.Cell(rows, ++cells).SetValue(currentPmBsBsheet.Capital).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    sheetByBSheet.Cell(rows, ++cells).SetValue(currentPmBsBsheet.Cash).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    sheetByBSheet.Cell(rows, ++cells).SetValue(currentPmBsBsheet.Loan).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                }
                else
                {
                    sheetByBSheet.Cell(++rows, cells).SetValue(nowYear).Style.Fill.SetBackgroundColor(XLColor.White).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    sheetByBSheet.Cell(rows, ++cells).SetValue(nowMonth).Style.Fill.SetBackgroundColor(XLColor.White).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    sheetByBSheet.Cell(rows, ++cells).SetValue("0.00").Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    sheetByBSheet.Cell(rows, ++cells).SetValue("0.00").Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    sheetByBSheet.Cell(rows, ++cells).SetValue("0.00").Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    sheetByBSheet.Cell(rows, ++cells).SetValue("0.00").Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    sheetByBSheet.Cell(rows, ++cells).SetValue("0.00").Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    sheetByBSheet.Cell(rows, ++cells).SetValue("0.00").Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    sheetByBSheet.Cell(rows, ++cells).SetValue("0.00").Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                }

                rows = 1;
                cells = 1;

                // ROIC 영역
                var sheetByRoic = wb.Worksheets.Add("ROIC");

                sheetByRoic.Cell(rows, cells).SetValue("년도").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                sheetByRoic.Cell(rows, ++cells).SetValue("월").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                sheetByRoic.Cell(rows, ++cells).SetValue("세후 영업이익").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                sheetByRoic.Cell(rows, ++cells).SetValue("투하자본").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                cells = 1;
                if(currentPmBsRoic != null)
                {
                    sheetByRoic.Cell(++rows, cells).SetValue(nowYear).Style.Fill.SetBackgroundColor(XLColor.White).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    sheetByRoic.Cell(rows, ++cells).SetValue(nowMonth).Style.Fill.SetBackgroundColor(XLColor.White).Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                    sheetByRoic.Cell(rows, ++cells).SetValue(currentPmBsRoic.AfterTaxOperationProfit).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    sheetByRoic.Cell(rows, ++cells).SetValue(currentPmBsRoic.PainInCapital).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                }
                else
                {
                    sheetByRoic.Cell(++rows, cells).SetValue(nowYear).Style.Fill.SetBackgroundColor(XLColor.White).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    sheetByRoic.Cell(rows, ++cells).SetValue(nowMonth).Style.Fill.SetBackgroundColor(XLColor.White).Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                    sheetByRoic.Cell(rows, ++cells).SetValue("0.00").Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    sheetByRoic.Cell(rows, ++cells).SetValue("0.00").Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                }

                rows = 1;
                cells = 1;

                // W/CAPITAL 영역
                var sheetByWCapital = wb.Worksheets.Add("WCAPITAL");
                sheetByWCapital.Cell(rows, cells).SetValue("년도").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                sheetByWCapital.Cell(rows, ++cells).SetValue("월").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                sheetByWCapital.Cell(rows, ++cells).SetValue("연간매출액").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                sheetByWCapital.Cell(rows, ++cells).SetValue("연간매출원가(AP)").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                sheetByWCapital.Cell(rows, ++cells).SetValue("연간매출원가(Inv)").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                cells = 1;
                if(currentPmBsWCapital != null)
                {

                    sheetByWCapital.Cell(++rows, cells).SetValue(nowYear).Style.Fill.SetBackgroundColor(XLColor.White).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    sheetByWCapital.Cell(rows, ++cells).SetValue(nowMonth).Style.Fill.SetBackgroundColor(XLColor.White).Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                    sheetByWCapital.Cell(rows, ++cells).SetValue(currentPmBsWCapital.AnnualSales).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    sheetByWCapital.Cell(rows, ++cells).SetValue(currentPmBsWCapital.AnnualSalesCost).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    sheetByWCapital.Cell(rows, ++cells).SetValue(currentPmBsWCapital.InventoryCost).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                }
                else
                {
                    sheetByWCapital.Cell(++rows, cells).SetValue(nowYear).Style.Fill.SetBackgroundColor(XLColor.White).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    sheetByWCapital.Cell(rows, ++cells).SetValue(nowMonth).Style.Fill.SetBackgroundColor(XLColor.White).Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                    sheetByWCapital.Cell(rows, ++cells).SetValue("0.00").Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    sheetByWCapital.Cell(rows, ++cells).SetValue("0.00").Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    sheetByWCapital.Cell(rows, ++cells).SetValue("0.00").Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                }
                using (MemoryStream mStream = new MemoryStream())
                {
                    wb.SaveAs(mStream);
                    return File(mStream.ToArray(), "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", fileName + ".xlsx");

                }
            }
        }


        [HttpPost]
        [AcceptVerbs(HttpVerbs.Post), ValidateInput(false)]
        [Route("Excel")]
        public ActionResult excel(PmBs entity, HttpPostedFileBase ExcelFile, string isEdit)
        {

            TempData["alert"] = "업로드되었습니다.";

            dynamic model = new ExpandoObject();

            model.uploadedPmBsBsheet = new PmBsBsheet();
            model.uploadedPmBsRoic = new PmBsRoic();
            model.uploadedPmBsWCapital = new PmBsWCapital();

            // 엑셀파일 처리 부 
            bool result = true;
            string resultMsg = "";
            if (ExcelFile.ContentLength != 0)
            {
                FileUtil fileUtil = new FileUtil(Define.FILE_PATH);
                string filePath = "pmBs";
                var file = fileUtil.FileUpload(ExcelFile, filePath);

                bool bDoubleValue = true;
                ExcelUtil excelUtil = new ExcelUtil();
                var ds = excelUtil.ImportExcelDs(file["FILE_PATH"]);

                try
                {
                    // 업로드한 엑셀의 SHEET 이름으로 체크한다.
                    if(ds.Tables["BSHEET"] == null || ds.Tables["BSHEET"].Rows.Count == 0
                        || ds.Tables["ROIC"] == null || ds.Tables["ROIC"].Rows.Count == 0
                        || ds.Tables["WCAPITAL"] == null || ds.Tables["WCAPITAL"].Rows.Count == 0)
                    {
                        // 오류시 파일 삭제
                        fileUtil.FileDelete(filePath, file["STORED_FILE_NAME"]);
                        result = false;
                        resultMsg = "엑셀 데이터에 오류가 있습니다.\\n확인 후 다시 업로드해주세요";
                    }else
                    {
                        // 정상적인 엑셀 양식이라고 판단.

                        PmBsBsheet uploadedPmBsBsheet = new PmBsBsheet();
                        PmBsRoic uploadedPmBsRoic = new PmBsRoic();
                        PmBsWCapital uploadedPmBsWCapital = new PmBsWCapital();

                        // 1. BSHEET 처리 
                        int rowCnt = 1;
                        foreach (DataRow item in ds.Tables["BSHEET"].Rows)
                        {
                            // 4. 처리 완료 후 Object 생성
                            if(rowCnt < 2)
                            {
                                string assets = item.ItemArray.GetValue(2).ToString();
                                string currentAssets = item.ItemArray.GetValue(3).ToString();
                                string liabilities = item.ItemArray.GetValue(4).ToString();
                                string currentLiabilities = item.ItemArray.GetValue(5).ToString();
                                string capital = item.ItemArray.GetValue(6).ToString();
                                string cash = item.ItemArray.GetValue(7).ToString();
                                string loan = item.ItemArray.GetValue(8).ToString();
                                //string liabilitiesRate      = item.ItemArray.GetValue(7).ToString();
                                //string currentRate          = item.ItemArray.GetValue(8).ToString();

                                if (!WebUtil.CheckDecimalTwo(assets)) { bDoubleValue = false; break; }
                                if (!WebUtil.CheckDecimalTwo(currentAssets)) { bDoubleValue = false; break; }
                                if (!WebUtil.CheckDecimalTwo(liabilities)) { bDoubleValue = false; break; }
                                if (!WebUtil.CheckDecimalTwo(currentLiabilities)) { bDoubleValue = false; break; }
                                if (!WebUtil.CheckDecimalTwo(capital)) { bDoubleValue = false; break; }
                                if (!WebUtil.CheckDecimalTwo(cash)) { bDoubleValue = false; break; }
                                if (!WebUtil.CheckDecimalTwo(loan)) { bDoubleValue = false; break; }
                                //if (!WebUtil.CheckDecimalTwo(liabilitiesRate))      { bDoubleValue = false; break; }
                                //if (!WebUtil.CheckDecimalTwo(currentRate))          { bDoubleValue = false; break; }


                                uploadedPmBsBsheet.Assets = Convert.ToDecimal(assets);
                                uploadedPmBsBsheet.CurrentAssets = Convert.ToDecimal(currentAssets);
                                uploadedPmBsBsheet.Liabilities = Convert.ToDecimal(liabilities);
                                uploadedPmBsBsheet.CurrentLiabilities = Convert.ToDecimal(currentLiabilities);
                                uploadedPmBsBsheet.Capital = Convert.ToDecimal(capital);
                                uploadedPmBsBsheet.Cash = Convert.ToDecimal(cash);
                                uploadedPmBsBsheet.Loan = Convert.ToDecimal(loan);
                                //uploadedPmBsBsheet.LiabilitiesRate      = Convert.ToDecimal(liabilitiesRate);
                                //uploadedPmBsBsheet.CurrentRate          = Convert.ToDecimal(currentRate);
                                rowCnt++;
                            }
                        }

                        if (!bDoubleValue)
                        {
                            // 오류시 파일 삭제
                            fileUtil.FileDelete(filePath, file["STORED_FILE_NAME"]);
                            result = false;
                            resultMsg = "엑셀 데이터에 오류가 있습니다.\\n확인 후 다시 업로드해주세요";
                        }


                        // 2. ROIC 처리
                        rowCnt = 1;
                        foreach (DataRow item in ds.Tables["ROIC"].Rows)
                        {
                            if(rowCnt < 2)
                            {
                                string afterTaxOperationProfit  = item.ItemArray.GetValue(2).ToString();
                                string painInCapital            = item.ItemArray.GetValue(3).ToString();

                                if (!WebUtil.CheckDecimalTwo(afterTaxOperationProfit))  { bDoubleValue = false; break; }
                                if (!WebUtil.CheckDecimalTwo(painInCapital))            { bDoubleValue = false; break; }

                                uploadedPmBsRoic.AfterTaxOperationProfit    = Convert.ToDecimal(afterTaxOperationProfit);
                                uploadedPmBsRoic.PainInCapital              = Convert.ToDecimal(painInCapital);

                                rowCnt++;
                            }
                        }

                        if (!bDoubleValue)
                        {
                            // 오류시 파일 삭제
                            fileUtil.FileDelete(filePath, file["STORED_FILE_NAME"]);
                            result = false;
                            resultMsg = "엑셀 데이터에 오류가 있습니다.\\n확인 후 다시 업로드해주세요";
                        }

                        // 3. W/CAPITAL 처리
                        rowCnt = 1;
                        foreach (DataRow item in ds.Tables["WCAPITAL"].Rows)
                        {
                            if(rowCnt < 2)
                            {
                                string annualSales = item.ItemArray.GetValue(2).ToString();
                                string annualSalesCost = item.ItemArray.GetValue(3).ToString();
                                string InventoryCost = item.ItemArray.GetValue(4).ToString();

                                if (!WebUtil.CheckDecimalTwo(annualSales)) { bDoubleValue = false; break; }
                                if (!WebUtil.CheckDecimalTwo(annualSalesCost)) { bDoubleValue = false; break; }
                                if (!WebUtil.CheckDecimalTwo(InventoryCost)) { bDoubleValue = false; break; }

                                uploadedPmBsWCapital.AnnualSales = Convert.ToDecimal(annualSales);
                                uploadedPmBsWCapital.AnnualSalesCost = Convert.ToDecimal(annualSalesCost);
                                uploadedPmBsWCapital.InventoryCost = Convert.ToDecimal(InventoryCost);

                                rowCnt++;
                            }
                        }

                        if (!bDoubleValue)
                        {
                            // 오류시 파일 삭제
                            fileUtil.FileDelete(filePath, file["STORED_FILE_NAME"]);
                            result = false;
                            resultMsg = "엑셀 데이터에 오류가 있습니다.\\n확인 후 다시 업로드해주세요";
                        }

                        if(uploadedPmBsBsheet.Liabilities == 0 || uploadedPmBsBsheet.Capital == 0)
                        {
                            uploadedPmBsBsheet.LiabilitiesRate = 0;
                        }
                        else
                        {
                            uploadedPmBsBsheet.LiabilitiesRate = Math.Round((uploadedPmBsBsheet.Liabilities / uploadedPmBsBsheet.Capital) * 100, 2, MidpointRounding.AwayFromZero);
                        }

                        if (uploadedPmBsBsheet.Assets == 0 || uploadedPmBsBsheet.Liabilities == 0)
                        {
                            uploadedPmBsBsheet.CurrentRate = 0;
                        }
                        else
                        {
                            uploadedPmBsBsheet.CurrentRate = Math.Round((uploadedPmBsBsheet.Assets / uploadedPmBsBsheet.Liabilities) * 100, 2, MidpointRounding.AwayFromZero);
                        }

                        if (uploadedPmBsRoic.AfterTaxOperationProfit == 0 || uploadedPmBsRoic.PainInCapital == 0)
                        {
                            uploadedPmBsRoic.Roic = 0;
                        }
                        else
                        {
                            uploadedPmBsRoic.Roic = Math.Round((uploadedPmBsRoic.AfterTaxOperationProfit / uploadedPmBsRoic.PainInCapital) * 100, 2, MidpointRounding.AwayFromZero);
                        }

                        model.uploadedPmBsBsheet = uploadedPmBsBsheet;
                        model.uploadedPmBsRoic = uploadedPmBsRoic;
                        model.uploadedPmBsWCapital = uploadedPmBsWCapital;
                    }
                }catch(Exception e)
                {
                    result = false;
                    resultMsg = "엑셀 데이터에 오류가 있습니다.\\n확인 후 다시 업로드해주세요";
                }
            }

            if (!result)
            {
                TempData["alert"] = resultMsg;
            }else
            {
                TempData["alert"] = "업로드되었습니다.";
            }

            // 기본 처리는 위 Write 와 동일함.
            if (Request.RequestType == "GET") return RedirectToAction("List");

            // 기본데이터 (pmBs.Monthly / pmBs.BsYear)
            var pmBs = pmBsRepo.selectOne(entity);

            // 부문 > 회사 이름
            var orgCompany = orgCompanyRepo.selectOne(new { Seq = pmBs.OrgCompanySeq });

            //////////////////////////////////////////////////////////////////////////////////
            // B/Sheet
            // 1. 전년도 기말 실적 : PM_BS_BSHEET
            //    전년도 pmBs 조회 해서 처리해야 함. >>>> bs_year, monthly, org_company_seq
            var prevPmBs = pmBsRepo.selectOneForPrev(new { bsYear = pmBs.BsYear, monthly = pmBs.Monthly, OrgCompanySeq = pmBs.OrgCompanySeq });
            var pmBsBsheet = pmBsBsheetRepo.selectOneByPmBsSeq(new { PmBsSeq = prevPmBs.Seq });
            if (pmBsBsheet == null) { pmBsBsheet = new PmBsBsheet(); }

            // 2. 당해 월 계획 : PLAN_YEAR_BS_BSHEET
            var planYearBsSheet = planYearBsBsheetRepo.nowYearBsSheetOneExp(new { yearBsYear = pmBs.BsYear, monthly = pmBs.Monthly, OrgCompanySeq = orgCompany.Seq });
            if(planYearBsSheet == null) { planYearBsSheet = new PlanYearBsBsheet(); }

            //////////////////////////////////////////////////////////////////////////////////
            // ROIC
            // 1. 전년도 실적 : PM_BS_ROIC
            //    전년도 pmBs 정보 이용해야 함.
            var pmBsRoic = pmBsRoicRepo.selectOneByPmBsSeq(new { PmBsSeq = prevPmBs.Seq });
            if (pmBsRoic == null) { pmBsRoic = new PmBsRoic(); }

            // 2. 당해 월 계획 : PLAN_YEAR_BS_ROIC
            var planYearBsRoic = planYearBsRoicRepo.nowYearBsRoicOneExp(new { yearBsYear = pmBs.BsYear, monthly = pmBs.Monthly, OrgCompanySeq = orgCompany.Seq });
            if(planYearBsRoic == null) { planYearBsRoic = new PlanYearBsRoic(); }

            //////////////////////////////////////////////////////////////////////////////////
            // W/Capital
            if (prevPmBs == null)
            {
                model.pmBsWCapitalReg = new PmBsWCapitalReg();
            }
            else
            {
                var pmBsWCapitalReg = pmBsWCapitalRegRepo.selectOneByPmBsSeq(new { PmBsSeq = prevPmBs.Seq });
                if(pmBsWCapitalReg == null) { pmBsWCapitalReg = new PmBsWCapitalReg(); }
                model.pmBsWCapitalReg = pmBsWCapitalReg;
            }

            // 2. 당해 월 계획 : PLAN_YEAR_BS_W_CAPITAL_REG
            var planYearBsWCapitalReg = planYearBsWCapitalRegRepo.nowYearBsWCapitalRegOneExp(new { yearBsYear = pmBs.BsYear, monthly = pmBs.Monthly, OrgCompanySeq = orgCompany.Seq });
            if (planYearBsWCapitalReg == null) { planYearBsWCapitalReg = new PlanYearBsWCapitalReg(); }

            ///////////////////////////////////////////////////////////////////////////////////////////
            var currentPmBsWCapital = pmBsWCapitalRepo.selectOneByPmBsSeq(new { PmBsSeq = pmBs.Seq });

            var currentPmBsWCapitalReg = pmBsWCapitalRegRepo.selectOneByPmBsSeq(new { PmBsSeq = pmBs.Seq });
            if (currentPmBsWCapitalReg == null) { currentPmBsWCapitalReg = new PmBsWCapitalReg(); }
            else
            {
                // PM_BS_W_CAPITAL_REG 데이터가 있는 경우 >> 계산하기 까지 처리가 된 경우임.
                // 계산하기가 처리 된 경우 하단 SUMMARY 영역 처리가 필요 함.

                // 당해년도 실적 정보 데이터 
                PmBsSummary pmBsSummary = pmBsSummaryRepo.selectOneByPmBsSeq(new { PmBsSeq = pmBs.Seq });
                if (pmBsSummary == null)
                {
                    pmBsSummary = new PmBsSummary();
                }
                else
                {
                    if (pmBsSummary.Liabilities == 0 || pmBsSummary.Capital == 0)
                    {
                        pmBsSummary.LiabilitiesRate = 0;
                    }
                    else
                    {
                        pmBsSummary.LiabilitiesRate = Math.Round((pmBsSummary.Liabilities / pmBsSummary.Capital) * 100, 2, MidpointRounding.AwayFromZero);
                    }
                }
                model.pmBsSummary = pmBsSummary;

                // 전년도 실적 정보 데이터
                PmBsSummary prevPmBsSummary = new PmBsSummary();
                if (prevPmBs != null)
                {
                    prevPmBsSummary = pmBsSummaryRepo.selectOneByPmBsSeq(new { PmBsSeq = prevPmBs.Seq });
                    if (prevPmBsSummary.Liabilities == 0 || prevPmBsSummary.Capital == 0)
                    {
                        prevPmBsSummary.LiabilitiesRate = 0;
                    }
                    else
                    {
                        prevPmBsSummary.LiabilitiesRate = Math.Round((prevPmBsSummary.Liabilities / prevPmBsSummary.Capital) * 100, 2, MidpointRounding.AwayFromZero);
                    }
                }
                model.prevPmBsSummary = prevPmBsSummary;
            }

            // 뷰 전달 모델
            model.pmBs = pmBs;
            model.orgCompany = orgCompany;
            model.pmBsBsheet = pmBsBsheet;
            model.planYearBsSheet = planYearBsSheet;
            model.pmBsRoic = pmBsRoic;
            model.planYearBsRoic = planYearBsRoic;
            model.currentPmBsWCapitalReg = currentPmBsWCapitalReg;
            model.planYearBsWCapitalReg = planYearBsWCapitalReg;
            model.excel = "Y";

            if (isEdit.Equals("Y"))
            {
                model.currentPmBsBsheet = pmBsBsheetRepo.selectOneByPmBsSeq(new { PmBsSeq = pmBs.Seq });
                model.currentPmBsRoic = pmBsRoicRepo.selectOneByPmBsSeq(new { PmBsSeq = pmBs.Seq });
                model.currentPmBsWCapital = pmBsWCapitalRepo.selectOneByPmBsSeq(new { PmBsSeq = pmBs.Seq });

                return View("~/Views/SiteMngHome/Performance/Bs/Edit.cshtml", model);
                TempData.Remove("alert");
            }
            else
            {
                return View("~/Views/SiteMngHome/Performance/Bs/Write.cshtml", model);
                TempData.Remove("alert");
            }
        }

        [Route("View")]
        public ActionResult view(PmBs entity)
        {
            // 하단 Edit 로직과 동일
            dynamic model = new ExpandoObject();

            // 기본데이터 (pmBs.Monthly / pmBs.BsYear)
            var pmBs = pmBsRepo.selectOne(entity);

            // 부문 > 회사 이름
            var orgCompany = orgCompanyRepo.selectOne(new { Seq = pmBs.OrgCompanySeq });

            //////////////////////////////////////////////////////////////////////////////////
            // B/Sheet
            // 1. 전년도 기말 실적 : PM_BS_BSHEET
            //    전년도 pmBs 조회 해서 처리해야 함. >>>> bs_year, monthly, org_company_seq
            var prevPmBs = pmBsRepo.selectOneForPrev(new { bsYear = Convert.ToInt32(pmBs.BsYear) - 1, monthly = pmBs.Monthly, OrgCompanySeq = pmBs.OrgCompanySeq });
            if (prevPmBs == null)
            {
                model.pmBsBsheet = new PmBsBsheet();
            }
            else
            {
                var pmBsBsheet = pmBsBsheetRepo.selectOneByPmBsSeq(new { PmBsSeq = prevPmBs.Seq });
                if(pmBsBsheet == null) { pmBsBsheet = new PmBsBsheet(); }
                model.pmBsBsheet = pmBsBsheet;
            }

            // 2. 당해 월 계획 : PLAN_YEAR_BS_BSHEET
            var planYearBsSheet = planYearBsBsheetRepo.nowYearBsSheetOneExp(new { yearBsYear = pmBs.BsYear, monthly = pmBs.Monthly, OrgCompanySeq = orgCompany.Seq });
            if (planYearBsSheet == null) { planYearBsSheet = new PlanYearBsBsheet(); }

            //////////////////////////////////////////////////////////////////////////////////
            // ROIC
            // 1. 전년도 실적 : PM_BS_ROIC
            //    전년도 pmBs 정보 이용해야 함.
            if (prevPmBs == null)
            {
                model.pmBsRoic = new PmBsRoic();
            }
            else
            {
                var pmBsRoic = pmBsRoicRepo.selectOneByPmBsSeq(new { PmBsSeq = prevPmBs.Seq });
                if(pmBsRoic == null) { pmBsRoic = new Models.PmBsRoic(); }
                model.pmBsRoic = pmBsRoic;
            }

            // 2. 당해 월 계획 : PLAN_YEAR_BS_ROIC
            var planYearBsRoic = planYearBsRoicRepo.nowYearBsRoicOneExp(new { yearBsYear = pmBs.BsYear, monthly = pmBs.Monthly, OrgCompanySeq = orgCompany.Seq });
            if (planYearBsRoic == null) { planYearBsRoic = new PlanYearBsRoic(); }

            //////////////////////////////////////////////////////////////////////////////////
            // W/Capital
            // 1. 전년도 실적 : PM_BS_CAPITAL_REG
            //    전년도 pmBS 정보 이용해야 함.
            if (prevPmBs == null)
            {
                model.pmBsWCapitalReg = new PmBsWCapitalReg();
            }
            else
            {
                var pmBsWCapitalReg = pmBsWCapitalRegRepo.selectOneByPmBsSeq(new { PmBsSeq = prevPmBs.Seq });
                if (pmBsWCapitalReg == null) { pmBsWCapitalReg = new PmBsWCapitalReg(); }
                model.pmBsWCapitalReg = pmBsWCapitalReg;
            }

            // 2. 당해 월 계획 : PLAN_YEAR_BS_W_CAPITAL_REG
            var planYearBsWCapitalReg = planYearBsWCapitalRegRepo.nowYearBsWCapitalRegOneExp(new { yearBsYear = pmBs.BsYear, monthly = pmBs.Monthly, OrgCompanySeq = orgCompany.Seq });
            if (planYearBsWCapitalReg == null) { planYearBsWCapitalReg = new PlanYearBsWCapitalReg(); }


            //////////////////////////////////////////////////////////////////////////////////
            // 뷰 전달 모델
            model.pmBs = pmBs;
            model.orgCompany = orgCompany;
            model.planYearBsSheet = planYearBsSheet;
            model.planYearBsRoic = planYearBsRoic;
            model.planYearBsWCapitalReg = planYearBsWCapitalReg;
            model.excel = "N";

            // Temp Data
            model.uploadedPmBsBsheet = new PmBsBsheet();
            model.uploadedPmBsRoic = new PmBsRoic();
            model.uploadedPmBsWCapital = new PmBsWCapital();

            // 기 등록된 데이터 가져오기
            var currentPmBsBsheet = pmBsBsheetRepo.selectOneByPmBsSeq(new { PmBsSeq = pmBs.Seq });
            if (currentPmBsBsheet.LiabilitiesRate == 0 || currentPmBsBsheet.Capital == 0)
            {
                currentPmBsBsheet.LiabilitiesRate = 0;
            }
            else
            {
                currentPmBsBsheet.LiabilitiesRate = Math.Round((currentPmBsBsheet.Liabilities / currentPmBsBsheet.Capital) * 100, 2, MidpointRounding.AwayFromZero);
            }
            if (currentPmBsBsheet.Assets == 0 || currentPmBsBsheet.Liabilities == 0)
            {
                currentPmBsBsheet.CurrentRate = 0;
            }
            else
            {
                currentPmBsBsheet.CurrentRate = Math.Round((currentPmBsBsheet.Assets / currentPmBsBsheet.Liabilities) * 100, 2, MidpointRounding.AwayFromZero);
            }

            var currentPmBsRoic = pmBsRoicRepo.selectOneByPmBsSeq(new { PmBsSeq = pmBs.Seq });
            if (currentPmBsRoic.AfterTaxOperationProfit == 0 || currentPmBsRoic.PainInCapital == 0)
            {
                currentPmBsRoic.Roic = 0;
            }
            else
            {
                currentPmBsRoic.Roic = Math.Round((currentPmBsRoic.AfterTaxOperationProfit / currentPmBsRoic.PainInCapital) * 100, 2, MidpointRounding.AwayFromZero);
            }

            var currentPmBsWCapital = pmBsWCapitalRepo.selectOneByPmBsSeq(new { PmBsSeq = pmBs.Seq });

            var currentPmBsWCapitalReg = pmBsWCapitalRegRepo.selectOneByPmBsSeq(new { PmBsSeq = pmBs.Seq });
            if (currentPmBsWCapitalReg == null) { currentPmBsWCapitalReg = new PmBsWCapitalReg(); }
            else
            {
                // PM_BS_W_CAPITAL_REG 데이터가 있는 경우 >> 계산하기 까지 처리가 된 경우임.
                // 계산하기가 처리 된 경우 하단 SUMMARY 영역 처리가 필요 함.

                // 당해년도 실적 정보 데이터 
                PmBsSummary pmBsSummary = new PmBsSummary();
                if (pmBs != null)
                {
                    pmBsSummary = pmBsSummaryRepo.selectOneByPmBsSeq(new { PmBsSeq = pmBs.Seq });
                    if (pmBsSummary == null)
                    {
                        pmBsSummary = new PmBsSummary();
                    }
                    else
                    {
                        if (pmBsSummary.Liabilities == 0 || pmBsSummary.Capital == 0)
                        {
                            pmBsSummary.LiabilitiesRate = 0;
                        }
                        else
                        {
                            pmBsSummary.LiabilitiesRate = Math.Round((pmBsSummary.Liabilities / pmBsSummary.Capital) * 100, 2, MidpointRounding.AwayFromZero);
                        }
                    }
                }
                model.pmBsSummary = pmBsSummary;

                // 전년도 실적 정보 데이터
                PmBsSummary prevPmBsSummary = new PmBsSummary();
                if (prevPmBs != null)
                {
                    prevPmBsSummary = pmBsSummaryRepo.selectOneByPmBsSeq(new { PmBsSeq = prevPmBs.Seq });
                    if (prevPmBsSummary == null) { prevPmBsSummary = new PmBsSummary(); }
                    if (prevPmBsSummary.Liabilities == 0 || prevPmBsSummary.Capital == 0)
                    {
                        prevPmBsSummary.LiabilitiesRate = 0;
                    }
                    else
                    {
                        prevPmBsSummary.LiabilitiesRate = Math.Round((prevPmBsSummary.Liabilities / prevPmBsSummary.Capital) * 100, 2, MidpointRounding.AwayFromZero);
                    }
                }
                model.prevPmBsSummary = prevPmBsSummary;


            }

            model.currentPmBsBsheet = currentPmBsBsheet;
            model.currentPmBsRoic = currentPmBsRoic;
            model.currentPmBsWCapital = currentPmBsWCapital;
            model.currentPmBsWCapitalReg = currentPmBsWCapitalReg;
            return View("~/Views/SiteMngHome/Performance/Bs/View.cshtml", model);
            TempData.Remove("alert");
        }

        [Route("Edit")]
        public ActionResult Edit(PmBs entity)
        {
            var alert = TempData["alert"];
            if(alert != null)
            {
                TempData["alert"] = alert;
            }

            dynamic model = new ExpandoObject();

            // 기본데이터 (pmBs.Monthly / pmBs.BsYear)
            var pmBs = pmBsRepo.selectOne(entity);

            // 부문 > 회사 이름
            var orgCompany = orgCompanyRepo.selectOne(new { Seq = pmBs.OrgCompanySeq });

            //////////////////////////////////////////////////////////////////////////////////
            // B/Sheet
            // 1. 전년도 기말 실적 : PM_BS_BSHEET
            //    전년도 pmBs 조회 해서 처리해야 함. >>>> bs_year, monthly, org_company_seq
            var prevPmBs = pmBsRepo.selectOneForPrev(new { bsYear = Convert.ToInt32(pmBs.BsYear) - 1, monthly = pmBs.Monthly, OrgCompanySeq = pmBs.OrgCompanySeq });
            if (prevPmBs == null)
            {
                model.pmBsBsheet = new PmBsBsheet();
            }
            else
            {
                var pmBsBsheet = pmBsBsheetRepo.selectOneByPmBsSeq(new { PmBsSeq = prevPmBs.Seq });
                if(pmBsBsheet == null) { pmBsBsheet = new PmBsBsheet(); }
                model.pmBsBsheet = pmBsBsheet;
            }

            // 2. 당해 월 계획 : PLAN_YEAR_BS_BSHEET
            var planYearBsSheet = planYearBsBsheetRepo.nowYearBsSheetOneExp(new { yearBsYear = pmBs.BsYear, monthly = pmBs.Monthly, OrgCompanySeq = orgCompany.Seq });
            if(planYearBsSheet == null) { planYearBsSheet = new PlanYearBsBsheet(); }

            //////////////////////////////////////////////////////////////////////////////////
            // ROIC
            // 1. 전년도 실적 : PM_BS_ROIC
            //    전년도 pmBs 정보 이용해야 함.
            if (prevPmBs == null)
            {
                model.pmBsRoic = new PmBsRoic();
            }
            else
            {
                var pmBsRoic = pmBsRoicRepo.selectOneByPmBsSeq(new { PmBsSeq = prevPmBs.Seq });
                if(pmBsRoic == null) { pmBsRoic = new Models.PmBsRoic(); }
                model.pmBsRoic = pmBsRoic;
                
            }

            // 2. 당해 월 계획 : PLAN_YEAR_BS_ROIC
            var planYearBsRoic = planYearBsRoicRepo.nowYearBsRoicOneExp(new { yearBsYear = pmBs.BsYear, monthly = pmBs.Monthly, OrgCompanySeq = orgCompany.Seq });
            if(planYearBsRoic == null) { planYearBsRoic = new PlanYearBsRoic(); }

            //////////////////////////////////////////////////////////////////////////////////
            // W/Capital
            // 1. 전년도 실적 : PM_BS_CAPITAL_REG
            //    전년도 pmBS 정보 이용해야 함.
            if(prevPmBs == null)
            {
                model.pmBsWCapitalReg = new PmBsWCapitalReg();
            }else
            {
                var pmBsWCapitalReg = pmBsWCapitalRegRepo.selectOneByPmBsSeq(new { PmBsSeq = prevPmBs.Seq });
                if(pmBsWCapitalReg == null) { pmBsWCapitalReg = new PmBsWCapitalReg(); }
                model.pmBsWCapitalReg = pmBsWCapitalReg;
            }

            // 2. 당해 월 계획 : PLAN_YEAR_BS_W_CAPITAL_REG
            var planYearBsWCapitalReg = planYearBsWCapitalRegRepo.nowYearBsWCapitalRegOneExp(new { yearBsYear = pmBs.BsYear, monthly = pmBs.Monthly, OrgCompanySeq = orgCompany.Seq });
            if (planYearBsWCapitalReg == null) { planYearBsWCapitalReg = new PlanYearBsWCapitalReg(); }


            //////////////////////////////////////////////////////////////////////////////////
            // 뷰 전달 모델
            model.pmBs = pmBs;
            model.orgCompany = orgCompany;
            model.planYearBsSheet = planYearBsSheet;
            model.planYearBsRoic = planYearBsRoic;
            model.planYearBsWCapitalReg = planYearBsWCapitalReg;
            model.excel = "N";

            // Temp Data
            model.uploadedPmBsBsheet = new PmBsBsheet();
            model.uploadedPmBsRoic = new PmBsRoic();
            model.uploadedPmBsWCapital = new PmBsWCapital();

            // 기 등록된 데이터 가져오기
            var currentPmBsBsheet = pmBsBsheetRepo.selectOneByPmBsSeq(new { PmBsSeq = pmBs.Seq });
            if (currentPmBsBsheet.LiabilitiesRate == 0 || currentPmBsBsheet.Capital == 0)
            {
                currentPmBsBsheet.LiabilitiesRate = 0;
            }
            else
            {
                currentPmBsBsheet.LiabilitiesRate = Math.Round((currentPmBsBsheet.Liabilities / currentPmBsBsheet.Capital) * 100, 2, MidpointRounding.AwayFromZero);
            }
            if (currentPmBsBsheet.Assets == 0 || currentPmBsBsheet.Liabilities == 0)
            {
                currentPmBsBsheet.CurrentRate = 0;
            }
            else
            {
                currentPmBsBsheet.CurrentRate = Math.Round((currentPmBsBsheet.Assets / currentPmBsBsheet.Liabilities) * 100, 2, MidpointRounding.AwayFromZero);
            }

            var currentPmBsRoic = pmBsRoicRepo.selectOneByPmBsSeq(new { PmBsSeq = pmBs.Seq });
            if (currentPmBsRoic.AfterTaxOperationProfit == 0 || currentPmBsRoic.PainInCapital == 0)
            {
                currentPmBsRoic.Roic = 0;
            }
            else
            {
                currentPmBsRoic.Roic = Math.Round((currentPmBsRoic.AfterTaxOperationProfit / currentPmBsRoic.PainInCapital) * 100, 2, MidpointRounding.AwayFromZero);
            }

            var currentPmBsWCapital = pmBsWCapitalRepo.selectOneByPmBsSeq(new { PmBsSeq = pmBs.Seq });

            var currentPmBsWCapitalReg = pmBsWCapitalRegRepo.selectOneByPmBsSeq(new { PmBsSeq = pmBs.Seq });
            if(currentPmBsWCapitalReg == null) { currentPmBsWCapitalReg = new PmBsWCapitalReg(); }
            else
            {
                // PM_BS_W_CAPITAL_REG 데이터가 있는 경우 >> 계산하기 까지 처리가 된 경우임.
                // 계산하기가 처리 된 경우 하단 SUMMARY 영역 처리가 필요 함.

                // 당해년도 실적 정보 데이터 
                PmBsSummary pmBsSummary = new Models.PmBsSummary();
                if (pmBs != null)
                {
                    pmBsSummary = pmBsSummaryRepo.selectOneByPmBsSeq(new { PmBsSeq = pmBs.Seq });
                    if (pmBsSummary == null)
                    {
                        pmBsSummary = new PmBsSummary();
                    }
                    else
                    {
                        if (pmBsSummary.Liabilities == 0 || pmBsSummary.Capital == 0)
                        {
                            pmBsSummary.LiabilitiesRate = 0;
                        }
                        else
                        {
                            pmBsSummary.LiabilitiesRate = Math.Round((pmBsSummary.Liabilities / pmBsSummary.Capital) * 100, 2, MidpointRounding.AwayFromZero);
                        }
                    }
                }
                
                model.pmBsSummary = pmBsSummary;

                // 전년도 실적 정보 데이터
                PmBsSummary prevPmBsSummary = new PmBsSummary();
                if (prevPmBs != null)
                {
                    prevPmBsSummary = pmBsSummaryRepo.selectOneByPmBsSeq(new { PmBsSeq = prevPmBs.Seq });
                    if(prevPmBsSummary == null) { prevPmBsSummary = new PmBsSummary(); }
                    if (prevPmBsSummary.Liabilities == 0 || prevPmBsSummary.Capital == 0)
                    {
                        prevPmBsSummary.LiabilitiesRate = 0;
                    }
                    else
                    {
                        prevPmBsSummary.LiabilitiesRate = Math.Round((prevPmBsSummary.Liabilities / prevPmBsSummary.Capital) * 100, 2, MidpointRounding.AwayFromZero);
                    }
                }
                model.prevPmBsSummary = prevPmBsSummary;


            }

            model.currentPmBsBsheet = currentPmBsBsheet;
            model.currentPmBsRoic = currentPmBsRoic;
            model.currentPmBsWCapital = currentPmBsWCapital;
            model.currentPmBsWCapitalReg = currentPmBsWCapitalReg;
            
            return View("~/Views/SiteMngHome/Performance/Bs/Edit.cshtml", model);
            TempData.Remove("alert");
        }


        [HttpPost]
        [AcceptVerbs(HttpVerbs.Post), ValidateInput(false)]
        [Route("CalculateAction")]
        public ActionResult CalculateAction(int seq, PmBsWCapitalReg pmBsWCapitalReg, PmBsBsheet pmBsBsheet, PmBsRoic pmBsRoic, PmBsWCapital pmBsWcapital)
        {
            bool flag = true;
            if (pmBsBsheetRepo.save(pmBsBsheet) == -1)
            {
                flag = false;
            }
            if (pmBsRoicRepo.save(pmBsRoic) == -1)
            {
                flag = false;
            }
            if (pmBsWCapitalRepo.save(pmBsWcapital) == -1)
            {
                flag = false;
            }
            if (pmBsWCapitalRegRepo.save(pmBsWCapitalReg) == -1)
            {
                flag = false;
            }

            if (!flag)
            {
                TempData["alert"] = "처리 중 오류가 발생하였습니다.";
                return Redirect("/SiteMngHome/Performance/Bs/Edit?seq=" + seq);
            }

            // 1. B/Sheet 저장
            if (pmBsWCapitalRegRepo.save(pmBsWCapitalReg) == -1)
            {
                TempData["alert"] = "계산 중 오류가 발생하였습니다.";

            }else
            {
                /////////////////////////////////////////////////////////////
                // 계산하기가 처리 된 경우 하단 SUMMARY 영역 처리가 필요 함.
                // 기 등록된 summary 가 있는 경우에도 계산하기를 수행하는 경우 계산된 정보로 UPDATE

                // 0. (당해년도) PM_BS 기본정보
                PmBs pmBs = pmBsRepo.selectOne(new { seq = seq });
                // 0. (전년도) PM_BS 기본정보
                PmBs prevPmBs = pmBsRepo.selectOneForPrev(new
                {
                    bsYear = Convert.ToInt32(pmBs.BsYear) - 1
                    ,
                    monthly = pmBs.Monthly
                    ,
                    OrgCompanySeq = pmBs.OrgCompanySeq
                });

                // 1. 당해년도 실적 PM_BS_SUMMARY 정보 생성
                PmBsSummary pmBsSummary = pmBsSummaryRepo.selectOneByPmBsSeq(new { PmBsSeq = pmBs.Seq });

                // 1-1. 전년도 실적 (by. PM_BS_SUMMARY)
                PmBsSummary prevPmBsSummary = new PmBsSummary();
                if (prevPmBs != null)
                {
                    prevPmBsSummary = pmBsSummaryRepo.selectOneByPmBsSeq(new { PmBsSeq = prevPmBs.Seq });
                }

                // 1-2. 당해년도 계획 (by. BSHEET / ROIC / W_CAPITAL / W_CAPITAL_REG)
                var planYearBsBsheet = planYearBsBsheetRepo.nowYearBsSheetOneExp(new { yearBsYear = pmBs.BsYear, monthly = pmBs.Monthly, OrgCompanySeq = pmBs.Seq });
                if (planYearBsBsheet == null) { planYearBsBsheet = new PlanYearBsBsheet(); }

                var planYearBsRoic = planYearBsRoicRepo.nowYearBsRoicOneExp(new { yearBsYear = pmBs.BsYear, monthly = pmBs.Monthly, OrgCompanySeq = pmBs.Seq });
                if (planYearBsRoic == null) { planYearBsRoic = new PlanYearBsRoic(); }

                var planYearBsWCapital = planYearBsWCapitalRepo.nowYearBsWCapitalOneExp(new { yearBsYear = pmBs.BsYear, OrgCompanySeq = pmBs.Seq });
                if (planYearBsWCapital == null) { planYearBsWCapital = new PlanYearBsWCapital(); }

                var planYearBsWCapitalReg = planYearBsWCapitalRegRepo.nowYearBsWCapitalRegOneExp(new { yearBsYear = pmBs.BsYear, monthly = pmBs.Monthly, OrgCompanySeq = pmBs.Seq });
                if (planYearBsWCapitalReg == null) { planYearBsWCapitalReg = new PlanYearBsWCapitalReg(); }

                // planYearBsWCapitalReg > arToDays, apToDays, inventoryToDays
                if (planYearBsWCapitalReg.Ar > 0 && planYearBsWCapital.AnnualSales > 0)
                {
                    planYearBsWCapitalReg.ArToDays = (planYearBsWCapitalReg.Ar / planYearBsWCapital.AnnualSales) * 365;
                }
                if (planYearBsWCapitalReg.Ap > 0 && planYearBsWCapital.AnnualSalesCost > 0)
                {
                    planYearBsWCapitalReg.ApToDays = (planYearBsWCapitalReg.Ap / planYearBsWCapital.AnnualSalesCost) * 365;
                }
                if (planYearBsWCapitalReg.Inventory > 0 && planYearBsWCapital.AnnualSalesCost > 0)
                {
                    planYearBsWCapitalReg.InventoryToDays = (planYearBsWCapitalReg.Inventory / planYearBsWCapital.AnnualSalesCost) * 365;
                }

                // 1-3. 당해년도 실적 (by. PM_BS_BSHEET / PM_BS_ROIC / PM_BS_W_CAPITAL_REG)
                // 등록된 실적이 없는 경우 
                var currentPmBsBsheet = pmBsBsheetRepo.selectOneByPmBsSeq(new { PmBsSeq = pmBs.Seq });
                if (currentPmBsBsheet.LiabilitiesRate == 0 || currentPmBsBsheet.Capital == 0)
                {
                    currentPmBsBsheet.LiabilitiesRate = 0;
                }
                else
                {
                    currentPmBsBsheet.LiabilitiesRate = Math.Round((currentPmBsBsheet.Liabilities / currentPmBsBsheet.Capital) * 100, 2, MidpointRounding.AwayFromZero);
                }
                if (currentPmBsBsheet.Assets == 0 || currentPmBsBsheet.Liabilities == 0)
                {
                    currentPmBsBsheet.CurrentRate = 0;
                }
                else
                {
                    currentPmBsBsheet.CurrentRate = Math.Round((currentPmBsBsheet.Assets / currentPmBsBsheet.Liabilities) * 100, 2, MidpointRounding.AwayFromZero);
                }

                var currentPmBsRoic = pmBsRoicRepo.selectOneByPmBsSeq(new { PmBsSeq = pmBs.Seq });
                if (currentPmBsRoic.AfterTaxOperationProfit == 0 || currentPmBsRoic.PainInCapital == 0)
                {
                    currentPmBsRoic.Roic = 0;
                }
                else
                {
                    currentPmBsRoic.Roic = Math.Round((currentPmBsRoic.AfterTaxOperationProfit / currentPmBsRoic.PainInCapital) * 100, 2, MidpointRounding.AwayFromZero);
                }

                var currentPmBsWCapital = pmBsWCapitalRepo.selectOneByPmBsSeq(new { PmBsSeq = pmBs.Seq });
                var currentPmBsWCapitalReg = pmBsWCapitalRegRepo.selectOneByPmBsSeq(new { PmBsSeq = pmBs.Seq });
                if (currentPmBsWCapitalReg.Ar > 0 && currentPmBsWCapital.AnnualSales > 0)
                {
                    currentPmBsWCapitalReg.ArToDays = (currentPmBsWCapitalReg.Ar / currentPmBsWCapital.AnnualSales) * 365;
                }
                if (currentPmBsWCapitalReg.Ap > 0 && currentPmBsWCapital.AnnualSalesCost > 0)
                {
                    currentPmBsWCapitalReg.ApToDays = (currentPmBsWCapitalReg.Ap / currentPmBsWCapital.AnnualSalesCost) * 365;
                }
                if (currentPmBsWCapitalReg.Inventory > 0 && currentPmBsWCapital.AnnualSalesCost > 0)
                {
                    currentPmBsWCapitalReg.InventoryToDays = (currentPmBsWCapitalReg.Inventory / currentPmBsWCapital.AnnualSalesCost) * 365;
                }

                pmBsSummary = new PmBsSummary();
                pmBsSummary.PmBsSeq = seq;
                pmBsSummary.Assets = currentPmBsBsheet.Assets;
                pmBsSummary.Liabilities = currentPmBsBsheet.Liabilities;
                pmBsSummary.Capital = currentPmBsBsheet.Capital;
                pmBsSummary.Cash = currentPmBsBsheet.Cash;
                pmBsSummary.Loan = currentPmBsBsheet.Loan;
                pmBsSummary.LiabilitiesRate = currentPmBsBsheet.LiabilitiesRate;

                pmBsSummary.AfterTaxOperationProfit = currentPmBsRoic.AfterTaxOperationProfit;
                pmBsSummary.PainInCapital = currentPmBsRoic.PainInCapital;
                pmBsSummary.Roic = currentPmBsRoic.Roic;

                pmBsSummary.Ar = currentPmBsWCapitalReg.Ar;
                pmBsSummary.ArToDays = currentPmBsWCapitalReg.ArToDays;
                pmBsSummary.Ap = currentPmBsWCapitalReg.Ap;
                pmBsSummary.ApToDays = currentPmBsWCapitalReg.ApToDays;
                pmBsSummary.Inventory = currentPmBsWCapitalReg.Inventory;
                pmBsSummary.InventoryToDays = currentPmBsWCapitalReg.InventoryToDays;


                if (pmBsSummaryRepo.save(pmBsSummary) == -1)
                {
                    TempData["alert"] = "BS 관리지표 생성 중 오류가 발생하였습니다.";
                }else
                {
                    TempData["alert"] = "정상적으로 처리되었습니다.";
                }
            }
            return Redirect("/SiteMngHome/Performance/Bs/Edit?seq=" + seq);
        }

        [HttpPost]
        [AcceptVerbs(HttpVerbs.Post), ValidateInput(false)]
        [Route("lastWriteAction")]
        public ActionResult lastWriteAction(int PmBsSeq, int RegistStatus, decimal pmAssets, decimal pmLiabilities, decimal pmCapital, decimal pmCash, decimal pmLoan, decimal pmAfterTaxOperationProfit, decimal pmPainInCapital, decimal pmAr, decimal pmArToDays, decimal pmAp, decimal pmApToDays, decimal pmInventory, decimal pmInventoryToDays
            , int seq, PmBsBsheet pmBsBsheet, PmBsRoic pmBsRoic, PmBsWCapital pmBsWcapital, PmBsWCapitalReg pmBsWCapitalReg)
        {

            bool flag = true;
            if (pmBsBsheetRepo.save(pmBsBsheet) == -1)
            {
                flag = false;
            }
            if (pmBsRoicRepo.save(pmBsRoic) == -1)
            {
                flag = false;
            }
            if (pmBsWCapitalRepo.save(pmBsWcapital) == -1)
            {
                flag = false;
            }
            if (pmBsWCapitalRegRepo.save(pmBsWCapitalReg) == -1)
            {
                flag = false;
            }

            if (!flag)
            {
                TempData["alert"] = "처리 중 오류가 발생하였습니다.";
                return Redirect("/SiteMngHome/Performance/Bs/Edit?seq=" + PmBsSeq);
            }


            PmBsSummary pmBsSummary = pmBsSummaryRepo.selectOneByPmBsSeq(new { PmBsSeq = PmBsSeq });
            pmBsSummary.Assets = pmAssets;
            pmBsSummary.Liabilities = pmLiabilities;
            pmBsSummary.Capital = pmCapital;
            pmBsSummary.Cash = pmCash;
            pmBsSummary.Loan = pmLoan;
            /////////////////////////////////////////// LiabilitiesRate
            if (pmBsSummary.Liabilities == 0 || pmBsSummary.Capital == 0)
            {
                pmBsSummary.LiabilitiesRate = 0;
            }
            else
            {
                pmBsSummary.LiabilitiesRate = Math.Round((pmBsSummary.Liabilities / pmBsSummary.Capital) * 100, 2, MidpointRounding.AwayFromZero);
            }

            pmBsSummary.AfterTaxOperationProfit = pmAfterTaxOperationProfit;
            pmBsSummary.PainInCapital = pmPainInCapital;
            /////////////////////////////////////////// Roic
            if (pmBsSummary.AfterTaxOperationProfit == 0 || pmBsSummary.PainInCapital == 0)
            {
                pmBsSummary.Roic = 0;
            }
            else
            {
                pmBsSummary.Roic = Math.Round((pmBsSummary.AfterTaxOperationProfit / pmBsSummary.PainInCapital) * 100, 2, MidpointRounding.AwayFromZero);
            }

            pmBsSummary.Ar = pmAr;
            pmBsSummary.ArToDays = pmArToDays;
            pmBsSummary.Ap = pmAp;
            pmBsSummary.ApToDays = pmApToDays;
            pmBsSummary.Inventory = pmInventory;
            pmBsSummary.InventoryToDays = pmInventoryToDays;

            if (pmBsSummaryRepo.save(pmBsSummary) == -1)
            {
                TempData["alert"] = "BS 관리지표 저장 중 오류가 발생하였습니다.";
            }else
            {
                TempData["alert"] = "정상적으로 저장되었습니다.";

                // 최종 저장처리 시 현재 STATUS 값을 기준으로 다음 STATUS 값으로 처리 되도록 함.
                // REGIST_STATUS 값이 1(미등록) 인 경우에 > 2(저장) 으로 변경 
                // 그 외 STATUS 값에 대해서는 STATUS 값 변경 X
                if (RegistStatus == Define.REGIST_STATUS.GetKey("미등록"))
                {
                    RegistStatus = Define.REGIST_STATUS.GetKey("저장");

                    pmBsRepo.updateRegistStatusByPmBsSeq(new { Seq = PmBsSeq, RegistStatus = RegistStatus, UserKey = SessionManager.GetAdminSession().insaUserV.userKey, EmpNo = SessionManager.GetAdminSession().insaUserV.empNo });
                }
            }

            return Redirect("/SiteMngHome/Performance/Bs/Edit?seq=" + PmBsSeq);
        }


        [HttpPost]
        [AcceptVerbs(HttpVerbs.Post), ValidateInput(false)]
        [Route("ConfirmAction")]
        public ActionResult ConfirmAction(int PmBsSeq, int RegistStatus)
        {

            if(RegistStatus == Define.REGIST_STATUS.GetKey("저장"))
            {
                // 저장 -> 승인대기
                RegistStatus = Define.REGIST_STATUS.GetKey("승인대기");
            }
            else if (RegistStatus == Define.REGIST_STATUS.GetKey("승인대기"))
            {
                // 승인대기 -> 1차승인
                RegistStatus = Define.REGIST_STATUS.GetKey("1차승인");
            }
            else if (RegistStatus == Define.REGIST_STATUS.GetKey("1차승인"))
            {
                // 1차 승인 -> 최종승인
                RegistStatus = Define.REGIST_STATUS.GetKey("최종승인");
            }

            if (RegistStatus == Define.REGIST_STATUS.GetKey("1차반려")
                || RegistStatus == Define.REGIST_STATUS.GetKey("2차반려"))
            {
                RegistStatus = Define.REGIST_STATUS.GetKey("승인대기");
            }
            
            if(pmBsRepo.updateRegistStatusByPmBsSeq(new { Seq = PmBsSeq, RegistStatus = RegistStatus, UserKey = SessionManager.GetAdminSession().insaUserV.userKey, EmpNo = SessionManager.GetAdminSession().insaUserV.empNo }) == -1)
            {
                TempData["alert"] = "요청 중 오류가 발생하였습니다.";
                return Redirect("List");
            }else
            {
                TempData["alert"] = "요청이 정상적으로 처리되었습니다.";
            }

            return Redirect("List");
        }


        [HttpPost]
        [AcceptVerbs(HttpVerbs.Post), ValidateInput(false)]
        [Route("RejectAction")]
        public ActionResult RejectAction(int PmBsSeq, int RegistStatus)
        {

            if (RegistStatus == Define.REGIST_STATUS.GetKey("승인대기"))
            {
                // 승인대기 -> 1차 반려
                RegistStatus = Define.REGIST_STATUS.GetKey("1차반려");
            }
            else if (RegistStatus == Define.REGIST_STATUS.GetKey("1차승인"))
            {
                // 1차승인 -> 2차 반려
                RegistStatus = Define.REGIST_STATUS.GetKey("2차반려");
            }

            if (pmBsRepo.updateRegistStatusByPmBsSeq(new { Seq = PmBsSeq, RegistStatus = RegistStatus, UserKey = SessionManager.GetAdminSession().insaUserV.userKey, EmpNo = SessionManager.GetAdminSession().insaUserV.empNo }) == -1)
            {
                TempData["alert"] = "요청 중 오류가 발생하였습니다.";
                return Redirect("List");
            }
            else
            {
                TempData["alert"] = "요청이 정상적으로 처리되었습니다.";
            }

            return Redirect("List");
        }
    }
}