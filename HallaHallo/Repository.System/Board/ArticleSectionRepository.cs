
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Transactions;

using Castle.Data;

namespace HallaTube
{
    public class ArticleSectionRepository : DataRepository
    {

        public List<ArticleSectionEntity> GetList(SearchModel search, bool containCount = true)
        {
            search.SetSort();

            int start = (search.PageNumber - 1) * search.PageSize;
            int end = search.PageNumber * search.PageSize;

            search.EndDate = search.EndDate.AddDays(1);

            DataCommand command = GetCommand("ArticleSection.GetList", search, new { IsCount = false, RowStart = start, RowEnd = end });
            var list = command.ExecuteDataTable().GetEntityList<ArticleSectionEntity>();

            if (containCount)
            {
                command = GetCommand("ArticleSection.GetList", search, new { IsCount = true });
                object rtn = command.ExecuteScalar();
                search.TotalCount = long.Parse(rtn.ToString());
            }

            search.EndDate = search.EndDate.AddDays(-1);

            return list;
        }

        public void Create(ArticleSectionEntity articleSection)
        {
            using (var scope = new TransactionScope(TransactionScopeOption.Required, tranOption, EnterpriseServicesInteropOption.None))
            {
                ExecuteNonQuery("ArticleSection.Create", articleSection);
                scope.Complete();
            }
        }

        public ArticleSectionEntity Get(string articleSectionID)
        {
            return ExecuteDataRow("ArticleSection.Get", new { articleSectionID }).GetEntity<ArticleSectionEntity>();
        }
       
        public void Update(ArticleSectionEntity articleSection)
        {
            using (var scope = new TransactionScope(TransactionScopeOption.Required, tranOption, EnterpriseServicesInteropOption.None))
            {
                ExecuteNonQuery("ArticleSection.Update", articleSection);
                scope.Complete();
            }
        }

        public void Delete(string articleSectionID)
        {
            ExecuteNonQuery("ArticleSection.Delete", new { articleSectionID });
        }

        public void Save(List<ArticleSectionEntity> list, string type)
        {
            using (var scope = new TransactionScope(TransactionScopeOption.Required, tranOption, EnterpriseServicesInteropOption.None))
            {
                if (type == "New")
                {
                    ExecuteNonQuery("ArticleSection.DeleteNew");
                }


                foreach (var item in list)
                {
                    var article = ExecuteDataRow("Article.Get", new { item.ArticleID }).GetEntity<ArticleEntity>();

                    bool create = string.IsNullOrEmpty(item.SectionID);

                    item.ExistViewCount = article.ViewCount;
                    item.RegDate = DateTime.UtcNow;

                    if (create || type == "New")
                    {
                        item.SectionID = Sequence.Generate();
                        ExecuteNonQuery("ArticleSection.Create", item);
                    }
                    else
                    {
                        ExecuteNonQuery("ArticleSection.Update", item);
                    }
                }

                scope.Complete();
            }
        }
    }
}
