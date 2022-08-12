using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Data;
using Dapper;
using HALLA_PM.Util;

namespace HALLA_PM.Models
{
    public class PushMasterRepo : DbCon, IPushMasterRepo
    {
        public int count(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " SELECT COUNT(*) FROM PUSH_MASTER ";
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

        public int insert(PushMaster entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " INSERT INTO  PUSH_MASTER ( " +
                        // 이부분은 수정하여 사용하세요. 
                        //" PUSH_IDX " +
                        "  TYPE " +
                        ", TITLE " +
                        ", CONTENTS " +
                        ", LINK " +
                        ", RESPONSE " +
                        //", SENDED_AT " +
                        ", CREATED_AT " +
                    " ) VALUES ( " +
                    //" @PushIdx " +
                    "  @Type " +
                    ", @Title " +
                    ", @Contents " +
                    ", @Link " +
                    ", @Response " +
                    //", @SendedAt " +
                    ", GETDATE() " +
                    // 이부분은 수정하여 사용하세요. 
                    "); SELECT CAST(SCOPE_IDENTITY() as int)";
                    return con.Query<int>(query, entity).First();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return -1;
                }
            }
        }

        public int save(PushMaster entity)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<PushMaster> selectList(object param)
        {
            throw new NotImplementedException();
        }

        public PushMaster selectOne(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string where = " WHERE 1 = 1 ";
                    where += " AND PUSH_IDX = @PushIdx ";

                    string query = " SELECT * FROM PUSH_MASTER " + where;

                    //search.TotalCount = count(search);
                    //search.MakePaging();

                    return con.Query<PushMaster>(query, param).First();

                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public int update(PushMaster entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " UPDATE PUSH_MASTER SET " +
                        // 이부분은 수정하여 사용하세요. 
                        " TYPE = @Type" +
                        " , TITLE = @Title" +
                        " , CONTENTS = @Contents" +
                        " , RESPONSE = @Response" +
                        " , SENDED_AT = @SendedAt" +
                        " , CREATED_AT = @CreatedAt" +
                        " WHERE PUSH_IDX = @PushIdx" +
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