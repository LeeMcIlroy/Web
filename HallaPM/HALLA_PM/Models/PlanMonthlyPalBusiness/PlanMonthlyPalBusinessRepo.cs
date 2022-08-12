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
    public class PlanMonthlyPalBusinessRepo : DbCon, IPlanMonthlyPalBusinessRepo
    {
        public int count(object param)
        {
            throw new NotImplementedException();
        }

        public int count(object param, string where)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " SELECT COUNT(*) FROM PLAN_MONTHLY_PAL_BUSINESS " + where;
                    return con.Query<int>(query, param).First();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return -1;
                }
            }
        }

        public IEnumerable<PlanMonthlyPalBusiness> selectList(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string where = " WHERE 1 = 1 ";

                    string query = " SELECT	A.*, B.BUSINESS_NAME " +
                        " FROM PLAN_MONTHLY_PAL_BUSINESS 	A " +
                        "LEFT OUTER JOIN ORG_BUSINESS        B ON A.ORG_BUSINESS_SEQ = B.SEQ WHERE PLAN_MONTHLY_PAL_SEQ = @PlanMonthlyPalSeq";                   

                    return con.Query<PlanMonthlyPalBusiness>(query, param).ToList();

                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }
        public IEnumerable<PlanMonthlyPalBusiness> selectListWithBofore(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string where = " WHERE 1 = 1 ";

                    string query = @" 
SELECT	A.ORG_BUSINESS_SEQ
		, A.MONTHLY
		, ISNULL(D.SALES, 0) AS BEFORE_SALES
		, ISNULL(D.EBIT, 0) AS BEFORE_EBIT
		, CONVERT(DECIMAL(12, 2), ROUND(CASE WHEN ISNULL(D.SALES, 0) = 0 THEN 0 ELSE (D.EBIT / ISNULL(D.SALES, 0)) * 100 END, 2)) AS BEFORE_EBIT_RATE
		, ISNULL(D.PBT, 0) AS BEFORE_PBT
		, A.SALES
		, A.EBIT
		, CONVERT(DECIMAL(12, 2), ROUND(CASE WHEN ISNULL(A.SALES, 0) = 0 THEN 0 ELSE (A.EBIT / A.SALES) * 100 END, 2)) AS EBIT_RATE
		, A.PBT
		, A.SEQ AS PLAN_MONTHLY_PAL_BUSINESS_SEQ
		, B.MONTHLY_PAL_YEAR
		, C.MONTHLY_PAL_YEAR AS BEFORE_MONTHLY_PAL_YEAR
FROM	PLAN_MONTHLY_PAL_BUSINESS	A
LEFT OUTER JOIN PLAN_MONTHLY_PAL	B ON A.PLAN_MONTHLY_PAL_SEQ = B.SEQ
LEFT OUTER JOIN PLAN_MONTHLY_PAL	C ON B.ORG_COMPANY_SEQ = C.ORG_COMPANY_SEQ AND CONVERT(VARCHAR, B.MONTHLY_PAL_YEAR - 1) = C.MONTHLY_PAL_YEAR
LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS D ON C.SEQ = D.PLAN_MONTHLY_PAL_SEQ AND A.ORG_BUSINESS_SEQ = D.ORG_BUSINESS_SEQ AND A.MONTHLY = D.MONTHLY
WHERE	A.PLAN_MONTHLY_PAL_SEQ = @PlanMonthlyPalSeq

UNION 

SELECT	A.ORG_BUSINESS_SEQ
		, '99' AS MONTHLY
		, SUM(ISNULL(D.SALES, 0)) AS BEFORE_SALES
		, SUM(ISNULL(D.EBIT, 0)) AS BEFORE_EBIT
		, CONVERT(DECIMAL(12, 2), ROUND(CASE WHEN SUM(ISNULL(D.SALES, 0)) = 0 THEN 0 ELSE (SUM((D.EBIT)) / SUM(ISNULL(D.SALES, 0))) * 100 END, 2)) AS BEFORE_EBIT_RATE
		, SUM(ISNULL(D.PBT, 0)) AS BEFORE_PBT
		, SUM(A.SALES) AS SALES
		, SUM(A.EBIT) AS EBIT
		, CONVERT(DECIMAL(12, 2), ROUND(CASE WHEN SUM(ISNULL(A.SALES, 0)) = 0 THEN 0 ELSE (SUM(A.EBIT) / SUM(A.SALES)) * 100 END, 2)) AS EBIT_RATE
		, SUM(A.PBT) AS PBT
		, 0 AS PLAN_MONTHLY_PAL_BUSINESS_SEQ
		, '9999' AS MONTHLY_PAL_YEAR
		, '9999' AS BEFORE_MONTHLY_PAL_YEAR
FROM	PLAN_MONTHLY_PAL_BUSINESS	A
LEFT OUTER JOIN PLAN_MONTHLY_PAL	B ON A.PLAN_MONTHLY_PAL_SEQ = B.SEQ
LEFT OUTER JOIN PLAN_MONTHLY_PAL	C ON B.ORG_COMPANY_SEQ = C.ORG_COMPANY_SEQ AND CONVERT(VARCHAR, B.MONTHLY_PAL_YEAR - 1) = C.MONTHLY_PAL_YEAR
LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS D ON C.SEQ = D.PLAN_MONTHLY_PAL_SEQ AND A.ORG_BUSINESS_SEQ = D.ORG_BUSINESS_SEQ AND A.MONTHLY = D.MONTHLY
WHERE	A.PLAN_MONTHLY_PAL_SEQ = @PlanMonthlyPalSeq
GROUP BY A.ORG_BUSINESS_SEQ
                        ";
                        
                    return con.Query<PlanMonthlyPalBusiness>(query, param).ToList();

                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<PlanMonthlyPalBusiness> selectListExcel(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string where = " WHERE 1 = 1 ";

                    string query = @" 
SELECT	A.PLAN_MONTHLY_PAL_SEQ
		, A.SEQ
		, A.ORG_BUSINESS_SEQ
		, B.BUSINESS_NAME
		, C.COMPANY_NAME
		, A.MONTHLY
		, A.SALES
		, A.EBIT
		, A.PBT
FROM	PLAN_MONTHLY_PAL_BUSINESS	A
LEFT OUTER JOIN ORG_BUSINESS		B ON A.ORG_BUSINESS_SEQ = B.SEQ
LEFT OUTER JOIN ORG_COMPANY			C ON B.ORG_COMPANY_SEQ = C.SEQ
WHERE	A.PLAN_MONTHLY_PAL_SEQ = @PlanMonthlyPalSeq
                        ";

                    return con.Query<PlanMonthlyPalBusiness>(query, param).ToList();

                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public PlanMonthlyPalBusiness selectOne(object param)
        {
            throw new NotImplementedException();
        }

        public int insert(PlanMonthlyPalBusiness entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " INSERT INTO  PLAN_MONTHLY_PAL_BUSINESS ( " +
                        " PLAN_MONTHLY_PAL_SEQ " +
                        ", ORG_BUSINESS_SEQ " +
                        ", MONTHLY " +
                        ", SALES " +
                        ", EBIT " +
                        ", EBIT_RATE " +
                        ", PBT " +
                        " ) VALUES ( " +
                        " @PlanMonthlyPalSeq " +
                        ", @OrgBusinessSeq " +
                        ", @Monthly " +
                        ", @Sales " +
                        ", @Ebit " +
                        ", @EbitRate " +
                        ", @Pbt " +
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


        public int update(PlanMonthlyPalBusiness entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = " UPDATE PLAN_MONTHLY_PAL_BUSINESS SET " +
                        " SALES = @Sales " +
                        " , EBIT = @Ebit " +
                        " , PBT = @Pbt " +
                        " WHERE SEQ = @Seq " +
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

        public int delete(object key)
        {
            throw new NotImplementedException();
        }

        public int save(PlanMonthlyPalBusiness entity)
        {
            throw new NotImplementedException();
        }

        public void Dispose()
        {
            throw new NotImplementedException();
        }

        public IEnumerable<PlanMonthlyPalBusinessExp> selectListPnThisYear(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
SELECT	*
FROM	(
-- 월별손익 : Bu
SELECT	A.MONTHLY_PAL_YEAR
		, B.MONTHLY
		, ISNULL(B.SALES, 0)				AS SALES
		, ISNULL(B.EBIT, 0)					AS EBIT
		, ISNULL(B.PBT, 0)					AS PBT
		, C.ORG_UNION_SEQ
		, E.UNION_NAME
		, A.ORG_COMPANY_SEQ
		, C.COMPANY_NAME
		, B.ORG_BUSINESS_SEQ
		, D.BUSINESS_NAME
FROM	PLAN_MONTHLY_PAL						A
LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS		B ON A.SEQ = B.PLAN_MONTHLY_PAL_SEQ
LEFT OUTER JOIN ORG_COMPANY					C ON A.ORG_COMPANY_SEQ = C.SEQ
LEFT OUTER JOIN ORG_BUSINESS				D ON B.ORG_BUSINESS_SEQ = D.SEQ
LEFT OUTER JOIN ORG_UNION					E ON C.ORG_UNION_SEQ = E.SEQ
WHERE	1 = 1
AND		A.MONTHLY_PAL_YEAR = @year
AND     A.REGIST_STATUS = " + Define.REGIST_STATUS.GetKey("최종승인") + @"
UNION
-- 월별손익합계
SELECT	A.MONTHLY_PAL_YEAR
		, '99'								AS MONTHLY
		, SUM(ISNULL(B.SALES, 0))			AS SALES
		, SUM(ISNULL(B.EBIT, 0))			AS EBIT
		, SUM(ISNULL(B.PBT, 0))				AS PBT
		, C.ORG_UNION_SEQ
		, E.UNION_NAME
		, A.ORG_COMPANY_SEQ
		, C.COMPANY_NAME
		, B.ORG_BUSINESS_SEQ
		, D.BUSINESS_NAME
FROM	PLAN_MONTHLY_PAL						A
LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS		B ON A.SEQ = B.PLAN_MONTHLY_PAL_SEQ
LEFT OUTER JOIN ORG_COMPANY					C ON A.ORG_COMPANY_SEQ = C.SEQ
LEFT OUTER JOIN ORG_BUSINESS				D ON B.ORG_BUSINESS_SEQ = D.SEQ
LEFT OUTER JOIN ORG_UNION					E ON C.ORG_UNION_SEQ = E.SEQ
WHERE	1 = 1
AND		A.MONTHLY_PAL_YEAR = @year
AND     A.REGIST_STATUS = " + Define.REGIST_STATUS.GetKey("최종승인") + @"
GROUP BY A.MONTHLY_PAL_YEAR
		, C.ORG_UNION_SEQ
		, E.UNION_NAME
		, A.ORG_COMPANY_SEQ
		, C.COMPANY_NAME
		, B.ORG_BUSINESS_SEQ
		, D.BUSINESS_NAME
)			A
ORDER BY A.ORG_UNION_SEQ, A.ORG_COMPANY_SEQ, A.ORG_BUSINESS_SEQ, A.MONTHLY_PAL_YEAR, A.MONTHLY ";

                    return con.Query<PlanMonthlyPalBusinessExp>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }
    }
}