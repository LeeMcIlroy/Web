using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Dapper;

using HALLA_PM.Core;
using HALLA_PM.Util;
using HALLA_PM.Models;
using System.Dynamic; 

namespace HALLA_PM.Controllers.SiteMngHome
{
    /// <summary>
    /// 관리자권한관리
    /// </summary>
    [AdminLoginFilter]
    [AuthAdminFilter(RequestAuthLevel = 1)]
    [RoutePrefix("SiteMngHome/Admin/Admin_Auth")]
    public class AdminAuthController : SiteMngBaseController
    {
        /// <summary>
        /// 리스트
        /// </summary>
        /// <param name="search"></param>
        /// <returns></returns>
        [Route("List")]
        public ActionResult List(Search search)
        {
            List<AdminAuth> list = adminAuthRepo.selectList(search).ToList();
           

            string EmpNo = "";
            foreach (var item in list)
            {
                EmpNo += "," + item.AuthUserKey;
            }
           // search.searchText = (search.searchText  == null)? "": search.searchText;
            List<InsaUserV> insaListAuth = insaUserVRepo.selectListWithAuth(new { EmpNo = EmpNo }).ToList();

            var list2 = from objList2 in list
                            join objInsa in insaListAuth
                                on objList2.AuthEmpNo equals objInsa.empNo into rows
                            from r3 in rows.DefaultIfEmpty(new InsaUserV {empNo = objList2.AuthEmpNo } )
                        where 1==1 && objList2.AuthUserKorName == search.searchText
                               || objList2.AuthEmpNo == search.searchText
                               || r3.CompKorName == search.searchText
                               || r3.levelKorName == search.searchText
                        select new AdminAuth { RowNum = objList2.RowNum
                            , AuthUserKey = objList2.AuthUserKey
                            , AuthEmpNo = objList2.AuthEmpNo
                            , AuthUserKorName = objList2.AuthUserKorName
                            , AuthLevel = objList2.AuthLevel
                            , AuthName = objList2.AuthName
                            , IsUse = objList2.IsUse
                            , IsDisclosure = objList2.IsDisclosure
                            , OrgSeq = objList2.OrgSeq
                            , CompKorName = r3.CompKorName
                            , levelKorName = r3.levelKorName
                          };


                                //into _a  from objInsa in _a.DefaultIfEmpty()
                                // where objList2.AuthEmpNo.Contains(search.searchText)
                                //|| objList2.AuthUserKorName.Contains(search.searchText)
                                //|| r3.CompKorName.Contains(search.searchText)
                                //|| r3.levelKorName.Contains(search.searchText)
                                //where objList2.AuthUserKorName == "" 
                                //       || objList2.EmpNo == ""
                                //       || objInsa.CompKorName == ""
                                //       || objInsa.levelKorName == ""
                                //select new AdminAuth { RowNum = objList2.RowNum
                                //    , AuthUserKey = objList2.AuthUserKey
                                //    , AuthEmpNo = objList2.AuthEmpNo
                                //    , AuthUserKorName = objList2.AuthUserKorName
                                //    , AuthLevel = objList2.AuthLevel
                                //    , IsUse = objList2.IsUse
                                //    , OrgSeq = objList2.OrgSeq
                                //    , CompKorName = objInsa.CompKorName
                                //    , levelKorName = objInsa.levelKorName
                                //  };



                                //foreach (var item in list)
                                //{
                                //    InsaUserV insa = insaListAuth.Where(w => w.userKey == item.AuthUserKey).FirstOrDefault();
                                //    if (insa == null)
                                //    {
                                //        item.CompKorName = "퇴직자";
                                //        item.levelKorName = "-";
                                //    }
                                //    else
                                //    {
                                //        item.CompKorName = insa.CompKorName;
                                //        item.levelKorName = insa.levelKorName;
                                //    }
                                //}
            dynamic model = new ExpandoObject();          

            search.TotalCount = list2.Count();
            search.EndPageIndex = (search.TotalCount == 0) ? 0 : search.EndPageIndex;
            search.MakePaging();
            List<AdminAuth> list3 = list2.Skip((search.PageIndex - 1) * search.PageSize).Take(search.PageSize).ToList();
            model.list = list3;
                   
            ViewBag.Search = search;
            return View("~/Views/SiteMngHome/Admin/Admin_Auth/List.cshtml", model);
        }

        [Route("Write")]
        public ActionResult Write(Search search)
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");

            dynamic model = new ExpandoObject();
            model.orgList = orgCompanyRepo.selectListAdminAuth(new { });
            ViewBag.Search = search;

            return View("~/Views/SiteMngHome/Admin/Admin_Auth/Write.cshtml", model);
        }

        [Route("Write_Action")]
        public ActionResult WriteAction(AdminAuth entity, Search search)
        {
            if(adminAuthRepo.save(entity) > 0)
            {
                adminOrgAuthRepo.delete(new { entity.AuthUserKey });
                if (entity.OrgCompanySeq != null && entity.OrgCompanySeq.Count() > 0)
                {
                    foreach (var item in entity.OrgCompanySeq)
                    {
                        AdminOrgAuth aOrgAuth = new AdminOrgAuth();
                        aOrgAuth.AuthUserKey = entity.AuthUserKey;
                        aOrgAuth.OrgCompanySeq = item;
                        adminOrgAuthRepo.insert(aOrgAuth);
                    }
                }
                TempData["alert"] = entity.message + "되었습니다.";

                // 2019.01.09 
                // 관리자 추가시 해당 사용자에 권한을 사용자에 권한 추가
                SystemAuth s = new SystemAuth();
                s.AuthUserKey = entity.AuthUserKey;
                s.AuthEmpNo = entity.AuthEmpNo;
                s.AuthUserKorName = entity.AuthUserKorName;
                s.EmpNo = entity.EmpNo;
                s.OrgCompanySeq = entity.OrgCompanySeq;
                s.IsUse = entity.IsUse;
                //s.IsDisclosure = entity.IsDisclosure;


                systemAuthRepo.save(s);

                // 2019.01.09 한마루 인사디비 입력
                InsaUserVRepo insaRepo = new InsaUserVRepo();
                // 
                if (entity.IsUse == "Y")
                {
                    string exec = "EXEC UP_GROUP_ITEM_INSERT 'ROLE.HEIS.USER', '" + entity.AuthUserKey + "', NULL, NULL,'HEIS 사용자 그룹-" + entity.AuthUserKorName + "'";
                    insaRepo.ExecProcedure(exec);
                }
                else
                {
                    string exec = "EXEC UP_GROUP_ITEM_DELETE 'ROLE.HEIS.USER', '" + entity.AuthUserKey + "'";
                    insaRepo.ExecProcedure(exec);
                }

                systemOrgAuthRepo.delete(new { s.AuthUserKey });
                // 2019.01.11 데이터 없으면 입력 안하게 변경
                if (entity.OrgCompanySeq != null && entity.OrgCompanySeq.Count() > 0)
                {
                    foreach (var item in s.OrgCompanySeq)
                    {
                        SystemOrgAuth sOrgAuth = new SystemOrgAuth();
                        sOrgAuth.AuthUserKey = entity.AuthUserKey;
                        sOrgAuth.OrgCompanySeq = item;
                        systemOrgAuthRepo.insert(sOrgAuth);
                    }
                }
            }
            else
            {
                TempData["alert"] = entity.message + "에 실패하였습니다.";
            }

            return RedirectToAction("List", search);
        }

        [Route("Insa_Search_Ajax")]
        public ActionResult InsaSearchAjax(string Userkorname)
        {
            List<InsaUserV> insa = (List<InsaUserV>)insaUserVRepo.selectList(new { UserKorName = Userkorname });

            if (insa == null || insa.Count() <= 0)
            {
                return Json(new { success = false }, JsonRequestBehavior.DenyGet);
            }
            else
            {
                return Json(new { success = true, list = insa }, JsonRequestBehavior.DenyGet);
            }
        }

        [Route("View")]
        public ActionResult view()
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");

            return View("~/Views/SiteMngHome/Admin/Admin_Auth/View.cshtml");
        }

        [Route("Edit")]
        public ActionResult Edit(string AuthUserKey, Search search)
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");
            if (string.IsNullOrEmpty(AuthUserKey)) return RedirectToAction("List");

            var compinfo = insaUserVRepo.selectOneJoinDept(new { EmpNo = AuthUserKey });
            if (compinfo == null) compinfo = new InsaUserV();

            dynamic model = new ExpandoObject();
            model.orgList = orgCompanyRepo.selectListAdminAuth(new { });
            model.edit = adminAuthRepo.selectOne(new { AuthUserKey });
            model.orgAuth = adminOrgAuthRepo.selectList(new { AuthUserKey });
            model.CompInfo = compinfo;

            ViewBag.Search = search;
            return View("~/Views/SiteMngHome/Admin/Admin_Auth/Edit.cshtml", model);
        }

        [Route("Delete_Action")]
        public ActionResult DeleteAction(AdminAuth entity, Search search)
        {
            adminOrgAuthRepo.delete(new { entity.AuthUserKey });
            adminAuthRepo.delete(new { entity.AuthUserKey });
            TempData["alert"] = "삭제되었습니다.";
            return RedirectToAction("List", search);
        }
    }
}