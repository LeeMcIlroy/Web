
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Transactions;

using Castle.Data;

namespace HallaTube
{
    public class BoardRepository : DataRepository
    {

        public List<BoardEntity> GetList(SearchModel search, bool containCount = true)
        {
            search.SetSort();

            int start = (search.PageNumber - 1) * search.PageSize;
            int end = search.PageNumber * search.PageSize;

            search.EndDate = search.EndDate.AddDays(1);

            DataCommand command = GetCommand("Board.GetList", search, new { IsCount = false, RowStart = start, RowEnd = end });
            var list = command.ExecuteDataTable().GetEntityList<BoardEntity>();

            if (containCount)
            {
                command = GetCommand("Board.GetList", search, new { IsCount = true });
                object rtn = command.ExecuteScalar();
                search.TotalCount = long.Parse(rtn.ToString());
            }

            search.EndDate = search.EndDate.AddDays(-1);

            return list;
        }

        public void Create(BoardEntity board)
        {
            using (var scope = new TransactionScope(TransactionScopeOption.Required, tranOption, EnterpriseServicesInteropOption.None))
            {
                ExecuteNonQuery("Board.Create", board);
                scope.Complete();
            }
        }

        public BoardEntity Get(string boardID)
        {
            return ExecuteDataRow("Board.Get", new { boardID }).GetEntity<BoardEntity>();
        }
       
        public void Update(BoardEntity board)
        {
            using (var scope = new TransactionScope(TransactionScopeOption.Required, tranOption, EnterpriseServicesInteropOption.None))
            {
                ExecuteNonQuery("Board.Update", board);
                scope.Complete();
            }
        }

        public void Delete(string boardID)
        {
            ExecuteNonQuery("Board.Delete", new { boardID });
        }
    }
}
