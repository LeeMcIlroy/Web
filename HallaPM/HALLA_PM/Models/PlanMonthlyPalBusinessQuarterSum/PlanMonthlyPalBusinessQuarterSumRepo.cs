using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Data;
using Dapper;
using HALLA_PM.Util;

namespace HALLA_PM.Models
{
    public class PlanMonthlyPalBusinessQuarterSumRepo : DbCon, IPlanMonthlyPalBusinessQuarterSumRepo
    {
        public int count(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " SELECT COUNT(*) FROM PLAN_MONTHLY_PAL_BUSINESS_QUARTER_SUM 	A " +
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

        public IEnumerable<PlanMonthlyPalBusinessQuarterSum> selectList(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = " SELECT	A.* " +
                        " FROM PLAN_MONTHLY_PAL_BUSINESS_QUARTER_SUM 	A " +
                        " WHERE A.PLAN_MONTHLY_PAL_SEQ = @PlanMonthlyPalSeq";

                    return con.Query<PlanMonthlyPalBusinessQuarterSum>(query, param).ToList();

                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<PlanMonthlyPalBusinessQuarterSum> selectListWithBofore(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string where = " WHERE 1 = 1 ";

                    string query = @" 
SELECT	A.PLAN_MONTHLY_PAL_SEQ
		, A.BUSINESS_QUARTER
		, ISNULL(D.SALES, 0) AS BEFORE_SALES
		, ISNULL(D.EBIT, 0) AS BEFORE_EBIT
		, CONVERT(DECIMAL(12, 2), ROUND(CASE WHEN ISNULL(D.EBIT, 0) = 0 THEN 0 ELSE (D.EBIT / ISNULL(D.SALES, 0)) * 100 END, 2)) AS BEFORE_EBIT_RATE
		, ISNULL(D.PBT, 0) AS BEFORE_PBT
		, A.SALES
		, A.EBIT
		, CONVERT(DECIMAL(12, 2), ROUND(CASE WHEN ISNULL(A.EBIT, 0) = 0 THEN 0 ELSE (A.EBIT / A.SALES) * 100 END, 2)) AS EBIT_RATE
		, A.PBT
		, A.SEQ AS PLAN_MONTHLY_PAL_BUSINESS_QUARTER_SUM_SEQ
FROM	PLAN_MONTHLY_PAL_BUSINESS_QUARTER_SUM			A
LEFT OUTER JOIN PLAN_MONTHLY_PAL						B ON A.PLAN_MONTHLY_PAL_SEQ = B.SEQ
LEFT OUTER JOIN PLAN_MONTHLY_PAL						C ON B.ORG_COMPANY_SEQ = C.ORG_COMPANY_SEQ AND CONVERT(VARCHAR, B.MONTHLY_PAL_YEAR - 1) = C.MONTHLY_PAL_YEAR
LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS_QUARTER_SUM	D ON C.SEQ = D.PLAN_MONTHLY_PAL_SEQ AND A.BUSINESS_QUARTER = D.BUSINESS_QUARTER
WHERE	A.PLAN_MONTHLY_PAL_SEQ = @PlanMonthlyPalSeq
                        ;";

                    return con.Query<PlanMonthlyPalBusinessQuarterSum>(query, param).ToList();

                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public PlanMonthlyPalBusinessQuarterSum selectOne(object param)
        {
            throw new NotImplementedException();
        }

        public int insert(PlanMonthlyPalBusinessQuarterSum entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " INSERT INTO  PLAN_MONTHLY_PAL_BUSINESS_QUARTER_SUM ( " +
                        " PLAN_MONTHLY_PAL_SEQ " +
                        ", BUSINESS_QUARTER " +
                        ", SALES " +
                        ", EBIT " +
                        //", EBIT_RATE " +
                        ", PBT ) " +
                    @" SELECT	PLAN_MONTHLY_PAL_SEQ
        , Q
        , SUM(SALES)AS SALES
        , SUM(EBIT) AS EBIT
        , SUM(PBT) AS PBT
FROM(
SELECT  PLAN_MONTHLY_PAL_SEQ
        , CASE WHEN MONTHLY IN('01', '02', '03') THEN 1

            WHEN MONTHLY IN('04', '05', '06') THEN 2

            WHEN MONTHLY IN('07', '08', '09') THEN 3

            WHEN MONTHLY IN('10', '11', '12') THEN 4 END AS Q
        , SALES
        , EBIT
        , PBT
FROM    PLAN_MONTHLY_PAL_BUSINESS
WHERE   PLAN_MONTHLY_PAL_SEQ = @PlanMonthlyPalSeq
)   A
GROUP BY PLAN_MONTHLY_PAL_SEQ, Q

UNION

SELECT	PLAN_MONTHLY_PAL_SEQ
		, '99' AS Q
		, SUM(SALES) AS SALES
		, SUM(EBIT) AS EBIT
		, SUM(PBT) AS PBT
FROM	PLAN_MONTHLY_PAL_BUSINESS
WHERE	PLAN_MONTHLY_PAL_SEQ = @PlanMonthlyPalSeq
GROUP BY PLAN_MONTHLY_PAL_SEQ
;  " + 
"SELECT @@ROWCOUNT";
                    return con.Query<int>(query, entity).First();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return -1;
                }
            }
        }

        public int update(PlanMonthlyPalBusinessQuarterSum entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " UPDATE PLAN_MONTHLY_PAL_BUSINESS_QUARTER_SUM SET " +
                        //" , PLAN_MONTHLY_PAL_SEQ = @PlanMonthlyPalSeq" +
                        //" , BUSINESS_QUARTER = @BusinessQuarter" +
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
                    string query = " DELETE PLAN_MONTHLY_PAL_BUSINESS_QUARTER_SUM " +
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

        public int save(PlanMonthlyPalBusinessQuarterSum entity)
        {
            throw new NotImplementedException();
        }

        public void Dispose()
        {
            throw new NotImplementedException();
        }
    }
}