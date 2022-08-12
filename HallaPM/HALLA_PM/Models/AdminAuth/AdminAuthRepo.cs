using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Data;
using Dapper;
using HALLA_PM.Util;
using HALLA_PM.Core;

namespace HALLA_PM.Models
{
    public class AdminAuthRepo : DbCon, IAdminAuthRepo
    {
        public int count(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " SELECT COUNT(*) FROM ADMIN_AUTH ";
                    return con.Query<int>(query, param).First();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return -1;
                }
            }
        }

        public IEnumerable<AdminAuth> selectList(object param)
        {
            Search search = (Search)param;
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string where = " WHERE 1 = 1 ";
                    

                    string query = " SELECT	ROW_NUMBER() OVER (ORDER BY AUTH_USER_KOR_NAME ASC) AS ROW_NUM, * , " +
                                   " CASE WHEN AUTH_LEVEL = '1' THEN '최종관리자' " +
                                   " WHEN AUTH_LEVEL = '2' THEN '중간관리자'  " +
                                   " WHEN AUTH_LEVEL = '3' THEN '중간관리자2' " +
                                   " ELSE '실적담당자' " +
                                   " END AS AUTH_NAME " +
                                   " FROM    ADMIN_AUTH " +
                                   "  " + where +
                                   " ORDER BY AUTH_USER_KOR_NAME DESC " +
                                   " --OFFSET @PageCount * (@PageIndex -1)  ROWS FETCH NEXT @PageCount ROW ONLY ";

                    search.TotalCount = count(search);
                    search.MakePaging();

                    return con.Query<AdminAuth>(query, param).ToList();

                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<AdminAuth> selectListCompany(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string where = " WHERE 1 = 1 ";

                    string query = @"
SELECT	A.AUTH_USER_KEY
		, A.AUTH_EMP_NO
		, A.AUTH_USER_KOR_NAME
		, C.COMPANY_NAME AS COMP_KOR_NAME
FROM	ADMIN_AUTH					A
LEFT OUTER JOIN ADMIN_ORG_AUTH		B ON A.AUTH_USER_KEY = B.AUTH_USER_KEY
LEFT OUTER JOIN ORG_COMPANY			C ON B.ORG_COMPANY_SEQ = C.SEQ
WHERE	1 = 1
AND		B.ORG_COMPANY_SEQ = @OrgCompanySeq 
AND		A.AUTH_LEVEL = @AuthLevel
AND		A.IS_USE = 'Y'
";
                    
                    return con.Query<AdminAuth>(query, param).ToList();

                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public AdminAuth selectOne(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = " SELECT * " +
                        " FROM ADMIN_AUTH " +
                        " WHERE AUTH_USER_KEY = @AuthUserKey ";

                    return con.Query<AdminAuth>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public AdminAuth selectOneForOrg(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
                                    SELECT	TOP 1 B.*
                                    FROM	ADMIN_ORG_AUTH					A
                                    INNER JOIN ADMIN_AUTH					B ON A.AUTH_USER_KEY = B.AUTH_USER_KEY
                                    WHERE	1 = 1
                                    AND		A.ORG_COMPANY_SEQ = @OrgSeq
                                    AND		B.AUTH_LEVEL = " + Define.AUTH_LEVEL.GetKey("중간 관리자2") + @"
                                    ";

                    return con.Query<AdminAuth>(query, param).First();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }
        
        public int insert(AdminAuth entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = " INSERT INTO ADMIN_AUTH ( " +
                        " AUTH_USER_KEY " +
                        " , AUTH_EMP_NO " +
                        " , AUTH_USER_KOR_NAME " +
                        " , AUTH_LEVEL " +
                        " , IS_USE " +
                        " , USER_KEY " +
                        " , EMP_NO " +
                        " , CREATE_DATE " +
                        " ) VALUES ( " +
                        " @AuthUserKey " +
                        " , @AuthEmpNo " +
                        " , @AuthUserKorName " +
                        " , @AuthLevel " +
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

        public int update(AdminAuth entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = " UPDATE ADMIN_AUTH SET " +
                        " AUTH_EMP_NO = @AuthEmpNo " +
                        " , AUTH_USER_KOR_NAME = @AuthUserKorName " +
                        " , AUTH_LEVEL = @AuthLevel " +
                        " , IS_USE = @IsUse " +
                        " , IS_DISCLOSURE = @IsDisclosure " +
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

                    string query = " DELETE ADMIN_AUTH " +
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

        public int save(AdminAuth entity)
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