using Dapper;
using GCRL.Areas.test.Models;
using GCRL.Modules;
using PagedList;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace GCRL.Areas.test.Controllers
{
    public class panelController : Controller
    {
        //private readonly int _pageSize = 2;

        private int totalCnt = 0;

        // GET: test/panel
        public ActionResult list()
        {
            string trbtyp = HttpUtility.UrlDecode(Request.QueryString["trbtyp"] ?? "");
            string initial = HttpUtility.UrlDecode(Request.QueryString["initial"] ?? "");
            string keyword = HttpUtility.UrlDecode(Request.QueryString["keyword"] ?? "");
            int pageNumber = Convert.ToInt16(Request.QueryString["page"] ?? "1");
            string onoff = HttpUtility.UrlDecode(Request.QueryString["onoff"] ?? "off");
            ViewBag.onoff = onoff;

            // 질환별 리스트
            List<panelModel> lstResult = new List<panelModel>();
            // 질환별 상세
            List<panelModel> lstDetail = new List<panelModel>();

            using (var conn = Functions.ConnectionDefault)
            {
                conn.Open();

                lstResult = conn.Query<panelModel>("dbo.GCRL_PANEL_LIST",
                    param: new
                    {
                        QRY_FLG = "A",
                        PAN_TYP = "01",
                        SEARCH_TXT = keyword ?? "",
                        TRB_TYP_F = trbtyp ?? "",
                        INITIAL = initial ?? ""
                    },
                    commandType: CommandType.StoredProcedure
                ).ToList();

                for (int i = 0; i < lstResult.Count(); i++)
                {
                    lstDetail = conn.Query<panelModel>("dbo.GCRL_PANEL_LIST",
                        param: new
                        {
                            QRY_FLG = "B",
                            PAN_TYP = "01",
                            TRB_TYP = lstResult[i].TRB_TYP ?? "",
                            SEARCH_TXT = keyword ?? "",
                            TRB_TYP_F = trbtyp ?? "",
                            INITIAL = initial ?? ""
                        },
                        commandType: CommandType.StoredProcedure
                    ).ToList();

                    lstResult[i].panel = lstDetail;
                }
            }

            ViewBag.KeyWord = keyword;
            int _pageSize = lstResult.Count() == 0 ? 1 : lstResult.Count();
            ViewBag.totalCnt = lstResult.Count();
            ViewBag.trbtyp = trbtyp == "" ? "All" : trbtyp;
            ViewBag.initial = initial == "" ? "All" : initial;

            //return View();
            return View(lstResult.ToPagedList(pageNumber, _pageSize));
        }

        public ActionResult list2()
        {
            string trbtyp = HttpUtility.UrlDecode(Request.QueryString["trbtyp"] ?? "");
            string initial = HttpUtility.UrlDecode(Request.QueryString["initial"] ?? "");
            string keyword = HttpUtility.UrlDecode(Request.QueryString["keyword"] ?? "");
            int pageNumber = Convert.ToInt16(Request.QueryString["page"] ?? "1");
            string onoff = HttpUtility.UrlDecode(Request.QueryString["onoff"] ?? "off");
            ViewBag.onoff = onoff;

            // 질환별 리스트
            List<panelModel_02> lstResult = new List<panelModel_02>();
            // 질환별 상세
            List<panelModel_02> lstDetail = new List<panelModel_02>();

            using (var conn = Functions.ConnectionDefault)
            {
                conn.Open();

                lstResult = conn.Query<panelModel_02>("dbo.GCRL_PANEL_LIST",
                    param: new
                    {
                        QRY_FLG = "A",
                        PAN_TYP = "02",
                        SEARCH_TXT = keyword ?? "",
                        TRB_TYP_F = trbtyp ?? "",
                        INITIAL = initial ?? ""
                    },
                    commandType: CommandType.StoredProcedure
                ).ToList();

                for (int i = 0; i < lstResult.Count(); i++)
                {
                    lstDetail = conn.Query<panelModel_02>("dbo.GCRL_PANEL_LIST",
                        param: new
                        {
                            QRY_FLG = "B",
                            PAN_TYP = "02",
                            TRB_TYP = lstResult[i].TRB_TYP ?? "",
                            SEARCH_TXT = keyword ?? "",
                            TRB_TYP_F = trbtyp ?? "",
                            INITIAL = initial ?? ""
                        },
                        commandType: CommandType.StoredProcedure
                    ).ToList();

                    lstResult[i].panel = lstDetail;
                }
            }

            ViewBag.KeyWord = keyword;
            int _pageSize = lstResult.Count() == 0 ? 1 : lstResult.Count();
            ViewBag.totalCnt = lstResult.Count();
            ViewBag.trbtyp = trbtyp == "" ? "All" : trbtyp;
            ViewBag.initial = initial == "" ? "All" : initial;

            //return View();
            return View(lstResult.ToPagedList(pageNumber, _pageSize));
        }
    }
}