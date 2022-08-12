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
    /// 시스템권한관리
    /// </summary>
    [AdminLoginFilter]
    [AuthAdminFilter(RequestAuthLevel = 1)]
    [RoutePrefix("SiteMngHome/Admin/System_Auth")]
    public class SystemAuthController : SiteMngBaseController
    {
        [Route("List")]
        public ActionResult List(Search search)
        {
            List<SystemAuth> list = systemAuthRepo.selectList(search).ToList();

            // 2018.12.11 사용자의 회사와 직위를 관리자화면에서 보여줘야하여. 기존에 디비에 저장하지 않았기에. 인사디비에서 가져오게 한다.
            // 건건이 가져오니 속도 이슈가 있어 우선 대기.
            string EmpNo = "";
            foreach (var item in list)
            {
                EmpNo += "," + item.AuthUserKey;
            }

            List<InsaUserV> insaListAuth = insaUserVRepo.selectListWithAuth(new { EmpNo = EmpNo }).ToList();

             var list2 = from objList2 in list
                            join objInsa in insaListAuth
                                on objList2.AuthEmpNo equals objInsa.empNo into rows
                            from r3 in rows.DefaultIfEmpty(new InsaUserV {empNo = objList2.AuthEmpNo } )
                        where 1==1 && objList2.AuthUserKorName == search.searchText
                               || objList2.AuthEmpNo == search.searchText
                               || r3.CompKorName == search.searchText
                               || r3.levelKorName == search.searchText
                        select new SystemAuth { RowNum = objList2.RowNum
                            , AuthUserKey = objList2.AuthUserKey
                            , AuthEmpNo = objList2.AuthEmpNo
                            , AuthUserKorName = objList2.AuthUserKorName 
                            , IsUse = objList2.IsUse 
                            , CompKorName = r3.CompKorName
                            , levelKorName = r3.levelKorName
                          };

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
            List<SystemAuth> list3 = list2.Skip((search.PageIndex - 1) * search.PageSize).Take(search.PageSize).ToList();
            model.list = list3;

            ViewBag.Search = search;
            return View("~/Views/SiteMngHome/Admin/System_Auth/List.cshtml", model);
        }

        [Route("Write")]
        public ActionResult Write(Search search)
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");

            List<OrgCompany> orgList = orgCompanyRepo.selectListAdminAuth(new { }).ToList();
            // 그룹전체가 디비에 없어서 여기서 넣어준다.
            OrgCompany oAdd = new OrgCompany();
            oAdd.Seq = 0;
            oAdd.UnionName = "그룹";
            oAdd.CompanyName = "그룹전체";
            orgList.Insert(0, oAdd);
            dynamic model = new ExpandoObject();
            model.orgList = orgList;

            ViewBag.Search = search;
            return View("~/Views/SiteMngHome/Admin/System_Auth/Write.cshtml", model);
        }

        [Route("Write_Action")]
        public ActionResult WriteAction(SystemAuth entity, Search search)
        {
            if (systemAuthRepo.save(entity) > 0)
            {
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

                systemOrgAuthRepo.delete(new { entity.AuthUserKey });
                foreach (var item in entity.OrgCompanySeq)
                {
                    SystemOrgAuth sOrgAuth = new SystemOrgAuth();
                    sOrgAuth.AuthUserKey = entity.AuthUserKey;
                    sOrgAuth.OrgCompanySeq = item;
                    systemOrgAuthRepo.insert(sOrgAuth);
                }

                systemMenuAuthRepo.delete(new { entity.AuthUserKey });
                foreach (var item in entity.MenuType)
                {
                    SystemMenuAuth sMenuAuth = new SystemMenuAuth();
                    sMenuAuth.AuthUserKey = entity.AuthUserKey;
                    sMenuAuth.MenuType = item;
                    systemMenuAuthRepo.insert(sMenuAuth);
                }
                TempData["alert"] = entity.message + "되었습니다.";
            }
            else
            {
                TempData["alert"] = entity.message + "에 실패하였습니다.";
            }

            return RedirectToAction("List", search);
        }

        [Route("View")]
        public ActionResult view()
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");

            return View("~/Views/SiteMngHome/Admin/System_Auth/View.cshtml");
        }

        [Route("Edit")]
        public ActionResult Edit(string AuthUserKey, Search search)
        {
            if (Request.RequestType == "GET") return RedirectToAction("List");

            List<OrgCompany> orgList = orgCompanyRepo.selectListAdminAuth(new { }).ToList();
            // 그룹전체가 디비에 없어서 여기서 넣어준다.
            OrgCompany oAdd = new OrgCompany();
            oAdd.Seq = 0;
            oAdd.UnionName = "그룹";
            oAdd.CompanyName = "그룹전체";
            orgList.Insert(0, oAdd);
            dynamic model = new ExpandoObject();

            var compinfo = insaUserVRepo.selectOneJoinDept(new { EmpNo = AuthUserKey });
            if (compinfo == null) compinfo = new InsaUserV();
            model.orgList = orgList;
            model.edit = systemAuthRepo.selectOne(new { AuthUserKey });
            model.orgAuth = systemOrgAuthRepo.selectList(new { AuthUserKey });
            model.CompInfo = compinfo;
            model.menuAuth = systemMenuAuthRepo.selectList(new { AuthUserKey });
            
            ViewBag.Search = search;
            return View("~/Views/SiteMngHome/Admin/System_Auth/Edit.cshtml", model);
        }
    }
}