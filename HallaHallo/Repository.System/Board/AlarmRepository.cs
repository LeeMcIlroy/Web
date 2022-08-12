
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Transactions;

using Castle.Data;

namespace HallaTube
{
    public class AlarmRepository : DataRepository
    {

        public List<AlarmEntity> GetList(SearchModel search, bool containCount = true)
        {
            search.SetSort();

            int start = (search.PageNumber - 1) * search.PageSize;
            int end = search.PageNumber * search.PageSize;

            search.EndDate = search.EndDate.AddDays(1);

            DataCommand command = GetCommand("Alarm.GetList", search, new { IsCount = false, RowStart = start, RowEnd = end });
            var list = command.ExecuteDataTable().GetEntityList<AlarmEntity>();

            if (containCount)
            {
                command = GetCommand("Alarm.GetList", search, new { IsCount = true });
                object rtn = command.ExecuteScalar();
                search.TotalCount = long.Parse(rtn.ToString());
            }

            search.EndDate = search.EndDate.AddDays(-1);

            return list;
        }

        
        public void Create(AlarmEntity alarm)
        {
            using (var scope = new TransactionScope(TransactionScopeOption.Required, tranOption, EnterpriseServicesInteropOption.None))
            {
                ExecuteNonQuery("Alarm.Create", alarm);
                scope.Complete();
            }
        }

        public AlarmEntity Get(string alarmID)
        {
            return ExecuteDataRow("Alarm.Get", new { alarmID }).GetEntity<AlarmEntity>();
        }

        public bool Exist(string regID)
        {
            return ExecuteScalar("Alarm.Exist", new { regID }) != null;
        }

        public void Update(AlarmEntity alarm)
        {
            using (var scope = new TransactionScope(TransactionScopeOption.Required, tranOption, EnterpriseServicesInteropOption.None))
            {
                ExecuteNonQuery("Alarm.Update", alarm);
                scope.Complete();
            }
        }


        public void Read(string alarmID)
        {
            ExecuteNonQuery("Alarm.Read", new { alarmID });
        }

        public void Delete(string alarmID)
        {
            ExecuteNonQuery("Alarm.Delete", new { alarmID });
        }

        public void DeleteRead(string regID)
        {
            ExecuteNonQuery("Alarm.DeleteRead", new { regID });
        }

        public void DeleteAll(string regID)
        {
            ExecuteNonQuery("Alarm.DeleteAll", new { regID });
        }


        
    }
}
