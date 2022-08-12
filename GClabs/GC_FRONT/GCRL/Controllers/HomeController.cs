
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

using System.Data;
using System.Data.SqlClient;

using System.Threading.Tasks;

using GCRL.Modules;

using Dapper;
using System.Web.Routing;
using GCRL.Areas.support.Models;
using GCRL.Areas.pr.Models;
using GCRL.Model;

namespace GCRL.Controllers
{
    public class HomeController : Controller
    {

        private readonly string _supportpageType = PageEnum.SupportOfficial.ToCode();
        private readonly string _newspageType = PageEnum.PrNews.ToCode();
        private readonly string _presspageType = PageEnum.PrPress.ToCode();
        private readonly string _livepageType = PageEnum.PrLive.ToCode();

        public ActionResult Index()
        {
            IDbConnection conn =    null; 

            ViewBag.divcode1 = HttpUtility.UrlDecode(Request.QueryString["divcode1"] ?? "");
            ViewBag.keyword = HttpUtility.UrlDecode(Request.QueryString["keyword"] ?? "");
            HttpBrowserCapabilitiesBase isMobile = Request.Browser;
            if (isMobile.IsMobileDevice)
            {
                ViewBag.isMobile = true;
            }
            else
            {
                ViewBag.isMobile = false;
            }

            List<supportListModel> supportResult = new List<supportListModel>();
            List<prListModel> newsResult = new List<prListModel>();
            List<prListModel> pressResult = new List<prListModel>();
            List<prListModel> liveResult = new List<prListModel>();
            List<visualModel> mainVisualResult = new List<visualModel>();
            List<visualModel> contentResult = new List<visualModel>();
            List<popupModel> popupResult = new List<popupModel>();
            try
            {
                using ( conn = Functions.ConnectionDefault)
                {
               

                    conn.Open();

                    popupResult = conn.Query<popupModel>("dbo.GCRL_POPUP_LIST",
                       param: new
                       {
                           CRUD = "R",
                           DVI_TYP = (ViewBag.isMobile == true ? "M" : "P"),
                           LANG_TYP = "K"
                       },
                       commandType: CommandType.StoredProcedure
                    ).ToList();

                    supportResult = conn.Query<supportListModel>("dbo.GCRL_BOARD_COMMON_LIST_SEL",
                        param: new
                        {
                            pType = _supportpageType,
                            pKeyWord = "",
                        },
                        commandType: CommandType.StoredProcedure
                    ).ToList();

                    newsResult = conn.Query<prListModel>("dbo.GCRL_BOARD_COMMON_LIST_SEL",
                        param: new
                        {
                            pType = _newspageType,
                            pDivCode1 = ViewBag.divcode1 ?? "",
                            pKeyWord = "",
                        },
                        commandType: CommandType.StoredProcedure
                    ).ToList();

                    pressResult = conn.Query<prListModel>("dbo.GCRL_BOARD_COMMON_LIST_SEL",
                        param: new
                        {
                            pType = _presspageType,
                            pKeyWord = "",
                        },
                        commandType: CommandType.StoredProcedure
                    ).ToList();

                    liveResult = conn.Query<prListModel>("dbo.GCRL_BOARD_COMMON_LIST_SEL",
                        param: new
                        {
                            pType = _livepageType,
                            pKeyWord = ViewBag.keyword ?? "",
                        },
                        commandType: CommandType.StoredProcedure
                    ).ToList();

                    mainVisualResult = conn.Query<visualModel>("dbo.GCMASTER_BOARD_MAIN_VISUAL_LIST_SEL",
                        param: new
                        {

                        },
                        commandType: CommandType.StoredProcedure
                    ).ToList();

                    contentResult = conn.Query<visualModel>("dbo.GCMASTER_BOARD_MAIN_CONTENTS_LIST_SEL",
                      param: new
                      {

                      },
                      commandType: CommandType.StoredProcedure
                  ).ToList();

                }
            }catch(Exception e)
            {
                if (conn.State == ConnectionState.Closed)
                {
                    return View("~/Views/Error/error.cshtml");
                }
            }
            List<supportListModel> mymodel = new List<supportListModel>();
            mymodel = supportResult.Take(3).ToList();
            //ViewData["supportListModel"] = supportResult.Take(3).ToList();

            //ViewBag.supportList = supportResult.Take(3).ToList();
            ViewBag.newsList = newsResult.Take(3).ToList().OrderBy(x => x.VIEW_ORDER);
            ViewBag.pressList = pressResult.Where(w => w.IMAGE2_ORG_NAME != null).Take(3).ToList().OrderBy(x => x.VIEW_ORDER);
            ViewBag.liveList = liveResult.Where(w => w.IMAGE2_ORG_NAME != null).Take(3).OrderBy(x => x.VIEW_ORDER);

            ViewBag.visualList = mainVisualResult.Where(w => w.DEVI_CLS == "PC").Where(w => w.VIEW_YN == "Y").Where(w => w.LANG_CLS == "국문").OrderBy(x => x.VIEW_ORDER);
            ViewBag.visualListMobile = mainVisualResult.Where(w => w.DEVI_CLS == "Mobile").Where(w => w.VIEW_YN == "Y").Where(w => w.LANG_CLS == "국문").OrderBy(x => x.VIEW_ORDER);

            ViewBag.contentLeft = contentResult.Where(w => w.COMM_CD == "01").ToList();
            ViewBag.contentRight = contentResult.Where(w => w.COMM_CD == "02").ToList();
            ViewBag.contentTitle = contentResult.Where(w => w.COMM_CD == "03").ToList();
            ViewBag.contentOne = contentResult.Where(w => w.COMM_CD == "04").ToList();
            ViewBag.contentTwo = contentResult.Where(w => w.COMM_CD == "05").ToList();
            ViewBag.contentThree = contentResult.Where(w => w.COMM_CD == "06").ToList();

            ViewBag.popupList = popupResult.ToList();

            return View();
        }
       
        public ActionResult About()
        {
            ViewBag.Message = "Your application description page.";
            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }
    }
}