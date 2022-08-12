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
    [RoutePrefix("SiteMngHome/Performance/InvestNew")]
    public class PmInvestNewController : SiteMngBaseController
    {
        [Route("List")]
        public ActionResult List(Search search)
        {
            dynamic model = new ExpandoObject();
            search.AuthUserKey = SessionManager.GetAdminSession().insaUserV.userKey;
            model.list = pmInvestRepo.selectListExp(search);
            model.UnionList = orgUnionRepo.selectList(new { });
            model.OrgCpyList = orgCompanyRepo.selectList(null);
            ViewBag.Search = search;

            return View("~/Views/SiteMngHome/Performance/InvestNew/list.cshtml", model);
        }

        [Route("Write")]
        public ActionResult Write(PmInvestExp entity, Search search)
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");

            // 기본정보가져오기
            PmInvest pmInvest = pmInvestRepo.selectOne(entity);
            List<OrgBusiness> orgBusinessList = orgBusinessRepo.selectListCompany(new { Seq = entity.OrgCompanySeq }).ToList();
            OrgCompany orgCompanyName = orgCompanyRepo.selectOne(new { Seq = entity.OrgCompanySeq });

            foreach (var business in orgBusinessList)
            {
                PmInvestBusiness p = new PmInvestBusiness();
                p.PmInvestSeq = entity.Seq;
                p.OrgBusinessSeq = business.Seq;
                p.Investment = 0;
                p.Personnel = 0;
                p.DomesticPersonnel = 0;
                p.OverseasPersonnel = 0;
                // 당월
                p.MonthlyType = Define.MONTHLY_TYPE.GetKey("당월");

                string where = " WHERE PM_INVEST_SEQ = @PmInvestSeq AND ORG_BUSINESS_SEQ = @OrgBusinessSeq AND MONTHLY_TYPE = @MonthlyType ";
                if (pmInvestBusinessRepo.count(p, where) == 0) { pmInvestBusinessRepo.insert(p); }
                // 누계
                p.MonthlyType = Define.MONTHLY_TYPE.GetKey("누계");

                where = " WHERE PM_INVEST_SEQ = @PmInvestSeq AND ORG_BUSINESS_SEQ = @OrgBusinessSeq AND MONTHLY_TYPE = @MonthlyType ";
                if (pmInvestBusinessRepo.count(p, where) == 0) { pmInvestBusinessRepo.insert(p); }
            }

            // 전년도 실적 정보
            List<PmInvestBusiness> lastYearPm = pmInvestBusinessRepo.selectListYear(new { InvestYear = pmInvest.InvestYear })
                .Where(w => w.OrgCompanySeq == entity.OrgCompanySeq).ToList();
            // 당해년도 연간 계획 정보
            List<PlanYearInvestBusiness> thisYearPn = planYearInvestBusinessRepo.selectListYear(new { YearInvestYear = pmInvest.InvestYear })
                .Where(w => w.OrgCompanySeq == entity.OrgCompanySeq).ToList();
            // 당해년도 월별 계획 정보
            List<PlanMonthlyInvestBusinessExp> thisYearMonPn = planMonthlyInvestBusinessRepo.selectListYear(new { YearInvestYear = pmInvest.InvestYear })
                .Where(w=> w.OrgCompanySeq == entity.OrgCompanySeq).ToList();
            // 당해년도 실적 정보
            List<PmInvestBusiness> thisYearPm = pmInvestBusinessRepo.selectList(new { PmInvestSeq = entity.Seq }).ToList();


            dynamic model = new ExpandoObject();

            model.pmInvest = pmInvest;
            model.orgBusinessList = orgBusinessList;
            model.orgCompanyName = orgCompanyName;
            model.lastYearPm = lastYearPm;
            model.thisYearPn = thisYearPn;
            model.thisYearMonPn = thisYearMonPn;
            model.thisYearPm = thisYearPm;

            ViewBag.Search = search;
            return View("~/Views/SiteMngHome/Performance/InvestNew/Write.cshtml", model);
        }

        [Route("Excel_Down")]
        public ActionResult ExcelDown(PmInvest entity)
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");

            // 기본정보가져오기
            PmInvest pmInvest = pmInvestRepo.selectOne(entity);
            List<OrgBusiness> orgBusinessList = orgBusinessRepo.selectListCompany(new { Seq = entity.OrgCompanySeq }).ToList();
            OrgCompany orgCompanyName = orgCompanyRepo.selectOne(new { Seq = entity.OrgCompanySeq });
            List<PmInvestBusiness> pBusinessList = pmInvestBusinessRepo.selectListExcel(new { PmInvestSeq = entity.Seq }).ToList();
            string fileName = "투자인원_" + pmInvest.InvestYear + "년_" + orgCompanyName.CompanyName;

            int rows = 1, cells = 1;

            using (XLWorkbook wb = new XLWorkbook())
            {
                var ws = wb.Worksheets.Add("투자인원");
                
                // 컬럼 숨기기
                ws.Column(1).Hide();
                ws.Column(2).Hide();
                ws.Column(4).Hide();

                ws.Cell(rows, cells).SetValue("ParentSeq").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                ws.Cell(rows, ++cells).SetValue("Seq").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                ws.Cell(rows, ++cells).SetValue("CompanyName").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                ws.Cell(rows, ++cells).SetValue("BusinessSeq").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                ws.Cell(rows, ++cells).SetValue("BusinessName").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                ws.Cell(rows, ++cells).SetValue("년").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                ws.Cell(rows, ++cells).SetValue("월").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                ws.Cell(rows, ++cells).SetValue("누계구분").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                ws.Cell(rows, ++cells).SetValue("투자").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                ws.Cell(rows, ++cells).SetValue("인원").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                ws.Cell(rows, ++cells).SetValue("국내인원").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                ws.Cell(rows, ++cells).SetValue("해외인원").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                foreach (var item in pBusinessList)
                {
                    rows++;
                    cells = 1;
                    ws.Cell(rows, cells).SetValue(item.PmInvestSeq).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    ws.Cell(rows, ++cells).SetValue(item.Seq).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    ws.Cell(rows, ++cells).SetValue(item.CompanyName).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    ws.Cell(rows, ++cells).SetValue(item.OrgBusinessSeq).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    ws.Cell(rows, ++cells).SetValue(item.BusinessName).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    ws.Cell(rows, ++cells).SetValue(item.InvestYear).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    ws.Cell(rows, ++cells).SetValue(item.Monthly).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    ws.Cell(rows, ++cells).SetValue(Define.MONTHLY_TYPE.GetValue(item.MonthlyType)).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                    ws.Cell(rows, ++cells).SetValue(item.Investment).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    ws.Cell(rows, ++cells).SetValue(item.Personnel).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    ws.Cell(rows, ++cells).SetValue(item.DomesticPersonnel).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    ws.Cell(rows, ++cells).SetValue(item.OverseasPersonnel).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                }

                using (MemoryStream mStream = new MemoryStream())
                {
                    wb.SaveAs(mStream);
                    return File(mStream.ToArray(), "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", fileName + ".xlsx");
                }
            }
        }



        [Route("Excel_Down2")]
        public ActionResult ExcelDown2(PmInvest entity)
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");

            // 기본정보가져오기
            PmInvest pmInvest = pmInvestRepo.selectOne(entity);
            List<OrgBusiness> orgBusinessList = orgBusinessRepo.selectListCompany(new { Seq = entity.OrgCompanySeq }).ToList();
            OrgCompany orgCompanyName = orgCompanyRepo.selectOne(new { Seq = entity.OrgCompanySeq });
            List<PmInvestBusiness> pBusinessList = pmInvestBusinessRepo.selectListExcel(new { PmInvestSeq = entity.Seq }).ToList();
            string fileName = "투자인원_" + pmInvest.InvestYear + "년_" + orgCompanyName.CompanyName;

            int rows = 1, cells = 1;

            using (XLWorkbook wb = new XLWorkbook())
            {
                var ws = wb.Worksheets.Add("투자인원");

                // 컬럼 숨기기
                //ws.Column(1).Hide();
                //ws.Column(2).Hide();
                ws.Column(2).Hide();

                //ws.Cell(rows, cells).SetValue("ParentSeq").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
               // ws.Cell(rows, ++cells).SetValue("Seq").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                ws.Cell(rows, cells).SetValue("CompanyName").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                ws.Cell(rows, ++cells).SetValue("BusinessSeq").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                ws.Cell(rows, ++cells).SetValue("BusinessName").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                ws.Cell(rows, ++cells).SetValue("년").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                ws.Cell(rows, ++cells).SetValue("월").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                ws.Cell(rows, ++cells).SetValue("누계구분").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                ws.Cell(rows, ++cells).SetValue("투자").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                ws.Cell(rows, ++cells).SetValue("인원").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                ws.Cell(rows, ++cells).SetValue("국내인원").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                ws.Cell(rows, ++cells).SetValue("해외인원").Style.Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                foreach (var item in pBusinessList)
                {
                    rows++;
                    cells = 1;
                    //ws.Cell(rows, cells).SetValue(item.PmInvestSeq).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    //ws.Cell(rows, ++cells).SetValue(item.Seq).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    ws.Cell(rows, cells).SetValue(item.CompanyName).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    ws.Cell(rows, ++cells).SetValue(item.OrgBusinessSeq).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    ws.Cell(rows, ++cells).SetValue(item.BusinessName).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    ws.Cell(rows, ++cells).SetValue(item.InvestYear).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    ws.Cell(rows, ++cells).SetValue(item.Monthly).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    ws.Cell(rows, ++cells).SetValue(Define.MONTHLY_TYPE.GetValue(item.MonthlyType)).Style.Fill.SetBackgroundColor(XLColor.NoColor).Border.SetOutsideBorder(XLBorderStyleValues.Thin);

                    ws.Cell(rows, ++cells).SetValue(item.Investment).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    ws.Cell(rows, ++cells).SetValue(item.Personnel).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    ws.Cell(rows, ++cells).SetValue(item.DomesticPersonnel).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
                    ws.Cell(rows, ++cells).SetValue(item.OverseasPersonnel).Style.Fill.SetBackgroundColor(XLColor.Yellow).Border.SetOutsideBorder(XLBorderStyleValues.Thin);
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

            bool result = false;
            string resultMsg = "";
            if (ExcelFile.ContentLength != 0)
            {
                FileUtil fileUtil = new FileUtil(Define.FILE_PATH);
                string filePath = "PmInvestNew";
                var file = fileUtil.FileUpload(ExcelFile, filePath);


                bool bDoubleValue = true;
                ExcelUtil excelUtil = new ExcelUtil();
                var dt = excelUtil.ImportExcel(file["FILE_PATH"]);
                List<PmInvestBusiness> pBusinessList = new List<PmInvestBusiness>();
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

                        string Investment = item.ItemArray.GetValue(8).ToString();
                        string Personnel = item.ItemArray.GetValue(9).ToString();
                        string DomesticPersonnel = item.ItemArray.GetValue(10).ToString();
                        string OverseasPersonnel = item.ItemArray.GetValue(11).ToString();
                        if (parentSeq != Seq.ToString()) { bDoubleValue = false; break; }       // 현재 코드와 업로드하려는 코드가 다른 경우는 양식이 잘못된것으로 오류
                        //if (!WebUtil.CheckDecimalTwo(Investment)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(Personnel)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(DomesticPersonnel)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(OverseasPersonnel)) { bDoubleValue = false; break; }

                        PmInvestBusiness pBusiness = new PmInvestBusiness();
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
                    // 오류시 파일 삭제
                    fileUtil.FileDelete(filePath, file["STORED_FILE_NAME"]);
                    result = false;
                    resultMsg = Message.MSG_007_E;
                    return Json(new { success = result, resultMsg = resultMsg }, JsonRequestBehavior.AllowGet);
                }
                // 문제 없으면 업데이트
                foreach (var item in pBusinessList)
                {
                    pmInvestBusinessRepo.update(item);
                }

                // 업데이트 완료 후 로그 남기기
                ExcelFileUploadList eFileList = new ExcelFileUploadList();
                eFileList.UserKey = SessionManager.GetAdminSession().insaUserV.userKey;
                eFileList.EmpNo = SessionManager.GetAdminSession().insaUserV.empNo;
                eFileList.AttachTableName = "PM_INVEST";
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
        public ActionResult CalculationAction(PmInvestAdmin entity, Search search)
        {
            #region
            Dictionary<string, object> postData = new Dictionary<string, object>();
            postData.Add("Seq", entity.Seq);
            postData.Add("OrgCompanySeq", entity.OrgCompanySeq);
            postData.Add("PageIndex", search.PageIndex);
            #endregion

            // 부서별 데이터 검증(정수 혹은 소수점 2자리까지의 데이터)
            bool bDoubleValue = true;
            List<PmInvestBusiness> pBusinessList = new List<PmInvestBusiness>();
            try
            {
                for (int i = 0; i < entity.PmInvestBusinessSeq.Count(); i++)
                {
                    if (!WebUtil.CheckDecimalTwo(entity.Investment[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.Personnel[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.DomesticPersonnel[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.OverseasPersonnel[i].ToString())) { bDoubleValue = false; break; }

                    PmInvestBusiness p = new PmInvestBusiness();
                    p.Seq = entity.PmInvestBusinessSeq[i];
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

            // 부서별 데이터 업데이트
            foreach (var item in pBusinessList)
            {
                pmInvestBusinessRepo.update(item);
            }
            // 계산하기 하였을 경우 기존 데이터 삭제하여 부서별 데이터의 합계를 다시 입력
            PmInvestSum pSum = new PmInvestSum();
            pSum.PmInvestSeq = entity.Seq;
            pmInvestSumRepo.delete(pSum);
            pmInvestSumRepo.insertCum(pSum);

            return RedirectAndPostActionResult.RedirectAndPost("Edit", postData);
        }

        [Route("Regist_Status_Change")]
        public ActionResult RegistStatusChange(PmInvest entity, Search search)
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
            pmInvestRepo.updateRegist(entity);

            // 현재의 상태 변경 후 담당자들에게 메일 발송합니다.(2018.11.08)
            var info = pmInvestRepo.selectOne(entity);

            MailInfo mInfo = new MailInfo();
            // 2019.01.13 결제라인 추가
            mInfo.Seq = entity.Seq;
            mInfo.ReferUrl = Request.UrlReferrer.AbsolutePath.ToString();
            mInfo.afterRegistStatus = entity.afterRegistStatus;
            mInfo.OrgCompanySeq = entity.OrgCompanySeq;
            mInfo.menuName = "투자인원";
            mInfo.year = info.InvestYear;
            mInfo.mm = info.Monthly;
            // 2018.01.03 반려사유 추가
            mInfo.RejectReson = entity.RejectReson;
            // MailUtil.RegistStatusMail(mInfo);
            MailUtilNew.AllComfirmMaillSender(mInfo); /*메일 발송*/

            // 최종승인의 경우. 다른 모든 회사와 메뉴가 최종승인 되었는지 체크하여. 푸시알림을 보낸다.
            if (entity.RegistStatus == Define.REGIST_STATUS.GetKey("최종승인"))
            {
                //RegistYearListRepo rYearListRepo = new RegistYearListRepo();
                //List<RegistYearList> registYearPm = rYearListRepo.selectListPm(new { }).ToList();

                //string year = info.InvestYear;
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

        [Route("Edit")]
        public ActionResult Edit(PmInvest entity, Search search)
        {

            if (Request.RequestType == "GET") return RedirectToAction("List");

            // 기본정보가져오기
            PmInvest pmInvest = pmInvestRepo.selectOne(entity);
            //List<OrgBusiness> orgBusinessList = orgBusinessRepo.selectListCompany(new { Seq = entity.OrgCompanySeq }).ToList();
            List<OrgBusiness> orgBusinessList = orgBusinessRepo.selectListAll(new { orgCompanySeq = entity.OrgCompanySeq }).ToList();
            OrgCompany orgCompanyName = orgCompanyRepo.selectOne(new { Seq = entity.OrgCompanySeq });

            //foreach (var business in orgBusinessList)
            //{
            //    PmInvestBusiness p = new PmInvestBusiness();
            //    p.PmInvestSeq = entity.Seq;
            //    p.OrgBusinessSeq = business.Seq;
            //    p.Investment = 0;
            //    p.Personnel = 0;
            //    p.DomesticPersonnel = 0;
            //    p.OverseasPersonnel = 0;
            //    // 당월
            //    p.MonthlyType = Define.MONTHLY_TYPE.GetKey("당월");

            //    string where = " WHERE PM_INVEST_SEQ = @PmInvestSeq AND ORG_BUSINESS_SEQ = @OrgBusinessSeq AND MONTHLY_TYPE = @MonthlyType ";
            //    if (pmInvestBusinessRepo.count(p, where) == 0) { pmInvestBusinessRepo.insert(p); }
            //    // 누계
            //    p.MonthlyType = Define.MONTHLY_TYPE.GetKey("누계");

            //    where = " WHERE PM_INVEST_SEQ = @PmInvestSeq AND ORG_BUSINESS_SEQ = @OrgBusinessSeq AND MONTHLY_TYPE = @MonthlyType ";
            //    if (pmInvestBusinessRepo.count(p, where) == 0) { pmInvestBusinessRepo.insert(p); }
            //}

            // 전년도 실적 정보
            List<PmInvestBusiness> lastYearPm = pmInvestBusinessRepo.selectListYear(new { InvestYear = pmInvest.InvestYear })
                .Where(w => w.OrgCompanySeq == entity.OrgCompanySeq).ToList();
            // 당해년도 연간 계획 정보
            List<PlanYearInvestBusiness> thisYearPn = planYearInvestBusinessRepo.selectListYear(new { YearInvestYear = pmInvest.InvestYear })
                .Where(w => w.OrgCompanySeq == entity.OrgCompanySeq).ToList();
            // 당해년도 월별 계획 정보
            List<PlanMonthlyInvestBusinessExp> thisYearMonPn = planMonthlyInvestBusinessRepo.selectListYear(new { YearInvestYear = pmInvest.InvestYear })
                .Where(w => w.OrgCompanySeq == entity.OrgCompanySeq).ToList();
            // 당해년도 실적 정보
            List<PmInvestBusiness> thisYearPm = pmInvestBusinessRepo.selectList(new { PmInvestSeq = entity.Seq }).ToList();

            // 현재기준의 Bu만 조인하여 넣는다.
            var orgBusinessList2 = from x in orgBusinessList
                                   join y in thisYearPm on x.Seq equals y.OrgBusinessSeq
                                   group x by new { x.Seq, x.BusinessName } into g
                                   select new OrgBusiness
                                   {
                                       Seq = g.First().Seq,
                                       BusinessName = g.First().BusinessName
                                   };
            orgBusinessList = orgBusinessList2.ToList();

            // 손익요약
            // 전년도 실적 정보
            List<PmInvestSum> lastYearPmSum = pmInvestSumRepo.selectListYear(new { InvestYear = pmInvest.InvestYear })
                .Where(w => w.OrgCompanySeq == entity.OrgCompanySeq).ToList();
            // 당해년도 연간 계획정보
            List<PlanYearInvestSummary> thisYearPnSum = planYearInvestSummaryRepo.selectListYear(new { YearInvestYear = pmInvest.InvestYear, OrgCompanySeq = entity.OrgCompanySeq }).ToList();
            // 당해년도 월별 계획정보
            List<PlanMonthlyInvestSummary> thisYearMonPnSum = planMonthlyInvestSummaryRepo.selectListYear(new { YearInvestYear = pmInvest.InvestYear, OrgCompanySeq = entity.OrgCompanySeq }).ToList();
            // 당해년도 실적 정보
            List<PmInvestSum> thisYearPmSum = pmInvestSumRepo.selectList(new { PmInvestSeq = entity.Seq }).ToList();

            dynamic model = new ExpandoObject();

            model.pmInvest = pmInvest;
            model.orgBusinessList = orgBusinessList;
            model.orgCompanyName = orgCompanyName;

            model.lastYearPm = lastYearPm;
            model.thisYearPn = thisYearPn;
            model.thisYearMonPn = thisYearMonPn;
            model.thisYearPm = thisYearPm;

            model.lastYearPmSum = lastYearPmSum;
            model.thisYearPnSum = thisYearPnSum;
            model.thisYearMonPnSum = thisYearMonPnSum;
            model.thisYearPmSum = thisYearPmSum;

            ViewBag.Search = search;
            return View("~/Views/SiteMngHome/Performance/InvestNew/Edit.cshtml", model);
        }

        [Route("Edit2")]
        public ActionResult Edit2(PmInvest entity, Search search)
        {

            if (Request.RequestType == "GET") return RedirectToAction("List");

            // 기본정보가져오기
            PmInvest pmInvest = pmInvestRepo.selectOne(entity);
            //List<OrgBusiness> orgBusinessList = orgBusinessRepo.selectListCompany(new { Seq = entity.OrgCompanySeq }).ToList();
            List<OrgBusiness> orgBusinessList = orgBusinessRepo.selectListAll(new { orgCompanySeq = entity.OrgCompanySeq }).ToList();
            OrgCompany orgCompanyName = orgCompanyRepo.selectOne(new { Seq = entity.OrgCompanySeq });
            
            // 손익요약
            // 전년도 실적 정보
            List<PmInvestSum> lastYearPmSum = pmInvestSumRepo.selectListYear(new { InvestYear = pmInvest.InvestYear })
                .Where(w => w.OrgCompanySeq == entity.OrgCompanySeq).ToList();
            // 당해년도 연간 계획정보
            List<PlanYearInvestSummary> thisYearPnSum = planYearInvestSummaryRepo.selectListYear(new { YearInvestYear = pmInvest.InvestYear, OrgCompanySeq = entity.OrgCompanySeq }).ToList();
            // 당해년도 월별 계획정보
            List<PlanMonthlyInvestSummary> thisYearMonPnSum = planMonthlyInvestSummaryRepo.selectListYear(new { YearInvestYear = pmInvest.InvestYear, OrgCompanySeq = entity.OrgCompanySeq }).ToList();
            // 당해년도 실적 정보
            List<PmInvestSum> thisYearPmSum = pmInvestSumRepo.selectList(new { PmInvestSeq = entity.Seq }).ToList();

            dynamic model = new ExpandoObject();

            model.pmInvest = pmInvest;
            model.orgBusinessList = orgBusinessList;
            model.orgCompanyName = orgCompanyName;

            model.lastYearPmSum = lastYearPmSum;
            model.thisYearPnSum = thisYearPnSum;
            model.thisYearMonPnSum = thisYearMonPnSum;
            model.thisYearPmSum = thisYearPmSum;

            ViewBag.Search = search;
            return View("~/Views/SiteMngHome/Performance/InvestNew/Edit2.cshtml", model);
        }

        [Route("Edit_Action")]
        public ActionResult EditAction(PmInvestAdmin entity, Search search)
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
            List<PmInvestBusiness> pBusinessList = new List<PmInvestBusiness>();
            List<PmInvestSum> pSummaryList = new List<PmInvestSum>();

            try
            {
                for (int i = 0; i < entity.PmInvestBusinessSeq.Count(); i++)
                {
                    if (!WebUtil.CheckDecimalTwo(entity.Investment[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.Personnel[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.DomesticPersonnel[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.OverseasPersonnel[i].ToString())) { bDoubleValue = false; break; }

                    PmInvestBusiness p = new PmInvestBusiness();
                    p.Seq = entity.PmInvestBusinessSeq[i];
                    p.Investment = entity.Investment[i];
                    p.Personnel = entity.Personnel[i];
                    p.DomesticPersonnel = entity.DomesticPersonnel[i];
                    p.OverseasPersonnel = entity.OverseasPersonnel[i];

                    pBusinessList.Add(p);
                }

                for (int i = 0; i < entity.PmInvestSumSeq.Count(); i++)
                {
                    if (!WebUtil.CheckDecimalTwo(entity.SummaryInvestment[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.SummaryPersonnel[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.SummaryDomesticPersonnel[i].ToString())) { bDoubleValue = false; break; }
                    if (!WebUtil.CheckDecimalTwo(entity.SummaryOverseasPersonnel[i].ToString())) { bDoubleValue = false; break; }

                    PmInvestSum p = new PmInvestSum();
                    p.Seq = entity.PmInvestSumSeq[i];
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
                pmInvestBusinessRepo.update(item);
            }

            foreach (var item in pSummaryList)
            {
                pmInvestSumRepo.update(item);
            }

            // 미저장에서 저장으로 변경
            if (entity.RegistStatus == Define.REGIST_STATUS.GetKey("미등록"))
            {
                entity.RegistStatus = Define.REGIST_STATUS.GetKey("저장");
                PmInvest p = new PmInvest();
                p.Seq = entity.Seq;
                p.RegistStatus = entity.RegistStatus;
                pmInvestRepo.updateRegist(p);
            }

            return RedirectAndPostActionResult.RedirectAndPost("Edit", postData);
        }

        [Route("View")]
        public ActionResult view(PmInvest entity, Search search)
        {

            if (Request.RequestType == "GET") return RedirectToAction("List");

            // 기본정보가져오기
            PmInvest pmInvest = pmInvestRepo.selectOne(entity);
            List<OrgBusiness> orgBusinessList = orgBusinessRepo.selectListCompany(new { Seq = entity.OrgCompanySeq }).ToList();
            OrgCompany orgCompanyName = orgCompanyRepo.selectOne(new { Seq = entity.OrgCompanySeq });

            //foreach (var business in orgBusinessList)
            //{
            //    PmInvestBusiness p = new PmInvestBusiness();
            //    p.PmInvestSeq = entity.Seq;
            //    p.OrgBusinessSeq = business.Seq;
            //    p.Investment = 0;
            //    p.Personnel = 0;
            //    p.DomesticPersonnel = 0;
            //    p.OverseasPersonnel = 0;
            //    // 당월
            //    p.MonthlyType = Define.MONTHLY_TYPE.GetKey("당월");

            //    string where = " WHERE PM_INVEST_SEQ = @PmInvestSeq AND ORG_BUSINESS_SEQ = @OrgBusinessSeq AND MONTHLY_TYPE = @MonthlyType ";
            //    if (pmInvestBusinessRepo.count(p, where) == 0) { pmInvestBusinessRepo.insert(p); }
            //    // 누계
            //    p.MonthlyType = Define.MONTHLY_TYPE.GetKey("누계");

            //    where = " WHERE PM_INVEST_SEQ = @PmInvestSeq AND ORG_BUSINESS_SEQ = @OrgBusinessSeq AND MONTHLY_TYPE = @MonthlyType ";
            //    if (pmInvestBusinessRepo.count(p, where) == 0) { pmInvestBusinessRepo.insert(p); }
            //}

            // 전년도 실적 정보
            List<PmInvestBusiness> lastYearPm = pmInvestBusinessRepo.selectListYear(new { InvestYear = pmInvest.InvestYear })
                .Where(w => w.OrgCompanySeq == entity.OrgCompanySeq).ToList();
            // 당해년도 연간 계획 정보
            List<PlanYearInvestBusiness> thisYearPn = planYearInvestBusinessRepo.selectListYear(new { YearInvestYear = pmInvest.InvestYear })
                .Where(w => w.OrgCompanySeq == entity.OrgCompanySeq).ToList();
            // 당해년도 월별 계획 정보
            List<PlanMonthlyInvestBusinessExp> thisYearMonPn = planMonthlyInvestBusinessRepo.selectListYear(new { YearInvestYear = pmInvest.InvestYear })
                .Where(w => w.OrgCompanySeq == entity.OrgCompanySeq).ToList();
            // 당해년도 실적 정보
            List<PmInvestBusiness> thisYearPm = pmInvestBusinessRepo.selectList(new { PmInvestSeq = entity.Seq }).ToList();

            // 현재기준의 Bu만 조인하여 넣는다.
            var orgBusinessList2 = from x in orgBusinessList
                                   join y in thisYearPm on x.Seq equals y.OrgBusinessSeq
                                   group x by new { x.Seq, x.BusinessName } into g
                                   select new OrgBusiness
                                   {
                                       Seq = g.First().Seq,
                                       BusinessName = g.First().BusinessName
                                   };
            orgBusinessList = orgBusinessList2.ToList();

            // 손익요약
            // 전년도 실적 정보
            List<PmInvestSum> lastYearPmSum = pmInvestSumRepo.selectListYear(new { InvestYear = pmInvest.InvestYear }).Where(w => w.OrgCompanySeq == entity.OrgCompanySeq).ToList();
            // 당해년도 연간 계획정보
            List<PlanYearInvestSummary> thisYearPnSum = planYearInvestSummaryRepo.selectListYear(new { YearInvestYear = pmInvest.InvestYear, OrgCompanySeq = entity.OrgCompanySeq }).ToList();
            // 당해년도 월별 계획정보
            List<PlanMonthlyInvestSummary> thisYearMonPnSum = planMonthlyInvestSummaryRepo.selectListYear(new { YearInvestYear = pmInvest.InvestYear, OrgCompanySeq = entity.OrgCompanySeq }).ToList();
            // 당해년도 실적 정보
            List<PmInvestSum> thisYearPmSum = pmInvestSumRepo.selectList(new { PmInvestSeq = entity.Seq }).ToList();

            dynamic model = new ExpandoObject();

            model.pmInvest = pmInvest;
            model.orgBusinessList = orgBusinessList;
            model.orgCompanyName = orgCompanyName;

            model.lastYearPm = lastYearPm;
            model.thisYearPn = thisYearPn;
            model.thisYearMonPn = thisYearMonPn;
            model.thisYearPm = thisYearPm;

            model.lastYearPmSum = lastYearPmSum;
            model.thisYearPnSum = thisYearPnSum;
            model.thisYearMonPnSum = thisYearMonPnSum;
            model.thisYearPmSum = thisYearPmSum;

            ViewBag.Search = search;
            return View("~/Views/SiteMngHome/Performance/InvestNew/View.cshtml", model);
        }

        [Route("Excel_Upload2")]
        public ActionResult ExcelUpload2(int Seq, int OrgCompanySeq, List<int> PmInvestBusinessSeq, HttpPostedFileBase ExcelFile)
        {

            bool result = false;
            string resultMsg = "";
            if (ExcelFile.ContentLength != 0)
            {
                FileUtil fileUtil = new FileUtil(Define.FILE_PATH);
                string filePath = "PmInvestNew";
                var file = fileUtil.FileUpload(ExcelFile, filePath);


                bool bDoubleValue = true;
                ExcelUtil excelUtil = new ExcelUtil();
                var dt = excelUtil.ImportExcel(file["FILE_PATH"]);
                List<PmInvestBusiness> pBusinessList = new List<PmInvestBusiness>();
                try
                {
                    int j = 0;
                    foreach (DataRow item in dt.Rows)
                    {
                        //string parentSeq = item.ItemArray.GetValue(0).ToString();
                        string excelSeq = PmInvestBusinessSeq[j].ToString();

                        string Investment = item.ItemArray.GetValue(6).ToString();
                        string Personnel = item.ItemArray.GetValue(7).ToString();
                        string DomesticPersonnel = item.ItemArray.GetValue(8).ToString();
                        string OverseasPersonnel = item.ItemArray.GetValue(9).ToString();
                        //string companyName = item.ItemArray.GetValue(2).ToString();
                        //string businessSeq = item.ItemArray.GetValue(3).ToString();
                        // string businessName = item.ItemArray.GetValue(4).ToString();
                        // string PalYear = item.ItemArray.GetValue(5).ToString();
                        //string Monthly = item.ItemArray.GetValue(6).ToString();
                        // string MonthlyType = item.ItemArray.GetValue(7).ToString();

                        //string Investment = item.ItemArray.GetValue(8).ToString();
                        //string Personnel = item.ItemArray.GetValue(9).ToString();
                        //string DomesticPersonnel = item.ItemArray.GetValue(10).ToString();
                        //string OverseasPersonnel = item.ItemArray.GetValue(11).ToString();
                        //if (parentSeq != Seq.ToString()) { bDoubleValue = false; break; }       // 현재 코드와 업로드하려는 코드가 다른 경우는 양식이 잘못된것으로 오류
                        //if (!WebUtil.CheckDecimalTwo(Investment)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(Personnel)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(DomesticPersonnel)) { bDoubleValue = false; break; }
                        //if (!WebUtil.CheckDecimalTwo(OverseasPersonnel)) { bDoubleValue = false; break; }

                        PmInvestBusiness pBusiness = new PmInvestBusiness();
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
                    // 오류시 파일 삭제
                    fileUtil.FileDelete(filePath, file["STORED_FILE_NAME"]);
                    result = false;
                    resultMsg = Message.MSG_007_E;
                    return Json(new { success = result, resultMsg = resultMsg }, JsonRequestBehavior.AllowGet);
                }
                // 문제 없으면 업데이트
                foreach (var item in pBusinessList)
                {
                    pmInvestBusinessRepo.update(item);
                }

                // 업데이트 완료 후 로그 남기기
                ExcelFileUploadList eFileList = new ExcelFileUploadList();
                eFileList.UserKey = SessionManager.GetAdminSession().insaUserV.userKey;
                eFileList.EmpNo = SessionManager.GetAdminSession().insaUserV.empNo;
                eFileList.AttachTableName = "PM_INVEST";
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