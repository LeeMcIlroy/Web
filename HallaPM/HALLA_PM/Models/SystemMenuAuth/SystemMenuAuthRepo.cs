using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Data;
using Dapper;
using HALLA_PM.Util;

namespace HALLA_PM.Models
{
    public class SystemMenuAuthRepo : DbCon, ISystemMenuAuthRepo
    {
        public int count(object param)
        {
            return -1;
        }

        public IEnumerable<SystemMenuAuth> selectList(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string where = " WHERE 1 = 1 ";
                    where += " AND A.AUTH_USER_KEY = @AuthUserKey ";

                    string query = " SELECT	A.*, B.IS_USE " +
                        " FROM    SYSTEM_MENU_AUTH 		A " +
                        " INNER JOIN SYSTEM_AUTH B ON A.AUTH_USER_KEY = B.AUTH_USER_KEY" +
                        "  " + where;

                    return con.Query<SystemMenuAuth>(query, param).ToList();

                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public SystemMenuAuth selectOne(object param)
        {
            return null;
        }

        public int insert(SystemMenuAuth entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = " INSERT INTO SYSTEM_MENU_AUTH ( " +
                        " AUTH_USER_KEY " +
                        " , MENU_TYPE " +
                        " ) VALUES ( " +
                        " @AuthUserKey " +
                        " , @MenuType " +
                        " ); SELECT @@ROWCOUNT ";
                    return con.Query<int>(query, entity).First();

                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return -1;
                }
            }
        }

        public int update(SystemMenuAuth entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = " UPDATE SYSTEM_MENU_AUTH SET " +
                        " ORG_COMPANY_SEQ = @OrgCompanySeq " +
                        " WHERE AUTH_USER_KEY = @AuthUserKey " +
                        " SELECT @@ROWCOUNT ";
                    return con.Query<int>(query, entity).First();

                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return -1;
                }
            }
        }

        public int delete(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = " DELETE SYSTEM_MENU_AUTH " +
                        " WHERE AUTH_USER_KEY = @AuthUserKey ";
                    return con.Execute(query, param);

                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return -1;
                }
            }
        }

        public int save(SystemMenuAuth entity)
        {
            var item = selectOne(entity);

            if (item == null)
            {
                return insert(entity);
            }
            else
            {
                return update(entity);
            }
        }
        public void Dispose()
        {
            throw new NotImplementedException();
        }
    }
}