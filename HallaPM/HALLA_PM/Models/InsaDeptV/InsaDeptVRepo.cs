using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Data;
using Dapper;
using HALLA_PM.Util;

namespace HALLA_PM.Models
{
    public class InsaDeptVRepo : DbCon, IInsaDeptVRepo
    {
        public int count(object param)
        {
            throw new NotImplementedException();
        }

        public int delete(object key)
        {
            throw new NotImplementedException();
        }

        public void Dispose()
        {
            throw new NotImplementedException();
        }

        public int insert(InsaDeptV entity)
        {
            throw new NotImplementedException();
        }

        public int save(InsaDeptV entity)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<InsaDeptV> selectList(object param)
        {
            throw new NotImplementedException();
        }

        public InsaDeptV selectOne(object param)
        {
            using (IDbConnection con = GetInsaDb())
            {
                try
                {
                    con.Open();

                    string query = " SELECT * FROM TB_HEIS_InsaDeptV WHERE DeptCode = @Deptcode  ";
                    return con.Query<InsaDeptV>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public int update(InsaDeptV entity)
        {
            throw new NotImplementedException();
        }
    }
}