
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Transactions;

using Castle.Data;

namespace HallaTube
{
    public class StatsSearchModel : SearchModel
    {
        public string UserCompNm { set; get; }
        public float Timezones { set; get; }
        public string Unique { set; get; }
        public string TargetID { set; get; }
    }

    public class LogRepository : DataRepository
    {

        public List<LogEntity> GetList(SearchModel search, bool containCount = true)
        {
            search.SetSort();

            int start = (search.PageNumber - 1) * search.PageSize;
            int end = search.PageNumber * search.PageSize;

            search.EndDate = search.EndDate.AddDays(1);

            DataCommand command = GetCommand("Log.GetList", search, new { IsCount = false, RowStart = start, RowEnd = end });
            var list = command.ExecuteDataTable().GetEntityList<LogEntity>();

            if (containCount)
            {
                command = GetCommand("Log.GetList", search, new { IsCount = true });
                object rtn = command.ExecuteScalar();
                search.TotalCount = long.Parse(rtn.ToString());
            }

            search.EndDate = search.EndDate.AddDays(-1);

            return list;
        }

        public void Create(LogEntity log)
        {
            log.LogID = Sequence.Generate();
            ExecuteNonQuery("Log.Create", log);
        }

        public LogEntity Get(string logID)
        {
            return ExecuteDataRow("Log.Get", new { logID }).GetEntity<LogEntity>();
        }

        public DataTable GetStats(StatsSearchModel search)
        {
            DataCommand command = GetCommand("Log.GetStats", search);
            return command.ExecuteDataTable();
            //return ExecuteDataTable("Log.GetStats", search);
        }

        public List<LogEntity> GetStatsData(StatsSearchModel search)
        {
            DataCommand command = GetCommand("Log.GetStatsData", search);
            return command.ExecuteDataTable().GetEntityList<LogEntity>();
            //return ExecuteDataTable("Log.GetStatsData", search).GetEntityList<LogEntity>();
        }

        public DataTable GetTargetStats(StatsSearchModel search)
        {
            return ExecuteDataTable("Log.GetTargetStats", search);
        }

        public List<LogEntity> GetTargetData(StatsSearchModel search)
        {
            return ExecuteDataTable("Log.GetTargetData", search).GetEntityList<LogEntity>();
        }

        
        public void Update(LogEntity log)
        {
            using (var scope = new TransactionScope(TransactionScopeOption.Required, tranOption, EnterpriseServicesInteropOption.None))
            {
                ExecuteNonQuery("Log.Update", log);
                scope.Complete();
            }
        }

        public void Delete(string logID)
        {
            ExecuteNonQuery("Log.Delete", new { logID });
        }

        public DataTable GetCompList()
        {
            return ExecuteDataTable("Log.GetCompList");
        }
        

        public long GetHitHashtagCount(string articleID, string word)
        {
            object result= ExecuteScalar("Log.GetHitHashtagCount", new { articleID, word });
            if(result is long)
            {
                return (long)result;
            }
            return 0;
        }
        
    }
}
