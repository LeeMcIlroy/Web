using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Data;
using Dapper;
using HALLA_PM.Core;
using HALLA_PM.Util;

namespace HALLA_PM.Models
{
    public class PageAuthRepo : DbCon, IPageAuthRepo
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

        public int insert(LevelOne entity)
        {
            throw new NotImplementedException();
        }

        public int save(LevelOne entity)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<LevelOne> selectList(object param)
        {
            throw new NotImplementedException();
        }

        public LevelOne selectOne(object param)
        {
            throw new NotImplementedException();
        }

        public int update(LevelOne entity)
        {
            throw new NotImplementedException();
        }

        /// <summary>
        /// 그룹 권한을 체크한다.
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        public IEnumerable<LevelTwo> GetGroupAuth(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
SELECT	'0'						AS [ID]
		, 'Halla Group'			AS [TXT]
FROM	SYSTEM_ORG_AUTH
WHERE	1 = 1
AND		AUTH_USER_KEY = @AuthUserKey
AND		ORG_COMPANY_SEQ = '0'
";

                    return con.Query<LevelTwo>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.ReportErrorLog(e.ToString());
                    return null;
                }
            }
        }

        /// <summary>
        /// 부문 권한을 체크한다.
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        public IEnumerable<LevelTwo> GetUnionAuth(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
; WITH UNION_AUTH_LIST AS
(
SELECT	A.SEQ, A.UNION_NAME
		, COUNT(B.SEQ)				AS B_SEQ
		, COUNT(C.ORG_COMPANY_SEQ)	AS C_SEQ
		, CASE WHEN COUNT(B.SEQ) = COUNT(C.ORG_COMPANY_SEQ) THEN 'Y' ELSE 'N' END AS UNION_AUTH
FROM	ORG_UNION					A
LEFT OUTER JOIN ORG_COMPANY			B ON A.SEQ = B.ORG_UNION_SEQ
LEFT OUTER JOIN SYSTEM_ORG_AUTH		C ON B.SEQ = C.ORG_COMPANY_SEQ AND C.AUTH_USER_KEY = @AuthUserKey
WHERE	1 = 1
AND		A.IS_USE = 'Y'
AND		B.IS_USE = 'Y'
GROUP BY A.SEQ, A.UNION_NAME
)
SELECT	SEQ						AS [ID]
		, UNION_NAME			AS [TXT]
FROM	UNION_AUTH_LIST
WHERE	UNION_AUTH = 'Y'
";

                    return con.Query<LevelTwo>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.ReportErrorLog(e.ToString());
                    return null;
                }
            }
        }

        /// <summary>
        /// 회사가 포함된 부문을 모두 가져온다.
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        public IEnumerable<LevelTwo> GetUnionAuthLeft(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
SELECT	A.SEQ						AS [ID]
		, A.UNION_NAME				AS [TXT]
FROM	ORG_UNION					A
LEFT OUTER JOIN ORG_COMPANY			B ON A.SEQ = B.ORG_UNION_SEQ
INNER JOIN SYSTEM_ORG_AUTH		C ON B.SEQ = C.ORG_COMPANY_SEQ AND C.AUTH_USER_KEY = @AuthUserKey
WHERE	1 = 1
AND		A.IS_USE = 'Y'
AND		B.IS_USE = 'Y'
GROUP BY A.SEQ, A.UNION_NAME
";

                    return con.Query<LevelTwo>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.ReportErrorLog(e.ToString());
                    return null;
                }
            }
        }
        public IEnumerable<LevelTwo> GetCompanyAuth(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
SELECT	B.ORG_UNION_SEQ			AS [UP_ID]
		, B.SEQ					AS [ID]
		, B.COMPANY_NAME		AS [TXT]
FROM	SYSTEM_ORG_AUTH			C
INNER JOIN ORG_COMPANY			B ON B.SEQ = C.ORG_COMPANY_SEQ 
WHERE	1 = 1
AND     C.AUTH_USER_KEY = @AuthUserKey
AND		C.ORG_COMPANY_SEQ != 0
AND		B.IS_USE = 'Y'
ORDER BY B.ORG_UNION_SEQ, B.SEQ
";

                    return con.Query<LevelTwo>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.ReportErrorLog(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<LevelTwo> GetSystemAuth(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    // 2019.02.08 회사가 미사용이면 안 나오게 변경
                    // 2019.02.11 위에 변경하면서 그룹전체가 표기가 안되어서 따로 수정
                    string query = @"
SELECT	B.ORG_UNION_SEQ			AS [UP_ID]
		, C.ORG_COMPANY_SEQ		AS [ID]
		, B.COMPANY_NAME 		AS [TXT]
FROM	SYSTEM_ORG_AUTH			C
INNER JOIN ORG_COMPANY			B ON B.SEQ = C.ORG_COMPANY_SEQ AND B.IS_USE = 'Y'
WHERE	1 = 1
AND		C.AUTH_USER_KEY = @AuthUserKey
UNION 
SELECT	B.ORG_UNION_SEQ			AS [UP_ID]
		, C.ORG_COMPANY_SEQ		AS [ID]
		, CASE WHEN C.ORG_COMPANY_SEQ = 0 THEN '그룹전체' ELSE B.COMPANY_NAME END		AS [TXT]
FROM	SYSTEM_ORG_AUTH			C
LEFT OUTER JOIN ORG_COMPANY			B ON B.SEQ = C.ORG_COMPANY_SEQ 
WHERE	1 = 1
AND		C.AUTH_USER_KEY = @AuthUserKey

/*
SELECT	B.ORG_UNION_SEQ			AS [UP_ID]
		, C.ORG_COMPANY_SEQ		AS [ID]
		, CASE WHEN C.ORG_COMPANY_SEQ = 0 THEN '그룹전체' ELSE B.COMPANY_NAME END		AS [TXT]
FROM	SYSTEM_ORG_AUTH			C
INNER JOIN ORG_COMPANY			B ON B.SEQ = C.ORG_COMPANY_SEQ AND B.IS_USE = 'Y'
WHERE	1 = 1
AND     C.AUTH_USER_KEY = 
*/
";

                    return con.Query<LevelTwo>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.ReportErrorLog(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<LevelTwo> GetBusinessAuth(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
SELECT	B.SEQ					AS [UP_ID]
		, D.SEQ					AS [ID]
		, D.BUSINESS_NAME		AS [TXT]
FROM	SYSTEM_ORG_AUTH			C
INNER JOIN ORG_COMPANY			B ON B.SEQ = C.ORG_COMPANY_SEQ
INNER JOIN ORG_BUSINESS			D ON B.SEQ = D.ORG_COMPANY_SEQ AND D.IS_USE = 'Y'
WHERE	1 = 1
AND		C.AUTH_USER_KEY = @AuthUserKey
AND		C.ORG_COMPANY_SEQ != 0
AND		B.IS_USE = 'Y'
";

                    return con.Query<LevelTwo>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.ReportErrorLog(e.ToString());
                    return null;
                }
            }
        }
    }
}