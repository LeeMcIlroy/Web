using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Data;
using Dapper;
using HALLA_PM.Util;

namespace HALLA_PM.Models
{
    public class SystemOrgAuthRepo : DbCon, ISystemOrgAuthRepo
    {
        public int count(object param)
        {
            return -1;
        }

        public IEnumerable<SystemOrgAuth> selectList(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string where = " WHERE 1 = 1 ";
                    where += " AND AUTH_USER_KEY = @AuthUserKey ";

                    string query = " SELECT	* " +
                        " FROM    SYSTEM_ORG_AUTH " +
                        "  " + where;

                    return con.Query<SystemOrgAuth>(query, param).ToList();

                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<SystemOrgAuthExp> selectListExp(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string where = " WHERE 1 = 1 ";
                    where += " AND A.AUTH_USER_KEY = @AuthUserKey  ";

                    string query = @"
SELECT	A.*
		, B.ORG_UNION_SEQ
		, CASE WHEN A.ORG_COMPANY_SEQ = 0 THEN 0 ELSE B.SEQ END SEQ
		, CASE WHEN A.ORG_COMPANY_SEQ = 0 THEN '그룹전체' ELSE B.COMPANY_NAME END COMPANY_NAME
		, CASE WHEN A.ORG_COMPANY_SEQ = 0 THEN 'Y' ELSE B.IS_USE END IS_USE
        , B.IS_DISCLOSURE
FROM	SYSTEM_ORG_AUTH			A
LEFT OUTER JOIN ORG_COMPANY		B ON A.ORG_COMPANY_SEQ = B.SEQ
" + where + @" 
ORDER BY B.ORG_UNION_SEQ, B.ORD ";

                    return con.Query<SystemOrgAuthExp>(query, param).ToList();

                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }

        }

        public SystemOrgAuth selectOne(object param)
        {
            return null;
        }

        public int insert(SystemOrgAuth entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = " INSERT INTO SYSTEM_ORG_AUTH ( " +
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

        public int update(SystemOrgAuth entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = " UPDATE SYSTEM_ORG_AUTH SET " +
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

                    string query = " DELETE SYSTEM_ORG_AUTH " +
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

        public int save(SystemOrgAuth entity)
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