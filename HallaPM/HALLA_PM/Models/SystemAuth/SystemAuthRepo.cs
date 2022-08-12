using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Data;
using Dapper;
using HALLA_PM.Util;

namespace HALLA_PM.Models
{
    public class SystemAuthRepo : DbCon, ISystemAuthRepo
    {
        public int count(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " SELECT COUNT(*) FROM SYSTEM_AUTH ";
                    return con.Query<int>(query, param).First();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return -1;
                }
            }
        }

        public IEnumerable<SystemAuth> selectList(object param)
        {
            Search search = (Search)param;
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string where = " WHERE 1 = 1 ";

                    string query = " SELECT	ROW_NUMBER() OVER (ORDER BY CREATE_DATE ASC) AS ROW_NUM, * " +
                        " FROM    SYSTEM_AUTH " +
                        "  " + where +
                        " ORDER BY CREATE_DATE DESC " +
                        " --OFFSET @PageCount * (@PageIndex -1)  ROWS FETCH NEXT @PageCount ROW ONLY ";

                    search.TotalCount = count(search);
                    search.MakePaging();

                    return con.Query<SystemAuth>(query, param).ToList();

                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public SystemAuth selectOne(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = " SELECT * " +
                        " FROM SYSTEM_AUTH " +
                        " WHERE AUTH_USER_KEY = @AuthUserKey ";

                    return con.Query<SystemAuth>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public int insert(SystemAuth entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = " INSERT INTO SYSTEM_AUTH ( " +
                        " AUTH_USER_KEY " +
                        " , AUTH_EMP_NO " +
                        " , AUTH_USER_KOR_NAME " +
                        //" , IS_DISCLOSURE " +
                        " , IS_USE " +
                        " , USER_KEY " +
                        " , EMP_NO " +
                        " , CREATE_DATE " +
                        " ) VALUES ( " +
                        " @AuthUserKey " +
                        " , @AuthEmpNo " +
                        " , @AuthUserKorName " +
                        //" , @IsDisclosure " +
                        " , @IsUse " +
                        " , @UserKey " +
                        " , @EmpNo " +
                        " , GETDATE() " +
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

        public int update(SystemAuth entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = " UPDATE SYSTEM_AUTH SET " +
                        " AUTH_EMP_NO = @AuthEmpNo " +
                        " , AUTH_USER_KOR_NAME = @AuthUserKorName " +                      
                        " , IS_USE = @IsUse " +
                        " , USER_KEY = @UserKey " +
                        " , EMP_NO = @EmpNo " +
                        " , CREATE_DATE = GETDATE() " +
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

                    string query = " DELETE SYSTEM_AUTH " +
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

        public int save(SystemAuth entity)
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