using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Data;
using Dapper;
using HALLA_PM.Util;

namespace HALLA_PM.Models
{
    public class AdminOrgAuthRepo : DbCon, IAdminOrgAuthRepo
    {
        public int count(object param)
        {
            return -1;
        }

        public IEnumerable<AdminOrgAuth> selectList(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string where = " WHERE 1 = 1 ";
                    where += " AND AUTH_USER_KEY = @AuthUserKey ";

                    string query = " SELECT	* " +
                        " FROM    ADMIN_ORG_AUTH " +
                        "  " + where;

                    return con.Query<AdminOrgAuth>(query, param).ToList();

                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public AdminOrgAuth selectOne(object param)
        {
            return null;
        }

        // 주한라 권한 체크
        public int countOrg(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = @"
SELECT  COUNT(*)
FROM    ADMIN_ORG_AUTH
WHERE   1 = 1
AND ORG_COMPANY_SEQ = 6
AND AUTH_USER_KEY = @AuthUserKey ";
                    return con.Query<int>(query, param).First();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return -1;
                }
            }

        }

        public int insert(AdminOrgAuth entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = " INSERT INTO ADMIN_ORG_AUTH ( " +
                        " AUTH_USER_KEY " +
                        " , ORG_COMPANY_SEQ " +
                        " ) VALUES ( " +
                        " @AuthUserKey " +
                        " , @OrgCompanySeq " +
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

        public int update(AdminOrgAuth entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = " UPDATE ADMIN_ORG_AUTH SET " +
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

                    string query = " DELETE ADMIN_ORG_AUTH " +
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

        public int save(AdminOrgAuth entity)
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