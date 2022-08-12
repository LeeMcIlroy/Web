using Dapper;
using HALLA_PM.Core;
using HALLA_PM.Util;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class PmPalSummaryRepo : DbCon, IPmPalSummaryRepo
    {
        public int count(object param)
        {
            throw new NotImplementedException();
        }

        public int delete(object key)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " DELETE PM_PAL_SUMMARY " +
                        " WHERE PM_PAL_SEQ = @PmPalSeq";
                    return con.Execute(query, key);
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return -1;
                }
            }
        }

        public void Dispose()
        {
            throw new NotImplementedException();
        }

        public int insert(PmPalSummary entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = @"INSERT INTO PM_PAL_SUMMARY (PM_PAL_SEQ, MONTHLY_TYPE, SALES, EBIT, EBIT_RATE, PBT, NET_PROFIT_TERM)
                                    SELECT PM_PAL_SEQ
			                                ,MONTHLY_TYPE
			                                ,SUM(ISNULL(SALES, 0))							AS SALES
			                                ,SUM(ISNULL(EBIT, 0))							AS EBIT
			                                ,CASE WHEN SUM(ISNULL(SALES, 0)) = 0 THEN 0 
                                                WHEN SUM(ISNULL(EBIT, 0))  = 0 THEN 0
                                            ELSE SUM(ISNULL(EBIT, 0)) / SUM(ISNULL(SALES, 0)) END	AS EBIT_RATE
			                                ,SUM(ISNULL(PBT, 0))							AS PBT
			                                ,'0'											AS NET_PROFIT_TERM
                                    FROM PM_PAL A
                                    LEFT OUTER JOIN PM_PAL_BUSINESS B ON A.SEQ = B.PM_PAL_SEQ
                                    WHERE 1 = 1
                                    AND A.PAL_YEAR = @PalYear
                                    AND A.MONTHLY = @Monthly
                                    AND B.PM_PAL_SEQ = @PmPalSeq
                                    GROUP BY PM_PAL_SEQ, MONTHLY_TYPE
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

        public int insert2(PmPalSummary entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = @" DELETE FROM PM_PAL_SUMMARY WHERE PM_PAL_SEQ = @PmPalSeq AND MONTHLY_TYPE = @MonthlyType;
                                    INSERT INTO PM_PAL_SUMMARY (PM_PAL_SEQ, MONTHLY_TYPE, SALES, EBIT, EBIT_RATE, PBT, NET_PROFIT_TERM)
                                     VALUES(@PmPalSeq,@MonthlyType,@Sales,@Ebit,CASE WHEN @Sales = 0 THEN 0 
                                                WHEN ISNULL(@Ebit, 0)  = 0 THEN 0
                                            ELSE ISNULL(@Ebit, 0) / ISNULL(@Sales, 0) END,@Pbt,@NetProfitTerm);
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
        public IEnumerable<PmPalSummary> selectListSummaryYear(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    // 전년도 연간 : 전년도 12월의 누계실적
                    // 전년도 당월 : 전년도 해당월의 실적
                    // 전년도 누계 : 전년도 해당월의 누계실적
                    string query = @" --연간
                                       SELECT '1'												 AS KIND
                                             ,A.PAL_YEAR										 AS PAL_YEAR
	                                         ,'9999'											 AS MONTHLY
	                                         ,SUM(ISNULL(B.SALES, 0))							 AS SALES
	                                         ,SUM(ISNULL(B.EBIT, 0))							 AS EBIT
	                                         ,ISNULL(ROUND(SUM(B.EBIT_RATE) / COUNT(*), 0), 0)	 AS EBIT_RATE
                                             ,SUM(ISNULL(B.PBT, 0))                                   AS PBT
	                                         ,A.ORG_COMPANY_SEQ
                                       FROM PM_PAL A
                                       LEFT OUTER JOIN PM_PAL_SUMMARY B ON A.SEQ = B.PM_PAL_SEQ
                                       WHERE 1 = 1
                                       --AND B.PM_PAL_SEQ = @Seq
                                        AND A.ORG_COMPANY_SEQ = @Seq
                                       AND B.MONTHLY_TYPE = " + Define.MONTHLY_TYPE.GetKey("누계") + @"
                                       AND A.PAL_YEAR = @YearlyYear - 1
                                       AND A.MONTHLY = '12'
                                       GROUP BY PAL_YEAR, A.ORG_COMPANY_SEQ
                                       UNION
                                       --당월
                                       SELECT '2'						 AS KIND
                                             ,A.PAL_YEAR				 AS PAL_YEAR
	                                         ,MONTHLY					 AS MONTHLY
	                                         ,ISNULL(B.SALES, 0)		 AS SALES
	                                         ,ISNULL(B.EBIT, 0)			 AS EBIT
	                                         ,ISNULL(B.EBIT_RATE, 0)	 AS EBIT_RATE
                                             ,ISNULL(B.PBT, 0)                                   AS PBT
	                                         ,A.ORG_COMPANY_SEQ
                                       FROM PM_PAL A
                                       LEFT OUTER JOIN PM_PAL_SUMMARY B ON A.SEQ = B.PM_PAL_SEQ
                                       WHERE 1 = 1
                                       --AND B.PM_PAL_SEQ = @Seq
                                        AND A.ORG_COMPANY_SEQ = @Seq
                                       AND B.MONTHLY_TYPE = " + Define.MONTHLY_TYPE.GetKey("당월") + @"
                                       AND A.PAL_YEAR = @YearlyYear - 1
                                       AND A.MONTHLY = @Monthly
                                       UNION
                                       --누계
                                       SELECT '3'						 AS KIND
                                             ,A.PAL_YEAR				 AS PAL_YEAR
	                                         ,MONTHLY					 AS MONTHLY
	                                         ,ISNULL(B.SALES, 0)		 AS SALES
	                                         ,ISNULL(B.EBIT, 0)			 AS EBIT
	                                         ,ISNULL(B.EBIT_RATE, 0)	 AS EBIT_RATE
                                             ,ISNULL(B.PBT, 0)                                   AS PBT
	                                         ,A.ORG_COMPANY_SEQ
                                       FROM PM_PAL A
                                       LEFT OUTER JOIN PM_PAL_SUMMARY B ON A.SEQ = B.PM_PAL_SEQ
                                       WHERE 1 = 1
                                       --AND B.PM_PAL_SEQ = @Seq
                                        AND A.ORG_COMPANY_SEQ = @Seq
                                       AND B.MONTHLY_TYPE = " + Define.MONTHLY_TYPE.GetKey("누계") + @"
                                       AND A.PAL_YEAR = @YearlyYear - 1
                                       AND A.MONTHLY = @Monthly";

                    return con.Query<PmPalSummary>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<PmPalSummary> selectListPlanSummaryThisYear(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" SELECT A.MONTHLY_PAL_YEAR
                                            ,B.MONTHLY 
                                            ,B.SALES
                                            ,B.EBIT
                                            ,ISNULL(B.EBIT_RATE, 0) AS EBIT_RATE
                                            ,B.PBT
                                            ,A.ORG_COMPANY_SEQ
                                            ,B.SEQ AS 'PLAN_MONTHLY_PAL_SEQ'
                                        FROM PLAN_MONTHLY_PAL A
                                        LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS_MONTHLY_SUM B ON A.SEQ = B.PLAN_MONTHLY_PAL_SEQ
                                        WHERE 1 = 1
                                        AND A.ORG_COMPANY_SEQ = @Seq
                                        AND A.MONTHLY_PAL_YEAR = @YearlyYear
                                        AND B.MONTHLY = @Monthly";

                    return con.Query<PmPalSummary>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<PmPalSummary> selectListPmPalSummaryThisYear(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" SELECT SALES
				                            ,EBIT
				                            ,EBIT_RATE
				                            ,PBT
                                            ,B.SEQ AS PM_PAL_SUMMARY_SEQ
                                            ,B.LIABILITIES_RATE_COMMENT
                                            ,NET_PROFIT_TERM
                                        FROM PM_PAL A
		                                LEFT OUTER JOIN PM_PAL_SUMMARY B ON A.SEQ = B.PM_PAL_SEQ
		                                WHERE 1 = 1
		                                AND B.PM_PAL_SEQ = @Seq
		                                AND B.MONTHLY_TYPE = @MonthlyType
		                                AND A.PAL_YEAR = @YearlyYear
		                                AND A.MONTHLY = @Monthly";

                    return con.Query<PmPalSummary>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<PmPalSummary> selectListResultMonthlySummaryThisYear(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" SELECT SALES
				                            ,EBIT
				                            ,EBIT_RATE
				                            ,PBT
                                        FROM PM_PAL A
		                                LEFT OUTER JOIN PM_PAL_SUMMARY B ON A.SEQ = B.PM_PAL_SEQ
		                                WHERE 1 = 1
		                                AND B.PM_PAL_SEQ = @Seq
		                                AND B.MONTHLY_TYPE = @MonthlyType
		                                AND A.PAL_YEAR = @YearlyYear
		                                AND A.MONTHLY = @Monthly";

                    return con.Query<PmPalSummary>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<PmPalSummary> selectListSumSummaryThisYear(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" SELECT A.MONTHLY_PAL_YEAR
					                        ,SUM(B.SALES)			AS SALES
					                        ,SUM(B.EBIT)			AS EBIT
					                        ,CASE WHEN SUM(ISNULL(SALES, 0)) = 0 THEN 0 
						                          WHEN SUM(ISNULL(EBIT, 0))  = 0 THEN 0
					                         ELSE SUM(ISNULL(EBIT, 0)) / SUM(ISNULL(SALES, 0)) END	AS EBIT_RATE
					                        ,SUM(B.PBT)				AS PBT
					                        ,A.ORG_COMPANY_SEQ
                                    FROM PLAN_MONTHLY_PAL A
                                    LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS_MONTHLY_SUM B ON A.SEQ = B.PLAN_MONTHLY_PAL_SEQ
                                    WHERE 1 = 1
                                    AND A.ORG_COMPANY_SEQ = @Seq
                                    AND A.MONTHLY_PAL_YEAR = @YearlyYear
                                    AND B.MONTHLY <= @Monthly
                                    GROUP BY A.MONTHLY_PAL_YEAR, A.ORG_COMPANY_SEQ";

                    return con.Query<PmPalSummary>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<PmPalSummary> selectListExpectSummaryThisYear(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" SELECT A.MONTHLY_PAL_YEAR
					                        ,SUM(B.SALES)			AS SALES
					                        ,SUM(B.EBIT)			AS EBIT
					                        ,CASE WHEN SUM(ISNULL(SALES, 0)) = 0 THEN 0 
						                          WHEN SUM(ISNULL(EBIT, 0))  = 0 THEN 0
					                         ELSE SUM(ISNULL(EBIT, 0)) / SUM(ISNULL(SALES, 0)) END	AS EBIT_RATE
					                        ,SUM(B.PBT)				AS PBT
					                        ,A.ORG_COMPANY_SEQ
                                    FROM PLAN_MONTHLY_PAL A
                                    LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS_MONTHLY_SUM B ON A.SEQ = B.PLAN_MONTHLY_PAL_SEQ
                                    WHERE 1 = 1
                                    AND A.ORG_COMPANY_SEQ = @Seq
                                    AND A.MONTHLY_PAL_YEAR = @YearlyYear
                                    AND B.MONTHLY <= @Monthly
                                    GROUP BY A.MONTHLY_PAL_YEAR, A.ORG_COMPANY_SEQ";

                    return con.Query<PmPalSummary>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<PmPalSummary> selectListExpectThisYear(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    // 2018.12.17 월별값이 합계가 아니라
                    // 합계되어진 값을 가져오게 변경
                    string query = @" SELECT A.MONTHLY_PAL_YEAR
					                        ,SUM(B.SALES)			AS SALES
					                        ,SUM(B.EBIT)			AS EBIT
					                        ,CASE WHEN SUM(ISNULL(SALES, 0)) = 0 THEN 0 
						                          WHEN SUM(ISNULL(EBIT, 0))  = 0 THEN 0
					                         ELSE SUM(ISNULL(EBIT, 0)) / SUM(ISNULL(SALES, 0)) END	AS EBIT_RATE
					                        ,SUM(B.PBT)				AS PBT
					                        ,A.ORG_COMPANY_SEQ
                                    FROM PLAN_MONTHLY_PAL A
                                    LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS_MONTHLY_SUM B ON A.SEQ = B.PLAN_MONTHLY_PAL_SEQ
                                    WHERE 1 = 1
                                    AND A.ORG_COMPANY_SEQ = @Seq
                                    AND A.MONTHLY_PAL_YEAR = @YearlyYear
                                    --AND B.MONTHLY <= '12'
                                    AND B.MONTHLY = '99'
                                    GROUP BY A.MONTHLY_PAL_YEAR, A.ORG_COMPANY_SEQ";

                    return con.Query<PmPalSummary>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public int save(PmPalSummary entity)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<PmPalSummary> selectList(object param)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<PmPalSummary> selectListExcel(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = @" 
                            SELECT	B.PAL_YEAR
                                    ,B.MONTHLY
                                    ,A.*
                            FROM	PM_PAL_SUMMARY A 
                                INNER JOIN PM_PAL B ON A.PM_PAL_SEQ   = B.SEQ                         
                            WHERE	A.PM_PAL_SEQ = @PmPalSeq
                            ORDER BY Monthly_Type
                        ";

                    return con.Query<PmPalSummary>(query, param).ToList();

                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public PmPalSummary selectOne(object param)
        {
            throw new NotImplementedException();
        }

        public int update(PmPalSummary entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = @" UPDATE PM_PAL_SUMMARY SET
                                      SALES = @Sales
                                     ,EBIT = @Ebit
                                     ,PBT = @Pbt
                                     ,NET_PROFIT_TERM = @NetProfitTerm
                                     ,LIABILITIES_RATE_COMMENT = @LiabilitiesRateComment
                                     WHERE SEQ = @Seq
                                    ; SELECT @@ROWCOUNT ";
                    return con.Query<int>(query, entity).First();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return -1;
                }
            }
        }

        public IEnumerable<PmPalSummaryExp> selectListYear(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
SELECT	*
FROM	PM_PAL				A
LEFT OUTER JOIN PM_PAL_SUMMARY		B ON A.SEQ = B.PM_PAL_SEQ
WHERE	A.PAL_YEAR = @PalYear
AND		A.MONTHLY = @Monthly
AND		A.ORG_COMPANY_SEQ = @OrgCompanySeq
";

                    return con.Query<PmPalSummaryExp>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public PmPalBusinessSummaryForPlan selectSummaryOne(object param, int palYear)
        {

            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = "";
                    query += " SELECT A.ORG_COMPANY_SEQ, SUM(B.SALES) AS SALES, SUM(B.EBIT) AS EBIT, SUM(B.EBIT_RATE) AS RATE, '"+ palYear +"' AS YEARLY_YEAR";
                    query += " FROM PM_PAL A ";
                    query += "     , PM_PAL_SUMMARY B ";
                    query += " WHERE A.SEQ = B.PM_PAL_SEQ ";
                    query += "     AND A.REGIST_STATUS = " + Define.REGIST_STATUS.GetKey("최종승인");
                    query += "     AND A.PAL_YEAR = @palYear ";
                    query += "     AND A.MONTHLY = '12' ";
                    query += "     AND A.ORG_COMPANY_SEQ = @orgCompanySeq ";
                    query += "     AND B.MONTHLY_TYPE = " + Define.MONTHLY_TYPE.GetKey("누계"); 
                    query += " GROUP BY ORG_COMPANY_SEQ ";

                    return con.Query<PmPalBusinessSummaryForPlan>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }
        /// <summary>
        /// 당해년도실적 회사
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        public IEnumerable<PmPalSummaryExp> selectListPmThisYear(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
-- 당해년도 실적
SELECT	A.PAL_YEAR
		, A.MONTHLY
		, B.MONTHLY_TYPE
		, ISNULL(B.SALES, 0)				AS SALES
		, ISNULL(B.EBIT, 0)					AS EBIT
		, ISNULL(B.PBT, 0)					AS PBT
		, C.ORG_UNION_SEQ
		, E.UNION_NAME
		, A.ORG_COMPANY_SEQ
		, C.COMPANY_NAME
		, A.LIABILITIES_RATE_COMMENT
FROM	PM_PAL								A
LEFT OUTER JOIN PM_PAL_SUMMARY				B ON A.SEQ = B.PM_PAL_SEQ
LEFT OUTER JOIN ORG_COMPANY					C ON A.ORG_COMPANY_SEQ = C.SEQ
LEFT OUTER JOIN ORG_UNION					E ON C.ORG_UNION_SEQ = E.SEQ
WHERE	1 = 1
AND		A.PAL_YEAR = @year
AND		A.MONTHLY = @mm
AND     A.REGIST_STATUS = " + Define.REGIST_STATUS.GetKey("최종승인") + @"

ORDER BY C.ORG_UNION_SEQ, C.ORD";

                    return con.Query<PmPalSummaryExp>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        /// <summary>
        /// 전년실적 연간 회사
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        public IEnumerable<PmPalSummaryExp> selectListPmLastYear(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
-- 전년실적 : 연간 <만도(BU) => 14, HL Klemove => 19, 만도헬라 => 4 제외>
SELECT	A.PAL_YEAR
		, A.MONTHLY
		, B.MONTHLY_TYPE
		, ISNULL(B.SALES, 0)				AS SALES
		, ISNULL(B.EBIT, 0)					AS EBIT
		, ISNULL(B.PBT, 0)					AS PBT
		, C.ORG_UNION_SEQ
		, E.UNION_NAME
		, A.ORG_COMPANY_SEQ
		, C.COMPANY_NAME
        , E.IS_USE
FROM	PM_PAL								A
LEFT OUTER JOIN PM_PAL_SUMMARY				B ON A.SEQ = B.PM_PAL_SEQ
LEFT OUTER JOIN ORG_COMPANY					C ON A.ORG_COMPANY_SEQ = C.SEQ
LEFT OUTER JOIN ORG_UNION					E ON C.ORG_UNION_SEQ = E.SEQ
WHERE	1 = 1
AND		A.PAL_YEAR = @year -1
AND     C.SEQ NOT  IN('14','19','4')
AND     A.REGIST_STATUS = " + Define.REGIST_STATUS.GetKey("최종승인");

                    return con.Query<PmPalSummaryExp>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        /// <summary>
        /// 당해년도 계획 연간 회사
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        public IEnumerable<PmPalSummaryExp> selectListPnThisYear(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
-- 당해년도 계획  <만도(BU) => 14, HL Klemove => 19, 만도헬라 => 4 제외>
SELECT	A.YEAR_PAL_YEAR						AS PAL_YEAR
		, B.MONTHLY
		, ISNULL(B.SALES, 0)				AS SALES
		, ISNULL(B.EBIT, 0)					AS EBIT
		, ISNULL(B.PBT, 0)					AS PBT
		, C.ORG_UNION_SEQ
		, E.UNION_NAME
		, A.ORG_COMPANY_SEQ
		, C.COMPANY_NAME
FROM	PLAN_YEAR_PAL										A
LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS_MONTHLY_SUM		B ON A.SEQ = B.PLAN_MONTHLY_PAL_SEQ
LEFT OUTER JOIN ORG_COMPANY									C ON A.ORG_COMPANY_SEQ = C.SEQ
LEFT OUTER JOIN ORG_UNION									E ON C.ORG_UNION_SEQ = E.SEQ
WHERE	1 = 1
AND		A.YEAR_PAL_YEAR = @year
AND     A.REGIST_STATUS = " + Define.REGIST_STATUS.GetKey("최종승인") + @"
--AND     C.SEQ NOT  IN('14','19','4')

ORDER BY C.ORG_UNION_SEQ, C.ORD";

                    return con.Query<PmPalSummaryExp>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<PmPalSummary> selectListBefore(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
SELECT	*
FROM	PM_PAL					A
LEFT OUTER JOIN PM_PAL_SUMMARY	B ON A.SEQ = B.PM_PAL_SEQ
WHERE	1 = 1
AND		A.PAL_YEAR = @YearPalYear - 1
AND		A.ORG_COMPANY_SEQ = @OrgCompanySeq
AND		A.MONTHLY = '12'
AND		B.MONTHLY_TYPE = " + Define.MONTHLY_TYPE.GetKey("누계") + @"
";

                    return con.Query<PmPalSummary>(query, param).ToList();
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