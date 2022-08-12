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
    public class TrendPalRepo : DbCon, ITrendPalRepo
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

        public int insert(TrendPal entity)
        {
            throw new NotImplementedException();
        }

        public int save(TrendPal entity)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<TrendPal> selectList(object param)
        {
            throw new NotImplementedException();
        }

        public TrendPal selectOne(object param)
        {
            throw new NotImplementedException();
        }

        public int update(TrendPal entity)
        {
            throw new NotImplementedException();
        }

        /// <summary>
        /// 회사레벨까지의 기본데이터
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        public IEnumerable<TrendPal> GetPalUnionCompany(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    // ISNULL(B.MONTHLY_TYPE, 20)  이 값을 체크한 이유는 현재 없는 데이터가 있어서 없을 경우도 확인용으로
                    string query = @"
                                        SELECT	*
                                        FROM	
                                        (
                                        SELECT	A.PAL_YEAR
		                                        , A.MONTHLY
		                                        , DATEPART(QUARTER, A.PAL_YEAR + '-' + A.MONTHLY + '-01') AS QT
		                                        , ROW_NUMBER() OVER (PARTITION BY A.PAL_YEAR, A.ORG_COMPANY_SEQ ORDER BY A.PAL_YEAR, A.MONTHLY DESC, B.MONTHLY_TYPE DESC) AS NO_Z
		                                        , ISNULL(B.MONTHLY_TYPE, 20)			AS MONTHLY_TYPE
		                                        , ISNULL(B.SALES, 0.00)					AS SALES
		                                        , ISNULL(B.EBIT, 0.00)					AS EBIT
		                                        , ISNULL(B.PBT, 0.00)					AS PBT
		                                        , A.ORG_COMPANY_SEQ
		                                        , G.COMPANY_NAME
		                                        , G.ORG_UNION_SEQ
		                                        , H.UNION_NAME
                                        FROM	PM_PAL									A
                                        LEFT OUTER JOIN PM_PAL_SUMMARY					B ON A.SEQ = B.PM_PAL_SEQ
                                        LEFT OUTER JOIN ORG_COMPANY					G ON A.ORG_COMPANY_SEQ = G.SEQ
                                        LEFT OUTER JOIN ORG_UNION					H ON G.ORG_UNION_SEQ = H.SEQ
                                        WHERE	1 = 1
                                        AND		A.REGIST_STATUS = " + Define.REGIST_STATUS.GetKey("최종승인") + @"
                                        AND		ISNULL(B.MONTHLY_TYPE, 20) != " + Define.MONTHLY_TYPE.GetKey("연간") + @"
                                        ) A

";

                    return con.Query<TrendPal>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.ReportErrorLog(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<TrendPal> GetPalUnionCompany_NEW(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    // ISNULL(B.MONTHLY_TYPE, 20)  이 값을 체크한 이유는 현재 없는 데이터가 있어서 없을 경우도 확인용으로
                    string query = @"     SELECT	A.PAL_YEAR
		                                    ,SUM(SALES) AS SALES
		                                    ,SUM(EBIT) AS EBIT
		                                    ,SUM(PBT) AS PBT
                                          FROM	
                                         (  SELECT	A.PAL_YEAR
		                                                , A.MONTHLY
		                                                , DATEPART(QUARTER, A.PAL_YEAR + '-' + A.MONTHLY + '-01') AS QT
		                                                , ROW_NUMBER() OVER (PARTITION BY A.PAL_YEAR, A.ORG_COMPANY_SEQ ORDER BY A.PAL_YEAR, A.MONTHLY DESC, B.MONTHLY_TYPE DESC) AS NO_Z
		                                                , ISNULL(B.MONTHLY_TYPE, 20)			AS MONTHLY_TYPE
		                                                , ISNULL(B.SALES, 0.00)					AS SALES
		                                                , ISNULL(B.EBIT, 0.00)					AS EBIT
		                                                , ISNULL(B.PBT, 0.00)					AS PBT
		                                                , A.ORG_COMPANY_SEQ
		                                                , G.COMPANY_NAME
		                                                , G.ORG_UNION_SEQ
		                                                , H.UNION_NAME
                                                FROM	PM_PAL									A
                                                INNER JOIN PM_PAL_SUMMARY					B ON A.SEQ = B.PM_PAL_SEQ AND A.PAL_YEAR <= '2018'
                                                LEFT OUTER JOIN ORG_COMPANY					G ON A.ORG_COMPANY_SEQ = G.SEQ
                                                LEFT OUTER JOIN ORG_UNION					H ON G.ORG_UNION_SEQ = H.SEQ
                                                WHERE	1 = 1
                                                AND		A.REGIST_STATUS =  " + Define.REGIST_STATUS.GetKey("최종승인") + @"
	                                            AND 	(A. PAL_YEAR  >=  @PREYEAR  AND A. PAL_YEAR  <=  @ENDYEAR  )  
	                                            AND     A.MONTHLY =(SELECT MAX(MONTHLY) FROM PM_PAL WHERE PAL_YEAR  = A.PAL_YEAR  AND REGIST_STATUS =  " + Define.REGIST_STATUS.GetKey("최종승인") + @")
                                                AND		ISNULL(B.MONTHLY_TYPE, 20) = " + Define.MONTHLY_TYPE.GetKey("누계") + @"
                                                ) A
	                                    GROUP BY  PAL_YEAR 
                                     UNION ALL
	                                    SELECT GROUPDATA_YEAR AS PAL_YEAR
		                                        , SALES
		                                        , EBIT
		                                        ,PBT
		                                        FROM PM_GROUPDATA_PAL_MONTHLY A WITH(NOLOCK)
		                                        WHERE  
				                                        (GROUPDATA_YEAR >=  '2019' AND GROUPDATA_YEAR <= @ENDYEAR ) 
                                                        AND GROUPDATA_MONTH = (SELECT MAX(GROUPDATA_MONTH) FROM PM_GROUPDATA_PAL_MONTHLY   WITH(NOLOCK) 
                                                                                                            WHERE  GROUPDATA_YEAR = A.GROUPDATA_YEAR )
			                                        AND	MONTHLY_TYPE =  " + Define.MONTHLY_TYPE.GetKey("누계") + @"
	                                    ORDER BY PAL_YEAR 

                                    ";

                    return con.Query<TrendPal>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.ReportErrorLog(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<TrendPal> GetPalUnionCompany_NEW_Quater(object param, string strQuater)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    // ISNULL(B.MONTHLY_TYPE, 20)  이 값을 체크한 이유는 현재 없는 데이터가 있어서 없을 경우도 확인용으로
                    string query = @"   SELECT	 PAL_YEAR
		                                        , QT
		                                        ,SUM(SALES) AS SALES
		                                        ,SUM(EBIT) AS EBIT
		                                        ,SUM(PBT) AS PBT
                                            FROM	
		                                        (  SELECT	A.PAL_YEAR
				                                        , DATEPART(QUARTER, A.PAL_YEAR + '-' + A.MONTHLY + '-01') AS QT 
				                                        , ISNULL(B.SALES, 0.00)					AS SALES
				                                        , ISNULL(B.EBIT, 0.00)					AS EBIT
				                                        , ISNULL(B.PBT, 0.00)					AS PBT 
		                                            FROM	PM_PAL									A
		                                            INNER JOIN PM_PAL_SUMMARY					B ON A.SEQ = B.PM_PAL_SEQ AND A.PAL_YEAR <= '2018'
		                                            LEFT OUTER JOIN ORG_COMPANY					G ON A.ORG_COMPANY_SEQ = G.SEQ
		                                            LEFT OUTER JOIN ORG_UNION					H ON G.ORG_UNION_SEQ = H.SEQ
		                                            WHERE	1 = 1 
		                                            AND (A.PAL_YEAR  >=  @quater_y_from AND A.PAL_YEAR  <=  @quater_y_to )
												    AND MONTHLY_TYPE = '" + Define.MONTHLY_TYPE.GetKey("당월") + @"'
												    AND A.REGIST_STATUS =  " + Define.REGIST_STATUS.GetKey("최종승인") + @"
	                                            UNION ALL
		                                            SELECT GROUPDATA_YEAR AS PAL_YEAR 
				                                                ,DATEPART(QUARTER, GROUPDATA_YEAR + '-' + GROUPDATA_MONTH + '-01') AS QT
				                                            ,SALES  
				                                            ,EBIT
				                                            ,PBT
		                                            FROM PM_GROUPDATA_PAL_MONTHLY A WITH(NOLOCK)
		                                            WHERE    (GROUPDATA_YEAR >=  '2019' AND GROUPDATA_YEAR <=  @quater_y_to )
			                                            AND	MONTHLY_TYPE = '" + Define.MONTHLY_TYPE.GetKey("당월") + @"' ) C
                                            WHERE  QT IN (" + strQuater + @")
                                            GROUP BY PAL_YEAR ,QT
                                            ORDER BY PAL_YEAR ,QT

                                    ";

                    return con.Query<TrendPal>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.ReportErrorLog(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<TrendPal> GetPalUnionCompany_NEW_Month(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    // ISNULL(B.MONTHLY_TYPE, 20)  이 값을 체크한 이유는 현재 없는 데이터가 있어서 없을 경우도 확인용으로
                    string query = @"   SELECT	 PAL_YEAR
		                                        , MONTHLY
		                                        ,SUM(SALES) AS SALES
		                                        ,SUM(EBIT) AS EBIT
		                                        ,SUM(PBT) AS PBT
                                            FROM	
		                                        (  SELECT	A.PAL_YEAR
				                                        , MONTHLY
				                                        , ISNULL(B.SALES, 0.00)					AS SALES
				                                        , ISNULL(B.EBIT, 0.00)					AS EBIT
				                                        , ISNULL(B.PBT, 0.00)					AS PBT 
		                                            FROM	PM_PAL									A
		                                            INNER JOIN PM_PAL_SUMMARY					B ON A.SEQ = B.PM_PAL_SEQ AND A.PAL_YEAR <= '2018'
		                                            LEFT OUTER JOIN ORG_COMPANY					G ON A.ORG_COMPANY_SEQ = G.SEQ
		                                            LEFT OUTER JOIN ORG_UNION					H ON G.ORG_UNION_SEQ = H.SEQ
		                                            WHERE	1 = 1 AND
		                                             (A.PAL_YEAR  +  A.MONTHLY >=  @PREYEAR 
                                                        AND   A.PAL_YEAR  +  A.MONTHLY <=  @ENDYEAR )
													                                        AND MONTHLY_TYPE = '" + Define.MONTHLY_TYPE.GetKey("당월") + @"'
													                                        AND A.REGIST_STATUS = " + Define.REGIST_STATUS.GetKey("최종승인") + @"
													                                        AND A.ORG_COMPANY_SEQ <> 13	
	                                            UNION ALL
		                                            SELECT GROUPDATA_YEAR AS PAL_YEAR 
                                                            ,GROUPDATA_MONTH AS MONTHLY  
				                                            ,SALES  
				                                            ,EBIT
				                                            ,PBT
		                                            FROM PM_GROUPDATA_PAL_MONTHLY A WITH(NOLOCK)
		                                            WHERE  
				                                       ( GROUPDATA_YEAR + GROUPDATA_MONTH >= '2019'  
                                                        AND   GROUPDATA_YEAR + GROUPDATA_MONTH <=  @ENDYEAR   )
			                                        AND	MONTHLY_TYPE = '" + Define.MONTHLY_TYPE.GetKey("당월") + @"' ) C
                                        GROUP BY  PAL_YEAR,MONTHLY
                                        ORDER BY  PAL_YEAR,MONTHLY

                                    ";

                    return con.Query<TrendPal>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.ReportErrorLog(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<TrendPal> GetPalUnionCompany_NEW_MonthChoice(object param, string strMonthly)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    // ISNULL(B.MONTHLY_TYPE, 20)  이 값을 체크한 이유는 현재 없는 데이터가 있어서 없을 경우도 확인용으로
                    string query = @"    SELECT	 PAL_YEAR
		                                        , MONTHLY
		                                        ,SUM(SALES) AS SALES
		                                        ,SUM(EBIT) AS EBIT
		                                        ,SUM(PBT) AS PBT
                                            FROM	
		                                        (  SELECT	A.PAL_YEAR
				                                        , MONTHLY
				                                        , ISNULL(B.SALES, 0.00)					AS SALES
				                                        , ISNULL(B.EBIT, 0.00)					AS EBIT
				                                        , ISNULL(B.PBT, 0.00)					AS PBT 
		                                            FROM	PM_PAL									A
		                                            INNER JOIN PM_PAL_SUMMARY					B ON A.SEQ = B.PM_PAL_SEQ AND A.PAL_YEAR <= '2018'
		                                            LEFT OUTER JOIN ORG_COMPANY					G ON A.ORG_COMPANY_SEQ = G.SEQ
		                                            LEFT OUTER JOIN ORG_UNION					H ON G.ORG_UNION_SEQ = H.SEQ
		                                            WHERE	1 = 1 AND
		                                             (A.PAL_YEAR   >=  @PREYEAR 
                                                        AND   A.PAL_YEAR   <=  @ENDYEAR )
													                                        AND MONTHLY_TYPE = '" + Define.MONTHLY_TYPE.GetKey("당월") + @"'
													                                        AND A.REGIST_STATUS = " + Define.REGIST_STATUS.GetKey("최종승인") + @"
													                                        AND A.ORG_COMPANY_SEQ <> 13	
	                                            UNION ALL
		                                            SELECT GROUPDATA_YEAR AS PAL_YEAR 
                                                            ,GROUPDATA_MONTH AS MONTHLY  
				                                            ,SALES  
				                                            ,EBIT
				                                            ,PBT
		                                            FROM PM_GROUPDATA_PAL_MONTHLY A WITH(NOLOCK)
		                                            WHERE  
				                                       ( GROUPDATA_YEAR   >= '2019'  
                                                        AND   GROUPDATA_YEAR   <=  @ENDYEAR   )
			                                        AND	MONTHLY_TYPE = '" + Define.MONTHLY_TYPE.GetKey("당월") + @"' ) C
										  WHERE  MONTHLY IN (" + strMonthly + @")
                                        GROUP BY  PAL_YEAR,MONTHLY
                                        ORDER BY  PAL_YEAR,MONTHLY
                                    ";

                    return con.Query<TrendPal>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.ReportErrorLog(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<TrendPal> GetPalBusiness(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
SELECT	*
FROM	
(
SELECT	A.PAL_YEAR
		, A.MONTHLY
		, DATEPART(QUARTER, A.PAL_YEAR + '-' + A.MONTHLY + '-01') AS QT
		, ROW_NUMBER() OVER (PARTITION BY A.PAL_YEAR, A.ORG_COMPANY_SEQ, B.ORG_BUSINESS_SEQ ORDER BY A.PAL_YEAR, A.MONTHLY DESC, B.MONTHLY_TYPE DESC) AS NO_Z
		, ISNULL(B.MONTHLY_TYPE, 20)			AS MONTHLY_TYPE
		, ISNULL(B.SALES, 0.00)					AS SALES
		, ISNULL(B.EBIT, 0.00)					AS EBIT
		, ISNULL(B.PBT, 0.00)					AS PBT
		, B.ORG_BUSINESS_SEQ
		, F.BUSINESS_NAME
		, A.ORG_COMPANY_SEQ
		, G.COMPANY_NAME
		, G.ORG_UNION_SEQ
		, H.UNION_NAME
FROM	PM_PAL									A
LEFT OUTER JOIN PM_PAL_BUSINESS					B ON A.SEQ = B.PM_PAL_SEQ
LEFT OUTER JOIN ORG_BUSINESS				F ON B.ORG_BUSINESS_SEQ = F.SEQ
LEFT OUTER JOIN ORG_COMPANY					G ON F.ORG_COMPANY_SEQ = G.SEQ
LEFT OUTER JOIN ORG_UNION					H ON G.ORG_UNION_SEQ = H.SEQ
WHERE	1 = 1
AND		A.REGIST_STATUS = " + Define.REGIST_STATUS.GetKey("최종승인") + @"
AND		ISNULL(B.MONTHLY_TYPE, 20) != " + Define.MONTHLY_TYPE.GetKey("연간") + @"
) A

";

                    return con.Query<TrendPal>(query, param).ToList();
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