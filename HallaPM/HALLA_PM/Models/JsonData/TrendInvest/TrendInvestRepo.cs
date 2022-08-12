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
    public class TrendInvestRepo : DbCon, ITrendInvestRepo
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

        public int insert(TrendInvest entity)
        {
            throw new NotImplementedException();
        }

        public int save(TrendInvest entity)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<TrendInvest> selectList(object param)
        {
            throw new NotImplementedException();
        }

        public TrendInvest selectOne(object param)
        {
            throw new NotImplementedException();
        }

        public int update(TrendInvest entity)
        {
            throw new NotImplementedException();
        }


        /// <summary>
        /// 회사레벨까지의 기본데이터
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        public IEnumerable<TrendInvest> GetInvestUnionCompany(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    // ISNULL(B.MONTHLY_TYPE, 20)  이 값을 체크한 이유는 현재 없는 데이터가 있어서 없을 경우도 확인용으로
                    string query = @"
SELECT	A.INVEST_YEAR
		, A.MONTHLY
		, DATEPART(QUARTER, A.INVEST_YEAR + '-' + A.MONTHLY + '-01') AS QT
		, ISNULL(B.MONTHLY_TYPE, 20)		AS MONTHLY_TYPE
		, ROW_NUMBER() OVER (PARTITION BY A.INVEST_YEAR, A.ORG_COMPANY_SEQ ORDER BY A.INVEST_YEAR, A.MONTHLY DESC, B.MONTHLY_TYPE DESC) AS NO_Z
		, ISNULL(B.INVESTMENT, 0.00)		AS INVESTMENT
		, ISNULL(B.PERSONNEL, 0.00)			AS PERSONNEL
		, ISNULL(B.DOMESTIC_PERSONNEL, 0.00) AS DOMESTIC_PERSONNEL
		, ISNULL(B.OVERSEAS_PERSONNEL, 0.00) AS OVERSEAS_PERSONNEL
		, A.ORG_COMPANY_SEQ
		, G.COMPANY_NAME
		, G.ORG_UNION_SEQ
		, H.UNION_NAME
FROM	PM_INVEST							A
LEFT OUTER JOIN PM_INVEST_SUM				B ON A.SEQ = B.PM_INVEST_SEQ
LEFT OUTER JOIN ORG_COMPANY					G ON A.ORG_COMPANY_SEQ = G.SEQ
LEFT OUTER JOIN ORG_UNION					H ON G.ORG_UNION_SEQ = H.SEQ
WHERE	1 = 1
AND		A.REGIST_STATUS = " + Define.REGIST_STATUS.GetKey("최종승인") + @"

";

                    return con.Query<TrendInvest>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.ReportErrorLog(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<TrendInvest> GetInvestUnionCompany_NEW(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    // ISNULL(B.MONTHLY_TYPE, 20)  이 값을 체크한 이유는 현재 없는 데이터가 있어서 없을 경우도 확인용으로
                    string query = @"
                            SELECT A.INVEST_YEAR,
		                        SUM(ISNULL(INVESTMENT,0)) INVESTMENT
		                        ,SUM(PERSONNEL) AS PERSONNEL
		                        ,SUM(ISNULL(DOMESTIC_PERSONNEL,0)) + SUM(ISNULL(OVERSEAS_PERSONNEL,0)) AS PERSONNEL2
		                        ,SUM(ISNULL(DOMESTIC_PERSONNEL,0)) DOMESTIC_PERSONNEL
		                        ,SUM(ISNULL(OVERSEAS_PERSONNEL,0)) OVERSEAS_PERSONNEL 
		                        FROM PM_INVEST A
	                        INNER  JOIN PM_INVEST_SUM B 
	                        ON A.SEQ = B.PM_INVEST_SEQ   AND A.INVEST_YEAR <= '2018'
		                        WHERE (A.INVEST_YEAR  >=  @year_y_from AND A.INVEST_YEAR  <=  @year_y_to ) AND A.MONTHLY =(SELECT MAX(MONTHLY) FROM PM_INVEST WHERE INVEST_YEAR  = A.INVEST_YEAR  AND REGIST_STATUS =  " + Define.REGIST_STATUS.GetKey("최종승인") + @")
													                        AND MONTHLY_TYPE = '" + Define.MONTHLY_TYPE.GetKey("누계") + @"'
													                        AND A.REGIST_STATUS = " + Define.REGIST_STATUS.GetKey("최종승인") + @"
                                                                            AND A.ORG_COMPANY_SEQ <> 13															
												                        GROUP BY A.INVEST_YEAR 
                    UNION ALL

	                    SELECT GROUPDATA_YEAR AS INVEST_YEAR
		                    , INVESTMENT  AS INVESTMENT
		                    , PERSONNEL 
		                    , DOMESTIC_PERSONNEL  +  OVERSEAS_PERSONNEL   AS PERSONNEL2
		                    ,  DOMESTIC_PERSONNEL 
		                    ,  OVERSEAS_PERSONNEL  	
		                    FROM PM_GROUPDATA_INVEST_MONTHLY A WITH(NOLOCK)
		                    WHERE  
				                    (GROUPDATA_YEAR >=  '2019' AND GROUPDATA_YEAR <=  @year_y_to ) AND GROUPDATA_MONTH = (SELECT MAX(GROUPDATA_MONTH) FROM PM_GROUPDATA_INVEST_MONTHLY   WITH(NOLOCK) WHERE  GROUPDATA_YEAR = A.GROUPDATA_YEAR )
			                    AND	MONTHLY_TYPE = '" + Define.MONTHLY_TYPE.GetKey("누계") + @"'
                            ";

                    return con.Query<TrendInvest>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.ReportErrorLog(e.ToString());
                    return null;
                }
            }
        }


        public IEnumerable<TrendInvest> GetInvestUnionCompany_NEW_Quater(object param,string strQuater)
        {
            using (IDbConnection con = GetHallaDb())
            {
                string query = "";
                try
                {
                    con.Open();

                    // ISNULL(B.MONTHLY_TYPE, 20)  이 값을 체크한 이유는 현재 없는 데이터가 있어서 없을 경우도 확인용으로
                     query = @"
                            SELECT   INVEST_YEAR 
		                            , QT
		                            ,SUM(ISNULL(INVESTMENT,0)) INVESTMENT
		                            ,SUM(PERSONNEL) AS PERSONNEL
		                            ,SUM(ISNULL(DOMESTIC_PERSONNEL,0)) + SUM(ISNULL(OVERSEAS_PERSONNEL,0)) AS PERSONNEL2
		                            ,SUM(ISNULL(DOMESTIC_PERSONNEL,0)) DOMESTIC_PERSONNEL
		                            ,SUM(ISNULL(OVERSEAS_PERSONNEL,0)) OVERSEAS_PERSONNEL  FROM (
	                            SELECT A.INVEST_YEAR  
		                            , A.MONTHLY
		                            , DATEPART(QUARTER, A.INVEST_YEAR + '-' + A.MONTHLY + '-01') AS QT
		                            ,SUM(ISNULL(INVESTMENT,0)) INVESTMENT
		                            ,SUM(PERSONNEL) AS PERSONNEL
		                            ,SUM(ISNULL(DOMESTIC_PERSONNEL,0)) + SUM(ISNULL(OVERSEAS_PERSONNEL,0)) AS PERSONNEL2
		                            ,SUM(ISNULL(DOMESTIC_PERSONNEL,0)) DOMESTIC_PERSONNEL
		                            ,SUM(ISNULL(OVERSEAS_PERSONNEL,0)) OVERSEAS_PERSONNEL 
		                            FROM PM_INVEST A
	                            INNER JOIN PM_INVEST_SUM B 
	                            ON A.SEQ = B.PM_INVEST_SEQ   AND A.INVEST_YEAR <= '2018'
		                            WHERE  (A.INVEST_YEAR  >=  @quater_y_from AND A.INVEST_YEAR  <=  @quater_y_to )
													                            AND MONTHLY_TYPE = '" + Define.MONTHLY_TYPE.GetKey("당월") + @"'
													                            AND A.REGIST_STATUS =  " + Define.REGIST_STATUS.GetKey("최종승인") + @"
													                            AND A.ORG_COMPANY_SEQ <> 13															
												                            GROUP BY A.INVEST_YEAR ,MONTHLY
                            UNION ALL
	                            SELECT GROUPDATA_YEAR AS INVEST_YEAR
		                            , GROUPDATA_MONTH AS MONTHLY
		                            , DATEPART(QUARTER, GROUPDATA_YEAR + '-' + GROUPDATA_MONTH + '-01') AS QT
		                            , INVESTMENT  AS INVESTMENT
		                            , PERSONNEL 
		                            , DOMESTIC_PERSONNEL  +  OVERSEAS_PERSONNEL   AS PERSONNEL2
		                            ,  DOMESTIC_PERSONNEL 
		                            ,  OVERSEAS_PERSONNEL  	
		                            FROM PM_GROUPDATA_INVEST_MONTHLY A WITH(NOLOCK)
		                            WHERE  
				                           (GROUPDATA_YEAR >= '2019' AND GROUPDATA_YEAR <=  @quater_y_to )
			                            AND	MONTHLY_TYPE = '" + Define.MONTHLY_TYPE.GetKey("당월") + @"' ) C
                            WHERE  QT IN (" + strQuater + @")
                            GROUP BY  INVEST_YEAR,QT
                            ORDER BY  INVEST_YEAR,QT
                            ";

                    return con.Query<TrendInvest>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.ReportErrorLog(e.ToString() + " " + query);
                    return null;
                }
            }
        }

        public IEnumerable<TrendInvest> GetInvestUnionCompany_NEW_Month(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                string query = "";
                try
                {
                    con.Open();

                    // ISNULL(B.MONTHLY_TYPE, 20)  이 값을 체크한 이유는 현재 없는 데이터가 있어서 없을 경우도 확인용으로
                    query = @" SELECT   INVEST_YEAR ,
                                     MONTHLY 
		                            ,SUM(ISNULL(INVESTMENT,0)) INVESTMENT
		                            ,SUM(PERSONNEL) AS PERSONNEL
		                            ,SUM(ISNULL(DOMESTIC_PERSONNEL,0)) + SUM(ISNULL(OVERSEAS_PERSONNEL,0)) AS PERSONNEL2
		                            ,SUM(ISNULL(DOMESTIC_PERSONNEL,0)) DOMESTIC_PERSONNEL
		                            ,SUM(ISNULL(OVERSEAS_PERSONNEL,0)) OVERSEAS_PERSONNEL  FROM (
	                            SELECT A.INVEST_YEAR  
		                            , A.MONTHLY	
		                            ,SUM(ISNULL(INVESTMENT,0)) INVESTMENT
		                            ,SUM(PERSONNEL) AS PERSONNEL
		                            ,SUM(ISNULL(DOMESTIC_PERSONNEL,0)) + SUM(ISNULL(OVERSEAS_PERSONNEL,0)) AS PERSONNEL2
		                            ,SUM(ISNULL(DOMESTIC_PERSONNEL,0)) DOMESTIC_PERSONNEL
		                            ,SUM(ISNULL(OVERSEAS_PERSONNEL,0)) OVERSEAS_PERSONNEL 
		                            FROM PM_INVEST A
	                            INNER JOIN PM_INVEST_SUM B 
	                            ON A.SEQ = B.PM_INVEST_SEQ   AND A.INVEST_YEAR <= '2018'
		                            WHERE 
                                             (A.INVEST_YEAR  +  A.MONTHLY >=  @PREYEAR 
                                            AND   A.INVEST_YEAR  +  A.MONTHLY <=  @ENDYEAR )
													                            AND MONTHLY_TYPE = '" + Define.MONTHLY_TYPE.GetKey("당월") + @"'
													                            AND A.REGIST_STATUS = " + Define.REGIST_STATUS.GetKey("최종승인") + @"
													                            AND A.ORG_COMPANY_SEQ <> 13															
												                            GROUP BY A.INVEST_YEAR ,MONTHLY
                            UNION ALL
	                            SELECT GROUPDATA_YEAR AS INVEST_YEAR
		                            , GROUPDATA_MONTH AS MONTHLY	 
		                            , INVESTMENT  AS INVESTMENT
		                            , PERSONNEL 
		                            , DOMESTIC_PERSONNEL  +  OVERSEAS_PERSONNEL   AS PERSONNEL2
		                            ,  DOMESTIC_PERSONNEL 
		                            ,  OVERSEAS_PERSONNEL  	
		                            FROM PM_GROUPDATA_INVEST_MONTHLY A WITH(NOLOCK)
		                            WHERE  
				                           ( GROUPDATA_YEAR + GROUPDATA_MONTH >= '2019'  
                                            AND   GROUPDATA_YEAR + GROUPDATA_MONTH <=  @ENDYEAR   )
			                            AND	MONTHLY_TYPE = '" + Define.MONTHLY_TYPE.GetKey("당월") + @"' ) C
                            GROUP BY  INVEST_YEAR,MONTHLY
                            ORDER BY  INVEST_YEAR,MONTHLY
                            ";

                    return con.Query<TrendInvest>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.ReportErrorLog(e.ToString() + " " + query);
                    return null;
                }
            }
        }

        public IEnumerable<TrendInvest> GetInvestUnionCompany_NEW_MonthChoice(object param, string strMonthly)
        {
            using (IDbConnection con = GetHallaDb())
            {
                string query = "";
                try
                {
                    con.Open();

                    // ISNULL(B.MONTHLY_TYPE, 20)  이 값을 체크한 이유는 현재 없는 데이터가 있어서 없을 경우도 확인용으로
                    query = @" SELECT   INVEST_YEAR ,
                                     MONTHLY 
		                            ,SUM(ISNULL(INVESTMENT,0)) INVESTMENT
		                            ,SUM(PERSONNEL) AS PERSONNEL
		                            ,SUM(ISNULL(DOMESTIC_PERSONNEL,0)) + SUM(ISNULL(OVERSEAS_PERSONNEL,0)) AS PERSONNEL2
		                            ,SUM(ISNULL(DOMESTIC_PERSONNEL,0)) DOMESTIC_PERSONNEL
		                            ,SUM(ISNULL(OVERSEAS_PERSONNEL,0)) OVERSEAS_PERSONNEL  FROM (
	                            SELECT A.INVEST_YEAR  
		                            , A.MONTHLY	
		                            ,SUM(ISNULL(INVESTMENT,0)) INVESTMENT
		                            ,SUM(PERSONNEL) AS PERSONNEL
		                            ,SUM(ISNULL(DOMESTIC_PERSONNEL,0)) + SUM(ISNULL(OVERSEAS_PERSONNEL,0)) AS PERSONNEL2
		                            ,SUM(ISNULL(DOMESTIC_PERSONNEL,0)) DOMESTIC_PERSONNEL
		                            ,SUM(ISNULL(OVERSEAS_PERSONNEL,0)) OVERSEAS_PERSONNEL 
		                            FROM PM_INVEST A
	                            INNER JOIN PM_INVEST_SUM B 
	                            ON A.SEQ = B.PM_INVEST_SEQ   AND A.INVEST_YEAR <= '2018'
		                            WHERE 
                                             (A.INVEST_YEAR  >=  @PREYEAR 
                                            AND   A.INVEST_YEAR  <=  @ENDYEAR )
													                            AND MONTHLY_TYPE = '" + Define.MONTHLY_TYPE.GetKey("당월") + @"'
													                            AND A.REGIST_STATUS = " + Define.REGIST_STATUS.GetKey("최종승인") + @"
													                            AND A.ORG_COMPANY_SEQ <> 13															
												                            GROUP BY A.INVEST_YEAR ,MONTHLY
                            UNION ALL
	                            SELECT GROUPDATA_YEAR AS INVEST_YEAR
		                            , GROUPDATA_MONTH AS MONTHLY	 
		                            , INVESTMENT  AS INVESTMENT
		                            , PERSONNEL 
		                            , DOMESTIC_PERSONNEL  +  OVERSEAS_PERSONNEL   AS PERSONNEL2
		                            ,  DOMESTIC_PERSONNEL 
		                            ,  OVERSEAS_PERSONNEL  	
		                            FROM PM_GROUPDATA_INVEST_MONTHLY A WITH(NOLOCK)
		                            WHERE  
				                           ( GROUPDATA_YEAR  >= '2019'  )  
                                            AND   ( GROUPDATA_YEAR  <=  @ENDYEAR )  
			                            AND	MONTHLY_TYPE = '" + Define.MONTHLY_TYPE.GetKey("당월") + @"' ) C
                             WHERE  MONTHLY IN (" + strMonthly + @")
                            GROUP BY  INVEST_YEAR,MONTHLY
                            ORDER BY  INVEST_YEAR,MONTHLY
                            ";

                    return con.Query<TrendInvest>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.ReportErrorLog(e.ToString() + " " + query);
                    return null;
                }
            }
        }
        public IEnumerable<TrendInvest> GetInvestBusiness(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
                                    SELECT	A.INVEST_YEAR
		                                    , A.MONTHLY
		                                    , DATEPART(QUARTER, A.INVEST_YEAR + '-' + A.MONTHLY + '-01') AS QT
		                                    , ISNULL(B.MONTHLY_TYPE, 20)		AS MONTHLY_TYPE
		                                    , ROW_NUMBER() OVER (PARTITION BY A.INVEST_YEAR, A.ORG_COMPANY_SEQ, B.ORG_BUSINESS_SEQ ORDER BY A.INVEST_YEAR, A.MONTHLY DESC, B.MONTHLY_TYPE DESC) AS NO_Z
		                                    , ISNULL(B.INVESTMENT, 0.00)		AS INVESTMENT
		                                    , ISNULL(B.PERSONNEL, 0.00)			AS PERSONNEL
		                                    , B.ORG_BUSINESS_SEQ
		                                    , F.BUSINESS_NAME
		                                    , A.ORG_COMPANY_SEQ
		                                    , G.COMPANY_NAME
		                                    , G.ORG_UNION_SEQ
		                                    , H.UNION_NAME
                                    FROM	PM_INVEST					A
                                    LEFT OUTER JOIN PM_INVEST_BUSINESS	B ON A.SEQ = B.PM_INVEST_SEQ
                                    LEFT OUTER JOIN ORG_BUSINESS				F ON B.ORG_BUSINESS_SEQ = F.SEQ
                                    LEFT OUTER JOIN ORG_COMPANY					G ON F.ORG_COMPANY_SEQ = G.SEQ
                                    LEFT OUTER JOIN ORG_UNION					H ON G.ORG_UNION_SEQ = H.SEQ
                                    WHERE	1 = 1
                                    AND		A.REGIST_STATUS = " + Define.REGIST_STATUS.GetKey("최종승인") + @"";

                    return con.Query<TrendInvest>(query, param).ToList();
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