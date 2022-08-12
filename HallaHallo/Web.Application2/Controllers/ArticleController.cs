
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;

namespace HallaTube.Controllers
{
    [Authorize]
    public class ArticleController : BaseController
    {
        ArticleRepository articleRepository = new ArticleRepository();
        FileRepository fileRepository = new FileRepository();
        CommentRepository commentRepository = new CommentRepository();
        ArticleLikeRepository articleLikeRepository = new ArticleLikeRepository();

        public ActionResult AllList(ArticleSearchModel search, string type = "Default")
        {
            search.BoardCode = type;

            if (type == "Pairing")
            {
                if (string.IsNullOrEmpty(search.Area))
                {
                    search.Area = "Period";
                    DateTime today = DateTime.UtcNow.AddHours(_User.TimeZones);
                    search.StartDate = new DateTime(today.Year, today.Month, 1);
                }

                search.EndDate = search.StartDate.AddMonths(1).AddDays(-1);
            }
            else if (type == "Default")
            {
                //if (_User.UserType != AuthType.ADMIN)
                {
                    search.DateType = "START_DATE";
                    search.StartDate = new DateTime(1900, 1, 2);
                    search.EndDate = DateTime.UtcNow.AddHours(_User.TimeZones);
                }

            }


            search.CategoryCode = search.CategoryCode;

            var list = articleRepository.GetAllList(search);
            ViewData["list"] = list;
            ViewData["search"] = search;

            if (!string.IsNullOrEmpty(search.CategoryCode))
            {
                Category = MenuList[search.CategoryCode];
            }



            string path = GetViewPath(type);
            return View(path);
        }

        public ActionResult List(ArticleSearchModel search, string type = "Default")
        {
            search.BoardCode = type;
            if (type == "Pairing")
            {
                if (string.IsNullOrEmpty(search.Area))
                {
                    search.Area = "Period";
                    DateTime today = DateTime.UtcNow.AddHours(_User.TimeZones);
                    search.StartDate = new DateTime(today.Year, today.Month, 1);
                }

                search.EndDate = search.StartDate.AddMonths(1).AddDays(-1);
            }
            else if (type == "Default")
            {
                //if (_User.UserType != AuthType.ADMIN)
                {
                    search.DateType = "START_DATE";
                    search.StartDate = new DateTime(1900, 1, 2);
                    search.EndDate = DateTime.UtcNow.AddHours(_User.TimeZones);
                }
                
            }

            

            var list = articleRepository.GetList(search);
            ViewData["list"] = list;
            ViewData["search"] = search;

            if (!string.IsNullOrEmpty(search.CategoryCode))
            {
                Category = MenuList[search.CategoryCode];
            }

            

            string path = GetViewPath(type);
            return View(path);
        }

        public ActionResult Write(string id, string type = "Default")
        {
            ArticleEntity article;
            if (string.IsNullOrEmpty(id))
            {
                article = new ArticleEntity
                {
                    ArticleType = "Text",
                    StartDate = DateTime.Now,
                    State = "Open"
                };
            }
            else
            {
                article = articleRepository.Get(id);
                if (article.BoardCode== "Default" && article.State != "Reserve")
                {
                    article.StartDate = DateTime.Now;
                }
            }

            ViewData["article"] = article;

            ViewData["attach"] = fileRepository.GetFileList(article.ArticleID, "Attach");
            ViewData["thumb"] = fileRepository.GetFile(article.ArticleID, "Thumb");

            string path = GetViewPath(type);
            return View(path);
        }

        [HttpPost]
        public ActionResult Write(string id, [JsonBinder]ArticleEntity entity,[JsonBinder] List<FileEntity> files, [JsonBinder] List<string> delFiles, string type = "Default")
        {
            //articleRepository.Get(id);

            entity.ArticleID = id;
            entity.BoardCode = type;

            articleRepository.Set(entity, files, delFiles, _User);
            return new EmptyResult();
            
        }

        public ActionResult Read(string id, CommentSearchModel search, string type = "Default")
        {
            if (_User.LastArticleID != id)
            {
                articleRepository.IncreaseViewCount(id);
            }
            _User.LastArticleID = id;

            ArticleEntity article = articleRepository.Get(id);
            if (article == null)
            {
                return new HttpStatusCodeResult(System.Net.HttpStatusCode.BadRequest);
            }
            ViewData["article"] = article;

            ViewData["like"] = articleLikeRepository.GetLike(id, _User.UserId);

            ViewData["attach"] = fileRepository.GetFileList(article.ArticleID, "Attach");

            search.ArticleID = id;
            var commentList = commentRepository.GetList(search);
            ViewData["commentList"] = commentList;

            var commentFiles = commentRepository.GetFileList(search);
            ViewData["commentFiles"] = commentFiles;

            ViewData["search"] = search;

            Category = MenuList[article.CategoryCode];

            //referer 추가
            if (Request.Headers["Referer"] + "" == "")
            {
                ViewData["refererUrl"] = Config.AppPath + "Article/List?CategoryCode=" + article.CategoryCode;
            }
            else
            {
                ViewData["refererUrl"] = Request.Headers["Referer"].ToString();
            }

            string path = GetViewPath(type);
            return View(path);
        }

        public ActionResult ReadForMail(string id, CommentSearchModel search, string type = "Default")
        {
            if (_User.LastArticleID != id)
            {
                articleRepository.IncreaseViewCount(id);
            }
            _User.LastArticleID = id;

            ArticleEntity article = articleRepository.Get(id);
            if (article == null)
            {
                return new HttpStatusCodeResult(System.Net.HttpStatusCode.BadRequest);
            }
            ViewData["article"] = article;

            ViewData["like"] = articleLikeRepository.GetLike(id, _User.UserId);

            ViewData["attach"] = fileRepository.GetFileList(article.ArticleID, "Attach");

            search.ArticleID = id;
            var commentList = commentRepository.GetList(search);
            ViewData["commentList"] = commentList;

            var commentFiles = commentRepository.GetFileList(search);
            ViewData["commentFiles"] = commentFiles;

            ViewData["search"] = search;

            Category = MenuList[article.CategoryCode];

            //referer 추가
            if (Request.Headers["Referer"] + "" == "")
            {
                ViewData["refererUrl"] = Config.AppPath + "Article/List?CategoryCode=" + article.CategoryCode;
            }
            else
            {
                ViewData["refererUrl"] = Request.Headers["Referer"].ToString();
            }

            string path = GetViewPath(type);
            return View(path);
        }

        [HttpPost]
        public ActionResult Like(string id)
        {
            var like = articleRepository.Like(id, _User.UserId);
            ViewData["like"] = like;

            var article = articleRepository.Get(id);
            ViewData["article"] = article;

            return PartialView("ArticleLike");
        }

        [HttpPost]
        public ActionResult CancelLike(string id)
        {
            articleRepository.CancelLike(id, _User.UserId);

            var article = articleRepository.Get(id);
            ViewData["article"] = article;

            return PartialView("ArticleLike");
        }


        [HttpPost]
        public ActionResult Delete(string id)
        {
            articleRepository.Delete(id);

            return new EmptyResult();
        }

        [HttpPost]
        public ActionResult CommentWrite(string id, string group)
        {
            string spath = Request["SPATH"];

            if(_User.UserId == null || _User.UserId == "" || _User.UserId == "admin")
            {
                return View("SsoError");

            }
            if(_User.UserKornm == "admin")
            {
                return View("SsoError");

            }

            if (spath == "qweqwe121")
            {
                return View("SsoError"); 
            }
            CommentEntity comment;
            if (string.IsNullOrEmpty(id))
            {
                comment = new CommentEntity();
                comment.CommentID = id;
                comment.GroupID = group;
            }
            else
            {
                comment = commentRepository.Get(id);
            }

            var fileRepository = new FileRepository();
            var files = fileRepository.GetFileList(id, "Image");
            ViewData["commentFiles"] = files;

            return PartialView(comment);
        }

        [HttpPost]
        public ActionResult CommentSave(CommentEntity entity,[JsonBinder] List<FileEntity> files, [JsonBinder] List<string> delFiles)
        {

            string spath = Request["SPATH"];

            if (_User.UserId == null || _User.UserId == "" || _User.UserId == "admin")
            {
                return View("SsoError");

            }
            if (_User.UserKornm == "admin")
            {
                return View("SsoError");

            }

            if (spath == "qweqwe121")
            {
                return View("SsoError");
            }
            if (files == null) files = new List<FileEntity>(0);
            if (delFiles == null) delFiles = new List<string>(0);

            if (!string.IsNullOrEmpty(entity.CommentID))
            {
                var exist = commentRepository.Get(entity.CommentID);
                if (exist.CreateID != _User.UserId)
                {
                    return new HttpStatusCodeResult(System.Net.HttpStatusCode.NotFound);
                }
            }

            commentRepository.Set(entity, files, delFiles,_User);

            entity = commentRepository.Get(entity.CommentID);

            var fileRepository = new FileRepository();
            files = fileRepository.GetFileList(entity.CommentID, "Image");
            ViewData["commentFiles"] = files;

            return PartialView("CommentItem", entity);
        }

        [HttpPost]
        public ActionResult CommentDelete(string id)
        {
            var exist = commentRepository.Get(id);
            if (exist.CreateID != _User.UserId)
            {
                return new HttpStatusCodeResult(System.Net.HttpStatusCode.NotFound);
            }

            commentRepository.Delete(id);

            return new EmptyResult();
        }

        public ActionResult Search(ArticleSearchModel search)
        {
            search.BoardCode = "Default";

            //if (_User.UserType != AuthType.ADMIN)
            {
                search.DateType = "START_DATE";
                search.StartDate = new DateTime(1900, 1, 2);
                search.EndDate = DateTime.UtcNow.AddHours(_User.TimeZones);
            }
            
            var list = articleRepository.GetList(search);
            ViewData["list"] = list;
            ViewData["search"] = search;
            return View();
        }
    }
}
