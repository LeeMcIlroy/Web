using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Data;

using GCRL.Modules;
using GCRL.Models;

using Dapper;

namespace GCRL.Areas.eng.Controllers
{
    public class doctorsController : Controller
    {
        private readonly string _pageType = PageEnum.EngDoctors.ToCode();

        public ActionResult list()
        {

            ViewBag.deptcode = HttpUtility.UrlDecode(Request.QueryString["deptcode"] ?? "");

            List<doctorsListModel> lstResult = new List<doctorsListModel>();

            using (var conn = Functions.ConnectionDefault)
            {
                conn.Open();

                lstResult = conn.Query<doctorsListModel>("dbo.GCRL_GCLABS_DOCTORS_LIST_SEL",
                    param: new
                    {
                        pType = _pageType,
                        pDeptCode = ViewBag.deptcode ?? ""
                    },
                    commandType: CommandType.StoredProcedure
                ).ToList();
            }

            return View(lstResult);
        }

        public ActionResult view(int? id)
        {
            if (id == null)
                return RedirectToAction("list");

            doctorsViewModel viewdata = null;

            using (var conn = Functions.ConnectionDefault)
            {
                conn.Open();

                using (var multi = conn.QueryMultiple("dbo.GCRL_GCLABS_DOCTORS_VIEW_SEL",
                                    param: new
                                    {
                                        pType = _pageType,
                                        pIDX = id
                                    },
                                    commandType: CommandType.StoredProcedure))
                {
                    viewdata = multi.ReadFirst<doctorsViewModel>();
                    viewdata.PAPERS = multi.Read<paperModel>().ToList();

                }
            }

            return View(viewdata);
        }
    }
}