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
    [RoutePrefix("SiteMngHome/Performance/Invest")]
    public class PmInvestController : SiteMngBaseController
    {
        [Route("List")]
        public ActionResult List(Search search)
        {
            var alert = TempData["alert"];
            if(alert != null)
            {
                TempData["alert"] = alert;
            }

            dynamic model = new ExpandoObject();
            search.AuthUserKey = SessionManager.GetAdminSession().insaUserV.userKey;
            model.list = pmInvestRepo.selectListExp(search);
            ViewBag.Search = search;
            return View("~/Views/SiteMngHome/Performance/Invest/List.cshtml", model);

            TempData.Remove("alert");
        }

        [Route("Write")]
        public ActionResult Write(PmInvest entity)
        {

            var alert = TempData["alert"];
            if (alert != null)
            {
                TempData["alert"] = alert;
            }
            dynamic model = new ExpandoObject();

            // 기본데이터 
            var pmInvest = pmInvestRepo.selectOne(entity);

            // 부문 > 회사 이름
            var orgCompany = orgCompanyRepo.selectOne(new { Seq = pmInvest.OrgCompanySeq });

            var orgBusiness = orgBusinessRepo.selectListCompany(new { Seq = orgCompany.Seq });

            /////////////////////////////////////////////////////////////
            // 0. 해당년도 실적 값이 있는 경우 - Edit 리다이렉트 처리 
            var currentPmInvestBusiness = pmInvestBusinessRepo.selectListByPmInvest(new { PmInvestSeq = pmInvest.Seq });
            if(currentPmInvestBusiness != null && currentPmInvestBusiness.Count() > 0)
            {
                return Redirect("/SiteMngHome/Performance/Invest/Edit?Seq=" + entity.Seq);
            }
            /////////////////////////////////////////////////////////////

            /////////////////////////////////////////////////////////////
            // 1. 전년도 연간 누계  -  12월 정보의 누계 
            var prevPmInvestBusinessByYearly = pmInvestBusinessRepo.selectListBefore(new { investYear = pmInvest.InvestYear, orgCompanySeq = orgCompany.Seq});
            if(prevPmInvestBusinessByYearly == null) { prevPmInvestBusinessByYearly = new List<PmInvestBusiness>(); }

            // 2. 전년도 당월 및 누계
            var prevPmInvestBusinessByMonthly = pmInvestBusinessRepo.selectListBeforeByMonthly(new { investYear = pmInvest.InvestYear, monthly = pmInvest.Monthly, orgCompanySeq = orgCompany.Seq });
            if (prevPmInvestBusinessByMonthly == null) { prevPmInvestBusinessByMonthly = new List<PmInvestBusiness>(); }

            // 3. 당해년도 연간 계획 정보
            var planYearInvestBusiness = planYearInvestBusinessRepo.selectListNowYear(new { yearInvestYear = pmInvest.InvestYear, orgCompanySeq = orgCompany.Seq});
            if(planYearInvestBusiness == null) { planYearInvestBusiness = new List<PlanYearInvestBusiness>(); }

            // 4. 당해년도 월별 계획 정보
            var planMonthlyInvestBusiness = planMonthlyInvestBusinessRepo.selectListNowMonthly(new { monthlyInvestYear = pmInvest.InvestYear, orgCompanySeq = orgCompany.Seq, monthly = pmInvest.Monthly});
            if (planMonthlyInvestBusiness == null) { planMonthlyInvestBusiness = new List<PlanMonthlyInvestBusiness>(); }

            // 5. 당해년도 누적 계획
            var planMonthlyInvestBusinessSummary = planMonthlyInvestBusinessRepo.selectListNowMonthlySummary(new { monthlyInvestYear = pmInvest.InvestYear, orgCompanySeq = orgCompany.Seq, monthly = pmInvest.Monthly });
            if (planMonthlyInvestBusinessSummary == null) { planMonthlyInvestBusinessSummary = new List<PlanMonthlyInvestBusiness>(); }

            // 뷰 전달 모델
            model.pmInvest = pmInvest;
            model.orgCompany = orgCompany;
            model.prevPmInvestBusinessByYearly = prevPmInvestBusinessByYearly;
            model.prevPmInvestBusinessByMonthly = prevPmInvestBusinessByMonthly;
            model.planYearInvestBusiness = planYearInvestBusiness;
            model.planMonthlyInvestBusiness = planMonthlyInvestBusiness;
            model.planMonthlyInvestBusinessSummary = planMonthlyInvestBusinessSummary;
            model.orgBusiness = orgBusiness;
            model.uploadedPmInvestBusiness = new List<PmInvestBusiness>();
            model.excel = "N";

            return View("~/Views/SiteMngHome/Performance/Invest/Write.cshtml", model);

            TempData.Remove("alert");
        }

        [Route("ExcelDownAction")]
        public ActionResult excelDownAction(PmInvest entity)
        {

            if (Request.RequestType == "GET") return RedirectToAction("List");

            // 기본데이터 
            var pmInvest = pmInvestRepo.selectOne(entity);

            // 부문 > 회사 이름
            var orgCompany = orgCompanyRepo.selectOne(new { Seq = pmInvest.OrgCompanySeq });
            var orgBusiness = orgBusinessRepo.selectListCompany(new { Seq = orgCompany.Seq });

            // 기 등록 데이터 가져오기
            var currentPmInvestBusiness = pmInvestBusinessRepo.selectListNow(new { investYear = pmInvest.InvestYear, monthly = pmInvest.Monthly, orgCompanySeq = orgCompany.Seq });

            string fileName = "PM_INVEST_" + pmInvest.InvestYear + "년_" + orgCompany.CompanyName;
            int rows = 1, cells = 1;

            int sheetSize = orgBusiness.Count();
            int idx = 0;

            var nowYear = pmInvest.InvestYear;
            var nowMonth = pmInvest.Monthly;

            using (XLWorkbook wb = new XLWorkbook())
            {
                foreach(var item in orgBusiness)
                {
                    rows = 1;
                    cells = 1;

                    var sheet = wb.Worksheets.Add(item.BusinessName);
                    sheet.Column(1).Hide();

                    sheet.Cell(rows, cells).SetValue("ORG_BUSINESS_SEQ").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    sheet.Cell(rows, ++cells).SetValue("년도").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    sheet.Cell(rows, ++cells).SetValue("월").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                    sheet.Cell(rows, ++cells).SetValue("당월_투자").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    sheet.Cell(rows, ++cells).SetValue("당월_인원").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    sheet.Cell(rows, ++cells).SetValue("당월_국내인원").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    sheet.Cell(rows, ++cells).SetValue("당월_해외인원").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                    sheet.Cell(rows, ++cells).SetValue("누계_투자").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    sheet.Cell(rows, ++cells).SetValue("누계_인원").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    sheet.Cell(rows, ++cells).SetValue("누계_국내인원").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    sheet.Cell(rows, ++cells).SetValue("누계_해외인원").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                    cells = 1;
                    rows = rows + 1;

                    var list = currentPmInvestBusiness.Where(x => x.OrgBusinessSeq == item.Seq).ToList();
                    if(list != null && list.Count() > 0)
                    {
                        sheet.Cell(rows, cells).SetValue(item.Seq).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                        sheet.Cell(rows, ++cells).SetValue(nowYear).Style.Fill.SetBackgroundColor(XLColor.White).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                        sheet.Cell(rows, ++cells).SetValue(nowMonth).Style.Fill.SetBackgroundColor(XLColor.White).Border.SetOutsideBorder(XLBorderStyleValues.Thin);


                        sheet.Cell(rows, ++cells).SetValue(list.Where(x => x.MonthlyType == Define.MONTHLY_TYPE.GetKey("당월")).FirstOrDefault().Investment).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                        sheet.Cell(rows, ++cells).SetValue(list.Where(x => x.MonthlyType == Define.MONTHLY_TYPE.GetKey("당월")).FirstOrDefault().Personnel).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                        sheet.Cell(rows, ++cells).SetValue(list.Where(x => x.MonthlyType == Define.MONTHLY_TYPE.GetKey("당월")).FirstOrDefault().DomesticPersonnel).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                        sheet.Cell(rows, ++cells).SetValue(list.Where(x => x.MonthlyType == Define.MONTHLY_TYPE.GetKey("당월")).FirstOrDefault().OverseasPersonnel).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                        sheet.Cell(rows, ++cells).SetValue(list.Where(x => x.MonthlyType == Define.MONTHLY_TYPE.GetKey("누계")).FirstOrDefault().Investment).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                        sheet.Cell(rows, ++cells).SetValue(list.Where(x => x.MonthlyType == Define.MONTHLY_TYPE.GetKey("누계")).FirstOrDefault().Personnel).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                        sheet.Cell(rows, ++cells).SetValue(list.Where(x => x.MonthlyType == Define.MONTHLY_TYPE.GetKey("누계")).FirstOrDefault().DomesticPersonnel).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                        sheet.Cell(rows, ++cells).SetValue(list.Where(x => x.MonthlyType == Define.MONTHLY_TYPE.GetKey("누계")).FirstOrDefault().OverseasPersonnel).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    }
                    else
                    {
                        sheet.Cell(rows, cells).SetValue(item.Seq).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                        sheet.Cell(rows, ++cells).SetValue(nowYear).Style.Fill.SetBackgroundColor(XLColor.White).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                        sheet.Cell(rows, ++cells).SetValue(nowMonth).Style.Fill.SetBackgroundColor(XLColor.White).Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                        sheet.Cell(rows, ++cells).SetValue("0.00").Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                        sheet.Cell(rows, ++cells).SetValue("0.00").Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                        sheet.Cell(rows, ++cells).SetValue("0.00").Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                        sheet.Cell(rows, ++cells).SetValue("0.00").Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                        sheet.Cell(rows, ++cells).SetValue("0.00").Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                        sheet.Cell(rows, ++cells).SetValue("0.00").Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                        sheet.Cell(rows, ++cells).SetValue("0.00").Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                        sheet.Cell(rows, ++cells).SetValue("0.00").Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    }
                    
                }

                using (MemoryStream mStream = new MemoryStream())
                {
                    wb.SaveAs(mStream);
                    return File(mStream.ToArray(), "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", fileName + ".xlsx");
                }
            }
        }
        [Route("ExcelUploadAction")]
        public ActionResult excelUploadAction(PmInvest entity, HttpPostedFileBase ExcelFile, string isEdit)
        {
            TempData["alert"] = "업로드되었습니다.";
            dynamic model = new ExpandoObject();

            // 기본데이터 
            var pmInvest = pmInvestRepo.selectOne(entity);

            // 부문 > 회사 이름
            var orgCompany = orgCompanyRepo.selectOne(new { Seq = pmInvest.OrgCompanySeq });
            var orgBusiness = orgBusinessRepo.selectListCompany(new { Seq = orgCompany.Seq });


            // 엑셀파일 처리 부 
            bool result = true;
            string resultMsg = "";

            if(ExcelFile.ContentLength != 0)
            {

                model.uploadedPmInvestBusiness = new List<PmInvestBusiness>(); ;
                FileUtil fileUtil = new FileUtil(Define.FILE_PATH);
                string filePath = "pmInvest";
                var file = fileUtil.FileUpload(ExcelFile, filePath);

                bool bDoubleValue = true;
                ExcelUtil excelUtil = new ExcelUtil();
                var ds = excelUtil.ImportExcelDs(file["FILE_PATH"]);
                try
                {
                    var sheetAvailableFlag = true;
                    foreach(var item in orgBusiness)
                    {
                        if(ds.Tables[item.BusinessName] == null || ds.Tables[item.BusinessName].Rows.Count == 0)
                        {
                            sheetAvailableFlag = false;
                        }
                    }

                    if (!sheetAvailableFlag)
                    {
                        // 오류시 파일 삭제
                        fileUtil.FileDelete(filePath, file["STORED_FILE_NAME"]);
                        result = false;
                        resultMsg = "엑셀 데이터에 오류가 있습니다.\\n확인 후 다시 업로드해주세요";
                    }
                    else
                    {
                        // 정상적인 엑셀 양식이라고 판단.
                        List<PmInvestBusiness> list = new List<PmInvestBusiness>();
                        foreach(var item in orgBusiness)
                        {
                            PmInvestBusiness info = new PmInvestBusiness();
                            info.PmInvestSeq = pmInvest.Seq;
                            info.OrgBusinessSeq = item.Seq;

                            list.Add(info);
                        }

                        int rowCnt = 1;
                        foreach(var item in orgBusiness)
                        {
                            rowCnt = 1;
                            foreach (DataRow dr in ds.Tables[item.BusinessName].Rows)
                            {
                                if(rowCnt < 2)
                                {
                                    int orgBusinessSeq = Convert.ToInt32(dr.ItemArray.GetValue(0));
                                    string investment = dr.ItemArray.GetValue(3).ToString();
                                    string personnel = dr.ItemArray.GetValue(4).ToString();
                                    string domesticPersonnel = dr.ItemArray.GetValue(5).ToString();
                                    string overseasPersonnel = dr.ItemArray.GetValue(6).ToString();
                                    string investmentExp = dr.ItemArray.GetValue(7).ToString();
                                    string personnelExp = dr.ItemArray.GetValue(8).ToString();
                                    string domesticPersonnelExp = dr.ItemArray.GetValue(9).ToString();
                                    string overseasPersonnelExp = dr.ItemArray.GetValue(10).ToString();

                                    if (!WebUtil.CheckDecimalTwo(investment)) { bDoubleValue = false; break; }
                                    if (!WebUtil.CheckDecimalTwo(personnel)) { bDoubleValue = false; break; }
                                    if (!WebUtil.CheckDecimalTwo(domesticPersonnel)) { bDoubleValue = false; break; }
                                    if (!WebUtil.CheckDecimalTwo(overseasPersonnel)) { bDoubleValue = false; break; }
                                    if (!WebUtil.CheckDecimalTwo(investmentExp)) { bDoubleValue = false; break; }
                                    if (!WebUtil.CheckDecimalTwo(personnelExp)) { bDoubleValue = false; break; }
                                    if (!WebUtil.CheckDecimalTwo(domesticPersonnelExp)) { bDoubleValue = false; break; }
                                    if (!WebUtil.CheckDecimalTwo(overseasPersonnelExp)) { bDoubleValue = false; break; }

                                    list.Where(x => x.OrgBusinessSeq == orgBusinessSeq).FirstOrDefault().Investment = Convert.ToDecimal(investment);
                                    list.Where(x => x.OrgBusinessSeq == orgBusinessSeq).FirstOrDefault().Personnel = Convert.ToDecimal(personnel);
                                    list.Where(x => x.OrgBusinessSeq == orgBusinessSeq).FirstOrDefault().DomesticPersonnel = Convert.ToDecimal(domesticPersonnel);
                                    list.Where(x => x.OrgBusinessSeq == orgBusinessSeq).FirstOrDefault().OverseasPersonnel = Convert.ToDecimal(overseasPersonnel);
                                    list.Where(x => x.OrgBusinessSeq == orgBusinessSeq).FirstOrDefault().InvestmentExp = Convert.ToDecimal(investmentExp);
                                    list.Where(x => x.OrgBusinessSeq == orgBusinessSeq).FirstOrDefault().PersonnelExp = Convert.ToDecimal(personnelExp);
                                    list.Where(x => x.OrgBusinessSeq == orgBusinessSeq).FirstOrDefault().DomesticPersonnelExp = Convert.ToDecimal(domesticPersonnelExp);
                                    list.Where(x => x.OrgBusinessSeq == orgBusinessSeq).FirstOrDefault().OverseasPersonnelExp = Convert.ToDecimal(overseasPersonnelExp);

                                    rowCnt++;
                                }
                                
                            }
                        }

                        if (!bDoubleValue)
                        {
                            // 오류시 파일 삭제
                            fileUtil.FileDelete(filePath, file["STORED_FILE_NAME"]);
                            result = false;
                            resultMsg = "엑셀 데이터에 오류가 있습니다.\\n확인 후 다시 업로드해주세요";
                        }

                        model.uploadedPmInvestBusiness = list;
                    }
                }
                catch(Exception e)
                {
                    fileUtil.FileDelete(filePath, file["STORED_FILE_NAME"]);
                    LogUtil.MngError(e.ToString());
                    result = false;
                    resultMsg = "엑셀 데이터에 오류가 있습니다.\\n확인 후 다시 업로드해주세요";

                    model.uploadedPmInvestBusiness = new List<PmInvestBusiness>(); ;
                }
            }

            if (!result)
            {
                TempData["alert"] = resultMsg;
            }else
            {
                TempData["alert"] = "업로드되었습니다.";
            }

            /////////////////////////////////////////////////////////////
            // 1. 전년도 연간 누계  -  12월 정보의 누계 
            var prevPmInvestBusinessByYearly = pmInvestBusinessRepo.selectListBefore(new { investYear = pmInvest.InvestYear, orgCompanySeq = orgCompany.Seq });
            if (prevPmInvestBusinessByYearly == null) { prevPmInvestBusinessByYearly = new List<PmInvestBusiness>(); }

            // 2. 전년도 당월 및 누계
            var prevPmInvestBusinessByMonthly = pmInvestBusinessRepo.selectListBeforeByMonthly(new { investYear = pmInvest.InvestYear, monthly = pmInvest.Monthly, orgCompanySeq = orgCompany.Seq });
            if (prevPmInvestBusinessByMonthly == null) { prevPmInvestBusinessByMonthly = new List<PmInvestBusiness>(); }

            // 3. 당해년도 연간 계획 정보
            var planYearInvestBusiness = planYearInvestBusinessRepo.selectListNowYear(new { yearInvestYear = pmInvest.InvestYear, orgCompanySeq = orgCompany.Seq });
            if (planYearInvestBusiness == null) { planYearInvestBusiness = new List<PlanYearInvestBusiness>(); }

            // 4. 당해년도 월별 계획 정보
            var planMonthlyInvestBusiness = planMonthlyInvestBusinessRepo.selectListNowMonthly(new { monthlyInvestYear = pmInvest.InvestYear, orgCompanySeq = orgCompany.Seq, monthly = pmInvest.Monthly });
            if (planMonthlyInvestBusiness == null) { planMonthlyInvestBusiness = new List<PlanMonthlyInvestBusiness>(); }

            // 5. 당해년도 누적 계획
            var planMonthlyInvestBusinessSummary = planMonthlyInvestBusinessRepo.selectListNowMonthlySummary(new { monthlyInvestYear = pmInvest.InvestYear, orgCompanySeq = orgCompany.Seq, monthly = pmInvest.Monthly });
            if (planMonthlyInvestBusinessSummary == null) { planMonthlyInvestBusinessSummary = new List<PlanMonthlyInvestBusiness>(); }

            //////////////////////////////////////////////////////////
            // 1. 현재년도 실적 정보
            var currentPmInvestBusiness = pmInvestBusinessRepo.selectListNow(new { investYear = pmInvest.InvestYear, monthly = pmInvest.Monthly, orgCompanySeq = orgCompany.Seq });

            
            // 뷰 전달 모델
            model.pmInvest = pmInvest;
            model.orgCompany = orgCompany;
            model.prevPmInvestBusinessByYearly = prevPmInvestBusinessByYearly;
            model.prevPmInvestBusinessByMonthly = prevPmInvestBusinessByMonthly;
            model.planYearInvestBusiness = planYearInvestBusiness;
            model.planMonthlyInvestBusiness = planMonthlyInvestBusiness;
            model.planMonthlyInvestBusinessSummary = planMonthlyInvestBusinessSummary;
            model.orgBusiness = orgBusiness;
            model.currentPmInvestBusiness = currentPmInvestBusiness;
            model.excel = "Y";

            if (isEdit.Equals("Y"))
            {

                // 투자, 인원 요약 정보 데이터 추가 조회 
                /////////////////////////////////////////////////////////
                // 투자, 인원 요약 정보 데이터 추가 조회 
                // 1. 전년도 연간 
                // 2. 전년도 XX월 당월
                // 3. 전년도 XX월 누계
                var prevInfoBaseList = pmInvestSumRepo.selectListByPrevInfoBaseList(new { InvestYear = pmInvest.InvestYear, orgCompanySeq = orgCompany.Seq });
                var prevYearlyInfo = prevInfoBaseList.Where(x => x.Monthly == "12" && x.MonthlyType == Define.MONTHLY_TYPE.GetKey("누계")).FirstOrDefault();
                if(prevYearlyInfo == null) { prevYearlyInfo = new PmInvestSum(); }
                var prevMonthlyInfo = prevInfoBaseList.Where(x => x.Monthly == pmInvest.Monthly && x.MonthlyType == Define.MONTHLY_TYPE.GetKey("당월")).FirstOrDefault();
                if (prevMonthlyInfo == null) { prevMonthlyInfo = new PmInvestSum(); }
                var prevMonthlyInfoSummary = prevInfoBaseList.Where(x => x.Monthly == pmInvest.Monthly && x.MonthlyType == Define.MONTHLY_TYPE.GetKey("누계")).FirstOrDefault();
                if (prevMonthlyInfoSummary == null) { prevMonthlyInfoSummary = new PmInvestSum(); }

                // 4. 해당년 연간 계획
                var planYearInvestSummary = planYearInvestSummaryRepo.selectListNowYear(new { YearInvestYear = pmInvest.InvestYear, YearlyYear = pmInvest.InvestYear, OrgCompanySeq = orgCompany.Seq });
                if(planYearInvestSummary == null) { planYearInvestSummary = new PlanYearInvestSummary(); }

                // 5. 해당년 XX월 계획 (당월/누계)
                //    = 계획에는 당월/누계 구분이 없으므로 특정 1월부터 특정월까지 합으로 누계값을 구한다.
                var currentYearlyPlanInfo = planMonthlyInvestSummaryRepo.selectOneNowYear(new { MonthlyInvestYear = pmInvest.InvestYear, Monthly = pmInvest.Monthly, OrgCompanySeq = orgCompany.Seq });
                if(currentYearlyPlanInfo == null) { currentYearlyPlanInfo = new PlanMonthlyInvestSummaryExp(); }
                var currentMonthlyPlanInfo = planMonthlyInvestSummaryRepo.selectOneNowMonth(new { MonthlyInvestYear = pmInvest.InvestYear, Monthly = pmInvest.Monthly, OrgCompanySeq = orgCompany.Seq });
                if (currentMonthlyPlanInfo == null) { currentMonthlyPlanInfo = new PlanMonthlyInvestSummaryExp(); }

                // 6. 해당년 XX월 실적 (당월/누계)
                //    = currentPmInvestBusiness
                var currentPmInvestSum = pmInvestSumRepo.selectListNowYear(new { InvestYear = pmInvest.InvestYear, Monthly = pmInvest.Monthly, OrgCompanySeq = orgCompany.Seq });
                if(currentPmInvestSum == null) { currentPmInvestSum = new List<PmInvestSum>(); }

                model.prevYearlyInfo = prevYearlyInfo;
                model.prevMonthlyInfo = prevMonthlyInfo;
                model.prevMonthlyInfoSummary = prevMonthlyInfoSummary;
                model.planYearInvestSummary = planYearInvestSummary;
                model.currentYearlyPlanInfo = currentYearlyPlanInfo;
                model.currentMonthlyPlanInfo = currentMonthlyPlanInfo;
                model.currentPmInvestSum = currentPmInvestSum;

                return View("~/Views/SiteMngHome/Performance/Invest/Edit.cshtml", model);

                TempData.Remove("alert");
            }
            else
            {
                return View("~/Views/SiteMngHome/Performance/Invest/Write.cshtml", model);

                TempData.Remove("alert");
            }
        }

        [Route("WriteAction")]
        public ActionResult WriteAction(int PmInvestSeq, PmInvestBusiness[] pmInvestBusiness)
        {
            
            if(pmInvestBusiness == null)
            {
                TempData["alert"] = "처리 중 오류가 발생하였습니다.";
                return Redirect("List");
            }else
            {
                foreach(var item in pmInvestBusiness)
                {
                    // 당월 실적 처리
                    PmInvestBusiness info = new PmInvestBusiness();
                    info.PmInvestSeq = PmInvestSeq;
                    info.OrgBusinessSeq = item.OrgBusinessSeq;
                    info.MonthlyType = Define.MONTHLY_TYPE.GetKey("당월");
                    info.Investment = item.Investment;
                    info.Personnel = item.Personnel;
                    info.DomesticPersonnel = item.DomesticPersonnel;
                    info.OverseasPersonnel = item.OverseasPersonnel;

                    pmInvestBusinessRepo.saveByPmInvest(info);

                    // 누계 실적 처리
                    info.MonthlyType = Define.MONTHLY_TYPE.GetKey("누계");
                    info.Investment = item.InvestmentExp;
                    info.Personnel = item.PersonnelExp;
                    info.DomesticPersonnel = item.DomesticPersonnelExp;
                    info.OverseasPersonnel = item.OverseasPersonnelExp;

                    pmInvestBusinessRepo.saveByPmInvest(info);
                }
            }

            // PM_INVEST_SUM 데이터 저장 처리
            var pmInvest = pmInvestRepo.selectOne(new { Seq = PmInvestSeq });
            var orgCompany = orgCompanyRepo.selectOne(new { Seq = pmInvest.OrgCompanySeq });
            var orgBusiness = orgBusinessRepo.selectListCompany(new { Seq = orgCompany.Seq });
            var currentPmInvestBusiness = pmInvestBusinessRepo.selectListNowBySummary(new { investYear = pmInvest.InvestYear, monthly = pmInvest.Monthly, orgCompanySeq = orgCompany.Seq });

            int rtn = 0;
            var currentPmInvestBusinessMonthly = currentPmInvestBusiness.Where(x => x.MonthlyType == Define.MONTHLY_TYPE.GetKey("당월")).FirstOrDefault();
            PmInvestSum pmInvestSum = new PmInvestSum();
            pmInvestSum.PmInvestSeq = pmInvest.Seq;
            pmInvestSum.MonthlyType = Define.MONTHLY_TYPE.GetKey("당월");
            pmInvestSum.Investment = currentPmInvestBusinessMonthly.Investment;
            pmInvestSum.Personnel = currentPmInvestBusinessMonthly.Personnel;
            pmInvestSum.DomesticPersonnel = currentPmInvestBusinessMonthly.DomesticPersonnel;
            pmInvestSum.OverseasPersonnel = currentPmInvestBusinessMonthly.OverseasPersonnel;
            rtn = pmInvestSumRepo.saveByPmInvest(pmInvestSum);
            if(rtn == -1)
            {
                TempData["alert"] = "처리 중 오류가 발생하였습니다.";
                return Redirect("List");
            }
            var currentPmInvestBusinessSummary = currentPmInvestBusiness.Where(x => x.MonthlyType == Define.MONTHLY_TYPE.GetKey("누계")).FirstOrDefault();
            pmInvestSum = new PmInvestSum();
            pmInvestSum.PmInvestSeq = pmInvest.Seq;
            pmInvestSum.MonthlyType = Define.MONTHLY_TYPE.GetKey("누계");
            pmInvestSum.Investment = currentPmInvestBusinessSummary.Investment;
            pmInvestSum.Personnel = currentPmInvestBusinessSummary.Personnel;
            pmInvestSum.DomesticPersonnel = currentPmInvestBusinessSummary.DomesticPersonnel;
            pmInvestSum.OverseasPersonnel = currentPmInvestBusinessSummary.OverseasPersonnel;
            rtn = pmInvestSumRepo.saveByPmInvest(pmInvestSum);
            if (rtn == -1)
            {
                TempData["alert"] = "처리 중 오류가 발생하였습니다.";
                return Redirect("List");
            }

            TempData["alert"] = "정상적으로 처리되었습니다.";

            return Redirect("/SiteMngHome/Performance/Invest/Edit?Seq="+PmInvestSeq);
        }

        [Route("EditAction")]
        public ActionResult EditAction(int PmInvestSeq, PmInvestBusiness[] pmInvestBusiness)
        {

            if (pmInvestBusiness == null)
            {
                TempData["alert"] = "처리 중 오류가 발생하였습니다.";
                return Redirect("List");
            }
            else
            {
                foreach (var item in pmInvestBusiness)
                {

                    bool bDoubleValue = true;
                    if (!WebUtil.CheckDecimalTwo(item.Investment.ToString())) { bDoubleValue = false; }
                    if (!WebUtil.CheckDecimalTwo(item.Personnel.ToString())) { bDoubleValue = false; }
                    if (!WebUtil.CheckDecimalTwo(item.DomesticPersonnel.ToString())) { bDoubleValue = false; }
                    if (!WebUtil.CheckDecimalTwo(item.OverseasPersonnel.ToString())) { bDoubleValue = false; }
                    if (!WebUtil.CheckDecimalTwo(item.InvestmentExp.ToString())) { bDoubleValue = false; }
                    if (!WebUtil.CheckDecimalTwo(item.PersonnelExp.ToString())) { bDoubleValue = false; }
                    if (!WebUtil.CheckDecimalTwo(item.DomesticPersonnelExp.ToString())) { bDoubleValue = false; }
                    if (!WebUtil.CheckDecimalTwo(item.OverseasPersonnelExp.ToString())) { bDoubleValue = false; }

                    if (!bDoubleValue)
                    {
                        TempData["alert"] = "데이터에 오류가 있습니다. 정확한 값을 입력해주세요.";
                        return Redirect("/SiteMngHome/Performance/Invest/Edit?Seq=" + PmInvestSeq);
                    }

                    // 당월 실적 처리
                    PmInvestBusiness info = new PmInvestBusiness();
                    info.PmInvestSeq = PmInvestSeq;
                    info.OrgBusinessSeq = item.OrgBusinessSeq;
                    info.MonthlyType = Define.MONTHLY_TYPE.GetKey("당월");
                    info.Investment = item.Investment;
                    info.Personnel = item.Personnel;
                    info.DomesticPersonnel = item.DomesticPersonnel;
                    info.OverseasPersonnel = item.OverseasPersonnel;

                    pmInvestBusinessRepo.saveByPmInvest(info);

                    // 누계 실적 처리
                    info.MonthlyType = Define.MONTHLY_TYPE.GetKey("누계");
                    info.Investment = item.InvestmentExp;
                    info.Personnel = item.PersonnelExp;
                    info.DomesticPersonnel = item.DomesticPersonnelExp;
                    info.OverseasPersonnel = item.OverseasPersonnelExp;

                    pmInvestBusinessRepo.saveByPmInvest(info);
                }

                // PM_INVEST_SUM 데이터 저장 처리
                var pmInvest = pmInvestRepo.selectOne(new { Seq = PmInvestSeq });
                var orgCompany = orgCompanyRepo.selectOne(new { Seq = pmInvest.OrgCompanySeq });
                var orgBusiness = orgBusinessRepo.selectListCompany(new { Seq = orgCompany.Seq });
                var currentPmInvestBusiness = pmInvestBusinessRepo.selectListNowBySummary(new { investYear = pmInvest.InvestYear, monthly = pmInvest.Monthly, orgCompanySeq = orgCompany.Seq });

                int rtn = 0;
                var currentPmInvestBusinessMonthly = currentPmInvestBusiness.Where(x => x.MonthlyType == Define.MONTHLY_TYPE.GetKey("당월")).FirstOrDefault();
                PmInvestSum pmInvestSum = new PmInvestSum();
                pmInvestSum.PmInvestSeq = pmInvest.Seq;
                pmInvestSum.MonthlyType = Define.MONTHLY_TYPE.GetKey("당월");
                pmInvestSum.Investment = currentPmInvestBusinessMonthly.Investment;
                pmInvestSum.Personnel = currentPmInvestBusinessMonthly.Personnel;
                pmInvestSum.DomesticPersonnel = currentPmInvestBusinessMonthly.DomesticPersonnel;
                pmInvestSum.OverseasPersonnel = currentPmInvestBusinessMonthly.OverseasPersonnel;
                rtn = pmInvestSumRepo.saveByPmInvest(pmInvestSum);
                if(rtn == -1)
                {
                    TempData["alert"] = "처리 중 오류가 발생하였습니다.";
                    return Redirect("List");
                }
                var currentPmInvestBusinessSummary = currentPmInvestBusiness.Where(x => x.MonthlyType == Define.MONTHLY_TYPE.GetKey("누계")).FirstOrDefault();
                pmInvestSum = new PmInvestSum();
                pmInvestSum.PmInvestSeq = pmInvest.Seq;
                pmInvestSum.MonthlyType = Define.MONTHLY_TYPE.GetKey("누계");
                pmInvestSum.Investment = currentPmInvestBusinessSummary.Investment;
                pmInvestSum.Personnel = currentPmInvestBusinessSummary.Personnel;
                pmInvestSum.DomesticPersonnel = currentPmInvestBusinessSummary.DomesticPersonnel;
                pmInvestSum.OverseasPersonnel = currentPmInvestBusinessSummary.OverseasPersonnel;
                rtn = pmInvestSumRepo.saveByPmInvest(pmInvestSum);
                if(rtn == -1)
                {
                    TempData["alert"] = "처리 중 오류가 발생하였습니다.";
                    return Redirect("List");
                }

                TempData["alert"] = "정상적으로 처리되었습니다.";
            }

            return Redirect("/SiteMngHome/Performance/Invest/Edit?Seq=" + PmInvestSeq);
        }

        [Route("LastEditAction")]
        public ActionResult lastEditAction(int PmInvestSeq, int RegistStatus, string sumInvestment, string sumInvestmentExp, string sumPersonnel, string sumPersonnelExp, string sumDomesticPersonnel, string sumDomesticPersonnelExp, string sumOverseasPersonnel, string sumOverseasPersonnelExp, PmInvestBusiness[] pmInvestBusiness)
        {

            // 상단 추가 처리


            if (pmInvestBusiness == null)
            {
                TempData["alert"] = "처리 중 오류가 발생하였습니다.";
                return Redirect("List");
            }
            else
            {
                foreach (var item in pmInvestBusiness)
                {
                    bool bdv = true;
                    if (!WebUtil.CheckDecimalTwo(item.Investment.ToString())) { bdv = false; }
                    if (!WebUtil.CheckDecimalTwo(item.Personnel.ToString())) { bdv = false; }
                    if (!WebUtil.CheckDecimalTwo(item.DomesticPersonnel.ToString())) { bdv = false; }
                    if (!WebUtil.CheckDecimalTwo(item.OverseasPersonnel.ToString())) { bdv = false; }
                    if (!WebUtil.CheckDecimalTwo(item.InvestmentExp.ToString())) { bdv = false; }
                    if (!WebUtil.CheckDecimalTwo(item.PersonnelExp.ToString())) { bdv = false; }
                    if (!WebUtil.CheckDecimalTwo(item.DomesticPersonnelExp.ToString())) { bdv = false; }
                    if (!WebUtil.CheckDecimalTwo(item.OverseasPersonnelExp.ToString())) { bdv = false; }

                    if (!bdv)
                    {
                        TempData["alert"] = "데이터에 오류가 있습니다. 정확한 값을 입력해주세요.";
                        return Redirect("/SiteMngHome/Performance/Invest/Edit?Seq=" + PmInvestSeq);
                    }

                    // 당월 실적 처리
                    PmInvestBusiness info = new PmInvestBusiness();
                    info.PmInvestSeq = PmInvestSeq;
                    info.OrgBusinessSeq = item.OrgBusinessSeq;
                    info.MonthlyType = Define.MONTHLY_TYPE.GetKey("당월");
                    info.Investment = item.Investment;
                    info.Personnel = item.Personnel;
                    info.DomesticPersonnel = item.DomesticPersonnel;
                    info.OverseasPersonnel = item.OverseasPersonnel;

                    pmInvestBusinessRepo.saveByPmInvest(info);

                    // 누계 실적 처리
                    info.MonthlyType = Define.MONTHLY_TYPE.GetKey("누계");
                    info.Investment = item.InvestmentExp;
                    info.Personnel = item.PersonnelExp;
                    info.DomesticPersonnel = item.DomesticPersonnelExp;
                    info.OverseasPersonnel = item.OverseasPersonnelExp;

                    pmInvestBusinessRepo.saveByPmInvest(info);
                }
                TempData["alert"] = "정상적으로 처리되었습니다.";
            }

            // 원래 lastEditAction 처리
            bool bDoubleValue = true;
            if (!WebUtil.CheckDecimalTwo(sumInvestment)) { bDoubleValue = false; }
            if (!WebUtil.CheckDecimalTwo(sumPersonnel)) { bDoubleValue = false; }
            if (!WebUtil.CheckDecimalTwo(sumDomesticPersonnel)) { bDoubleValue = false; }
            if (!WebUtil.CheckDecimalTwo(sumOverseasPersonnel)) { bDoubleValue = false; }
            if (!WebUtil.CheckDecimalTwo(sumInvestmentExp)) { bDoubleValue = false; }
            if (!WebUtil.CheckDecimalTwo(sumPersonnelExp)) { bDoubleValue = false; }
            if (!WebUtil.CheckDecimalTwo(sumDomesticPersonnelExp)) { bDoubleValue = false; }
            if (!WebUtil.CheckDecimalTwo(sumOverseasPersonnelExp)) { bDoubleValue = false; }

            if (!bDoubleValue)
            {
                TempData["alert"] = "데이터에 오류가 있습니다. 정확한 값을 입력해주세요.";
                return Redirect("/SiteMngHome/Performance/Invest/Edit?Seq=" + PmInvestSeq);
            }

            int rtn = 0;
            PmInvestSum pmInvestSum = new PmInvestSum();
            pmInvestSum.PmInvestSeq = PmInvestSeq;
            pmInvestSum.MonthlyType = Define.MONTHLY_TYPE.GetKey("당월");
            pmInvestSum.Investment = Convert.ToDecimal(sumInvestment);
            pmInvestSum.Personnel = Convert.ToDecimal(sumPersonnel);
            pmInvestSum.DomesticPersonnel = Convert.ToDecimal(sumDomesticPersonnel);
            pmInvestSum.OverseasPersonnel = Convert.ToDecimal(sumOverseasPersonnel);
            rtn = pmInvestSumRepo.saveByPmInvest(pmInvestSum);
            if(rtn == -1)
            {
                TempData["alert"] = "처리중 오류가 발생하였습니다.";
                return Redirect("List");
            }

            pmInvestSum = new PmInvestSum();
            pmInvestSum.PmInvestSeq = PmInvestSeq;
            pmInvestSum.MonthlyType = Define.MONTHLY_TYPE.GetKey("누계");
            pmInvestSum.Investment = Convert.ToDecimal(sumInvestmentExp);
            pmInvestSum.Personnel = Convert.ToDecimal(sumPersonnelExp);
            pmInvestSum.DomesticPersonnel = Convert.ToDecimal(sumDomesticPersonnelExp);
            pmInvestSum.OverseasPersonnel = Convert.ToDecimal(sumOverseasPersonnelExp);
            rtn = pmInvestSumRepo.saveByPmInvest(pmInvestSum);
            if(rtn == -1)
            {
                TempData["alert"] = "처리중 오류가 발생하였습니다.";
                return Redirect("List");
            }

            TempData["alert"] = "정상적으로 처리 되었습니다.";


            // 현재 STATUS 값에 의해 단계 처리 진행 필요
            if (RegistStatus == Define.REGIST_STATUS.GetKey("미등록"))
            {
                RegistStatus = Define.REGIST_STATUS.GetKey("저장");
                pmInvestRepo.updateRegistStatusByPmInvestSeq(new { Seq = PmInvestSeq, RegistStatus = RegistStatus, UserKey = SessionManager.GetAdminSession().insaUserV.userKey, EmpNo = SessionManager.GetAdminSession().insaUserV.empNo });
            }

            return Redirect("/SiteMngHome/Performance/Invest/Edit?Seq=" + PmInvestSeq);
        }

        [Route("View")]
        public ActionResult view(PmInvest entity)
        {

            var alert = TempData["alert"];
            if (alert != null)
            {
                TempData["alert"] = alert;
            }
            dynamic model = new ExpandoObject();

            // 기본데이터 
            var pmInvest = pmInvestRepo.selectOne(entity);

            // 부문 > 회사 이름
            var orgCompany = orgCompanyRepo.selectOne(new { Seq = pmInvest.OrgCompanySeq });

            //var orgBusiness = orgBusinessRepo.selectListCompany(new { Seq = orgCompany.Seq });
            var orgBusiness = orgBusinessRepo.selectListAll(new { orgCompanySeq = orgCompany.Seq });


            /////////////////////////////////////////////////////////////
            // 1. 전년도 연간 누계  -  12월 정보의 누계 
            var prevPmInvestBusinessByYearly = pmInvestBusinessRepo.selectListBefore(new { investYear = pmInvest.InvestYear, orgCompanySeq = orgCompany.Seq });
            if (prevPmInvestBusinessByYearly == null) { prevPmInvestBusinessByYearly = new List<PmInvestBusiness>(); }

            // 2. 전년도 당월 및 누계
            var prevPmInvestBusinessByMonthly = pmInvestBusinessRepo.selectListBeforeByMonthly(new { investYear = pmInvest.InvestYear, monthly = pmInvest.Monthly, orgCompanySeq = orgCompany.Seq });
            if (prevPmInvestBusinessByMonthly == null) { prevPmInvestBusinessByMonthly = new List<PmInvestBusiness>(); }

            // 3. 당해년도 연간 계획 정보
            var planYearInvestBusiness = planYearInvestBusinessRepo.selectListNowYear(new { yearInvestYear = pmInvest.InvestYear, orgCompanySeq = orgCompany.Seq });
            if (planYearInvestBusiness == null) { planYearInvestBusiness = new List<PlanYearInvestBusiness>(); }

            // 4. 당해년도 월별 계획 정보
            var planMonthlyInvestBusiness = planMonthlyInvestBusinessRepo.selectListNowMonthly(new { monthlyInvestYear = pmInvest.InvestYear, orgCompanySeq = orgCompany.Seq, monthly = pmInvest.Monthly });
            if (planMonthlyInvestBusiness == null) { planMonthlyInvestBusiness = new List<PlanMonthlyInvestBusiness>(); }

            // 5. 당해년도 누적 계획
            var planMonthlyInvestBusinessSummary = planMonthlyInvestBusinessRepo.selectListNowMonthlySummary(new { monthlyInvestYear = pmInvest.InvestYear, orgCompanySeq = orgCompany.Seq, monthly = pmInvest.Monthly });
            if (planMonthlyInvestBusinessSummary == null) { planMonthlyInvestBusinessSummary = new List<PlanMonthlyInvestBusiness>(); }

            //////////////////////////////////////////////////////////
            // 1. 현재년도 실적 정보
            var currentPmInvestBusiness = pmInvestBusinessRepo.selectListNow(new { investYear = pmInvest.InvestYear, monthly = pmInvest.Monthly, orgCompanySeq = orgCompany.Seq });

            // 현재기준의 Bu만 조인하여 넣는다.
            var orgBusiness2 = from x in orgBusiness
                               join y in currentPmInvestBusiness on x.Seq equals y.OrgBusinessSeq
                               group x by new { x.Seq, x.BusinessName } into g
                               select new OrgBusiness
                               {
                                   Seq = g.First().Seq,
                                   BusinessName = g.First().BusinessName
                               };

            orgBusiness = orgBusiness2.ToList();

            /////////////////////////////////////////////////////////
            // 투자, 인원 요약 정보 데이터 추가 조회 
            // 1. 전년도 연간 
            // 2. 전년도 XX월 당월
            // 3. 전년도 XX월 누계
            var prevInfoBaseList = pmInvestSumRepo.selectListByPrevInfoBaseList(new { InvestYear = pmInvest.InvestYear, orgCompanySeq = orgCompany.Seq });
            var prevYearlyInfo = prevInfoBaseList.Where(x => x.Monthly == "12" && x.MonthlyType == Define.MONTHLY_TYPE.GetKey("누계")).FirstOrDefault();
            if (prevYearlyInfo == null) { prevYearlyInfo = new Models.PmInvestSum(); }
            var prevMonthlyInfo = prevInfoBaseList.Where(x => x.Monthly == pmInvest.Monthly && x.MonthlyType == Define.MONTHLY_TYPE.GetKey("당월")).FirstOrDefault();
            if (prevMonthlyInfo == null) { prevMonthlyInfo = new Models.PmInvestSum(); }
            var prevMonthlyInfoSummary = prevInfoBaseList.Where(x => x.Monthly == pmInvest.Monthly && x.MonthlyType == Define.MONTHLY_TYPE.GetKey("누계")).FirstOrDefault();
            if (prevMonthlyInfoSummary == null) { prevMonthlyInfoSummary = new Models.PmInvestSum(); }

            // 4. 해당년 연간 계획
            var planYearInvestSummary = planYearInvestSummaryRepo.selectListNowYear(new { YearInvestYear = pmInvest.InvestYear, YearlyYear = pmInvest.InvestYear, OrgCompanySeq = orgCompany.Seq });
            if (planYearInvestSummary == null) { planYearInvestSummary = new PlanYearInvestSummary(); }

            // 5. 해당년 XX월 계획 (당월/누계)
            //    = 계획에는 당월/누계 구분이 없으므로 특정 1월부터 특정월까지 합으로 누계값을 구한다.
            var currentYearlyPlanInfo = planMonthlyInvestSummaryRepo.selectOneNowYear(new { MonthlyInvestYear = pmInvest.InvestYear, Monthly = pmInvest.Monthly, OrgCompanySeq = orgCompany.Seq });
            if (currentYearlyPlanInfo == null) { currentYearlyPlanInfo = new PlanMonthlyInvestSummaryExp(); }
            var currentMonthlyPlanInfo = planMonthlyInvestSummaryRepo.selectOneNowMonth(new { MonthlyInvestYear = pmInvest.InvestYear, Monthly = pmInvest.Monthly, OrgCompanySeq = orgCompany.Seq });
            if (currentMonthlyPlanInfo == null) { currentMonthlyPlanInfo = new PlanMonthlyInvestSummaryExp(); }

            // 6. 해당년 XX월 실적 (당월/누계)
            //    = currentPmInvestBusiness
            var currentPmInvestSum = pmInvestSumRepo.selectListNowYear(new { InvestYear = pmInvest.InvestYear, Monthly = pmInvest.Monthly, OrgCompanySeq = orgCompany.Seq });


            // 뷰 전달 모델
            model.pmInvest = pmInvest;
            model.orgCompany = orgCompany;
            model.prevPmInvestBusinessByYearly = prevPmInvestBusinessByYearly;
            model.prevPmInvestBusinessByMonthly = prevPmInvestBusinessByMonthly;
            model.planYearInvestBusiness = planYearInvestBusiness;
            model.planMonthlyInvestBusiness = planMonthlyInvestBusiness;
            model.planMonthlyInvestBusinessSummary = planMonthlyInvestBusinessSummary;
            model.orgBusiness = orgBusiness;
            model.uploadedPmInvestBusiness = new List<PmInvestBusiness>();
            model.currentPmInvestBusiness = currentPmInvestBusiness;
            model.excel = "N";

            model.prevYearlyInfo = prevYearlyInfo;
            model.prevMonthlyInfo = prevMonthlyInfo;
            model.prevMonthlyInfoSummary = prevMonthlyInfoSummary;
            model.planYearInvestSummary = planYearInvestSummary;
            model.currentYearlyPlanInfo = currentYearlyPlanInfo;
            model.currentMonthlyPlanInfo = currentMonthlyPlanInfo;
            model.currentPmInvestSum = currentPmInvestSum;

            return View("~/Views/SiteMngHome/Performance/Invest/View.cshtml", model);

            TempData.Remove("alert");
        }

        [Route("Edit")]
        public ActionResult Edit(PmInvest entity)
        {

            var alert = TempData["alert"];
            if (alert != null)
            {
                TempData["alert"] = alert;
            }
            dynamic model = new ExpandoObject();

            // 기본데이터 
            var pmInvest = pmInvestRepo.selectOne(entity);

            // 부문 > 회사 이름
            var orgCompany = orgCompanyRepo.selectOne(new { Seq = pmInvest.OrgCompanySeq });

            //var orgBusiness = orgBusinessRepo.selectListCompany(new { Seq = orgCompany.Seq });
            var orgBusiness = orgBusinessRepo.selectListAll(new { orgCompanySeq = orgCompany.Seq });


            /////////////////////////////////////////////////////////////
            // 1. 전년도 연간 누계  -  12월 정보의 누계 
            var prevPmInvestBusinessByYearly = pmInvestBusinessRepo.selectListBefore(new { investYear = pmInvest.InvestYear, orgCompanySeq = orgCompany.Seq });
            if (prevPmInvestBusinessByYearly == null) { prevPmInvestBusinessByYearly = new List<PmInvestBusiness>(); }

            // 2. 전년도 당월 및 누계
            var prevPmInvestBusinessByMonthly = pmInvestBusinessRepo.selectListBeforeByMonthly(new { investYear = pmInvest.InvestYear, monthly = pmInvest.Monthly, orgCompanySeq = orgCompany.Seq });
            if (prevPmInvestBusinessByMonthly == null) { prevPmInvestBusinessByMonthly = new List<PmInvestBusiness>(); }

            // 3. 당해년도 연간 계획 정보
            var planYearInvestBusiness = planYearInvestBusinessRepo.selectListNowYear(new { yearInvestYear = pmInvest.InvestYear, orgCompanySeq = orgCompany.Seq });
            if (planYearInvestBusiness == null) { planYearInvestBusiness = new List<PlanYearInvestBusiness>(); }

            // 4. 당해년도 월별 계획 정보
            var planMonthlyInvestBusiness = planMonthlyInvestBusinessRepo.selectListNowMonthly(new { monthlyInvestYear = pmInvest.InvestYear, orgCompanySeq = orgCompany.Seq, monthly = pmInvest.Monthly });
            if (planMonthlyInvestBusiness == null) { planMonthlyInvestBusiness = new List<PlanMonthlyInvestBusiness>(); }

            // 5. 당해년도 누적 계획
            var planMonthlyInvestBusinessSummary = planMonthlyInvestBusinessRepo.selectListNowMonthlySummary(new { monthlyInvestYear = pmInvest.InvestYear, orgCompanySeq = orgCompany.Seq, monthly = pmInvest.Monthly });
            if (planMonthlyInvestBusinessSummary == null) { planMonthlyInvestBusinessSummary = new List<PlanMonthlyInvestBusiness>(); }

            //////////////////////////////////////////////////////////
            // 1. 현재년도 실적 정보
            var currentPmInvestBusiness = pmInvestBusinessRepo.selectListNow(new { investYear = pmInvest.InvestYear, monthly = pmInvest.Monthly, orgCompanySeq = orgCompany.Seq });

            // 현재기준의 Bu만 조인하여 넣는다.
            var orgBusiness2 = from x in orgBusiness
                               join y in currentPmInvestBusiness on x.Seq equals y.OrgBusinessSeq 
                               group x by new { x.Seq, x.BusinessName} into g
                               select new OrgBusiness
                               {
                                   Seq = g.First().Seq,
                                   BusinessName = g.First().BusinessName
                               };

            orgBusiness = orgBusiness2.ToList();

            /////////////////////////////////////////////////////////
            // 투자, 인원 요약 정보 데이터 추가 조회 
            // 1. 전년도 연간 
            // 2. 전년도 XX월 당월
            // 3. 전년도 XX월 누계
            var prevInfoBaseList = pmInvestSumRepo.selectListByPrevInfoBaseList(new { InvestYear = pmInvest.InvestYear, orgCompanySeq = orgCompany.Seq });
            var prevYearlyInfo = prevInfoBaseList.Where(x => x.Monthly == "12" && x.MonthlyType == Define.MONTHLY_TYPE.GetKey("누계")).FirstOrDefault();
            if(prevYearlyInfo == null) { prevYearlyInfo = new Models.PmInvestSum(); }
            var prevMonthlyInfo = prevInfoBaseList.Where(x => x.Monthly == pmInvest.Monthly && x.MonthlyType == Define.MONTHLY_TYPE.GetKey("당월")).FirstOrDefault();
            if (prevMonthlyInfo == null) { prevMonthlyInfo = new Models.PmInvestSum(); }
            var prevMonthlyInfoSummary = prevInfoBaseList.Where(x => x.Monthly == pmInvest.Monthly && x.MonthlyType == Define.MONTHLY_TYPE.GetKey("누계")).FirstOrDefault();
            if (prevMonthlyInfoSummary == null) { prevMonthlyInfoSummary = new Models.PmInvestSum(); }

            // 4. 해당년 연간 계획
            var planYearInvestSummary = planYearInvestSummaryRepo.selectListNowYear(new { YearInvestYear = pmInvest.InvestYear, YearlyYear = pmInvest.InvestYear, OrgCompanySeq = orgCompany.Seq});
            if (planYearInvestSummary == null) { planYearInvestSummary = new PlanYearInvestSummary(); }

            // 5. 해당년 XX월 계획 (당월/누계)
            //    = 계획에는 당월/누계 구분이 없으므로 특정 1월부터 특정월까지 합으로 누계값을 구한다.
            var currentYearlyPlanInfo = planMonthlyInvestSummaryRepo.selectOneNowYear(new { MonthlyInvestYear = pmInvest.InvestYear, Monthly = pmInvest.Monthly, OrgCompanySeq = orgCompany.Seq });
            if(currentYearlyPlanInfo == null) { currentYearlyPlanInfo = new PlanMonthlyInvestSummaryExp(); }
            var currentMonthlyPlanInfo = planMonthlyInvestSummaryRepo.selectOneNowMonth(new { MonthlyInvestYear = pmInvest.InvestYear, Monthly = pmInvest.Monthly, OrgCompanySeq = orgCompany.Seq });
            if (currentMonthlyPlanInfo == null) { currentMonthlyPlanInfo = new PlanMonthlyInvestSummaryExp(); }

            // 6. 해당년 XX월 실적 (당월/누계)
            //    = currentPmInvestBusiness
            var currentPmInvestSum = pmInvestSumRepo.selectListNowYear(new { InvestYear = pmInvest.InvestYear, Monthly = pmInvest.Monthly, OrgCompanySeq = orgCompany.Seq});


            // 뷰 전달 모델
            model.pmInvest = pmInvest;
            model.orgCompany = orgCompany;
            model.prevPmInvestBusinessByYearly = prevPmInvestBusinessByYearly;
            model.prevPmInvestBusinessByMonthly = prevPmInvestBusinessByMonthly;
            model.planYearInvestBusiness = planYearInvestBusiness;
            model.planMonthlyInvestBusiness = planMonthlyInvestBusiness;
            model.planMonthlyInvestBusinessSummary = planMonthlyInvestBusinessSummary;
            model.orgBusiness = orgBusiness;
            model.uploadedPmInvestBusiness = new List<PmInvestBusiness>();
            model.currentPmInvestBusiness = currentPmInvestBusiness;
            model.excel = "N";

            model.prevYearlyInfo = prevYearlyInfo;
            model.prevMonthlyInfo = prevMonthlyInfo;
            model.prevMonthlyInfoSummary = prevMonthlyInfoSummary;
            model.planYearInvestSummary = planYearInvestSummary;
            model.currentYearlyPlanInfo = currentYearlyPlanInfo;
            model.currentMonthlyPlanInfo = currentMonthlyPlanInfo;
            model.currentPmInvestSum = currentPmInvestSum;


            return View("~/Views/SiteMngHome/Performance/Invest/Edit.cshtml", model);

            TempData.Remove("alert");
        }


        [HttpPost]
        [AcceptVerbs(HttpVerbs.Post), ValidateInput(false)]
        [Route("ConfirmAction")]
        public ActionResult ConfirmAction(int PmInvestSeq, int RegistStatus)
        {
            if (RegistStatus == Define.REGIST_STATUS.GetKey("저장"))
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

            if (pmInvestRepo.updateRegistStatusByPmInvestSeq(new { Seq = PmInvestSeq, RegistStatus = RegistStatus, UserKey = SessionManager.GetAdminSession().insaUserV.userKey, EmpNo = SessionManager.GetAdminSession().insaUserV.empNo }) == -1)
            {
                TempData["alert"] = "요청 중 오류가 발생하였습니다.";
                return Redirect("List");
            }
            else
            {
                TempData["alert"] = "요청이 정상적으로 처리되었습니다.";
            }

            // 현재의 상태 변경 후 담당자들에게 메일 발송합니다.(2018.11.08)
            var info = pmInvestRepo.selectOne(new { Seq = PmInvestSeq });

            MailInfo mInfo = new MailInfo();
            mInfo.afterRegistStatus = RegistStatus;
            mInfo.OrgCompanySeq = info.OrgCompanySeq;
            mInfo.menuName = "투자인원";
            mInfo.year = info.InvestYear;
            mInfo.mm = info.Monthly;
            MailUtil.RegistStatusMail(mInfo);
            
            // 최종승인의 경우. 다른 모든 회사와 메뉴가 최종승인 되었는지 체크하여. 푸시알림을 보낸다.
            if (RegistStatus == Define.REGIST_STATUS.GetKey("최종승인"))
            {
                RegistYearListRepo rYearListRepo = new RegistYearListRepo();
                List<RegistYearList> registYearPm = rYearListRepo.selectListPm(new { }).ToList();

                string year = info.InvestYear;
                string month = info.Monthly;

                var checkRegist = registYearPm.Where(w => w.RegistYear == year && w.RegistMonth == month).ToList();
                if (checkRegist != null && checkRegist.Count() > 0)
                {
                    // 인사디비에서 권한 사용자 가져온다.
                    var users = insaUserVRepo.selectListAuth().ToList();

                    PushMaster pushMaster = new PushMaster();
                    pushMaster.Type = 1;
                    pushMaster.Title = "-";
                    pushMaster.Contents = year + "년 " + month + "월 실적등록이 승인되었습니다.";
                    pushMaster.Link = "";

                    ApiController api = new ApiController();

                    List<string> result = api.SendPushServer(pushMaster, users);
                    if (result[0].ToUpper() == "FALSE")
                    {
                        LogUtil.MngError(result[2].ToString() + "[" + year + "." + month);
                    }
                }
            }

            return Redirect("List");
        }

        [HttpPost]
        [AcceptVerbs(HttpVerbs.Post), ValidateInput(false)]
        [Route("RejectAction")]
        public ActionResult RejectAction(int PmInvestSeq, int RegistStatus)
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

            if (pmInvestRepo.updateRegistStatusByPmInvestSeq(new { Seq = PmInvestSeq, RegistStatus = RegistStatus, UserKey = SessionManager.GetAdminSession().insaUserV.userKey, EmpNo = SessionManager.GetAdminSession().insaUserV.empNo }) == -1)
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