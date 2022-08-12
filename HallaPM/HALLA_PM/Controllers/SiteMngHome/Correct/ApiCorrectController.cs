using HALLA_PM.Core;
using HALLA_PM.Util;

using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using HALLA_PM.Models;
using Newtonsoft.Json;

namespace HALLA_PM.Controllers.SiteMngHome.Correct
{
    [AdminLoginFilter]
    [AuthAdminFilter(RequestAuthLevel = 1)] 
    public class ApiCorrectController : ApiController
    {
        [HttpPost]
        [Route("PlanMonthPalUpdate")]
        public object PlanMonthPalUpdate(JsonMonthPal obj)
        {
            PlanGroupdataYearRepo groupYearRepo = new PlanGroupdataYearRepo();
            PlanGroupdataPalMonthRepo palMonthRepo = new PlanGroupdataPalMonthRepo();
            PlanGroupdataPalQuarterRepo palQuarterRepo = new PlanGroupdataPalQuarterRepo();
            PlanGroupdataPalSummaryRepo palSummaryRepo = new PlanGroupdataPalSummaryRepo();
            

            clsReturnValues objReturn = new clsReturnValues();

            string strCallUser = SessionManager.GetAdminSession().insaUserV.userKey; 
               
            try
            {
                if (obj != null)
                    groupYearRepo.update(new {obj.seq, strComment = HttpContext.Server.UrlDecode(obj.strComment)});
                if (obj.MonthData != null)
                    foreach (var monthData in obj.MonthData)
                    {
                        palMonthRepo.updateSummary(monthData);
                    }
                if (obj.QuarterData != null)
                    foreach (var quarterData in obj.QuarterData)
                    {
                        palQuarterRepo.updateSummary(quarterData);
                    }
                if (obj.SummaryData != null)
                    foreach (var summaryData in obj.SummaryData)
                    {
                        palSummaryRepo.updateSummary(summaryData);
                    }
                objReturn.strResult_Code = "0";
                objReturn.strResult_Msg = "성공"; 
            }
            catch(Exception e)
            {
                objReturn.strResult_Code = "-1";
                objReturn.strResult_Msg = "실패: " + e.Message.ToString();
            }

            LogUtil.MngError("API PlanMonthPalUpdate:" + JsonConvert.SerializeObject(obj) + " 호출자:" + strCallUser);

            objReturn.strApi_Path = HttpContext.Request.Url.ToString();
            objReturn.strCall_User = strCallUser;
            return JsonConvert.SerializeObject(objReturn); 
        }

        [HttpPost]
        [Route("PlanGroupDataInvestUpdate")]
        public object PlanGroupDataInvestUpdate(JsonGroupDataInvest obj)
        {
            PlanGroupdataYearRepo groupYearRepo = new PlanGroupdataYearRepo();
            PlanGroupdataInvestMonthRepo investMonthRepo = new PlanGroupdataInvestMonthRepo();
            PlanGroupdataInvestSummaryRepo investSummaryRepo = new PlanGroupdataInvestSummaryRepo();

            clsReturnValues objReturn = new clsReturnValues();

            string strCallUser = SessionManager.GetAdminSession().insaUserV.userKey;

            try
            {
                if (obj != null)
                    groupYearRepo.update(new { obj.seq, strComment = HttpContext.Server.UrlDecode(obj.strComment) });
                if (obj.MonthData != null)
                    foreach (var monthData in obj.MonthData)
                    {
                        investMonthRepo.update(monthData);
                    }
           
                if (obj.SummaryData != null)
                    foreach (var summaryData in obj.SummaryData)
                    {
                        investSummaryRepo.update(summaryData);
                    }
                objReturn.strResult_Code = "0";
                objReturn.strResult_Msg = "성공";
            }
            catch (Exception e)
            {
                objReturn.strResult_Code = "-1";
                objReturn.strResult_Msg = "실패: " + e.Message.ToString();
            }

            LogUtil.MngError("API PlanMonthPalUpdate:" + JsonConvert.SerializeObject(obj) + " 호출자:" + strCallUser);

            objReturn.strApi_Path = HttpContext.Request.Url.ToString();
            objReturn.strCall_User = strCallUser;
            return JsonConvert.SerializeObject(objReturn);
        }

        [HttpPost]
        [Route("PlanGroupDataBsUpdate")]
        public object PlanGroupDataBsUpdate(JsonGroupDataBs obj)
        {
            PlanGroupdataYearRepo groupYearRepo = new PlanGroupdataYearRepo();
            PlanGroupdataBsMonthRepo bsMonthRepo = new PlanGroupdataBsMonthRepo();
            PlanGroupdataBsSummaryRepo bsSummaryRepo = new PlanGroupdataBsSummaryRepo();

            clsReturnValues objReturn = new clsReturnValues();

            string strCallUser = SessionManager.GetAdminSession().insaUserV.userKey;

            try
            {
                if (obj != null)
                    groupYearRepo.update(new { obj.seq, strComment = HttpContext.Server.UrlDecode(obj.strComment) });
                if (obj.MonthData != null)
                    foreach (var monthData in obj.MonthData)
                    {
                        bsMonthRepo.update(monthData);
                    }

                if (obj.SummaryData != null)
                    foreach (var summaryData in obj.SummaryData)
                    {
                        bsSummaryRepo.update(summaryData);
                    }
                objReturn.strResult_Code = "0";
                objReturn.strResult_Msg = "성공";
            }
            catch (Exception e)
            {
                objReturn.strResult_Code = "-1";
                objReturn.strResult_Msg = "실패: " + e.Message.ToString();
            }

            LogUtil.MngError("API PlanMonthPalUpdate:" + JsonConvert.SerializeObject(obj) + " 호출자:" + strCallUser);

            objReturn.strApi_Path = HttpContext.Request.Url.ToString();
            objReturn.strCall_User = strCallUser;
            return JsonConvert.SerializeObject(objReturn);
        }

        [HttpPost]
        [Route("PlanGroupDataCashflowUpdate")]
        public object PlanGroupDataCashflowUpdate(JsonGroupDataCashflow obj)
        {
            PlanGroupdataYearRepo groupYearRepo = new PlanGroupdataYearRepo();
            PlanGroupdataCashflowMonthRepo cashflowMonthRepo = new PlanGroupdataCashflowMonthRepo();
            //PlanGroupdataCashflowMonthCrRepo cashflowMonthCrRepo = new PlanGroupdataCashflowMonthCrRepo();
            //PlanGroupdataCashflowSummaryRepo cashflowSummaryRepo = new PlanGroupdataCashflowSummaryRepo();

            clsReturnValues objReturn = new clsReturnValues();

            string strCallUser = SessionManager.GetAdminSession().insaUserV.userKey;

            try
            {
                if (obj != null)
                    groupYearRepo.update(new { obj.seq, strComment = HttpContext.Server.UrlDecode(obj.strComment) });
                if (obj.MonthData != null)
                    foreach (var monthData in obj.MonthData)
                    {
                        cashflowMonthRepo.update(monthData);
                    }

                //if (obj.SummaryData != null)
                //    foreach (var summaryData in obj.SummaryData)
                //    {
                //        cashflowSummaryRepo.update(summaryData);
                //    }
                objReturn.strResult_Code = "0";
                objReturn.strResult_Msg = "성공";
            }
            catch (Exception e)
            {
                objReturn.strResult_Code = "-1";
                objReturn.strResult_Msg = "실패: " + e.Message.ToString();
            }

            LogUtil.MngError("API PlanMonthPalUpdate:" + JsonConvert.SerializeObject(obj) + " 호출자:" + strCallUser);

            objReturn.strApi_Path = HttpContext.Request.Url.ToString();
            objReturn.strCall_User = strCallUser;
            return JsonConvert.SerializeObject(objReturn);
        }

        [HttpPost]
        [Route("PmGroupDataCashflowUpdate")]
        public object PmGroupDataCashflowUpdate(JsonGroupDataPmCashflow obj)
        {
            PmGroupdataMonth groupMonth = new PmGroupdataMonth() { Seq = obj.seq, Comment = HttpContext.Server.UrlDecode(obj.strComment) };
            PmGroupdataMonthRepo groupMonthRepo = new PmGroupdataMonthRepo();
            PmGroupdataCashflowMonthRepo cashflowMonthRepo = new PmGroupdataCashflowMonthRepo();

            clsReturnValues objReturn = new clsReturnValues();

            string strCallUser = SessionManager.GetAdminSession().insaUserV.userKey;

            try
            {
                if (obj != null)
                    groupMonthRepo.update(groupMonth);
                if (obj.MonthData != null)
                    foreach (var monthData in obj.MonthData)
                    {
                        cashflowMonthRepo.update(monthData);
                    }

                objReturn.strResult_Code = "0";
                objReturn.strResult_Msg = "성공";
            }
            catch (Exception e)
            {
                objReturn.strResult_Code = "-1";
                objReturn.strResult_Msg = "실패: " + e.Message.ToString();
            }

            LogUtil.MngError("API PlanMonthPalUpdate:" + JsonConvert.SerializeObject(obj) + " 호출자:" + strCallUser);

            objReturn.strApi_Path = HttpContext.Request.Url.ToString();
            objReturn.strCall_User = strCallUser;
            return JsonConvert.SerializeObject(objReturn);
        }

        [HttpPost]
        [Route("PmGroupDataPalUpdate")]
        public object PmGroupDataPalUpdate(JsonGroupDataPmPal obj)
        {
            PmGroupdataMonth groupMonth = new PmGroupdataMonth() { Seq = obj.seq, Comment = HttpContext.Server.UrlDecode(obj.strComment) };
            PmGroupdataMonthRepo groupMonthRepo = new PmGroupdataMonthRepo();
            PmGroupdataPalMonthRepo palMonthRepo = new PmGroupdataPalMonthRepo();

            clsReturnValues objReturn = new clsReturnValues();

            string strCallUser = SessionManager.GetAdminSession().insaUserV.userKey;

            try
            {
                if (obj != null)
                    groupMonthRepo.update(groupMonth);
                if (obj.MonthData != null)
                    foreach (var monthData in obj.MonthData)
                    {
                        palMonthRepo.update(monthData);
                    }

                objReturn.strResult_Code = "0";
                objReturn.strResult_Msg = "성공";
            }
            catch (Exception e)
            {
                objReturn.strResult_Code = "-1";
                objReturn.strResult_Msg = "실패: " + e.Message.ToString();
            }

            LogUtil.MngError("API PlanMonthPalUpdate:" + JsonConvert.SerializeObject(obj) + " 호출자:" + strCallUser);

            objReturn.strApi_Path = HttpContext.Request.Url.ToString();
            objReturn.strCall_User = strCallUser;
            return JsonConvert.SerializeObject(objReturn);
        }


        [HttpPost]
        [Route("PmGroupDataQuarterPalUpdate")]
        public object PmGroupDataQuarterPalUpdate(JsonGroupDataPmQuarterPal obj)
        {
            PmGroupdataMonth groupMonth = new PmGroupdataMonth() { Seq = obj.seq, Comment = HttpContext.Server.UrlDecode(obj.strComment) };
            PmGroupdataMonthRepo groupMonthRepo = new PmGroupdataMonthRepo();
            PmGroupdataQuarterPalMonthRepo palMonthRepo = new PmGroupdataQuarterPalMonthRepo();

            clsReturnValues objReturn = new clsReturnValues();

            string strCallUser = SessionManager.GetAdminSession().insaUserV.userKey;

            try
            {
                if (obj != null)
                    groupMonthRepo.update(groupMonth);
                if (obj.MonthData != null)
                    foreach (var monthData in obj.MonthData)
                    {
                        palMonthRepo.update(monthData);
                    }

                objReturn.strResult_Code = "0";
                objReturn.strResult_Msg = "성공";
            }
            catch (Exception e)
            {
                objReturn.strResult_Code = "-1";
                objReturn.strResult_Msg = "실패: " + e.Message.ToString();
            }

            LogUtil.MngError("API PlanMonthPalUpdate:" + JsonConvert.SerializeObject(obj) + " 호출자:" + strCallUser);

            objReturn.strApi_Path = HttpContext.Request.Url.ToString();
            objReturn.strCall_User = strCallUser;
            return JsonConvert.SerializeObject(objReturn);
        }

        [HttpPost]
        [Route("PmGroupDataBsUpdate")]
        public object PmGroupDataBsUpdate(JsonGroupDataPmBs obj)
        {
            PmGroupdataMonth groupMonth = new PmGroupdataMonth() { Seq = obj.seq, Comment = HttpContext.Server.UrlDecode(obj.strComment) };
            PmGroupdataMonthRepo groupMonthRepo = new PmGroupdataMonthRepo();
            PmGroupdataBsMonthRepo bsMonthRepo = new PmGroupdataBsMonthRepo();

            clsReturnValues objReturn = new clsReturnValues();

            string strCallUser = SessionManager.GetAdminSession().insaUserV.userKey;

            try
            {
                if (obj != null)
                    groupMonthRepo.update(groupMonth);
                if (obj.MonthData != null)
                    foreach (var monthData in obj.MonthData)
                    {
                        bsMonthRepo.update(monthData);
                    }

                objReturn.strResult_Code = "0";
                objReturn.strResult_Msg = "성공";
            }
            catch (Exception e)
            {
                objReturn.strResult_Code = "-1";
                objReturn.strResult_Msg = "실패: " + e.Message.ToString();
            }

            LogUtil.MngError("API PlanMonthPalUpdate:" + JsonConvert.SerializeObject(obj) + " 호출자:" + strCallUser);

            objReturn.strApi_Path = HttpContext.Request.Url.ToString();
            objReturn.strCall_User = strCallUser;
            return JsonConvert.SerializeObject(objReturn);
        }

        [HttpPost]
        [Route("PmGroupDataInvestUpdate")] 
        public object PmGroupDataInvestUpdate(JsonGroupDataPmInvest obj)
        {
            PmGroupdataMonth groupMonth = new PmGroupdataMonth(){ Seq = obj.seq, Comment = HttpContext.Server.UrlDecode(obj.strComment) };
            PmGroupdataMonthRepo groupMonthRepo = new PmGroupdataMonthRepo();
            PmGroupdataInvestMonthRepo investMonthRepo = new PmGroupdataInvestMonthRepo(); 

            clsReturnValues objReturn = new clsReturnValues();            

            string strCallUser = SessionManager.GetAdminSession().insaUserV.userKey;

            try
            {
                if (obj != null)
                    groupMonthRepo.update(groupMonth);
                if (obj.MonthData != null)
                    foreach (var monthData in obj.MonthData)
                    {
                        investMonthRepo.update(monthData);
                    } 
                
                objReturn.strResult_Code = "0";
                objReturn.strResult_Msg = "성공";
            }
            catch (Exception e)
            {
                objReturn.strResult_Code = "-1";
                objReturn.strResult_Msg = "실패: " + e.Message.ToString();
            }

            LogUtil.MngError("API PlanMonthPalUpdate:" + JsonConvert.SerializeObject(obj) + " 호출자:" + strCallUser);

            objReturn.strApi_Path = HttpContext.Request.Url.ToString();
            objReturn.strCall_User = strCallUser;
            return JsonConvert.SerializeObject(objReturn);
        }

    }
}