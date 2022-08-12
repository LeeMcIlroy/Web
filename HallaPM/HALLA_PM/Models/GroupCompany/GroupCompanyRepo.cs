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
    public class GroupCompanyRepo : DbCon, IGroupCompany
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

        public IEnumerable<GroupCompany> selectList(object param)
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

                    return con.Query<GroupCompany>(query, param).ToList();

                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<GroupCompany> selectListUnion(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = " SELECT A.*, B.UNION_NAME " +
                        " FROM ORG_COMPANY A " +
                        " LEFT OUTER JOIN ORG_UNION B ON A.ORG_UNION_SEQ = B.SEQ WHERE B.SEQ = @Seq ";

                    return con.Query<GroupCompany>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public GroupCompany selectOne(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = " SELECT A.*, B.UNION_NAME " +
                        " FROM ORG_COMPANY A " +
                        " LEFT OUTER JOIN ORG_UNION B ON A.ORG_UNION_SEQ = B.SEQ WHERE A.SEQ = @Seq ";

                    return con.Query<GroupCompany>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }
        public int selectDuplicate(object param)
        {

            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = " SELECT COUNT(*) FROM ORG_COMPANY WHERE COMPANY_NAME = @CompanyName AND ORG_UNION_SEQ = @OrgUnionSeq  ";

                    return con.Query<int>(query, param).First();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return -1;
                }
            }
        }

        public GroupCompany selectCompanyName(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"SELECT COMPANY_NAME AS companyName FROM ORG_COMPANY WHERE SEQ = @Seq";

                    return con.Query<GroupCompany>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        #region << Dash Board >>

        public GroupCompany companyFCF(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" 
SELECT	ISNULL(B.FCF2, 0) AS 'DashBoardCashFcf'
		, ISNULL(D.FCF2, 0)	AS DashBoardPlanFcf
		-- 계획값이 음수(-)이면 200에서 빼준다
		, CASE WHEN ISNULL(D.FCF2, 0) = 0 THEN 0
			WHEN ISNULL(D.FCF2, 0) < 0 THEN 200 - CONVERT(DECIMAL(12, 2), ROUND(ISNULL(B.FCF2, 0) / ISNULL(D.FCF2, 2) * 100, 2))
			ELSE CONVERT(DECIMAL(12, 2), ROUND(ISNULL(B.FCF2, 0) / ISNULL(D.FCF2, 2) * 100, 2)) END AS DashBoardRateFcf
		--, CONVERT(DECIMAL(12,2), ROUND(CASE WHEN ISNULL(B.FCF2, 0) = 0 THEN 0
		--	ELSE (ISNULL(B.FCF2, 0) / ISNULL(D.FCF2, 0)) * 100 END, 2)) AS 'DashBoardRateFcf'
FROM	PM_CASH_FLOW A
LEFT OUTER JOIN PM_CASH_FLOW_CUMULATIVE B ON A.SEQ = B.PM_CASH_FLOW_SEQ AND B.DIFF = 20 -- 실적
LEFT OUTER JOIN PM_CASH_FLOW_CUMULATIVE	D ON A.SEQ = D.PM_CASH_FLOW_SEQ AND D.DIFF = 10 -- 계획
LEFT OUTER JOIN ORG_COMPANY E ON E.ORG_UNION_SEQ = A.ORG_COMPANY_SEQ
WHERE 1 = 1
AND A.ORG_COMPANY_SEQ = @Seq					
AND A.CASH_FLOW_YEAR = @Year	
AND A.MONTHLY = @Month
GROUP BY B.FCF2, D.FCF2
";

          //          string query = @" SELECT ISNULL(B.FCF2, 0)				                                                          AS 'DashBoardCashFcf'
          //                                  ,CONVERT(DECIMAL(12,2), ROUND(CASE WHEN ISNULL(B.FCF2, 0) = 0 THEN 0 
          //                                                                ELSE (ISNULL(B.FCF2, 0) / ISNULL(D.FCF2, 0)) * 100 END, 2)) AS 'DashBoardRateFcf'
          //                              FROM PM_CASH_FLOW A
          //                              LEFT OUTER JOIN PM_CASH_FLOW_CUMULATIVE B ON A.SEQ = B.PM_CASH_FLOW_SEQ AND B.DIFF = 20 -- 실적
										//LEFT OUTER JOIN PM_CASH_FLOW_CUMULATIVE	D ON A.SEQ = D.PM_CASH_FLOW_SEQ AND D.DIFF = 10 -- 계획
          //                              LEFT OUTER JOIN ORG_COMPANY E ON E.ORG_UNION_SEQ = A.ORG_COMPANY_SEQ
          //                              WHERE 1 = 1
          //                              AND A.ORG_COMPANY_SEQ = @Seq					
          //                              AND A.CASH_FLOW_YEAR = @Year	
          //                              AND A.MONTHLY = @Month
          //                              GROUP BY B.FCF2, D.FCF2";

                    return con.Query<GroupCompany>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<GroupCompany> companySales(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"

-- 계획값이 음수(-)이면 200에서 빼준다
SELECT	*
FROM	(
	SELECT	'당월' AS 'Kind'
			, ISNULL(B.SALES, 0) AS 'DashBoardCashSales'
			, ISNULL(D.SALES, 0) AS 'DashBoardPlanSales'
			, CONVERT(DECIMAL(12, 2), ROUND(CASE WHEN ISNULL(B.SALES, 0) = 0 THEN 0
				WHEN ISNULL(B.SALES, 0) < 0 THEN 200 - (ISNULL(B.SALES, 0) / ISNULL(D.SALES, 0) * 100)
				ELSE ISNULL(B.SALES, 0) / ISNULL(D.SALES, 0) * 100 END, 2)) AS 'DashBoardRateSales'
		    , CONVERT(DECIMAL(12,2), ROUND(CASE WHEN ISNULL(B.SALES, 0) = 0 THEN 0 
									ELSE (ISNULL(B.SALES, 0) / ISNULL(D.SALES,0)) * 100 END, 2)) AS 'DashBoardRateSales_BEFORE'
	FROM PM_PAL A
	LEFT OUTER JOIN PM_PAL_SUMMARY B ON A.SEQ = B.PM_PAL_SEQ
	LEFT OUTER JOIN PLAN_MONTHLY_PAL C ON A.ORG_COMPANY_SEQ = C.ORG_COMPANY_SEQ AND A.PAL_YEAR = C.MONTHLY_PAL_YEAR
	LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS_MONTHLY_SUM D ON C.SEQ = D.PLAN_MONTHLY_PAL_SEQ AND A.MONTHLY = D.MONTHLY
	LEFT OUTER JOIN ORG_COMPANY E ON A.ORG_COMPANY_SEQ = E.SEQ
	WHERE B.MONTHLY_TYPE = @MonthlyTypeFirst
    AND E.SEQ = @Seq
	AND A.PAL_YEAR = @Year
	AND A.MONTHLY = @Month
    UNION
    SELECT '누계' AS 'Kind'
	    ,ISNULL(B.SALES, 0) AS 'DashBoardCashSales'
		, ISNULL(D.SALES, 0) AS 'DashBoardPlanSales'
		, CONVERT(DECIMAL(12, 2), ROUND(CASE WHEN ISNULL(B.SALES, 0) = 0 THEN 0
			WHEN ISNULL(B.SALES, 0) < 0 THEN 200 - (ISNULL(B.SALES, 0) / ISNULL(D.SALES, 0) * 100)
			ELSE ISNULL(B.SALES, 0) / ISNULL(D.SALES, 0) * 100 END, 2)) AS 'DashBoardRateSales'
	    ,CONVERT(DECIMAL(12,2), ROUND(CASE WHEN ISNULL(B.SALES, 0) = 0 THEN 0 
									ELSE (ISNULL(B.SALES,0) / ISNULL(D.SALES, 0)) * 100 END, 2)) AS 'DashBoardRateSales_BEFORE'
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
        AND A.ORG_COMPANY_SEQ = @Seq
		GROUP BY B.PLAN_MONTHLY_PAL_SEQ, A.MONTHLY_PAL_YEAR, A.ORG_COMPANY_SEQ
	) D ON C.SEQ = D.PLAN_MONTHLY_PAL_SEQ
	LEFT OUTER JOIN ORG_COMPANY E ON A.ORG_COMPANY_SEQ = E.SEQ
	WHERE B.MONTHLY_TYPE = @MonthlyTypeSecond
    AND E.SEQ = @Seq
	AND A.PAL_YEAR = @Year
	AND A.MONTHLY = @Month
) A
ORDER BY KIND DESC
";

                    return con.Query<GroupCompany>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<GroupCompany> companyEbit(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"

-- 계획값이 음수(-)이면 200에서 빼준다
SELECT *
FROM
(
	SELECT '당월' AS 'Kind'
		    ,ISNULL(B.EBIT, 0) AS 'DashBoardCashEbit'
		    ,ISNULL(D.EBIT, 0) AS 'DashBoardCashPlanEbit'	
			, CONVERT(DECIMAL(12, 2), ROUND(CASE WHEN ISNULL(B.EBIT, 0) = 0 THEN 0
				WHEN ISNULL(B.EBIT, 0) < 0 THEN 200 - (ISNULL(B.EBIT, 0) / ISNULL(D.EBIT, 0) * 100)
				ELSE ISNULL(B.EBIT, 0) / ISNULL(D.EBIT, 0) * 100 END, 2)) AS 'DashBoardRateEbit'
		    ,CONVERT(DECIMAL(12,2), ROUND(CASE WHEN ISNULL(B.EBIT, 0) = 0 THEN 0 
									ELSE (ISNULL(B.EBIT, 0) / ISNULL(D.EBIT,0)) * 100 END, 2)) AS 'DashBoardRateEbit_BEFORE'
	FROM PM_PAL A
	LEFT OUTER JOIN PM_PAL_SUMMARY B ON A.SEQ = B.PM_PAL_SEQ
	LEFT OUTER JOIN PLAN_MONTHLY_PAL C ON A.ORG_COMPANY_SEQ = C.ORG_COMPANY_SEQ AND A.PAL_YEAR = C.MONTHLY_PAL_YEAR
	LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS_MONTHLY_SUM D ON C.SEQ = D.PLAN_MONTHLY_PAL_SEQ AND A.MONTHLY = D.MONTHLY
	LEFT OUTER JOIN ORG_COMPANY E ON A.ORG_COMPANY_SEQ = E.SEQ
	WHERE B.MONTHLY_TYPE = @MonthlyTypeFirst
	AND E.SEQ = @Seq
    AND A.PAL_YEAR = @Year
	AND A.MONTHLY = @Month
    UNION
    SELECT '누계' AS 'Kind'
	    ,ISNULL(B.EBIT, 0) AS 'DashBoardCashEbit'
		    ,ISNULL(D.EBIT, 0) AS 'DashBoardCashPlanEbit'	
			, CONVERT(DECIMAL(12, 2), ROUND(CASE WHEN ISNULL(B.EBIT, 0) = 0 THEN 0
				WHEN ISNULL(B.EBIT, 0) < 0 THEN 200 - (ISNULL(B.EBIT, 0) / ISNULL(D.EBIT, 0) * 100)
				ELSE ISNULL(B.EBIT, 0) / ISNULL(D.EBIT, 0) * 100 END, 2)) AS 'DashBoardRateEbit'
	    ,CONVERT(DECIMAL(12,2), ROUND(CASE WHEN ISNULL(B.EBIT, 0) = 0 THEN 0 
									ELSE (ISNULL(B.EBIT,0) / ISNULL(D.EBIT, 0)) * 100 END, 2)) AS 'DashBoardRateEbit_BEFORE'
	FROM PM_PAL A
	LEFT OUTER JOIN PM_PAL_SUMMARY B ON A.SEQ = B.PM_PAL_SEQ
	LEFT OUTER JOIN PLAN_MONTHLY_PAL C ON A.ORG_COMPANY_SEQ = C.ORG_COMPANY_SEQ AND A.PAL_YEAR = C.MONTHLY_PAL_YEAR
	LEFT OUTER JOIN(
		SELECT B.PLAN_MONTHLY_PAL_SEQ
			    ,A.MONTHLY_PAL_YEAR
			    ,A.ORG_COMPANY_SEQ
			    ,@Month AS MONTHLY
			    ,SUM(B.EBIT) AS EBIT
		FROM PLAN_MONTHLY_PAL A
		LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS_MONTHLY_SUM B ON A.SEQ = B.PLAN_MONTHLY_PAL_SEQ
		WHERE A.MONTHLY_PAL_YEAR = @Year
		AND	B.MONTHLY <= @Month
        AND A.ORG_COMPANY_SEQ = @Seq
		GROUP BY B.PLAN_MONTHLY_PAL_SEQ, A.MONTHLY_PAL_YEAR, A.ORG_COMPANY_SEQ
	) D ON C.SEQ = D.PLAN_MONTHLY_PAL_SEQ
	LEFT OUTER JOIN ORG_COMPANY E ON A.ORG_COMPANY_SEQ = E.SEQ
	WHERE B.MONTHLY_TYPE = @MonthlyTypeSecond
    AND E.SEQ = @Seq
	AND A.PAL_YEAR = @Year
	AND A.MONTHLY = @Month
) A
ORDER BY KIND DESC
";

                    return con.Query<GroupCompany>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public GroupCompany companyRoic(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    // ROIC 로직 변경 작업
                    string query = @" 
;WITH COMPANY_ROW_TABLE AS (
SELECT	B.BS_YEAR
		, F.COMPANY_NAME
		, CONVERT(DECIMAL(12, 2), B.MONTHLY)			AS D_MONTH
		, ISNULL(A.AFTER_TAX_OPERATION_PROFIT, 0)		AS PM_AFTER_TAX_OPERATION_PROFIT
		, ISNULL(A.PAIN_IN_CAPITAL, 0)					AS PM_PAIN_IN_CAPITAL
		, ISNULL(D.AFTER_TAX_OPERATION_PROFIT, 0)		AS PN_AFTER_TAX_OPERATION_PROFIT
		, ISNULL(D.PAIN_IN_CAPITAL, 0)					AS PN_PAIN_IN_CAPITAL
/*
		, CASE WHEN ISNULL(A.PAIN_IN_CAPITAL, 0) = 0 THEN 0
			ELSE CONVERT(DECIMAL(12, 2),ROUND(A.AFTER_TAX_OPERATION_PROFIT / A.PAIN_IN_CAPITAL * 100 * (12 / CONVERT(DECIMAL(12, 2), B.MONTHLY)), 2)) END AS PM_ROIC
		, CASE WHEN ISNULL(D.PAIN_IN_CAPITAL, 0) = 0 THEN 0
			ELSE CONVERT(DECIMAL(12, 2),ROUND(D.AFTER_TAX_OPERATION_PROFIT / D.PAIN_IN_CAPITAL * 100 * (12 / CONVERT(DECIMAL(12, 2), B.MONTHLY)), 2)) END AS PN_ROIC
*/
		, CASE WHEN ISNULL(A.PAIN_IN_CAPITAL, 0) = 0 THEN 0
			ELSE CONVERT(DECIMAL(12, 2),ROUND(A.AFTER_TAX_OPERATION_PROFIT / A.PAIN_IN_CAPITAL * 100 * ( 12 / CONVERT(DECIMAL(12, 2), B.MONTHLY)), 2)) END AS PM_ROIC
		, CASE WHEN ISNULL(D.PAIN_IN_CAPITAL, 0) = 0 THEN 0
			ELSE CONVERT(DECIMAL(12, 2),ROUND(D.AFTER_TAX_OPERATION_PROFIT / D.PAIN_IN_CAPITAL * 100 * ( 12 / CONVERT(DECIMAL(12, 2), B.MONTHLY)), 2)) END AS PN_ROIC
FROM	PM_BS_ROIC					A
LEFT OUTER JOIN PM_BS				B ON A.PM_BS_SEQ = B.SEQ
LEFT OUTER JOIN PLAN_YEAR_BS		C ON B.ORG_COMPANY_SEQ = C.ORG_COMPANY_SEQ AND B.BS_YEAR = C.YEAR_BS_YEAR
LEFT OUTER JOIN PLAN_YEAR_BS_ROIC	D ON C.SEQ = D.PLAN_YEAR_BS_SEQ AND C.YEAR_BS_YEAR = D.YEARLY_YEAR AND B.MONTHLY = D.MONTHLY
LEFT OUTER JOIN ORG_COMPANY			F ON B.ORG_COMPANY_SEQ = F.SEQ
--LEFT OUTER JOIN ORG_BUSINESS		E ON F.SEQ = E.ORG_COMPANY_SEQ
WHERE F.SEQ = @Seq 
AND B.BS_YEAR = @Year
AND B.MONTHLY = @Month
)
SELECT	COMPANY_NAME
		, PN_ROIC				AS DashBoardPlanRoic
		, PM_ROIC				AS DashBoardRoic
		, CONVERT(DECIMAL(12, 2), ROUND(
			CASE WHEN PN_ROIC = 0 THEN 0
			WHEN PN_ROIC < 0 THEN 200 - ((PM_ROIC / PN_ROIC) * 100)
			ELSE ((PM_ROIC / PN_ROIC) * 100) END, 2))			AS DashBoardRateRoic
FROM	COMPANY_ROW_TABLE

/*
-- 계획값이 음수(-)이면 200에서 빼준다
SELECT F.COMPANY_NAME
	    ,CONVERT(DECIMAL(12, 2), ROUND(CASE WHEN ISNULL(A.PAIN_IN_CAPITAL, 0) = 0 THEN 0 
									ELSE (A.AFTER_TAX_OPERATION_PROFIT / A.PAIN_IN_CAPITAL) * 100 END, 2)) AS 'DashBoardRoic'
	    --,CONVERT(DECIMAL(12, 2), ROUND(CASE WHEN ISNULL(A.AFTER_TAX_OPERATION_PROFIT, 0) = 0 THEN 0 
		--							ELSE (A.PAIN_IN_CAPITAL / A.AFTER_TAX_OPERATION_PROFIT) * 100 END, 2)) AS 'DashBoardRoic'
		, D.ROIC AS DashBoardPlanRoic
	    ,CONVERT(DECIMAL(12, 2), ROUND(CASE WHEN ISNULL(D.ROIC, 0) = 0 THEN 0 
									WHEN ISNULL(D.ROIC, 0) < 0 THEN 200 - (ISNULL(A.ROIC, 0) / ISNULL(D.ROIC, 0) * 100)
									ELSE (ISNULL(A.ROIC, 0) / ISNULL(D.ROIC, 0)) * 100 END, 2))            AS 'DashBoardRateRoic'
FROM PM_BS_ROIC A
LEFT OUTER JOIN PM_BS B ON A.PM_BS_SEQ = B.SEQ
LEFT OUTER JOIN PLAN_YEAR_BS C ON B.ORG_COMPANY_SEQ = C.ORG_COMPANY_SEQ AND B.BS_YEAR = C.YEAR_BS_YEAR
LEFT OUTER JOIN PLAN_YEAR_BS_ROIC D ON C.SEQ = D.PLAN_YEAR_BS_SEQ AND C.YEAR_BS_YEAR = D.YEARLY_YEAR AND B.MONTHLY = D.MONTHLY
LEFT OUTER JOIN ORG_COMPANY F ON B.ORG_COMPANY_SEQ = F.SEQ
LEFT OUTER JOIN ORG_BUSINESS E ON F.SEQ = E.ORG_COMPANY_SEQ
WHERE F.SEQ = @Seq 
AND B.BS_YEAR = @Year
AND B.MONTHLY = @Month					
GROUP BY F.COMPANY_NAME, A.PAIN_IN_CAPITAL,  A.AFTER_TAX_OPERATION_PROFIT, A.ROIC, D.ROIC
*/
";

                    return con.Query<GroupCompany>(query, param).FirstOrDefault();
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

        public IEnumerable<GroupCompany> companyCashFlow(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    // 계획 연초현금은 당월이 아닌 해당년도 1월의 값을 가져오게 변경
                    string query = @" SELECT *
                                        FROM(
                                            --SELECT ISNULL(D.BASIC_CASH, 0)			AS '연초현금'
                                              SELECT (
								                        SELECT ISNULL(B.BASIC_CASH, 0)			
									                        FROM PM_CASH_FLOW A 
										                        LEFT OUTER JOIN PM_CASH_FLOW_BE_CASH B ON A.SEQ = B.PM_CASH_FLOW_SEQ
										                        LEFT OUTER JOIN PM_CASH_FLOW_CUMULATIVE C ON B.PM_CASH_FLOW_SEQ = C.PM_CASH_FLOW_SEQ AND A.SEQ = C.PM_CASH_FLOW_SEQ
										                        LEFT OUTER JOIN ORG_COMPANY D ON A.ORG_COMPANY_SEQ = D.SEQ
									                        WHERE 1 = 1
										                        AND A.REGIST_STATUS =  @RegistStatus
										                        AND CUMULATIVE = '20'
										                        AND DIFF = '20'
										                        AND D.SEQ = @Seq
										                        AND CASH_FLOW_YEAR =  @Year
										                        AND A.MONTHLY = @Month
								                        )					AS '연초현금'
                                                  ,ISNULL(C.EBITDA, 0)				AS '세후EBITDA'
                                                  ,ISNULL(C.WC_SUM, 0)				AS 'WC변동'
                                                  ,ISNULL(C.ETC, 0)				    AS '영업기타'
                                                  ,ISNULL(C.NET_CAPEX_SUM, 0)		AS 'NetCAPEX'
                                                  ,ISNULL(C.FINANCIAL_COST, 0)		AS '순금융비용'
                                                  ,ISNULL(C.FINANCIAL_SUM, 0)		AS '재무활동'
                                                  ,ISNULL(C.ENDING_CASH, 0)		    AS '월말현금'
                                                  ,ISNULL(C.AVAILABLE_CASH, 0)		AS '가용현금'
                                            FROM PM_CASH_FLOW A
                                            LEFT OUTER JOIN PM_CASH_FLOW_BE_CASH B ON A.SEQ = B.PM_CASH_FLOW_SEQ
                                            LEFT OUTER JOIN PM_CASH_FLOW_CUMULATIVE C ON B.PM_CASH_FLOW_SEQ = C.PM_CASH_FLOW_SEQ AND A.SEQ = C.PM_CASH_FLOW_SEQ
                                            LEFT OUTER JOIN (SELECT A.YEAR_CF_YEAR
                                                                   ,B.MONTHLY
                                                                   ,A.ORG_COMPANY_SEQ
                                                                   ,ISNULL(B.BASIC_CASH, 0) AS BASIC_CASH
                                                             FROM PLAN_YEAR_CF A
                                                             LEFT OUTER JOIN PLAN_YEAR_CF_BE_CASH B ON A.SEQ = B.PLAN_YEAR_CF_SEQ
                                                             WHERE  1 = 1
                                                             AND A.REGIST_STATUS = @RegistStatus
                                                             AND A.YEAR_CF_YEAR = @Year
                                                             AND A.ORG_COMPANY_SEQ = @Seq
                                                             --AND B.MONTHLY <> '99' AND B.MONTHLY <= @Month
                                                             AND B.MONTHLY <> '99' AND B.MONTHLY <= '01'
                                            --)D ON A.ORG_COMPANY_SEQ = D.ORG_COMPANY_SEQ AND A.CASH_FLOW_YEAR = D.YEAR_CF_YEAR AND A.MONTHLY = D.MONTHLY
                                            )D ON A.ORG_COMPANY_SEQ = D.ORG_COMPANY_SEQ AND A.CASH_FLOW_YEAR = D.YEAR_CF_YEAR
                                            LEFT OUTER JOIN ORG_COMPANY E ON A.ORG_COMPANY_SEQ = E.SEQ
                                            WHERE 1 = 1
                                            AND A.REGIST_STATUS = @RegistStatus
                                            AND CUMULATIVE = @Cumulative
                                            AND C.DIFF = @Diff
                                            AND E.SEQ = @Seq
                                            AND CASH_FLOW_YEAR = @Year
                                            AND A.MONTHLY = @Month
                                        ) A
                                        UNPIVOT (
                                            companyCashFlowValue FOR companyCashFlowName IN (연초현금,세후EBITDA,WC변동,영업기타,NetCAPEX,순금융비용,재무활동,월말현금,가용현금)
                                        ) AS A";

                    return con.Query<GroupCompany>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<GroupCompany> companySumCashFlow(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" SELECT *
                                        FROM
                                        (
                                          SELECT ISNULL(B.BASIC_CASH, 0)			AS '연초현금'
                                                ,ISNULL(C.EBITDA, 0)				AS '세후EBITDA'
                                                ,ISNULL(C.WC_SUM,0)				    AS 'WC변동'
                                                ,ISNULL(C.ETC,0)					AS '영업기타'
                                                ,ISNULL(C.NET_CAPEX_SUM,0)			AS 'NetCAPEX'
                                                ,ISNULL(C.FINANCIAL_COST,0)		    AS '순금융비용'
                                                ,ISNULL(C.FINANCIAL_SUM,0)			AS '재무활동'
                                                ,ISNULL(C.ENDING_CASH,0)			AS '월말현금'
                                                ,ISNULL(C.AVAILABLE_CASH,0)		    AS '가용현금'
                                            FROM PM_CASH_FLOW A 
                                            LEFT OUTER JOIN PM_CASH_FLOW_BE_CASH B ON A.SEQ = B.PM_CASH_FLOW_SEQ
                                            LEFT OUTER JOIN PM_CASH_FLOW_CUMULATIVE C ON B.PM_CASH_FLOW_SEQ = C.PM_CASH_FLOW_SEQ AND A.SEQ = C.PM_CASH_FLOW_SEQ
                                            LEFT OUTER JOIN ORG_COMPANY D ON A.ORG_COMPANY_SEQ = D.SEQ
                                            WHERE 1 = 1
                                            AND A.REGIST_STATUS = @RegistStatus
                                            AND CUMULATIVE = @Cumulative 
                                            AND DIFF = @Diff
                                            AND D.SEQ = @Seq
                                            AND CASH_FLOW_YEAR = @Year
                                            AND A.MONTHLY = @Month
                                        )A
                                        UNPIVOT (
                                            companyCashFlowValue FOR companyCashFlowName IN (연초현금,세후EBITDA,WC변동,영업기타,NetCAPEX,순금융비용,재무활동,월말현금,가용현금)
                                        ) AS A ";

                    return con.Query<GroupCompany>(query, param).ToList();
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

        public IEnumerable<GroupCompany> companySalesCalc(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" SELECT BUSINESS_NAME	AS 'businessName'
                                             ,ISNULL(D.SALES, 0) AS 'companyPlanSales'
                                             ,ISNULL(B.SALES, 0) AS 'companyResultSales'
                                             ,F.SEQ              AS 'businessSeq'
                                             ,A.ORG_COMPANY_SEQ  AS 'OrgCompanySeq'
                                        FROM PM_PAL A
                                        LEFT OUTER JOIN PM_PAL_BUSINESS B ON A.SEQ = B.PM_PAL_SEQ 
                                        LEFT OUTER JOIN PLAN_MONTHLY_PAL C ON A.ORG_COMPANY_SEQ = C.ORG_COMPANY_SEQ AND A.PAL_YEAR = C.MONTHLY_PAL_YEAR
                                        LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS D ON C.SEQ = D.PLAN_MONTHLY_PAL_SEQ AND A.MONTHLY = D.MONTHLY AND B.ORG_BUSINESS_SEQ = D.ORG_BUSINESS_SEQ
                                        LEFT OUTER JOIN ORG_BUSINESS F ON A.ORG_COMPANY_SEQ = F.ORG_COMPANY_SEQ AND D.ORG_BUSINESS_SEQ = F.SEQ
                                        WHERE 1 = 1
                                        AND A.REGIST_STATUS = @RegistStatus
                                        AND B.MONTHLY_TYPE = @MonthlyType
                                        AND A.PAL_YEAR = @Year
                                        AND A.MONTHLY = @Month
                                        AND A.ORG_COMPANY_SEQ = @Seq
                                        GROUP BY F.ORD, BUSINESS_NAME, D.SALES, B.SALES, F.SEQ, A.ORG_COMPANY_SEQ
                                        ORDER BY F.ORD";

                    return con.Query<GroupCompany>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<GroupCompany> companyEbitCalc(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" SELECT BUSINESS_NAME	     AS 'businessName'
                                             ,ISNULL(D.EBIT, 0)  AS 'companyPlanEbit'
                                             ,ISNULL(B.EBIT, 0)  AS 'companyResultEbit'
                                             ,F.SEQ              AS 'businessSeq'
                                             ,A.ORG_COMPANY_SEQ  AS 'companySeq'
                                        FROM PM_PAL A
                                        LEFT OUTER JOIN PM_PAL_BUSINESS B ON A.SEQ = B.PM_PAL_SEQ 
                                        LEFT OUTER JOIN PLAN_MONTHLY_PAL C ON A.ORG_COMPANY_SEQ = C.ORG_COMPANY_SEQ AND A.PAL_YEAR = C.MONTHLY_PAL_YEAR
                                        LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS D ON C.SEQ = D.PLAN_MONTHLY_PAL_SEQ AND A.MONTHLY = D.MONTHLY AND B.ORG_BUSINESS_SEQ = D.ORG_BUSINESS_SEQ
                                        LEFT OUTER JOIN ORG_BUSINESS F ON A.ORG_COMPANY_SEQ = F.ORG_COMPANY_SEQ AND D.ORG_BUSINESS_SEQ = F.SEQ
                                        WHERE 1 = 1
                                        AND A.REGIST_STATUS = @RegistStatus
                                        AND B.MONTHLY_TYPE = @MonthlyType
                                        AND A.ORG_COMPANY_SEQ = @Seq
                                        AND A.PAL_YEAR = @Year
                                        AND A.MONTHLY = @Month
                                        GROUP BY F.ORD, BUSINESS_NAME, D.EBIT, B.EBIT, F.SEQ, A.ORG_COMPANY_SEQ 
                                        ORDER BY F.ORD";

                    return con.Query<GroupCompany>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<GroupCompany> companyProfitTable(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" SELECT BUSINESS_NAME	AS 'businessName'
                                             ,ISNULL(D.SALES, 0) AS 'companyPlanSales'
                                             ,ISNULL(B.SALES, 0) AS 'companyResultSales'
                                             ,ISNULL(D.EBIT, 0) AS 'companyPlanEbit'
                                             ,ISNULL(B.EBIT, 0) AS 'companyResultEbit'
                                        FROM PM_PAL A
                                        LEFT OUTER JOIN PM_PAL_BUSINESS B ON A.SEQ = B.PM_PAL_SEQ 
                                        LEFT OUTER JOIN PLAN_MONTHLY_PAL C ON A.ORG_COMPANY_SEQ = C.ORG_COMPANY_SEQ AND A.PAL_YEAR = C.MONTHLY_PAL_YEAR
                                        LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS D ON C.SEQ = D.PLAN_MONTHLY_PAL_SEQ AND A.MONTHLY = D.MONTHLY AND B.ORG_BUSINESS_SEQ = D.ORG_BUSINESS_SEQ
                                        LEFT OUTER JOIN ORG_BUSINESS F ON A.ORG_COMPANY_SEQ = F.ORG_COMPANY_SEQ AND D.ORG_BUSINESS_SEQ = F.SEQ
                                        WHERE B.MONTHLY_TYPE = @MonthlyType
                                        AND A.ORG_COMPANY_SEQ = @Seq
                                        AND A.PAL_YEAR = @Year
                                        AND A.MONTHLY = @Month
                                        GROUP BY F.ORD, BUSINESS_NAME, D.SALES, B.SALES, D.EBIT, B.EBIT 
                                        ORDER BY F.ORD";

                    return con.Query<GroupCompany>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<GroupCompany> companySalesCalcTotal(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    // 계획과 실적이 바뀐듯?
                    string query = @" SELECT BUSINESS_NAME		            AS 'businessName'
	                                        ,ISNULL(C.SALES,0)				AS 'CompanyPlanSales'
	                                        ,ISNULL(B.SALES,0)				AS 'CompanyResultSales'
                                            ,A.ORG_COMPANY_SEQ				AS 'companySeq'
                                            ,B.ORG_BUSINESS_SEQ				AS 'businessSeq'
                                        FROM PM_PAL A
                                        LEFT OUTER JOIN PM_PAL_BUSINESS B ON A.SEQ = B.PM_PAL_SEQ
                                        LEFT OUTER JOIN (SELECT ORG_COMPANY_SEQ
						                                        ,ORG_BUSINESS_SEQ
                                                                ,@Month AS MONTHLY
                                                                ,SUM(SALES) AS SALES
                                                           FROM PLAN_MONTHLY_PAL A
                                                           LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS B ON A.SEQ = B.PLAN_MONTHLY_PAL_SEQ
                                                           WHERE 1 = 1
                                                           AND A.REGIST_STATUS = @RegistStatus
                                                           AND A.MONTHLY_PAL_YEAR = @Year
                                                           AND A.ORG_COMPANY_SEQ = @Seq
                                                           AND B.MONTHLY <> '99' AND B.MONTHLY <= @Month
                                                           GROUP BY A.ORG_COMPANY_SEQ, ORG_BUSINESS_SEQ
                                        ) C ON A.ORG_COMPANY_SEQ = C.ORG_COMPANY_SEQ AND A.MONTHLY = C.MONTHLY AND B.ORG_BUSINESS_SEQ = C.ORG_BUSINESS_SEQ
                                        LEFT OUTER JOIN ORG_BUSINESS D ON  B.ORG_BUSINESS_SEQ = D.SEQ
                                        WHERE 1 = 1
                                        AND A.REGIST_STATUS = @RegistStatus
                                        AND B.MONTHLY_TYPE = @MonthlyType
                                        AND A.ORG_COMPANY_SEQ = @Seq
                                        AND A.PAL_YEAR = @Year
                                        AND A.MONTHLY = @Month
                                        GROUP BY D.ORD, BUSINESS_NAME, B.SALES, C.SALES, A.ORG_COMPANY_SEQ, B.ORG_BUSINESS_SEQ
                                        ORDER BY D.ORD, B.ORG_BUSINESS_SEQ ASC";

                    //string query = @" SELECT BUSINESS_NAME		            AS 'businessName'
	                   //                     ,ISNULL(B.SALES,0)				AS 'CompanyPlanSales'
	                   //                     ,ISNULL(C.SALES,0)				AS 'CompanyResultSales'
                    //                    FROM PM_PAL A
                    //                    LEFT OUTER JOIN PM_PAL_BUSINESS B ON A.SEQ = B.PM_PAL_SEQ
                    //                    LEFT OUTER JOIN (SELECT ORG_COMPANY_SEQ
						              //                          ,ORG_BUSINESS_SEQ
                    //                                            ,@Month AS MONTHLY
                    //                                            ,SUM(SALES) AS SALES
                    //                                       FROM PLAN_MONTHLY_PAL A
                    //                                       LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS B ON A.SEQ = B.PLAN_MONTHLY_PAL_SEQ
                    //                                       WHERE A.MONTHLY_PAL_YEAR = @Year
                    //                                       AND A.ORG_COMPANY_SEQ = @Seq
                    //                                       AND B.MONTHLY <> '99' AND B.MONTHLY <= @Month
                    //                                       GROUP BY A.ORG_COMPANY_SEQ, ORG_BUSINESS_SEQ
                    //                    ) C ON A.ORG_COMPANY_SEQ = C.ORG_COMPANY_SEQ AND A.MONTHLY = C.MONTHLY AND B.ORG_BUSINESS_SEQ = C.ORG_BUSINESS_SEQ
                    //                    LEFT OUTER JOIN ORG_BUSINESS D ON  B.ORG_BUSINESS_SEQ = D.SEQ
                    //                    WHERE B.MONTHLY_TYPE = @MonthlyType
                    //                    AND A.ORG_COMPANY_SEQ = @Seq
                    //                    AND A.PAL_YEAR = @Year
                    //                    AND A.MONTHLY = @Month
                    //                    GROUP BY BUSINESS_NAME, B.SALES, C.SALES ";

                    return con.Query<GroupCompany>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<GroupCompany> companyEbitCalcTotal(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    // 
                    string query = @" SELECT BUSINESS_NAME		    AS 'businessName'
	                                        ,ISNULL(C.EBIT,0)		AS 'CompanyPlanEbit'
	                                        ,ISNULL(B.EBIT,0)		AS 'CompanyResultEbit'
                                            ,A.ORG_COMPANY_SEQ		AS 'companySeq'
                                            ,B.ORG_BUSINESS_SEQ		AS 'businessSeq'
                                        FROM PM_PAL A
                                        LEFT OUTER JOIN PM_PAL_BUSINESS B ON A.SEQ = B.PM_PAL_SEQ
                                        LEFT OUTER JOIN (SELECT ORG_COMPANY_SEQ
						                                        ,ORG_BUSINESS_SEQ
                                                                ,@Month AS MONTHLY
                                                                ,SUM(EBIT) AS EBIT
                                                           FROM PLAN_MONTHLY_PAL A
                                                           LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS B ON A.SEQ = B.PLAN_MONTHLY_PAL_SEQ
                                                           WHERE 1 = 1
                                                           AND A.REGIST_STATUS = @RegistStatus
                                                           AND A.MONTHLY_PAL_YEAR = @Year
                                                           AND A.ORG_COMPANY_SEQ = @Seq
                                                           AND B.MONTHLY <> '99' AND B.MONTHLY <= @Month
                                                           GROUP BY A.ORG_COMPANY_SEQ, ORG_BUSINESS_SEQ
                                        ) C ON A.ORG_COMPANY_SEQ = C.ORG_COMPANY_SEQ AND A.MONTHLY = C.MONTHLY AND B.ORG_BUSINESS_SEQ = C.ORG_BUSINESS_SEQ
                                        LEFT OUTER JOIN ORG_BUSINESS D ON  B.ORG_BUSINESS_SEQ = D.SEQ
                                        WHERE 1 = 1
                                        AND A.REGIST_STATUS = @RegistStatus
                                        AND B.MONTHLY_TYPE = @MonthlyType
                                        AND A.ORG_COMPANY_SEQ = @Seq
                                        AND A.PAL_YEAR = @Year
                                        AND A.MONTHLY = @Month
                                        GROUP BY D.ORD, BUSINESS_NAME, B.EBIT, C.EBIT, A.ORG_COMPANY_SEQ, B.ORG_BUSINESS_SEQ 
                                        ORDER BY D.ORD";

                    //string query = @" SELECT BUSINESS_NAME		    AS 'businessName'
	                   //                     ,ISNULL(B.EBIT,0)		AS 'CompanyPlanEbit'
	                   //                     ,ISNULL(C.EBIT,0)		AS 'CompanyResultEbit'
                    //                    FROM PM_PAL A
                    //                    LEFT OUTER JOIN PM_PAL_BUSINESS B ON A.SEQ = B.PM_PAL_SEQ
                    //                    LEFT OUTER JOIN (SELECT ORG_COMPANY_SEQ
						              //                          ,ORG_BUSINESS_SEQ
                    //                                            ,@Month AS MONTHLY
                    //                                            ,SUM(EBIT) AS EBIT
                    //                                       FROM PLAN_MONTHLY_PAL A
                    //                                       LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS B ON A.SEQ = B.PLAN_MONTHLY_PAL_SEQ
                    //                                       WHERE A.MONTHLY_PAL_YEAR = @Year
                    //                                       AND A.ORG_COMPANY_SEQ = @Seq
                    //                                       AND B.MONTHLY <> '99' AND B.MONTHLY <= @Month
                    //                                       GROUP BY A.ORG_COMPANY_SEQ, ORG_BUSINESS_SEQ
                    //                    ) C ON A.ORG_COMPANY_SEQ = C.ORG_COMPANY_SEQ AND A.MONTHLY = C.MONTHLY AND B.ORG_BUSINESS_SEQ = C.ORG_BUSINESS_SEQ
                    //                    LEFT OUTER JOIN ORG_BUSINESS D ON  B.ORG_BUSINESS_SEQ = D.SEQ
                    //                    WHERE B.MONTHLY_TYPE = @MonthlyType
                    //                    AND A.ORG_COMPANY_SEQ = @Seq
                    //                    AND A.PAL_YEAR = @Year
                    //                    AND A.MONTHLY = @Month
                    //                    GROUP BY BUSINESS_NAME, B.EBIT, C.EBIT ";

                    return con.Query<GroupCompany>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<GroupCompany> companyProfitTotalTable(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" SELECT BUSINESS_NAME		    AS 'businessName'
                                            ,ISNULL(C.SALES,0)		AS 'CompanyPlanSales'
	                                        ,ISNULL(B.SALES,0)		AS 'CompanyResultSales'
	                                        ,ISNULL(C.EBIT,0)		AS 'CompanyPlanEbit'
	                                        ,ISNULL(B.EBIT,0)		AS 'CompanyResultEbit'
                                        FROM PM_PAL A
                                        LEFT OUTER JOIN PM_PAL_BUSINESS B ON A.SEQ = B.PM_PAL_SEQ
                                        LEFT OUTER JOIN (SELECT ORG_COMPANY_SEQ
						                                        ,ORG_BUSINESS_SEQ
                                                                ,@Month AS MONTHLY
                                                                ,SUM(EBIT) AS EBIT
                                                                ,SUM(SALES) AS SALES
                                                           FROM PLAN_MONTHLY_PAL A
                                                           LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS B ON A.SEQ = B.PLAN_MONTHLY_PAL_SEQ
                                                           WHERE A.MONTHLY_PAL_YEAR = @Year
                                                           AND A.ORG_COMPANY_SEQ = @Seq
                                                           AND B.MONTHLY <> '99' AND B.MONTHLY <= @Month
                                                           GROUP BY A.ORG_COMPANY_SEQ, ORG_BUSINESS_SEQ
                                        ) C ON A.ORG_COMPANY_SEQ = C.ORG_COMPANY_SEQ AND A.MONTHLY = C.MONTHLY AND B.ORG_BUSINESS_SEQ = C.ORG_BUSINESS_SEQ
                                        LEFT OUTER JOIN ORG_BUSINESS D ON  B.ORG_BUSINESS_SEQ = D.SEQ
                                        WHERE B.MONTHLY_TYPE = @MonthlyType
                                        AND A.ORG_COMPANY_SEQ = @Seq
                                        AND A.PAL_YEAR = @Year
                                        AND A.MONTHLY = @Month
-- 2019.02.27 BU 이름이 없는 것은 나타나지 않게 변경함
AND D.BUSINESS_NAME IS NOT NULL
                                        GROUP BY D.ORD, BUSINESS_NAME, B.SALES, C.SALES, B.EBIT, C.EBIT 
                                        ORDER BY D.ORD";

                    //string query = @" SELECT BUSINESS_NAME		    AS 'businessName'
                    //                        ,ISNULL(B.SALES,0)		AS 'CompanyPlanSales'
	                   //                     ,ISNULL(C.SALES,0)		AS 'CompanyResultSales'
	                   //                     ,ISNULL(B.EBIT,0)		AS 'CompanyPlanEbit'
	                   //                     ,ISNULL(C.EBIT,0)		AS 'CompanyResultEbit'
                    //                    FROM PM_PAL A
                    //                    LEFT OUTER JOIN PM_PAL_BUSINESS B ON A.SEQ = B.PM_PAL_SEQ
                    //                    LEFT OUTER JOIN (SELECT ORG_COMPANY_SEQ
						              //                          ,ORG_BUSINESS_SEQ
                    //                                            ,@Month AS MONTHLY
                    //                                            ,SUM(EBIT) AS EBIT
                    //                                            ,SUM(SALES) AS SALES
                    //                                       FROM PLAN_MONTHLY_PAL A
                    //                                       LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS B ON A.SEQ = B.PLAN_MONTHLY_PAL_SEQ
                    //                                       WHERE A.MONTHLY_PAL_YEAR = @Year
                    //                                       AND A.ORG_COMPANY_SEQ = @Seq
                    //                                       AND B.MONTHLY <> '99' AND B.MONTHLY <= @Month
                    //                                       GROUP BY A.ORG_COMPANY_SEQ, ORG_BUSINESS_SEQ
                    //                    ) C ON A.ORG_COMPANY_SEQ = C.ORG_COMPANY_SEQ AND A.MONTHLY = C.MONTHLY AND B.ORG_BUSINESS_SEQ = C.ORG_BUSINESS_SEQ
                    //                    LEFT OUTER JOIN ORG_BUSINESS D ON  B.ORG_BUSINESS_SEQ = D.SEQ
                    //                    WHERE B.MONTHLY_TYPE = @MonthlyType
                    //                    AND A.ORG_COMPANY_SEQ = @Seq
                    //                    AND A.PAL_YEAR = @Year
                    //                    AND A.MONTHLY = @Month
                    //                    GROUP BY BUSINESS_NAME, B.SALES, C.SALES, B.EBIT, C.EBIT ";

                    return con.Query<GroupCompany>(query, param).ToList();
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

        public IEnumerable<GroupCompany> companyExpectSales(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" SELECT ISNULL(BUSINESS_NAME, 'companyName')		  AS 'expectCompanyName'
	                                          ,ISNULL(A.SALES, 0)						  AS 'CompanyExpectResultSales'
	                                          ,ISNULL(D.SALES, 0)						  AS 'CompanyExpectPlanSales'
	                                          --,ISNULL(D.SALES, 0) + ISNULL(A.SALES, 0)    AS 'CompanyExpectTotalSales'
                                        FROM PM_PAL_BUSINESS A
                                        LEFT OUTER JOIN PM_PAL B ON A.PM_PAL_SEQ = B.SEQ
                                        LEFT OUTER JOIN PLAN_MONTHLY_PAL C ON B.ORG_COMPANY_SEQ = C.ORG_COMPANY_SEQ AND B.PAL_YEAR = C.MONTHLY_PAL_YEAR
                                        LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS D ON C.SEQ = D.PLAN_MONTHLY_PAL_SEQ AND A.ORG_BUSINESS_SEQ = D.ORG_BUSINESS_SEQ AND B.MONTHLY = D.MONTHLY
                                        LEFT OUTER JOIN ORG_COMPANY E ON B.ORG_COMPANY_SEQ = E.SEQ
                                        LEFT OUTER JOIN ORG_BUSINESS F ON E.SEQ = F.ORG_COMPANY_SEQ AND D.ORG_BUSINESS_SEQ = F.SEQ
                                        WHERE A.MONTHLY_TYPE = @MonthlyType
                                        AND E.SEQ = @Seq
                                        AND B.PAL_YEAR = @Year
                                        AND B.MONTHLY = @Month
                                        GROUP BY BUSINESS_NAME, A.SALES, D.SALES 

                                        SELECT UNION_NAME			    AS 'unionName'
	                                        ,ISNULL(SUM(C.SALES),0) AS 'groupMainExpectPlanSales'
	                                        ,ISNULL(SUM(B.SALES),0) AS 'groupMainExpectResultSales'
                                        FROM PM_PAL A
                                        LEFT OUTER JOIN PM_PAL_SUMMARY B ON A.SEQ = B.PM_PAL_SEQ 
                                        LEFT OUTER JOIN(SELECT A.ORG_COMPANY_SEQ
					                                          ,SUM(B.SALES) AS SALES
					                                          ,@Month AS MONTHLY
				                                        FROM PLAN_MONTHLY_PAL A
				                                        LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS_MONTHLY_SUM B ON A.SEQ = B.PLAN_MONTHLY_PAL_SEQ
				                                        WHERE A.MONTHLY_PAL_YEAR = @Year
                                                        AND A.ORG_COMPANY_SEQ = @Seq
				                                        AND B.MONTHLY <> '99' AND B.MONTHLY <= @Month
				                                        GROUP BY ORG_COMPANY_SEQ) C ON A.ORG_COMPANY_SEQ = C.ORG_COMPANY_SEQ AND A.MONTHLY = C.MONTHLY
                                        LEFT OUTER JOIN ORG_COMPANY D ON A.ORG_COMPANY_SEQ = D.SEQ
                                        LEFT OUTER JOIN ORG_UNION E ON D.ORG_UNION_SEQ = E.SEQ
                                        WHERE B.MONTHLY_TYPE = @MonthlyType
                                        AND A.PAL_YEAR = @Year
                                        AND A.MONTHLY = @Month
                                        GROUP BY UNION_NAME";

                    return con.Query<GroupCompany>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<GroupCompany> companyExpect(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" SELECT BUSINESS_NAME				AS 'businessName'
                                            ,ISNULL(C.SALES,0)		    AS 'companyExpectPlanSales'
                                            ,ISNULL(B.SALES,0)		    AS 'companyExpectResultSales'
                                            ,ISNULL(C.EBIT,0)		    AS 'companyExpectPlanEbit'
                                            ,ISNULL(B.EBIT,0)		    AS 'companyExpectResultEbit'
                                            ,A.ORG_COMPANY_SEQ		    AS 'companySeq'
                                            ,B.ORG_BUSINESS_SEQ         AS 'businessSeq'
                                        FROM PM_PAL A
                                        LEFT OUTER JOIN PM_PAL_BUSINESS B ON A.SEQ = B.PM_PAL_SEQ 
                                        LEFT OUTER JOIN(SELECT A.ORG_COMPANY_SEQ
						                                      ,B.ORG_BUSINESS_SEQ
                                                              ,SUM(B.SALES) AS SALES
                                                              ,SUM(B.EBIT)  AS EBIT
                                                              ,@Month AS MONTHLY
                                                        FROM PLAN_MONTHLY_PAL A
                                                        LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS B ON A.SEQ = B.PLAN_MONTHLY_PAL_SEQ
                                                        WHERE 1 = 1 
                                                        AND A.REGIST_STATUS = @RegistStatus
                                                        AND A.ORG_COMPANY_SEQ = @Seq
                                                        AND A.MONTHLY_PAL_YEAR = @Year
                                                        AND B.MONTHLY <> '99' AND B.MONTHLY <= @Month
                                                        GROUP BY ORG_COMPANY_SEQ, ORG_BUSINESS_SEQ) C ON A.ORG_COMPANY_SEQ = C.ORG_COMPANY_SEQ 
                                                                                                      AND A.MONTHLY = C.MONTHLY AND B.ORG_BUSINESS_SEQ = C.ORG_BUSINESS_SEQ
                                        LEFT OUTER JOIN ORG_BUSINESS D ON A.ORG_COMPANY_SEQ = D.ORG_COMPANY_SEQ AND C.ORG_BUSINESS_SEQ = D.SEQ
                                        WHERE 1 = 1
                                        AND A.REGIST_STATUS = @RegistStatus
                                        AND B.MONTHLY_TYPE = @MonthlyType
                                        AND A.ORG_COMPANY_SEQ = @Seq
                                        AND A.PAL_YEAR = @Year
                                        AND A.MONTHLY = @Month
                                        GROUP BY D.ORD, BUSINESS_NAME, B.SALES, C.SALES, B.EBIT, C.EBIT, A.ORG_COMPANY_SEQ, B.ORG_BUSINESS_SEQ
                                        ORDER BY D.ORD";

                    return con.Query<GroupCompany>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<GroupCompany> companyExpectPreYear(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" SELECT BUSINESS_NAME				AS 'businessName'
                                            ,ISNULL(C.SALES,0)		    AS 'companyExpectPlanSales'
                                            ,ISNULL(B.SALES,0)		    AS 'companyExpectResultSales'
                                            ,ISNULL(C.EBIT,0)		    AS 'companyExpectPlanEbit'
                                            ,ISNULL(B.EBIT,0)		    AS 'companyExpectResultEbit'
                                        FROM PM_PAL A
                                        LEFT OUTER JOIN PM_PAL_BUSINESS B ON A.SEQ = B.PM_PAL_SEQ 
                                        LEFT OUTER JOIN(SELECT A.ORG_COMPANY_SEQ
						                                      ,B.ORG_BUSINESS_SEQ
                                                              ,SUM(B.SALES) AS SALES
                                                              ,SUM(B.EBIT)  AS EBIT
                                                              ,@Month AS MONTHLY
                                                        FROM PLAN_MONTHLY_PAL A
                                                        LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS B ON A.SEQ = B.PLAN_MONTHLY_PAL_SEQ
                                                        WHERE A.ORG_COMPANY_SEQ = @Seq
                                                        AND A.MONTHLY_PAL_YEAR = @Year
                                                        AND B.MONTHLY <> '99' AND B.MONTHLY <= @Month
                                                        GROUP BY ORG_COMPANY_SEQ, ORG_BUSINESS_SEQ) C ON A.ORG_COMPANY_SEQ = C.ORG_COMPANY_SEQ 
                                                                                                      AND A.MONTHLY = C.MONTHLY AND B.ORG_BUSINESS_SEQ = C.ORG_BUSINESS_SEQ
                                        LEFT OUTER JOIN ORG_BUSINESS D ON A.ORG_COMPANY_SEQ = D.ORG_COMPANY_SEQ AND C.ORG_BUSINESS_SEQ = D.SEQ
                                        WHERE B.MONTHLY_TYPE = @MonthlyType
                                        AND A.ORG_COMPANY_SEQ = @Seq
                                        AND A.PAL_YEAR = @Year
                                        AND A.MONTHLY = @Month
                                        GROUP BY BUSINESS_NAME, B.SALES, C.SALES, B.EBIT, C.EBIT";

                    return con.Query<GroupCompany>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<GroupCompany> companyExpectRestSales(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" SELECT *
	                                  FROM(
										  SELECT @MonthlyTypeFirst	AS 'restSalesKind'
												,BUSINESS_NAME	    AS 'businessName'
												,ISNULL(C.SALES, 0) AS 'companyExpectPlanSales'
												,ISNULL(B.SALES, 0) AS 'companyExpectResultSales'
												,ISNULL(C.EBIT, 0)  AS 'companyExpectPlanEbit'
												,ISNULL(B.EBIT, 0)  AS 'companyExpectResultEbit'
                                                ,A.ORG_COMPANY_SEQ		    AS 'companySeq'
                                                ,B.ORG_BUSINESS_SEQ         AS 'businessSeq'
                                                ,D.ORD
										   FROM PM_PAL A
										   LEFT OUTER JOIN PM_PAL_BUSINESS B ON A.SEQ = B.PM_PAL_SEQ 
										   LEFT OUTER JOIN(SELECT A.ORG_COMPANY_SEQ
																 ,B.ORG_BUSINESS_SEQ
																 ,SUM(B.SALES) AS SALES
																 ,SUM(B.EBIT) AS EBIT
																 ,@Month AS MONTHLY
														   FROM PLAN_MONTHLY_PAL A
														   LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS B ON A.SEQ = B.PLAN_MONTHLY_PAL_SEQ
														   WHERE 1 = 1
                                                           AND A.REGIST_STATUS = @RegistStatus
                                                           AND A.ORG_COMPANY_SEQ = @Seq
														   AND A.MONTHLY_PAL_YEAR = @Year
														   AND B.MONTHLY <> '99' AND B.MONTHLY <= '12' -- 당해년도 12월까지 합산을 하기 위한 조건
														   GROUP BY ORG_COMPANY_SEQ, ORG_BUSINESS_SEQ) C ON A.ORG_COMPANY_SEQ = C.ORG_COMPANY_SEQ 
																									  AND A.MONTHLY = C.MONTHLY AND B.ORG_BUSINESS_SEQ = C.ORG_BUSINESS_SEQ
										   LEFT OUTER JOIN ORG_BUSINESS D ON A.ORG_COMPANY_SEQ = D.ORG_COMPANY_SEQ AND B.ORG_BUSINESS_SEQ = D.SEQ
										   WHERE 1 = 1
                                           AND A.REGIST_STATUS = @RegistStatus
                                           AND B.MONTHLY_TYPE = @MonthlyTypeFirst
										   AND A.ORG_COMPANY_SEQ = @Seq
										   AND A.PAL_YEAR = @Year
										   AND A.MONTHLY = @Month
										   GROUP BY D.ORD, BUSINESS_NAME, C.SALES, B.SALES, C.EBIT, B.EBIT, A.ORG_COMPANY_SEQ, B.ORG_BUSINESS_SEQ
										   UNION 
										   SELECT @MonthlyTypeSecond		AS 'restSalesKind' 
												,BUSINESS_NAME				AS 'businessName'
												,ISNULL(C.SALES,0)		    AS 'companyExpectPlanSales'
												,ISNULL(B.SALES,0)		    AS 'companyExpectResultSales'
												,ISNULL(C.EBIT,0)		    AS 'companyExpectPlanEbit'
												,ISNULL(B.EBIT,0)		    AS 'companyExpectResultEbit'
                                                ,A.ORG_COMPANY_SEQ		    AS 'companySeq'
                                                ,B.ORG_BUSINESS_SEQ         AS 'businessSeq'
                                                ,D.ORD
											FROM PM_PAL A
											LEFT OUTER JOIN PM_PAL_BUSINESS B ON A.SEQ = B.PM_PAL_SEQ 
											LEFT OUTER JOIN(SELECT A.ORG_COMPANY_SEQ
																  ,B.ORG_BUSINESS_SEQ
																  ,SUM(B.SALES) AS SALES
																  ,SUM(B.EBIT)  AS EBIT
																  ,@Month AS MONTHLY
															FROM PLAN_MONTHLY_PAL A
															LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS B ON A.SEQ = B.PLAN_MONTHLY_PAL_SEQ
															WHERE 1 = 1
                                                            AND A.REGIST_STATUS = @RegistStatus
                                                            AND A.ORG_COMPANY_SEQ = @Seq
															AND A.MONTHLY_PAL_YEAR = @Year
															AND B.MONTHLY <> '99' AND B.MONTHLY <= @Month
															GROUP BY ORG_COMPANY_SEQ, ORG_BUSINESS_SEQ) C ON A.ORG_COMPANY_SEQ = C.ORG_COMPANY_SEQ 
																										  AND A.MONTHLY = C.MONTHLY AND B.ORG_BUSINESS_SEQ = C.ORG_BUSINESS_SEQ
											LEFT OUTER JOIN ORG_BUSINESS D ON A.ORG_COMPANY_SEQ = D.ORG_COMPANY_SEQ AND C.ORG_BUSINESS_SEQ = D.SEQ
											WHERE 1 = 1
                                            AND A.REGIST_STATUS = @RegistStatus
                                            AND B.MONTHLY_TYPE = @MonthlyTypeSecond
											AND A.ORG_COMPANY_SEQ = @Seq
											AND A.PAL_YEAR = @Year
											AND A.MONTHLY = @Month
											GROUP BY D.ORD, BUSINESS_NAME, B.SALES, C.SALES, B.EBIT, C.EBIT, A.ORG_COMPANY_SEQ, B.ORG_BUSINESS_SEQ
                                        )A
                                        ORDER BY restSalesKind DESC, ORD ASC ";

                    return con.Query<GroupCompany>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<GroupCompany> companyExpectYear(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" SELECT BUSINESS_NAME	  AS 'businessName'
                                             ,ISNULL(C.SALES, 0) AS 'companyExpectPlanSales'
                                             ,ISNULL(B.SALES, 0) AS 'companyExpectResultSales'
                                             ,ISNULL(C.EBIT, 0)  AS 'companyExpectPlanEbit'
                                             ,ISNULL(B.EBIT, 0)  AS 'companyExpectResultEbit'
                                             ,A.ORG_COMPANY_SEQ		AS 'companySeq'
                                             ,B.ORG_BUSINESS_SEQ  AS 'businessSeq'
                                        FROM PM_PAL A
                                        LEFT OUTER JOIN PM_PAL_BUSINESS B ON A.SEQ = B.PM_PAL_SEQ 
                                        LEFT OUTER JOIN(SELECT A.ORG_COMPANY_SEQ
					                                          ,B.ORG_BUSINESS_SEQ
                                                              ,SUM(B.SALES) AS SALES
                                                              ,SUM(B.EBIT) AS EBIT
                                                              ,@Month AS MONTHLY
                                                        FROM PLAN_MONTHLY_PAL A
                                                        LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS B ON A.SEQ = B.PLAN_MONTHLY_PAL_SEQ
                                                        WHERE 1 = 1
                                                        AND A.REGIST_STATUS = @RegistStatus
                                                        AND A.ORG_COMPANY_SEQ = @Seq
                                                        AND A.MONTHLY_PAL_YEAR = @Year
                                                        AND B.MONTHLY <> '99' AND B.MONTHLY <= '12' -- 당해년도 12월까지 합산을 하기 위한 조건
                                                        GROUP BY ORG_COMPANY_SEQ, ORG_BUSINESS_SEQ) C ON A.ORG_COMPANY_SEQ = C.ORG_COMPANY_SEQ 
															                                          AND A.MONTHLY = C.MONTHLY AND B.ORG_BUSINESS_SEQ = C.ORG_BUSINESS_SEQ
                                        LEFT OUTER JOIN ORG_BUSINESS D ON A.ORG_COMPANY_SEQ = D.ORG_COMPANY_SEQ AND B.ORG_BUSINESS_SEQ = D.SEQ
                                        WHERE 1 = 1
                                        AND A.REGIST_STATUS = @RegistStatus
                                        AND B.MONTHLY_TYPE = @MonthlyType
                                        AND A.ORG_COMPANY_SEQ = @Seq
                                        AND A.PAL_YEAR = @Year
                                        AND A.MONTHLY = @Month
-- 2019.02.27 BU 이름이 없는 것은 나타나지 않게 변경함
AND D.BUSINESS_NAME IS NOT NULL
                                        GROUP BY D.ORD, BUSINESS_NAME, C.SALES, B.SALES, C.EBIT, B.EBIT, A.ORG_COMPANY_SEQ, B.ORG_BUSINESS_SEQ 
                                        ORDER BY D.ORD";

                    return con.Query<GroupCompany>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<GroupCompany> companyExpectHeaderTable(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" SELECT BUSINESS_NAME	  AS 'businessName'
                                        FROM PM_PAL A
                                        LEFT OUTER JOIN PM_PAL_BUSINESS B ON A.SEQ = B.PM_PAL_SEQ 
                                        LEFT OUTER JOIN(SELECT A.ORG_COMPANY_SEQ
					                                          ,B.ORG_BUSINESS_SEQ
                                                              ,@Month AS MONTHLY
                                                        FROM PLAN_MONTHLY_PAL A
                                                        LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS B ON A.SEQ = B.PLAN_MONTHLY_PAL_SEQ
                                                        WHERE A.ORG_COMPANY_SEQ = @Seq
                                                        AND A.MONTHLY_PAL_YEAR = @Year
                                                        AND B.MONTHLY <> '99' AND B.MONTHLY <= '12' -- 당해년도 12월까지 합산을 하기 위한 조건
                                                        GROUP BY ORG_COMPANY_SEQ, ORG_BUSINESS_SEQ) C ON A.ORG_COMPANY_SEQ = C.ORG_COMPANY_SEQ 
															                                          AND A.MONTHLY = C.MONTHLY AND B.ORG_BUSINESS_SEQ = C.ORG_BUSINESS_SEQ
                                        LEFT OUTER JOIN ORG_BUSINESS D ON A.ORG_COMPANY_SEQ = D.ORG_COMPANY_SEQ AND B.ORG_BUSINESS_SEQ = D.SEQ
                                        WHERE B.MONTHLY_TYPE = @MonthlyType
                                        AND A.ORG_COMPANY_SEQ = @Seq
                                        AND A.PAL_YEAR = @Year
                                        AND A.MONTHLY = @Month
-- 2019.02.27 BU 이름이 없는 것은 나타나지 않게 변경함
AND D.BUSINESS_NAME IS NOT NULL
                                        GROUP BY D.ORD, BUSINESS_NAME 
                                        ORDER BY D.ORD";

                    return con.Query<GroupCompany>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<GroupCompany> companyExpectYearEbit(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" SELECT BUSINESS_NAME							        AS 'expectCompanyName'
                                             ,ISNULL(A.EBIT, 0)						        AS 'CompanyExpectResultEbit'
                                             ,ISNULL(D.EBIT, 0)						        AS 'CompanyExpectPlanEbit'
                                             ,ISNULL(D.EBIT, 0) + ISNULL(A.EBIT, 0)         AS 'CompanyExpectTotalEbit'
                                        FROM PM_PAL_BUSINESS A
                                        LEFT OUTER JOIN PM_PAL B ON A.PM_PAL_SEQ = B.SEQ
                                        LEFT OUTER JOIN PLAN_MONTHLY_PAL C ON B.ORG_COMPANY_SEQ = C.ORG_COMPANY_SEQ AND B.PAL_YEAR = C.MONTHLY_PAL_YEAR
                                        LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS D ON C.SEQ = D.PLAN_MONTHLY_PAL_SEQ AND A.ORG_BUSINESS_SEQ = D.ORG_BUSINESS_SEQ AND B.MONTHLY = D.MONTHLY
                                        LEFT OUTER JOIN ORG_COMPANY E ON B.ORG_COMPANY_SEQ = E.SEQ
                                        LEFT OUTER JOIN ORG_BUSINESS F ON E.SEQ = F.ORG_COMPANY_SEQ AND D.ORG_BUSINESS_SEQ = F.SEQ
                                        WHERE A.MONTHLY_TYPE = @MonthlyType
                                        AND E.SEQ = @Seq
                                        AND B.PAL_YEAR = @Year
                                        AND B.MONTHLY = @Month
                                        GROUP BY BUSINESS_NAME, A.EBIT, D.EBIT
                                        ORDER BY BUSINESS_NAME ASC ";

                    return con.Query<GroupCompany>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        #endregion

        #region << 재무비율 및 B/S >>

        /// <summary>
        /// 재무비율 및 B/S(ROIC)
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        public IEnumerable<GroupCompany> companyPlanRoic(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    // 2019.03.05 작년도 계획이 없으면 데이터가 밀려버려 수정
                    string query = @"
		SELECT	C.SCHEDULE_YEAR								AS YEARLY_YEAR
				, C.REG_MONTH								AS 'companyMonthlyRoic'
				, ISNULL(A.PAIN_IN_CAPITAL, 0)				AS PAIN_IN_CAPITAL
				, ISNULL(A.AFTER_TAX_OPERATION_PROFIT, 0)	AS AFTER_TAX_OPERATION_PROFIT
				/*
                , CONVERT(DECIMAL(12, 2),
					ROUND(CASE WHEN ISNULL(A.PAIN_IN_CAPITAL, 0) = 0 THEN 0
								WHEN ISNULL(A.AFTER_TAX_OPERATION_PROFIT, 0) = 0 THEN 0
								ELSE (A.AFTER_TAX_OPERATION_PROFIT / A.PAIN_IN_CAPITAL) * 100 END, 2)) AS 'companyRoic'
                */
				, CASE WHEN ISNULL(A.PAIN_IN_CAPITAL, 0) = 0 THEN 0
								WHEN ISNULL(A.AFTER_TAX_OPERATION_PROFIT, 0) = 0 THEN 0
								ELSE (A.AFTER_TAX_OPERATION_PROFIT / A.PAIN_IN_CAPITAL) * 100 END AS 'companyRoic'
				, C.SCHEDULE_YEAR + C.REG_MONTH				AS [DATE]
		FROM	PLAN_SCHEDULE_PERFORMANCE_REG		C
			LEFT OUTER JOIN (
			SELECT	YEARLY_YEAR
					, MONTHLY
					, ISNULL(PAIN_IN_CAPITAL, 0)            AS PAIN_IN_CAPITAL
					, ISNULL(AFTER_TAX_OPERATION_PROFIT, 0) AS AFTER_TAX_OPERATION_PROFIT
					, YEARLY_YEAR + MONTHLY AS [DATE]
			FROM	PLAN_YEAR_BS A
			LEFT OUTER JOIN PLAN_YEAR_BS_ROIC B ON A.SEQ = B.PLAN_YEAR_BS_SEQ AND B.MONTHLY != '99' -- 합계 제외
			WHERE	1 = 1
			AND		A.ORG_COMPANY_SEQ = @Seq
			AND		A.REGIST_STATUS = @RegistStatus
		)			A ON C.SCHEDULE_YEAR = A.YEARLY_YEAR AND C.REG_MONTH = A.MONTHLY
		WHERE	1 = 1
		AND		C.SCHEDULE_YEAR + C.REG_MONTH BETWEEN @StartDate AND @EndDate
		ORDER BY C.SCHEDULE_YEAR + C.REG_MONTH";

                    //string query = @"SELECT YEARLY_YEAR
	                   //                    ,MONTHLY                                                                                                    AS 'companyMonthlyRoic'
		                  //                 ,CONVERT(DECIMAL(12, 2), ROUND(CASE WHEN ISNULL(SUM(PAIN_IN_CAPITAL), 0) = 0 THEN 0 
                    //                                                           WHEN ISNULL(SUM(AFTER_TAX_OPERATION_PROFIT), 0) = 0 THEN 0 
										          //                        ELSE (SUM(AFTER_TAX_OPERATION_PROFIT) / SUM(PAIN_IN_CAPITAL)) * 100 END, 2)) AS 'companyRoic'
		                  //                 ,[DATE]
	                   //               FROM(
		                  //                  SELECT YEARLY_YEAR
                    //                              ,MONTHLY
                    //                              ,ISNULL(PAIN_IN_CAPITAL, 0)            AS PAIN_IN_CAPITAL
                    //                              ,ISNULL(AFTER_TAX_OPERATION_PROFIT, 0) AS AFTER_TAX_OPERATION_PROFIT
                    //                              ,YEARLY_YEAR + MONTHLY AS [DATE]
		                  //                  FROM PLAN_YEAR_BS A
		                  //                  LEFT OUTER JOIN PLAN_YEAR_BS_ROIC B ON A.SEQ = B.PLAN_YEAR_BS_SEQ AND B.MONTHLY != '99' -- 합계 제외
                    //                        WHERE 1 = 1
                    //                        AND A.ORG_COMPANY_SEQ = @Seq
                    //                        AND A.REGIST_STATUS = @RegistStatus
	                   //                 )A
	                   //                 WHERE A.[DATE] BETWEEN @StartDate AND @EndDate
	                   //                 GROUP BY YEARLY_YEAR, MONTHLY, A.[DATE]";

                    return con.Query<GroupCompany>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<GroupCompany> companyPlanLiabilitiesRate(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    // 2019.03.05 작년도 계획이 없으면 데이터가 밀려버려 수정
                    string query = @"

SELECT	C.SCHEDULE_YEAR								AS YEARLY_YEAR
		, C.REG_MONTH								AS 'companyMonthlyRoic'
		, ISNULL(A.LIABILITIES, 0)					AS LIABILITIES
		, ISNULL(A.CAPITAL, 0)						AS CAPITAL
		, CONVERT(DECIMAL(12, 2),
			ROUND(CASE WHEN ISNULL(A.LIABILITIES, 0) = 0 THEN 0
						WHEN ISNULL(A.CAPITAL, 0) = 0 THEN 0
						ELSE (A.LIABILITIES / A.CAPITAL) * 100 END, 2)) AS 'companyRoic'
		, C.SCHEDULE_YEAR + C.REG_MONTH				AS [DATE]
FROM	PLAN_SCHEDULE_PERFORMANCE_REG		C
LEFT OUTER JOIN (
	SELECT	YEARLY_YEAR
            , MONTHLY
            , ISNULL(LIABILITIES, 0)            AS LIABILITIES
            , ISNULL(CAPITAL, 0) AS CAPITAL
            , YEARLY_YEAR + MONTHLY AS [DATE]
	FROM	PLAN_YEAR_BS A
	LEFT OUTER JOIN PLAN_YEAR_BS_BSHEET B ON A.SEQ = B.PLAN_YEAR_BS_SEQ AND B.MONTHLY != '99' -- 합계는 제외
    WHERE	1 = 1
    AND		A.ORG_COMPANY_SEQ = @Seq
    AND		A.REGIST_STATUS = @RegistStatus
)			A ON C.SCHEDULE_YEAR = A.YEARLY_YEAR AND C.REG_MONTH = A.MONTHLY
WHERE	1 = 1
AND		C.SCHEDULE_YEAR + C.REG_MONTH BETWEEN @StartDate AND @EndDate
ORDER BY C.SCHEDULE_YEAR + C.REG_MONTH

/*
SELECT YEARLY_YEAR
	,MONTHLY                                                                                                    AS 'companyMonthlyRoic'
	,CONVERT(DECIMAL(12, 2), ROUND(CASE WHEN ISNULL(SUM(LIABILITIES), 0) = 0 THEN 0 
                                        WHEN ISNULL(SUM(CAPITAL), 0) = 0 THEN 0 
									ELSE (SUM(LIABILITIES) / SUM(CAPITAL)) * 100 END, 2)) AS 'companyRoic'
	,[DATE]
FROM(
	SELECT YEARLY_YEAR
            ,MONTHLY
            ,ISNULL(LIABILITIES, 0)            AS LIABILITIES
            ,ISNULL(CAPITAL, 0) AS CAPITAL
            ,YEARLY_YEAR + MONTHLY AS [DATE]
	FROM PLAN_YEAR_BS A
	LEFT OUTER JOIN PLAN_YEAR_BS_BSHEET B ON A.SEQ = B.PLAN_YEAR_BS_SEQ AND B.MONTHLY != '99' -- 합계는 제외
    WHERE 1 = 1
    AND A.ORG_COMPANY_SEQ = @Seq
    AND A.REGIST_STATUS = @RegistStatus
)A
WHERE A.[DATE] BETWEEN @StartDate AND @EndDate
GROUP BY YEARLY_YEAR, MONTHLY, A.[DATE]
*/
";

                    return con.Query<GroupCompany>(query, param).ToList();
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
        public IEnumerable<GroupCompany> companyResultRoic(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"SELECT BS_YEAR
		                                    ,MONTHLY                                                                                                    AS 'companyMonthlyRoic'
                                            /*
		                                    ,CONVERT(DECIMAL(12, 2), ROUND(CASE WHEN ISNULL(SUM(PAIN_IN_CAPITAL), 0) = 0 THEN 0 
                                                                                WHEN ISNULL(SUM(AFTER_TAX_OPERATION_PROFIT), 0) = 0 THEN 0 
										                                   ELSE (SUM(AFTER_TAX_OPERATION_PROFIT) / SUM(PAIN_IN_CAPITAL)) * 100 END, 2)) AS 'companyRoic'
                                            */
		                                    , CASE WHEN ISNULL(SUM(PAIN_IN_CAPITAL), 0) = 0 THEN 0 
                                                                                WHEN ISNULL(SUM(AFTER_TAX_OPERATION_PROFIT), 0) = 0 THEN 0 
										                                   ELSE (SUM(AFTER_TAX_OPERATION_PROFIT) / SUM(PAIN_IN_CAPITAL)) * 100 END AS 'companyRoic'
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
                                            AND C.REGIST_STATUS = @RegistStatus
                                            AND C.ORG_COMPANY_SEQ = @Seq
	                                    )A 
	                                    WHERE A.[DATE] BETWEEN @StartDate AND @EndDate
	                                    GROUP BY BS_YEAR, MONTHLY, A.[DATE]";

                    return con.Query<GroupCompany>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<GroupCompany> companyResultLiabilitesRate(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
SELECT BS_YEAR
	,MONTHLY                                                                                                    AS 'companyMonthlyRoic'
	,CONVERT(DECIMAL(12, 2), ROUND(CASE WHEN ISNULL(SUM(LIABILITIES), 0) = 0 THEN 0 
                                        WHEN ISNULL(SUM(CAPITAL), 0) = 0 THEN 0 
									ELSE (SUM(LIABILITIES) / SUM(CAPITAL)) * 100 END, 2)) AS 'companyRoic'
	,[DATE]
FROM(
	SELECT	C.BS_YEAR									AS BS_YEAR
			, C.MONTHLY									AS MONTHLY
			, C.ORG_COMPANY_SEQ							AS ORG_COMPANY_SEQ
			, ISNULL(D.LIABILITIES, 0)	AS LIABILITIES
			, ISNULL(D.CAPITAL, 0)				AS CAPITAL
			, C.BS_YEAR + C.MONTHLY						AS [DATE]
	FROM	PM_BS							C
	LEFT OUTER JOIN PM_BS_BSHEET			D ON C.SEQ = D.PM_BS_SEQ
    WHERE 1 = 1
    AND C.ORG_COMPANY_SEQ = @Seq
    AND C.REGIST_STATUS = @RegistStatus
)A 
WHERE A.[DATE] BETWEEN @StartDate AND @EndDate
GROUP BY BS_YEAR, MONTHLY, A.[DATE]
";

                    return con.Query<GroupCompany>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        /// <summary>
        /// 당월 실적을 가져온다.
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        public IEnumerable<GroupCompany> selectListPmThisYear(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"SELECT	A.BS_YEAR
		                                    , A.ORG_COMPANY_SEQ
		                                    , A.MONTHLY
		                                    , ISNULL(B.ASSETS, 0.00)						AS ASSETS
		                                    , ISNULL(B.LIABILITIES, 0.00)					AS LIABILITIES
		                                    , ISNULL(B.CAPITAL, 0.00)						AS CAPITAL
		                                    , ISNULL(B.CASH, 0.00)							AS CASH
		                                    , ISNULL(B.LOAN, 0.00)							AS LOAN
		                                    , ISNULL(B.LIABILITIES_RATE, 0.00)				AS LIABILITIES_RATE		-- 월실적에서 부채비율은 계산 : 프로그램에서 계산
		                                    , ISNULL(B.AFTER_TAX_OPERATION_PROFIT, 0.00)	AS AFTER_TAX_OPERATION_PROFIT
		                                    , ISNULL(B.PAIN_IN_CAPITAL, 0.00)				AS PAIN_IN_CAPITAL
		                                    , ISNULL(B.ROIC, 0.00)							AS ROIC					-- 월실적에서 계산\ : 프로그램에서 계산
		                                    , ISNULL(B.AR, 0.00)							AS AR
		                                    , ISNULL(B.AR_TO_DAYS, 0.00)					AS AR_TO_DAYS
		                                    , ISNULL(B.AP, 0.00)							AS AP
		                                    , ISNULL(B.AP_TO_DAYS, 0.00)					AS AP_TO_DAYS
		                                    , ISNULL(B.INVENTORY, 0.00)						AS INVENTORY
		                                    , ISNULL(B.INVENTORY_TO_DAYS, 0.00)				AS INVENTORY_TO_DAYS
		                                    , C.COMPANY_NAME
		                                    , D.UNION_NAME
		                                    , C.SEQ											AS ORG_COMPANY_SEQ
		                                    , D.SEQ											AS ORG_UNION_SEQ
                                    FROM	PM_BS											A
                                    LEFT OUTER JOIN PM_BS_SUMMARY								B ON A.SEQ = B.PM_BS_SEQ
                                    LEFT OUTER JOIN ORG_COMPANY								C ON A.ORG_COMPANY_SEQ = C.SEQ
                                    LEFT OUTER JOIN ORG_UNION								D ON C.ORG_UNION_SEQ = D.SEQ
                                    WHERE	1 = 1
                                    AND		A.BS_YEAR = @year
                                    AND		A.MONTHLY = @mm
                                    AND		A.ORG_COMPANY_SEQ = @OrgCompanySeq
                                    AND     A.REGIST_STATUS = " + Define.REGIST_STATUS.GetKey("최종승인") + @"
";

                    return con.Query<GroupCompany>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<GroupCompany> selectListPmThisYearEx(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"SELECT	A.BS_YEAR
		                                    , A.ORG_COMPANY_SEQ
		                                    , A.MONTHLY
		                                    , ISNULL(B.ASSETS, 0.00)						AS ASSETS
		                                    , ISNULL(B.LIABILITIES, 0.00)					AS LIABILITIES
		                                    , ISNULL(B.CAPITAL, 0.00)						AS CAPITAL
		                                    , ISNULL(B.CASH, 0.00)							AS CASH
		                                    , ISNULL(B.LOAN, 0.00)							AS LOAN
		                                    , ISNULL(B.LIABILITIES_RATE, 0.00)				AS LIABILITIES_RATE		-- 월실적에서 부채비율은 계산 : 프로그램에서 계산
		                                    , ISNULL(B.AFTER_TAX_OPERATION_PROFIT, 0.00)	AS AFTER_TAX_OPERATION_PROFIT
		                                    , ISNULL(B.PAIN_IN_CAPITAL, 0.00)				AS PAIN_IN_CAPITAL
		                                    , ISNULL(B.ROIC, 0.00)							AS ROIC					-- 월실적에서 계산\ : 프로그램에서 계산
		                                    , ISNULL(B.AR, 0.00)							AS AR
		                                    , ISNULL(B.AR_TO_DAYS, 0.00)					AS AR_TO_DAYS
		                                    , ISNULL(B.AP, 0.00)							AS AP
		                                    , ISNULL(B.AP_TO_DAYS, 0.00)					AS AP_TO_DAYS
		                                    , ISNULL(B.INVENTORY, 0.00)						AS INVENTORY
		                                    , ISNULL(B.INVENTORY_TO_DAYS, 0.00)				AS INVENTORY_TO_DAYS
		                                    , C.COMPANY_NAME
		                                    , D.UNION_NAME
		                                    , C.SEQ											AS ORG_COMPANY_SEQ
		                                    , D.SEQ											AS ORG_UNION_SEQ
                                    FROM	PM_BS_EX										A
                                    LEFT OUTER JOIN PM_BS_SUMMARY_EX						B ON A.SEQ = B.PM_BS_SEQ
                                    LEFT OUTER JOIN ORG_COMPANY								C ON A.ORG_COMPANY_SEQ = C.SEQ
                                    LEFT OUTER JOIN ORG_UNION								D ON C.ORG_UNION_SEQ = D.SEQ
                                    WHERE	1 = 1
                                    AND		A.BS_YEAR = @year
                                    AND		A.MONTHLY = @mm
                                    AND		A.ORG_COMPANY_SEQ = @OrgCompanySeq
                                    AND     A.REGIST_STATUS = " + Define.REGIST_STATUS.GetKey("최종승인") + @"
";

                    return con.Query<GroupCompany>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        /// <summary>
        /// 전년도 12월 실적을 가져온다.
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        public IEnumerable<GroupCompany> selectListPmLastYear(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"SELECT	A.BS_YEAR
		                                    , A.ORG_COMPANY_SEQ
		                                    , A.MONTHLY
		                                    , ISNULL(B.ASSETS, 0.00)						AS ASSETS
		                                    , ISNULL(B.LIABILITIES, 0.00)					AS LIABILITIES
		                                    , ISNULL(B.CAPITAL, 0.00)						AS CAPITAL
		                                    , ISNULL(B.CASH, 0.00)							AS CASH
		                                    , ISNULL(B.LOAN, 0.00)							AS LOAN
		                                    , ISNULL(B.LIABILITIES_RATE, 0.00)				AS LIABILITIES_RATE		-- 월실적에서 부채비율은 계산 : 프로그램에서 계산
		                                    , ISNULL(B.AFTER_TAX_OPERATION_PROFIT, 0.00)	AS AFTER_TAX_OPERATION_PROFIT
		                                    , ISNULL(B.PAIN_IN_CAPITAL, 0.00)				AS PAIN_IN_CAPITAL
		                                    , ISNULL(B.ROIC, 0.00)							AS ROIC					-- 월실적에서 계산 : 프로그램에서 계산
		                                    , ISNULL(B.AR, 0.00)							AS AR
		                                    , ISNULL(B.AR_TO_DAYS, 0.00)					AS AR_TO_DAYS
		                                    , ISNULL(B.AP, 0.00)							AS AP
		                                    , ISNULL(B.AP_TO_DAYS, 0.00)					AS AP_TO_DAYS
		                                    , ISNULL(B.INVENTORY, 0.00)						AS INVENTORY
		                                    , ISNULL(B.INVENTORY_TO_DAYS, 0.00)				AS INVENTORY_TO_DAYS
                                    FROM	PM_BS											A
                                    LEFT OUTER JOIN PM_BS_SUMMARY								B ON A.SEQ = B.PM_BS_SEQ
                                    WHERE	1 = 1
                                    AND		A.BS_YEAR = @year - 1
                                    AND		A.MONTHLY = '12'
                                    AND		A.ORG_COMPANY_SEQ = @OrgCompanySeq
                                    AND     A.REGIST_STATUS = " + Define.REGIST_STATUS.GetKey("최종승인") + @"
                                    ";

                    return con.Query<GroupCompany>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<GroupCompany> selectListPmLastYearEx(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"SELECT	A.BS_YEAR
		                                    , A.ORG_COMPANY_SEQ
		                                    , A.MONTHLY
		                                    , ISNULL(B.ASSETS, 0.00)						AS ASSETS
		                                    , ISNULL(B.LIABILITIES, 0.00)					AS LIABILITIES
		                                    , ISNULL(B.CAPITAL, 0.00)						AS CAPITAL
		                                    , ISNULL(B.CASH, 0.00)							AS CASH
		                                    , ISNULL(B.LOAN, 0.00)							AS LOAN
		                                    , ISNULL(B.LIABILITIES_RATE, 0.00)				AS LIABILITIES_RATE		-- 월실적에서 부채비율은 계산 : 프로그램에서 계산
		                                    , ISNULL(B.AFTER_TAX_OPERATION_PROFIT, 0.00)	AS AFTER_TAX_OPERATION_PROFIT
		                                    , ISNULL(B.PAIN_IN_CAPITAL, 0.00)				AS PAIN_IN_CAPITAL
		                                    , ISNULL(B.ROIC, 0.00)							AS ROIC					-- 월실적에서 계산 : 프로그램에서 계산
		                                    , ISNULL(B.AR, 0.00)							AS AR
		                                    , ISNULL(B.AR_TO_DAYS, 0.00)					AS AR_TO_DAYS
		                                    , ISNULL(B.AP, 0.00)							AS AP
		                                    , ISNULL(B.AP_TO_DAYS, 0.00)					AS AP_TO_DAYS
		                                    , ISNULL(B.INVENTORY, 0.00)						AS INVENTORY
		                                    , ISNULL(B.INVENTORY_TO_DAYS, 0.00)				AS INVENTORY_TO_DAYS
                                    FROM	PM_BS_EX											A
                                    LEFT OUTER JOIN PM_BS_SUMMARY_EX							B ON A.SEQ = B.PM_BS_SEQ
                                    WHERE	1 = 1
                                    AND		A.BS_YEAR = @year - 1
                                    AND		A.MONTHLY = '12'
                                    AND		A.ORG_COMPANY_SEQ = @OrgCompanySeq
                                    AND     A.REGIST_STATUS = " + Define.REGIST_STATUS.GetKey("최종승인") + @"
                                    ";

                    return con.Query<GroupCompany>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        /// <summary>
        /// 당해년도 계획을 가져온다.
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        public IEnumerable<GroupCompany> selectListPnThisYear(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"SELECT	A.YEAR_BS_YEAR									AS BS_YEAR
	                                        , A.ORG_COMPANY_SEQ
	                                        , B.MONTHLY
	                                        , ISNULL(B.ASSETS, 0.00)						AS ASSETS
	                                        , ISNULL(B.LIABILITIES, 0.00)					AS LIABILITIES
	                                        , ISNULL(B.CAPITAL, 0.00)						AS CAPITAL
	                                        , ISNULL(B.CASH, 0.00)							AS CASH
	                                        , ISNULL(B.LOAN, 0.00)							AS LOAN
	                                        , ISNULL(B.LIABILITIES_RATE, 0.00)				AS LIABILITIES_RATE		-- 월계획에서 부채비율은 계산 : 프로그램에서 계산
	                                        , ISNULL(C.AFTER_TAX_OPERATION_PROFIT, 0.00)	AS AFTER_TAX_OPERATION_PROFIT
	                                        , ISNULL(C.PAIN_IN_CAPITAL, 0.00)				AS PAIN_IN_CAPITAL
	                                        , ISNULL(C.ROIC, 0.00)							AS ROIC					-- 월계획에서 계산 : 프로그램에서 계산
	                                        --, ISNULL(D.ANNUAL_SALES, 0.00)					AS ANNUAL_SALES
	                                        --, ISNULL(D.ANNUAL_SALES_COST, 0.00)				AS ANNUAL_SALES_COST
	                                        , ISNULL(E.AR, 0.00)							AS AR
	                                        , CASE WHEN ISNULL(D.ANNUAL_SALES, 0.00) = 0 THEN 0.00 
		                                        ELSE (ISNULL(E.AR, 0.00) / ISNULL(D.ANNUAL_SALES, 0.00)) * 365 END AS AR_TO_DAYS
	                                        , ISNULL(E.AP, 0.00)							AS AP
	                                        , CASE WHEN ISNULL(D.ANNUAL_SALES_COST, 0.00) = 0 THEN 0.00 
		                                        ELSE (ISNULL(E.AP, 0.00) / ISNULL(D.ANNUAL_SALES_COST, 0.00)) * 365 END AS AP_TO_DAYS
	                                        , ISNULL(E.INVENTORY, 0.00)						AS INVENTORY
	                                        , CASE WHEN ISNULL(D.INVENTORY_COST, 0.00) = 0 THEN 0.00 
		                                        ELSE (ISNULL(E.INVENTORY, 0.00) / ISNULL(D.INVENTORY_COST, 0.00)) * 365 END AS INVENTORY_TO_DAYS
                                        FROM	PLAN_YEAR_BS									A
                                        LEFT OUTER JOIN PLAN_YEAR_BS_BSHEET							B ON A.SEQ = B.PLAN_YEAR_BS_SEQ	AND A.YEAR_BS_YEAR = B.YEARLY_YEAR
                                        LEFT OUTER JOIN PLAN_YEAR_BS_ROIC							C ON A.SEQ = C.PLAN_YEAR_BS_SEQ AND A.YEAR_BS_YEAR = C.YEARLY_YEAR AND B.MONTHLY = C.MONTHLY
                                        LEFT OUTER JOIN PLAN_YEAR_BS_W_CAPITAL						D ON A.SEQ = D.PLAN_YEAR_BS_SEQ AND A.YEAR_BS_YEAR = D.YEARLY_YEAR AND B.MONTHLY = D.MONTHLY
                                        LEFT OUTER JOIN PLAN_YEAR_BS_W_CAPITAL_REG					E ON A.SEQ = E.PLAN_YEAR_BS_SEQ AND A.YEAR_BS_YEAR = E.YEARLY_YEAR AND D.MONTHLY = E.MONTHLY

                                        WHERE	1 = 1
                                        AND		A.YEAR_BS_YEAR = @year
                                        AND		B.MONTHLY = @mm
                                        AND		A.ORG_COMPANY_SEQ = @OrgCompanySeq
                                        AND     A.REGIST_STATUS = " + Define.REGIST_STATUS.GetKey("최종승인") + @"
";

//                    string query = @"SELECT	A.YEAR_BS_YEAR									AS BS_YEAR
//	                                        , A.ORG_COMPANY_SEQ
//	                                        , B.MONTHLY
//	                                        , ISNULL(B.ASSETS, 0.00)						AS ASSETS
//	                                        , ISNULL(B.LIABILITIES, 0.00)					AS LIABILITIES
//	                                        , ISNULL(B.CAPITAL, 0.00)						AS CAPITAL
//	                                        , ISNULL(B.CASH, 0.00)							AS CASH
//	                                        , ISNULL(B.LOAN, 0.00)							AS LOAN
//	                                        , ISNULL(B.LIABILITIES_RATE, 0.00)				AS LIABILITIES_RATE		-- 월계획에서 부채비율은 계산 : 프로그램에서 계산
//	                                        , ISNULL(C.AFTER_TAX_OPERATION_PROFIT, 0.00)	AS AFTER_TAX_OPERATION_PROFIT
//	                                        , ISNULL(C.PAIN_IN_CAPITAL, 0.00)				AS PAIN_IN_CAPITAL
//	                                        , ISNULL(C.ROIC, 0.00)							AS ROIC					-- 월계획에서 계산 : 프로그램에서 계산
//	                                        --, ISNULL(D.ANNUAL_SALES, 0.00)					AS ANNUAL_SALES
//	                                        --, ISNULL(D.ANNUAL_SALES_COST, 0.00)				AS ANNUAL_SALES_COST
//	                                        , ISNULL(E.AR, 0.00)							AS AR
//	                                        , CASE WHEN ISNULL(D.ANNUAL_SALES, 0.00) = 0 THEN 0.00 
//		                                        ELSE (ISNULL(E.AR, 0.00) / ISNULL(D.ANNUAL_SALES, 0.00)) * 365 END AS AR_TO_DAYS
//	                                        , ISNULL(E.AP, 0.00)							AS AP
//	                                        , CASE WHEN ISNULL(D.ANNUAL_SALES_COST, 0.00) = 0 THEN 0.00 
//		                                        ELSE (ISNULL(E.AP, 0.00) / ISNULL(D.ANNUAL_SALES_COST, 0.00)) * 365 END AS AP_TO_DAYS
//	                                        , ISNULL(E.INVENTORY, 0.00)						AS INVENTORY
//	                                        , CASE WHEN ISNULL(D.INVENTORY_COST, 0.00) = 0 THEN 0.00 
//		                                        ELSE (ISNULL(E.INVENTORY, 0.00) / ISNULL(D.INVENTORY_COST, 0.00)) * 365 END AS INVENTORY_TO_DAYS
//                                        FROM	PLAN_YEAR_BS									A
//                                        LEFT OUTER JOIN PLAN_YEAR_BS_BSHEET							B ON A.SEQ = B.PLAN_YEAR_BS_SEQ	AND A.YEAR_BS_YEAR = B.YEARLY_YEAR
//                                        LEFT OUTER JOIN PLAN_YEAR_BS_ROIC							C ON A.SEQ = C.PLAN_YEAR_BS_SEQ AND A.YEAR_BS_YEAR = C.YEARLY_YEAR AND B.MONTHLY = C.MONTHLY
//                                        LEFT OUTER JOIN PLAN_YEAR_BS_W_CAPITAL						D ON A.SEQ = D.PLAN_YEAR_BS_SEQ AND A.YEAR_BS_YEAR = D.YEARLY_YEAR
//                                        LEFT OUTER JOIN PLAN_YEAR_BS_W_CAPITAL_REG					E ON A.SEQ = E.PLAN_YEAR_BS_SEQ AND A.YEAR_BS_YEAR = E.YEARLY_YEAR AND B.MONTHLY = E.MONTHLY

//                                        WHERE	1 = 1
//                                        AND		A.YEAR_BS_YEAR = @year
//                                        AND		B.MONTHLY = @mm
//                                        AND		A.ORG_COMPANY_SEQ = @OrgCompanySeq
//                                        AND     A.REGIST_STATUS = " + Define.REGIST_STATUS.GetKey("최종승인") + @"
//";

                    return con.Query<GroupCompany>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<GroupCompany> selectListPnThisYearEx(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"SELECT	A.YEAR_BS_YEAR									AS BS_YEAR
	                                        , A.ORG_COMPANY_SEQ
	                                        , B.MONTHLY
	                                        , ISNULL(B.ASSETS, 0.00)						AS ASSETS
	                                        , ISNULL(B.LIABILITIES, 0.00)					AS LIABILITIES
	                                        , ISNULL(B.CAPITAL, 0.00)						AS CAPITAL
	                                        , ISNULL(B.CASH, 0.00)							AS CASH
	                                        , ISNULL(B.LOAN, 0.00)							AS LOAN
	                                        , ISNULL(B.LIABILITIES_RATE, 0.00)				AS LIABILITIES_RATE		-- 월계획에서 부채비율은 계산 : 프로그램에서 계산
	                                        , ISNULL(C.AFTER_TAX_OPERATION_PROFIT, 0.00)	AS AFTER_TAX_OPERATION_PROFIT
	                                        , ISNULL(C.PAIN_IN_CAPITAL, 0.00)				AS PAIN_IN_CAPITAL
	                                        , ISNULL(C.ROIC, 0.00)							AS ROIC					-- 월계획에서 계산 : 프로그램에서 계산
	                                        --, ISNULL(D.ANNUAL_SALES, 0.00)					AS ANNUAL_SALES
	                                        --, ISNULL(D.ANNUAL_SALES_COST, 0.00)				AS ANNUAL_SALES_COST
	                                        , ISNULL(E.AR, 0.00)							AS AR
	                                        , CASE WHEN ISNULL(D.ANNUAL_SALES, 0.00) = 0 THEN 0.00 
		                                        ELSE (ISNULL(E.AR, 0.00) / ISNULL(D.ANNUAL_SALES, 0.00)) * 365 END AS AR_TO_DAYS
	                                        , ISNULL(E.AP, 0.00)							AS AP
	                                        , CASE WHEN ISNULL(D.ANNUAL_SALES_COST, 0.00) = 0 THEN 0.00 
		                                        ELSE (ISNULL(E.AP, 0.00) / ISNULL(D.ANNUAL_SALES_COST, 0.00)) * 365 END AS AP_TO_DAYS
	                                        , ISNULL(E.INVENTORY, 0.00)						AS INVENTORY
	                                        , CASE WHEN ISNULL(D.INVENTORY_COST, 0.00) = 0 THEN 0.00 
		                                        ELSE (ISNULL(E.INVENTORY, 0.00) / ISNULL(D.INVENTORY_COST, 0.00)) * 365 END AS INVENTORY_TO_DAYS
                                        FROM	PLAN_YEAR_BS_EX									A
                                        LEFT OUTER JOIN PLAN_YEAR_BS_BSHEET_EX							B ON A.SEQ = B.PLAN_YEAR_BS_SEQ	AND A.YEAR_BS_YEAR = B.YEARLY_YEAR
                                        LEFT OUTER JOIN PLAN_YEAR_BS_ROIC_EX							C ON A.SEQ = C.PLAN_YEAR_BS_SEQ AND A.YEAR_BS_YEAR = C.YEARLY_YEAR AND B.MONTHLY = C.MONTHLY
                                        LEFT OUTER JOIN PLAN_YEAR_BS_W_CAPITAL_EX						D ON A.SEQ = D.PLAN_YEAR_BS_SEQ AND A.YEAR_BS_YEAR = D.YEARLY_YEAR AND B.MONTHLY = D.MONTHLY
                                        LEFT OUTER JOIN PLAN_YEAR_BS_W_CAPITAL_REG_EX					E ON A.SEQ = E.PLAN_YEAR_BS_SEQ AND A.YEAR_BS_YEAR = E.YEARLY_YEAR AND D.MONTHLY = E.MONTHLY

                                        WHERE	1 = 1
                                        AND		A.YEAR_BS_YEAR = @year
                                        AND		B.MONTHLY = @mm
                                        AND		A.ORG_COMPANY_SEQ = @OrgCompanySeq
                                        AND     A.REGIST_STATUS = " + Define.REGIST_STATUS.GetKey("최종승인") + @"
";

                    return con.Query<GroupCompany>(query, param).ToList();
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
        public GroupCompany investPlanPieChart(object param)
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
AND A.ORG_COMPANY_SEQ = @Seq
AND A.MONTHLY_INVEST_YEAR = @Yearly
AND B.MONTHLY <= @Monthly
AND A.REGIST_STATUS = @RegistStatus";

                    return con.Query<GroupCompany>(query, param).FirstOrDefault();
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
        public GroupCompany investResultPieChart(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" 
SELECT INVESTMENT       AS resultInvest
FROM PM_INVEST A
LEFT OUTER JOIN PM_INVEST_SUM B ON A.SEQ = B.PM_INVEST_SEQ
WHERE 1 = 1
AND A.ORG_COMPANY_SEQ = @Seq
AND B.MONTHLY_TYPE = @MonthlyType
AND A.INVEST_YEAR = @Yearly
AND A.MONTHLY = @Monthly
AND A.REGIST_STATUS = @RegistStatus";

                    return con.Query<GroupCompany>(query, param).FirstOrDefault();
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
        public GroupCompany investYearPlanPieChart(object param)
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
AND A.ORG_COMPANY_SEQ = @Seq
AND A.REGIST_STATUS = @RegistStatus
";

                    return con.Query<GroupCompany>(query, param).FirstOrDefault();
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
        public GroupCompany investYearResultPieChart(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" 
SELECT INVESTMENT   AS resultInvest
FROM PM_INVEST A
LEFT OUTER JOIN PM_INVEST_SUM B ON A.SEQ = B.PM_INVEST_SEQ
WHERE 1 = 1
AND B.MONTHLY_TYPE = @MonthlyType
AND A.INVEST_YEAR = @Yearly
AND A.MONTHLY = @Monthly
AND A.ORG_COMPANY_SEQ = @Seq
AND A.REGIST_STATUS = @RegistStatus";

                    return con.Query<GroupCompany>(query, param).FirstOrDefault();
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
        public IEnumerable<GroupCompany> personnelResultChart(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    // 2019.03.06 여기도 밀려서 수정
                    string query = @" 
SELECT  C.SCHEDULE_YEAR								AS INVEST_YEAR
	   , C.REG_MONTH								AS MONTHLY
       ,ISNULL(PERSONNEL, 0)		AS PERSONNEL
       , C.SCHEDULE_YEAR + C.REG_MONTH				AS [DATE]
  FROM  PLAN_SCHEDULE_PERFORMANCE_REG		C
  LEFT OUTER JOIN 
  (
		SELECT INVEST_YEAR
			   ,MONTHLY
               ,PERSONNEL
		       ,A.INVEST_YEAR + MONTHLY AS [DATE]
        FROM PM_INVEST A
		LEFT OUTER JOIN PM_INVEST_SUM B ON A.SEQ = B.PM_INVEST_SEQ
		WHERE 1 = 1
        AND A.ORG_COMPANY_SEQ = @Seq
		AND B.MONTHLY_TYPE = @MonthlyType
        AND A.REGIST_STATUS = @RegistStatus
    ) A ON C.SCHEDULE_YEAR = A.INVEST_YEAR AND C.REG_MONTH = A.MONTHLY
    WHERE C.SCHEDULE_YEAR + C.REG_MONTH BETWEEN @StartDate AND @EndDate
    ORDER BY C.SCHEDULE_YEAR + C.REG_MONTH

/*
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
        AND A.ORG_COMPANY_SEQ = @Seq
		AND B.MONTHLY_TYPE = @MonthlyType
        AND A.REGIST_STATUS = @RegistStatus
    )A
    WHERE A.[DATE] BETWEEN @StartDate AND @EndDate
    GROUP BY A.[DATE], INVEST_YEAR, MONTHLY
*/";

                    return con.Query<GroupCompany>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        #endregion


        public int insert(GroupCompany entity)
        {
            throw new NotImplementedException();
        }

        public int update(GroupCompany entity)
        {
            throw new NotImplementedException();
        }

        public int delete(object param)
        {
            throw new NotImplementedException();
        }

        public int save(GroupCompany entity)
        {
            throw new NotImplementedException();
        }

        public void Dispose()
        {
            throw new NotImplementedException();
        }
    }
}