using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Data;
using Dapper;
using HALLA_PM.Util;

namespace HALLA_PM.Models
{
    public class PushDetailRepo : DbCon, IPushDetailRepo
    {
        public int count(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " SELECT COUNT(*) FROM PUSH_DETAIL ";
                    return con.Query<int>(query, param).First();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return -1;
                }
            }
        }

        public int delete(object key)
        {
            throw new NotImplementedException();
        }

        public void Dispose()
        {
            throw new NotImplementedException();
        }

        public int insert(PushDetail entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " INSERT INTO  PUSH_DETAIL ( " +
                        // 이부분은 수정하여 사용하세요. 
                        " PUSH_IDX " +
                        ", USER_IDX " +
                        ", PUSH_CONFIRM " +
                        ", CREATED_AT " +
                    " ) VALUES ( " +
                    " @PushIdx " +
                    ", @UserIdx " +
                    ", @PushConfirm " +
                    ", GETDATE() " +
                    // 이부분은 수정하여 사용하세요. 
                    "); " +
                    " SELECT @@ROWCOUNT";
                    return con.Query<int>(query, entity).First();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return -1;
                }
            }

        }

        public int save(PushDetail entity)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<PushDetail> selectList(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string where = " WHERE 1 = 1 ";
                    where += " AND PUSH_IDX = @PushIdx ";
                    where += " AND USER_IDX = @UserIdx ";

                    string query = " SELECT * FROM PUSH_DETAIL " + where;

                    //search.TotalCount = count(search);
                    //search.MakePaging();

                    return con.Query<PushDetail>(query, param).ToList();

                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public PushDetail selectOne(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string where = " WHERE 1 = 1 ";
                    where += " AND PUSH_IDX = @PushIdx ";

                    string query = " SELECT * FROM PUSH_DETAIL " + where;

                    //search.TotalCount = count(search);
                    //search.MakePaging();

                    return con.Query<PushDetail>(query, param).First();

                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public int update(PushDetail entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " UPDATE PUSH_DETAIL SET " +
                        // 이부분은 수정하여 사용하세요. 
                        " , PUSH_CONFIRM = @PushConfirm" +
                        " , CREATED_AT = GETDATE()" +
                        " WHERE PUSH_IDX = @PushIdx" +
                        " AND USER_IDX = @UserIdx" +
                    // 이부분은 수정하여 사용하세요. 
                    "; SELECT @@ROWCOUNT";
                    return con.Query<int>(query, entity).First();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return -1;
                }
            }

        }
    }
}