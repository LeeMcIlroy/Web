using Dapper;
using GCRL.Areas.eng.Models;
using GCRL.Model;
using GCRL.Modules;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace GCRL.Areas.eng.Controllers
{
    public class mainController : Controller
    {
        private readonly string _newsletterType = PageEnum.EngNewsletters.ToCode();
        private readonly string _prpageType = PageEnum.EngPr.ToCode();
        private readonly string _marketingType = PageEnum.EngMarketing.ToCode();
        // GET: eng/main
        public ActionResult Index()
        {

            List<engListModel> newsLetter = new List<engListModel>();
            List<engListModel> pr = new List<engListModel>();
            List<engListModel> marketing = new List<engListModel>();
            List<visualModel> mainVisualResult = new List<visualModel>();
            List<visualModel> contentResult = new List<visualModel>();
            List<popupModel> popupResult = new List<popupModel>();

            using (var conn = Functions.ConnectionDefault)
            {
                conn.Open();

                popupResult = conn.Query<popupModel>("dbo.GCRL_POPUP_LIST",
                   param: new
                   {
                       CRUD = "R",
                       DVI_TYP = (ViewBag.isMobile == true ? "M" : "P"),
                       LANG_TYP = "E"
                   },
                   commandType: CommandType.StoredProcedure
                ).ToList();

                newsLetter = conn.Query<engListModel>("dbo.GCRL_BOARD_COMMON_LIST_SEL",
                    param: new
                    {
                        pType = _newsletterType
                    },
                    commandType: CommandType.StoredProcedure
                ).ToList();


                pr = conn.Query<engListModel>("dbo.GCRL_BOARD_COMMON_LIST_SEL",
                    param: new
                    {
                        pType = _prpageType
                    },
                    commandType: CommandType.StoredProcedure
                ).ToList();

                marketing = conn.Query<engListModel>("dbo.GCRL_BOARD_COMMON_LIST_SEL",
                    param: new
                    {
                        pType = _marketingType
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
            HttpBrowserCapabilitiesBase isMobile = Request.Browser;
            if (isMobile.IsMobileDevice)
            {
                ViewBag.isMobile = true;
            }
            else
            {
                ViewBag.isMobile = false;
            }
            ViewBag.newsLetterList = newsLetter.Take(3).ToList();
            ViewBag.prList = pr.Where(w => w.IMAGE2_ORG_NAME != "").Take(3).ToList().OrderBy(x => x.VIEW_ORDER);
            ViewBag.marketingList = marketing.Where(w => w.IMAGE1_ORG_NAME != "").Take(3).ToList().OrderBy(x => x.VIEW_ORDER);
            ViewBag.visualList = mainVisualResult.Where(w => w.DEVI_CLS == "PC").Where(w => w.VIEW_YN == "Y").Where(w => w.LANG_CLS == "영문").OrderBy(x => x.VIEW_ORDER);
            ViewBag.visualListMobile = mainVisualResult.Where(w => w.DEVI_CLS == "Mobile").Where(w => w.VIEW_YN == "Y").Where(w => w.LANG_CLS == "영문").OrderBy(x => x.VIEW_ORDER);
            ViewBag.contentLeft = contentResult.Where(w => w.COMM_CD == "07").ToList();
            ViewBag.contentRight = contentResult.Where(w => w.COMM_CD == "08").ToList();
            ViewBag.contentTitle = contentResult.Where(w => w.COMM_CD == "09").ToList();
            ViewBag.contentOne = contentResult.Where(w => w.COMM_CD == "10").ToList();
            ViewBag.contentTwo = contentResult.Where(w => w.COMM_CD == "11").ToList();
            ViewBag.contentThree = contentResult.Where(w => w.COMM_CD == "12").ToList();

            ViewBag.contentLeftM = contentResult.Where(w => w.COMM_CD == "19").ToList();
            ViewBag.contentRightM = contentResult.Where(w => w.COMM_CD == "20").ToList();
            ViewBag.contentTitleM = contentResult.Where(w => w.COMM_CD == "21").ToList();

            ViewBag.popupList = popupResult.ToList();

            return View();
        }
        public ActionResult privacy()
        {

            return View();
        }
    }
}