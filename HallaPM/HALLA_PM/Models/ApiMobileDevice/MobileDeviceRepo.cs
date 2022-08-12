using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Data;
using Dapper;
using HALLA_PM.Util;

namespace HALLA_PM.Models
{
    public class MobileDeviceRepo : DbCon, IMobileDeviceRepo
    {
        public int count(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " SELECT COUNT(*) FROM MOBILE_DEVICE ";
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

        public int insert(MobileDevice entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " INSERT INTO  MOBILE_DEVICE ( " +
                        // 이부분은 수정하여 사용하세요. 
                        " USER_IDX " +
                        ", DEVICE_TOKEN " +
                        ", DEVICE_TYPE " +
                        ", CREATED_AT " +
                    " ) VALUES ( " +
                    " @UserIdx " +
                    ", @DeviceToken " +
                    ", @DeviceType " +
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

        public int save(MobileDevice entity)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<MobileDevice> selectAll()
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string where = " WHERE 1 = 1 ";

                    string query = " SELECT * FROM MOBILE_DEVICE " + where;

                    return con.Query<MobileDevice>(query).ToList();

                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<MobileDevice> selectList(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string where = " WHERE 1 = 1 ";
                    //where += " AND USER_IDX = @UserIdx ";

                    string query = " SELECT * FROM MOBILE_DEVICE " + where;

                    //search.TotalCount = count(search);
                    //search.MakePaging();

                    return con.Query<MobileDevice>(query, param).ToList();

                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public MobileDevice selectOne(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string where = " WHERE 1 = 1 ";
                    where += " AND USER_IDX = @UserIdx ";

                    string query = " SELECT * FROM MOBILE_DEVICE " + where;

                    //search.TotalCount = count(search);
                    //search.MakePaging();

                    return con.Query<MobileDevice>(query, param).First();

                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public int update(MobileDevice entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " UPDATE MOBILE_DEVICE SET " +
                        // 이부분은 수정하여 사용하세요. 
                        " DEVICE_TOKEN = @DeviceToken" +
                        " , DEVICE_TYPE = @DeviceType" +
                        " , CREATED_AT = GETDATE()" +
                        " WHERE USER_IDX = @UserIdx" +
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