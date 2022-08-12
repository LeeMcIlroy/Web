
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Transactions;

using Castle.Data;

namespace HallaTube
{
    public class ConfigRepository : DataRepository
    {
        
        public void Create(ConfigEntity config)
        {
            using (var scope = new TransactionScope(TransactionScopeOption.Required, tranOption, EnterpriseServicesInteropOption.None))
            {
                ExecuteNonQuery("Config.CreateFile", config);
                scope.Complete();
            }
        }

        public void Update(ConfigEntity config)
        {
            ExecuteNonQuery("Config.UpdateConfig", config);
        }

        public ConfigEntity Get(string configID)
        {
            return ExecuteDataRow("Config.Get", new { configID }).GetEntity<ConfigEntity>();
        }

        public Dictionary<string,string> GetAll()
        {
            var list= ExecuteDataTable("Config.GetAll").GetEntityList<ConfigEntity>();
            var dic = new Dictionary<string, string>(list.Count);
            foreach(var item in list)
            {
                dic.Add(item.ConfigID, item.Value);
            }
            return dic;
        }

        public void SaveAll(Dictionary<string, string> dic)
        {
            using (var scope = new TransactionScope(TransactionScopeOption.Required, tranOption, EnterpriseServicesInteropOption.None))
            {
                foreach (var item in dic)
                {
                    var entity = new ConfigEntity
                    {
                        ConfigID = item.Key,
                        Value = item.Value,
                        RegDate = DateTime.Now
                    };

                    string key = entity.ConfigID;
                    if (key.IndexOf("Use") > 0 && string.IsNullOrEmpty(entity.Value))
                    {
                        entity.Value = Const.False;
                    }

                    int effect = ExecuteNonQuery("Config.UpdateConfig", entity);
                    if (effect == 0)
                    {
                        ExecuteNonQuery("Config.CreateConfig", entity);
                    }
                }

                scope.Complete();
            }
        }

        public void Delete(string configID)
        {
            ExecuteNonQuery("Config.DeleteFile", new { configID });
        }

    }
}
