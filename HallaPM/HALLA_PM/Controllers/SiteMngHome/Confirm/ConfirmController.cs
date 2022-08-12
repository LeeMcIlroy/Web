using Fluentx.Mvc;
using HALLA_PM.Core;
using HALLA_PM.Models;
using HALLA_PM.Models.Confirm;
using HALLA_PM.Util;
using System.Collections.Generic;
using System.Dynamic;
using System.Web.Mvc;

namespace HALLA_PM.Controllers.SiteMngHome.Confirm
{
    [AdminLoginFilter]
    [AuthAdminFilter(RequestAuthLevel = 2)]
    [RoutePrefix("SiteMngHome/Confirm")]
    public class ConfirmController : Controller
    {
        ConfirmAllViewRepo confirmAllViewRepo = new ConfirmAllViewRepo();
        OrgCompanyRepo orgCompanyRepo = new OrgCompanyRepo();
        PmConfirmStateViewRepo pmConfirmStateViewRepo = new PmConfirmStateViewRepo();
        OrgUnionRepo orgUnionRepo = new OrgUnionRepo();
        [Route("BuList")]
        public ActionResult BuList(Search search)
        {
            dynamic model = new ExpandoObject();
            search.AuthUserKey = SessionManager.GetAdminSession().insaUserV.userKey;
            model.list = confirmAllViewRepo.selectList(search);
            model.totalCount = confirmAllViewRepo.totalCount(search);
            model.OrgCpyList = orgCompanyRepo.selectList(null);
            ViewBag.Search = search; 
            return View("~/Views/SiteMngHome/Confirm/BuList.cshtml",model);
        }
        [Route("PmList")]
        public ActionResult PmList(Search search)
        {
            
            dynamic model = new ExpandoObject();
            search.AuthUserKey = SessionManager.GetAdminSession().insaUserV.userKey;
            model.list = pmConfirmStateViewRepo.selectList(search);
            model.totalCount = pmConfirmStateViewRepo.count(search);
            model.UnionList = orgUnionRepo.selectList(new{ });
            model.OrgCpyList = orgCompanyRepo.selectList(null);
            ViewBag.Search = search;

            return View("~/Views/SiteMngHome/Confirm/PmList.cshtml", model);
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

            objReject = pmConfirmStateViewRepo.selectOne(new { searchCpySeq = objLog.orgCompanySeq
                                                               ,searchYear = objLog.pmYear
                                                               , searchMonth = objLog.monthly });
          

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
                intResult = pmConfirmStateViewRepo.statusChangeAll(objLog);
                
                MailInfo objMailinfo = new MailInfo();
                objMailinfo.OrgCompanySeq = objLog.orgCompanySeq;
                objMailinfo.year = objLog.pmYear;
                objMailinfo.mm = objLog.monthly;
                objMailinfo.afterRegistStatus = objLog.confirmStatus;
                objMailinfo.RejectReson = objLog.confirmComment;
                objMailinfo.Seq = objLog.seq;
                objMailinfo.objPmSeq = new Dictionary<string,int>();
                pmconfirmViewList = pmconfirmViewRepo.selectSeqList(new {orgCompanySeq = objLog.orgCompanySeq
                                                               , planYear = objLog.pmYear
                                                               , monthly =objLog.monthly 
                                                               , registStatus = objLog.confirmStatus });
                foreach (var obj in pmconfirmViewList)
                {
                    objMailinfo.objPmSeq.Add(obj.busType,obj.seq);
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

        [Route("RegistSendForm")]
        [HttpPost]
        public ActionResult RegistSendPost(PmConfirmLog objLog)
        {
            dynamic model = new ExpandoObject();            
            var pmConfirm = pmConfirmStateViewRepo.selectComment(new
            {
                searchCpySeq = objLog.orgCompanySeq
                                                                        ,
                searchYear = objLog.pmYear
                                                                        ,
                searchMonth = objLog.monthly
            });
            objLog.confirmComment = pmConfirm.confirmComment;
            objLog.strCompnayName = pmConfirm.companyName;
            model.pmconfirmLog = objLog;
            model.BsExcount = (pmConfirm.pmBsEx > 0) ? "" : "none";
            //model.LISTPAGEURL = listUrl; 
            return View("~/Views/SiteMngHome/Confirm/RegistSendForm.cshtml", model);
        }

        [Route("PagePath")] 
        public ActionResult EidtSendPost(string orgCompanySeq,string pmYear,string monthly,string strPageType,string strTableName)
        {
            Dictionary<string, object> postData = new Dictionary<string, object>();
            Dictionary<string, string> ListPageUrl = new Dictionary<string, string> { };
 
            var pmConfirm = pmConfirmStateViewRepo.selectView(new { searchCpySeq = orgCompanySeq 
                                                        ,searchYear =  pmYear
                                                        , searchMonth =  monthly},strPageType,strTableName);
            postData.Add("Seq", pmConfirm.seq);
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
 