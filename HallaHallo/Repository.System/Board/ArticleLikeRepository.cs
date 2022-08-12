
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Transactions;

using Castle.Data;

namespace HallaTube
{
    public class ArticleLikeRepository : DataRepository
    {

        public List<ArticleLikeEntity> GetList(SearchModel search, bool containCount = true)
        {
            search.SetSort();

            int start = (search.PageNumber - 1) * search.PageSize;
            int end = search.PageNumber * search.PageSize;

            search.EndDate = search.EndDate.AddDays(1);

            DataCommand command = GetCommand("ArticleLike.GetList", search, new { IsCount = false, RowStart = start, RowEnd = end });
            var list = command.ExecuteDataTable().GetEntityList<ArticleLikeEntity>();

            if (containCount)
            {
                command = GetCommand("ArticleLike.GetList", search, new { IsCount = true });
                object rtn = command.ExecuteScalar();
                search.TotalCount = long.Parse(rtn.ToString());
            }

            search.EndDate = search.EndDate.AddDays(-1);

            return list;
        }

        public void Create(ArticleLikeEntity articleLike)
        {
            using (var scope = new TransactionScope(TransactionScopeOption.Required, tranOption, EnterpriseServicesInteropOption.None))
            {
                ExecuteNonQuery("ArticleLike.Create", articleLike);
                scope.Complete();
            }
        }

        public ArticleLikeEntity Get(string articleLikeID)
        {
            return ExecuteDataRow("ArticleLike.Get", new { articleLikeID }).GetEntity<ArticleLikeEntity>();
        }
       
        public void Update(ArticleLikeEntity articleLike)
        {
            using (var scope = new TransactionScope(TransactionScopeOption.Required, tranOption, EnterpriseServicesInteropOption.None))
            {
                ExecuteNonQuery("ArticleLike.Update", articleLike);
                scope.Complete();
            }
        }

        public void Delete(string articleLikeID)
        {
            ExecuteNonQuery("ArticleLike.Delete", new { articleLikeID });
        }

        public ArticleLikeEntity GetLike(string articleID, string regID)
        {
            return ExecuteDataRow("ArticleLike.GetLike", new { articleID, regID }).GetEntity<ArticleLikeEntity>();
        }
    }
}
