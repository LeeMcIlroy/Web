using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using Dapper;
using HALLA_PM.Util;

namespace HALLA_PM.Models
{
    public class GroupMainRepo : DbCon, IGroupMain
    {
        public int count(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " SELECT COUNT(*) FROM ORG_COMPANY ";
                    return con.Query<int>(query, param).First();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return -1;
                }
            }
        }

        public IEnumerable<GroupMain> selectList(object param)
        {
            //Search search = (Search)param;
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string where = " WHERE 1 = 1 AND IS_USE = 'Y' ";
                    where += " AND ORG_UNION_SEQ = @OrgUnionSeq";

                    string query = " SELECT ROW_NUMBER() OVER (ORDER BY CREATE_DATE ASC) AS ROW_NUM, * FROM ORG_COMPANY " + where;

                    //search.TotalCount = count(search);
                    //search.MakePaging();

                    return con.Query<GroupMain>(query, param).ToList();

                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public GroupMain selectOne(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = " SELECT A.*, B.UNION_NAME " +
                        " FROM ORG_COMPANY A " +
                        " LEFT OUTER JOIN ORG_UNION B ON A.ORG_UNION_SEQ = B.SEQ WHERE A.SEQ = @Seq ";

                    return con.Query<GroupMain>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        #region << Dash Board >>

        public GroupMain groupMainFCF(object param)
        {
             
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
                            SELECT	SUM(ISNULL(C.FCF2, 0))		AS DashBoardCashFcf
		                            , SUM(ISNULL(B.FCF2, 0))	AS DashBoardPlanFcf
		                            -- 계획값이 음수(-)이면 200에서 빼준다
		                            , CASE WHEN SUM(ISNULL(B.FCF2, 0)) = 0 THEN 0
			                            WHEN SUM(ISNULL(B.FCF2, 0)) < 0 THEN 200 - CONVERT(DECIMAL(12, 2), ROUND(SUM(ISNULL(C.FCF2, 0)) / SUM(ISNULL(B.FCF2, 2)) * 100, 2))
			                            ELSE CONVERT(DECIMAL(12, 2), ROUND(SUM(ISNULL(C.FCF2, 0)) / SUM(ISNULL(B.FCF2, 2)) * 100, 2)) END AS DashBoardRateFcf
		                            , CASE WHEN SUM(ISNULL(B.FCF2, 0)) = 0 THEN 0 ELSE CONVERT(DECIMAL(12, 2), ROUND(SUM(ISNULL(C.FCF2, 0)) / SUM(ISNULL(B.FCF2, 2)) * 100, 2)) END AS DashBoardRateFcf_BEFORE
                            FROM	PM_CASH_FLOW					A
                            LEFT OUTER JOIN PM_CASH_FLOW_CUMULATIVE	B ON A.SEQ = B.PM_CASH_FLOW_SEQ AND B.DIFF = 10 -- 계획
                            LEFT OUTER JOIN PM_CASH_FLOW_CUMULATIVE	C ON A.SEQ = C.PM_CASH_FLOW_SEQ AND C.DIFF = 20 -- 실적
                            WHERE	1 = 1
                            
                            AND		A.CASH_FLOW_YEAR = @Year
                            AND		A.MONTHLY = @Month
                            ";

                    //string query = @"
                    //        SELECT  DashBoardCashFcf
                    //          ,DashBoardPlanFcf
                    //          ,  CASE 
                    //                        WHEN SUM(B.DashBoardPlanFcf) = 0 THEN 0
                    //               WHEN SUM(B.DashBoardPlanFcf) < 0 THEN 200 - CONVERT(DECIMAL(12, 2), ROUND(SUM(B.DashBoardCashFcf) / SUM(ISNULL(B.DashBoardPlanFcf, 2)) * 100, 2))
                    //               ELSE CONVERT(DECIMAL(12, 2), ROUND(SUM(B.DashBoardCashFcf) / SUM(ISNULL(B.DashBoardPlanFcf, 2)) * 100, 2)) 
                    //                   END AS DashBoardRateFcf
                    //          , CASE 
                    //                    WHEN SUM(B.DashBoardPlanFcf) = 0 THEN 0 
                    //                    ELSE CONVERT(DECIMAL(12, 2), ROUND(SUM(B.DashBoardCashFcf) / SUM(ISNULL(B.DashBoardPlanFcf, 2)) * 100, 2)) 
                    //                END AS DashBoardRateFcf_BEFORE 
                    //        FROM ( SELECT FCF AS DashBoardCashFcf
                    //                , ( SELECT  SUM(FCF) FROM PLAN_GROUPDATA_CF_MONTHLY WITH(NOLOCK)
                    //                 WHERE  PLAN_GROUPDATA_CF_MONTHLY.GROUPDATA_YEAR = @Year 
                    //                    AND PLAN_GROUPDATA_CF_MONTHLY.GROUPDATA_MONTH <= @Month)
                    //                 AS DashBoardPlanFcf 
                    //                FROM PM_GROUPDATA_CF_MONTHLY 
                    //                WHERE   GROUPDATA_YEAR = @Year AND GROUPDATA_MONTH = @Month)B
                    //        GROUP BY DashBoardCashFcf,DashBoardPlanFcf 
                    //        ";
                    return con.Query<GroupMain>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }
        public GroupMain groupMainFCFexcept(object param)
        {

            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
                            SELECT	SUM(ISNULL(C.FCF2, 0))		AS DashBoardCashFcf
		                            , SUM(ISNULL(B.FCF2, 0))	AS DashBoardPlanFcf
		                            -- 계획값이 음수(-)이면 200에서 빼준다
		                            , CASE WHEN SUM(ISNULL(B.FCF2, 0)) = 0 THEN 0
			                            WHEN SUM(ISNULL(B.FCF2, 0)) < 0 THEN 200 - CONVERT(DECIMAL(12, 2), ROUND(SUM(ISNULL(C.FCF2, 0)) / SUM(ISNULL(B.FCF2, 2)) * 100, 2))
			                            ELSE CONVERT(DECIMAL(12, 2), ROUND(SUM(ISNULL(C.FCF2, 0)) / SUM(ISNULL(B.FCF2, 2)) * 100, 2)) END AS DashBoardRateFcf
		                            , CASE WHEN SUM(ISNULL(B.FCF2, 0)) = 0 THEN 0 ELSE CONVERT(DECIMAL(12, 2), ROUND(SUM(ISNULL(C.FCF2, 0)) / SUM(ISNULL(B.FCF2, 2)) * 100, 2)) END AS DashBoardRateFcf_BEFORE
                            FROM	PM_CASH_FLOW					A
                            LEFT OUTER JOIN PM_CASH_FLOW_CUMULATIVE	B ON A.SEQ = B.PM_CASH_FLOW_SEQ AND B.DIFF = 10 -- 계획
                            LEFT OUTER JOIN PM_CASH_FLOW_CUMULATIVE	C ON A.SEQ = C.PM_CASH_FLOW_SEQ AND C.DIFF = 20 -- 실적
                            WHERE	1 = 1
                            
                            AND		A.CASH_FLOW_YEAR = @Year
                            AND		A.MONTHLY = @Month
                            AND     A.ORG_COMPANY_SEQ IN('19','14')

                            ";

                    
                    return con.Query<GroupMain>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }
        public GroupMain groupMainFCF_NEW(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
                            SELECT  DashBoardCashFcf
		                            ,DashBoardPlanFcf
		                            ,  CASE 
                                            WHEN SUM(B.DashBoardPlanFcf) = 0 THEN 0
			                                WHEN SUM(B.DashBoardPlanFcf) < 0 THEN 200 - CONVERT(DECIMAL(12, 2), ROUND(SUM(B.DashBoardCashFcf) / SUM(ISNULL(B.DashBoardPlanFcf, 2)) * 100, 2))
			                                ELSE CONVERT(DECIMAL(12, 2), ROUND(SUM(B.DashBoardCashFcf) / SUM(ISNULL(B.DashBoardPlanFcf, 2)) * 100, 2)) 
                                       END AS DashBoardRateFcf
		                            , CASE 
                                        WHEN SUM(B.DashBoardPlanFcf) = 0 THEN 0 
                                        ELSE CONVERT(DECIMAL(12, 2), ROUND(SUM(B.DashBoardCashFcf) / SUM(ISNULL(B.DashBoardPlanFcf, 2)) * 100, 2)) 
                                    END AS DashBoardRateFcf_BEFORE 
                            FROM ( SELECT FCF AS DashBoardCashFcf
                                    , ( SELECT  SUM(FCF) FROM PLAN_GROUPDATA_CF_MONTHLY WITH(NOLOCK)
	                                    WHERE  PLAN_GROUPDATA_CF_MONTHLY.GROUPDATA_YEAR = @Year 
                                        AND PLAN_GROUPDATA_CF_MONTHLY.GROUPDATA_MONTH <= @Month)
	                                    AS DashBoardPlanFcf 
                                    FROM PM_GROUPDATA_CF_MONTHLY 
                                    WHERE   GROUPDATA_YEAR = @Year AND GROUPDATA_MONTH = @Month AND MONTH_TYPE = '20' )B
                            GROUP BY DashBoardCashFcf,DashBoardPlanFcf 
                            ";


                    //                    string query = @"
                    //SELECT	SUM(ISNULL(C.FCF2, 0))		AS DashBoardCashFcf
                    //		, CASE WHEN SUM(ISNULL(B.FCF2, 0)) = 0 THEN 0 ELSE CONVERT(DECIMAL(12, 2), ROUND(SUM(ISNULL(C.FCF2, 0)) / SUM(ISNULL(B.FCF2, 2)) * 100, 2)) END AS DashBoardRateFcf
                    //FROM	PM_CASH_FLOW					A
                    //LEFT OUTER JOIN PM_CASH_FLOW_CUMULATIVE	B ON A.SEQ = B.PM_CASH_FLOW_SEQ AND B.DIFF = 10 -- 계획
                    //LEFT OUTER JOIN PM_CASH_FLOW_CUMULATIVE	C ON A.SEQ = C.PM_CASH_FLOW_SEQ AND C.DIFF = 20 -- 실적
                    //WHERE	1 = 1
                    //AND		A.CASH_FLOW_YEAR = @Year
                    //AND		A.MONTHLY = @Month
                    //";

                    return con.Query<GroupMain>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<GroupMain> groupMainSales(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"

SELECT *
FROM
(
		-- 계획값이 음수(-)이면 200에서 빼준다
	SELECT	'당월' AS 'Kind'
			, SUM(B.SALES) AS 'DashBoardCashSales'
			, SUM(D.SALES) AS 'DashBoardPlanSales'
			, CONVERT(DECIMAL(12, 2), ROUND(CASE WHEN SUM(ISNULL(B.SALES, 0)) = 0 THEN 0
				WHEN SUM(ISNULL(B.SALES, 0)) < 0 THEN 200 - SUM(ISNULL(B.SALES, 0)) / SUM(ISNULL(D.SALES, 0)) * 100
				ELSE SUM(ISNULL(B.SALES, 0)) / SUM(ISNULL(D.SALES, 0)) * 100 END, 2)) AS 'DashBoardRateSales'
			,CONVERT(DECIMAL(12,2), ROUND(CASE WHEN ISNULL(SUM(B.SALES), 0) = 0 THEN 0 
										ELSE (SUM(B.SALES) / SUM(D.SALES)) * 100 END, 2)) AS 'DashBoardRateSales_BEFORE'
	FROM PM_PAL A
	LEFT OUTER JOIN PM_PAL_SUMMARY B ON A.SEQ = B.PM_PAL_SEQ
	LEFT OUTER JOIN PLAN_MONTHLY_PAL C ON A.ORG_COMPANY_SEQ = C.ORG_COMPANY_SEQ AND A.PAL_YEAR = C.MONTHLY_PAL_YEAR
	LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS_MONTHLY_SUM D ON C.SEQ = D.PLAN_MONTHLY_PAL_SEQ AND A.MONTHLY = D.MONTHLY
	WHERE B.MONTHLY_TYPE = @MonthlyTypeFirst
	AND A.PAL_YEAR = @Year
	AND A.MONTHLY = @Month
	UNION	SELECT '누계' AS 'Kind'
		    , SUM(B.SALES) AS 'DashBoardCashSales'
			, SUM(D.SALES) AS 'DashBoardPlanSales'
			, CONVERT(DECIMAL(12, 2), ROUND(CASE WHEN SUM(ISNULL(B.SALES, 0)) = 0 THEN 0
				WHEN SUM(ISNULL(B.SALES, 0)) < 0 THEN 200 - SUM(ISNULL(B.SALES, 0)) / SUM(ISNULL(D.SALES, 0)) * 100
				ELSE SUM(ISNULL(B.SALES, 0)) / SUM(ISNULL(D.SALES, 0)) * 100 END, 2)) AS 'DashBoardRateSales'
		    ,CONVERT(DECIMAL(12,2), ROUND(CASE WHEN ISNULL(SUM(B.SALES), 0) = 0 THEN 0 
										ELSE (SUM(B.SALES) / SUM(D.SALES)) * 100 END, 2)) AS 'DashBoardRateSales'
	FROM PM_PAL A
	LEFT OUTER JOIN PM_PAL_SUMMARY B ON A.SEQ = B.PM_PAL_SEQ
	LEFT OUTER JOIN PLAN_MONTHLY_PAL C ON A.ORG_COMPANY_SEQ = C.ORG_COMPANY_SEQ AND A.PAL_YEAR = C.MONTHLY_PAL_YEAR
	LEFT OUTER JOIN(
		SELECT B.PLAN_MONTHLY_PAL_SEQ
		        ,A.MONTHLY_PAL_YEAR
		        ,A.ORG_COMPANY_SEQ
		        ,@Month AS MONTHLY
			    ,SUM(B.SALES) AS SALES
	    FROM PLAN_MONTHLY_PAL A
		LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS_MONTHLY_SUM B ON A.SEQ = B.PLAN_MONTHLY_PAL_SEQ
		WHERE A.MONTHLY_PAL_YEAR = @Year
		AND	B.MONTHLY <= @Month
		GROUP BY B.PLAN_MONTHLY_PAL_SEQ, A.MONTHLY_PAL_YEAR, A.ORG_COMPANY_SEQ
	) D ON C.SEQ = D.PLAN_MONTHLY_PAL_SEQ
	WHERE B.MONTHLY_TYPE = @MonthlyTypeSecond
	AND A.PAL_YEAR = @Year
	AND A.MONTHLY = @Month
) A
ORDER BY KIND DESC
";


                    //string query = @" SELECT *
                    //                    FROM
                    //                    (
	                   //                     SELECT '당월' AS 'Kind'
		                  //                        ,SUM(B.SALES) AS 'DashBoardCashSales'
		                  //                        ,CONVERT(DECIMAL(12,2), ROUND(CASE WHEN ISNULL(SUM(B.SALES), 0) = 0 THEN 0 
										          //                              ELSE (SUM(B.SALES) / SUM(D.SALES)) * 100 END, 2)) AS 'DashBoardRateSales'
	                   //                     FROM PM_PAL A
	                   //                     LEFT OUTER JOIN PM_PAL_SUMMARY B ON A.SEQ = B.PM_PAL_SEQ
	                   //                     LEFT OUTER JOIN PLAN_MONTHLY_PAL C ON A.ORG_COMPANY_SEQ = C.ORG_COMPANY_SEQ AND A.PAL_YEAR = C.MONTHLY_PAL_YEAR
	                   //                     LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS_MONTHLY_SUM D ON C.SEQ = D.PLAN_MONTHLY_PAL_SEQ AND A.MONTHLY = D.MONTHLY
	                   //                     WHERE B.MONTHLY_TYPE = @MonthlyTypeFirst
	                   //                     AND A.PAL_YEAR = @Year
	                   //                     AND A.MONTHLY = @Month
	                   //                     UNION
	                   //                     SELECT '누계' AS 'Kind'
		                  //                        ,SUM(B.SALES) AS 'DashBoardCashSales'
		                  //                        ,CONVERT(DECIMAL(12,2), ROUND(CASE WHEN ISNULL(SUM(B.SALES), 0) = 0 THEN 0 
										          //                              ELSE (SUM(B.SALES) / SUM(D.SALES)) * 100 END, 2)) AS 'DashBoardRateSales'
	                   //                     FROM PM_PAL A
	                   //                     LEFT OUTER JOIN PM_PAL_SUMMARY B ON A.SEQ = B.PM_PAL_SEQ
	                   //                     LEFT OUTER JOIN PLAN_MONTHLY_PAL C ON A.ORG_COMPANY_SEQ = C.ORG_COMPANY_SEQ AND A.PAL_YEAR = C.MONTHLY_PAL_YEAR
	                   //                     LEFT OUTER JOIN(
		                  //                      SELECT B.PLAN_MONTHLY_PAL_SEQ
		                  //                            ,A.MONTHLY_PAL_YEAR
		                  //                            ,A.ORG_COMPANY_SEQ
		                  //                            ,@Month AS MONTHLY
			                 //                         ,SUM(B.SALES) AS SALES
	                   //                         FROM PLAN_MONTHLY_PAL A
		                  //                      LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS_MONTHLY_SUM B ON A.SEQ = B.PLAN_MONTHLY_PAL_SEQ
		                  //                      WHERE A.MONTHLY_PAL_YEAR = @Year
		                  //                      AND	B.MONTHLY <= @Month
		                  //                      GROUP BY B.PLAN_MONTHLY_PAL_SEQ, A.MONTHLY_PAL_YEAR, A.ORG_COMPANY_SEQ
	                   //                     ) D ON C.SEQ = D.PLAN_MONTHLY_PAL_SEQ
	                   //                     WHERE B.MONTHLY_TYPE = @MonthlyTypeSecond
	                   //                     AND A.PAL_YEAR = @Year
	                   //                     AND A.MONTHLY = @Month
                    //                    ) A
                    //                    ORDER BY KIND DESC ";

                    return con.Query<GroupMain>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<GroupMain> groupMainSales_NEW(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"	SELECT '당월' AS 'Kind'
			                                    ,DashBoardCashSales
			                                    ,DashBoardPlanSales
			                                    , CONVERT(DECIMAL(12, 2), ROUND(CASE WHEN SUM(ISNULL(DashBoardCashSales, 0)) = 0 THEN 0
					                                    WHEN SUM(ISNULL(DashBoardPlanSales, 0)) < 0 THEN 
							                                    200 - SUM(ISNULL(DashBoardCashSales, 0)) / SUM(ISNULL(DashBoardPlanSales, 0)) * 100
					                                    ELSE SUM(ISNULL(DashBoardCashSales, 0)) / SUM(ISNULL(DashBoardPlanSales, 0)) * 100 END, 2)) AS 'DashBoardRateSales'
			                                    ,CONVERT(DECIMAL(12,2), ROUND(CASE WHEN ISNULL(SUM(DashBoardCashSales), 0) = 0 THEN 0 
					                                    ELSE (SUM(DashBoardCashSales) / SUM(DashBoardPlanSales)) * 100 END, 2)) AS 'DashBoardRateSales_BEFORE'
	                                    FROM (SELECT SALES AS 'DashBoardCashSales'
				                                    , ( SELECT  SALES  FROM PLAN_GROUPDATA_PAL_MONTHLY_SUMMARY WITH(NOLOCK)
					                                    WHERE   GROUPDATA_YEAR =  @Year
							                                    AND  GROUPDATA_MONTH = @Month)  AS 'DashBoardPlanSales'
		                                       FROM  PM_GROUPDATA_PAL_MONTHLY
		                                       WHERE  GROUPDATA_YEAR = @Year
					                                    AND GROUPDATA_MONTH = @Month
					                                    AND  MONTHLY_TYPE = @MonthlyTypeFirst ) B
	                                    GROUP BY  DashBoardCashSales,DashBoardPlanSales

                                    UNION ALL

	                                    SELECT '누계' AS 'Kind'
				                                    , DashBoardCashSales
				                                    , DashBoardPlanSales
				                                    , CONVERT(DECIMAL(12, 2), ROUND(CASE WHEN SUM(ISNULL(DashBoardCashSales, 0)) = 0 THEN 0
					                                    WHEN SUM(ISNULL(DashBoardPlanSales, 0)) < 0 THEN 
							                                    200 - SUM(ISNULL(DashBoardCashSales, 0)) / SUM(ISNULL(DashBoardPlanSales, 0)) * 100
					                                    ELSE SUM(ISNULL(DashBoardCashSales, 0)) / SUM(ISNULL(DashBoardPlanSales, 0)) * 100 END, 2)) AS 'DashBoardRateSales'
				                                    ,CONVERT(DECIMAL(12,2), ROUND(CASE WHEN ISNULL(SUM(DashBoardCashSales), 0) = 0 THEN 0 
					                                    ELSE (SUM(DashBoardCashSales) / SUM(DashBoardPlanSales)) * 100 END, 2)) AS 'DashBoardRateSales'
	                                    FROM (SELECT SALES AS DashBoardCashSales
			                                    , ( SELECT  SUM(SALES)  FROM PLAN_GROUPDATA_PAL_MONTHLY_SUMMARY WITH(NOLOCK)
				                                    WHERE   GROUPDATA_YEAR =  @Year
						                                    AND  GROUPDATA_MONTH <= @Month)	AS DashBoardPlanSales
			                                    FROM  PM_GROUPDATA_PAL_MONTHLY
			                                    WHERE  GROUPDATA_YEAR = @Year 
					                                    AND GROUPDATA_MONTH =  @Month
					                                    AND  MONTHLY_TYPE = @MonthlyTypeSecond) B
	                                    GROUP BY  DashBoardCashSales,DashBoardPlanSales ";

                     
                    return con.Query<GroupMain>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<GroupMain> groupMainEbit(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
-- 그룹 EBIT
SELECT *
FROM
(
		-- 계획값이 음수(-)이면 200에서 빼준다
	SELECT '당월' AS 'Kind'
		    ,SUM(B.EBIT) AS 'DashBoardCashEbit'
		    ,SUM(D.EBIT) AS 'DashBoardCashPlanEbit'	
			, CONVERT(DECIMAL(12, 2), ROUND(CASE WHEN SUM(ISNULL(B.EBIT, 0)) = 0 THEN 0
				WHEN SUM(ISNULL(B.EBIT, 0)) < 0 THEN 200 - SUM(ISNULL(B.EBIT, 0)) / SUM(ISNULL(D.EBIT, 0)) * 100
				ELSE SUM(ISNULL(B.EBIT, 0)) / SUM(ISNULL(D.EBIT, 0)) * 100 END, 2)) AS 'DashBoardRateEbit'
		    ,CONVERT(DECIMAL(12,2), ROUND(CASE WHEN ISNULL(SUM(B.EBIT), 0) = 0 THEN 0 
										ELSE (SUM(B.EBIT) / SUM(D.EBIT)) * 100 END, 2)) AS 'DashBoardRateEbit_BEFORE'
	FROM PM_PAL A
	LEFT OUTER JOIN PM_PAL_SUMMARY B ON A.SEQ = B.PM_PAL_SEQ
	LEFT OUTER JOIN PLAN_MONTHLY_PAL C ON A.ORG_COMPANY_SEQ = C.ORG_COMPANY_SEQ AND A.PAL_YEAR = C.MONTHLY_PAL_YEAR
	LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS_MONTHLY_SUM D ON C.SEQ = D.PLAN_MONTHLY_PAL_SEQ AND A.MONTHLY = D.MONTHLY
	WHERE B.MONTHLY_TYPE = @MonthlyTypeFirst
	AND A.PAL_YEAR = @Year
	AND A.MONTHLY = @Month
	UNION
	SELECT '누계' AS 'Kind'
		    ,SUM(B.EBIT) AS 'DashBoardCashEbit'
		    ,SUM(D.EBIT) AS 'DashBoardCashPlanEbit'
			, CONVERT(DECIMAL(12, 2), ROUND(CASE WHEN SUM(ISNULL(B.EBIT, 0)) = 0 THEN 0
				WHEN SUM(ISNULL(B.EBIT, 0)) < 0 THEN 200 - SUM(ISNULL(B.EBIT, 0)) / SUM(ISNULL(D.EBIT, 0)) * 100
				ELSE SUM(ISNULL(B.EBIT, 0)) / SUM(ISNULL(D.EBIT, 0)) * 100 END, 2)) AS 'DashBoardRateEbit'
		    ,CONVERT(DECIMAL(12,2), ROUND(CASE WHEN ISNULL(SUM(B.EBIT), 0) = 0 THEN 0 
										ELSE (SUM(B.EBIT) / SUM(D.EBIT)) * 100 END, 2)) AS 'DashBoardRateEbit_BEFORE'
	FROM PM_PAL A
	LEFT OUTER JOIN PM_PAL_SUMMARY B ON A.SEQ = B.PM_PAL_SEQ
	LEFT OUTER JOIN PLAN_MONTHLY_PAL C ON A.ORG_COMPANY_SEQ = C.ORG_COMPANY_SEQ AND A.PAL_YEAR = C.MONTHLY_PAL_YEAR
	LEFT OUTER JOIN(
		SELECT B.PLAN_MONTHLY_PAL_SEQ
		        ,A.MONTHLY_PAL_YEAR
		        ,A.ORG_COMPANY_SEQ
		        ,@Month	   AS MONTHLY
			    ,SUM(B.EBIT) AS EBIT
	    FROM PLAN_MONTHLY_PAL A
		LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS_MONTHLY_SUM B ON A.SEQ = B.PLAN_MONTHLY_PAL_SEQ
		WHERE A.MONTHLY_PAL_YEAR = @Year
		AND	B.MONTHLY <= @Month
		GROUP BY B.PLAN_MONTHLY_PAL_SEQ, A.MONTHLY_PAL_YEAR, A.ORG_COMPANY_SEQ
	) D ON C.SEQ = D.PLAN_MONTHLY_PAL_SEQ
	WHERE B.MONTHLY_TYPE = @MonthlyTypeSecond
	AND A.PAL_YEAR = @Year
	AND A.MONTHLY = @Month
) A
ORDER BY KIND DESC
";

                    return con.Query<GroupMain>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<GroupMain> groupMainEbit_NEW(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"-- 그룹 EBIT
                            SELECT '당월' AS 'Kind'
				                        , DashBoardCashEbit
				                        , DashBoardCashPlanEbit
				                        , CONVERT(DECIMAL(12, 2), ROUND(CASE WHEN SUM(ISNULL(DashBoardCashEbit, 0)) = 0 THEN 0
					                        WHEN SUM(ISNULL(DashBoardCashPlanEbit, 0)) < 0 THEN 
							                        200 - SUM(ISNULL(DashBoardCashEbit, 0)) / SUM(ISNULL(DashBoardCashPlanEbit, 0)) * 100
					                        ELSE SUM(ISNULL(DashBoardCashEbit, 0)) / SUM(ISNULL(DashBoardCashPlanEbit, 0)) * 100 END, 2)) AS 'DashBoardRateEbit'
				                        ,CONVERT(DECIMAL(12,2), ROUND(CASE WHEN ISNULL(SUM(DashBoardCashEbit), 0) = 0 THEN 0 
					                        ELSE (SUM(DashBoardCashEbit) / SUM(DashBoardCashPlanEbit)) * 100 END, 2)) AS 'DashBoardRateEbit_BEFORE'
	                        FROM (SELECT EBIT AS 'DashBoardCashEbit'
				                        , ( SELECT  EBIT  FROM PLAN_GROUPDATA_PAL_MONTHLY_SUMMARY WITH(NOLOCK)
					                        WHERE   GROUPDATA_YEAR =  @Year
							                        AND  GROUPDATA_MONTH = @Month)  AS 'DashBoardCashPlanEbit'
		                            FROM  PM_GROUPDATA_PAL_MONTHLY
		                            WHERE  GROUPDATA_YEAR = @Year
					                        AND GROUPDATA_MONTH = @Month
					                        AND  MONTHLY_TYPE = @MonthlyTypeFirst) B
	                        GROUP BY   DashBoardCashEbit,DashBoardCashPlanEbit

                        UNION ALL

	                        SELECT '누계' AS 'Kind'
				                        , DashBoardCashEbit
				                        , DashBoardCashPlanEbit
				                        , CONVERT(DECIMAL(12, 2), ROUND(CASE WHEN SUM(ISNULL(DashBoardCashEbit, 0)) = 0 THEN 0
					                        WHEN SUM(ISNULL(DashBoardCashPlanEbit, 0)) < 0 THEN 
							                        200 - SUM(ISNULL(DashBoardCashEbit, 0)) / SUM(ISNULL(DashBoardCashPlanEbit, 0)) * 100
					                        ELSE SUM(ISNULL(DashBoardCashEbit, 0)) / SUM(ISNULL(DashBoardCashPlanEbit, 0)) * 100 END, 2)) AS 'DashBoardRateEbit'
				                        ,CONVERT(DECIMAL(12,2), ROUND(CASE WHEN ISNULL(SUM(DashBoardCashEbit), 0) = 0 THEN 0 
					                        ELSE (SUM(DashBoardCashEbit) / SUM(DashBoardCashPlanEbit)) * 100 END, 2)) AS 'DashBoardRateEbit_BEFORE'
	                        FROM (SELECT EBIT AS 'DashBoardCashEbit'
			                        , ( SELECT  SUM(EBIT)  FROM PLAN_GROUPDATA_PAL_MONTHLY_SUMMARY WITH(NOLOCK)
				                        WHERE   GROUPDATA_YEAR =   @Year
						                        AND  GROUPDATA_MONTH <=  @Month)	AS 'DashBoardCashPlanEbit'
			                        FROM  PM_GROUPDATA_PAL_MONTHLY
			                        WHERE  GROUPDATA_YEAR =  @Year
					                        AND GROUPDATA_MONTH =  @Month
					                        AND  MONTHLY_TYPE =@MonthlyTypeSecond) B
	                        GROUP BY  DashBoardCashEbit,DashBoardCashPlanEbit";

                    return con.Query<GroupMain>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<GroupMain> groupMainPbt_NEW(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"-- 그룹 EBIT
                            SELECT '당월' AS 'Kind'
		                            , DashBoardCashPbt
		                            , DashBoardCashPlanPbt
		                            , CONVERT(DECIMAL(12, 2), ROUND(CASE WHEN SUM(ISNULL(DashBoardCashPbt, 0)) = 0 THEN 0
			                            WHEN SUM(ISNULL(DashBoardCashPlanPbt, 0)) < 0 THEN 
					                            200 - SUM(ISNULL(DashBoardCashPbt, 0)) / SUM(ISNULL(DashBoardCashPlanPbt, 0)) * 100
			                            ELSE SUM(ISNULL(DashBoardCashPbt, 0)) / SUM(ISNULL(DashBoardCashPlanPbt, 0)) * 100 END, 2)) AS 'DashBoardRatePbt'
		                            ,CONVERT(DECIMAL(12,2), ROUND(CASE WHEN ISNULL(SUM(DashBoardCashPbt), 0) = 0 THEN 0 
			                            ELSE (SUM(DashBoardCashPbt) / SUM(DashBoardCashPlanPbt)) * 100 END, 2)) AS 'DashBoardRatePbt_BEFORE'
                            FROM (SELECT PBT AS 'DashBoardCashPbt'
		                            , ( SELECT  PBT  FROM PLAN_GROUPDATA_PAL_MONTHLY_SUMMARY WITH(NOLOCK)
			                            WHERE   GROUPDATA_YEAR =  @Year
					                            AND  GROUPDATA_MONTH = @Month)  AS 'DashBoardCashPlanPbt'
	                           FROM  PM_GROUPDATA_PAL_MONTHLY
		                            WHERE  GROUPDATA_YEAR = @Year
					                        AND GROUPDATA_MONTH = @Month
					                        AND  MONTHLY_TYPE = @MonthlyTypeFirst) B
                            GROUP BY   DashBoardCashPbt,DashBoardCashPlanPbt

                            UNION ALL

                            SELECT '누계' AS 'Kind'
		                            , DashBoardCashPbt
		                            , DashBoardCashPlanPbt
		                            , CONVERT(DECIMAL(12, 2), ROUND(CASE WHEN SUM(ISNULL(DashBoardCashPbt, 0)) = 0 THEN 0
			                            WHEN SUM(ISNULL(DashBoardCashPlanPbt, 0)) < 0 THEN 
					                            200 - SUM(ISNULL(DashBoardCashPbt, 0)) / SUM(ISNULL(DashBoardCashPlanPbt, 0)) * 100
			                            ELSE SUM(ISNULL(DashBoardCashPbt, 0)) / SUM(ISNULL(DashBoardCashPlanPbt, 0)) * 100 END, 2)) AS 'DashBoardRatePbt'
		                            ,CONVERT(DECIMAL(12,2), ROUND(CASE WHEN ISNULL(SUM(DashBoardCashPbt), 0) = 0 THEN 0 
			                            ELSE (SUM(DashBoardCashPbt) / SUM(DashBoardCashPlanPbt)) * 100 END, 2)) AS 'DashBoardRatePbt_BEFORE'
                            FROM (SELECT PBT 'DashBoardCashPbt'
	                            , ( SELECT  SUM(PBT)  FROM PLAN_GROUPDATA_PAL_MONTHLY_SUMMARY WITH(NOLOCK)
		                            WHERE   GROUPDATA_YEAR =    @Year
				                            AND  GROUPDATA_MONTH <= @Month)	AS 'DashBoardCashPlanPbt'
	                                FROM  PM_GROUPDATA_PAL_MONTHLY
			                        WHERE  GROUPDATA_YEAR =  @Year
					                        AND GROUPDATA_MONTH =  @Month
					                        AND  MONTHLY_TYPE =@MonthlyTypeSecond) B
                            GROUP BY  DashBoardCashPbt,DashBoardCashPlanPbt";

                    return con.Query<GroupMain>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public GroupMain groupMainRoic(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    // 나누기 체크 하실때 앞에 값이 아닌 뒤에 값이 0으로 나눌때 오류가 발생합니다.

                    // 2019.03.28 ROIC 로직 변경된걸로 작업하여 새로 작성
                    string query = @"
; WITH GROUP_ROW_TABLE AS
(
SELECT	A.BS_YEAR
		, CONVERT(DECIMAL(12, 2), A.MONTHLY)			AS D_MONTH
		, SUM(ISNULL(B.AFTER_TAX_OPERATION_PROFIT, 0))	AS PM_AFTER_TAX_OPERATION_PROFIT
		, SUM(ISNULL(B.PAIN_IN_CAPITAL, 0))				AS PM_PAIN_IN_CAPITAL
		, SUM(ISNULL(D.AFTER_TAX_OPERATION_PROFIT, 0))	AS PN_AFTER_TAX_OPERATION_PROFIT
		, SUM(ISNULL(D.PAIN_IN_CAPITAL, 0))				AS PN_PAIN_IN_CAPITAL
FROM	PM_BS							A
LEFT OUTER JOIN PM_BS_SUMMARY			B ON A.SEQ = B.PM_BS_SEQ
LEFT OUTER JOIN PLAN_YEAR_BS			C ON A.ORG_COMPANY_SEQ = C.ORG_COMPANY_SEQ AND A.BS_YEAR = C.YEAR_BS_YEAR
LEFT OUTER JOIN PLAN_YEAR_BS_ROIC		D ON C.SEQ = D.PLAN_YEAR_BS_SEQ AND A.BS_YEAR = D.YEARLY_YEAR AND A.MONTHLY = D.MONTHLY
WHERE	1 = 1
AND		A.BS_YEAR = @Year
AND		A.MONTHLY = @Month
GROUP BY A.BS_YEAR, A.MONTHLY
)
, GROUP_ROIC_TABLE AS
(
SELECT	BS_YEAR
		, CASE WHEN PM_PAIN_IN_CAPITAL = 0 THEN 0
			ELSE PM_AFTER_TAX_OPERATION_PROFIT / PM_PAIN_IN_CAPITAL * 100 END			AS PM_ROIC
		, CASE WHEN PM_PAIN_IN_CAPITAL = 0 THEN 0
			ELSE PN_AFTER_TAX_OPERATION_PROFIT / PN_PAIN_IN_CAPITAL * 100 END			AS PN_ROIC
		, CASE WHEN PM_PAIN_IN_CAPITAL = 0 THEN 0
			ELSE CONVERT(DECIMAL(12, 2), ROUND(PM_AFTER_TAX_OPERATION_PROFIT / PM_PAIN_IN_CAPITAL * 100 * (12 / D_MONTH), 2)) END			AS PM_NEW_ROIC
		, CASE WHEN PM_PAIN_IN_CAPITAL = 0 THEN 0
			ELSE CONVERT(DECIMAL(12, 2), ROUND(PN_AFTER_TAX_OPERATION_PROFIT / PN_PAIN_IN_CAPITAL * 100 * (12 / D_MONTH), 2)) END			AS PN_NEW_ROIC
FROM	GROUP_ROW_TABLE
)
SELECT	BS_YEAR
		, PM_NEW_ROIC				AS dashBoardRoic
		, PN_NEW_ROIC				AS dashBoardplanRoic
		, CONVERT(DECIMAL(12, 2), ROUND(CASE WHEN PN_NEW_ROIC = 0 THEN 0
			WHEN PN_NEW_ROIC < 0 THEN 200 - (PM_NEW_ROIC / PN_NEW_ROIC * 100)
			WHEN PN_NEW_ROIC > 0 THEN (PM_NEW_ROIC / PN_NEW_ROIC * 100) END, 2))				AS dashBoardRateRoic
FROM	GROUP_ROIC_TABLE
/*
-- 계획값이 음수(-)이면 200에서 빼준다
SELECT	PM_ROIC AS dashBoardRoic
		, PN_ROIC AS dashBoardplanRoic
		, CONVERT(DECIMAL(12, 2), ROUND(CASE WHEN PN_ROIC = 0 THEN 0
			WHEN PN_ROIC < 0 THEN 200 - (PM_ROIC / PN_ROIC * 100)
			ELSE (PM_ROIC / PN_ROIC * 100) END, 2)) AS dashBoardRateRoic
		, CASE WHEN PN_ROIC = 0 THEN 0 ELSE CONVERT(DECIMAL(12, 2), ROUND(PM_ROIC / PN_ROIC * 100, 2)) END AS dashBoardRateRoic
FROM	(
SELECT	SUM(ISNULL(B.AFTER_TAX_OPERATION_PROFIT, 0)) AS PM_AFTER_TAX_OPERATION_PROFIT
		, SUM(ISNULL(B.PAIN_IN_CAPITAL, 0)) AS PM_PAIN_IN_CAPITAL
		, CASE WHEN SUM(ISNULL(B.PAIN_IN_CAPITAL, 0)) = 0 THEN 0 ELSE CONVERT(DECIMAL(12, 2), ROUND(SUM(ISNULL(B.AFTER_TAX_OPERATION_PROFIT, 0)) / SUM(ISNULL(B.PAIN_IN_CAPITAL, 0)) * 100, 2)) END AS PM_ROIC
		, SUM(ISNULL(D.AFTER_TAX_OPERATION_PROFIT, 0)) AS AFTER_TAX_OPERATION_PROFIT
		, SUM(ISNULL(D.PAIN_IN_CAPITAL, 0)) AS PAIN_IN_CAPITAL
		, CASE WHEN SUM(ISNULL(D.PAIN_IN_CAPITAL, 0)) = 0 THEN 0 ELSE CONVERT(DECIMAL(12, 2), ROUND(SUM(ISNULL(D.AFTER_TAX_OPERATION_PROFIT, 0)) / SUM(ISNULL(D.PAIN_IN_CAPITAL, 0)) * 100, 2)) END AS PN_ROIC
		, A.BS_YEAR
FROM	PM_BS							A
LEFT OUTER JOIN PM_BS_SUMMARY			B ON A.SEQ = B.PM_BS_SEQ
LEFT OUTER JOIN PLAN_YEAR_BS			C ON A.ORG_COMPANY_SEQ = C.ORG_COMPANY_SEQ AND A.BS_YEAR = C.YEAR_BS_YEAR
LEFT OUTER JOIN PLAN_YEAR_BS_ROIC		D ON C.SEQ = D.PLAN_YEAR_BS_SEQ AND A.BS_YEAR = D.YEARLY_YEAR AND A.MONTHLY = D.MONTHLY
WHERE	1 = 1
AND		A.BS_YEAR = @Year
AND		A.MONTHLY = @Month
GROUP BY A.BS_YEAR
)			A
*/
";
                    
                    return con.Query<GroupMain>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public GroupMain groupMainRoic_NEW(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    // 나누기 체크 하실때 앞에 값이 아닌 뒤에 값이 0으로 나눌때 오류가 발생합니다.

                    // 2019.03.28 ROIC 로직 변경된걸로 작업하여 새로 작성
                    string query = @"
                            ; WITH GROUP_ROW_TABLE AS
                            (
                            SELECT A.GROUPDATA_YEAR AS BS_YEAR
	                                 ,CONVERT(DECIMAL(12, 2),A.GROUPDATA_MONTH) AS D_MONTH
	                                 ,A.AFTER_TAX_OPERATION_PROFIT AS PM_AFTER_TAX_OPERATION_PROFIT
	                                 ,A.PAIN_IN_CAPITAL AS PM_PAIN_IN_CAPITAL
	                                 ,B.AFTER_TAX_OPERATION_PROFIT AS PN_AFTER_TAX_OPERATION_PROFIT
	                                 ,B.PAIN_IN_CAPITAL AS  PN_PAIN_IN_CAPITAL
                            FROM PM_GROUPDATA_BS_MONTHLY A WITH(NOLOCK) 
	                                 INNER JOIN PLAN_GROUPDATA_BS_MONTHLY B  WITH(NOLOCK) 
	                                 ON	 A.GROUPDATA_YEAR = B.GROUPDATA_YEAR AND A.GROUPDATA_MONTH = B.GROUPDATA_MONTH
	                                 WHERE A.GROUPDATA_YEAR =  @Year
			                                AND A.GROUPDATA_MONTH =@Month 
                            )
                            , GROUP_ROIC_TABLE AS
                            (
                            SELECT	BS_YEAR
		                            , CASE WHEN PM_PAIN_IN_CAPITAL = 0 THEN 0
			                            ELSE PM_AFTER_TAX_OPERATION_PROFIT / PM_PAIN_IN_CAPITAL * 100 END			AS PM_ROIC
		                            , CASE WHEN PM_PAIN_IN_CAPITAL = 0 THEN 0
			                            ELSE PN_AFTER_TAX_OPERATION_PROFIT / PN_PAIN_IN_CAPITAL * 100 END			AS PN_ROIC
		                            , CASE WHEN PM_PAIN_IN_CAPITAL = 0 THEN 0
			                            ELSE CONVERT(DECIMAL(12, 2), ROUND(PM_AFTER_TAX_OPERATION_PROFIT / PM_PAIN_IN_CAPITAL * 100 * (12 / D_MONTH), 2)) END			AS PM_NEW_ROIC
		                            , CASE WHEN PM_PAIN_IN_CAPITAL = 0 THEN 0
			                            ELSE CONVERT(DECIMAL(12, 2), ROUND(PN_AFTER_TAX_OPERATION_PROFIT / PN_PAIN_IN_CAPITAL * 100 * (12 / D_MONTH), 2)) END			AS PN_NEW_ROIC
                            FROM	GROUP_ROW_TABLE
                            )
                            SELECT	BS_YEAR
		                            , PM_NEW_ROIC				AS dashBoardRoic
		                            , PN_NEW_ROIC				AS dashBoardplanRoic
		                            , CONVERT(DECIMAL(12, 2), ROUND(CASE WHEN PN_NEW_ROIC = 0 THEN 0
			                            WHEN PN_NEW_ROIC < 0 THEN 200 - (PM_NEW_ROIC / PN_NEW_ROIC * 100)
			                            WHEN PN_NEW_ROIC > 0 THEN (PM_NEW_ROIC / PN_NEW_ROIC * 100) END, 2))				AS dashBoardRateRoic
                            FROM	GROUP_ROIC_TABLE ";  

                    return con.Query<GroupMain>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }



        #endregion

        #region << KPI Signal >>

        public IEnumerable<GroupMain> groupMainKpiSignalGroup(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" SELECT UNION_NAME AS 'unionName'
                                        FROM PM_CASH_FLOW A
                                        LEFT OUTER JOIN PM_CASH_FLOW_CUMULATIVE B ON A.SEQ = B.PM_CASH_FLOW_SEQ
                                        LEFT OUTER JOIN PLAN_YEAR_CF C ON A.ORG_COMPANY_SEQ = C.ORG_COMPANY_SEQ AND A.CASH_FLOW_YEAR = C.YEAR_CF_YEAR
                                        LEFT OUTER JOIN PLAN_YEAR_CF_FCF D ON C.SEQ = D.PLAN_YEAR_CF_SEQ AND A.CASH_FLOW_YEAR = D.YEARLY_YEAR AND A.MONTHLY = D.MONTHLY
                                        LEFT OUTER JOIN ORG_COMPANY E ON A.ORG_COMPANY_SEQ = E.SEQ
                                        LEFT OUTER JOIN ORG_UNION F ON E.ORG_UNION_SEQ = F.SEQ
                                        WHERE B.DIFF = @Diff					
                                        AND A.CASH_FLOW_YEAR = @Year
                                        AND A.MONTHLY = @Month
                                        GROUP BY UNION_NAME";

                    return con.Query<GroupMain>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<GroupMain> groupMainKpiSignalFCF(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    //2022.03.31 쿼리 수정
                    string query = @"
                    SELECT E.SEQ AS companySeq,
                           E.COMPANY_NAME 
                           ,SUM(ISNULL(B.FCF2, 0))		AS 'kpiResultFcf2'
                           ,SUM(ISNULL(D.FCF2, 0))		AS 'kpiPlanFcf2'
                           ,UNION_NAME      AS 'unionName'
                           ,E.ORD
                    FROM PM_CASH_FLOW A
                    LEFT OUTER JOIN PM_CASH_FLOW_CUMULATIVE B ON A.SEQ = B.PM_CASH_FLOW_SEQ AND B.DIFF = 20 -- 실적
                    LEFT OUTER JOIN PM_CASH_FLOW_CUMULATIVE	D ON A.SEQ = D.PM_CASH_FLOW_SEQ AND D.DIFF = 10 -- 계획
                    LEFT OUTER JOIN ORG_COMPANY E ON A.ORG_COMPANY_SEQ = E.SEQ
                    LEFT OUTER JOIN ORG_UNION F ON E.ORG_UNION_SEQ = F.SEQ
                    WHERE 1 = 1
                    AND A.CASH_FLOW_YEAR = @Year	
                    AND A.MONTHLY = @Month
                    AND E.IS_USE = 'Y'
                    AND E.ORD IS NOT NULL
                    
                    GROUP BY E.COMPANY_NAME, UNION_NAME, F.SEQ,E.SEQ, E.ORD
                    ORDER BY F.SEQ, E.ORD
                    ";
                    //string query = @"
                    //SELECT E.SEQ AS companySeq,
                    //       E.COMPANY_NAME 
                    //       ,SUM(ISNULL(B.FCF2, 0))		AS 'kpiResultFcf2'
                    //       ,SUM(ISNULL(D.FCF2, 0))		AS 'kpiPlanFcf2'
                    //       ,UNION_NAME      AS 'unionName'
                    //FROM PM_CASH_FLOW A
                    //LEFT OUTER JOIN PM_CASH_FLOW_CUMULATIVE B ON A.SEQ = B.PM_CASH_FLOW_SEQ AND B.DIFF = 20 -- 실적
                    //LEFT OUTER JOIN PM_CASH_FLOW_CUMULATIVE	D ON A.SEQ = D.PM_CASH_FLOW_SEQ AND D.DIFF = 10 -- 계획
                    //LEFT OUTER JOIN ORG_COMPANY E ON A.ORG_COMPANY_SEQ = E.SEQ
                    //LEFT OUTER JOIN ORG_UNION F ON E.ORG_UNION_SEQ = F.SEQ
                    //WHERE 1 = 1
                    //AND A.CASH_FLOW_YEAR = @Year	
                    //AND A.MONTHLY = @Month
                    //AND E.IS_USE = 'Y'
                    //GROUP BY E.COMPANY_NAME, UNION_NAME, F.SEQ, E.SEQ
                    //ORDER BY F.SEQ, E.SEQ
                    //";



                    //string query = @" SELECT E.COMPANY_NAME, CONVERT(DECIMAL(12,2), ROUND(CASE WHEN ISNULL(SUM(D.FCF2), 0) = 0 THEN 0 
                    //                                 WHEN ISNULL(SUM(B.FCF2), 0) = 0 THEN 0
                    //                                                                      ELSE (ISNULL(SUM(B.FCF2), 0) / ISNULL(SUM(D.FCF2), 0)) * 100 END, 2)) AS 'KpiSignalRateFcf'
                    //                        ,UNION_NAME      AS 'unionName'
                    //                    FROM PM_CASH_FLOW A
                    //                    LEFT OUTER JOIN PM_CASH_FLOW_CUMULATIVE B ON A.SEQ = B.PM_CASH_FLOW_SEQ
                    //                    LEFT OUTER JOIN PLAN_YEAR_CF C ON A.ORG_COMPANY_SEQ = C.ORG_COMPANY_SEQ AND A.CASH_FLOW_YEAR = C.YEAR_CF_YEAR
                    //                    LEFT OUTER JOIN PLAN_YEAR_CF_FCF D ON C.SEQ = D.PLAN_YEAR_CF_SEQ AND A.CASH_FLOW_YEAR = D.YEARLY_YEAR AND A.MONTHLY = D.MONTHLY
                    //                    LEFT OUTER JOIN ORG_COMPANY E ON A.ORG_COMPANY_SEQ = E.SEQ
                    //                    LEFT OUTER JOIN ORG_UNION F ON E.ORG_UNION_SEQ = F.SEQ
                    //                    WHERE B.DIFF = @Diff				
                    //                    AND A.CASH_FLOW_YEAR = @Year	
                    //                    AND A.MONTHLY = @Month
                    //                    GROUP BY E.COMPANY_NAME, UNION_NAME, F.SEQ, E.SEQ
                    //                    ORDER BY F.SEQ, E.SEQ

                    //SELECT E.COMPANY_NAME, CONVERT(DECIMAL(12, 2), ROUND(CASE WHEN ISNULL(SUM(D.FCF2), 0) = 0 THEN 0

                    //                                                                           WHEN ISNULL(SUM(B.FCF2), 0) = 0 THEN 0
                    //                                                                      ELSE(ISNULL(SUM(B.FCF2), 0) / ISNULL(SUM(D.FCF2), 0)) * 100 END, 2)) AS 'KpiSignalRateFcf'
                    //                        ,UNION_NAME AS 'unionName'
                    //                    FROM PM_CASH_FLOW A
                    //                    LEFT OUTER JOIN PM_CASH_FLOW_CUMULATIVE B ON A.SEQ = B.PM_CASH_FLOW_SEQ AND B.DIFF = 20-- 실적
                    //                   LEFT OUTER JOIN PM_CASH_FLOW_CUMULATIVE D ON A.SEQ = D.PM_CASH_FLOW_SEQ AND D.DIFF = 10-- 계획
                    //                  LEFT OUTER JOIN ORG_COMPANY E ON A.ORG_COMPANY_SEQ = E.SEQ
                    //                    LEFT OUTER JOIN ORG_UNION F ON E.ORG_UNION_SEQ = F.SEQ
                    //                    WHERE 1 = 1
                    //                    AND A.CASH_FLOW_YEAR = @Year
                    //                    AND A.MONTHLY = @Month
                    //                    GROUP BY E.COMPANY_NAME, UNION_NAME, F.SEQ, E.SEQ
                    //                    ORDER BY F.SEQ, E.SEQ
                    //";

                    return con.Query<GroupMain>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }
        public IEnumerable<GroupMain> groupMainDisclosure(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    //2022.03.31 쿼리 수정
                   // string query = @"
                   //SELECT  E.SEQ AS companySeq,
                   //        E.COMPANY_NAME 
                   //        ,UNION_NAME      AS 'unionName'
                   //        ,E.ORD
                   //        ,A.REGIST_STATUS
                   // FROM    DISCLOSURE A
                   //         LEFT OUTER JOIN DISCLOSURE_DATA B 
                   // ON      A.CPN_SEQ = B.IDX_SEQ
                   // AND     B.PLAN_YN = 'Y' -- 실적
                   //         LEFT OUTER JOIN ORG_COMPANY E 
                   // ON      A.CPN_SEQ = E.SEQ
                   //         LEFT OUTER JOIN ORG_UNION F
                   // ON      E.ORG_UNION_SEQ = F.SEQ
                   // WHERE   1 = 1
                   // AND     A.YEAR = @Year	
                   // AND     A.MONTH = @Month
                   // AND     E.IS_USE = 'Y'
                   // AND     E.IS_DISCLOSURE = 'Y'
                   // AND     E.ORD IS NOT NULL
                   // --AND     A.REGIST_STATUS = 7
                   // GROUP BY E.COMPANY_NAME, UNION_NAME, F.SEQ,E.SEQ, E.ORD,A.REGIST_STATUS
                   // ORDER BY F.SEQ, E.ORD
                   // ";
                    string query = @"
                   SELECT  A.SEQ AS companySeq,
                            A.COMPANY_NAME 
                           ,F.UNION_NAME      AS 'unionName'
                           ,A.ORD
                    FROM    ORG_COMPANY A
                

                            LEFT OUTER JOIN ORG_UNION F
                    ON      A.ORG_UNION_SEQ = F.SEQ
                    WHERE   1 = 1
                  
                    AND     A.IS_DISCLOSURE = 'Y'
                    AND     A.ORD IS NOT NULL
                    GROUP BY A.COMPANY_NAME, UNION_NAME, F.SEQ,A.SEQ, A.ORD
                    ORDER BY F.SEQ, A.SEQ
                    ";
                    return con.Query<GroupMain>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<DisclosureDetail> groupMainDisclosureItem(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    //2022.03.31 쿼리 수정
                    string query = @"
                   SELECT 
                       A.SEQ AS DIS_ITEM_SEQ
                      ,A.DIS_NAME
                      ,B.SEQ AS DETAIL_SEQ
                      ,B.DETAIL_NAME
                  FROM DISCLOSURE_ITEM A
                  INNER JOIN DISCLOSURE_DETAIL B
                  ON A.SEQ  = B.DIS_ITEM_SEQ
                    ";

                    return con.Query<DisclosureDetail>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<DisclosureData> groupMainDisclosureData(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = @"
                                              SELECT  
                                                    A.DIS_SEQ
                                                   ,A.DIS_NAME
                                                   ,A.DETAIL_SEQ
                                                   ,A.DETAIL_NAME
                                                   ,MAX(T11_01)             AS T11_01
                                                   ,MAX(T11_02)             AS T11_02
                                                   ,SUM(T11_03)             AS T11_03
                                                   ,MAX(T12_01)             AS T12_01
                                                   ,MAX(T12_02)             AS T12_02
                                                   ,SUM(T12_03)             AS T12_03
                                                   ,MAX(T13_01)             AS T13_01
                                                   ,MAX(T13_02)             AS T13_02
                                                   ,SUM(T13_03)             AS T13_03
                                                   ,MAX(T14_01)             AS T14_01
                                                   ,MAX(T14_02)             AS T14_02
                                                   ,SUM(T14_03)             AS T14_03
                                                   ,MAX(T15_01)             AS T15_01
                                                   ,MAX(T15_02)             AS T15_02
                                                   ,SUM(T15_03)             AS T15_03
                                                   ,MAX(T16_01)             AS T16_01
                                                   ,MAX(T16_02)             AS T16_02
                                                   ,SUM(T16_03)             AS T16_03
                                                   ,MAX(T17_01)             AS T17_01
                                                   ,MAX(T17_02)             AS T17_02
                                                   ,SUM(T17_03)             AS T17_03
                                                   ,MAX(T18_01)             AS T18_01
                                                   ,MAX(T18_02)             AS T18_02
                                                   ,SUM(T18_03)             AS T18_03
                                                   ,MAX(T19_01)             AS T19_01
                                                   ,MAX(T19_02)             AS T19_02
                                                   ,SUM(T19_03)             AS T19_03
                                            FROM   (

                                                    SELECT  G.SEQ           AS DIS_SEQ
                                                           ,G.DIS_NAME      AS DIS_NAME
                                                           ,F.SEQ           AS DETAIL_SEQ
                                                           ,F.DETAIL_NAME   AS DETAIL_NAME
                                                           ,E.SEQ           AS TITLE_SEQ
                                                           ,E.TITLE         AS TITLE
                                                             
                                                           ,CASE WHEN A.IDX_SEQ =  1 THEN E.TITLE ELSE '' END        AS T11_01 -- 홀딩스(사업)
                                                           ,CASE WHEN A.IDX_SEQ =  1 THEN 'Y'          ELSE '' END   AS T11_02
                                                           ,CASE WHEN A.IDX_SEQ =  1 THEN A.TRANS_AMT  ELSE 0  END   AS T11_03
                                                           ,CASE WHEN A.IDX_SEQ =  2 THEN E.TITLE ELSE '' END        AS T12_01 -- 홀딩스(지주)
                                                           ,CASE WHEN A.IDX_SEQ =  2 THEN 'Y'          ELSE '' END   AS T12_02
                                                           ,CASE WHEN A.IDX_SEQ =  2 THEN A.TRANS_AMT  ELSE 0  END   AS T12_03
                                                           ,CASE WHEN A.IDX_SEQ =  7 THEN E.TITLE ELSE '' END        AS T13_01 -- JJ한라
                                                           ,CASE WHEN A.IDX_SEQ =  7 THEN 'Y'          ELSE '' END   AS T13_02
                                                           ,CASE WHEN A.IDX_SEQ =  7 THEN A.TRANS_AMT  ELSE 0  END   AS T13_03
                                                           ,CASE WHEN A.IDX_SEQ = 17 THEN E.TITLE ELSE '' END        AS T14_01 -- 리츠운용
                                                           ,CASE WHEN A.IDX_SEQ = 17 THEN 'Y'          ELSE '' END   AS T14_02
                                                           ,CASE WHEN A.IDX_SEQ = 17 THEN A.TRANS_AMT  ELSE 0  END   AS T14_03
                                                                      
                                                           ,CASE WHEN A.IDX_SEQ =  5 THEN E.TITLE ELSE '' END        AS T15_01 --브로제
                                                           ,CASE WHEN A.IDX_SEQ =  5 THEN 'Y'          ELSE '' END   AS T15_02
                                                           ,CASE WHEN A.IDX_SEQ =  5 THEN A.TRANS_AMT  ELSE 0  END   AS T15_03
                                                           ,CASE WHEN A.IDX_SEQ = 14 THEN E.TITLE ELSE '' END        AS T16_01 -- 만도(BU)
                                                           ,CASE WHEN A.IDX_SEQ = 14 THEN 'Y'          ELSE '' END   AS T16_02
                                                           ,CASE WHEN A.IDX_SEQ = 14 THEN A.TRANS_AMT  ELSE 0  END   AS T16_03
                                                           ,CASE WHEN A.IDX_SEQ = 19 THEN E.TITLE ELSE '' END        AS T17_01 -- 클레무브
                                                           ,CASE WHEN A.IDX_SEQ = 19 THEN 'Y'          ELSE '' END   AS T17_02
                                                           ,CASE WHEN A.IDX_SEQ = 19 THEN A.TRANS_AMT  ELSE 0  END   AS T17_03
                                                           ,CASE WHEN A.IDX_SEQ = 20 THEN E.TITLE ELSE '' END        AS T18_01 -- 만도(연결)
                                                           ,CASE WHEN A.IDX_SEQ = 20 THEN 'Y'          ELSE '' END   AS T18_02
                                                           ,CASE WHEN A.IDX_SEQ = 20 THEN A.TRANS_AMT  ELSE 0  END   AS T18_03
                                                           ,CASE WHEN A.IDX_SEQ =  6 THEN E.TITLE ELSE '' END        AS T19_01 -- (주)한라
                                                           ,CASE WHEN A.IDX_SEQ =  6 THEN 'Y'          ELSE '' END   AS T19_02
                                                           ,CASE WHEN A.IDX_SEQ =  6 THEN A.TRANS_AMT  ELSE 0  END   AS T19_03
                                                    FROM    DISCLOSURE_DATA A

                                                            INNER JOIN   DISCLOSURE C
                                                    ON      C.CPN_SEQ           = A.IDX_SEQ
                                                    AND     C.YEAR              = @Year
                                                    AND     C.MONTH             = @Month
                                                       
                                                            INNER JOIN   DISCLOSURE_TITLE  E
                                                    ON      E.DIS_CODE          = A.DIS_CODE
                                                            INNER JOIN   DISCLOSURE_DETAIL F
                                                    ON      F.SEQ          = E.DETAIL_SEQ
                                                   
                                                            INNER JOIN   DISCLOSURE_ITEM  G
                                                    ON      G.SEQ          = F.DIS_ITEM_SEQ
                                                    WHERE   C.REGIST_STATUS = 7
                                                    
                                                   ) A
                                            GROUP   BY
                                                     A.DIS_SEQ
                                                   , A.DIS_NAME
                                                   , A.DETAIL_SEQ
                                                   , A.DETAIL_NAME
                                                   , A.TITLE_SEQ
                                                   , A.TITLE

                                    ";
                    //string query = @"
                    //    SELECT  A.CPN_SEQ AS COMPANY_SEQ
                    //                       ,A.REGIST_STATUS
                    //                       ,E.DIS_NAME
                    //                       ,D.DETAIL_NAME
                    //                       ,C.TITLE
                    //                       ,B.TRANS_AMT
                    //                       ,B.DIS_CODE
                    //                       ,F.ORD
                    //                       ,F.COMPANY_NAME
                    //                       ,G.ORD
                    //                       ,G.UNION_NAME
                    //                FROM    DISCLOSURE A

                    //                        INNER JOIN DISCLOSURE_DATA B
                    //                ON      A.CPN_SEQ = B.IDX_SEQ

                    //                        LEFT JOIN DISCLOSURE_TITLE C
                    //                ON      C.DIS_CODE = B.DIS_CODE

                    //                        LEFT JOIN DISCLOSURE_DETAIL D
                    //                ON      D.SEQ = C.DETAIL_SEQ

                    //                        LEFT JOIN DISCLOSURE_ITEM E
                    //                ON      E.SEQ = D.DIS_ITEM_SEQ
                    //                        LEFT JOIN ORG_COMPANY F
                    //                ON      A.CPN_SEQ   = F.SEQ
                    //                        LEFT JOIN ORG_UNION G
                    //                ON      F.ORG_UNION_SEQ   = G.SEQ

                    //                WHERE   A.YEAR = '2022'
                    //                AND     A. MONTH = '05'

                    //                GROUP BY A.CPN_SEQ ,REGIST_STATUS,E.DIS_NAME
                    //                       ,D.DETAIL_NAME
                    //                       ,C.TITLE
                    //                       ,B.TRANS_AMT
                    //                       ,B.DIS_CODE,F.ORD,F.COMPANY_NAME ,G.ORD
                    //                       ,G.UNION_NAME
                    //                ORDER BY G.ORD,F.ORD ASC,COMPANY_SEQ,DIS_CODE 
                    //";
                    //string query = @" 
                    //                DECLARE @COMPANY TABLE (
                    //                        UNION_SEQ               INT
                    //                       , UNION_NAME              NVARCHAR(0200)
                    //                       , COMPANY_SEQ             INT             -- 회사키
                    //                       , COMPANY_NAME            NVARCHAR(0200) )

                    //                        INSERT  @COMPANY
                    //                        SELECT  A.SEQ               AS UNION_SEQ
                    //                               , A.UNION_NAME        AS UNION_NAME
                    //                               , B.SEQ               AS COMPANY_SEQ
                    //                               , B.COMPANY_NAME      AS COMPANY_NAME
                    //                        FROM    ORG_UNION A
                    //                                INNER JOIN  ORG_COMPANY B
                    //                        ON      B.ORG_UNION_SEQ     = A.SEQ
                    //                        AND     B.IS_DISCLOSURE     = 'Y'   
                    //                        WHERE   A.IS_USE            = 'Y'
                    //                        ORDER   BY
                    //                                A.SEQ, B.SEQ

 


                    //                        DECLARE @TITLE TABLE(
                    //                        DIS_SEQ                 INT
                    //                       ,DIS_NAME                NVARCHAR(0200)
                    //                       ,DETAIL_SEQ              INT
                    //                       ,DETAIL_NAME             NVARCHAR(0200)
                    //                       ,TITLE_SEQ               INT
                    //                       ,TITLE_NAME              NVARCHAR(0200)
                    //                       ,DIS_CODE                NVARCHAR(0030))

                    //                        INSERT  @TITLE
                    //                        SELECT  A.SEQ
                    //                               ,A.DIS_NAME
                    //                               ,B.SEQ
                    //                               ,B.DETAIL_NAME
                    //                               ,C.SEQ
                    //                               ,C.TITLE
                    //                               ,C.DIS_CODE
                    //                        FROM    DISCLOSURE_ITEM A
                    //                                INNER JOIN DISCLOSURE_DETAIL B
                    //                        ON      B.DIS_ITEM_SEQ      = A.SEQ
                    //                                INNER JOIN DISCLOSURE_TITLE C
                    //                        ON      C.DETAIL_SEQ        = B.SEQ


                    //                        SELECT  
                    //                               -- A.DIS_SEQ
                    //                                A.DIS_NAME
                    //                               ,A.DETAIL_SEQ
                    //                               ,A.DETAIL_NAME
                    //                               --,'                ' 
                    //                               ,MAX(T11_01)             AS T11_01
                    //                               ,MAX(T11_02)             AS T11_02
                    //                               ,SUM(T11_03)             AS T11_03
                    //                               ,MAX(T12_01)             AS T12_01
                    //                               ,MAX(T12_02)             AS T12_02
                    //                               ,SUM(T12_03)             AS T12_03
                    //                               ,MAX(T13_01)             AS T13_01
                    //                               ,MAX(T13_02)             AS T13_02
                    //                               ,SUM(T13_03)             AS T13_03
                    //                               ,MAX(T14_01)             AS T14_01
                    //                               ,MAX(T14_02)             AS T14_02
                    //                               ,SUM(T14_03)             AS T14_03
                    //                               ,MAX(T15_01)             AS T15_01
                    //                               ,MAX(T15_02)             AS T15_02
                    //                               ,SUM(T15_03)             AS T15_03
                    //                               ,MAX(T16_01)             AS T16_01
                    //                               ,MAX(T16_02)             AS T16_02
                    //                               ,SUM(T16_03)             AS T16_03
                    //                               ,MAX(T17_01)             AS T17_01
                    //                               ,MAX(T17_02)             AS T17_02
                    //                               ,SUM(T17_03)             AS T17_03
                    //                               ,MAX(T18_01)             AS T18_01
                    //                               ,MAX(T18_02)             AS T18_02
                    //                               ,SUM(T18_03)             AS T18_03
                    //                               ,MAX(T19_01)             AS T19_01
                    //                               ,MAX(T19_02)             AS T19_02
                    //                               ,SUM(T19_03)             AS T19_03
                    //                        FROM   (

                    //                                SELECT  E.DIS_SEQ
                    //                                       ,E.DIS_NAME
                    //                                       ,E.DETAIL_SEQ
                    //                                       ,E.DETAIL_NAME
                    //                                       ,E.TITLE_SEQ
                    //                                       ,E.TITLE_NAME
                    //                                       ,CASE WHEN A.COMPANY_SEQ =  1 THEN E.TITLE_NAME ELSE '' END      AS T11_01
                    //                                       ,CASE WHEN A.COMPANY_SEQ =  1 THEN 'Y'          ELSE '' END      AS T11_02
                    //                                       ,CASE WHEN A.COMPANY_SEQ =  1 THEN D.TRANS_AMT  ELSE 0  END      AS T11_03
                    //                                       ,CASE WHEN A.COMPANY_SEQ =  2 THEN E.TITLE_NAME ELSE '' END      AS T12_01
                    //                                       ,CASE WHEN A.COMPANY_SEQ =  2 THEN 'Y'          ELSE '' END      AS T12_02
                    //                                       ,CASE WHEN A.COMPANY_SEQ =  2 THEN D.TRANS_AMT  ELSE 0  END      AS T12_03
                    //                                       ,CASE WHEN A.COMPANY_SEQ =  7 THEN E.TITLE_NAME ELSE '' END      AS T13_01
                    //                                       ,CASE WHEN A.COMPANY_SEQ =  7 THEN 'Y'          ELSE '' END      AS T13_02
                    //                                       ,CASE WHEN A.COMPANY_SEQ =  7 THEN D.TRANS_AMT  ELSE 0  END      AS T13_03
                    //                                       ,CASE WHEN A.COMPANY_SEQ = 17 THEN E.TITLE_NAME ELSE '' END      AS T14_01
                    //                                       ,CASE WHEN A.COMPANY_SEQ = 17 THEN 'Y'          ELSE '' END      AS T14_02
                    //                                       ,CASE WHEN A.COMPANY_SEQ = 17 THEN D.TRANS_AMT  ELSE 0  END      AS T14_03

                    //                                       ,CASE WHEN A.COMPANY_SEQ =  5 THEN E.TITLE_NAME ELSE '' END      AS T15_01
                    //                                       ,CASE WHEN A.COMPANY_SEQ =  5 THEN 'Y'          ELSE '' END      AS T15_02
                    //                                       ,CASE WHEN A.COMPANY_SEQ =  5 THEN D.TRANS_AMT  ELSE 0  END      AS T15_03
                    //                                       ,CASE WHEN A.COMPANY_SEQ = 14 THEN E.TITLE_NAME ELSE '' END      AS T16_01
                    //                                       ,CASE WHEN A.COMPANY_SEQ = 14 THEN 'Y'          ELSE '' END      AS T16_02
                    //                                       ,CASE WHEN A.COMPANY_SEQ = 14 THEN D.TRANS_AMT  ELSE 0  END      AS T16_03
                    //                                       ,CASE WHEN A.COMPANY_SEQ = 19 THEN E.TITLE_NAME ELSE '' END      AS T17_01
                    //                                       ,CASE WHEN A.COMPANY_SEQ = 19 THEN 'Y'          ELSE '' END      AS T17_02
                    //                                       ,CASE WHEN A.COMPANY_SEQ = 19 THEN D.TRANS_AMT  ELSE 0  END      AS T17_03
                    //                                       ,CASE WHEN A.COMPANY_SEQ = 20 THEN E.TITLE_NAME ELSE '' END      AS T18_01
                    //                                       ,CASE WHEN A.COMPANY_SEQ = 20 THEN 'Y'          ELSE '' END      AS T18_02
                    //                                       ,CASE WHEN A.COMPANY_SEQ = 20 THEN D.TRANS_AMT  ELSE 0  END      AS T18_03

                    //                                       ,CASE WHEN A.COMPANY_SEQ =  6 THEN E.TITLE_NAME ELSE '' END      AS T19_01
                    //                                       ,CASE WHEN A.COMPANY_SEQ =  6 THEN 'Y'          ELSE '' END      AS T19_02
                    //                                       ,CASE WHEN A.COMPANY_SEQ =  6 THEN D.TRANS_AMT  ELSE 0  END      AS T19_03
                    //                                FROM    @COMPANY A

                    //                                        LEFT JOIN   DISCLOSURE C
                    //                                ON      C.CPN_SEQ           = A.COMPANY_SEQ
                    //                                AND     C.YEAR              = '2022'
                    //                                AND     C.MONTH             = '05'
                    //                                        LEFT JOIN   DISCLOSURE_DATA D
                    //                                ON      D.IDX_SEQ           = C.IDX
                    //                                        LEFT JOIN   @TITLE E
                    //                                ON      E.DIS_CODE          = D.DIS_CODE
                    //                                WHERE   E.TITLE_NAME != ''
                    //                                --AND     C.REGIST_STATUS = 7
                    //                               ) A
                    //                        GROUP   BY
                    //                                 A.DIS_SEQ
                    //                               , A.DIS_NAME
                    //                               , A.DETAIL_SEQ
                    //                               , A.DETAIL_NAME
                    //                               , A.TITLE_SEQ
                    //                               , A.TITLE_NAME

                    //                                                            ";

                    return con.Query<DisclosureData>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }
        public IEnumerable<DisclosureData> CompanyDisclosureData(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" 
                                 SELECT  
                                             A.DIS_NAME
                                            ,A.DETAIL_NAME
                                            ,MAX(JAN_01)                 AS JAN_01
                                            ,MAX(JAN_02)                 AS JAN_02
                                            ,SUM(JAN_03)                 AS JAN_03
                                            ,MAX(FEB_01)                 AS FEB_01
                                            ,MAX(FEB_02)                 AS FEB_02
                                            ,SUM(FEB_03)                 AS FEB_03
                                            ,MAX(MAR_01)                 AS MAR_01
                                            ,MAX(MAR_02)                 AS MAR_02
                                            ,SUM(MAR_03)                 AS MAR_03
                                            ,MAX(APR_01)                 AS APR_01                              
                                            ,MAX(APR_02)                 AS APR_02
                                            ,SUM(APR_03)                 AS APR_03
                                            ,MAX(MAY_01)                 AS MAY_01                              
                                            ,MAX(MAY_02)                 AS MAY_02
                                            ,SUM(MAY_03)                 AS MAY_03
                                            ,MAX(JUN_01)                 AS JUN_01
                                            ,MAX(JUN_02)                 AS JUN_02
                                            ,SUM(JUN_03)                 AS JUN_03
                                            ,MAX(JUL_01)                 AS JUL_01
                                            ,MAX(JUL_02)                 AS JUL_02
                                            ,SUM(JUL_03)                 AS JUL_03
                                            ,MAX(AUG_01)                 AS AUG_01
                                            ,MAX(AUG_02)                 AS AUG_02
                                            ,SUM(AUG_03)                 AS AUG_03
                                            ,MAX(SEP_01)                 AS SEP_01
                                            ,MAX(SEP_02)                 AS SEP_02
                                            ,SUM(SEP_03)                 AS SEP_03
                                            ,MAX(OCT_01)                 AS OCT_01
                                            ,MAX(OCT_02)                 AS OCT_02
                                            ,SUM(OCT_03)                 AS OCT_03
                                            ,MAX(NOV_01)                 AS NOV_01
                                            ,MAX(NOV_02)                 AS NOV_02
                                            ,SUM(NOV_03)                 AS NOV_03
                                            ,MAX(DEC_01)                 AS DEC_01
                                            ,MAX(DEC_02)                 AS DEC_02
                                            ,SUM(DEC_03)                 AS DEC_03
                                    FROM   (

                                            SELECT   G.SEQ           AS DIS_SEQ
                                                    ,G.DIS_NAME      AS DIS_NAME
                                                    ,F.SEQ           AS DETAIL_SEQ
                                                    ,F.DETAIL_NAME   AS DETAIL_NAME
                                                    ,E.SEQ           AS TITLE_SEQ
                                                    ,E.TITLE         AS TITLE
                                                    ,CASE WHEN A.IDX_SEQ =  @Seq AND A.MONTH = 01 THEN E.TITLE      ELSE '' END      AS JAN_01
                                                    ,CASE WHEN A.IDX_SEQ =  @Seq AND A.MONTH = 01 THEN 'Y'          ELSE '' END      AS JAN_02
                                                    ,CASE WHEN A.IDX_SEQ =  @Seq AND A.MONTH = 01 THEN A.TRANS_AMT  ELSE 0  END      AS JAN_03
                                                    ,CASE WHEN A.IDX_SEQ =  @Seq AND A.MONTH = 02 THEN E.TITLE      ELSE '' END      AS FEB_01
                                                    ,CASE WHEN A.IDX_SEQ =  @Seq AND A.MONTH = 02 THEN 'Y'          ELSE '' END      AS FEB_02
                                                    ,CASE WHEN A.IDX_SEQ =  @Seq AND A.MONTH = 02 THEN A.TRANS_AMT  ELSE 0  END      AS FEB_03
                                                    ,CASE WHEN A.IDX_SEQ =  @Seq AND A.MONTH = 03 THEN E.TITLE      ELSE '' END      AS MAR_01
                                                    ,CASE WHEN A.IDX_SEQ =  @Seq AND A.MONTH = 03 THEN 'Y'          ELSE '' END      AS MAR_02
                                                    ,CASE WHEN A.IDX_SEQ =  @Seq AND A.MONTH = 03 THEN A.TRANS_AMT  ELSE 0  END      AS MAR_03   
                                                    ,CASE WHEN A.IDX_SEQ =  @Seq AND A.MONTH = 04 THEN E.TITLE      ELSE '' END      AS APR_01
                                                    ,CASE WHEN A.IDX_SEQ =  @Seq AND A.MONTH = 04 THEN 'Y'          ELSE '' END      AS APR_02
                                                    ,CASE WHEN A.IDX_SEQ =  @Seq AND A.MONTH = 04 THEN A.TRANS_AMT  ELSE 0  END      AS APR_03
                                                    ,CASE WHEN A.IDX_SEQ =  @Seq AND A.MONTH = 05 THEN E.TITLE      ELSE '' END      AS MAY_01
                                                    ,CASE WHEN A.IDX_SEQ =  @Seq AND A.MONTH = 05 THEN 'Y'          ELSE '' END      AS MAY_02
                                                    ,CASE WHEN A.IDX_SEQ =  @Seq AND A.MONTH = 05 THEN A.TRANS_AMT  ELSE 0  END      AS MAY_03
                                                    ,CASE WHEN A.IDX_SEQ =  @Seq AND A.MONTH = 06 THEN E.TITLE      ELSE '' END      AS JUN_01
                                                    ,CASE WHEN A.IDX_SEQ =  @Seq AND A.MONTH = 06 THEN 'Y'          ELSE '' END      AS JUN_02
                                                    ,CASE WHEN A.IDX_SEQ =  @Seq AND A.MONTH = 06 THEN A.TRANS_AMT  ELSE 0  END      AS JUN_03
                                                    ,CASE WHEN A.IDX_SEQ =  @Seq AND A.MONTH = 07 THEN E.TITLE      ELSE '' END      AS JUL_01
                                                    ,CASE WHEN A.IDX_SEQ =  @Seq AND A.MONTH = 07 THEN 'Y'          ELSE '' END      AS JUL_02
                                                    ,CASE WHEN A.IDX_SEQ =  @Seq AND A.MONTH = 07 THEN A.TRANS_AMT  ELSE 0  END      AS JUL_03
                                                    ,CASE WHEN A.IDX_SEQ =  @Seq AND A.MONTH = 08 THEN E.TITLE      ELSE '' END      AS AUG_01
                                                    ,CASE WHEN A.IDX_SEQ =  @Seq AND A.MONTH = 08 THEN 'Y'          ELSE '' END      AS AUG_02
                                                    ,CASE WHEN A.IDX_SEQ =  @Seq AND A.MONTH = 08 THEN A.TRANS_AMT  ELSE 0  END      AS AUG_03
                                                    ,CASE WHEN A.IDX_SEQ =  @Seq AND A.MONTH = 09 THEN E.TITLE      ELSE '' END      AS SEP_01
                                                    ,CASE WHEN A.IDX_SEQ =  @Seq AND A.MONTH = 09 THEN 'Y'          ELSE '' END      AS SEP_02
                                                    ,CASE WHEN A.IDX_SEQ =  @Seq AND A.MONTH = 09 THEN A.TRANS_AMT  ELSE 0  END      AS SEP_03
                                                    ,CASE WHEN A.IDX_SEQ =  @Seq AND A.MONTH = 10 THEN E.TITLE      ELSE '' END      AS OCT_01
                                                    ,CASE WHEN A.IDX_SEQ =  @Seq AND A.MONTH = 10 THEN 'Y'          ELSE '' END      AS OCT_02
                                                    ,CASE WHEN A.IDX_SEQ =  @Seq AND A.MONTH = 10 THEN A.TRANS_AMT  ELSE 0  END      AS OCT_03
                                                    ,CASE WHEN A.IDX_SEQ =  @Seq AND A.MONTH = 11 THEN E.TITLE      ELSE '' END      AS NOV_01
                                                    ,CASE WHEN A.IDX_SEQ =  @Seq AND A.MONTH = 11 THEN 'Y'          ELSE '' END      AS NOV_02
                                                    ,CASE WHEN A.IDX_SEQ =  @Seq AND A.MONTH = 11 THEN A.TRANS_AMT  ELSE 0  END      AS NOV_03
                                                    ,CASE WHEN A.IDX_SEQ =  @Seq AND A.MONTH = 12 THEN E.TITLE      ELSE '' END      AS DEC_01
                                                    ,CASE WHEN A.IDX_SEQ =  @Seq AND A.MONTH = 12 THEN 'Y'          ELSE '' END      AS DEC_02
                                                    ,CASE WHEN A.IDX_SEQ =  @Seq AND A.MONTH = 12 THEN A.TRANS_AMT  ELSE 0  END      AS DEC_03
                  
                                            FROM    DISCLOSURE_DATA A

                                                    INNER JOIN   DISCLOSURE C
                                            ON      C.CPN_SEQ           = A.IDX_SEQ
       
                                                    INNER JOIN   DISCLOSURE_TITLE  E
                                            ON      E.DIS_CODE          = A.DIS_CODE
                                                    INNER JOIN   DISCLOSURE_DETAIL F
                                            ON      F.SEQ          = E.DETAIL_SEQ
                                                   
                                                    INNER JOIN   DISCLOSURE_ITEM  G
                                            ON      G.SEQ          = F.DIS_ITEM_SEQ

                                            WHERE   A.YEAR = @Year
                                            AND     C.REGIST_STATUS = 7
                                            AND     A.IDX_SEQ =  @Seq

                                            ) A
                                    GROUP   BY
                                             A.DIS_SEQ
                                            ,A.DIS_NAME
                                            ,A.DETAIL_SEQ
                                            ,A.DETAIL_NAME
                                            ,A.TITLE_SEQ
                                            ,A.TITLE


                                        ";

                    return con.Query<DisclosureData>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }
        /// <summary>
        /// 2018.12.17 엔컴과 배당회사 데이터는 그룹합산에서는 보여야 하기에 여기서는 모든 데이터를 가져오게 변경
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        public IEnumerable<GroupMain> groupMainKpiSignal(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    //2022.03.31 쿼리 수정
                    string query = @"SELECT *
                                        FROM
                                        (
                                            SELECT '10' AS 'KpiKind'
                                                    ,E.SEQ
                                                    ,E.SEQ AS 'companySeq'
			                                        ,E.ORG_UNION_SEQ
			                                        ,SUM(B.SALES)				AS 'kpiResultSales'
			                                        ,SUM(D.SALES)				AS 'kpiPlanSales'
			                                        ,SUM(B.EBIT)				AS 'kpiResultEbit'
			                                        ,SUM(D.EBIT)				AS 'kpiPlanEbit'
			                                        ,SUM(B.PBT)					AS 'kpiResultPbt'
			                                        ,SUM(D.PBT)					AS 'kpiPlanPbt'
                                                    ,UNION_NAME					AS 'unionName'
                                                    ,COMPANY_NAME
                                                    ,E.IS_USE
                                                    ,E.ORD
                                            FROM PM_PAL A
                                            LEFT OUTER JOIN PM_PAL_SUMMARY B ON A.SEQ = B.PM_PAL_SEQ
                                            LEFT OUTER JOIN PLAN_MONTHLY_PAL C ON A.ORG_COMPANY_SEQ = C.ORG_COMPANY_SEQ AND A.PAL_YEAR = C.MONTHLY_PAL_YEAR
                                            LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS_MONTHLY_SUM D ON C.SEQ = D.PLAN_MONTHLY_PAL_SEQ AND A.MONTHLY = D.MONTHLY
                                            LEFT OUTER JOIN ORG_COMPANY E ON A.ORG_COMPANY_SEQ = E.SEQ
                                            LEFT OUTER JOIN ORG_UNION F ON E.ORG_UNION_SEQ = F.SEQ
                                            WHERE B.MONTHLY_TYPE = @MonthlyTypeFirst
                                            AND A.PAL_YEAR = @Year
                                            AND A.MONTHLY = @Month
	                                        AND E.IS_USE = 'Y'
                                          
                                            GROUP BY UNION_NAME, COMPANY_NAME, E.SEQ, E.ORG_UNION_SEQ, E.IS_USE ,E.ORD
                                            UNION
                                            SELECT '20' AS 'KpiKind'
                                                    ,E.SEQ
                                                    ,E.SEQ AS 'companySeq'
			                                        ,E.ORG_UNION_SEQ
                                                    ,SUM(B.SALES)				AS 'kpiResultSales'
			                                        ,SUM(D.SALES)				AS 'kpiPlanSales'
			                                        ,SUM(B.EBIT)				AS 'kpiResultEbit'
			                                        ,SUM(D.EBIT)				AS 'kpiPlanEbit'
			                                        ,SUM(B.PBT)					AS 'kpiResultPbt'
			                                        ,SUM(D.PBT)					AS 'kpiPlanPbt'
                                                    ,UNION_NAME                                                                   AS 'unionName'
                                                    ,COMPANY_NAME
                                                    ,E.IS_USE
                                                    ,E.ORD
                                            FROM PM_PAL A
                                            LEFT OUTER JOIN PM_PAL_SUMMARY B ON A.SEQ = B.PM_PAL_SEQ
                                            LEFT OUTER JOIN PLAN_MONTHLY_PAL C ON A.ORG_COMPANY_SEQ = C.ORG_COMPANY_SEQ AND A.PAL_YEAR = C.MONTHLY_PAL_YEAR
                                            LEFT OUTER JOIN(
                                                SELECT B.PLAN_MONTHLY_PAL_SEQ
                                                        ,A.MONTHLY_PAL_YEAR
                                                        ,A.ORG_COMPANY_SEQ
                                                        ,@Month AS MONTHLY
                                                        ,ISNULL(SUM(B.SALES),0) AS SALES
                                                        ,ISNULL(SUM(B.EBIT),0)  AS EBIT
                                                        ,ISNULL(SUM(B.PBT),0)   AS PBT

                                                FROM PLAN_MONTHLY_PAL A
                                                LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS_MONTHLY_SUM B ON A.SEQ = B.PLAN_MONTHLY_PAL_SEQ
                                                WHERE A.MONTHLY_PAL_YEAR = @Year
                                                AND	B.MONTHLY <= @Month
                                                GROUP BY B.PLAN_MONTHLY_PAL_SEQ, A.MONTHLY_PAL_YEAR, A.ORG_COMPANY_SEQ
                                            ) D ON C.SEQ = D.PLAN_MONTHLY_PAL_SEQ
                                            LEFT OUTER JOIN ORG_COMPANY E ON A.ORG_COMPANY_SEQ = E.SEQ
                                            LEFT OUTER JOIN ORG_UNION F ON E.ORG_UNION_SEQ = F.SEQ
                                            WHERE B.MONTHLY_TYPE = @MonthlyTypeSecond
                                            AND A.PAL_YEAR = @Year
                                            AND A.MONTHLY = @Month
	                                        AND E.IS_USE = 'Y'
                                           
                                            GROUP BY UNION_NAME, COMPANY_NAME, E.SEQ, E.ORG_UNION_SEQ, E.IS_USE ,E.ORD
                                        ) A
                                        ORDER BY KpiKind DESC, ORG_UNION_SEQ, A.ORD";
                    //string query = @" 
                    //                SELECT *
                    //                FROM
                    //                (
                    //                    SELECT '10' AS 'KpiKind'
                    //                            ,E.SEQ
                    //                            ,E.SEQ AS 'companySeq'
			                 //                   ,E.ORG_UNION_SEQ
			                 //                   ,SUM(B.SALES)				AS 'kpiResultSales'
			                 //                   ,SUM(D.SALES)				AS 'kpiPlanSales'
			                 //                   ,SUM(B.EBIT)				AS 'kpiResultEbit'
			                 //                   ,SUM(D.EBIT)				AS 'kpiPlanEbit'
			                 //                   ,SUM(B.PBT)					AS 'kpiResultPbt'
			                 //                   ,SUM(D.PBT)					AS 'kpiPlanPbt'
                    //                            ,UNION_NAME					AS 'unionName'
                    //                            ,COMPANY_NAME
                    //                            ,E.IS_USE
                    //                    FROM PM_PAL A
                    //                    LEFT OUTER JOIN PM_PAL_SUMMARY B ON A.SEQ = B.PM_PAL_SEQ
                    //                    LEFT OUTER JOIN PLAN_MONTHLY_PAL C ON A.ORG_COMPANY_SEQ = C.ORG_COMPANY_SEQ AND A.PAL_YEAR = C.MONTHLY_PAL_YEAR
                    //                    LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS_MONTHLY_SUM D ON C.SEQ = D.PLAN_MONTHLY_PAL_SEQ AND A.MONTHLY = D.MONTHLY
                    //                    LEFT OUTER JOIN ORG_COMPANY E ON A.ORG_COMPANY_SEQ = E.SEQ
                    //                    LEFT OUTER JOIN ORG_UNION F ON E.ORG_UNION_SEQ = F.SEQ
                    //                    WHERE B.MONTHLY_TYPE = @MonthlyTypeFirst
                    //                    AND A.PAL_YEAR = @Year
                    //                    AND A.MONTHLY = @Month
	                   //                 --AND E.IS_USE = 'Y'
                    //                    GROUP BY UNION_NAME, COMPANY_NAME, E.SEQ, E.ORG_UNION_SEQ, E.IS_USE
                    //                    UNION
                    //                    SELECT '20' AS 'KpiKind'
                    //                            ,E.SEQ
                    //                            ,E.SEQ AS 'companySeq'
			                 //                   , E.ORG_UNION_SEQ
                    //                            ,SUM(B.SALES)				AS 'kpiResultSales'
			                 //                   ,SUM(D.SALES)				AS 'kpiPlanSales'
			                 //                   ,SUM(B.EBIT)				AS 'kpiResultEbit'
			                 //                   ,SUM(D.EBIT)				AS 'kpiPlanEbit'
			                 //                   ,SUM(B.PBT)					AS 'kpiResultPbt'
			                 //                   ,SUM(D.PBT)					AS 'kpiPlanPbt'
                    //                            ,UNION_NAME                                                                   AS 'unionName'
                    //                            ,COMPANY_NAME
                    //                            ,E.IS_USE
                    //                    FROM PM_PAL A
                    //                    LEFT OUTER JOIN PM_PAL_SUMMARY B ON A.SEQ = B.PM_PAL_SEQ
                    //                    LEFT OUTER JOIN PLAN_MONTHLY_PAL C ON A.ORG_COMPANY_SEQ = C.ORG_COMPANY_SEQ AND A.PAL_YEAR = C.MONTHLY_PAL_YEAR
                    //                    LEFT OUTER JOIN(
                    //                        SELECT B.PLAN_MONTHLY_PAL_SEQ
                    //                                ,A.MONTHLY_PAL_YEAR
                    //                                ,A.ORG_COMPANY_SEQ
                    //                                ,@Month AS MONTHLY
                    //                                ,ISNULL(SUM(B.SALES),0) AS SALES
                    //                                ,ISNULL(SUM(B.EBIT),0)  AS EBIT
                    //                                ,ISNULL(SUM(B.PBT),0)   AS PBT
                    //                        FROM PLAN_MONTHLY_PAL A
                    //                        LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS_MONTHLY_SUM B ON A.SEQ = B.PLAN_MONTHLY_PAL_SEQ
                    //                        WHERE A.MONTHLY_PAL_YEAR = @Year
                    //                        AND	B.MONTHLY <= @Month
                    //                        GROUP BY B.PLAN_MONTHLY_PAL_SEQ, A.MONTHLY_PAL_YEAR, A.ORG_COMPANY_SEQ
                    //                    ) D ON C.SEQ = D.PLAN_MONTHLY_PAL_SEQ
                    //                    LEFT OUTER JOIN ORG_COMPANY E ON A.ORG_COMPANY_SEQ = E.SEQ
                    //                    LEFT OUTER JOIN ORG_UNION F ON E.ORG_UNION_SEQ = F.SEQ
                    //                    WHERE B.MONTHLY_TYPE = @MonthlyTypeSecond
                    //                    AND A.PAL_YEAR = @Year
                    //                    AND A.MONTHLY = @Month
	                   //                 --AND E.IS_USE = 'Y'
                    //                    GROUP BY UNION_NAME, COMPANY_NAME, E.SEQ, E.ORG_UNION_SEQ, E.IS_USE
                    //                ) A
                    //                ORDER BY KpiKind DESC, ORG_UNION_SEQ, SEQ ";

                    return con.Query<GroupMain>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<GroupMain> groupMainKpiSignalLiabilities(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    //2022.03.31 쿼리 수정
                    string query = @"SELECT	*
                                    FROM	(
                                    SELECT	A.BS_YEAR               AS YEAR
		                                    , A.MONTHLY
		                                    , A.ORG_COMPANY_SEQ
                                            , E.SEQ                  AS 'companySeq'
		                                    , E.ORG_UNION_SEQ
		                                    , E.COMPANY_NAME
		                                    , B.LIABILITIES         AS 'resultLiabilities'
		                                    , B.CAPITAL             AS 'resultCapital'
		                                    --, CASE WHEN B.CAPITAL = 0 THEN 0 ELSE CONVERT(DECIMAL(12, 2), ROUND(B.LIABILITIES / B.CAPITAL * 100, 2)) END F01
		                                    , D.LIABILITIES         AS 'planLiabilities'
		                                    , D.CAPITAL             AS 'planCapital'
		                                    --, CASE WHEN D.CAPITAL = 0 THEN 0 ELSE CONVERT(DECIMAL(12, 2), ROUND(D.LIABILITIES / D.CAPITAL * 100, 2)) END F03
                                            , F.AFTER_TAX_OPERATION_PROFIT
		                                    , F.PAIN_IN_CAPITAL
		                                    , CASE WHEN F.PAIN_IN_CAPITAL = 0 THEN 0
			                                    ELSE CONVERT(DECIMAL(12, 2), ROUND(F.AFTER_TAX_OPERATION_PROFIT / F.PAIN_IN_CAPITAL * 100, 2)) END AS KPI_ROIC
		                                    , G.AFTER_TAX_OPERATION_PROFIT	AS PLAN_AFTER_TAX_OPERATION_PROFIT
		                                    , G.PAIN_IN_CAPITAL				AS PLAN_PAIN_IN_CAPITAL
		                                    , CASE WHEN G.PAIN_IN_CAPITAL = 0 THEN 0
			                                    ELSE CONVERT(DECIMAL(12, 2), ROUND(G.AFTER_TAX_OPERATION_PROFIT / G.PAIN_IN_CAPITAL * 100, 2)) END AS KPI_PLAN_ROIC
                                            ,E.ORD
                                    FROM	PM_BS						A
                                    LEFT OUTER JOIN PM_BS_SUMMARY		B ON A.SEQ = B.PM_BS_SEQ
                                    LEFT OUTER JOIN PLAN_YEAR_BS		C ON A.ORG_COMPANY_SEQ = C.ORG_COMPANY_SEQ AND A.BS_YEAR = C.YEAR_BS_YEAR
                                    LEFT OUTER JOIN PLAN_YEAR_BS_BSHEET	D ON C.SEQ = D.PLAN_YEAR_BS_SEQ AND A.BS_YEAR = D.YEARLY_YEAR AND A.MONTHLY = D.MONTHLY
                                    LEFT OUTER JOIN PM_BS_ROIC			F ON A.SEQ = F.PM_BS_SEQ
                                    LEFT OUTER JOIN ORG_COMPANY E ON A.ORG_COMPANY_SEQ = E.SEQ
                                    LEFT OUTER JOIN (
	                                    SELECT	A.ORG_COMPANY_SEQ
			                                    , A.YEAR_BS_YEAR
			                                    , B.MONTHLY
			                                    , B.AFTER_TAX_OPERATION_PROFIT
			                                    , B.PAIN_IN_CAPITAL
	                                    FROM	PLAN_YEAR_BS					A
	                                    LEFT OUTER JOIN PLAN_YEAR_BS_ROIC		B ON A.SEQ = B.PLAN_YEAR_BS_SEQ
	                                    WHERE	1 = 1
	                                    AND		A.YEAR_BS_YEAR = @Year
	                                    AND		B.MONTHLY = @Month
                                    )			G ON A.BS_YEAR = G.YEAR_BS_YEAR AND A.MONTHLY = G.MONTHLY AND A.ORG_COMPANY_SEQ = G.ORG_COMPANY_SEQ
                                    WHERE	1 = 1
                                    AND		A.BS_YEAR = @Year
                                    AND		A.MONTHLY = @Month
                                    AND     E.IS_USE = 'Y'
                                 
                                    ) A
                                    ORDER BY A.ORG_UNION_SEQ ,A.ORD
                                    ";
                    //string query = @"
                    //                SELECT	*
                    //                FROM	(
                    //                SELECT	A.BS_YEAR               AS YEAR
		                  //                  , A.MONTHLY
		                  //                  , A.ORG_COMPANY_SEQ
                    //                        , E.SEQ                  AS 'companySeq'
		                  //                  , E.ORG_UNION_SEQ
		                  //                  , E.COMPANY_NAME
		                  //                  , B.LIABILITIES         AS 'resultLiabilities'
		                  //                  , B.CAPITAL             AS 'resultCapital'
		                  //                  --, CASE WHEN B.CAPITAL = 0 THEN 0 ELSE CONVERT(DECIMAL(12, 2), ROUND(B.LIABILITIES / B.CAPITAL * 100, 2)) END F01
		                  //                  , D.LIABILITIES         AS 'planLiabilities'
		                  //                  , D.CAPITAL             AS 'planCapital'
		                  //                  --, CASE WHEN D.CAPITAL = 0 THEN 0 ELSE CONVERT(DECIMAL(12, 2), ROUND(D.LIABILITIES / D.CAPITAL * 100, 2)) END F03
                    //                        , F.AFTER_TAX_OPERATION_PROFIT
		                  //                  , F.PAIN_IN_CAPITAL
		                  //                  , CASE WHEN F.PAIN_IN_CAPITAL = 0 THEN 0
			                 //                   ELSE CONVERT(DECIMAL(12, 2), ROUND(F.AFTER_TAX_OPERATION_PROFIT / F.PAIN_IN_CAPITAL * 100, 2)) END AS KPI_ROIC
		                  //                  , G.AFTER_TAX_OPERATION_PROFIT	AS PLAN_AFTER_TAX_OPERATION_PROFIT
		                  //                  , G.PAIN_IN_CAPITAL				AS PLAN_PAIN_IN_CAPITAL
		                  //                  , CASE WHEN G.PAIN_IN_CAPITAL = 0 THEN 0
			                 //                   ELSE CONVERT(DECIMAL(12, 2), ROUND(G.AFTER_TAX_OPERATION_PROFIT / G.PAIN_IN_CAPITAL * 100, 2)) END AS KPI_PLAN_ROIC
                    //                FROM	PM_BS						A
                    //                LEFT OUTER JOIN PM_BS_SUMMARY		B ON A.SEQ = B.PM_BS_SEQ
                    //                LEFT OUTER JOIN PLAN_YEAR_BS		C ON A.ORG_COMPANY_SEQ = C.ORG_COMPANY_SEQ AND A.BS_YEAR = C.YEAR_BS_YEAR
                    //                LEFT OUTER JOIN PLAN_YEAR_BS_BSHEET	D ON C.SEQ = D.PLAN_YEAR_BS_SEQ AND A.BS_YEAR = D.YEARLY_YEAR AND A.MONTHLY = D.MONTHLY
                    //                LEFT OUTER JOIN PM_BS_ROIC			F ON A.SEQ = F.PM_BS_SEQ
                    //                LEFT OUTER JOIN ORG_COMPANY E ON A.ORG_COMPANY_SEQ = E.SEQ
                    //                LEFT OUTER JOIN (
	                   //                 SELECT	A.ORG_COMPANY_SEQ
			                 //                   , A.YEAR_BS_YEAR
			                 //                   , B.MONTHLY
			                 //                   , B.AFTER_TAX_OPERATION_PROFIT
			                 //                   , B.PAIN_IN_CAPITAL
	                   //                 FROM	PLAN_YEAR_BS					A
	                   //                 LEFT OUTER JOIN PLAN_YEAR_BS_ROIC		B ON A.SEQ = B.PLAN_YEAR_BS_SEQ
	                   //                 WHERE	1 = 1
	                   //                 AND		A.YEAR_BS_YEAR = @Year
	                   //                 AND		B.MONTHLY = @Month
                    //                )			G ON A.BS_YEAR = G.YEAR_BS_YEAR AND A.MONTHLY = G.MONTHLY AND A.ORG_COMPANY_SEQ = G.ORG_COMPANY_SEQ
                    //                WHERE	1 = 1
                    //                AND		A.BS_YEAR = @Year
                    //                AND		A.MONTHLY = @Month
                    //                AND     E.IS_USE = 'Y'
                    //                ) A
                    //                ORDER BY A.ORG_UNION_SEQ, A.ORG_COMPANY_SEQ
                    //                ";

                    //string query = @" SELECT CONVERT(DECIMAL(12,2), ROUND(CASE WHEN ISNULL(F01, 0) = 0 THEN 0 
										          //                             WHEN ISNULL(F03, 0) = 0 THEN 0
                    //                                                      ELSE (F01 / F03 * 100)  END, 2)) AS 'KpiSignalLiabilitiesRate' 
                    //                        ,COMPANY_NAME
                    //                    FROM(
	                   //                     SELECT CONVERT(DECIMAL(12,2), ROUND(CASE WHEN ISNULL(B.LIABILITIES, 0) = 0 THEN 0 
											         //                                WHEN ISNULL(B.CAPITAL, 0) = 0 THEN 0
										          //                              ELSE (B.LIABILITIES / B.CAPITAL) * 100 END, 2)) AS 'F01'
		                  //                        ,ISNULL(B.LIABILITIES_RATE, 0) AS 'F03'
		                  //                        ,COMPANY_NAME
	                   //                     FROM PM_BS A
	                   //                     LEFT OUTER JOIN PM_BS_SUMMARY B ON A.SEQ = B.PM_BS_SEQ
	                   //                     LEFT OUTER JOIN PLAN_YEAR_BS C ON A.ORG_COMPANY_SEQ = C.ORG_COMPANY_SEQ AND A.BS_YEAR = C.YEAR_BS_YEAR
	                   //                     LEFT OUTER JOIN PLAN_YEAR_BS_SUMMARY D ON C.SEQ = D.PLAN_YEAR_BS_SEQ AND A.BS_YEAR = D.YEARLY_YEAR 
	                   //                     LEFT OUTER JOIN ORG_COMPANY E ON A.ORG_COMPANY_SEQ = E.SEQ
	                   //                     WHERE A.BS_YEAR = @Year
	                   //                     AND A.MONTHLY = @Month
                    //                    )A ";

                    return con.Query<GroupMain>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        #endregion

        #region << 손익 목표 달성 현황(KPI X-Y Graph) >>

        public IEnumerable<GroupMain> groupMainKpiGraph(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"

SELECT	E.COMPANY_NAME				AS 'KpiGraphCompanyName'
		,ISNULL(B.SALES, 0)			AS 'kpiGraphSales'
		,CONVERT(DECIMAL(12,2), ROUND(CASE WHEN ISNULL(B.SALES, 0) = 0 THEN 0 
									        WHEN ISNULL(C.SALES, 0) = 0 THEN 0
										WHEN ISNULL(C.SALES, 0) < 0 THEN 200 - ((ISNULL(B.SALES, 0) / ISNULL(C.SALES, 0)) * 100)
									    ELSE (ISNULL(B.SALES, 0) / ISNULL(C.SALES, 0)) * 100 END, 2)) AS 'kpiGraphSalesRate'
        ,ISNULL(B.EBIT, 0)			AS 'kpiGraphEbit'
        ,CONVERT(DECIMAL(12,2), ROUND(CASE WHEN ISNULL(B.EBIT, 0) = 0 THEN 0 
									        WHEN ISNULL(C.EBIT, 0) = 0 THEN 0
										WHEN ISNULL(C.EBIT, 0) < 0 THEN 200 - ((ISNULL(B.EBIT, 0) / ISNULL(C.EBIT, 0)) * 100)
									    ELSE (ISNULL(B.EBIT, 0) / ISNULL(C.EBIT, 0)) * 100 END, 2))	  AS 'kpiGraphEbitRate'
        ,CONVERT(DECIMAL(12,2), ROUND(CASE WHEN ISNULL(B.SALES, 0) = 0 THEN 0 
									        WHEN ISNULL(C.EBIT, 0) = 0 THEN 0
									    ELSE (ISNULL(B.EBIT, 0) / ISNULL(B.SALES, 0)) * 100 END, 2))	  AS 'kpiGraphResultRate'
        ,UNION_NAME					AS 'unionName'
FROM	PM_PAL							A
LEFT OUTER JOIN PM_PAL_SUMMARY			B ON A.SEQ = B.PM_PAL_SEQ
LEFT OUTER JOIN 
(
	SELECT	A.MONTHLY_PAL_YEAR
			, A.ORG_COMPANY_SEQ
			, SUM(ISNULL(B.SALES, 0)) AS SALES
			, SUM(ISNULL(B.EBIT, 0)) AS EBIT
	FROM	PLAN_MONTHLY_PAL					A
	LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS_MONTHLY_SUM	B ON A.SEQ = B.PLAN_MONTHLY_PAL_SEQ
	WHERE	1 = 1
    AND     A.REGIST_STATUS    = @RegistStatus
    AND     A.MONTHLY_PAL_YEAR = @Year
	AND		B.MONTHLY <= @Month
	GROUP BY A.MONTHLY_PAL_YEAR
			, A.ORG_COMPANY_SEQ
)						C ON A.ORG_COMPANY_SEQ = C.ORG_COMPANY_SEQ AND A.PAL_YEAR = C.MONTHLY_PAL_YEAR
LEFT OUTER JOIN ORG_COMPANY E ON A.ORG_COMPANY_SEQ = E.SEQ
LEFT OUTER JOIN ORG_UNION F ON F.SEQ = E.ORG_UNION_SEQ
WHERE	1 = 1
AND     A.REGIST_STATUS    = @RegistStatus
AND		A.PAL_YEAR = @Year
AND		A.MONTHLY = @Month
AND		B.MONTHLY_TYPE = @MonthlyType
                                        AND E.IS_USE = 'Y'
                                        AND F.IS_USE = 'Y'
                                        AND A.ORG_COMPANY_SEQ <> 13
                                        ORDER BY F.SEQ ASC

/*
SELECT	E.COMPANY_NAME				AS 'KpiGraphCompanyName'
		,ISNULL(B.SALES, 0)			AS 'kpiGraphSales'
		,CONVERT(DECIMAL(12,2), ROUND(CASE WHEN ISNULL(B.SALES, 0) = 0 THEN 0 
									        WHEN ISNULL(C.SALES, 0) = 0 THEN 0
									    ELSE (ISNULL(B.SALES, 0) / ISNULL(C.SALES, 0)) * 100 END, 2)) AS 'kpiGraphSalesRate'
        ,ISNULL(B.EBIT, 0)			AS 'kpiGraphEbit'
        ,CONVERT(DECIMAL(12,2), ROUND(CASE WHEN ISNULL(B.EBIT, 0) = 0 THEN 0 
									        WHEN ISNULL(C.EBIT, 0) = 0 THEN 0
									    ELSE (ISNULL(B.EBIT, 0) / ISNULL(C.EBIT, 0)) * 100 END, 2))	  AS 'kpiGraphEbitRate'
        ,CONVERT(DECIMAL(12,2), ROUND(CASE WHEN ISNULL(B.SALES, 0) = 0 THEN 0 
									        WHEN ISNULL(C.EBIT, 0) = 0 THEN 0
									    ELSE (ISNULL(B.EBIT, 0) / ISNULL(B.SALES, 0)) * 100 END, 2))	  AS 'kpiGraphResultRate'
        ,UNION_NAME					AS 'unionName'
FROM	PM_PAL							A
LEFT OUTER JOIN PM_PAL_SUMMARY			B ON A.SEQ = B.PM_PAL_SEQ
LEFT OUTER JOIN 
(
	SELECT	A.MONTHLY_PAL_YEAR
			, A.ORG_COMPANY_SEQ
			, SUM(ISNULL(B.SALES, 0)) AS SALES
			, SUM(ISNULL(B.EBIT, 0)) AS EBIT
	FROM	PLAN_MONTHLY_PAL					A
	LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS_MONTHLY_SUM	B ON A.SEQ = B.PLAN_MONTHLY_PAL_SEQ
	WHERE	1 = 1
    AND     A.REGIST_STATUS    = @RegistStatus
    AND     A.MONTHLY_PAL_YEAR = @Year
	AND		B.MONTHLY <= @Month
	GROUP BY A.MONTHLY_PAL_YEAR
			, A.ORG_COMPANY_SEQ
)						C ON A.ORG_COMPANY_SEQ = C.ORG_COMPANY_SEQ AND A.PAL_YEAR = C.MONTHLY_PAL_YEAR
LEFT OUTER JOIN ORG_COMPANY E ON A.ORG_COMPANY_SEQ = E.SEQ
LEFT OUTER JOIN ORG_UNION F ON F.SEQ = E.ORG_UNION_SEQ
WHERE	1 = 1
AND     A.REGIST_STATUS    = @RegistStatus
AND		A.PAL_YEAR = @Year
AND		A.MONTHLY = @Month
AND		B.MONTHLY_TYPE = @MonthlyType
                                        AND E.IS_USE = 'Y'
                                        AND F.IS_USE = 'Y'
                                        ORDER BY F.SEQ ASC */
";

                    //string query = @" SELECT E.COMPANY_NAME				AS 'KpiGraphCompanyName'
                    //                        ,ISNULL(B.SALES, 0)			AS 'kpiGraphSales'
                    //                        ,CONVERT(DECIMAL(12,2), ROUND(CASE WHEN ISNULL(B.SALES, 0) = 0 THEN 0 
									           //                                WHEN ISNULL(D.SALES, 0) = 0 THEN 0
									           //                           ELSE (ISNULL(B.SALES, 0) / ISNULL(D.SALES, 0)) * 100 END, 2)) AS 'kpiGraphSalesRate'
                    //                        ,ISNULL(B.EBIT, 0)			AS 'kpiGraphEbit'
                    //                        ,CONVERT(DECIMAL(12,2), ROUND(CASE WHEN ISNULL(B.EBIT, 0) = 0 THEN 0 
									           //                                WHEN ISNULL(D.EBIT, 0) = 0 THEN 0
									           //                           ELSE (ISNULL(B.EBIT, 0) / ISNULL(D.EBIT, 0)) * 100 END, 2))	  AS 'kpiGraphEbitRate'
                    //                        ,CONVERT(DECIMAL(12,2), ROUND(CASE WHEN ISNULL(B.SALES, 0) = 0 THEN 0 
									           //                                WHEN ISNULL(D.EBIT, 0) = 0 THEN 0
									           //                           ELSE (ISNULL(B.EBIT, 0) / ISNULL(B.SALES, 0)) * 100 END, 2))	  AS 'kpiGraphResultRate'
                    //                        ,UNION_NAME					AS 'unionName'
                    //                    FROM PM_PAL A
                    //                    LEFT OUTER JOIN PM_PAL_SUMMARY B ON A.SEQ = B.PM_PAL_SEQ
                    //                    LEFT OUTER JOIN PLAN_MONTHLY_PAL C ON A.PAL_YEAR = C.MONTHLY_PAL_YEAR AND A.ORG_COMPANY_SEQ = C.ORG_COMPANY_SEQ
                    //                    LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS_MONTHLY_SUM D ON C.SEQ = D.PLAN_MONTHLY_PAL_SEQ AND A.MONTHLY = D.MONTHLY
                    //                    LEFT OUTER JOIN ORG_COMPANY E ON A.ORG_COMPANY_SEQ = E.SEQ
                    //                    LEFT OUTER JOIN ORG_UNION F ON F.SEQ = E.ORG_UNION_SEQ
                    //                    WHERE MONTHLY_TYPE = @MonthlyType 
                    //                    AND A.PAL_YEAR = @Year
                    //                    AND A.MONTHLY = @Month
                    //                    AND E.IS_USE = 'Y'
                    //                    AND F.IS_USE = 'Y'
                    //                    ORDER BY F.SEQ ASC";

                    return con.Query<GroupMain>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        #endregion

        #region << Cash Flow >>

        public IEnumerable<GroupMain> groupMainPlanCashFlow(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" SELECT *
                                        FROM(
                                        SELECT ISNULL(SUM(D.BASIC_CASH), 0)			AS '연초현금'
	                                          ,ISNULL(SUM(C.EBITDA), 0)				AS '세후EBITDA'
	                                          ,ISNULL(SUM(C.WC_SUM), 0)				AS 'WC변동'
	                                          ,ISNULL(SUM(C.ETC), 0)				AS '영업기타'
	                                          ,ISNULL(SUM(C.NET_CAPEX_SUM), 0)		AS 'NetCAPEX'
	                                          ,ISNULL(SUM(C.FINANCIAL_COST), 0)		AS '순금융비용'
	                                          ,ISNULL(SUM(C.FINANCIAL_SUM), 0)		AS '재무활동'
	                                          ,ISNULL(SUM(C.ENDING_CASH), 0)		AS '월말현금'
	                                          ,ISNULL(SUM(C.AVAILABLE_CASH), 0)		AS '가용현금'
                                        FROM PM_CASH_FLOW A
                                        LEFT OUTER JOIN PM_CASH_FLOW_BE_CASH B ON A.SEQ = B.PM_CASH_FLOW_SEQ
                                        LEFT OUTER JOIN PM_CASH_FLOW_CUMULATIVE C ON B.PM_CASH_FLOW_SEQ = C.PM_CASH_FLOW_SEQ AND A.SEQ = C.PM_CASH_FLOW_SEQ
                                        LEFT OUTER JOIN (SELECT A.YEAR_CF_YEAR
					                                          ,B.MONTHLY
					                                          ,A.ORG_COMPANY_SEQ
					                                          ,ISNULL(B.BASIC_CASH, 0) AS BASIC_CASH
				                                         FROM PLAN_YEAR_CF A
				                                         LEFT OUTER JOIN PLAN_YEAR_CF_BE_CASH B ON A.SEQ = B.PLAN_YEAR_CF_SEQ
				                                         WHERE 1 = 1
                                                         AND A.REGIST_STATUS = @RegistStatus
                                                         AND A.YEAR_CF_YEAR = @Year
				                                         --AND B.MONTHLY <> '99' AND B.MONTHLY <= @Month
                                                         AND B.MONTHLY <> '99' AND B.MONTHLY <= '01'
                                        --)D ON A.ORG_COMPANY_SEQ = D.ORG_COMPANY_SEQ AND A.CASH_FLOW_YEAR = D.YEAR_CF_YEAR AND A.MONTHLY = D.MONTHLY
                                        )D ON A.ORG_COMPANY_SEQ = D.ORG_COMPANY_SEQ AND A.CASH_FLOW_YEAR = D.YEAR_CF_YEAR
                                        WHERE 1 = 1
                                        AND A.REGIST_STATUS = @RegistStatus
                                        AND CUMULATIVE = @Cumulative
                                        AND C.DIFF = @Diff 
                                        AND CASH_FLOW_YEAR = @Year
                                        AND A.MONTHLY = @Month 
                                        ) A
                                        UNPIVOT (
                                            groupMainCashFlowValue FOR groupMainCashFlowName IN (연초현금,세후EBITDA,WC변동,영업기타,NetCAPEX,순금융비용,재무활동,월말현금,가용현금)
                                        ) AS A ";

                    return con.Query<GroupMain>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }
        public IEnumerable<GroupMain> groupMainPlanCashFlow_NEW(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {

                    // string query = @" SELECT * FROM (
                    // SELECT BASIC_CASH AS '연초현금'
                    // ,[세후EBITDA]
                    // ,[WC변동]
                    // ,[영업기타]
                    // ,[NetCAPEX]
                    // ,[순금융비용]
                    // ,FINANCIAL_SUM AS '재무활동'
                    // ,BASIC_CASH + FCF + FINANCIAL_SUM AS '월말현금'
                    // ,BASIC_CASH + FCF + FINANCIAL_SUM + CREDIT_LINE AS '가용현금' 
                    // FROM(
                    // SELECT 
                    // (SELECT   SUM(ISNULL(B.BASIC_CASH, 0)) AS BASIC_CASH
                    // FROM PLAN_YEAR_CF A WITH(NOLOCK)
                    // LEFT OUTER JOIN PLAN_YEAR_CF_BE_CASH B WITH(NOLOCK) ON A.SEQ = B.PLAN_YEAR_CF_SEQ
                    // WHERE 1 = 1
                    // AND A.REGIST_STATUS = 7
                    // AND A.YEAR_CF_YEAR = @Year
                    // --AND B.MONTHLY <> '99' AND B.MONTHLY <= @Month
                    // --AND B.MONTHLY <> '99' AND B.MONTHLY <= '01' AND   A.ORG_COMPANY_SEQ <> 13)			AS BASIC_CASH
                    // AND B.MONTHLY <> '99' AND B.MONTHLY <= '01' )			AS BASIC_CASH

                    // ,SUM(EBITDA)				AS '세후EBITDA'
                    // ,SUM(WC)				AS 'WC변동'
                    // ,SUM(SALES_ETC)			AS '영업기타'
                    // ,SUM(NET_CAPEX)		AS 'NetCAPEX'
                    // ,SUM(FINANCIAL_COST)		AS '순금융비용'
                    // ,SUM(FINANCIAL_SUM)	AS FINANCIAL_SUM
                    // ,SUM(FCF)  AS FCF 
                    // ,SUM(CREDIT_LINE)	  AS  CREDIT_LINE
                    // FROM  PLAN_GROUPDATA_CF_MONTHLY      
                    // WHERE 1 = 1     
                    // AND GROUPDATA_YEAR  = @Year
                    // AND GROUPDATA_MONTH <= @Month) B 
                    // ) A
                    // UNPIVOT (
                    // groupMainCashFlowValue FOR groupMainCashFlowName IN (연초현금,세후EBITDA,WC변동,영업기타,NetCAPEX,순금융비용,재무활동,월말현금,가용현금)
                    // ) AS A ";
           //         string query = @" SELECT * FROM (                                        
           //                             SELECT SUM([연초현금])  AS '연초현금'
			        //                    ,SUM([세후EBITDA]) AS '세후EBITDA'
			        //                    ,SUM([WC변동]) AS 'WC변동'
			        //                    ,SUM([영업기타]) AS '영업기타'
			        //                    ,SUM([NetCAPEX]) AS 'NetCAPEX'
			        //                    ,SUM([순금융비용]) AS '순금융비용'
			        //                    ,SUM([재무활동]) AS '재무활동'
			        //                    ,SUM([월말현금]) AS '월말현금'
			        //                    ,SUM([가용현금]) AS '가용현금' 
           //                            FROM (
           //                             SELECT BASIC_CASH AS '연초현금'
											//,[세후EBITDA]
											//,[WC변동]
											//,[영업기타]
											//,[NetCAPEX]
											//,[순금융비용]
											//,FINANCIAL_SUM AS '재무활동'
											//,BASIC_CASH + FCF + FINANCIAL_SUM AS '월말현금'
											//--,BASIC_CASH + FCF + FINANCIAL_SUM + CREDIT_LINE AS '가용현금' 
           //                                 ,  CREDIT_LINE AS '가용현금' 
											//	FROM(
				       //                         SELECT 
					      //                           (SELECT   SUM(ISNULL(B.BASIC_CASH, 0)) AS BASIC_CASH
										 //                               FROM PLAN_YEAR_CF A WITH(NOLOCK)
										 //                               LEFT OUTER JOIN PLAN_YEAR_CF_BE_CASH B WITH(NOLOCK) ON A.SEQ = B.PLAN_YEAR_CF_SEQ
										 //                               WHERE 1 = 1
										 //                               AND A.REGIST_STATUS = 7
										 //                               AND A.YEAR_CF_YEAR = @Year
										 //                               --AND B.MONTHLY <> '99' AND B.MONTHLY <= @Month
										 //                               AND B.MONTHLY <> '99' AND B.MONTHLY <= '01' AND   A.ORG_COMPANY_SEQ <> 13)			AS BASIC_CASH
	       
							    //                            ,SUM(EBITDA)				AS '세후EBITDA'
							    //                            ,SUM(WC)				AS 'WC변동'
							    //                            ,SUM(SALES_ETC)			AS '영업기타'
							    //                            ,SUM(NET_CAPEX)		AS 'NetCAPEX'
							    //                            ,SUM(FINANCIAL_COST)		AS '순금융비용'
							    //                            ,SUM(FINANCIAL_SUM)	AS FINANCIAL_SUM
							    //                            ,SUM(FCF)  AS FCF 
											//				--,SUM(CREDIT_LINE)	  AS  CREDIT_LINE
           //                                                 ,(SELECT Ebitda + Wc + SALES_ETC + NET_CAPEX + FINANCIAL_COST + FINANCIAL_SUM + BASIC_CASH + CREDIT_LINE  
           //                                                     FROM PLAN_GROUPDATA_CF_MONTHLY WITH(NOLOCK)
					      //                          WHERE 1 = 1     
					      //                          AND GROUPDATA_YEAR  = @Year
					      //                          AND GROUPDATA_MONTH  = @Month) AS CREDIT_LINE
					      //                          FROM  PLAN_GROUPDATA_CF_MONTHLY      
					      //                          WHERE 1 = 1     
					      //                          AND GROUPDATA_YEAR  = @Year
					      //                          AND GROUPDATA_MONTH <= @Month) B 
           //                                         ) A ) C
           //                             UNPIVOT (
           //                                 groupMainCashFlowValue FOR groupMainCashFlowName IN (연초현금,세후EBITDA,WC변동,영업기타,NetCAPEX,순금융비용,재무활동,월말현금,가용현금)
           //                             ) AS A ";
                    string query = @" SELECT * FROM (                                        
                                        SELECT SUM([연초현금])  AS '연초현금'
			                            ,SUM([세후EBITDA]) AS '세후EBITDA'
			                            ,SUM([WC변동]) AS 'WC변동'
			                            ,SUM([영업기타]) AS '영업기타'
			                            ,SUM([NetCAPEX]) AS 'NetCAPEX'
			                            ,SUM([순금융비용]) AS '순금융비용'
			                            ,SUM([재무활동]) AS '재무활동'
			                            ,SUM([월말현금]) AS '월말현금'
			                            ,SUM([가용현금]) AS '가용현금' 
                                       FROM (
                                        SELECT BASIC_CASH AS '연초현금'
											,[세후EBITDA]
											,[WC변동]
											,[영업기타]
											,[NetCAPEX]
											,[순금융비용]
											,FINANCIAL_SUM AS '재무활동'
											,BASIC_CASH + FCF + FINANCIAL_SUM AS '월말현금'
											--,BASIC_CASH + FCF + FINANCIAL_SUM + CREDIT_LINE AS '가용현금' 
                                            ,  CREDIT_LINE AS '가용현금' 
												FROM(
				                                SELECT 
					                                 (SELECT   SUM(ISNULL(B.BASIC_CASH, 0)) AS BASIC_CASH
										                                FROM PLAN_YEAR_CF A WITH(NOLOCK)
										                                LEFT OUTER JOIN PLAN_YEAR_CF_BE_CASH B WITH(NOLOCK) ON A.SEQ = B.PLAN_YEAR_CF_SEQ
                                                                         INNER JOIN ORG_COMPANY C
                                                                        ON A.ORG_COMPANY_SEQ    = C.SEQ
										                                WHERE 1 = 1
										                                AND A.REGIST_STATUS = 7
										                                AND A.YEAR_CF_YEAR = @Year
										                                --AND B.MONTHLY <> '99' AND B.MONTHLY <= @Month
										                                AND B.MONTHLY <> '99' AND B.MONTHLY <= '01' 
                                                                        AND A.ORG_COMPANY_SEQ <> 14
                                                                        AND A.ORG_COMPANY_SEQ <> 19
                                                                        AND C.IS_USE ='Y')			AS BASIC_CASH
	       
							                                ,SUM(EBITDA)				AS '세후EBITDA'
							                                ,SUM(WC)				AS 'WC변동'
							                                ,SUM(SALES_ETC)			AS '영업기타'
							                                ,SUM(NET_CAPEX)		AS 'NetCAPEX'
							                                ,SUM(FINANCIAL_COST)		AS '순금융비용'
							                                ,SUM(FINANCIAL_SUM)	AS FINANCIAL_SUM
							                                ,SUM(FCF)  AS FCF 
															--,SUM(CREDIT_LINE)	  AS  CREDIT_LINE
                                                            ,(SELECT Ebitda + Wc + SALES_ETC + NET_CAPEX + FINANCIAL_COST + FINANCIAL_SUM + BASIC_CASH + CREDIT_LINE  
                                                                FROM PLAN_GROUPDATA_CF_MONTHLY WITH(NOLOCK)
					                                WHERE 1 = 1     
					                                AND GROUPDATA_YEAR  = @Year
					                                AND GROUPDATA_MONTH  = @Month) AS CREDIT_LINE
					                                FROM  PLAN_GROUPDATA_CF_MONTHLY      
					                                WHERE 1 = 1     
					                                AND GROUPDATA_YEAR  = @Year
					                                AND GROUPDATA_MONTH <= @Month) B 
                                                    ) A ) C
                                        UNPIVOT (
                                            groupMainCashFlowValue FOR groupMainCashFlowName IN (연초현금,세후EBITDA,WC변동,영업기타,NetCAPEX,순금융비용,재무활동,월말현금,가용현금)
                                        ) AS A ";
                    return con.Query<GroupMain>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<GroupMain> groupMainPlanCashFlow_NEW2(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" SELECT * FROM(
				                                SELECT 
					                                 (SELECT   SUM(ISNULL(B.BASIC_CASH, 0)) AS BASIC_CASH
										                                FROM PLAN_YEAR_CF A WITH(NOLOCK)
										                                LEFT OUTER JOIN PLAN_YEAR_CF_BE_CASH B WITH(NOLOCK) ON A.SEQ = B.PLAN_YEAR_CF_SEQ
										                                WHERE 1 = 1
										                                AND A.REGIST_STATUS = 7
										                                AND A.YEAR_CF_YEAR = @Year
										                                --AND B.MONTHLY <> '99' AND B.MONTHLY <= @Month
										                                AND B.MONTHLY <> '99' AND B.MONTHLY <= '01' AND   A.ORG_COMPANY_SEQ <> 13)			AS '연초현금'
	       
							                                ,SUM(EBITDA)				AS '세후EBITDA'
							                                ,SUM(WC)				AS 'WC변동'
							                                ,SUM(SALES_ETC)			AS '영업기타'
							                                ,SUM(NET_CAPEX)		AS 'NetCAPEX'
							                                ,SUM(FINANCIAL_COST)		AS '순금융비용'
							                                ,SUM(FINANCIAL_SUM)	AS '재무활동'
							                                ,SUM(BASIC_CASH) + SUM(FCF) + SUM(FINANCIAL_SUM)	AS '월말현금'
							                                ,SUM(BASIC_CASH) + SUM(FCF) + SUM(FINANCIAL_SUM) + SUM(CREDIT_LINE)		AS '가용현금'
					                                FROM  PLAN_GROUPDATA_CF_MONTHLY 
     
					                                WHERE 1 = 1
     
					                                AND GROUPDATA_YEAR  = @Year
					                                AND GROUPDATA_MONTH <= @Month ) A
                                        UNPIVOT (
                                            groupMainCashFlowValue FOR groupMainCashFlowName IN (연초현금,세후EBITDA,WC변동,영업기타,NetCAPEX,순금융비용,재무활동,월말현금,가용현금)
                                        ) AS A ";

                    return con.Query<GroupMain>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<GroupMain> groupMainResultCashFlow_NEW(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

           //         string query = @"SELECT * FROM (
           //                             SELECT BASIC_CASH AS '연초현금'
											//,[세후EBITDA]
											//,[WC변동]
											//,[영업기타]
											//,[NetCAPEX]
											//,[순금융비용]
											//,FINANCIAL_SUM AS '재무활동'
											//,BASIC_CASH + FCF + FINANCIAL_SUM AS '월말현금'
											//,BASIC_CASH + FCF + FINANCIAL_SUM + CREDIT_LINE AS '가용현금' 
											//	FROM(
				       //                         SELECT 
					      //                           (SELECT   SUM(ISNULL(B.BASIC_CASH, 0)) AS BASIC_CASH
										 //                               FROM PLAN_YEAR_CF A WITH(NOLOCK)
										 //                               LEFT OUTER JOIN PLAN_YEAR_CF_BE_CASH B WITH(NOLOCK) ON A.SEQ = B.PLAN_YEAR_CF_SEQ
										 //                               WHERE 1 = 1
										 //                               AND A.REGIST_STATUS = 7
										 //                               AND A.YEAR_CF_YEAR = @Year
										 //                               --AND B.MONTHLY <> '99' AND B.MONTHLY <= @Month
										 //                               --AND B.MONTHLY <> '99' AND B.MONTHLY <= '01' AND   A.ORG_COMPANY_SEQ <> 13)			AS BASIC_CASH
           //                                                             AND B.MONTHLY <> '99' AND B.MONTHLY <= '01' )			AS BASIC_CASH
	       
							    //                            ,SUM(EBITDA)				AS '세후EBITDA'
							    //                            ,SUM(WC)				AS 'WC변동'
							    //                            ,SUM(SALES_ETC)			AS '영업기타'
							    //                            ,SUM(NET_CAPEX)		AS 'NetCAPEX'
							    //                            ,SUM(FINANCIAL_COST)		AS '순금융비용'
							    //                            ,SUM(FINANCIAL_SUM)	AS FINANCIAL_SUM
							    //                            ,SUM(FCF)  AS FCF 
											//				,SUM(CREDIT_LINE)	  AS  CREDIT_LINE
					      //                          FROM  PM_GROUPDATA_CF_MONTHLY WITH(NOLOCK)
     
					      //                          WHERE 1 = 1
     
					      //                          AND GROUPDATA_YEAR  = @Year
					      //                          AND GROUPDATA_MONTH = @Month 
           //                                         AND MONTH_TYPE ='20') B 
           //                                         ) A 
           //                             UNPIVOT (
           //                                 groupMainCashFlowValue FOR groupMainCashFlowName IN (연초현금,세후EBITDA,WC변동,영업기타,NetCAPEX,순금융비용,재무활동,월말현금,가용현금)
           //                             ) AS A ";
                    string query = @"SELECT * FROM (
                                        SELECT BASIC_CASH AS '연초현금'
											,[세후EBITDA]
											,[WC변동]
											,[영업기타]
											,[NetCAPEX]
											,[순금융비용]
											,FINANCIAL_SUM AS '재무활동'
											,BASIC_CASH + FCF + FINANCIAL_SUM AS '월말현금'
											,BASIC_CASH + FCF + FINANCIAL_SUM + CREDIT_LINE AS '가용현금' 
												FROM(
				                                SELECT 
					                                 (SELECT   SUM(ISNULL(B.BASIC_CASH, 0)) AS BASIC_CASH
										                                FROM PLAN_YEAR_CF A WITH(NOLOCK)
										                                LEFT OUTER JOIN PLAN_YEAR_CF_BE_CASH B WITH(NOLOCK) ON A.SEQ = B.PLAN_YEAR_CF_SEQ
                                                                        INNER JOIN ORG_COMPANY C
                                                                        ON A.ORG_COMPANY_SEQ    = C.SEQ
										                                WHERE 1 = 1
										                                AND A.REGIST_STATUS = 7
										                                AND A.YEAR_CF_YEAR = @Year
										                                --AND B.MONTHLY <> '99' AND B.MONTHLY <= @Month
										                                --AND B.MONTHLY <> '99' AND B.MONTHLY <= '01' AND   A.ORG_COMPANY_SEQ <> 13)			AS BASIC_CASH
                                                                        AND B.MONTHLY <> '99' AND B.MONTHLY <= '01' 
                                                                        AND A.ORG_COMPANY_SEQ <> 14
                                                                        AND A.ORG_COMPANY_SEQ <> 19
                                                                        AND C.IS_USE ='Y')			AS BASIC_CASH
	       
							                                ,SUM(EBITDA)				AS '세후EBITDA'
							                                ,SUM(WC)				AS 'WC변동'
							                                ,SUM(SALES_ETC)			AS '영업기타'
							                                ,SUM(NET_CAPEX)		AS 'NetCAPEX'
							                                ,SUM(FINANCIAL_COST)		AS '순금융비용'
							                                ,SUM(FINANCIAL_SUM)	AS FINANCIAL_SUM
							                                ,SUM(FCF)  AS FCF 
															,SUM(CREDIT_LINE)	  AS  CREDIT_LINE
					                                FROM  PM_GROUPDATA_CF_MONTHLY WITH(NOLOCK)
     
					                                WHERE 1 = 1
     
					                                AND GROUPDATA_YEAR  = @Year
					                                AND GROUPDATA_MONTH = @Month 
                                                    AND MONTH_TYPE ='20') B 
                                                    ) A 
                                        UNPIVOT (
                                            groupMainCashFlowValue FOR groupMainCashFlowName IN (연초현금,세후EBITDA,WC변동,영업기타,NetCAPEX,순금융비용,재무활동,월말현금,가용현금)
                                        ) AS A ";
                    return con.Query<GroupMain>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<GroupMain> groupMainResultCashFlow(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" SELECT *
                                        FROM
                                        (
                                          SELECT ISNULL(SUM(B.BASIC_CASH), 0)			AS '연초현금'
		                                        ,ISNULL(SUM(C.EBITDA), 0)				AS '세후EBITDA'
		                                        ,ISNULL(SUM(C.WC_SUM),0)				AS 'WC변동'
		                                        ,ISNULL(SUM(C.ETC),0)					AS '영업기타'
		                                        ,ISNULL(SUM(C.NET_CAPEX_SUM),0)			AS 'NetCAPEX'
		                                        ,ISNULL(SUM(C.FINANCIAL_COST),0)		AS '순금융비용'
		                                        ,ISNULL(SUM(C.FINANCIAL_SUM),0)			AS '재무활동'
		                                        ,ISNULL(SUM(C.ENDING_CASH),0)			AS '월말현금'
		                                        ,ISNULL(SUM(C.AVAILABLE_CASH),0)		AS '가용현금'
                                            FROM PM_CASH_FLOW A 
                                            LEFT OUTER JOIN PM_CASH_FLOW_BE_CASH B ON A.SEQ = B.PM_CASH_FLOW_SEQ
                                            LEFT OUTER JOIN PM_CASH_FLOW_CUMULATIVE C ON B.PM_CASH_FLOW_SEQ = C.PM_CASH_FLOW_SEQ AND A.SEQ = C.PM_CASH_FLOW_SEQ
                                            WHERE 1 = 1
                                            AND CUMULATIVE = @Cumulative
                                            AND DIFF = @Diff
                                            AND A.REGIST_STATUS = @RegistStatus
                                            AND CASH_FLOW_YEAR = @Year
                                            AND MONTHLY = @Month
                                        )A
                                        UNPIVOT (
                                            groupMainCashFlowValue FOR groupMainCashFlowName IN (연초현금,세후EBITDA,WC변동,영업기타,NetCAPEX,순금융비용,재무활동,월말현금,가용현금)
                                        ) AS A ";

                    return con.Query<GroupMain>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        #endregion

        #region << 손익(당월/누계) >>
        /// <summary>
        /// 2022.07.11 월 손익 추가 항목
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        /// 
        public GroupMain groupMainSalesCr(object param)
        {

            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
                            SELECT	SALES_CR
                            FROM	PM_GROUPDATA_PAL_MONTHLY_CR	A
                            WHERE	1 = 1
                            
                            AND		A.GROUPDATA_YEAR = @Year
                            AND		A.GROUPDATA_MONTH = @Month
                            AND     A.MONTHLY_TYPE = @MonthlyType


                            ";


                    return con.Query<GroupMain>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }



        /// <summary>
        /// 2018.12.17 모든 회사 데이터가 나오게 변경
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        /// 
        public IEnumerable<GroupMain> groupMainSalesCalc(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" SELECT UNION_NAME	AS 'unionName'
	                                         ,ISNULL(SUM(D.SALES), 0) AS 'groupMainPlanSales'
                                             ,ISNULL(SUM(B.SALES), 0) AS 'groupMainResultSales'
                                             ,F.SEQ					  AS 'unionSeq'
                                             ,F.IS_USE
                                        FROM PM_PAL A
                                        LEFT OUTER JOIN PM_PAL_SUMMARY B ON A.SEQ = B.PM_PAL_SEQ
                                        LEFT OUTER JOIN PLAN_MONTHLY_PAL C ON A.ORG_COMPANY_SEQ = C.ORG_COMPANY_SEQ AND A.PAL_YEAR = C.MONTHLY_PAL_YEAR
                                        LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS_MONTHLY_SUM D ON C.SEQ = D.PLAN_MONTHLY_PAL_SEQ AND A.MONTHLY = D.MONTHLY
                                        LEFT OUTER JOIN ORG_COMPANY E ON A.ORG_COMPANY_SEQ = E.SEQ
                                        LEFT OUTER JOIN ORG_UNION F ON E.ORG_UNION_SEQ = F.SEQ
                                        WHERE 1 = 1 
                                        AND B.MONTHLY_TYPE = @MonthlyType
                                        AND A.REGIST_STATUS = @RegistStatus
                                        AND A.PAL_YEAR = @Year
                                        AND A.MONTHLY = @Month
 
                                        -- 사용중인 부문만 보이게 변경
                                        --AND F.IS_USE = 'Y'
                                        GROUP BY F.ORD, UNION_NAME, F.SEQ, F.IS_USE ";

                    return con.Query<GroupMain>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        
        /// <summary>
        /// 2018.12.17 모든 회사 데이터가 나오게 변경
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        public IEnumerable<GroupMain> groupMainSalesCalc_NEW(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" SELECT UNION_NAME	AS 'unionName'
	                                         ,ISNULL(SUM(D.SALES), 0) AS 'groupMainPlanSales'
                                             ,ISNULL(SUM(B.SALES), 0) AS 'groupMainResultSales'
                                             , (SELECT  SALES  FROM PLAN_GROUPDATA_PAL_MONTHLY_SUMMARY WITH(NOLOCK)  
                                                                     WHERE GROUPDATA_YEAR = @Year AND GROUPDATA_MONTH   = @Month) AS groupMainPlanSalesSum
											 , (SELECT SALES  FROM PM_GROUPDATA_PAL_MONTHLY WITH(NOLOCK) 
                                                                    WHERE GROUPDATA_YEAR = @Year AND GROUPDATA_MONTH   = @Month  AND MONTHLY_TYPE = @MonthlyType) AS groupMainResultSalesSum
                                      
                                             ,F.SEQ					  AS 'unionSeq'
                                             ,F.IS_USE
                                        FROM PM_PAL A
                                        LEFT OUTER JOIN PM_PAL_SUMMARY B ON A.SEQ = B.PM_PAL_SEQ
                                        LEFT OUTER JOIN PLAN_MONTHLY_PAL C ON A.ORG_COMPANY_SEQ = C.ORG_COMPANY_SEQ AND A.PAL_YEAR = C.MONTHLY_PAL_YEAR
                                        LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS_MONTHLY_SUM D ON C.SEQ = D.PLAN_MONTHLY_PAL_SEQ AND A.MONTHLY = D.MONTHLY
                                        LEFT OUTER JOIN ORG_COMPANY E ON A.ORG_COMPANY_SEQ = E.SEQ
                                        LEFT OUTER JOIN ORG_UNION F ON E.ORG_UNION_SEQ = F.SEQ
                                        WHERE 1 = 1 
                                        AND B.MONTHLY_TYPE = @MonthlyType
                                        AND A.REGIST_STATUS = @RegistStatus
                                        AND A.PAL_YEAR = @Year
                                        AND A.MONTHLY = @Month
                                        AND A.ORG_COMPANY_SEQ <> 13
                                        AND A.ORG_COMPANY_SEQ <> 19
                                        AND A.ORG_COMPANY_SEQ <> 14   
                                        AND A.ORG_COMPANY_SEQ <> 4 
                                        -- 사용중인 부문만 보이게 변경
                                        --AND F.IS_USE = 'Y'
                                        GROUP BY F.ORD, UNION_NAME, F.SEQ, F.IS_USE ";

                    return con.Query<GroupMain>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        /// <summary>
        /// 2018.12.17 모든 회사 데이터가 나오게 변경(서브차트제외)
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        public IEnumerable<GroupMain> groupMainSubSalesCalc(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" SELECT CASE WHEN total = 0 THEN 0 ELSE ROUND(건설부문 / total * 100, 0) END AS 'groupMainBuildSales'
	                                        ,CASE WHEN total = 0 THEN 0 ELSE ROUND(자동차부문 / total * 100, 0) END AS 'groupMainCarSales'
	                                        ,CASE WHEN total = 0 THEN 0 ELSE ROUND(지주부문 / total * 100, 0) END AS 'groupMainCompanySales'
                                    FROM(
	                                    SELECT UNION_NAME
		                                        ,ISNULL(SUM(B.SALES), 0) AS 'groupMainResultSales'
	                                    FROM PM_PAL A
	                                    LEFT OUTER JOIN PM_PAL_SUMMARY B ON A.SEQ = B.PM_PAL_SEQ
	                                    LEFT OUTER JOIN PLAN_MONTHLY_PAL C ON A.ORG_COMPANY_SEQ = C.ORG_COMPANY_SEQ AND A.PAL_YEAR = C.MONTHLY_PAL_YEAR
	                                    LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS_MONTHLY_SUM D ON C.SEQ = D.PLAN_MONTHLY_PAL_SEQ AND A.MONTHLY = D.MONTHLY
	                                    LEFT OUTER JOIN ORG_COMPANY E ON A.ORG_COMPANY_SEQ = E.SEQ
	                                    LEFT OUTER JOIN ORG_UNION F ON E.ORG_UNION_SEQ = F.SEQ
	                                    WHERE 1 = 1
                                        AND B.MONTHLY_TYPE = @MonthlyType
                                        AND A.REGIST_STATUS = @RegistStatus
	                                    AND A.PAL_YEAR = @Year
	                                    AND A.MONTHLY = @Month
                                        AND A.ORG_COMPANY_SEQ <> 19
                                        AND A.ORG_COMPANY_SEQ <> 14   
                                        AND A.ORG_COMPANY_SEQ <> 4 
                                        -- 사용중인 부문만 보이게 변경
                                        AND F.IS_USE = 'Y'
	                                    GROUP BY F.ORD, UNION_NAME
	                                    UNION
	                                    SELECT 'total' AS 'total'
		                                        ,ISNULL(SUM(groupMainResultSales), 0) AS 'groupMainResultSales'
	                                    FROM(
		                                    SELECT UNION_NAME
			                                        ,ISNULL(SUM(B.SALES), 0) AS 'groupMainResultSales'
		                                    FROM PM_PAL A
		                                    LEFT OUTER JOIN PM_PAL_SUMMARY B ON A.SEQ = B.PM_PAL_SEQ
		                                    LEFT OUTER JOIN PLAN_MONTHLY_PAL C ON A.ORG_COMPANY_SEQ = C.ORG_COMPANY_SEQ AND A.PAL_YEAR = C.MONTHLY_PAL_YEAR
		                                    LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS_MONTHLY_SUM D ON C.SEQ = D.PLAN_MONTHLY_PAL_SEQ AND A.MONTHLY = D.MONTHLY
		                                    LEFT OUTER JOIN ORG_COMPANY E ON A.ORG_COMPANY_SEQ = E.SEQ
		                                    LEFT OUTER JOIN ORG_UNION F ON E.ORG_UNION_SEQ = F.SEQ
		                                    WHERE 1 = 1
                                            AND B.MONTHLY_TYPE = @MonthlyType
                                            AND A.REGIST_STATUS = @RegistStatus
		                                    AND A.PAL_YEAR = @Year
		                                    AND A.MONTHLY = @Month
                                            AND A.ORG_COMPANY_SEQ <> 19
                                            AND A.ORG_COMPANY_SEQ <> 14   
                                            AND A.ORG_COMPANY_SEQ <> 4 
                                        -- 사용중인 부문만 보이게 변경
                                        AND F.IS_USE = 'Y'
		                                    GROUP BY F.ORD, UNION_NAME
	                                    )A
                                    )B
                                    PIVOT(
	                                    MIN(B.groupMainResultSales) FOR B.UNION_NAME IN (건설부문,자동차부문,지주부문,total)
                                    )C";

                    return con.Query<GroupMain>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        /// <summary>
        /// 2018.12.17 모든 회사 데이터가 나오게 변경
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        public IEnumerable<GroupMain> groupMainEbitCalc(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" SELECT UNION_NAME	AS 'unionName'
	                                         ,ISNULL(SUM(D.EBIT), 0) AS 'groupMainPlanEbit'
                                             ,ISNULL(SUM(B.EBIT), 0) AS 'groupMainResultEbit'
                                             ,ISNULL(SUM(D.SALES), 0) AS 'groupMainPlanSales'
                                             ,ISNULL(SUM(B.SALES), 0) AS 'groupMainResultSales'
                                             ,F.SEQ                   AS 'unionSeq'
                                                ,F.IS_USE
                                        FROM PM_PAL A
                                        LEFT OUTER JOIN PM_PAL_SUMMARY B ON A.SEQ = B.PM_PAL_SEQ
                                        LEFT OUTER JOIN PLAN_MONTHLY_PAL C ON A.ORG_COMPANY_SEQ = C.ORG_COMPANY_SEQ AND A.PAL_YEAR = C.MONTHLY_PAL_YEAR
                                        LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS_MONTHLY_SUM D ON C.SEQ = D.PLAN_MONTHLY_PAL_SEQ AND A.MONTHLY = D.MONTHLY
                                        LEFT OUTER JOIN ORG_COMPANY E ON A.ORG_COMPANY_SEQ = E.SEQ
                                        LEFT OUTER JOIN ORG_UNION F ON E.ORG_UNION_SEQ = F.SEQ
                                        WHERE 1 = 1 
                                        AND B.MONTHLY_TYPE = @MonthlyType
                                        AND A.REGIST_STATUS = @RegistStatus
                                        AND A.PAL_YEAR = @Year
                                        AND A.MONTHLY = @Month
                                        -- 사용중인 부문만 보이게 변경
                                        --AND F.IS_USE = 'Y'
                                        GROUP BY F.ORD, UNION_NAME, F.SEQ, F.IS_USE";

                    return con.Query<GroupMain>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }


        /// <summary>
        /// 2018.12.17 모든 회사 데이터가 나오게 변경
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        public IEnumerable<GroupMain> groupMainEbitCalc_NEW(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" SELECT UNION_NAME	AS 'unionName'
	                                         ,ISNULL(SUM(D.EBIT), 0) AS 'groupMainPlanEbit'
                                             ,ISNULL(SUM(B.EBIT), 0) AS 'groupMainResultEbit'
                                             ,ISNULL(SUM(D.SALES), 0) AS 'groupMainPlanSales'
                                             ,ISNULL(SUM(B.SALES), 0) AS 'groupMainResultSales'
                                             , (SELECT  SALES  FROM PLAN_GROUPDATA_PAL_MONTHLY_SUMMARY WITH(NOLOCK)  
                                                                     WHERE GROUPDATA_YEAR = @Year AND GROUPDATA_MONTH   = @Month) AS groupMainPlanSalesSum
		                                     , (SELECT SALES  FROM PM_GROUPDATA_PAL_MONTHLY WITH(NOLOCK) 
                                                                    WHERE GROUPDATA_YEAR = @Year AND GROUPDATA_MONTH   = @Month  AND MONTHLY_TYPE = @MonthlyType) AS groupMainResultSalesSum
                                             , (SELECT EBIT  FROM PLAN_GROUPDATA_PAL_MONTHLY_SUMMARY WITH(NOLOCK)  
                                                                     WHERE GROUPDATA_YEAR = @Year AND GROUPDATA_MONTH   = @Month) AS groupMainPlanEbitSum
		                                     , (SELECT EBIT  FROM PM_GROUPDATA_PAL_MONTHLY WITH(NOLOCK) 
                                                                    WHERE GROUPDATA_YEAR = @Year AND GROUPDATA_MONTH   = @Month  AND MONTHLY_TYPE = @MonthlyType) AS groupMainResultEbitSum
   
                                             ,F.SEQ                   AS 'unionSeq'
                                                ,F.IS_USE
                                        FROM PM_PAL A
                                        LEFT OUTER JOIN PM_PAL_SUMMARY B ON A.SEQ = B.PM_PAL_SEQ
                                        LEFT OUTER JOIN PLAN_MONTHLY_PAL C ON A.ORG_COMPANY_SEQ = C.ORG_COMPANY_SEQ AND A.PAL_YEAR = C.MONTHLY_PAL_YEAR
                                        LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS_MONTHLY_SUM D ON C.SEQ = D.PLAN_MONTHLY_PAL_SEQ AND A.MONTHLY = D.MONTHLY
                                        LEFT OUTER JOIN ORG_COMPANY E ON A.ORG_COMPANY_SEQ = E.SEQ
                                        LEFT OUTER JOIN ORG_UNION F ON E.ORG_UNION_SEQ = F.SEQ
                                        WHERE 1 = 1 
                                        AND B.MONTHLY_TYPE = @MonthlyType
                                        AND A.REGIST_STATUS = @RegistStatus
                                        AND A.PAL_YEAR = @Year
                                        AND A.MONTHLY = @Month
                                        AND A.ORG_COMPANY_SEQ <> 13
                                        AND A.ORG_COMPANY_SEQ <> 19
                                        AND A.ORG_COMPANY_SEQ <> 14   
                                        AND A.ORG_COMPANY_SEQ <> 4 
                                        -- 사용중인 부문만 보이게 변경
                                        --AND F.IS_USE = 'Y'
                                        GROUP BY F.ORD, UNION_NAME, F.SEQ, F.IS_USE";

                    return con.Query<GroupMain>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<GroupMain> groupMainSubEbitCalc(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" SELECT CASE WHEN total = 0 THEN 0 ELSE ROUND(건설부문 / total * 100, 0) END AS 'groupMainBuildEbit'
	                                        ,CASE WHEN total = 0 THEN 0 ELSE ROUND(자동차부문 / total * 100, 0) END AS 'groupMainCarEbit'
	                                        ,CASE WHEN total = 0 THEN 0 ELSE ROUND(지주부문 / total * 100, 0) END AS 'groupMainCompanyEbit'
                                        FROM(
	                                        SELECT UNION_NAME
		                                            ,ISNULL(SUM(B.EBIT), 0) AS 'groupMainResultEbit'
	                                        FROM PM_PAL A
	                                        LEFT OUTER JOIN PM_PAL_SUMMARY B ON A.SEQ = B.PM_PAL_SEQ
	                                        LEFT OUTER JOIN PLAN_MONTHLY_PAL C ON A.ORG_COMPANY_SEQ = C.ORG_COMPANY_SEQ AND A.PAL_YEAR = C.MONTHLY_PAL_YEAR
	                                        LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS_MONTHLY_SUM D ON C.SEQ = D.PLAN_MONTHLY_PAL_SEQ AND A.MONTHLY = D.MONTHLY
	                                        LEFT OUTER JOIN ORG_COMPANY E ON A.ORG_COMPANY_SEQ = E.SEQ
	                                        LEFT OUTER JOIN ORG_UNION F ON E.ORG_UNION_SEQ = F.SEQ
	                                        WHERE 1 = 1 
                                            AND B.MONTHLY_TYPE = @MonthlyType
                                            AND A.REGIST_STATUS = @RegistStatus
	                                        AND A.PAL_YEAR = @Year
	                                        AND A.MONTHLY = @Month
                                            AND A.ORG_COMPANY_SEQ <> 19
                                        AND A.ORG_COMPANY_SEQ <> 14   
                                        AND A.ORG_COMPANY_SEQ <> 4 
                                        -- 사용중인 부문만 보이게 변경
                                            AND F.IS_USE = 'Y'
	                                        GROUP BY F.ORD, UNION_NAME
	                                        UNION
	                                        SELECT 'total' AS 'total'
		                                            ,ISNULL(SUM(groupMainResultEbit), 0) AS 'groupMainResultEbit'
	                                        FROM(
		                                        SELECT UNION_NAME
			                                            ,ISNULL(SUM(B.EBIT), 0) AS 'groupMainResultEbit'
		                                        FROM PM_PAL A
		                                        LEFT OUTER JOIN PM_PAL_SUMMARY B ON A.SEQ = B.PM_PAL_SEQ
		                                        LEFT OUTER JOIN PLAN_MONTHLY_PAL C ON A.ORG_COMPANY_SEQ = C.ORG_COMPANY_SEQ AND A.PAL_YEAR = C.MONTHLY_PAL_YEAR
		                                        LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS_MONTHLY_SUM D ON C.SEQ = D.PLAN_MONTHLY_PAL_SEQ AND A.MONTHLY = D.MONTHLY
		                                        LEFT OUTER JOIN ORG_COMPANY E ON A.ORG_COMPANY_SEQ = E.SEQ
		                                        LEFT OUTER JOIN ORG_UNION F ON E.ORG_UNION_SEQ = F.SEQ
		                                        WHERE 1 = 1 
                                                AND B.MONTHLY_TYPE = @MonthlyType
                                                AND A.REGIST_STATUS = @RegistStatus
		                                        AND A.PAL_YEAR = @Year
		                                        AND A.MONTHLY = @Month
                                        AND A.ORG_COMPANY_SEQ <> 19
                                        AND A.ORG_COMPANY_SEQ <> 14   
                                        AND A.ORG_COMPANY_SEQ <> 4 
                                        -- 사용중인 부문만 보이게 변경
                                        AND F.IS_USE = 'Y'
		                                        GROUP BY F.ORD, UNION_NAME
	                                        )A
                                        )B
                                        PIVOT(
	                                        MIN(B.groupMainResultEbit) FOR B.UNION_NAME IN (건설부문,자동차부문,지주부문,total)
                                        )C";

                    return con.Query<GroupMain>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        /// <summary>
        /// 2018.12.17 모든 회사 데이터가 나오게 변경(합계에 다른 부분[배당회사]가 보여야한다.)
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        public IEnumerable<GroupMain> groupMainSalesSumCalc(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    // groupMainPlanSales <-- 이게 계획 아닌가요? 그렇다면 B
                    string query = @" SELECT UNION_NAME	    AS 'unionName'
                                             ,SUM(C.SALES)  AS 'groupMainPlanSales'
                                             ,SUM(B.SALES)  AS 'groupMainResultSales'
                                             ,E.SEQ         AS 'unionSeq'
                                                ,E.IS_USE
                                        FROM PM_PAL A
                                        LEFT OUTER JOIN PM_PAL_SUMMARY B ON A.SEQ = B.PM_PAL_SEQ
                                        LEFT OUTER JOIN (SELECT ORG_COMPANY_SEQ
				                                                 ,@Month AS MONTHLY
				                                                 ,SUM(SALES) AS SALES
				                                           FROM PLAN_MONTHLY_PAL A
				                                           LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS_MONTHLY_SUM B ON A.SEQ = B.PLAN_MONTHLY_PAL_SEQ
				                                           WHERE 1 = 1
                                                           AND A.REGIST_STATUS = @RegistStatus
                                                           AND A.MONTHLY_PAL_YEAR = @Year
				                                           AND B.MONTHLY <> '99' AND B.MONTHLY <= @Month
				                                           GROUP BY A.ORG_COMPANY_SEQ
                                        ) C ON A.ORG_COMPANY_SEQ = C.ORG_COMPANY_SEQ AND A.MONTHLY = C.MONTHLY
                                        LEFT OUTER JOIN ORG_COMPANY D ON A.ORG_COMPANY_SEQ = D.SEQ 
                                        LEFT OUTER JOIN ORG_UNION E ON D.ORG_UNION_SEQ = E.SEQ
                                        WHERE 1 = 1
                                        AND B.MONTHLY_TYPE = @MonthlyType
                                        AND A.REGIST_STATUS = @RegistStatus
                                        AND A.PAL_YEAR = @Year
                                        AND A.MONTHLY = @Month
                                  
                                        -- 사용중인 부문만 보이게 변경
                                        --AND E.IS_USE = 'Y'
                                        GROUP BY E.ORD, UNION_NAME, E.SEQ, E.IS_USE";

                    //string query = @" SELECT UNION_NAME	    AS 'unionName'
                    //                         ,SUM(B.SALES)  AS 'groupMainPlanSales'
                    //                         ,SUM(C.SALES)  AS 'groupMainResultSales'
                    //                    FROM PM_PAL A
                    //                    LEFT OUTER JOIN PM_PAL_SUMMARY B ON A.SEQ = B.PM_PAL_SEQ
                    //                    LEFT OUTER JOIN (SELECT ORG_COMPANY_SEQ
				                //                                 ,@Month AS MONTHLY
				                //                                 ,SUM(SALES) AS SALES
				                //                           FROM PLAN_MONTHLY_PAL A
				                //                           LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS_MONTHLY_SUM B ON A.SEQ = B.PLAN_MONTHLY_PAL_SEQ
				                //                           WHERE A.MONTHLY_PAL_YEAR = @Year
				                //                           AND B.MONTHLY <> '99' AND B.MONTHLY <= @Month
				                //                           GROUP BY A.ORG_COMPANY_SEQ
                    //                    ) C ON A.ORG_COMPANY_SEQ = C.ORG_COMPANY_SEQ AND A.MONTHLY = C.MONTHLY
                    //                    LEFT OUTER JOIN ORG_COMPANY D ON A.ORG_COMPANY_SEQ = D.SEQ 
                    //                    LEFT OUTER JOIN ORG_UNION E ON D.ORG_UNION_SEQ = E.SEQ
                    //                    WHERE B.MONTHLY_TYPE = @MonthlyType
                    //                    AND A.PAL_YEAR = @Year
                    //                    AND A.MONTHLY = @Month
                    //                    GROUP BY UNION_NAME";

                    return con.Query<GroupMain>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        /// <summary>
        /// 2018.12.17 모든 회사 데이터가 나오게 변경(합계에 다른 부분[배당회사]가 보여야한다.)
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        public IEnumerable<GroupMain> groupMainSalesSumCalc_NEW(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    // groupMainPlanSales <-- 이게 계획 아닌가요? 그렇다면 B
                    string query = @" SELECT UNION_NAME	    AS 'unionName'
                                             ,SUM(C.SALES)  AS 'groupMainPlanSales'
                                             ,SUM(B.SALES)  AS 'groupMainResultSales'
                                             , (SELECT SUM(SALES)  FROM PLAN_GROUPDATA_PAL_MONTHLY_SUMMARY WITH(NOLOCK)  
                                                                     WHERE GROUPDATA_YEAR = @Year AND GROUPDATA_MONTH   <= @Month) AS groupMainPlanSalesSum
											 , (SELECT SALES  FROM PM_GROUPDATA_PAL_MONTHLY WITH(NOLOCK) 
                                                                    WHERE GROUPDATA_YEAR = @Year AND GROUPDATA_MONTH   = @Month  AND MONTHLY_TYPE = @MonthlyType) AS groupMainResultSalesSum
                                             ,E.SEQ         AS 'unionSeq'
                                                ,E.IS_USE
                                        FROM PM_PAL A
                                        LEFT OUTER JOIN PM_PAL_SUMMARY B ON A.SEQ = B.PM_PAL_SEQ
                                        LEFT OUTER JOIN (SELECT ORG_COMPANY_SEQ
				                                                 ,@Month AS MONTHLY
				                                                 ,SUM(SALES) AS SALES
				                                           FROM PLAN_MONTHLY_PAL A
				                                           LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS_MONTHLY_SUM B ON A.SEQ = B.PLAN_MONTHLY_PAL_SEQ
				                                           WHERE 1 = 1
                                                           AND A.REGIST_STATUS = @RegistStatus
                                                           AND A.MONTHLY_PAL_YEAR = @Year
				                                           AND B.MONTHLY <> '99' AND B.MONTHLY <= @Month
				                                           GROUP BY A.ORG_COMPANY_SEQ
                                        ) C ON A.ORG_COMPANY_SEQ = C.ORG_COMPANY_SEQ AND A.MONTHLY = C.MONTHLY
                                        LEFT OUTER JOIN ORG_COMPANY D ON A.ORG_COMPANY_SEQ = D.SEQ 
                                        LEFT OUTER JOIN ORG_UNION E ON D.ORG_UNION_SEQ = E.SEQ
                                        WHERE 1 = 1
                                        AND B.MONTHLY_TYPE = @MonthlyType
                                        AND A.REGIST_STATUS = @RegistStatus
                                        AND A.PAL_YEAR = @Year
                                        AND A.MONTHLY = @Month
                                        AND A.ORG_COMPANY_SEQ <> 13
                                        AND A.ORG_COMPANY_SEQ <> 19
                                        AND A.ORG_COMPANY_SEQ <> 14   
                                        AND A.ORG_COMPANY_SEQ <> 4 
                                        -- 사용중인 부문만 보이게 변경
                                        --AND E.IS_USE = 'Y'
                                        GROUP BY E.ORD, UNION_NAME, E.SEQ, E.IS_USE";

                    //string query = @" SELECT UNION_NAME	    AS 'unionName'
                    //                         ,SUM(B.SALES)  AS 'groupMainPlanSales'
                    //                         ,SUM(C.SALES)  AS 'groupMainResultSales'
                    //                    FROM PM_PAL A
                    //                    LEFT OUTER JOIN PM_PAL_SUMMARY B ON A.SEQ = B.PM_PAL_SEQ
                    //                    LEFT OUTER JOIN (SELECT ORG_COMPANY_SEQ
                    //                                 ,@Month AS MONTHLY
                    //                                 ,SUM(SALES) AS SALES
                    //                           FROM PLAN_MONTHLY_PAL A
                    //                           LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS_MONTHLY_SUM B ON A.SEQ = B.PLAN_MONTHLY_PAL_SEQ
                    //                           WHERE A.MONTHLY_PAL_YEAR = @Year
                    //                           AND B.MONTHLY <> '99' AND B.MONTHLY <= @Month
                    //                           GROUP BY A.ORG_COMPANY_SEQ
                    //                    ) C ON A.ORG_COMPANY_SEQ = C.ORG_COMPANY_SEQ AND A.MONTHLY = C.MONTHLY
                    //                    LEFT OUTER JOIN ORG_COMPANY D ON A.ORG_COMPANY_SEQ = D.SEQ 
                    //                    LEFT OUTER JOIN ORG_UNION E ON D.ORG_UNION_SEQ = E.SEQ
                    //                    WHERE B.MONTHLY_TYPE = @MonthlyType
                    //                    AND A.PAL_YEAR = @Year
                    //                    AND A.MONTHLY = @Month
                    //                    GROUP BY UNION_NAME";

                    return con.Query<GroupMain>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<GroupMain> groupMainSubSalesSumCalc(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    // 0 나누기 오류 수정
                    string query = @" SELECT CASE WHEN total = 0 THEN 0 ELSE ROUND(건설부문 / total * 100, 0) END AS 'groupMainBuildSales'
                                            ,CASE WHEN total = 0 THEN 0 ELSE ROUND(자동차부문 / total * 100, 0) END AS 'groupMainCarSales'
                                            ,CASE WHEN total = 0 THEN 0 ELSE ROUND(지주부문 / total * 100, 0) END AS 'groupMainCompanySales'
                                       FROM(
                                            SELECT UNION_NAME
                                                    ,ISNULL(SUM(B.SALES), 0) AS 'groupMainResultSales'
                                            FROM PM_PAL A
                                            LEFT OUTER JOIN PM_PAL_SUMMARY B ON A.SEQ = B.PM_PAL_SEQ
                                            LEFT OUTER JOIN (SELECT ORG_COMPANY_SEQ
				                                                 ,@Month AS MONTHLY
				                                                 ,SUM(SALES) AS SALES
				                                           FROM PLAN_MONTHLY_PAL A
				                                           LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS_MONTHLY_SUM B ON A.SEQ = B.PLAN_MONTHLY_PAL_SEQ
				                                           WHERE 1 = 1
                                                           AND A.REGIST_STATUS = @RegistStatus
                                                           AND A.MONTHLY_PAL_YEAR = @Year
				                                           AND B.MONTHLY <> '99' AND B.MONTHLY <= @Month
				                                           GROUP BY A.ORG_COMPANY_SEQ
	                                        ) C ON A.ORG_COMPANY_SEQ = C.ORG_COMPANY_SEQ AND A.MONTHLY = C.MONTHLY
                                            LEFT OUTER JOIN ORG_COMPANY E ON A.ORG_COMPANY_SEQ = E.SEQ
                                            LEFT OUTER JOIN ORG_UNION F ON E.ORG_UNION_SEQ = F.SEQ
                                            WHERE 1 = 1
                                            AND B.MONTHLY_TYPE = @MonthlyType
                                            AND A.REGIST_STATUS = @RegistStatus
                                            AND A.PAL_YEAR = @Year
                                            AND A.MONTHLY = @Month
                                            AND A.ORG_COMPANY_SEQ <> 19
                                        AND A.ORG_COMPANY_SEQ <> 14   
                                        AND A.ORG_COMPANY_SEQ <> 4 
                                        -- 사용중인 부문만 보이게 변경
                                        AND F.IS_USE = 'Y'
                                            GROUP BY F.ORD, UNION_NAME
                                            UNION
                                            SELECT 'total' AS 'total'
                                                    ,ISNULL(SUM(groupMainResultSales), 0) AS 'groupMainResultSales'
                                            FROM(
                                                SELECT UNION_NAME
                                                        ,ISNULL(SUM(B.SALES), 0) AS 'groupMainResultSales'
                                                FROM PM_PAL A
                                                LEFT OUTER JOIN PM_PAL_SUMMARY B ON A.SEQ = B.PM_PAL_SEQ
                                                LEFT OUTER JOIN (SELECT ORG_COMPANY_SEQ
				                                                 ,@Month AS MONTHLY
				                                                 ,SUM(SALES) AS SALES
				                                           FROM PLAN_MONTHLY_PAL A
				                                           LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS_MONTHLY_SUM B ON A.SEQ = B.PLAN_MONTHLY_PAL_SEQ
				                                           WHERE 1 = 1
                                                           AND A.REGIST_STATUS = @RegistStatus
                                                           AND A.MONTHLY_PAL_YEAR = @Year
				                                           AND B.MONTHLY <> '99' AND B.MONTHLY <= @Month
				                                           GROUP BY A.ORG_COMPANY_SEQ
		                                        ) C ON A.ORG_COMPANY_SEQ = C.ORG_COMPANY_SEQ AND A.MONTHLY = C.MONTHLY
                                                LEFT OUTER JOIN ORG_COMPANY E ON A.ORG_COMPANY_SEQ = E.SEQ
                                                LEFT OUTER JOIN ORG_UNION F ON E.ORG_UNION_SEQ = F.SEQ
                                                WHERE 1 = 1
                                                AND B.MONTHLY_TYPE = @MonthlyType
                                                AND A.REGIST_STATUS = @RegistStatus
                                                AND A.PAL_YEAR = @Year
                                                AND A.MONTHLY = @Month
                                                AND A.ORG_COMPANY_SEQ <> 19
                                                AND A.ORG_COMPANY_SEQ <> 14   
                                                AND A.ORG_COMPANY_SEQ <> 4 
                                        -- 사용중인 부문만 보이게 변경
                                        AND F.IS_USE = 'Y'
                                                GROUP BY F.ORD, UNION_NAME
                                            )A
                                        )B
                                        PIVOT(
                                            MIN(B.groupMainResultSales) FOR B.UNION_NAME IN (건설부문,자동차부문,지주부문,total)
                                        )C";

                    return con.Query<GroupMain>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        /// <summary>
        /// 2018.12.17 배당회사가 보여야하여 다시 변경
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        public IEnumerable<GroupMain> groupMainEbitSumCalc(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    // 2018.10.13 B는 실적, C 테이블은 계획인데 반대로 되어있네요.

                    string query = @" SELECT UNION_NAME	AS 'unionName'
                                              ,SUM(C.EBIT) AS 'groupMainPlanEbit'
                                              ,SUM(B.EBIT) AS 'groupMainResultEbit'
                                              ,SUM(C.SALES) AS 'groupMainPlanSales'
                                              ,SUM(B.SALES) AS 'groupMainResultSales'
                                              ,E.SEQ        AS 'unionSeq'
                                              ,E.IS_USE
                                        FROM PM_PAL A
                                        LEFT OUTER JOIN PM_PAL_SUMMARY B ON A.SEQ = B.PM_PAL_SEQ
                                        LEFT OUTER JOIN (SELECT ORG_COMPANY_SEQ
				                                                 ,@Month AS MONTHLY
				                                                 ,SUM(EBIT)  AS EBIT
                                                                 ,SUM(SALES) AS SALES
				                                           FROM PLAN_MONTHLY_PAL A
				                                           LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS_MONTHLY_SUM B ON A.SEQ = B.PLAN_MONTHLY_PAL_SEQ
				                                           WHERE 1 = 1 
                                                           AND A.REGIST_STATUS = @RegistStatus
                                                           AND A.MONTHLY_PAL_YEAR = @Year
				                                           AND B.MONTHLY <> '99' AND B.MONTHLY <= @Month
--AND A.ORG_COMPANY_SEQ NOT IN( 19,14)

				                                           GROUP BY A.ORG_COMPANY_SEQ
                                        ) C ON A.ORG_COMPANY_SEQ = C.ORG_COMPANY_SEQ AND A.MONTHLY = C.MONTHLY
                                        LEFT OUTER JOIN ORG_COMPANY D ON A.ORG_COMPANY_SEQ = D.SEQ 
                                        LEFT OUTER JOIN ORG_UNION E ON D.ORG_UNION_SEQ = E.SEQ

                                        WHERE 1 = 1
                                        AND B.MONTHLY_TYPE = @MonthlyType
                                        AND A.REGIST_STATUS = @RegistStatus
                                        AND A.PAL_YEAR = @Year
                                        AND A.MONTHLY = @Month
--AND A.ORG_COMPANY_SEQ NOT IN(14,19)

                                        -- 사용중인 부문만 보이게 변경
                                        --AND E.IS_USE = 'Y'
                                        GROUP BY E.ORD, UNION_NAME, E.SEQ, E.IS_USE";

                    //string query = @" SELECT UNION_NAME	AS 'unionName'
                    //                          ,SUM(B.EBIT) AS 'groupMainPlanEbit'
                    //                          ,SUM(C.EBIT) AS 'groupMainResultEbit'
                    //                          ,SUM(B.SALES) AS 'groupMainPlanSales'
                    //                          ,SUM(C.SALES) AS 'groupMainResultSales'
                    //                    FROM PM_PAL A
                    //                    LEFT OUTER JOIN PM_PAL_SUMMARY B ON A.SEQ = B.PM_PAL_SEQ
                    //                    LEFT OUTER JOIN (SELECT ORG_COMPANY_SEQ
				                //                                 ,@Month AS MONTHLY
				                //                                 ,SUM(EBIT)  AS EBIT
                    //                                             ,SUM(SALES) AS SALES
				                //                           FROM PLAN_MONTHLY_PAL A
				                //                           LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS_MONTHLY_SUM B ON A.SEQ = B.PLAN_MONTHLY_PAL_SEQ
				                //                           WHERE A.MONTHLY_PAL_YEAR = @Year
				                //                           AND B.MONTHLY <> '99' AND B.MONTHLY <= @Month
				                //                           GROUP BY A.ORG_COMPANY_SEQ
                    //                    ) C ON A.ORG_COMPANY_SEQ = C.ORG_COMPANY_SEQ AND A.MONTHLY = C.MONTHLY
                    //                    LEFT OUTER JOIN ORG_COMPANY D ON A.ORG_COMPANY_SEQ = D.SEQ 
                    //                    LEFT OUTER JOIN ORG_UNION E ON D.ORG_UNION_SEQ = E.SEQ
                    //                    WHERE B.MONTHLY_TYPE = @MonthlyType
                    //                    AND A.PAL_YEAR = @Year
                    //                    AND A.MONTHLY = @Month
                    //                    GROUP BY UNION_NAME";

                    return con.Query<GroupMain>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        /// <summary>
        /// 2018.12.17 배당회사가 보여야하여 다시 변경
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        public IEnumerable<GroupMain> groupMainEbitSumCalc_NEW(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    // 2018.10.13 B는 실적, C 테이블은 계획인데 반대로 되어있네요.

                    string query = @" SELECT UNION_NAME	AS 'unionName'
                                              ,SUM(C.EBIT) AS 'groupMainPlanEbit'
                                              ,SUM(B.EBIT) AS 'groupMainResultEbit'
                                              ,SUM(C.SALES) AS 'groupMainPlanSales'
                                              ,SUM(B.SALES) AS 'groupMainResultSales'
                                              , (SELECT  SUM(SALES)  FROM PLAN_GROUPDATA_PAL_MONTHLY_SUMMARY WITH(NOLOCK)  
                                                              WHERE GROUPDATA_YEAR = @Year AND GROUPDATA_MONTH   <= @Month) AS groupMainPlanSalesSum
                                              , (SELECT SALES  FROM PM_GROUPDATA_PAL_MONTHLY WITH(NOLOCK) 
                                                              WHERE GROUPDATA_YEAR = @Year AND GROUPDATA_MONTH   = @Month  AND MONTHLY_TYPE = @MonthlyType) AS groupMainResultSalesSum
                                              , (SELECT SUM(EBIT)  FROM PLAN_GROUPDATA_PAL_MONTHLY_SUMMARY WITH(NOLOCK)  
                                                              WHERE GROUPDATA_YEAR = @Year AND GROUPDATA_MONTH   <= @Month) AS groupMainPlanEbitSum
                                              , (SELECT EBIT  FROM PM_GROUPDATA_PAL_MONTHLY WITH(NOLOCK) 
                                                              WHERE GROUPDATA_YEAR = @Year AND GROUPDATA_MONTH   = @Month  AND MONTHLY_TYPE = @MonthlyType) AS groupMainResultEbitSum
                                              ,E.SEQ        AS 'unionSeq'
                                              ,E.IS_USE
                                        FROM PM_PAL A
                                        LEFT OUTER JOIN PM_PAL_SUMMARY B ON A.SEQ = B.PM_PAL_SEQ
                                        LEFT OUTER JOIN (SELECT ORG_COMPANY_SEQ
				                                                 ,@Month AS MONTHLY
				                                                 ,SUM(EBIT)  AS EBIT
                                                                 ,SUM(SALES) AS SALES
				                                           FROM PLAN_MONTHLY_PAL A
				                                           LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS_MONTHLY_SUM B ON A.SEQ = B.PLAN_MONTHLY_PAL_SEQ
				                                           WHERE 1 = 1 
                                                           AND A.REGIST_STATUS = @RegistStatus
                                                           AND A.MONTHLY_PAL_YEAR = @Year
				                                           AND B.MONTHLY <> '99' AND B.MONTHLY <= @Month
				                                           GROUP BY A.ORG_COMPANY_SEQ
                                        ) C ON A.ORG_COMPANY_SEQ = C.ORG_COMPANY_SEQ AND A.MONTHLY = C.MONTHLY
                                        LEFT OUTER JOIN ORG_COMPANY D ON A.ORG_COMPANY_SEQ = D.SEQ 
                                        LEFT OUTER JOIN ORG_UNION E ON D.ORG_UNION_SEQ = E.SEQ
                                        WHERE 1 = 1
                                        AND B.MONTHLY_TYPE = @MonthlyType
                                        AND A.REGIST_STATUS = @RegistStatus
                                        AND A.PAL_YEAR = @Year
                                        AND A.MONTHLY = @Month
                                        AND A.ORG_COMPANY_SEQ <> 13
                                        --2022.04.12 추가
                                        AND A.ORG_COMPANY_SEQ <> 19
                                        AND A.ORG_COMPANY_SEQ <> 14   
                                        AND A.ORG_COMPANY_SEQ <> 4 
                                        -- 사용중인 부문만 보이게 변경
                                        --AND E.IS_USE = 'Y'
                                        GROUP BY E.ORD, UNION_NAME, E.SEQ, E.IS_USE";

                    //string query = @" SELECT UNION_NAME	AS 'unionName'
                    //                          ,SUM(B.EBIT) AS 'groupMainPlanEbit'
                    //                          ,SUM(C.EBIT) AS 'groupMainResultEbit'
                    //                          ,SUM(B.SALES) AS 'groupMainPlanSales'
                    //                          ,SUM(C.SALES) AS 'groupMainResultSales'
                    //                    FROM PM_PAL A
                    //                    LEFT OUTER JOIN PM_PAL_SUMMARY B ON A.SEQ = B.PM_PAL_SEQ
                    //                    LEFT OUTER JOIN (SELECT ORG_COMPANY_SEQ
                    //                                 ,@Month AS MONTHLY
                    //                                 ,SUM(EBIT)  AS EBIT
                    //                                             ,SUM(SALES) AS SALES
                    //                           FROM PLAN_MONTHLY_PAL A
                    //                           LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS_MONTHLY_SUM B ON A.SEQ = B.PLAN_MONTHLY_PAL_SEQ
                    //                           WHERE A.MONTHLY_PAL_YEAR = @Year
                    //                           AND B.MONTHLY <> '99' AND B.MONTHLY <= @Month
                    //                           GROUP BY A.ORG_COMPANY_SEQ
                    //                    ) C ON A.ORG_COMPANY_SEQ = C.ORG_COMPANY_SEQ AND A.MONTHLY = C.MONTHLY
                    //                    LEFT OUTER JOIN ORG_COMPANY D ON A.ORG_COMPANY_SEQ = D.SEQ 
                    //                    LEFT OUTER JOIN ORG_UNION E ON D.ORG_UNION_SEQ = E.SEQ
                    //                    WHERE B.MONTHLY_TYPE = @MonthlyType
                    //                    AND A.PAL_YEAR = @Year
                    //                    AND A.MONTHLY = @Month
                    //                    GROUP BY UNION_NAME";

                    return con.Query<GroupMain>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }
        public IEnumerable<GroupMain> groupMainSubEbitSumCalc(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" SELECT CASE WHEN total = 0 THEN 0 ELSE ISNULL(ROUND(건설부문 / total * 100, 0), 0) END AS 'groupMainBuildEbit'
                                                 ,CASE WHEN total = 0 THEN 0 ELSE ISNULL(ROUND(자동차부문 / total * 100, 0), 0) END AS 'groupMainCarEbit'
                                                 ,CASE WHEN total = 0 THEN 0 ELSE ISNULL(ROUND(지주부문 / total * 100, 0), 0) END AS 'groupMainCompanyEbit'
                                        FROM(
                                            SELECT UNION_NAME
                                                    ,ISNULL(SUM(B.EBIT), 0) AS 'groupMainResultEbit'
                                            FROM PM_PAL A
                                            LEFT OUTER JOIN PM_PAL_SUMMARY B ON A.SEQ = B.PM_PAL_SEQ
                                            LEFT OUTER JOIN (SELECT ORG_COMPANY_SEQ
				                                                 ,@Month AS MONTHLY
				                                                 ,SUM(EBIT) AS SALES
				                                           FROM PLAN_MONTHLY_PAL A
				                                           LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS_MONTHLY_SUM B ON A.SEQ = B.PLAN_MONTHLY_PAL_SEQ
				                                           WHERE A.MONTHLY_PAL_YEAR = @Year
				                                           AND B.MONTHLY <> '99' AND B.MONTHLY <= @Month
				                                           GROUP BY A.ORG_COMPANY_SEQ
	                                        ) C ON A.ORG_COMPANY_SEQ = C.ORG_COMPANY_SEQ AND A.MONTHLY = C.MONTHLY
                                            LEFT OUTER JOIN ORG_COMPANY E ON A.ORG_COMPANY_SEQ = E.SEQ
                                            LEFT OUTER JOIN ORG_UNION F ON E.ORG_UNION_SEQ = F.SEQ
                                            WHERE 1 = 1 
                                            AND B.MONTHLY_TYPE = @MonthlyType
                                            AND A.REGIST_STATUS = @RegistStatus
                                            AND A.PAL_YEAR = @Year
                                            AND A.MONTHLY = @Month
                                            AND A.ORG_COMPANY_SEQ <> 19
                                            AND A.ORG_COMPANY_SEQ <> 14   
                                            AND A.ORG_COMPANY_SEQ <> 4 
                                        -- 사용중인 부문만 보이게 변경
                                        AND F.IS_USE = 'Y'
                                            GROUP BY F.ORD, UNION_NAME
                                            UNION
                                            SELECT 'total' AS 'total'
                                                    ,ISNULL(SUM(groupMainResultEbit), 0) AS 'groupMainResultEbit'
                                            FROM(
                                                SELECT UNION_NAME
                                                        ,ISNULL(SUM(B.EBIT), 0) AS 'groupMainResultEbit'
                                                FROM PM_PAL A
                                                LEFT OUTER JOIN PM_PAL_SUMMARY B ON A.SEQ = B.PM_PAL_SEQ
                                                LEFT OUTER JOIN (SELECT ORG_COMPANY_SEQ
				                                                 ,@Month AS MONTHLY
				                                                 ,SUM(EBIT) AS SALES
				                                           FROM PLAN_MONTHLY_PAL A
				                                           LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS_MONTHLY_SUM B ON A.SEQ = B.PLAN_MONTHLY_PAL_SEQ
				                                           WHERE A.MONTHLY_PAL_YEAR = @Year
				                                           AND B.MONTHLY <> '99' AND B.MONTHLY <= @Month
				                                           GROUP BY A.ORG_COMPANY_SEQ
		                                        ) C ON A.ORG_COMPANY_SEQ = C.ORG_COMPANY_SEQ AND A.MONTHLY = C.MONTHLY
                                                LEFT OUTER JOIN ORG_COMPANY E ON A.ORG_COMPANY_SEQ = E.SEQ
                                                LEFT OUTER JOIN ORG_UNION F ON E.ORG_UNION_SEQ = F.SEQ
                                                WHERE 1 = 1
                                                AND B.MONTHLY_TYPE = @MonthlyType
                                                AND A.REGIST_STATUS = @RegistStatus
                                                AND A.PAL_YEAR = @Year
                                                AND A.MONTHLY = @Month
                                                AND A.ORG_COMPANY_SEQ <> 19
                                                AND A.ORG_COMPANY_SEQ <> 14   
                                                AND A.ORG_COMPANY_SEQ <> 4 
                                        -- 사용중인 부문만 보이게 변경
                                        AND F.IS_USE = 'Y'
                                                GROUP BY F.ORD, UNION_NAME
                                            )A
                                        )B
                                        PIVOT(
                                            MIN(B.groupMainResultEbit) FOR B.UNION_NAME IN (건설부문,자동차부문,지주부문,total)
                                        )C";

                    return con.Query<GroupMain>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        #endregion

        #region << 손익(연간예상) >>

        /// <summary>
        /// 연간예상손익 - Sales 누계실적(계획, 실적)
        /// 2018.12.17 추가된 배당회사합계값이 보여야 하여 변경
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        public IEnumerable<GroupMain> groupMainExpectSales(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" SELECT UNION_NAME			    AS 'unionName'
	                                        ,ISNULL(SUM(C.SALES),0) AS 'groupMainExpectPlanSales'
	                                        ,ISNULL(SUM(B.SALES),0) AS 'groupMainExpectResultSales'
                                            ,E.SEQ                  AS 'unionSeq'
                                            ,E.IS_USE
                                        FROM PM_PAL A
                                        LEFT OUTER JOIN PM_PAL_SUMMARY B ON A.SEQ = B.PM_PAL_SEQ 
                                        LEFT OUTER JOIN(SELECT A.ORG_COMPANY_SEQ
					                                          ,SUM(B.SALES) AS SALES
					                                          ,@Month AS MONTHLY
				                                        FROM PLAN_MONTHLY_PAL A
				                                        LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS_MONTHLY_SUM B ON A.SEQ = B.PLAN_MONTHLY_PAL_SEQ
				                                        WHERE A.MONTHLY_PAL_YEAR = @Year
				                                        AND B.MONTHLY <> '99' AND B.MONTHLY <= @Month
				                                        GROUP BY ORG_COMPANY_SEQ) C ON A.ORG_COMPANY_SEQ = C.ORG_COMPANY_SEQ AND A.MONTHLY = C.MONTHLY
                                        LEFT OUTER JOIN ORG_COMPANY D ON A.ORG_COMPANY_SEQ = D.SEQ
                                        LEFT OUTER JOIN ORG_UNION E ON D.ORG_UNION_SEQ = E.SEQ
                                        WHERE 1 = 1
                                        AND B.MONTHLY_TYPE = @MonthlyType
                                        AND A.REGIST_STATUS = @RegistStatus
                                        AND A.PAL_YEAR = @Year
                                        AND A.MONTHLY = @Month
                                        -- 사용중인 부문만 보이게 변경
                                        -- AND E.IS_USE = 'Y'
                                        GROUP BY E.ORD, UNION_NAME, E.SEQ,E.IS_USE ";

                    return con.Query<GroupMain>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        /// <summary>
        /// 연간예상손익 - Sales 누계실적(계획, 실적)
        /// 2018.12.17 추가된 배당회사합계값이 보여야 하여 변경
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        public IEnumerable<GroupMain> groupMainExpectSales_NEW(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" SELECT UNION_NAME			    AS 'unionName'
	                                        ,ISNULL(SUM(C.SALES),0) AS 'groupMainExpectPlanSales'
	                                        ,ISNULL(SUM(B.SALES),0) AS 'groupMainExpectResultSales'
                                             , (SELECT SUM(SALES)  FROM PLAN_GROUPDATA_PAL_MONTHLY_SUMMARY WITH(NOLOCK)  
                                                                     WHERE GROUPDATA_YEAR = @Year AND GROUPDATA_MONTH  <= @Month) AS groupMainPlanSalesSum
											 , (SELECT SALES  FROM PM_GROUPDATA_PAL_MONTHLY WITH(NOLOCK) 
                                                                    WHERE GROUPDATA_YEAR = @Year AND GROUPDATA_MONTH   = @Month  AND MONTHLY_TYPE = @MonthlyType) AS groupMainResultSalesSum
                                            ,E.SEQ                  AS 'unionSeq'
                                            ,E.IS_USE
                                        FROM PM_PAL A
                                        LEFT OUTER JOIN PM_PAL_SUMMARY B ON A.SEQ = B.PM_PAL_SEQ 
                                        LEFT OUTER JOIN(SELECT A.ORG_COMPANY_SEQ
					                                          ,SUM(B.SALES) AS SALES
					                                          ,@Month AS MONTHLY
				                                        FROM PLAN_MONTHLY_PAL A
				                                        LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS_MONTHLY_SUM B ON A.SEQ = B.PLAN_MONTHLY_PAL_SEQ
				                                        WHERE A.MONTHLY_PAL_YEAR = @Year
				                                        AND B.MONTHLY <> '99' AND B.MONTHLY <= @Month
				                                        GROUP BY ORG_COMPANY_SEQ) C ON A.ORG_COMPANY_SEQ = C.ORG_COMPANY_SEQ AND A.MONTHLY = C.MONTHLY
                                        LEFT OUTER JOIN ORG_COMPANY D ON A.ORG_COMPANY_SEQ = D.SEQ
                                        LEFT OUTER JOIN ORG_UNION E ON D.ORG_UNION_SEQ = E.SEQ
                                        WHERE 1 = 1
                                        AND B.MONTHLY_TYPE = @MonthlyType
                                        AND A.REGIST_STATUS = @RegistStatus
                                        AND A.PAL_YEAR = @Year
                                        AND A.MONTHLY = @Month
                                        AND A.ORG_COMPANY_SEQ <> 13
                                        -- 사용중인 부문만 보이게 변경
                                        -- AND E.IS_USE = 'Y'
                                        GROUP BY E.ORD, UNION_NAME, E.SEQ,E.IS_USE ";

                    return con.Query<GroupMain>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        /// <summary>
        /// 연간예상손익 - Sales 누계실적(전년)
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        public IEnumerable<GroupMain> groupMainPreYearExpectSales(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" SELECT UNION_NAME
                                            ,SUM(B.SALES) AS 'groupMainExpectResultSales'
                                            ,D.SEQ        AS 'unionSeq'
                                            ,D.IS_USE
                                        FROM PM_PAL A
                                        LEFT OUTER JOIN PM_PAL_SUMMARY B ON A.SEQ = B.PM_PAL_SEQ
                                        LEFT OUTER JOIN ORG_COMPANY C ON A.ORG_COMPANY_SEQ = C.SEQ
                                        LEFT OUTER JOIN ORG_UNION D ON C.ORG_UNION_SEQ = D.SEQ
                                        WHERE 1 = 1 
                                        AND B.MONTHLY_TYPE = @MonthlyType
                                        AND A.REGIST_STATUS = @RegistStatus
                                        AND A.PAL_YEAR = @Year
                                        AND A.MONTHLY <> '99' AND A.MONTHLY = @Month
                                        -- 사용중인 부문만 보이게 변경
                                        -- AND D.IS_USE = 'Y'
GROUP BY D.ORD, UNION_NAME, D.SEQ, D.IS_USE";

                    return con.Query<GroupMain>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        /// <summary>
        /// 연간예상손익 - Sales 연간예상 (계획, 실적)
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        public IEnumerable<GroupMain> groupMainExpectYearSales(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" SELECT UNION_NAME			      AS 'unionName'
	                                          ,ISNULL(SUM(C.SALES),0) AS 'groupMainExpectYearPlanSales'
	                                          ,ISNULL(SUM(B.SALES),0) AS 'groupMainExpectYearResultSales'
                                              ,E.SEQ                  AS 'unionSeq'
                                                ,E.IS_USE
                                        FROM PM_PAL A
                                        LEFT OUTER JOIN PM_PAL_SUMMARY B ON A.SEQ = B.PM_PAL_SEQ 
                                        LEFT OUTER JOIN(SELECT A.ORG_COMPANY_SEQ
					                                          ,SUM(B.SALES) AS SALES
					                                          ,@Month AS MONTHLY
				                                        FROM PLAN_MONTHLY_PAL A
				                                        LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS_MONTHLY_SUM B ON A.SEQ = B.PLAN_MONTHLY_PAL_SEQ
				                                        WHERE A.MONTHLY_PAL_YEAR = @Year
				                                        AND B.MONTHLY <> '99' AND B.MONTHLY <= '12' -- 당해년도 12월까지 합산을 하기 위한 조건
				                                        GROUP BY ORG_COMPANY_SEQ) C ON A.ORG_COMPANY_SEQ = C.ORG_COMPANY_SEQ AND A.MONTHLY = C.MONTHLY
                                        LEFT OUTER JOIN ORG_COMPANY D ON A.ORG_COMPANY_SEQ = D.SEQ
                                        LEFT OUTER JOIN ORG_UNION E ON D.ORG_UNION_SEQ = E.SEQ
                                        WHERE 1 = 1
                                        AND B.MONTHLY_TYPE = @MonthlyType
                                        AND A.REGIST_STATUS = @RegistStatus
                                        AND A.PAL_YEAR = @Year
                                        AND A.MONTHLY = @Month
                                        -- 사용중인 부문만 보이게 변경
                                        -- AND E.IS_USE = 'Y'
                                        GROUP BY E.ORD, UNION_NAME, E.SEQ, E.IS_USE";

                    return con.Query<GroupMain>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }
        /// <summary>
        /// 연간예상손익 - Sales 연간예상 (계획, 실적)
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        public IEnumerable<GroupMain> groupMainExpectYearSales_NEW(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" SELECT UNION_NAME			      AS 'unionName'
	                                          ,ISNULL(SUM(C.SALES),0) AS 'groupMainExpectYearPlanSales'
	                                          ,ISNULL(SUM(B.SALES),0) AS 'groupMainExpectYearResultSales'
                                              ,ISNULL((SELECT SUM(ISNULL(SALES,0))  FROM PLAN_GROUPDATA_PAL_MONTHLY_SUMMARY WITH(NOLOCK)  
                                                                     WHERE GROUPDATA_YEAR = @Year AND GROUPDATA_MONTH  <= '12'),0) AS groupMainPlanSalesSum
											 , ISNULL((SELECT SALES  FROM PM_GROUPDATA_PAL_MONTHLY WITH(NOLOCK) 
                                                                    WHERE GROUPDATA_YEAR = @Year AND GROUPDATA_MONTH   = @Month  AND MONTHLY_TYPE = @MonthlyType),0) AS groupMainResultSalesSum
                                                 
                                              ,E.SEQ                  AS 'unionSeq'
                                                ,E.IS_USE
                                        FROM PM_PAL A
                                        LEFT OUTER JOIN PM_PAL_SUMMARY B ON A.SEQ = B.PM_PAL_SEQ 
                                        LEFT OUTER JOIN(SELECT A.ORG_COMPANY_SEQ
					                                          ,SUM(B.SALES) AS SALES
					                                          ,@Month AS MONTHLY
				                                        FROM PLAN_MONTHLY_PAL A
				                                        LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS_MONTHLY_SUM B ON A.SEQ = B.PLAN_MONTHLY_PAL_SEQ
				                                        WHERE A.MONTHLY_PAL_YEAR = @Year
				                                        AND B.MONTHLY <> '99' AND B.MONTHLY <= '12' -- 당해년도 12월까지 합산을 하기 위한 조건
				                                        GROUP BY ORG_COMPANY_SEQ) C ON A.ORG_COMPANY_SEQ = C.ORG_COMPANY_SEQ AND A.MONTHLY = C.MONTHLY
                                        LEFT OUTER JOIN ORG_COMPANY D ON A.ORG_COMPANY_SEQ = D.SEQ
                                        LEFT OUTER JOIN ORG_UNION E ON D.ORG_UNION_SEQ = E.SEQ
                                        WHERE 1 = 1
                                        AND B.MONTHLY_TYPE = @MonthlyType
                                        AND A.REGIST_STATUS = @RegistStatus
                                        AND A.PAL_YEAR = @Year
                                        AND A.MONTHLY = @Month
                                        -- 사용중인 부문만 보이게 변경
                                        -- AND E.IS_USE = 'Y'
                                        GROUP BY E.ORD, UNION_NAME, E.SEQ, E.IS_USE";

                    return con.Query<GroupMain>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        /// <summary>
        /// 연간예상손익 - Sales 연간예상(전년)
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        public IEnumerable<GroupMain> groupMainPreYearExpectYearSales(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" SELECT UNION_NAME
                                            ,SUM(B.SALES) AS 'groupMainExpectYearResultSales'
                                            ,D.SEQ        AS 'unionSeq'
                                            ,D.IS_USE
                                        FROM PM_PAL A
                                        LEFT OUTER JOIN PM_PAL_SUMMARY B ON A.SEQ = B.PM_PAL_SEQ
                                        LEFT OUTER JOIN ORG_COMPANY C ON A.ORG_COMPANY_SEQ = C.SEQ
                                        LEFT OUTER JOIN ORG_UNION D ON C.ORG_UNION_SEQ = D.SEQ
                                        WHERE 1 = 1
                                        AND B.MONTHLY_TYPE = @MonthlyType
                                        AND A.REGIST_STATUS = @RegistStatus
                                        AND A.PAL_YEAR = @Year
                                        AND A.MONTHLY <> '99' AND A.MONTHLY = '12' -- 당해년도 12월까지 합산을 하기 위한 조건
                                        -- 사용중인 부문만 보이게 변경
                                        -- AND D.IS_USE = 'Y'
GROUP BY D.ORD, UNION_NAME, D.SEQ, D.IS_USE";

                    return con.Query<GroupMain>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        /// <summary>
        /// 연간예상손익 - Sales 잔여월(계획, 실적)
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        public IEnumerable<GroupMain> groupMainExpectRestSales(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" SELECT *
	                                    FROM(
		                                    SELECT @MonthlyTypeFirst	  AS 'restSalesKind' 
			                                      ,UNION_NAME			  AS 'unionName'
			                                      ,ISNULL(SUM(C.SALES),0) AS 'groupMainExpectPlanSales'
			                                      ,ISNULL(SUM(B.SALES),0) AS 'groupMainExpectResultSales'
                                                  ,E.SEQ                  AS 'unionSeq'
                                                    ,E.IS_USE
		                                    FROM PM_PAL A
		                                    LEFT OUTER JOIN PM_PAL_SUMMARY B ON A.SEQ = B.PM_PAL_SEQ 
		                                    LEFT OUTER JOIN(SELECT A.ORG_COMPANY_SEQ
							                                      ,SUM(B.SALES) AS SALES
							                                      ,@Month AS MONTHLY
						                                    FROM PLAN_MONTHLY_PAL A
						                                    LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS_MONTHLY_SUM B ON A.SEQ = B.PLAN_MONTHLY_PAL_SEQ
						                                    WHERE A.MONTHLY_PAL_YEAR = @Year
						                                    AND B.MONTHLY <> '99' AND B.MONTHLY <= '12'
						                                    GROUP BY ORG_COMPANY_SEQ) C ON A.ORG_COMPANY_SEQ = C.ORG_COMPANY_SEQ AND A.MONTHLY = C.MONTHLY
		                                    LEFT OUTER JOIN ORG_COMPANY D ON A.ORG_COMPANY_SEQ = D.SEQ
		                                    LEFT OUTER JOIN ORG_UNION E ON D.ORG_UNION_SEQ = E.SEQ
		                                    WHERE 1 = 1 
                                            AND B.MONTHLY_TYPE = @MonthlyTypeFirst
                                            AND A.REGIST_STATUS = @RegistStatus
		                                    AND A.PAL_YEAR = @Year
		                                    AND A.MONTHLY = @Month
                                        -- 사용중인 부문만 보이게 변경
                                        -- AND E.IS_USE = 'Y'
		                                    GROUP BY E.ORD, UNION_NAME, E.SEQ,E.IS_USE
		                                    UNION
		                                    SELECT @MonthlyTypeSecond	  AS 'restSalesKind' 
			                                      ,UNION_NAME			  AS 'unionName'
			                                      ,ISNULL(SUM(C.SALES),0) AS 'groupMainExpectPlanSales'
			                                      ,ISNULL(SUM(B.SALES),0) AS 'groupMainExpectResultSales'
                                                  ,E.SEQ                  AS 'unionSeq'
                                                    ,E.IS_USE
		                                    FROM PM_PAL A
		                                    LEFT OUTER JOIN PM_PAL_SUMMARY B ON A.SEQ = B.PM_PAL_SEQ 
		                                    LEFT OUTER JOIN(SELECT A.ORG_COMPANY_SEQ
							                                      ,SUM(B.SALES) AS SALES
							                                      ,@Month AS MONTHLY
						                                    FROM PLAN_MONTHLY_PAL A
						                                    LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS_MONTHLY_SUM B ON A.SEQ = B.PLAN_MONTHLY_PAL_SEQ
						                                    WHERE A.MONTHLY_PAL_YEAR = @Year
						                                    AND B.MONTHLY <> '99' AND B.MONTHLY <= @Month
						                                    GROUP BY ORG_COMPANY_SEQ) C ON A.ORG_COMPANY_SEQ = C.ORG_COMPANY_SEQ AND A.MONTHLY = C.MONTHLY
		                                    LEFT OUTER JOIN ORG_COMPANY D ON A.ORG_COMPANY_SEQ = D.SEQ
		                                    LEFT OUTER JOIN ORG_UNION E ON D.ORG_UNION_SEQ = E.SEQ
		                                    WHERE 1 = 1 
                                            AND B.MONTHLY_TYPE = @MonthlyTypeSecond
                                            AND A.REGIST_STATUS = @RegistStatus
		                                    AND A.PAL_YEAR = @Year
		                                    AND A.MONTHLY = @Month
                                        -- 사용중인 부문만 보이게 변경
                                        -- AND E.IS_USE = 'Y'
		                                    GROUP BY E.ORD, UNION_NAME, E.SEQ, E.IS_USE
	                                    ) A
	                                    ORDER BY restSalesKind DESC, unionName DESC ";

                    return con.Query<GroupMain>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        /// <summary>
        /// 연간예상손익 - Sales 잔여월(전년)
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        public IEnumerable<GroupMain> groupMainPreYearExpectRestSales(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" SELECT *
                                        FROM(
	                                        SELECT '30'			AS 'restSalesKind'
		                                          ,UNION_NAME                   AS 'unionName'
		                                          ,SUM(B.SALES)                 AS 'groupMainExpectResultSales'
                                                  ,D.SEQ                        AS 'unionSeq'
                                                    ,D.IS_USE
	                                        FROM PM_PAL A
	                                        LEFT OUTER JOIN PM_PAL_SUMMARY B ON A.SEQ = B.PM_PAL_SEQ
	                                        LEFT OUTER JOIN ORG_COMPANY C ON A.ORG_COMPANY_SEQ = C.SEQ
	                                        LEFT OUTER JOIN ORG_UNION D ON C.ORG_UNION_SEQ = D.SEQ
	                                        WHERE 1 = 1
                                            AND B.MONTHLY_TYPE = @MonthlyTypeFirst
                                            AND A.REGIST_STATUS = @RegistStatus
	                                        AND A.PAL_YEAR = @Year
	                                        AND A.MONTHLY <> '99' AND A.MONTHLY = '12' -- 당해년도 12월까지 합산을 하기 위한 조건
                                        -- 사용중인 부문만 보이게 변경
                                        AND D.IS_USE = 'Y'
	                                        GROUP BY D.ORD, UNION_NAME, D.SEQ, D.IS_USE
	                                        UNION
	                                        SELECT '20'			AS 'restSalesKind'
		                                          ,UNION_NAME                   AS 'unionName'
		                                          ,SUM(B.SALES)                 AS 'groupMainExpectResultSales'
                                                  ,D.SEQ                        AS 'unionSeq'
                                                    ,D.IS_USE
	                                        FROM PM_PAL A
	                                        LEFT OUTER JOIN PM_PAL_SUMMARY B ON A.SEQ = B.PM_PAL_SEQ
	                                        LEFT OUTER JOIN ORG_COMPANY C ON A.ORG_COMPANY_SEQ = C.SEQ
	                                        LEFT OUTER JOIN ORG_UNION D ON C.ORG_UNION_SEQ = D.SEQ
	                                        WHERE 1 = 1
                                            AND B.MONTHLY_TYPE = @MonthlyTypeSecond
                                            AND A.REGIST_STATUS = @RegistStatus
	                                        AND A.PAL_YEAR = @Year
	                                        AND A.MONTHLY <> '99' AND A.MONTHLY = @Month
                                        -- 사용중인 부문만 보이게 변경
                                        AND D.IS_USE = 'Y'
	                                        GROUP BY D.ORD, UNION_NAME, D.SEQ, D.IS_USE
                                        )A
                                        ORDER BY restSalesKind DESC ";

                    return con.Query<GroupMain>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        /// <summary>
        /// 연간예상손익 - Ebit 누계실적(계획,실적)
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        public IEnumerable<GroupMain> groupMainExpectEbit(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" SELECT UNION_NAME			    AS 'unionName'
	                                        ,ISNULL(SUM(C.EBIT),0) AS 'groupMainExpectPlanEbit'
	                                        ,ISNULL(SUM(B.EBIT),0) AS 'groupMainExpectResultEbit'
                                            ,ISNULL(SUM(C.SALES),0) AS 'groupMainExpectPlanSales'
	                                        ,ISNULL(SUM(B.SALES),0) AS 'groupMainExpectResultSales'
                                            ,E.SEQ                  AS 'unionSeq'
                                            ,D.IS_USE
                                        FROM PM_PAL A
                                        LEFT OUTER JOIN PM_PAL_SUMMARY B ON A.SEQ = B.PM_PAL_SEQ 
                                        LEFT OUTER JOIN(SELECT A.ORG_COMPANY_SEQ
					                                          ,SUM(B.EBIT) AS EBIT
                                                              ,SUM(B.SALES) AS SALES
					                                          ,@Month AS MONTHLY
				                                        FROM PLAN_MONTHLY_PAL A
				                                        LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS_MONTHLY_SUM B ON A.SEQ = B.PLAN_MONTHLY_PAL_SEQ
				                                        WHERE A.MONTHLY_PAL_YEAR = @Year
				                                        AND B.MONTHLY <> '99' AND B.MONTHLY <= @Month
				                                        GROUP BY ORG_COMPANY_SEQ) C ON A.ORG_COMPANY_SEQ = C.ORG_COMPANY_SEQ AND A.MONTHLY = C.MONTHLY
                                        LEFT OUTER JOIN ORG_COMPANY D ON A.ORG_COMPANY_SEQ = D.SEQ
                                        LEFT OUTER JOIN ORG_UNION E ON D.ORG_UNION_SEQ = E.SEQ
                                        WHERE B.MONTHLY_TYPE = @MonthlyType
                                        AND A.REGIST_STATUS = @RegistStatus
                                        AND A.PAL_YEAR = @Year
                                        AND A.MONTHLY = @Month
                                        -- 사용중인 부문만 보이게 변경
                                        -- AND E.IS_USE = 'Y'
                                        GROUP BY E.ORD, UNION_NAME, E.SEQ,D.IS_USE ";

                    return con.Query<GroupMain>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        /// <summary>
        /// 연간예상손익 - Ebit 누계실적(계획,실적)
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        public IEnumerable<GroupMain> groupMainExpectEbit_NEW(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" SELECT UNION_NAME			    AS 'unionName'
	                                        ,ISNULL(SUM(C.EBIT),0) AS 'groupMainExpectPlanEbit'
	                                        ,ISNULL(SUM(B.EBIT),0) AS 'groupMainExpectResultEbit'
                                            ,ISNULL(SUM(C.SALES),0) AS 'groupMainExpectPlanSales'
	                                        ,ISNULL(SUM(B.SALES),0) AS 'groupMainExpectResultSales'
                                            , ISNULL((SELECT  SUM(SALES)  FROM PLAN_GROUPDATA_PAL_MONTHLY_SUMMARY WITH(NOLOCK)  
                                                              WHERE GROUPDATA_YEAR = @Year AND GROUPDATA_MONTH   <= @Month),0) AS groupMainPlanSalesSum
                                            , ISNULL((SELECT SALES  FROM PM_GROUPDATA_PAL_MONTHLY WITH(NOLOCK) 
                                                              WHERE GROUPDATA_YEAR = @Year AND GROUPDATA_MONTH   = @Month  AND MONTHLY_TYPE = @MonthlyType),0) AS groupMainResultSalesSum
                                            , ISNULL((SELECT SUM(EBIT)  FROM PLAN_GROUPDATA_PAL_MONTHLY_SUMMARY WITH(NOLOCK)  
                                                              WHERE GROUPDATA_YEAR = @Year AND GROUPDATA_MONTH   <= @Month),0) AS groupMainPlanEbitSum
                                            , ISNULL((SELECT EBIT  FROM PM_GROUPDATA_PAL_MONTHLY WITH(NOLOCK) 
                                                              WHERE GROUPDATA_YEAR = @Year AND GROUPDATA_MONTH   = @Month  AND MONTHLY_TYPE = @MonthlyType),0) AS groupMainResultEbitSum

                                            ,E.SEQ                  AS 'unionSeq'
                                            ,D.IS_USE
                                        FROM PM_PAL A
                                        LEFT OUTER JOIN PM_PAL_SUMMARY B ON A.SEQ = B.PM_PAL_SEQ 
                                        LEFT OUTER JOIN(SELECT A.ORG_COMPANY_SEQ
					                                          ,SUM(B.EBIT) AS EBIT
                                                              ,SUM(B.SALES) AS SALES
					                                          ,@Month AS MONTHLY
				                                        FROM PLAN_MONTHLY_PAL A
				                                        LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS_MONTHLY_SUM B ON A.SEQ = B.PLAN_MONTHLY_PAL_SEQ
				                                        WHERE A.MONTHLY_PAL_YEAR = @Year
				                                        AND B.MONTHLY <> '99' AND B.MONTHLY <= @Month
				                                        GROUP BY ORG_COMPANY_SEQ) C ON A.ORG_COMPANY_SEQ = C.ORG_COMPANY_SEQ AND A.MONTHLY = C.MONTHLY
                                        LEFT OUTER JOIN ORG_COMPANY D ON A.ORG_COMPANY_SEQ = D.SEQ
                                        LEFT OUTER JOIN ORG_UNION E ON D.ORG_UNION_SEQ = E.SEQ
                                        WHERE B.MONTHLY_TYPE = @MonthlyType
                                        AND A.REGIST_STATUS = @RegistStatus
                                        AND A.PAL_YEAR = @Year
                                        AND A.MONTHLY = @Month
                                        -- 사용중인 부문만 보이게 변경
                                        -- AND E.IS_USE = 'Y'
                                        GROUP BY E.ORD, UNION_NAME, E.SEQ,D.IS_USE ";

                    return con.Query<GroupMain>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        /// <summary>
        /// 연간 예상 손익 - Ebit누계실적(전년)
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        public IEnumerable<GroupMain> groupMainPreYearExpectEbit(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" SELECT UNION_NAME
                                            ,SUM(B.EBIT) AS 'groupMainExpectYearResultEbit'
                                            ,SUM(B.SALES) AS 'groupMainExpectYearResultSales'
                                            ,D.SEQ        AS 'unionSeq'
                                            ,D.IS_USE
                                        FROM PM_PAL A
                                        LEFT OUTER JOIN PM_PAL_SUMMARY B ON A.SEQ = B.PM_PAL_SEQ
                                        LEFT OUTER JOIN ORG_COMPANY C ON A.ORG_COMPANY_SEQ = C.SEQ
                                        LEFT OUTER JOIN ORG_UNION D ON C.ORG_UNION_SEQ = D.SEQ
                                        WHERE B.MONTHLY_TYPE = @MonthlyType
                                        AND A.REGIST_STATUS = @RegistStatus
                                        AND A.PAL_YEAR = @Year
                                        -- 사용중인 부문만 보이게 변경
                                        -- AND D.IS_USE = 'Y'
                                        AND A.MONTHLY <> '99' AND A.MONTHLY = @Month
GROUP BY D.ORD, UNION_NAME, D.SEQ,D.IS_USE";

                    return con.Query<GroupMain>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        /// <summary>
        /// 연간예상손익 - Ebit연간예상(계획, 실적)
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        public IEnumerable<GroupMain> groupMainExpectYearEbit(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" SELECT UNION_NAME			      AS 'unionName'
	                                          ,ISNULL(SUM(C.EBIT),0) AS 'groupMainExpectYearPlanEbit'
	                                          ,ISNULL(SUM(B.EBIT),0) AS 'groupMainExpectYearResultEbit'
                                              ,ISNULL(SUM(C.SALES),0) AS 'groupMainExpectYearPlanSales'
	                                          ,ISNULL(SUM(B.SALES),0) AS 'groupMainExpectYearResultSales'
                                              ,E.SEQ                  AS 'unionSeq'
                                              ,E.IS_USE
                                        FROM PM_PAL A
                                        LEFT OUTER JOIN PM_PAL_SUMMARY B ON A.SEQ = B.PM_PAL_SEQ 
                                        LEFT OUTER JOIN(SELECT A.ORG_COMPANY_SEQ
					                                          ,SUM(B.EBIT) AS EBIT
                                                              ,SUM(B.SALES) AS SALES
					                                          ,@Month AS MONTHLY
				                                        FROM PLAN_MONTHLY_PAL A
				                                        LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS_MONTHLY_SUM B ON A.SEQ = B.PLAN_MONTHLY_PAL_SEQ
				                                        WHERE A.MONTHLY_PAL_YEAR = @Year
				                                        AND B.MONTHLY <> '99' AND B.MONTHLY <= '12' -- 당해년도 12월까지 합산을 하기 위한 조건
				                                        GROUP BY ORG_COMPANY_SEQ) C ON A.ORG_COMPANY_SEQ = C.ORG_COMPANY_SEQ AND A.MONTHLY = C.MONTHLY
                                        LEFT OUTER JOIN ORG_COMPANY D ON A.ORG_COMPANY_SEQ = D.SEQ
                                        LEFT OUTER JOIN ORG_UNION E ON D.ORG_UNION_SEQ = E.SEQ
                                        WHERE B.MONTHLY_TYPE = @MonthlyType
                                        AND A.REGIST_STATUS = @RegistStatus
                                        AND A.PAL_YEAR = @Year
                                        AND A.MONTHLY = @Month
                                        -- 사용중인 부문만 보이게 변경
                                        -- AND E.IS_USE = 'Y'
                                        GROUP BY E.ORD, UNION_NAME, E.SEQ ,E.IS_USE
                                        ORDER BY E.ORD";

                    return con.Query<GroupMain>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        /// <summary>
        /// 연간예상손익 - Ebit연간예상(계획, 실적)
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        public IEnumerable<GroupMain> groupMainExpectYearEbit_NEW(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" SELECT UNION_NAME			      AS 'unionName'
	                                          ,ISNULL(SUM(C.EBIT),0) AS 'groupMainExpectYearPlanEbit'
	                                          ,ISNULL(SUM(B.EBIT),0) AS 'groupMainExpectYearResultEbit'
                                              ,ISNULL(SUM(C.SALES),0) AS 'groupMainExpectYearPlanSales'
	                                          ,ISNULL(SUM(B.SALES),0) AS 'groupMainExpectYearResultSales'
                                              , ISNULL((SELECT  SUM(SALES)  FROM PLAN_GROUPDATA_PAL_MONTHLY_SUMMARY WITH(NOLOCK)  
                                                              WHERE GROUPDATA_YEAR = @Year AND GROUPDATA_MONTH   <= '12'),0) AS groupMainPlanSalesSum
                                              , ISNULL((SELECT SALES  FROM PM_GROUPDATA_PAL_MONTHLY WITH(NOLOCK) 
                                                              WHERE GROUPDATA_YEAR = @Year AND GROUPDATA_MONTH   = @Month  AND MONTHLY_TYPE = @MonthlyType),0) AS groupMainResultSalesSum
                                              , ISNULL((SELECT SUM(EBIT)  FROM PLAN_GROUPDATA_PAL_MONTHLY_SUMMARY WITH(NOLOCK)  
                                                              WHERE GROUPDATA_YEAR = @Year AND GROUPDATA_MONTH   <= '12'),0) AS groupMainPlanEbitSum
                                              , ISNULL((SELECT EBIT  FROM PM_GROUPDATA_PAL_MONTHLY WITH(NOLOCK) 
                                                              WHERE GROUPDATA_YEAR = @Year AND GROUPDATA_MONTH   = @Month  AND MONTHLY_TYPE = @MonthlyType),0) AS groupMainResultEbitSum
                                              ,E.SEQ                  AS 'unionSeq'
                                              ,E.IS_USE
                                        FROM PM_PAL A
                                        LEFT OUTER JOIN PM_PAL_SUMMARY B ON A.SEQ = B.PM_PAL_SEQ 
                                        LEFT OUTER JOIN(SELECT A.ORG_COMPANY_SEQ
					                                          ,SUM(B.EBIT) AS EBIT
                                                              ,SUM(B.SALES) AS SALES
					                                          ,@Month AS MONTHLY
				                                        FROM PLAN_MONTHLY_PAL A
				                                        LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS_MONTHLY_SUM B ON A.SEQ = B.PLAN_MONTHLY_PAL_SEQ
				                                        WHERE A.MONTHLY_PAL_YEAR = @Year
				                                        AND B.MONTHLY <> '99' AND B.MONTHLY <= '12' -- 당해년도 12월까지 합산을 하기 위한 조건
				                                        GROUP BY ORG_COMPANY_SEQ) C ON A.ORG_COMPANY_SEQ = C.ORG_COMPANY_SEQ AND A.MONTHLY = C.MONTHLY
                                        LEFT OUTER JOIN ORG_COMPANY D ON A.ORG_COMPANY_SEQ = D.SEQ
                                        LEFT OUTER JOIN ORG_UNION E ON D.ORG_UNION_SEQ = E.SEQ
                                        WHERE B.MONTHLY_TYPE = @MonthlyType
                                        AND A.REGIST_STATUS = @RegistStatus
                                        AND A.PAL_YEAR = @Year
                                        AND A.MONTHLY = @Month
                                        -- 사용중인 부문만 보이게 변경
                                        -- AND E.IS_USE = 'Y'
                                        GROUP BY E.ORD, UNION_NAME, E.SEQ ,E.IS_USE
                                        ORDER BY E.ORD";

                    return con.Query<GroupMain>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        /// <summary>
        /// //연간 예상 손익 - Ebit연간예상(전년)
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        public IEnumerable<GroupMain> groupMainPreYearExpectYearEbit(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" SELECT UNION_NAME
                                            ,SUM(B.EBIT) AS 'groupMainExpectYearResultEbit'
                                            ,SUM(B.SALES) AS 'groupMainExpectYearResultSales'
                                            ,D.SEQ        AS 'unionSeq'
                                            ,D.IS_USE
                                        FROM PM_PAL A
                                        LEFT OUTER JOIN PM_PAL_SUMMARY B ON A.SEQ = B.PM_PAL_SEQ
                                        LEFT OUTER JOIN ORG_COMPANY C ON A.ORG_COMPANY_SEQ = C.SEQ
                                        LEFT OUTER JOIN ORG_UNION D ON C.ORG_UNION_SEQ = D.SEQ
                                        WHERE B.MONTHLY_TYPE = @MonthlyType
                                        AND A.REGIST_STATUS = @RegistStatus
                                        AND A.PAL_YEAR = @Year
                                        -- 사용중인 부문만 보이게 변경
                                        -- AND D.IS_USE = 'Y'
                                        AND A.MONTHLY <> '99' AND A.MONTHLY = '12' -- 당해년도 12월까지 합산을 하기 위한 조건
GROUP BY D.ORD, UNION_NAME, D.SEQ,D.IS_USE";

                    return con.Query<GroupMain>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        /// <summary>
        /// 연간예상손익 - Ebit잔여월(계획, 실적)
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        public IEnumerable<GroupMain> groupMainExpectRestEbit(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" SELECT *
                                        FROM(
	                                        SELECT @MonthlyTypeFirst	 AS 'restSalesKind' 
		                                          ,UNION_NAME			 AS 'unionName'
		                                          ,ISNULL(SUM(C.EBIT),0) AS 'groupMainExpectYearPlanEbit'
		                                          ,ISNULL(SUM(B.EBIT),0) AS 'groupMainExpectYearResultEbit'
                                                  ,ISNULL(SUM(C.SALES),0) AS 'groupMainExpectYearPlanSales'
		                                          ,ISNULL(SUM(B.SALES),0) AS 'groupMainExpectYearResultSales'
                                                  ,E.SEQ                  AS 'unionSeq'
                                                    ,E.IS_USE
	                                        FROM PM_PAL A
	                                        LEFT OUTER JOIN PM_PAL_SUMMARY B ON A.SEQ = B.PM_PAL_SEQ 
	                                        LEFT OUTER JOIN(SELECT A.ORG_COMPANY_SEQ
						                                          ,SUM(B.EBIT) AS EBIT
                                                                  ,SUM(B.SALES) AS SALES
						                                          ,@Month AS MONTHLY
					                                        FROM PLAN_MONTHLY_PAL A
					                                        LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS_MONTHLY_SUM B ON A.SEQ = B.PLAN_MONTHLY_PAL_SEQ
					                                        WHERE A.MONTHLY_PAL_YEAR = @Year
					                                        AND B.MONTHLY <> '99' AND B.MONTHLY <= '12' -- 당해년도 12월까지 합산을 하기 위한 조건
					                                        GROUP BY ORG_COMPANY_SEQ) C ON A.ORG_COMPANY_SEQ = C.ORG_COMPANY_SEQ AND A.MONTHLY = C.MONTHLY
	                                        LEFT OUTER JOIN ORG_COMPANY D ON A.ORG_COMPANY_SEQ = D.SEQ
	                                        LEFT OUTER JOIN ORG_UNION E ON D.ORG_UNION_SEQ = E.SEQ
	                                        WHERE B.MONTHLY_TYPE = @MonthlyTypeFirst
	                                        AND A.PAL_YEAR = @Year
	                                        AND A.MONTHLY = @Month
                                            AND A.REGIST_STATUS = @RegistStatus
                                        -- 사용중인 부문만 보이게 변경
                                        -- AND E.IS_USE = 'Y'
	                                        GROUP BY E.ORD, UNION_NAME, E.SEQ ,E.IS_USE
	                                        UNION
	                                        SELECT @MonthlyTypeSecond		AS 'restSalesKind' 
		                                         ,UNION_NAME		        AS 'unionName'
		                                        ,ISNULL(SUM(C.EBIT),0)      AS 'groupMainExpectPlanEbit'
		                                        ,ISNULL(SUM(B.EBIT),0)      AS 'groupMainExpectResultEbit'
                                                ,ISNULL(SUM(C.SALES),0)      AS 'groupMainExpectPlanSales'
		                                        ,ISNULL(SUM(B.SALES),0)      AS 'groupMainExpectResultSales'
                                                ,E.SEQ                      AS 'unionSeq'
                                                ,E.IS_USE
	                                        FROM PM_PAL A
	                                        LEFT OUTER JOIN PM_PAL_SUMMARY B ON A.SEQ = B.PM_PAL_SEQ 
	                                        LEFT OUTER JOIN(SELECT A.ORG_COMPANY_SEQ
						                                          ,SUM(B.EBIT) AS EBIT
                                                                  ,SUM(B.SALES) AS SALES
						                                          ,@Month AS MONTHLY
					                                        FROM PLAN_MONTHLY_PAL A
					                                        LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS_MONTHLY_SUM B ON A.SEQ = B.PLAN_MONTHLY_PAL_SEQ
					                                        WHERE A.MONTHLY_PAL_YEAR = @Year
					                                        AND B.MONTHLY <> '99' AND B.MONTHLY <= @Month
					                                        GROUP BY ORG_COMPANY_SEQ) C ON A.ORG_COMPANY_SEQ = C.ORG_COMPANY_SEQ AND A.MONTHLY = C.MONTHLY
	                                        LEFT OUTER JOIN ORG_COMPANY D ON A.ORG_COMPANY_SEQ = D.SEQ
	                                        LEFT OUTER JOIN ORG_UNION E ON D.ORG_UNION_SEQ = E.SEQ
	                                        WHERE B.MONTHLY_TYPE = @MonthlyTypeSecond
	                                        AND A.PAL_YEAR = @Year
	                                        AND A.MONTHLY = @Month
                                            AND A.REGIST_STATUS = @RegistStatus
                                        -- 사용중인 부문만 보이게 변경
                                        -- AND E.IS_USE = 'Y'
	                                        GROUP BY E.ORD, UNION_NAME, E.SEQ,E.IS_USE
                                        ) A 
                                        ORDER BY restSalesKind DESC,unionName DESC ";

                    return con.Query<GroupMain>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        /// <summary>
        /// 연간예상손익 - Ebit 잔여월(전년)
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        public IEnumerable<GroupMain> groupMainPreYearExpectRestEbit(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" SELECT *
                                        FROM(
	                                        SELECT '30'			                AS 'restSalesKind'
		                                          ,UNION_NAME                   AS 'unionName'
		                                          ,SUM(B.EBIT)                  AS 'groupMainExpectResultEbit'
                                                  ,SUM(B.SALES)                 AS 'groupMainExpectResultSales'
                                                  ,D.SEQ                        AS 'unionSeq'
                                                    , D.IS_USE
	                                        FROM PM_PAL A
	                                        LEFT OUTER JOIN PM_PAL_SUMMARY B ON A.SEQ = B.PM_PAL_SEQ
	                                        LEFT OUTER JOIN ORG_COMPANY C ON A.ORG_COMPANY_SEQ = C.SEQ
	                                        LEFT OUTER JOIN ORG_UNION D ON C.ORG_UNION_SEQ = D.SEQ
	                                        WHERE B.MONTHLY_TYPE = @MonthlyTypeFirst
                                            AND A.REGIST_STATUS = @RegistStatus
	                                        AND A.PAL_YEAR = @Year
	                                        AND A.MONTHLY <> '99' AND A.MONTHLY = '12' -- 당해년도 12월까지 합산을 하기 위한 조건
	                                        GROUP BY D.ORD, UNION_NAME, D.SEQ, D.IS_USE
	                                        UNION
	                                        SELECT '20'			                AS 'restSalesKind'
		                                          ,UNION_NAME                   AS 'unionName'
		                                          ,SUM(B.EBIT)                  AS 'groupMainExpectResultEbit'
                                                  ,SUM(B.SALES)                 AS 'groupMainExpectResultSales'
                                                  ,D.SEQ                        AS 'unionSeq'
                                                    , D.IS_USE
	                                        FROM PM_PAL A
	                                        LEFT OUTER JOIN PM_PAL_SUMMARY B ON A.SEQ = B.PM_PAL_SEQ
	                                        LEFT OUTER JOIN ORG_COMPANY C ON A.ORG_COMPANY_SEQ = C.SEQ
	                                        LEFT OUTER JOIN ORG_UNION D ON C.ORG_UNION_SEQ = D.SEQ
	                                        WHERE B.MONTHLY_TYPE = @MonthlyTypeSecond
                                            AND A.REGIST_STATUS = @RegistStatus
	                                        AND A.PAL_YEAR = @Year
	                                        AND A.MONTHLY <> '99' AND A.MONTHLY = @Month
	                                        GROUP BY D.ORD, UNION_NAME, D.SEQ, D.IS_USE
                                        )A
                                        ORDER BY restSalesKind DESC ";

                    return con.Query<GroupMain>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        /// <summary>
        /// 연간예상손익 - Tablehead
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        public IEnumerable<GroupMain> groupMainExpectYearHeadTable(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" SELECT UNION_NAME			  AS 'unionName'
                                        FROM PM_PAL A
                                        LEFT OUTER JOIN PM_PAL_SUMMARY B ON A.SEQ = B.PM_PAL_SEQ 
                                        LEFT OUTER JOIN(SELECT A.ORG_COMPANY_SEQ
					                                            ,@Month AS MONTHLY
				                                        FROM PLAN_MONTHLY_PAL A
				                                        LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS_MONTHLY_SUM B ON A.SEQ = B.PLAN_MONTHLY_PAL_SEQ
				                                        WHERE A.MONTHLY_PAL_YEAR = @Year
				                                        AND B.MONTHLY <> '99' AND B.MONTHLY <= '12'
				                                        GROUP BY ORG_COMPANY_SEQ) C ON A.ORG_COMPANY_SEQ = C.ORG_COMPANY_SEQ AND A.MONTHLY = C.MONTHLY
                                        LEFT OUTER JOIN ORG_COMPANY D ON A.ORG_COMPANY_SEQ = D.SEQ
                                        LEFT OUTER JOIN ORG_UNION E ON D.ORG_UNION_SEQ = E.SEQ
                                        WHERE B.MONTHLY_TYPE = @MonthlyType
                                        AND A.PAL_YEAR = @Year
                                        AND A.MONTHLY = @Month
                                        AND A.REGIST_STATUS = @RegistStatus
                                        -- 사용중인 부문만 보이게 변경
                                        AND E.IS_USE = 'Y'
                                        GROUP BY E.ORD, UNION_NAME  ";

                    return con.Query<GroupMain>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        /// <summary>
        /// 연간예상손익 - TableBody(연간예상)
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        public IEnumerable<GroupMain> groupMainExpectYearBodyTable(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" SELECT @MonthlyType	          AS 'restSalesKind' 
			                          ,UNION_NAME			          AS 'unionName'
			                          ,ISNULL(SUM(C.SALES), 0)        AS 'groupMainExpectPlanSales'
			                          ,ISNULL(SUM(C.EBIT), 0)         AS 'groupMainExpectPlanEbit'
			                          ,ISNULL(SUM(B.SALES), 0)        AS 'groupMainExpectResultSales'
			                          ,ISNULL(SUM(B.EBIT), 0)         AS 'groupMainExpectResultEbit'
		                        FROM PM_PAL A
		                        LEFT OUTER JOIN PM_PAL_SUMMARY B ON A.SEQ = B.PM_PAL_SEQ 
		                        LEFT OUTER JOIN(SELECT A.ORG_COMPANY_SEQ
							                          ,SUM(B.SALES) AS SALES
							                          ,SUM(B.EBIT) AS EBIT
							                          ,@Month AS MONTHLY
						                        FROM PLAN_MONTHLY_PAL A
						                        LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS_MONTHLY_SUM B ON A.SEQ = B.PLAN_MONTHLY_PAL_SEQ
						                        WHERE A.MONTHLY_PAL_YEAR = @Year
						                        AND B.MONTHLY <> '99' AND B.MONTHLY <= '12'
						                        GROUP BY ORG_COMPANY_SEQ) C ON A.ORG_COMPANY_SEQ = C.ORG_COMPANY_SEQ AND A.MONTHLY = C.MONTHLY
		                        LEFT OUTER JOIN ORG_COMPANY D ON A.ORG_COMPANY_SEQ = D.SEQ
		                        LEFT OUTER JOIN ORG_UNION E ON D.ORG_UNION_SEQ = E.SEQ
		                        WHERE B.MONTHLY_TYPE = @MonthlyType
		                        AND A.PAL_YEAR = @Year
		                        AND A.MONTHLY = @Month
                                AND A.REGIST_STATUS = @RegistStatus
		                        GROUP BY E.ORD, UNION_NAME  ";

                    return con.Query<GroupMain>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        /// <summary>
        /// 연간예상손익 - TableBody(잔여월)
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        public IEnumerable<GroupMain> groupMainExpectYearTable(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" SELECT *
                                        FROM(
                                            SELECT @MonthlyTypeFirst	  AS 'restSalesKind' 
                                                  ,UNION_NAME			  AS 'unionName'
                                                  ,ISNULL(SUM(C.SALES),0) AS 'groupMainExpectPlanSales'
                                                  ,ISNULL(SUM(C.EBIT), 0) AS 'groupMainExpectPlanEbit'
                                                  ,ISNULL(SUM(B.SALES),0) AS 'groupMainExpectResultSales'
                                                  ,ISNULL(SUM(B.EBIT),0)  AS 'groupMainExpectResultEbit'
                                            FROM PM_PAL A
                                            LEFT OUTER JOIN PM_PAL_SUMMARY B ON A.SEQ = B.PM_PAL_SEQ 
                                            LEFT OUTER JOIN(SELECT A.ORG_COMPANY_SEQ
                                                                  ,SUM(B.SALES) AS SALES
                                                                  ,SUM(B.EBIT) AS EBIT
                                                                  ,@Month AS MONTHLY
                                                            FROM PLAN_MONTHLY_PAL A
                                                            LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS_MONTHLY_SUM B ON A.SEQ = B.PLAN_MONTHLY_PAL_SEQ
                                                            WHERE A.MONTHLY_PAL_YEAR = @Year
                                                            AND B.MONTHLY <> '99' AND B.MONTHLY <= '12'  -- 당해년도 12월까지 합산을 하기 위한 조건
                                                            GROUP BY ORG_COMPANY_SEQ) C ON A.ORG_COMPANY_SEQ = C.ORG_COMPANY_SEQ AND A.MONTHLY = C.MONTHLY
                                            LEFT OUTER JOIN ORG_COMPANY D ON A.ORG_COMPANY_SEQ = D.SEQ
                                            LEFT OUTER JOIN ORG_UNION E ON D.ORG_UNION_SEQ = E.SEQ
                                            WHERE B.MONTHLY_TYPE = @MonthlyTypeFirst
                                            AND A.PAL_YEAR = @Year
                                            AND A.MONTHLY = @Month
                                            AND A.REGIST_STATUS = @RegistStatus
                                            GROUP BY E.ORD, UNION_NAME
                                            UNION
                                            SELECT @MonthlyTypeSecond	  AS 'restSalesKind' 
                                                  ,UNION_NAME			  AS 'unionName'
                                                  ,ISNULL(SUM(C.SALES),0) AS 'groupMainExpectPlanSales'
                                                  ,ISNULL(SUM(C.EBIT), 0) AS 'groupMainExpectPlanEbit'
                                                  ,ISNULL(SUM(B.SALES),0) AS 'groupMainExpectResultSales'
                                                  ,ISNULL(SUM(B.EBIT),0)  AS 'groupMainExpectResultEbit'
                                            FROM PM_PAL A
                                            LEFT OUTER JOIN PM_PAL_SUMMARY B ON A.SEQ = B.PM_PAL_SEQ 
                                            LEFT OUTER JOIN(SELECT A.ORG_COMPANY_SEQ
                                                                  ,SUM(B.SALES) AS SALES
                                                                  ,SUM(B.EBIT) AS EBIT
                                                                  ,@Month AS MONTHLY
                                                            FROM PLAN_MONTHLY_PAL A
                                                            LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS_MONTHLY_SUM B ON A.SEQ = B.PLAN_MONTHLY_PAL_SEQ
                                                            WHERE A.MONTHLY_PAL_YEAR = @Year
                                                            AND B.MONTHLY <> '99' AND B.MONTHLY <= @Month
                                                            GROUP BY ORG_COMPANY_SEQ) C ON A.ORG_COMPANY_SEQ = C.ORG_COMPANY_SEQ AND A.MONTHLY = C.MONTHLY
                                            LEFT OUTER JOIN ORG_COMPANY D ON A.ORG_COMPANY_SEQ = D.SEQ
                                            LEFT OUTER JOIN ORG_UNION E ON D.ORG_UNION_SEQ = E.SEQ
                                            WHERE B.MONTHLY_TYPE = @MonthlyTypeSecond
                                            AND A.PAL_YEAR = @Year
                                            AND A.MONTHLY = @Month
                                            AND A.REGIST_STATUS = @RegistStatus
                                            GROUP BY E.ORD, UNION_NAME
                                        ) A
	                                    ORDER BY restSalesKind DESC  ";

                    return con.Query<GroupMain>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        #endregion

        #region << ROIC >>

        /// <summary>
        /// 투자/인원(계획)
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        public IEnumerable<GroupMain> groupMainPlanRoic(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"SELECT YEARLY_YEAR
	                                       ,MONTHLY                                                                                                    AS 'groupMainMonthlyRoic'
		                                   --,CONVERT(DECIMAL(12, 2), ROUND(CASE WHEN ISNULL(SUM(PAIN_IN_CAPITAL), 0) = 0 THEN 0 
                                           --                                    WHEN ISNULL(SUM(AFTER_TAX_OPERATION_PROFIT), 0) = 0 THEN 0 
										    --                              ELSE (SUM(PAIN_IN_CAPITAL) / SUM(AFTER_TAX_OPERATION_PROFIT)) * 100 END, 2)) AS 'groupMainRoic'
		                                   /*
                                            ,CONVERT(DECIMAL(12, 2), ROUND(CASE WHEN ISNULL(SUM(PAIN_IN_CAPITAL), 0) = 0 THEN 0 
                                                                               WHEN ISNULL(SUM(AFTER_TAX_OPERATION_PROFIT), 0) = 0 THEN 0 
										                                  ELSE (SUM(AFTER_TAX_OPERATION_PROFIT) / SUM(PAIN_IN_CAPITAL)) * 100 END, 2)) AS 'groupMainRoic'
                                            */
		                                   , CASE WHEN ISNULL(SUM(PAIN_IN_CAPITAL), 0) = 0 THEN 0 
                                                                               WHEN ISNULL(SUM(AFTER_TAX_OPERATION_PROFIT), 0) = 0 THEN 0 
										                                  ELSE (SUM(AFTER_TAX_OPERATION_PROFIT) / SUM(PAIN_IN_CAPITAL)) * 100 END AS 'groupMainRoic'
		                                   ,[DATE]
	                                  FROM(
		                                    SELECT YEARLY_YEAR
                                                  ,MONTHLY  
                                                  ,ISNULL(PAIN_IN_CAPITAL, 0)            AS PAIN_IN_CAPITAL
                                                  ,ISNULL(AFTER_TAX_OPERATION_PROFIT, 0) AS AFTER_TAX_OPERATION_PROFIT
                                                  ,YEARLY_YEAR + MONTHLY AS [DATE]
		                                    FROM PLAN_YEAR_BS A
		                                    LEFT OUTER JOIN PLAN_YEAR_BS_ROIC B ON A.SEQ = B.PLAN_YEAR_BS_SEQ AND B.MONTHLY != '99' -- 합계 제외
                                            WHERE 1 = 1
		                                    AND REGIST_STATUS = @RegistStatus
	                                    )A
	                                    WHERE A.[DATE] BETWEEN @StartDate AND @EndDate
	                                    GROUP BY YEARLY_YEAR, MONTHLY, A.[DATE]";

                    return con.Query<GroupMain>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        /// <summary>
        /// 투자/인원(계획)
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        public IEnumerable<GroupMain> groupMainPlanRoic_NEW(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"SELECT YEARLY_YEAR
	                                       ,MONTHLY    AS 'groupMainMonthlyRoic'
		                                   ,CASE WHEN ISNULL(PAIN_IN_CAPITAL, 0) = 0 THEN 0 
                                                  WHEN ISNULL(AFTER_TAX_OPERATION_PROFIT, 0) = 0 THEN 0 
										          ELSE (AFTER_TAX_OPERATION_PROFIT / PAIN_IN_CAPITAL) * 100 
                                            END AS 'groupMainRoic'
		                                   ,[DATE]
	                                  FROM(
		                                    SELECT GROUPDATA_YEAR AS YEARLY_YEAR
                                                  ,GROUPDATA_MONTH AS MONTHLY
                                                  ,ISNULL(PAIN_IN_CAPITAL, 0)            AS PAIN_IN_CAPITAL
                                                  ,ISNULL(AFTER_TAX_OPERATION_PROFIT, 0) AS AFTER_TAX_OPERATION_PROFIT
                                                  ,GROUPDATA_YEAR + GROUPDATA_MONTH AS [DATE]
		                                    FROM PLAN_GROUPDATA_BS_MONTHLY
                                            WHERE GROUPDATA_YEAR  =  @EndYear
											UNION  ALL
											 SELECT  @StartYear AS YEARLY_YEAR
                                                  , '12' AS MONTHLY
                                                  ,ISNULL((SELECT PAIN_IN_CAPITAL  FROM PLAN_GROUPDATA_BS_MONTHLY
															WHERE GROUPDATA_YEAR  =  @StartYear AND GROUPDATA_MONTH = '12'),0)            AS PAIN_IN_CAPITAL
                                                  ,ISNULL((SELECT AFTER_TAX_OPERATION_PROFIT  FROM PLAN_GROUPDATA_BS_MONTHLY
															WHERE GROUPDATA_YEAR  =  @StartYear AND GROUPDATA_MONTH = '12'),0)  AS AFTER_TAX_OPERATION_PROFIT
                                                  , @StartYear + '12' AS [DATE]
	                                    )A  
                                        ORDER BY  YEARLY_YEAR, MONTHLY";

                    return con.Query<GroupMain>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }


        /// <summary>
        /// 투자/인원(실적)
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        public IEnumerable<GroupMain> groupMainResultRoic(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"SELECT BS_YEAR
		                                    ,MONTHLY                                                                                                    AS 'groupMainMonthlyRoic'
		                                    --,CONVERT(DECIMAL(12, 2), ROUND(CASE WHEN ISNULL(SUM(PAIN_IN_CAPITAL), 0) = 0 THEN 0 
                                            --                                    WHEN ISNULL(SUM(AFTER_TAX_OPERATION_PROFIT), 0) = 0 THEN 0 
										    --                               ELSE (SUM(PAIN_IN_CAPITAL) / SUM(AFTER_TAX_OPERATION_PROFIT)) * 100 END, 2)) AS 'groupMainRoic'
                                            /*
		                                    ,CONVERT(DECIMAL(12, 2), ROUND(CASE WHEN ISNULL(SUM(PAIN_IN_CAPITAL), 0) = 0 THEN 0 
                                                                                WHEN ISNULL(SUM(AFTER_TAX_OPERATION_PROFIT), 0) = 0 THEN 0 
										                                   ELSE (SUM(AFTER_TAX_OPERATION_PROFIT) / SUM(PAIN_IN_CAPITAL)) * 100 END, 2)) AS 'groupMainRoic'
                                            */
                                            , CASE WHEN ISNULL(SUM(PAIN_IN_CAPITAL), 0) = 0 THEN 0 
                                                                                WHEN ISNULL(SUM(AFTER_TAX_OPERATION_PROFIT), 0) = 0 THEN 0 
										                                   ELSE (SUM(AFTER_TAX_OPERATION_PROFIT) / SUM(PAIN_IN_CAPITAL)) * 100 END AS 'groupMainRoic'
		                                    ,[DATE]
	                                  FROM(
		                                    SELECT	C.BS_YEAR									AS BS_YEAR
				                                    , C.MONTHLY									AS MONTHLY
				                                    , C.ORG_COMPANY_SEQ							AS ORG_COMPANY_SEQ
				                                    , ISNULL(D.AFTER_TAX_OPERATION_PROFIT, 0)	AS AFTER_TAX_OPERATION_PROFIT
				                                    , ISNULL(D.PAIN_IN_CAPITAL, 0)				AS PAIN_IN_CAPITAL
				                                    , C.BS_YEAR + C.MONTHLY						AS [DATE]                                       
		                                    FROM	PM_BS							C
		                                    LEFT OUTER JOIN PM_BS_ROIC				D ON C.SEQ = D.PM_BS_SEQ
                                            WHERE 1 = 1
		                                    AND REGIST_STATUS = @RegistStatus
	                                    )A 
	                                    WHERE A.[DATE] BETWEEN @StartDate AND @EndDate
	                                    GROUP BY BS_YEAR, MONTHLY, A.[DATE]";

                    return con.Query<GroupMain>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }


        /// <summary>
        /// 투자/인원(실적)
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        public IEnumerable<GroupMain> groupMainResultRoic_NEW(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"SELECT YEARLY_YEAR
	                                       ,MONTHLY    AS 'groupMainMonthlyRoic'
		                                   ,CASE WHEN ISNULL(PAIN_IN_CAPITAL, 0) = 0 THEN 0 
                                                  WHEN ISNULL(AFTER_TAX_OPERATION_PROFIT, 0) = 0 THEN 0 
										          ELSE (AFTER_TAX_OPERATION_PROFIT / PAIN_IN_CAPITAL) * 100 
                                            END AS 'groupMainRoic'
		                                   ,[DATE]
	                                  FROM(
		                                    SELECT GROUPDATA_YEAR AS YEARLY_YEAR
                                                  ,GROUPDATA_MONTH AS MONTHLY
                                                  ,ISNULL(PAIN_IN_CAPITAL, 0)            AS PAIN_IN_CAPITAL
                                                  ,ISNULL(AFTER_TAX_OPERATION_PROFIT, 0) AS AFTER_TAX_OPERATION_PROFIT
                                                  ,GROUPDATA_YEAR + GROUPDATA_MONTH AS [DATE]
		                                    FROM PM_GROUPDATA_BS_MONTHLY
                                            WHERE GROUPDATA_YEAR  =  @EndYear
											UNION  ALL
											 SELECT  @StartYear AS YEARLY_YEAR
                                                  , '12' AS MONTHLY
                                                  ,ISNULL((SELECT PAIN_IN_CAPITAL  FROM PM_GROUPDATA_BS_MONTHLY
															WHERE GROUPDATA_YEAR  =  @StartYear AND GROUPDATA_MONTH = '12'),0)            AS PAIN_IN_CAPITAL
                                                  ,ISNULL((SELECT AFTER_TAX_OPERATION_PROFIT  FROM PM_GROUPDATA_BS_MONTHLY
															WHERE GROUPDATA_YEAR  =  @StartYear AND GROUPDATA_MONTH = '12'),0)  AS AFTER_TAX_OPERATION_PROFIT
                                                  , @StartYear + '12' AS [DATE]
	                                    )A  
                                        ORDER BY  YEARLY_YEAR, MONTHLY";

                    return con.Query<GroupMain>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        #endregion

        #region << 투자,인원 >>

        /// <summary>
        /// 투자/인원 누계 - 계획
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        public GroupMain investPlanPieChart(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" SELECT SUM(INVESTMENT)	 AS planInvest
FROM PLAN_MONTHLY_INVEST A
LEFT OUTER JOIN PLAN_MONTHLY_INVEST_SUMMARY B ON A.SEQ = B.PLAN_MONTHLY_INVEST_SEQ
WHERE 1 = 1 
AND A.MONTHLY_INVEST_YEAR = @Yearly
AND B.MONTHLY <= @Monthly
AND A.REGIST_STATUS = @RegistStatus";

                    return con.Query<GroupMain>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }


        public GroupMain investPlanPieChart_NEW(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                { 
                    con.Open();

                    string query = @" SELECT SUM(INVESTMENT)	 AS planInvest
                                     FROM PLAN_GROUPDATA_INVEST_MONTHLY 
							            WHERE GROUPDATA_YEAR = @Yearly AND GROUPDATA_MONTH  <= @Monthly ";

                    return con.Query<GroupMain>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        /// <summary>
        /// 투자/인원 누계 - 실적
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        public GroupMain investResultPieChart(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" 
SELECT SUM(INVESTMENT)       AS resultInvest
FROM PM_INVEST A
LEFT OUTER JOIN PM_INVEST_SUM B ON A.SEQ = B.PM_INVEST_SEQ
WHERE 1 = 1
AND B.MONTHLY_TYPE = @MonthlyType
AND A.INVEST_YEAR = @Yearly
AND A.MONTHLY = @Monthly
AND A.REGIST_STATUS = @RegistStatus";

                    return con.Query<GroupMain>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }


        public GroupMain investResultPieChart_NEW(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"SELECT  INVESTMENT  AS resultInvest   
                                            FROM PM_GROUPDATA_INVEST_MONTHLY 
							                    WHERE GROUPDATA_YEAR = @Yearly 
                                                    AND GROUPDATA_MONTH = @Monthly 
                                                    AND MONTHLY_TYPE = @MonthlyType ";

                    return con.Query<GroupMain>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        /// <summary>
        /// 투자/인원 연간 - 계획
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        public GroupMain investYearPlanPieChart(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" 
SELECT SUM(INVESTMENT)		AS planInvest
FROM PLAN_YEAR_INVEST A
LEFT OUTER JOIN PLAN_YEAR_INVEST_SUMMARY B ON A.SEQ = B.PLAN_YEAR_INVEST_SEQ
WHERE 1 = 1 
AND A.YEAR_INVEST_YEAR = @Yearly
AND B.YEARLY_YEAR = @Yearly
AND A.REGIST_STATUS = @RegistStatus
";

                    return con.Query<GroupMain>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public GroupMain investYearPlanPieChart_NEW(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"SELECT  INVESTMENT AS planInvest
                                        FROM  PLAN_GROUPDATA_INVEST_SUMMARY
							                WHERE GROUPDATA_YEAR = @Yearly AND GROUPDATA_MONTH  =  @Yearly"; 

                    return con.Query<GroupMain>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        /// <summary>
        /// 투자/인원 연간 - 실적
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        public GroupMain investYearResultPieChart(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" 
SELECT SUM(INVESTMENT)   AS resultInvest
FROM PM_INVEST A
LEFT OUTER JOIN PM_INVEST_SUM B ON A.SEQ = B.PM_INVEST_SEQ
WHERE 1 = 1
AND B.MONTHLY_TYPE = @MonthlyType
AND A.INVEST_YEAR = @Yearly
AND A.MONTHLY = @Monthly
AND A.REGIST_STATUS = @RegistStatus";

                    return con.Query<GroupMain>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }


        public GroupMain investYearResultPieChart_NEW(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"SELECT  INVESTMENT  AS resultInvest   
                                            FROM PM_GROUPDATA_INVEST_MONTHLY 
							                    WHERE GROUPDATA_YEAR = @Yearly 
                                                    AND GROUPDATA_MONTH = @Monthly 
                                                    AND MONTHLY_TYPE = @MonthlyType ";

                    return con.Query<GroupMain>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        /// <summary>
        /// 투자/인원
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        public IEnumerable<GroupMain> personnelResultChart(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" 
                                    SELECT  INVEST_YEAR
	                                       ,MONTHLY
                                           ,ISNULL(SUM(PERSONNEL), 0)		AS PERSONNEL
                                           ,[DATE]
                                      FROM(
		                                    SELECT INVEST_YEAR
			                                       ,MONTHLY
                                                   ,PERSONNEL
		                                           ,A.INVEST_YEAR + MONTHLY AS [DATE]
                                            FROM PM_INVEST A
		                                    LEFT OUTER JOIN PM_INVEST_SUM B ON A.SEQ = B.PM_INVEST_SEQ
		                                    WHERE 1 = 1
		                                    AND B.MONTHLY_TYPE = @MonthlyType
                                            AND A.REGIST_STATUS = @RegistStatus
                                        )A
                                        WHERE A.[DATE] BETWEEN @StartDate AND @EndDate
                                        GROUP BY A.[DATE], INVEST_YEAR, MONTHLY";

                    return con.Query<GroupMain>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }


        public IEnumerable<GroupMain> personnelResultChart_NEW(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"SELECT INVEST_YEAR
	                                       ,MONTHLY
                                           ,PERSONNEL
                                           ,[DATE]
                                     FROM  (SELECT GROUPDATA_YEAR AS INVEST_YEAR
			                                            , GROUPDATA_MONTH AS MONTHLY
                                                        , PERSONNEL AS PERSONNEL
		                                                , GROUPDATA_YEAR + GROUPDATA_MONTH AS [DATE] 
												        FROM PM_GROUPDATA_INVEST_MONTHLY  
												                WHERE GROUPDATA_YEAR = @EndDate
														            AND GROUPDATA_MONTH <='12' 
														            AND MONTHLY_TYPE = @MonthlyType
					                                UNION  ALL
							                                SELECT @StartDate  AS INVEST_YEAR
									                                 , '12' AS MONTHLY
									                                 ,ISNULL((SELECT   PERSONNEL 
																            FROM PM_GROUPDATA_INVEST_MONTHLY  
																            WHERE GROUPDATA_YEAR = @StartDate 
																		        AND GROUPDATA_MONTH  ='12' 
																		        AND MONTHLY_TYPE = @MonthlyType),0)  AS PERSONNEL
									                                 ,@StartDate + '12'  AS [DATE]
					                                ) A
	                                ORDER BY INVEST_YEAR, MONTHLY ";

                    return con.Query<GroupMain>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }


        /// <summary>
        /// 투자/인원
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        public GroupMain groupMainInvestPieChart1(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" ; WITH CTE_PM AS
                                    (
                                        SELECT	A.INVEST_YEAR
		                                        , A.MONTHLY
		                                        --, A.ORG_COMPANY_SEQ
		                                        , SUM(ISNULL(B.INVESTMENT, 0)) AS PM_INVESTMENT
                                        FROM PM_INVEST A
                                        LEFT OUTER JOIN PM_INVEST_SUM B ON A.SEQ = B.PM_INVEST_SEQ
                                        WHERE	1 = 1
                                        AND	A.INVEST_YEAR = @Year
                                        AND	A.MONTHLY = @Month
                                        AND	B.MONTHLY_TYPE = @MonthlyType
                                        GROUP BY A.INVEST_YEAR ,A.MONTHLY
                                    ), CTE_PLAN AS (
                                        SELECT	A.YEAR_INVEST_YEAR
		                                        ,SUM(ISNULL(B.INVESTMENT, 0)) AS PLAN_INVESTMENT
                                        FROM PLAN_YEAR_INVEST A
                                        LEFT OUTER JOIN PLAN_YEAR_INVEST_SUMMARY B ON A.SEQ = B.PLAN_YEAR_INVEST_SEQ
												                                        AND A.YEAR_INVEST_YEAR = B.YEARLY_YEAR
                                        WHERE	1 = 1
                                        AND	A.YEAR_INVEST_YEAR = @Year
                                        GROUP BY A.YEAR_INVEST_YEAR
                                    )
                                    SELECT	A.YEAR_INVEST_YEAR
		                                    , A.PLAN_INVESTMENT         AS 'groupMainPlanInvest'
		                                    , B.PM_INVESTMENT           AS 'groupMainPmInvest'
                                    FROM	CTE_PLAN A
                                    INNER JOIN 	CTE_PM B ON A.YEAR_INVEST_YEAR = B.INVEST_YEAR  ";

                    return con.Query<GroupMain>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public GroupMain groupMainInvestPieChart2(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" ; WITH CTE_PM AS
                                    (
	                                    SELECT	A.INVEST_YEAR
			                                    ,A.MONTHLY
			                                    --, A.ORG_COMPANY_SEQ
			                                    ,SUM(ISNULL(B.INVESTMENT, 0)) AS PM_INVESTMENT
	                                    FROM PM_INVEST A
	                                    LEFT OUTER JOIN PM_INVEST_SUM B ON A.SEQ = B.PM_INVEST_SEQ
	                                    WHERE	1 = 1
	                                    AND		A.INVEST_YEAR = @Year
	                                    AND		A.MONTHLY = @Month
	                                    AND		B.MONTHLY_TYPE = @MonthlyType
	                                    GROUP BY A.INVEST_YEAR, A.MONTHLY
                                    ), CTE_PLAN AS
                                    (
                                    SELECT	A.YEAR_INVEST_YEAR
		                                    ,SUM(ISNULL(B.INVESTMENT, 0)) AS PLAN_INVESTMENT
                                    FROM PLAN_YEAR_INVEST A
                                    LEFT OUTER JOIN PLAN_YEAR_INVEST_SUMMARY B ON A.SEQ = B.PLAN_YEAR_INVEST_SEQ
												                                    AND A.YEAR_INVEST_YEAR = B.YEARLY_YEAR
                                    WHERE	1 = 1
                                    AND	A.YEAR_INVEST_YEAR = @Year
                                    GROUP BY A.YEAR_INVEST_YEAR
                                    )
                                    SELECT	A.YEAR_INVEST_YEAR
		                                    , A.PLAN_INVESTMENT     AS 'groupMainPlanInvest'
		                                    , B.PM_INVESTMENT       AS 'groupMainPmInvest'
                                    FROM	CTE_PLAN A
                                    INNER JOIN CTE_PM B ON A.YEAR_INVEST_YEAR = B.INVEST_YEAR ";

                    return con.Query<GroupMain>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        #endregion


        public int insert(GroupMain entity)
        {
            throw new NotImplementedException();
        }

        public int update(GroupMain entity)
        {
            throw new NotImplementedException();
        }

        public int delete(object param)
        {
            throw new NotImplementedException();
        }

        public int save(GroupMain entity)
        {
            throw new NotImplementedException();
        }

        public void Dispose()
        {
            throw new NotImplementedException();
        }
    }
}