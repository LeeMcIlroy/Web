
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Helpers;
using System.Web.Mvc;
using System.Web.Security;

namespace HallaTube.Controllers
{
#if DEBUG
#else
    [Authorize(AuthType.ADMIN)]
#endif
    public class AdminController : BaseController
    {
        ArticleRepository articleRepository = new ArticleRepository();
        ConfigRepository configRepository = new ConfigRepository();
        CategoryRepository categoryRepository = new CategoryRepository();
        FileRepository fileRepository = new FileRepository();

        public ActionResult Main()
        {
            ViewData["Data"]= configRepository.GetAll();
            return View();
        }


        public ActionResult Menu()
        {
            return View();
        }

        [HttpPost]
        public ActionResult MenuSave(CategoryEntity entity)
        {
            var list = new List<CategoryEntity>();
            list.Add(entity);
            categoryRepository.Set(list, _User);

            WebCache.Remove("Menu");
            WebCache.Remove("TopMenu");

            return new EmptyResult();
        }

        [HttpPost]
        public ActionResult MenuDelete(string id)
        {
            categoryRepository.Delete(id);

            WebCache.Remove("Menu");
            WebCache.Remove("TopMenu");

            return new EmptyResult();
        }

        public ActionResult MainArticle(string type)
        {
            var mainList = articleRepository.GetMainList(type,false);
            ViewData["mainList"] = mainList;

            return View($"Main{type}");
        }

        public ActionResult MainArticleSearch(ArticleSearchModel search, string type)
        {
            search.PageSize = 10000;
            search.BoardCode = "Default";

            var list = articleRepository.GetList(search);
            ViewData["list"] = list;
            ViewData["search"] = search;

            return PartialView($"Main{type}Search");
        }

        public ActionResult MainArticleHistory(SearchModel search, string type)
        {
            var list = articleRepository.GetMainHistoryList(search);
            ViewData["list"] = list;
            ViewData["search"] = search;

            return PartialView($"Main{type}History");
        }


        [HttpPost]
        public ActionResult MainArticleItem(string id, string type)
        {
            var article=articleRepository.Get(id);

            return PartialView($"Main{type}Apply", article);
        }

        [HttpPost]
        public ActionResult MainArticleSave([JsonBinder] List<ArticleSectionEntity> list, string type)
        {
            ArticleSectionRepository articleSectionRepository = new ArticleSectionRepository();
            articleSectionRepository.Save(list, type);

            return new EmptyResult();
        }




        public ActionResult BannerList(ArticleSearchModel search)
        {
            search.BoardCode = "Banner";

            var list = articleRepository.GetList(search);
            ViewData["list"] = list;
            ViewData["search"] = search;

            return View();
        }

        public ActionResult BannerWrite(string id)
        {
            ArticleEntity article;
            if (string.IsNullOrEmpty(id))
            {
                article = new ArticleEntity
                {
                    ArticleType="Top",
                    StartDate = DateTime.Now,
                    EndDate = DateTime.Now
                };
            }
            else
            {
                article = articleRepository.Get(id);
            }

            ViewData["article"] = article;

            ViewData["thumb"] = fileRepository.GetFile(article.ArticleID, "Thumb");

            return View();
        }

        [HttpPost]
        public ActionResult BannerWrite(string id, [JsonBinder]ArticleEntity entity, [JsonBinder]List<FileEntity> files, [JsonBinder]List<string> delFiles)
        {
            //articleRepository.Get(id);

            entity.ArticleID = id;
            entity.BoardCode = "Banner";

            articleRepository.Set(entity, files, delFiles, _User);
            return new EmptyResult();
        }

        [HttpPost]
        public ActionResult BannerDelete(string id)
        {
            articleRepository.Delete(id);

            return new EmptyResult();
        }

        public ActionResult HashtagList(ArticleSearchModel search)
        {
            search.BoardCode = "Hashtag";

            var list = articleRepository.GetList(search);
            ViewData["list"] = list;
            ViewData["search"] = search;

            return View();
        }

        public ActionResult HashtagWrite(string id)
        {
            ArticleEntity article;
            if (string.IsNullOrEmpty(id))
            {
                article = new ArticleEntity
                {
                    StartDate = DateTime.Now,
                    EndDate = DateTime.Now
                };
            }
            else
            {
                article = articleRepository.Get(id);
            }

            ViewData["article"] = article;

            var search = new ArticleSearchModel();
            search.BoardCode = "Hashtag";
            var list = articleRepository.GetList(search);
            ViewData["list"] = list;

            return View();
        }

        [HttpPost]
        public ActionResult HashtagWrite(string id, [JsonBinder]ArticleEntity entity, [JsonBinder]List<FileEntity> files, [JsonBinder]List<string> delFiles)
        {
            entity.ArticleID = id;
            entity.BoardCode = "Hashtag";

            articleRepository.Set(entity, files, delFiles, _User);
            return new EmptyResult();
        }

        [HttpPost]
        public ActionResult HashtagDelete(string id)
        {
            articleRepository.Delete(id);

            return new EmptyResult();
        }



        public ActionResult PairingList(ArticleSearchModel search)
        {
            search.BoardCode = "Pairing";

            var list = articleRepository.GetList(search);
            ViewData["list"] = list;
            ViewData["search"] = search;

            return View();
        }

        public ActionResult PairingWrite(string id)
        {
            ArticleEntity article;
            if (string.IsNullOrEmpty(id))
            {
                article = new ArticleEntity
                {
                    StartDate = DateTime.Now,
                    EndDate = DateTime.Now
                };
            }
            else
            {
                article = articleRepository.Get(id);
            }

            ViewData["article"] = article;


            return View();
        }

        [HttpPost]
        public ActionResult PairingWrite(string id, [JsonBinder]ArticleEntity entity, [JsonBinder]List<FileEntity> files, [JsonBinder]List<string> delFiles)
        {
            entity.ArticleID = id;
            entity.BoardCode = "Pairing";

            articleRepository.Set(entity, files, delFiles, _User);
            return new EmptyResult();
        }

        [HttpPost]
        public ActionResult PairingDelete(string id)
        {
            articleRepository.Delete(id);

            return new EmptyResult();
        }




        //영상관리
        public ActionResult VideoList(ArticleSearchModel search)
        {
            search.BoardCode = "Video";

            var list = articleRepository.GetList(search);
            ViewData["list"] = list;
            ViewData["search"] = search;

            return View();
        }

        public ActionResult VideoWrite(string id)
        {
            ArticleEntity article;
            if (string.IsNullOrEmpty(id))
            {
                article = new ArticleEntity
                {
                    ArticleType = "Top",
                    StartDate = DateTime.Now,
                    EndDate = DateTime.Now
                };
            }
            else
            {
                article = articleRepository.Get(id);
            }

            ViewData["article"] = article;


            return View();
        }

        [HttpPost]
        public ActionResult VideoWrite(string id, [JsonBinder] ArticleEntity entity, [JsonBinder]List<FileEntity> files, [JsonBinder] List<string> delFiles)
        {
            //articleRepository.Get(id);

            entity.ArticleID = id;
            entity.BoardCode = "Video";

            articleRepository.Set(entity, files, delFiles, _User);
            return Json(entity);
        }

        [HttpPost]
        public ActionResult VideoDelete(string id)
        {
            articleRepository.Delete(id);

            return new EmptyResult();
        }


        //관리자 목록
        public ActionResult Manager()
        {
            var list = categoryRepository.GetTypeCategoryList(CategoryType.Manager);
            ViewData["List"] = list;
            return View();
        }

        //관리자 저장
        public ActionResult SaveManager([JsonBinder]List<CategoryEntity> list)
        {
            foreach (var item in list)
            {
                item.CategoryType = CategoryType.Manager;
                item.ParentID = "000000000020";
            }
            categoryRepository.Set(list, _User);

            return new EmptyResult();
        }

        //관리자 삭제
        public ActionResult DeleteManager(string[] list)
        {
            categoryRepository.DeleteCategory(list);

            return new EmptyResult();
        }


        public ActionResult StatsConnect(StatsSearchModel search)
        {
            search.Timezones = _User.TimeZones;
            if (Request.HttpMethod == "GET")
            {
                search.EndDate = DateTime.Today;
                if (string.IsNullOrEmpty(search.DateType))
                {
                    search.DateType = "Hour";
                }

                if (search.DateType=="Hour")
                {
                    search.StartDate = search.EndDate.AddDays(-1);
                }
                else if (search.DateType == "Day")
                {
                    search.StartDate = search.EndDate.AddMonths(-1);
                }
                else if (search.DateType == "Month")
                {
                    search.StartDate = search.EndDate.AddYears(-1);
                }
                else if (search.DateType == "Year")
                {
                    search.StartDate = new DateTime(2020, 1, 1);
                }
            }

            var logRepository = new LogRepository();
            if (search.UseExcel == Const.True)
            {
                var list = logRepository.GetStatsData(search);
                ViewData["list"] = list;

                return View("StatsExcel");
            }
            else
            {
                var dt = logRepository.GetStats(search);
                ViewData["dt"] = dt;

                string tempDateType = search.DateType;
                if (!string.IsNullOrEmpty(search.UserCompNm))
                {
                    search.DateType = "Grade";
                    var dtGrade = logRepository.GetStats(search);
                    ViewData["dtGrade"] = dtGrade;

                    search.DateType = "Position";
                    var dtPosition = logRepository.GetStats(search);
                    ViewData["dtPosition"] = dtPosition;
                }
                search.DateType = tempDateType;

                ViewData["search"] = search;

                return View();
            }
            
        }

        public ActionResult StatsContents()
        {
            var list = categoryRepository.GetTypeCategoryList(CategoryType.Manager);
            ViewData["List"] = list;
            return View();
        }

        public ActionResult StatsContentsChart(StatsSearchModel search)
        {
            search.Timezones = _User.TimeZones;
            var now = DateTime.UtcNow;
            search.EndDate = new DateTime(now.Year, now.Month, now.Day);
            search.StartDate = search.EndDate.AddDays(-30);

            var logRepository = new LogRepository();
            var list = logRepository.GetTargetData(search);
            ViewData["list"] = list;

            if (search.UseExcel == Const.True)
            {
                

                return View("StatsExcel");
            }
            else
            {
                var dt = logRepository.GetTargetStats(search);
                ViewData["dt"] = dt;

                string tempDateType = search.DateType;
                if (!string.IsNullOrEmpty(search.UserCompNm))
                {
                    search.DateType = "Grade";
                    var dtGrade = logRepository.GetTargetStats(search);
                    ViewData["dtGrade"] = dtGrade;

                    search.DateType = "Position";
                    var dtPosition = logRepository.GetTargetStats(search);
                    ViewData["dtPosition"] = dtPosition;
                }
                search.DateType = tempDateType;

                ViewData["search"] = search;

                return PartialView();
            }
        }
    }

    
}
