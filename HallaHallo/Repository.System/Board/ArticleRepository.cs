
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Text;
using System.Transactions;

using Castle.Data;

namespace HallaTube
{
    public class ArticleRepository : DataRepository
    {

        public List<ArticleEntity> GetList(SearchModel search, bool containCount = true)
        {
            search.SetSort();
            if (search.Word == null) search.Word = "";

            int start = (search.PageNumber - 1) * search.PageSize;
            int end = search.PageNumber * search.PageSize;

            //search.EndDate = search.EndDate.AddDays(1);

            DataCommand command = GetCommand("Article.GetList", search, new { IsCount = false, RowStart = start, RowEnd = end });
            var list = command.ExecuteDataTable().GetEntityList<ArticleEntity>();

            if (containCount)
            {
                command = GetCommand("Article.GetList", search, new { IsCount = true });
                object rtn = command.ExecuteScalar();
                search.TotalCount = long.Parse(rtn.ToString());
            }

            //search.EndDate = search.EndDate.AddDays(-1);

            return list;
        }

        public List<ArticleEntity> GetAllList(SearchModel search, bool containCount = true)
        {
            search.SetSort();
            if (search.Word == null) search.Word = "";

            int start = (search.PageNumber - 1) * search.PageSize;
            int end = search.PageNumber * search.PageSize;

            //search.EndDate = search.EndDate.AddDays(1);

            DataCommand command = GetCommand("Article.GetAllList", search, new { IsCount = false, RowStart = start, RowEnd = end });
            var list = command.ExecuteDataTable().GetEntityList<ArticleEntity>();

            if (containCount)
            {
                command = GetCommand("Article.GetAllList", search, new { IsCount = true });
                object rtn = command.ExecuteScalar();
                search.TotalCount = long.Parse(rtn.ToString());
            }

            //search.EndDate = search.EndDate.AddDays(-1);

            return list;
        }

        public object GetBanner(string type,DateTime date)
        {
            return ExecuteDataTable("Article.GetBanner", new { type, date= date.ToDate() }).GetEntityList<ArticleEntity>();
        }

        public void Set(ArticleEntity article, List<FileEntity> files, List<string> delFiles, UserModel user)
        {
            bool create = string.IsNullOrEmpty(article.ArticleID);

            using (var scope = new TransactionScope(TransactionScopeOption.Required, tranOption, EnterpriseServicesInteropOption.None))
            {
                if(article.Hashtag!=null)
                {
                    StringBuilder sb = new StringBuilder();
                    foreach(string t in article.Hashtag.Split('#'))
                    {
                        if (string.IsNullOrEmpty(t)) continue;
                        sb.Append($"#{t.Trim()}");
                    }
                    article.Hashtag = sb.ToString();
                }

                if (article.BoardCode == "Default")
                {
                    if (article.State == "Open")
                    {
                        article.StartDate = new DateTime(1900, 1, 2);
                    }
                    else if (article.State == "Private")
                    {
                        article.StartDate = new DateTime(3000, 1, 2);
                    }
                }

                if (create)
                {
                    article.ArticleID = Sequence.Generate();
                    article.ArticleLevel = 1;

                    article.RegID = user.UserId;
                    article.UserKornm = user.UserKornm;
                    article.UserEngnm = user.UserEngnm;
                    article.UserChnnm = user.UserChnnm;
                    article.RegDate = DateTime.UtcNow;
                    article.IsNotice = Const.False;
                    article.IsDel = Const.False;

                    ExecuteNonQuery("Article.Create", article);
                }
                else
                {
                    ExecuteNonQuery("Article.Update", article);
                }

                if (delFiles != null)
                {
                    foreach (var file in delFiles)
                    {
                        ExecuteNonQuery("File.Delete", new { fileID = file });
                    }
                }

                if (files != null)
                {
                    foreach (var file in files)
                    {
                        file.ObjectID = article.ArticleID;
                        bool createFile = string.IsNullOrEmpty(file.FileID);
                        if (createFile)
                        {
                            file.FileID = Sequence.Generate();
                            file.RegDate = DateTime.UtcNow;
                            if (file.Path.StartsWith("/dext5uploaddata"))
                            {
                                file.Extension = System.IO.Path.GetExtension(file.Path);
                                file.Path = $"/{Config.AppName}{file.Path}";
                            }
                            else
                            {
                                file.TempPath = file.Path;
                                file.Path = Config.GetFileTypePath(file.ObjectType, file.FileID, file.Extension, file.RegDate, bMapPath: false);
                            }

                            ExecuteNonQuery("File.Create", file);
                        }
                        else
                        {
                            ExecuteNonQuery("File.Update", file);
                        }
                    }
                }

                scope.Complete();
            }

            if (delFiles != null)
            {
                //삭제 안함
            }

            if (files != null)
            {
                foreach (var file in files)
                {
                    if (file.Path.StartsWith($"/{Config.AppName}/dext5uploaddata"))
                    {
                        //file.Path = $"/{Config.AppName}{file.Path}";
                    }
                    else
                    {
                        string tempPath = Config.GetPath(file.TempPath);
                        if (System.IO.File.Exists(tempPath))
                        {
                            System.IO.File.Move(tempPath, Config.GetPath(file.Path));
                        }
                    }
                }
            }
            
        }

        string[] sectionCodesCarousel = new string[] { "CarouselLeft", "CarouselRightTop", "CarouselRightBottom" };
        string[] sectionCodesHot = new string[] { "HotLeftLeftTop", "HotLeftLeftBottom", "HotLeftRightTop", "HotLeftRightBottom", "HotRight" };
        string[] sectionCodesNew = null;
        public List<ArticleEntity> GetMainList(string type, bool fit=true)
        {
            string[] target;
            if (type == "Carousel")
            {
                target = sectionCodesCarousel;
            }
            else if (type == "Hot")
            {
                target = sectionCodesHot;
            }
            else if(type == "New")
            {
                if (sectionCodesNew == null)
                {
                    sectionCodesNew = new string[12];
                    for (int i = 1; i <= sectionCodesNew.Length; i++)
                    {
                        sectionCodesNew[i-1] = $"New{i}";
                    }
                    
                }
                
                target = sectionCodesNew;
            }
            else
            {
                target = new string[0];
            }

            string codes = string.Join("','", target);
            var list= ExecuteDataTable("Article.GetMainList", new { codes }).GetEntityList<ArticleEntity>();
            if (list.Count == 0)
            {
                
            }
            //TODO: 메인 최신콘텐츠 컨트롤러 영역
            if (fit && type == "New" && list.Count < target.Length)
            {
                var temp=ExecuteDataTable("Article.GetNewList", new { Count = target.Length- list.Count }).GetEntityList<ArticleEntity>();
                list.AddRange(temp);
            }
            return list;
        }

        public List<ArticleEntity> GetMainHistoryList(SearchModel search, bool containCount = true)
        {
            search.SetSort();

            int start = (search.PageNumber - 1) * search.PageSize;
            int end = search.PageNumber * search.PageSize;

            search.EndDate = search.EndDate.AddDays(1);

            var codes = string.Join("','", sectionCodesCarousel);
            DataCommand command = GetCommand("Article.GetMainHistoryList", search, new { codes }, new { IsCount = false, RowStart = start, RowEnd = end });
            var list = command.ExecuteDataTable().GetEntityList<ArticleEntity>();

            if (containCount)
            {
                command = GetCommand("Article.GetMainHistoryList", search, new { codes }, new { IsCount = true });
                object rtn = command.ExecuteScalar();
                search.TotalCount = long.Parse(rtn.ToString());
            }

            search.EndDate = search.EndDate.AddDays(-1);

            return list;
        }


        public void Create(ArticleEntity article)
        {
            using (var scope = new TransactionScope(TransactionScopeOption.Required, tranOption, EnterpriseServicesInteropOption.None))
            {
                ExecuteNonQuery("Article.Create", article);
                scope.Complete();
            }
        }

        public void CancelLike(string articleID, string regID)
        {
            var like = ExecuteDataRow("ArticleLike.GetLike", new { articleID, regID }).GetEntity<ArticleLikeEntity>();
            if (like != null)
            {
                using (var scope = new TransactionScope(TransactionScopeOption.Required, tranOption, EnterpriseServicesInteropOption.None))
                {
                    ExecuteNonQuery("ArticleLike.DeleteLike", new { articleID, regID });
                    ExecuteNonQuery("Article.DecreaseLikeCount", new { articleID });
                    scope.Complete();
                }
            }
            
        }

        public ArticleLikeEntity Like(string articleID, string regID)
        {
            var like = ExecuteDataRow("ArticleLike.GetLike", new { articleID, regID }).GetEntity<ArticleLikeEntity>();
            if (like == null)
            {
                using (var scope = new TransactionScope(TransactionScopeOption.Required, tranOption, EnterpriseServicesInteropOption.None))
                {
                    like = new ArticleLikeEntity
                    {
                        LikeID = Sequence.Generate(),
                        ArticleID = articleID,
                        RegDate = DateTime.UtcNow,
                        RegID = regID
                    };

                    ExecuteNonQuery("ArticleLike.Create", like);
                    ExecuteNonQuery("Article.IncreaseLikeCount", new { articleID });
                    scope.Complete();
                }
            }
            
            return like;
        }

        public ArticleEntity Get(string articleID)
        {
            var dr = ExecuteDataRow("Article.Get", new { articleID });
            return dr.GetEntity<ArticleEntity>();
        }

        public List<ArticleEntity> GetRelatedList(ArticleEntity target)
        {
            var data = target.Hashtag.Split('#');
            var list = new List<ArticleEntity>(4);
            foreach(string word in data)
            {
                if (string.IsNullOrEmpty(word)) continue;

                var result=ExecuteDataTable("Article.GetRelatedList", new { word }).GetEntityList<ArticleEntity>();
                foreach(var item in result)
                {
                    if (target.ArticleID == item.ArticleID) continue;
                    if (list.Exists(p => p.ArticleID == item.ArticleID)) continue;

                    list.Add(item);
                }
                if (list.Count >= 4) break;
            }

            if (list.Count > 4)
            {
                list.RemoveRange(4, list.Count - 4);
            }

            return list;
        }

        public List<ArticleEntity> GetNewList()
        {
            var list=ExecuteDataTable("Article.GetNewList", new { Count = 4 }).GetEntityList<ArticleEntity>();

            return list;
        }

        public void IncreaseViewCount(string articleID)
        {
            ExecuteNonQuery("Article.IncreaseViewCount", new { articleID });
        }

        public void Update(ArticleEntity article)
        {
            using (var scope = new TransactionScope(TransactionScopeOption.Required, tranOption, EnterpriseServicesInteropOption.None))
            {
                ExecuteNonQuery("Article.Update", article);
                scope.Complete();
            }
        }

        public void Delete(string articleID)
        {
            ExecuteNonQuery("Article.Delete", new { articleID });
        }
    }
}
