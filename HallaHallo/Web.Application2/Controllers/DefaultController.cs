using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;

namespace HallaTube.Controllers
{
    public class DefaultController : BaseController
    {
        ArticleRepository articleRepository = new ArticleRepository();
        ConfigRepository configRepository = new ConfigRepository();
        FileRepository fileRepository = new FileRepository();

        public ActionResult Index()
        {
            return Redirect("~/Main");
        }


        [Authorize]
        public ActionResult Main()
        {
            ViewData["carousel"] = articleRepository.GetMainList("Carousel");
            ViewData["hot"] = articleRepository.GetMainList("Hot");
            ViewData["new"] = articleRepository.GetMainList("New");

            DateTime today = DateTime.UtcNow.AddHours(_User.TimeZones);
            
            ViewData["bannerTop"] = articleRepository.GetBanner("Top", today);
            ViewData["bannerMiddle"] = articleRepository.GetBanner("Middle", today);


            var search = new ArticleSearchModel();
            search.BoardCode = "Hashtag";
            search.PageSize = 1;
            search.Area = "Period";
            search.StartDate = new DateTime(today.Year, today.Month, today.Day);
            search.EndDate = search.StartDate;

            ViewData["hashtag"] = articleRepository.GetList(search, false);

            return View();
        }

        public ActionResult HitHashtag(string id,string word)
        {
            Logging = true;
            LoggingData = word;

            articleRepository.IncreaseViewCount(id);
            return new EmptyResult();
        }

        public ActionResult HitBanner(string id)
        {
            articleRepository.IncreaseViewCount(id);
            return new EmptyResult();
        }

        public ActionResult Intro()
        {
            return View();
        }

        public ActionResult Constant()
        {
            Logging = false;
            return View();
        }

        static string[] forbidExtension = "exe,cs,js,jsp,asp,php,aspx,asmx,css,xml".Split(',');
        [Authorize]
        public ActionResult FileReceiver(string type)
        {
            List<FileEntity> list = new List<FileEntity>();
            if (Request.Files.Count > 0)
            {

                for(int i=0; i<Request.Files.Count;i++)
                {
                    var file = Request.Files[i];
                    string fileID = Sequence.Generate();
                    FileInfo fi = new FileInfo(file.FileName);
                    if(forbidExtension.Contains(fi.Extension.Trim('.')))
                    {
                        return new HttpStatusCodeResult(System.Net.HttpStatusCode.BadRequest);
                    }

                    string path = Config.AppPath + "FileRoot/Temp/" + fileID + fi.Extension;
                    file.SaveAs(Server.MapPath(path));

                    list.Add(new FileEntity
                    {
                        FileNm = fi.Name,
                        Extension = fi.Extension,
                        Size = file.ContentLength,
                        Path = path,
                        ObjectType = type
                    });
                }
            }

            return Content(Newtonsoft.Json.JsonConvert.SerializeObject(list));
        }

        [Authorize]
        public ActionResult Download(string id)
        {
            var file = fileRepository.GetFile(id);
            string path = Config.GetPath(file.Path);
            if (System.IO.File.Exists(path))
            {
                return File(path, "application/octet-stream", file.FileNm);
            }
            else
            {
                return new HttpStatusCodeResult(System.Net.HttpStatusCode.NotFound);
            }
        }

        public ActionResult Logout()
        {
            Session.Abandon();
            Session["User"] = null;
            FormsAuthentication.SignOut();

            return Redirect("https://ep.halla.com");
        }

        public ActionResult ChangeLanguage(string lang)
        {
            _User.Language = lang;

            return new EmptyResult();
        }

        public ActionResult Test()
        {
            return View();
        }
        
    }
}