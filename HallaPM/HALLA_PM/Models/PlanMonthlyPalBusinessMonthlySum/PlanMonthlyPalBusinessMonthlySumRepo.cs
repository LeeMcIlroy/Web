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
    public class PlanMonthlyPalBusinessMonthlySumRepo : DbCon, IPlanMonthlyPalBusinessMonthlySumRepo
    {
        public int count(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " SELECT COUNT(*) FROM PLAN_MONTHLY_PAL_BUSINESS_MONTHLY_SUM 	A " +
                        " WHERE A.PLAN_MONTHLY_PAL_SEQ = @PlanMonthlyPalSeq";
                    return con.Query<int>(query, param).First();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return -1;
                }
            }
        }

        public int count(object param, string where)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " SELECT COUNT(*) FROM PLAN_MONTHLY_PAL_BUSINESS_MONTHLY_SUM " + where;
                    return con.Query<int>(query, param).First();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return -1;
                }
            }
        }

        public IEnumerable<PlanMonthlyPalBusinessMonthlySum> selectList(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    
                    string query = " SELECT	A.* " +
                        " FROM PLAN_MONTHLY_PAL_BUSINESS_MONTHLY_SUM 	A " +
                        " WHERE A.PLAN_MONTHLY_PAL_SEQ = @PlanMonthlyPalSeq";

                    return con.Query<PlanMonthlyPalBusinessMonthlySum>(query, param).ToList();

                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<PlanMonthlyPalBusinessMonthlySum> selectListWithBofore(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string where = " WHERE 1 = 1 ";

                    string query = @" 
SELECT	A.PLAN_MONTHLY_PAL_SEQ
		, A.MONTHLY
		, ISNULL(D.SALES, 0) AS BEFORE_SALES
		, ISNULL(D.EBIT, 0) AS BEFORE_EBIT
		, CONVERT(DECIMAL(12, 2), ROUND(CASE WHEN ISNULL(D.EBIT, 0) = 0 THEN 0 ELSE (D.EBIT / ISNULL(D.SALES, 0)) * 100 END, 2)) AS BEFORE_EBIT_RATE
		, ISNULL(D.PBT, 0) AS BEFORE_PBT
		, A.SALES
		, A.EBIT
		, CONVERT(DECIMAL(12, 2), ROUND(CASE WHEN ISNULL(A.EBIT, 0) = 0 THEN 0 ELSE (A.EBIT / A.SALES) * 100 END, 2)) AS EBIT_RATE
		, A.PBT
        , A.SEQ AS PLAN_MONTHLY_PAL_BUSINESS_MONTHLY_SUM_SEQ
FROM	PLAN_MONTHLY_PAL_BUSINESS_MONTHLY_SUM			A
LEFT OUTER JOIN PLAN_MONTHLY_PAL						B ON A.PLAN_MONTHLY_PAL_SEQ = B.SEQ
LEFT OUTER JOIN PLAN_MONTHLY_PAL						C ON B.ORG_COMPANY_SEQ = C.ORG_COMPANY_SEQ AND CONVERT(VARCHAR, B.MONTHLY_PAL_YEAR - 1) = C.MONTHLY_PAL_YEAR
LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS_MONTHLY_SUM	D ON C.SEQ = D.PLAN_MONTHLY_PAL_SEQ AND A.MONTHLY = D.MONTHLY
WHERE	A.PLAN_MONTHLY_PAL_SEQ = @PlanMonthlyPalSeq
                        ;";

                    return con.Query<PlanMonthlyPalBusinessMonthlySum>(query, param).ToList();

                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public PlanMonthlyPalBusinessMonthlySum selectOne(object param)
        {
            throw new NotImplementedException();
        }

        public int insert(PlanMonthlyPalBusinessMonthlySum entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = @" INSERT INTO PLAN_MONTHLY_PAL_BUSINESS_MONTHLY_SUM
(PLAN_MONTHLY_PAL_SEQ, MONTHLY, SALES, EBIT, PBT)
SELECT PLAN_MONTHLY_PAL_SEQ
        , MONTHLY
        , SUM(SALES)AS SALES
        , SUM(EBIT) AS EBIT " +
        //"--, CONVERT(DECIMAL(12, 2), ROUND(CASE WHEN SUM(EBIT) = 0 THEN 0 ELSE(SUM((EBIT)) / SUM(SALES)) * 100 END, 2)) AS EBIT_RATE " +
        @"
        , SUM(PBT) AS PBT
FROM    PLAN_MONTHLY_PAL_BUSINESS
WHERE   PLAN_MONTHLY_PAL_SEQ = @PlanMonthlyPalSeq
GROUP BY PLAN_MONTHLY_PAL_SEQ, MONTHLY

UNION

SELECT	PLAN_MONTHLY_PAL_SEQ
		, '99' AS MONTHLY
		, SUM(SALES) AS SALES
		, SUM(EBIT) AS EBIT " +
        //"--, CONVERT(DECIMAL(12, 2), ROUND(CASE WHEN SUM(EBIT) = 0 THEN 0 ELSE (SUM((EBIT)) / SUM(SALES)) * 100 END, 2)) AS EBIT_RATE" +
        @", SUM(PBT) AS PBT
FROM	PLAN_MONTHLY_PAL_BUSINESS
WHERE	PLAN_MONTHLY_PAL_SEQ = @PlanMonthlyPalSeq
GROUP BY PLAN_MONTHLY_PAL_SEQ;
         SELECT @@ROWCOUNT";
                    return con.Query<int>(query, entity).First();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return -1;
                }
            }
        }

        public int update(PlanMonthlyPalBusinessMonthlySum entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " UPDATE PLAN_MONTHLY_PAL_BUSINESS_MONTHLY_SUM SET " +
                        //" , PLAN_MONTHLY_PAL_SEQ = @PlanMonthlyPalSeq" +
                        //" , MONTHLY = @Monthly" +
                        " SALES = @Sales" +
                        " , EBIT = @Ebit" +
                        //" , EBIT_RATE = @EbitRate" +
                        " , PBT = @Pbt" +
                        " WHERE SEQ = @Seq" +
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

        public int delete(object key)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " DELETE PLAN_MONTHLY_PAL_BUSINESS_MONTHLY_SUM " +
                        " WHERE PLAN_MONTHLY_PAL_SEQ = @PlanMonthlyPalSeq";
                    return con.Execute(query, key);
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return -1;
                }
            }
        }

        public int save(PlanMonthlyPalBusinessMonthlySum entity)
        {
            throw new NotImplementedException();
        }

        public void Dispose()
        {
            throw new NotImplementedException();
        }


        public IEnumerable<PlanMonthlyPalBusinessMonthlySum> selectListExp(object param)
        {

            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = "";
                    query += " SELECT MONTHLY, SALES, EBIT ";
                    query += " FROM PLAN_MONTHLY_PAL_BUSINESS_MONTHLY_SUM ";
                    query += " WHERE PLAN_MONTHLY_PAL_SEQ = @planMonthlyPalSeq ";
                    //query += "     AND MONTHLY != '99' ";
                    query += " ORDER BY MONTHLY ASC ";

                    return con.Query<PlanMonthlyPalBusinessMonthlySum>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<PlanMonthlyPalBusinessMonthlySumExp> selectListYear(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
SELECT	*
FROM	PLAN_MONTHLY_PAL				A
LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS_MONTHLY_SUM	B ON A.SEQ = B.PLAN_MONTHLY_PAL_SEQ
WHERE	A.MONTHLY_PAL_YEAR = @MonthlyPalYear
AND		A.ORG_COMPANY_SEQ = @OrgCompanySeq
";

                    return con.Query<PlanMonthlyPalBusinessMonthlySumExp>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<PlanMonthlyPalBusinessMonthlySumExp> selectListPnThisYear(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
SELECT	*
FROM	(
-- 월별손익 : 회사
SELECT	A.MONTHLY_PAL_YEAR
		, B.MONTHLY
		, ISNULL(B.SALES, 0)				AS SALES
		, ISNULL(B.EBIT, 0)					AS EBIT
		, ISNULL(B.PBT, 0)					AS PBT
		, C.ORG_UNION_SEQ
		, E.UNION_NAME
		, A.ORG_COMPANY_SEQ
		, C.COMPANY_NAME
        , C.ORD
FROM	PLAN_MONTHLY_PAL						A
LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS_MONTHLY_SUM		B ON A.SEQ = B.PLAN_MONTHLY_PAL_SEQ
LEFT OUTER JOIN ORG_COMPANY					C ON A.ORG_COMPANY_SEQ = C.SEQ
LEFT OUTER JOIN ORG_UNION					E ON C.ORG_UNION_SEQ = E.SEQ
WHERE	1 = 1
AND		A.MONTHLY_PAL_YEAR = @year
AND     A.REGIST_STATUS = " + Define.REGIST_STATUS.GetKey("최종승인") + @"
)			A
ORDER BY A.ORG_UNION_SEQ, A.ORD, A.MONTHLY_PAL_YEAR, A.MONTHLY ";

                    return con.Query<PlanMonthlyPalBusinessMonthlySumExp>(query, param).ToList();
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