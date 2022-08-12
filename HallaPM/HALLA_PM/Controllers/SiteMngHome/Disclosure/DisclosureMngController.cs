using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

using HALLA_PM.Core;
using HALLA_PM.Util;
using HALLA_PM.Models;
using System.Dynamic;
using HALLA_PM.Models.Confirm;
using Fluentx.Mvc;
using ClosedXML.Excel;
using System.Data;
using System.IO;
using FileInfo = HALLA_PM.Models.FileInfo;
using System.Text.RegularExpressions;

namespace HALLA_PM.Controllers.SiteMngHome
{
    /// <summary>
    /// 조직관리 컨트롤러
    /// </summary>
    [AdminLoginFilter]
    [AuthAdminFilter(RequestAuthLevel = 1)]
    [RoutePrefix("SiteMngHome/Disclosure")]
    public class DisclosureMndController : SiteMngBaseController
    {
        DisclosureRepo disclosureRepo = new DisclosureRepo();
        OrgCompanyRepo orgCompanyRepo = new OrgCompanyRepo();
        DisclosureDraftRepo disclosureDraftRepo = new DisclosureDraftRepo();
        DisclosureDataRepo disclosureDataRepo = new DisclosureDataRepo();
        FileInfoRepo fileInfoRepo = new FileInfoRepo();

        OrgUnionRepo orgUnionRepo = new OrgUnionRepo();
        [Route("DisclosureList")]
        public ActionResult DisclosureList(Search search)
        {


            dynamic model = new ExpandoObject();
            search.AuthUserKey = SessionManager.GetAdminSession().insaUserV.userKey;
            model.list = disclosureRepo.selectList(search);
            model.UnionList = orgUnionRepo.selectList(new { });

            model.OrgCpyList = orgCompanyRepo.selectList(null);
            ViewBag.Search = search;
            return View("~/Views/SiteMngHome/Disclosure/DisclosureList.cshtml", model);
        }

        [Route("DisclosureView")]
        public ActionResult DisclosureView(Disclosure entity, Search search)
        {

            if (Request.RequestType == "GET") return RedirectToAction("List");
            if (entity.Month.Length == 1)
            {
                entity.Month = "0" + entity.Month;
            }
            //기초 데이터 등록
            var check = disclosureRepo.disclosureCount(entity);

            if(check <= 0)
            {           
                disclosureRepo.insert(entity);
            }

            // 기본데이터
            var disclosure = disclosureRepo.selectOne(entity);

            // 부문 > 회사 이름
            var orgCompanyName = orgCompanyRepo.selectOne(new { Seq = entity.CompanySeq });

            dynamic model = new ExpandoObject();
            model.list = disclosureDataRepo.selectList(entity);
            model.disclosure = disclosure;
            model.orgCompanyName = orgCompanyName;
  
            ViewBag.Search = search;


            return View("~/Views/SiteMngHome/Disclosure/DisclosureView.cshtml", model);
        }
        [Route("DisclosureView2")]
        public ActionResult DisclosureView2(Disclosure entity, Search search)
        {

            if (Request.RequestType == "GET") return RedirectToAction("List");
            if (entity.Month.Length == 1)
            {
                entity.Month = "0" + entity.Month;
            }
            //기초 데이터 등록
            var check = disclosureRepo.disclosureCount(entity);

            if (check <= 0)
            {
                disclosureRepo.insert(entity);
            }

            // 기본데이터
            var disclosure = disclosureRepo.selectOne(entity);

            // 부문 > 회사 이름
            var orgCompanyName = orgCompanyRepo.selectOne(new { Seq = entity.CompanySeq });

            dynamic model = new ExpandoObject();
            model.list = disclosureDataRepo.selectList(entity);
            model.disclosure = disclosure;
            model.orgCompanyName = orgCompanyName;

            ViewBag.Search = search;


            return View("~/Views/SiteMngHome/Disclosure/DisclosureView.cshtml", model);
        }

       
        [Route("DisclosureDelete")]
        public ActionResult DisclosureDelete(Disclosure entity, Search search)
        {
            //데이터 삭제
            disclosureDataRepo.delete(entity);

            //초기화 후에 상태값 미완료로 변경
            disclosureRepo.afterResetRegist(entity);
            
            return Json(new { success = true, resultMsg = "" }, JsonRequestBehavior.AllowGet);

        }

        [Route("DisclosureDraftList")]
        public ActionResult DisclosureDraftList(Search search)
        {

            dynamic model = new ExpandoObject();
            search.AuthUserKey = SessionManager.GetAdminSession().insaUserV.userKey;
            model.list = disclosureDraftRepo.selectList(search);
            model.totalCount = disclosureDraftRepo.count(search);
            model.UnionList = orgUnionRepo.selectList(new { });
            model.OrgCpyList = orgCompanyRepo.selectList(null);
            ViewBag.Search = search;

            return View("~/Views/SiteMngHome/Disclosure/DisclosureDraftList.cshtml", model);
        }

        [Route("DisclosureDraftWrite")]
        public ActionResult DisclosureDraftWrite(DisclosureDraft entity, Search search)
        {
            if (entity.Month.Length == 1)
            {
                entity.Month = "0" + entity.Month;
            }

            var orgCompanyName = orgCompanyRepo.selectOne(new { Seq = entity.CompanySeq });
            var disclosureDraft = disclosureDraftRepo.selectOne(entity);

            dynamic model = new ExpandoObject();
          
            model.fileInfo = disclosureDraftRepo.selectOneExp(new { entity.Seq });
            model.orgCompanyName = orgCompanyName;
            model.disclosureDraft = disclosureDraft;

            ViewBag.Search = search;

            return View("~/Views/SiteMngHome/Disclosure/DisclosureDraftWrite.cshtml", model);
        }

        [HttpPost]
        [AcceptVerbs(HttpVerbs.Post), ValidateInput(false)]
        [Route("writeAction")]
        public ActionResult writeAction(DisclosureDraft disclosureDraft, Search search)
        {
            DisclosureDraft info = disclosureDraftRepo.availableCheckInfo(disclosureDraft);
            if (info == null)
            {
                int seq = 0;
                if ((seq = disclosureDraftRepo.save(disclosureDraft)) == -1)
                {
                    TempData["alert"] = "등록에 실패하였습니다.";
                    disclosureDraftRepo.delete(disclosureDraft);
                }
                else
                {
                    TempData["alert"] = "등록 되었습니다.";
                    fileInfoRepo.attachFileDevelop(Request.Files, "DISCLOSURE_DRAFT", seq, "disclosureDraft");
                }

            }
            else
            {
                TempData["alert"] = "중복된 게시글이 있습니다.";
            }
            return RedirectToAction("DisclosureDraftList", search);
        }
   

        

        [HttpPost]
        [Route("deleteAction")]
        public ActionResult deleteAction(int seq, Search search)
        {
            if (disclosureDraftRepo.delete(new { seq }) == -1)
            {
                TempData["alert"] = "삭제에 실패하였습니다.";
            }
            else
            {
                TempData["alert"] = "삭제 되었습니다.";
                fileInfoRepo.deleteTableSeq(new FileInfo { attachTableName = "DISCLOSURE_DRAFT", attachTableSeq = seq });
            }
            return RedirectToAction("List", search);
        }

        [HttpPost]
        [Route("deleteFileAction")]
        public JsonResult deleteFileAction(int seq, string inputName,string Month,string Year,int CompanySeq )
        {
            bool result = false;
            var procCnt = fileInfoRepo.deleteTableSeqAndInputName(new FileInfo { attachTableName = "DISCLOSURE_DRAFT", attachTableSeq = seq, fileInputName = inputName });
            if (procCnt > 0)
            {
                disclosureDraftRepo.delete(new { Month = Month, Year = Year, CompanySeq = CompanySeq });
                result = true;
            }
            return Json(new { success = result }, JsonRequestBehavior.AllowGet);

        }
        [Route("FileDownload")]
        public ActionResult FileDownload(int fileInfoSeq, int seq, string inputRegDate)
        {
            var fileInfo = fileInfoRepo.selectOneSeq(new { seq = fileInfoSeq });
            try
            {
                byte[] fileBytes = System.IO.File.ReadAllBytes(Define.FILE_PATH + "/" + fileInfo.filePath + " /" + fileInfo.fileStoredName);
                string fileName = fileInfo.fileOrgName;

                return File(fileBytes, System.Net.Mime.MediaTypeNames.Application.Octet, fileName);
            }
            catch (Exception e)
            {
                LogUtil.MngError(e.ToString());
                // View?seq=@item.seq&inputRegDate=@item.inputRegDate
                TempData["alert"] = "첨부파일에 오류가 있습니다.";
                return Redirect("/SiteMngHome/Disclosure/DisclosureDraftWrite,html");
            }
        }

        [Route("Excel_Down")]
        public ActionResult ExcelDown(Disclosure entity)
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");

            // 기본데이터
            var disclosure = disclosureRepo.selectOne(entity);
            // 부문 > 회사 이름
            var orgCompanyName = orgCompanyRepo.selectOne(new { Seq =entity.CompanySeq });

            // 공시항목
            var disItemlist = disclosureTitleRepo.selectExcelList(" ");

            string fileName = "Disclosure_" + disclosure.Year + "년_" + disclosure.Month + "월_" + orgCompanyName.CompanyName+ "_공시양식"; ;

            int rows = 1, cells = 1;

            using (XLWorkbook wb = new XLWorkbook())
            {
                var wsDisclosure = wb.Worksheets.Add("공시양식");

                // 컬럼 숨기기
                // wsSales.Column(1).Hide();
                // wsSales.Column(2).Hide();
                //wsSales.Column(3).Hide();

                //wsSales.Cell(rows, cells).SetValue("ParentSeq").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                // wsSales.Cell(rows, ++cells).SetValue("Seq").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsDisclosure.Column(3).Width = 16;
                wsDisclosure.Column(4).Width = 20;
                wsDisclosure.Column(5).Width = 36;
                wsDisclosure.Column(7).Style.NumberFormat.Format = "#,#";
                wsDisclosure.Column(7).Width = 30;
                wsDisclosure.Column(8).Width = 20;
                wsDisclosure.Column(9).Width = 20;
                wsDisclosure.Column(10).Width = 40;
                wsDisclosure.Column(11).Width = 40;

                wsDisclosure.Cell(rows, cells).SetValue("년도").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsDisclosure.Cell(rows, ++cells).SetValue("월").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                wsDisclosure.Cell(rows, ++cells).SetValue("L1(공시항목)").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsDisclosure.Cell(rows, ++cells).SetValue("L2(세부항목)").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsDisclosure.Cell(rows, ++cells).SetValue("L3(공시제목)").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsDisclosure.Cell(rows, ++cells).SetValue("공시대상").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsDisclosure.Cell(rows, ++cells).SetValue("거래금액(백만원)").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsDisclosure.Cell(rows, ++cells).SetValue("거래상대방").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsDisclosure.Cell(rows, ++cells).SetValue("거래일시").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsDisclosure.Cell(rows, ++cells).SetValue("세부내용").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsDisclosure.Cell(rows, ++cells).SetValue("비고").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                wsDisclosure.Cell(2, 1).SetValue(disclosure.Year).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsDisclosure.Cell(2, 2).SetValue(disclosure.Month).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsDisclosure.Cell(2, 6).SetValue("Y").Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                wsDisclosure.Cell(2, 9).SetValue("2022-05-15").Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);


                rows = 1;
                cells = 1;
                var disclosureItem = wb.Worksheets.Add("공시항목");

                // 컬럼 숨기기
            
                disclosureItem.Column(1).Width = 16;
                disclosureItem.Column(2).Width = 20;
                disclosureItem.Column(3).Width = 30;
                disclosureItem.Cell(rows,  cells).SetValue("L1(공시항목)").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                disclosureItem.Cell(rows, ++cells).SetValue("L2(세부항목)").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                disclosureItem.Cell(rows, ++cells).SetValue("L3(공시제목)").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                disclosureItem.Cell(rows, ++cells).SetValue("공시코드").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                foreach (var item in disItemlist)
                {
                    rows++;
                    cells = 1;

                    disclosureItem.Cell(rows,  cells).SetValue(item.DisName).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    disclosureItem.Cell(rows, ++cells).SetValue(item.DetailName).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    disclosureItem.Cell(rows, ++cells).SetValue(item.Title).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    disclosureItem.Cell(rows, ++cells).SetValue(item.DisCode).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
         
                }



                using (MemoryStream mStream = new MemoryStream())
                {
                    wb.SaveAs(mStream);
                    return File(mStream.ToArray(), "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", fileName + ".xlsx");
                }
            }
        }

        [Route("Excel_Upload3")]
        public ActionResult ExcelUpload3(int Seq, int CompanySeq, string Month , string Year, int RegistStatus, HttpPostedFileBase ExcelFile)
        {
            // 엑셀파일 검증 후
            // 문제가 없다면 엑셀 파일 데이터에 입력
            // 저장 완료되면 엑셀 로그에 데이터 남기고 해당 파일 저장
            // 문제가 있으면 삭제
            int j = 2;
            bool result = false;
            string resultMsg = "";
            if (ExcelFile.ContentLength != 0)
            {
                FileUtil fileUtil = new FileUtil(Define.FILE_PATH);
                string filePath = "Disclosure";
                var file = fileUtil.FileUpload(ExcelFile, filePath);

                bool bDoubleValue = true;

                ExcelUtil excelUtil = new ExcelUtil();
                var ds = excelUtil.ImportExcelDs(file["FILE_PATH"]);

                List<DisclosureData> disclosureDataList = new List<DisclosureData>();

                try
                {
                    // 다운받은 sheet 이름으로 체크 한다.
                    if (ds.Tables["공시양식"] == null || ds.Tables["공시양식"].Rows.Count == 0)
                    {
                        // 오류시 파일 삭제
                        fileUtil.FileDelete(filePath, file["STORED_FILE_NAME"]);
                        result = false;
                        resultMsg = Message.MSG_007_E;
                        return Json(new { success = result, resultMsg = resultMsg }, JsonRequestBehavior.AllowGet);
                    }
                    //ds.Tables["공시양식"].Rows
                    for (int i = 0; i < ds.Tables["공시양식"].Rows.Count; i++)
                    {
                        if (ds.Tables["공시양식"].Rows[i].ItemArray.GetValue(0).ToString() == "")
                        {
                            ds.Tables["공시양식"].Rows[i].Delete();
                            ds.AcceptChanges();
                        }

                    }
                    foreach (DataRow item in ds.Tables["공시양식"].Rows)
                    {
                      
                       
                        string year = item.ItemArray.GetValue(0).ToString();
                        string month = item.ItemArray.GetValue(1).ToString();
                        string disName = item.ItemArray.GetValue(2).ToString().Trim();
                        string detailName = item.ItemArray.GetValue(3).ToString().Trim();
                        string title = item.ItemArray.GetValue(4).ToString().Trim();
                        string planYn = item.ItemArray.GetValue(5).ToString().Trim();
                        string transAmt = item.ItemArray.GetValue(6).ToString();
                        string transCpy = item.ItemArray.GetValue(7).ToString();
                        string transDate = item.ItemArray.GetValue(8).ToString();
                        string content = item.ItemArray.GetValue(9).ToString();
                        string remark = item.ItemArray.GetValue(10).ToString();
                        
                        if(year != Year)
                        {
                            fileUtil.FileDelete(filePath, file["STORED_FILE_NAME"]);
                            result = false;
                            resultMsg = j + "열 입력데이터 오류 양식에 기재되어있는 연도만 입력할 수 있습니다.";
                            return Json(new { success = result, resultMsg = resultMsg }, JsonRequestBehavior.AllowGet);

                        };
                        if (month != Month)
                        {
                            fileUtil.FileDelete(filePath, file["STORED_FILE_NAME"]);
                            result = false;
                            resultMsg = j + "열 입력데이터 오류 양식에 기재되어있는 월 만 입력할 수 있습니다.";
                            return Json(new { success = result, resultMsg = resultMsg }, JsonRequestBehavior.AllowGet);

                        };
                        // Y/N 체크
                        Regex regexYn = new Regex("^[YN]$");
                        bool YnTest = regexYn.IsMatch(planYn);
                        if (YnTest == false) {
                            fileUtil.FileDelete(filePath, file["STORED_FILE_NAME"]);
                            result = false;
                            resultMsg = j + "열 입력데이터 오류 Y 또는 N 값만 허용됩니다.";
                            return Json(new { success = result, resultMsg = resultMsg }, JsonRequestBehavior.AllowGet);
                        }

                        //숫자 여부체크
                        Regex regexNumber = new Regex("^[0-9]*$");
                        bool numberTest = regexNumber.IsMatch(transAmt);
                        if(numberTest == false) {

                            fileUtil.FileDelete(filePath, file["STORED_FILE_NAME"]);
                            result = false;
                            resultMsg = j + " 번째 열에 숫자형식에 맞지 않는 데이터가있습니다.";
                            return Json(new { success = result, resultMsg = resultMsg }, JsonRequestBehavior.AllowGet);
                        }

                        //yyyy-MM-dd 형식 체크
                        Regex regexDate1 = new Regex("[0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])");
                        Regex regexDate2 = new Regex("[0-9]{4}/(0[1-9]|1[0-2])/(0[1-9]|[1-2][0-9]|3[0-1])");

                        bool dateTimeTest = regexDate1.IsMatch(transDate.Substring(0,10));
                        bool dateTimeTest2 = regexDate2.IsMatch(transDate.Substring(0, 10));

                        if (dateTimeTest == false && dateTimeTest2 == false) {

                            fileUtil.FileDelete(filePath, file["STORED_FILE_NAME"]);
                            result = false;
                            resultMsg = j + " 번째 열에 날짜형식에 맞지 않는 데이터가있습니다.";
                            return Json(new { success = result, resultMsg = resultMsg }, JsonRequestBehavior.AllowGet);
                        }

                        // 공시항목 존재 체크
                        string disCode = "";
                        int verify = disclosureRepo.verifyDisclosure(new { DisName = disName ,DetailName = detailName, Title = title });
                        if(verify <= 0) {
                            
                            fileUtil.FileDelete(filePath, file["STORED_FILE_NAME"]);
                            result = false;
                            resultMsg = j + " 번째 열에 공시항목에 맞지 않는 데이터가있습니다.";
                            return Json(new { success = result, resultMsg = resultMsg }, JsonRequestBehavior.AllowGet);
                            
                        } else
                        {
                            j++;
                            disCode = disclosureRepo.selectDisCode(new { DisName = disName, DetailName = detailName, Title = title });
                        }
           
                        DisclosureData p = new DisclosureData();
                        p.IdxSeq = CompanySeq;
                        p.Year = year;
                        p.Month = month;
                        p.DisName   = disName;
                        p.DetailName = detailName;
                        p.Title = title;
                        p.DisCode = disCode;
                        p.PlanYn = planYn.ToUpper();
                        p.TransAmt = Convert.ToInt32(string.Format("{0:#,##0}", transAmt));
                        p.TransDate = transDate; 
                        p.TransCpn = transCpy;
                        p.Content = content;
                        p.Remark = remark;
                      
                        disclosureDataList.Add(p);
                    }
                   
                    if (!bDoubleValue)
                    {
                        // 오류시 파일 삭제
                        fileUtil.FileDelete(filePath, file["STORED_FILE_NAME"]);
                        result = false;
                        resultMsg = Message.MSG_007_E;
                        return Json(new { success = result, resultMsg = resultMsg }, JsonRequestBehavior.AllowGet);
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

                // 반려상태 일때 초기화버튼없이 엑셀업로드로 엎어친다.
                if (RegistStatus == 4 || RegistStatus == 5 || RegistStatus == 9)
                {
                    //기존데이터 삭제
                    disclosureDataRepo.delete(new { Month = Month, Year = Year, CompanySeq = CompanySeq });
                }

                // 문제 없으면 업데이트
                foreach (var item in disclosureDataList)
                {
                    disclosureDataRepo.insert(item);
                }
                //반려상태에서 진행시에는 반려상태값을 가지고있고 최초 업로드해서 등록시에는 저장이라는 상태값으로 변경한다.
                disclosureRepo.afterUploadRegist(new { CompanySeq = CompanySeq, RegistStatus = RegistStatus ,Month = Month, Year = Year });



                // 업데이트 완료 후 로그 남기기
                ExcelFileUploadList eFileList = new ExcelFileUploadList();
                eFileList.UserKey = SessionManager.GetAdminSession().insaUserV.userKey;
                eFileList.EmpNo = SessionManager.GetAdminSession().insaUserV.empNo;
                eFileList.AttachTableName = "DISCLOSURE_DATA";
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

        [Route("Edit_Action")]
        public ActionResult EditAction(DisclosureData entity, Search search)
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");

            #region
            Dictionary<string, object> postData = new Dictionary<string, object>();
            postData.Add("Seq", entity.Seq);
            postData.Add("OrgCompanySeq", entity.IdxSeq);
            postData.Add("message", Message.MSG_007_A);
            postData.Add("PageIndex", search.PageIndex);
            #endregion

            // 영업활동, 투자활동, 재무활동, FCF, 기초기말현금, 요약 저장
            bool bDoubleValue = true;

            List<DisclosureData> pSalesList = new List<DisclosureData>();
           

            try
            {
                //for (int i = 0; i < entity.PmCashFlowSalesSeq.Count(); i++)
                //{
                //    if (!WebUtil.CheckDecimalTwo(entity.OperationProfit[i].ToString())) { bDoubleValue = false; break; }
                //    if (!WebUtil.CheckDecimalTwo(entity.DepreciationCost[i].ToString())) { bDoubleValue = false; break; }
                //    if (!WebUtil.CheckDecimalTwo(entity.CorpTax[i].ToString())) { bDoubleValue = false; break; }
                //    if (!WebUtil.CheckDecimalTwo(entity.Ar[i].ToString())) { bDoubleValue = false; break; }
                //    if (!WebUtil.CheckDecimalTwo(entity.Inv[i].ToString())) { bDoubleValue = false; break; }
                //    if (!WebUtil.CheckDecimalTwo(entity.Ap[i].ToString())) { bDoubleValue = false; break; }
                //    if (!WebUtil.CheckDecimalTwo(entity.Etc[i].ToString())) { bDoubleValue = false; break; }
                //    if (!WebUtil.CheckDecimalTwo(entity.InterestExpense[i].ToString())) { bDoubleValue = false; break; }
                //    if (!WebUtil.CheckDecimalTwo(entity.InterestIncome[i].ToString())) { bDoubleValue = false; break; }

                //    PmCashFlowSales p = new PmCashFlowSales();
                //    p.Seq = entity.PmCashFlowSalesSeq[i];
                //    p.OperationProfit = entity.OperationProfit[i];
                //    p.DepreciationCost = entity.DepreciationCost[i];
                //    p.CorpTax = entity.CorpTax[i];
                //    p.Ar = entity.Ar[i];
                //    p.Inv = entity.Inv[i];
                //    p.Ap = entity.Ap[i];
                //    p.Etc = entity.Etc[i];
                //    p.InterestExpense = entity.InterestExpense[i];
                //    p.InterestIncome = entity.InterestIncome[i];

                //    pSalesList.Add(p);
                //}

                
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

            // 업데이트
            //foreach (var item in pSalesList)
            //{
            //    pmCashFlowSalesRepo.update(item);
            //}
            //foreach (var item in pInvestmentList)
            //{
            //    pmCashFlowInvestmentRepo.update(item);
            //}
            //foreach (var item in pFinancialList)
            //{
            //    pmCashFlowFinancialRepo.update(item);
            //}
            //foreach (var item in pFcfList)
            //{
            //    pmCashFlowFcfRepo.update(item);
            //}
            //foreach (var item in pBeCashList)
            //{
            //    pmCashFlowBeCashRepo.update2(item);
            //}
            //foreach (var item in pCumulativeList)
            //{
            //    pmCashFlowCumulativeRepo.update(item);
            //}

            // 미저장에서 저장으로 변경
            if (entity.RegistStatus == Define.REGIST_STATUS.GetKey("미등록"))
            {
                entity.RegistStatus = Define.REGIST_STATUS.GetKey("저장");
                PmCashFlow p = new PmCashFlow();
                p.Seq = entity.Seq;
                p.RegistStatus = entity.RegistStatus;
                pmCashFlowRepo.updateRegist(p);
            }

            return RedirectAndPostActionResult.RedirectAndPost("Edit", postData);
        }
        /// <summary>
        /// 공시계획여부 상태 변경
        /// </summary>
        /// <returns></returns>
        [Route("PlanYnUpdate")]
        public ActionResult PlanYnUpdate(int Seq, int CompanySeq, string Month, string Year, string PlanYn, int RegistStatus, HttpPostedFileBase ExcelFile)
        {
           

            bool result = false;
            string resultMsg = "";

            disclosureRepo.planYnUpdate(new { CompanySeq = CompanySeq, PlanYn = PlanYn, Month = Month, Year = Year });

            result = true;
            resultMsg = Message.MSG_007_A;

            
            return Json(new { success = result, resultMsg = resultMsg }, JsonRequestBehavior.AllowGet);
        }
        /// <summary>
        /// 승인요청, 승인, 반려등의 상태 변경
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        [Route("Regist_Status_Change")]
        public ActionResult RegistStatusChange(Disclosure entity, Search search)
        {


            if (Request.RequestType == "GET") return RedirectToAction("List");

            #region
            Dictionary<string, object> postData = new Dictionary<string, object>();
            postData.Add("Seq", entity.Seq);
            postData.Add("CompanySeq", entity.CompanySeq);
            postData.Add("message", entity.message);
            #endregion

            // 현재 상태값을 변경한다.
            entity.RegistStatus = entity.afterRegistStatus;
            disclosureRepo.updateRegist(entity);


            // 현재의 상태 변경 후 담당자들에게 메일 발송합니다.(2018.11.08)
            var info = disclosureRepo.selectOne(entity);

            MailInfo mInfo = new MailInfo();
            // 2019.01.13 결제라인 추가
            mInfo.Seq = entity.Seq;
            mInfo.ReferUrl = Request.UrlReferrer.AbsolutePath.ToString();
            mInfo.afterRegistStatus = entity.afterRegistStatus;
            mInfo.OrgCompanySeq = entity.CompanySeq;
            mInfo.menuName = "공시";
            mInfo.year = info.Year;
            mInfo.mm = info.Month;

            // 2018.01.03 반려사유 추가
            mInfo.RejectReson = entity.RejectReason;

            MailUtilNew.AllComfirmMaillSender(mInfo); /*메일 발송*/

            // 최종승인의 경우. 다른 모든 회사와 메뉴가 최종승인 되었는지 체크하여. 푸시알림을 보낸다.
            if (entity.RegistStatus == Define.REGIST_STATUS.GetKey("최종승인"))
            {
                RegistYearListRepo rYearListRepo = new RegistYearListRepo();
                List<RegistYearList> registYearPm = rYearListRepo.selectListDisclosure(new { }).ToList();

                string year = info.Year;
                string month = info.Month;

                var checkRegist = registYearPm.Where(w => w.RegistYear == year && w.RegistMonth == month).ToList();
                if (checkRegist != null && checkRegist.Count() > 0)
                {
                    // 인사디비에서 권한 사용자 가져온다.
                    var users = insaUserVRepo.selectListAuth().ToList();

                    PushMaster pushMaster = new PushMaster();
                    pushMaster.Type = 1;
                    pushMaster.Title = "-";
                    pushMaster.Contents = year + "년 " + month + "월 공시등록이 승인되었습니다.";
                    pushMaster.Link = "";

                    ApiController api = new ApiController();

                    List<string> result = api.SendPushServer(pushMaster, users);
                    if (result[0].ToUpper() == "FALSE")
                    {
                        LogUtil.MngError(result[2].ToString() + "[" + year + "." + month);
                    }
                }
            }

            return RedirectToAction("DisclosureList", search);
        }
        [Route("RegistStatusAllChange")]
        [HttpPost]
        public ActionResult RegistStatusAllChange(PmConfirmLog objLog)
        {
            //if (Request.RequestType == "GET") return RedirectToAction("List");
            bool result = false;
            string resultMsg = "";
            PmConfirmStateView objReject = null;
            PmConfirmView pmconfirmView = new PmConfirmView();
            PmConfirmViewRepo pmconfirmViewRepo = new PmConfirmViewRepo();
            List<PmConfirmView> pmconfirmViewList;
            #region
            Dictionary<string, object> postData = new Dictionary<string, object>();
            postData.Add("Seq", objLog.seq);
            postData.Add("OrgCompanySeq", objLog.orgCompanySeq);
            postData.Add("message", "");
            #endregion
            int intResult = 0;
            objLog.userIp = WebUtil.GetClientIP();
            objLog.userKey = SessionManager.GetAdminSession().insaUserV.userKey;

            //objReject = disclosureDraftRepo.selectOne(new
            //{
            //    searchCpySeq = objLog.orgCompanySeq
            //                                                   ,
            //    searchYear = objLog.pmYear
            //                                                   ,
            //    searchMonth = objLog.monthly
            //});


            if (objReject.firstReject > 0 || objReject.secondReject > 0 || objReject.thirdReject > 0)
            {
                LogUtil.MngError(string.Format("[해당회사 : {0} ][해당년 : {1}][해당월 :{2}] [{3}]", objLog.orgCompanySeq, objLog.pmYear, objLog.monthly, Message.MSG_001_ALL_REJECT));
                resultMsg = Message.MSG_001_ALL_REJECT;
            }
            else if (objReject.finalConfirm == "TRUE")
            {
                LogUtil.MngError(string.Format("[해당회사 : {0} ][해당년 : {1}][해당월 :{2}] [{3}]", objLog.orgCompanySeq, objLog.pmYear, objLog.monthly, "이미 최종승인 처리 되었습니다."));
                resultMsg = "이미 최종승인 처리 되었습니다.";
            }
            else if (objReject.readyFirstConfirm != "TRUE" && objReject.readySecondConfirm != "TRUE" && objReject.readyLastConfirm != "TRUE")
            {
                LogUtil.MngError(string.Format("[해당회사 : {0} ][해당년 : {1}][해당월 :{2}] [{3}]", objLog.orgCompanySeq, objLog.pmYear, objLog.monthly, Message.MSG_001_ALL_READY));
                resultMsg = Message.MSG_001_ALL_READY;
            }
            else
            {
                //intResult = disclosureDraftRepo.statusChangeAll(objLog);

                MailInfo objMailinfo = new MailInfo();
                objMailinfo.OrgCompanySeq = objLog.orgCompanySeq;
                objMailinfo.year = objLog.pmYear;
                objMailinfo.mm = objLog.monthly;
                objMailinfo.afterRegistStatus = objLog.confirmStatus;
                objMailinfo.RejectReson = objLog.confirmComment;
                objMailinfo.Seq = objLog.seq;
                objMailinfo.objPmSeq = new Dictionary<string, int>();
                pmconfirmViewList = pmconfirmViewRepo.selectSeqList(new
                {
                    orgCompanySeq = objLog.orgCompanySeq
                                                               ,
                    planYear = objLog.pmYear
                                                               ,
                    monthly = objLog.monthly
                                                               ,
                    registStatus = objLog.confirmStatus
                });
                foreach (var obj in pmconfirmViewList)
                {
                    objMailinfo.objPmSeq.Add(obj.busType, obj.seq);
                }

                if (intResult > 0)
                {
                    // AllConfirmSendMail(string strStatus); 메일발송처리
                    MailUtilNew.RegistStatusMail(objMailinfo, "ALL");
                }
                result = true;
                resultMsg = "승인 처리 되었습니다.";
                // TempData["alert"] = Define.REGIST_STATUS.GetValue(objLog.confirmStatus) + " 처리되었습니다" ;
            }

            return Json(new { success = result, resultMsg = resultMsg }, JsonRequestBehavior.AllowGet);
        }

        //[Route("RegistSendForm")]
        //[HttpPost]
        //public ActionResult RegistSendPost(PmConfirmLog objLog)
        //{
        //    dynamic model = new ExpandoObject();
        //    var pmConfirm = pmConfirmStateViewRepo.selectComment(new
        //    {
        //        searchCpySeq = objLog.orgCompanySeq
        //                                                                ,
        //        searchYear = objLog.pmYear
        //                                                                ,
        //        searchMonth = objLog.monthly
        //    });
        //    objLog.confirmComment = pmConfirm.confirmComment;
        //    objLog.strCompnayName = pmConfirm.companyName;
        //    model.pmconfirmLog = objLog;
        //    model.BsExcount = (pmConfirm.pmBsEx > 0) ? "" : "none";
        //    //model.LISTPAGEURL = listUrl; 
        //    return View("~/Views/SiteMngHome/Confirm/RegistSendForm.cshtml", model);
        //}

        [Route("PagePath")]
        public ActionResult EidtSendPost(string orgCompanySeq, string pmYear, string monthly, string strPageType, string strTableName)
        {
            Dictionary<string, object> postData = new Dictionary<string, object>();
            Dictionary<string, string> ListPageUrl = new Dictionary<string, string> { };

            //var pmConfirm = pmConfirmStateViewRepo.selectView(new
            //{
            //    searchCpySeq = orgCompanySeq
            //                                            ,
            //    searchYear = pmYear
            //                                            ,
            //    searchMonth = monthly
            //}, strPageType, strTableName);
            //postData.Add("Seq", pmConfirm.seq);
            postData.Add("orgCompanySeq", orgCompanySeq);

            ListPageUrl.Add("CASH_FLOW", "/SiteMngHome/Performance/Cash_Flow/Edit");
            ListPageUrl.Add("PAL", "/SiteMngHome/Performance/Pal/Edit");
            ListPageUrl.Add("QUARTER_PAL", "/SiteMngHome/Performance/Quarter_Pal/Edit");
            ListPageUrl.Add("BS", "/SiteMngHome/Performance/BsNew/Edit");
            ListPageUrl.Add("BS_EX", "/SiteMngHome/Performance/BsEx/Edit");
            ListPageUrl.Add("INVEST", "/SiteMngHome/Performance/InvestNew/Edit");

            return RedirectAndPostActionResult.RedirectAndPost(ListPageUrl[strPageType], postData);
        }
    }
}