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
    public class PmQuarterPalBusinessSummaryRepo : DbCon, IPmQuarterPalBusinessSummaryRepo
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
                    string query = " DELETE PM_QUARTER_PAL_SUMMARY " +
                        " WHERE PM_QUARTER_PAL_SEQ = @PmQuarterPalBusinessSeq";
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

        public int insert(PmQuarterPalBusinessSummary entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = @"INSERT INTO PM_QUARTER_PAL_SUMMARY (PM_QUARTER_PAL_SEQ, BUSINESS_YEAR, BUSINESS_QUARTER, SALES, EBIT, EBIT_RATE, PBT, NET_PROFIT_TERM)
                                    SELECT PM_QUARTER_PAL_SEQ
                                            ,A.QUARTER_PAL_YEAR
                                            ,BUSINESS_QUARTER
                                            ,SUM(ISNULL(SALES, 0))							AS SALES
                                            ,SUM(ISNULL(EBIT, 0))							AS EBIT
                                            ,CASE WHEN SUM(ISNULL(SALES, 0)) = 0 THEN 0 
			                                        WHEN SUM(ISNULL(EBIT, 0))  = 0 THEN 0
		                                        ELSE SUM(ISNULL(EBIT, 0)) / SUM(ISNULL(SALES, 0)) END	AS EBIT_RATE
                                            ,SUM(ISNULL(PBT, 0))							AS PBT
                                            ,'0'											AS NET_PROFIT_TERM
                                    FROM PM_QUARTER_PAL A
                                    LEFT OUTER JOIN PM_QUARTER_PAL_BUSINESS B ON A.SEQ = B.PM_QUARTER_PAL_SEQ
                                    WHERE 1 = 1
                                    AND B.PM_QUARTER_PAL_SEQ = @PmQuarterPalBusinessSeq
                                    AND A.QUARTER_PAL_YEAR = @BusinessYear
                                    AND A.MONTHLY = @Monthly
                                    GROUP BY PM_QUARTER_PAL_SEQ, A.QUARTER_PAL_YEAR, BUSINESS_QUARTER
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

        public int insert2(PmQuarterPalBusinessSummary entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = @" DELETE FROM PM_QUARTER_PAL_SUMMARY 
                                        WHERE PM_QUARTER_PAL_SEQ = @PmQuarterPalBusinessSeq 
                                            AND BUSINESS_YEAR = @BusinessYear
                                            AND BUSINESS_QUARTER = @BusinessQuarter ;
                                    INSERT INTO PM_QUARTER_PAL_SUMMARY (PM_QUARTER_PAL_SEQ, BUSINESS_YEAR, BUSINESS_QUARTER, SALES, EBIT, EBIT_RATE, PBT, NET_PROFIT_TERM)
                                    VALUES (@PmQuarterPalBusinessSeq
                                            , @BusinessYear
                                            , @BusinessQuarter
                                            , @SALES
                                            , @EBIT
                                            , CASE WHEN @SALES = 0 THEN 0 
                                                WHEN ISNULL(@EBIT, 0)  = 0 THEN 0
                                            ELSE ISNULL(@EBIT, 0) / ISNULL(@SALES, 0) END
                                            , @PBT
                                            , @NetProfitTerm);
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

        /// <summary>
        /// 전년 실적 요약
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        public IEnumerable<PmQuarterPalBusinessSummary> QuarterResultLastSummaryYearList(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
SELECT	A.QT AS BUSINESS_QUARTER, SUM(A.SALES) AS SALES, SUM(A.EBIT) AS EBIT, SUM(A.PBT) AS PBT
FROM	(
SELECT	A.PAL_YEAR, A.MONTHLY, DATEPART(QUARTER, A.PAL_YEAR + '-' + A.MONTHLY + '-01') AS QT, A.ORG_COMPANY_SEQ, B.PM_PAL_SEQ, B.SALES, B.EBIT, B.PBT
FROM	PM_PAL						A
LEFT OUTER JOIN PM_PAL_SUMMARY		B ON A.SEQ = B.PM_PAL_SEQ
WHERE	1 = 1
AND		A.PAL_YEAR = @YearlyYear - 1
AND		B.MONTHLY_TYPE = 10
AND		A.ORG_COMPANY_SEQ = @Seq
) A
GROUP BY A.QT


/*
SELECT A.ORG_COMPANY_SEQ 
		                                    ,QUARTER_PAL_YEAR
		                                    ,BUSINESS_QUARTER
		                                    ,MONTHLY
		                                    ,ISNULL(SALES,0)            AS SALES
		                                    ,ISNULL(EBIT,0)             AS EBIT
		                                    ,CASE WHEN ISNULL(SALES, 0) = 0 THEN 0 
			                                      WHEN ISNULL(EBIT, 0)  = 0 THEN 0
		                                     ELSE ISNULL(EBIT, 0) / ISNULL(SALES, 0) END AS EBITRATE
		                                    ,PBT
		                                    ,B.NET_PROFIT_TERM
                                    FROM PM_QUARTER_PAL A
                                    LEFT OUTER JOIN PM_QUARTER_PAL_SUMMARY B ON A.SEQ = B.PM_QUARTER_PAL_SEQ
                                    LEFT OUTER JOIN ORG_COMPANY C ON A.ORG_COMPANY_SEQ = C.SEQ
                                    WHERE 1 = 1
                                    AND A.ORG_COMPANY_SEQ = @Seq
                                    AND QUARTER_PAL_YEAR = @YearlyYear - 1
                                    AND A.MONTHLY = @Monthly
*/
";

                    return con.Query<PmQuarterPalBusinessSummary>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        /// <summary>
        /// 전년 실적 요약
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        public IEnumerable<PmQuarterPalBusinessSummary> QuarterPlanSummaryThisYearList(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" 

SELECT	A.MONTHLY_PAL_YEAR								AS QUARTER_PAL_YEAR
		, B.BUSINESS_QUARTER
		, ISNULL(B.SALES, 0.00)							AS SALES
		, ISNULL(B.EBIT, 0.00)							AS EBIT
		, ISNULL(B.PBT, 0.00)							AS PBT
		, C.ORG_UNION_SEQ
		, E.UNION_NAME
		, A.ORG_COMPANY_SEQ
		, C.COMPANY_NAME
FROM	PLAN_MONTHLY_PAL									A
LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS_QUARTER_SUM			B ON A.SEQ = B.PLAN_MONTHLY_PAL_SEQ
LEFT OUTER JOIN ORG_COMPANY					C ON A.ORG_COMPANY_SEQ = C.SEQ
LEFT OUTER JOIN ORG_UNION					E ON C.ORG_UNION_SEQ = E.SEQ
WHERE	1 = 1
AND		A.MONTHLY_PAL_YEAR = @YearlyYear
AND     A.ORG_COMPANY_SEQ = @Seq
AND		B.BUSINESS_QUARTER != 99

";

                    //string query = @" SELECT A.ORG_COMPANY_SEQ
		                  //                  ,MONTHLY_PAL_YEAR
		                  //                  ,'1'							AS BUSINESS_QUARTER
		                  //                  ,SUM(ISNULL(SALES, 0))		AS SALES
		                  //                  ,SUM(ISNULL(EBIT, 0))			AS EBIT
		                  //                  ,CASE WHEN SUM(ISNULL(SALES, 0)) = 0 THEN 0 
			                 //                     WHEN SUM(ISNULL(EBIT, 0))  = 0 THEN 0
		                  //                   ELSE SUM(ISNULL(EBIT, 0)) / SUM(ISNULL(SALES, 0)) END AS EBITRATE
		                  //                  ,SUM(ISNULL(PBT, 0))			AS PBT
                    //                FROM PLAN_MONTHLY_PAL A
                    //                LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS_MONTHLY_SUM B ON A.SEQ = B.PLAN_MONTHLY_PAL_SEQ
                    //                WHERE 1 = 1
                    //                AND A.ORG_COMPANY_SEQ = @Seq
                    //                AND A.MONTHLY_PAL_YEAR = @YearlyYear
                    //                AND MONTHLY BETWEEN '01' AND '03'
                    //                GROUP BY ORG_COMPANY_SEQ, MONTHLY_PAL_YEAR
                    //                UNION
                    //                SELECT A.ORG_COMPANY_SEQ
		                  //                  ,MONTHLY_PAL_YEAR
		                  //                  ,'2'							AS BUSINESS_QUARTER
		                  //                  ,SUM(ISNULL(SALES, 0))		AS SALES
		                  //                  ,SUM(ISNULL(EBIT, 0))			AS EBIT
		                  //                  ,CASE WHEN SUM(ISNULL(SALES, 0)) = 0 THEN 0 
			                 //                     WHEN SUM(ISNULL(EBIT, 0))  = 0 THEN 0
		                  //                  ELSE SUM(ISNULL(EBIT, 0)) / SUM(ISNULL(SALES, 0)) END AS EBITRATE
		                  //                  ,SUM(ISNULL(PBT, 0))			AS PBT
                    //                FROM PLAN_MONTHLY_PAL A
                    //                LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS_MONTHLY_SUM B ON A.SEQ = B.PLAN_MONTHLY_PAL_SEQ
                    //                WHERE 1 = 1
                    //                AND A.ORG_COMPANY_SEQ = @Seq
                    //                AND A.MONTHLY_PAL_YEAR = @YearlyYear
                    //                AND MONTHLY BETWEEN '04' AND '06'
                    //                GROUP BY ORG_COMPANY_SEQ, MONTHLY_PAL_YEAR
                    //                UNION
                    //                SELECT A.ORG_COMPANY_SEQ
		                  //                  ,MONTHLY_PAL_YEAR
		                  //                  ,'3'							AS BUSINESS_QUARTER
		                  //                  ,SUM(ISNULL(SALES, 0))		AS SALES
		                  //                  ,SUM(ISNULL(EBIT, 0))			AS EBIT
		                  //                  ,CASE WHEN SUM(ISNULL(SALES, 0)) = 0 THEN 0 
			                 //                     WHEN SUM(ISNULL(EBIT, 0))  = 0 THEN 0
		                  //                  ELSE SUM(ISNULL(EBIT, 0)) / SUM(ISNULL(SALES, 0)) END AS EBITRATE
		                  //                  ,SUM(ISNULL(PBT, 0))			AS PBT
                    //                FROM PLAN_MONTHLY_PAL A
                    //                LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS_MONTHLY_SUM B ON A.SEQ = B.PLAN_MONTHLY_PAL_SEQ
                    //                WHERE 1 = 1
                    //                AND A.ORG_COMPANY_SEQ = @Seq
                    //                AND A.MONTHLY_PAL_YEAR = @YearlyYear
                    //                AND MONTHLY BETWEEN '07' AND '09'
                    //                GROUP BY ORG_COMPANY_SEQ, MONTHLY_PAL_YEAR
                    //                UNION
                    //                SELECT A.ORG_COMPANY_SEQ
		                  //                  ,MONTHLY_PAL_YEAR
		                  //                  ,'4'							AS BUSINESS_QUARTER
		                  //                  ,SUM(ISNULL(SALES, 0))		AS SALES
		                  //                  ,SUM(ISNULL(EBIT, 0))			AS EBIT
		                  //                  ,CASE WHEN SUM(ISNULL(SALES, 0)) = 0 THEN 0 
			                 //                     WHEN SUM(ISNULL(EBIT, 0))  = 0 THEN 0
		                  //                  ELSE SUM(ISNULL(EBIT, 0)) / SUM(ISNULL(SALES, 0)) END AS EBITRATE
		                  //                  ,SUM(ISNULL(PBT, 0))			AS PBT
                    //                FROM PLAN_MONTHLY_PAL A
                    //                LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS_MONTHLY_SUM B ON A.SEQ = B.PLAN_MONTHLY_PAL_SEQ
                    //                WHERE 1 = 1
                    //                AND A.ORG_COMPANY_SEQ = @Seq
                    //                AND A.MONTHLY_PAL_YEAR = @YearlyYear
                    //                AND MONTHLY BETWEEN '10' AND '12'
                    //                GROUP BY ORG_COMPANY_SEQ, MONTHLY_PAL_YEAR";

                    return con.Query<PmQuarterPalBusinessSummary>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        /// <summary>
        /// 전년 실적 요약
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        public IEnumerable<PmQuarterPalBusinessSummary> QuarterExpectSummaryThisYearList(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" SELECT A.ORG_COMPANY_SEQ 
                                            ,QUARTER_PAL_YEAR
                                            ,BUSINESS_QUARTER
                                            ,MONTHLY
                                            ,ISNULL(SALES,0)            AS SALES
                                            ,ISNULL(EBIT,0)             AS EBIT
                                            ,CASE WHEN ISNULL(SALES, 0) = 0 THEN 0 
                                                  WHEN ISNULL(EBIT, 0)  = 0 THEN 0
                                             ELSE ISNULL(EBIT, 0) / ISNULL(SALES, 0) END AS EBITRATE
                                            ,PBT
                                            ,B.NET_PROFIT_TERM
                                            ,B.SEQ						AS PM_QUARTER_PAL_BUSINESS_SEQ
                                    FROM PM_QUARTER_PAL A
                                    LEFT OUTER JOIN PM_QUARTER_PAL_SUMMARY B ON A.SEQ = B.PM_QUARTER_PAL_SEQ
                                    LEFT OUTER JOIN ORG_COMPANY C ON A.ORG_COMPANY_SEQ = C.SEQ
                                    WHERE 1 = 1
                                    AND A.ORG_COMPANY_SEQ = @Seq
                                    AND QUARTER_PAL_YEAR = @YearlyYear
                                    AND A.MONTHLY = @Monthly";

                    return con.Query<PmQuarterPalBusinessSummary>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public int save(PmQuarterPalBusinessSummary entity)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<PmQuarterPalBusinessSummary> selectList(object param)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<PmQuarterPalBusinessSummary>  selectListExcel(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = @" 
                            SELECT	B.QUARTER_PAL_YEAR AS Business_Year
                                    ,B.MONTHLY
                                    ,A.*
                            FROM	PM_QUARTER_PAL_SUMMARY A 
                                INNER JOIN PM_QUARTER_PAL B ON A.PM_QUARTER_PAL_SEQ   = B.SEQ                         
                            WHERE	A.PM_QUARTER_PAL_SEQ = @PmQuarterPalSeq
                            ORDER BY BUSINESS_QUARTER
                        ";

                    return con.Query<PmQuarterPalBusinessSummary>(query, param).ToList();

                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }
        public PmQuarterPalBusinessSummary selectOne(object param)
        {
            throw new NotImplementedException();
        }

        public int update(PmQuarterPalBusinessSummary entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = @" UPDATE PM_QUARTER_PAL_SUMMARY SET
                                      SALES = @Sales
                                     ,EBIT = @Ebit
                                     ,EBIT_RATE = @EbitRate
                                     ,PBT = @Pbt
                                     ,NET_PROFIT_TERM = @NetProfitTerm
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

        /// <summary>
        /// 당해년도 연간예상(분기) 회사
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        public IEnumerable<PmQuarterPalBusinessSummaryExp> selectListPmThisYear(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
SELECT	A.QUARTER_PAL_YEAR
		, A.MONTHLY
		--, DATEPART(QUARTER, A.QUARTER_PAL_YEAR + '-' + A.MONTHLY + '-01') AS QT
		, B.BUSINESS_QUARTER
		, ISNULL(B.SALES, 0.00)							AS SALES
		, ISNULL(B.EBIT, 0.00)							AS EBIT
		, ISNULL(B.PBT, 0.00)							AS PBT
		, C.ORG_UNION_SEQ
		, E.UNION_NAME
		, A.ORG_COMPANY_SEQ
		, C.COMPANY_NAME
FROM	PM_QUARTER_PAL						A
LEFT OUTER JOIN PM_QUARTER_PAL_SUMMARY			B ON A.SEQ = B.PM_QUARTER_PAL_SEQ
LEFT OUTER JOIN ORG_COMPANY					C ON A.ORG_COMPANY_SEQ = C.SEQ
LEFT OUTER JOIN ORG_UNION					E ON C.ORG_UNION_SEQ = E.SEQ
WHERE	1 = 1
AND		A.QUARTER_PAL_YEAR = @year
AND		A.MONTHLY = @mm
AND     A.REGIST_STATUS = " + Define.REGIST_STATUS.GetKey("최종승인") + @"

ORDER BY C.ORG_UNION_SEQ, C.ORD
";

                    return con.Query<PmQuarterPalBusinessSummaryExp>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        /// <summary>
        /// 전년도 실적(분기) 회사
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        public IEnumerable<PmQuarterPalBusinessSummaryExp> selectListPmLastYear(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
SELECT	A.PAL_YEAR										AS QUARTER_PAL_YEAR
		--, A.MONTHLY
		, DATEPART(QUARTER, A.PAL_YEAR + '-' + A.MONTHLY + '-01') AS BUSINESS_QUARTER
		--, B.MONTHLY_TYPE
		, SUM(ISNULL(B.SALES, 0.00))						AS SALES
		, SUM(ISNULL(B.EBIT, 0.00))						AS EBIT
		, SUM(ISNULL(B.PBT, 0.00))						AS PBT
		, C.ORG_UNION_SEQ
		, E.UNION_NAME
		, A.ORG_COMPANY_SEQ
		, C.COMPANY_NAME
FROM	PM_PAL										A
LEFT OUTER JOIN PM_PAL_SUMMARY					B ON A.SEQ = B.PM_PAL_SEQ
LEFT OUTER JOIN ORG_COMPANY					C ON A.ORG_COMPANY_SEQ = C.SEQ
LEFT OUTER JOIN ORG_UNION					E ON C.ORG_UNION_SEQ = E.SEQ
WHERE	1 = 1
AND		A.PAL_YEAR = @year - 1
AND		B.MONTHLY_TYPE =  " + Define.MONTHLY_TYPE.GetKey("당월") + @"
AND     A.REGIST_STATUS = " + Define.REGIST_STATUS.GetKey("최종승인") + @"
GROUP BY A.PAL_YEAR
		--, A.MONTHLY
		, DATEPART(QUARTER, A.PAL_YEAR + '-' + A.MONTHLY + '-01')
		, C.ORG_UNION_SEQ
		, E.UNION_NAME
		, A.ORG_COMPANY_SEQ
		, C.COMPANY_NAME
";

                    return con.Query<PmQuarterPalBusinessSummaryExp>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        /// <summary>
        /// 전년도 계획(분기) 회사
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        public IEnumerable<PmQuarterPalBusinessSummaryExp> selectListPnThisYear(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
-- 합계 제외
SELECT	A.MONTHLY_PAL_YEAR								AS QUARTER_PAL_YEAR
		, B.BUSINESS_QUARTER
		, ISNULL(B.SALES, 0.00)							AS SALES
		, ISNULL(B.EBIT, 0.00)							AS EBIT
		, ISNULL(B.PBT, 0.00)							AS PBT
		, C.ORG_UNION_SEQ
		, E.UNION_NAME
		, A.ORG_COMPANY_SEQ
		, C.COMPANY_NAME
FROM	PLAN_MONTHLY_PAL									A
LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS_QUARTER_SUM			B ON A.SEQ = B.PLAN_MONTHLY_PAL_SEQ
LEFT OUTER JOIN ORG_COMPANY					C ON A.ORG_COMPANY_SEQ = C.SEQ
LEFT OUTER JOIN ORG_UNION					E ON C.ORG_UNION_SEQ = E.SEQ
WHERE	1 = 1
AND		A.MONTHLY_PAL_YEAR = @year
AND		B.BUSINESS_QUARTER != 99
AND     A.REGIST_STATUS = " + Define.REGIST_STATUS.GetKey("최종승인") + @"
";

                    return con.Query<PmQuarterPalBusinessSummaryExp>(query, param).ToList();
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