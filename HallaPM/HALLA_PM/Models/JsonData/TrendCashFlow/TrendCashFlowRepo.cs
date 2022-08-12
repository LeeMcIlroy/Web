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
    public class TrendCashFlowRepo : DbCon, ITrendCashFlowRepo
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

        public int insert(TrendCashFlow entity)
        {
            throw new NotImplementedException();
        }

        public int save(TrendCashFlow entity)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<TrendCashFlow> selectList(object param)
        {
            throw new NotImplementedException();
        }

        public TrendCashFlow selectOne(object param)
        {
            throw new NotImplementedException();
        }

        public int update(TrendCashFlow entity)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<TrendCashFlow> GetCashFlowYear(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
;WITH CTE_CASH_FLOW_LOW_DATA AS
(
SELECT	*
FROM	(
SELECT	A.CASH_FLOW_YEAR
		, A.MONTHLY
		, ROW_NUMBER() OVER (PARTITION BY A.CASH_FLOW_YEAR, A.ORG_COMPANY_SEQ ORDER BY A.CASH_FLOW_YEAR, A.MONTHLY DESC, B.DIFF DESC) AS NO_Z
		, ISNULL(B.DIFF, 20)				AS DIFF
		, ISNULL(B.EBITDA, 0.00)			AS EBITDA
		, ISNULL(B.WC_SUM, 0.00)			AS WC_SUM
		, ISNULL(B.ETC, 0.00)				AS ETC
		, ISNULL(B.NET_CAPEX_SUM, 0.00)		AS NET_CAPEX_SUM
		, ISNULL(B.FINANCIAL_COST, 0.00)	AS FINANCIAL_COST_SUM
		, ISNULL(B.FCF2, 0.00)				AS FCF2
		, ISNULL(B.FINANCIAL_SUM, 0.00)		AS FINANCIAL_SUM
		, ISNULL(B.CASH_SUM, 0.00)			AS CASH_SUM
		, ISNULL(B.ENDING_CASH, 0.00)		AS ENDING_CASH
		, ISNULL(B.CREDIT_LINE, 0.00)		AS CREDIT_LINE
		, ISNULL(B.AVAILABLE_CASH, 0.00)	AS AVAILABLE_CASH
		, ISNULL(D.ALLOCATION, 0.00)					AS ALLOCATION
		, ISNULL(D.INCREASE, 0.00)						AS INCREASE
		, ISNULL(D.BORROWING, 0.00)						AS BORROWING
		, ISNULL(D.REPAYMENT, 0.00)						AS REPAYMENT
		, ISNULL(D.ETC, 0.00)							AS FINANCIAL_ETC
		, A.ORG_COMPANY_SEQ
		, G.COMPANY_NAME
		, G.ORG_UNION_SEQ
		, H.UNION_NAME
FROM	PM_CASH_FLOW						A
LEFT OUTER JOIN PM_CASH_FLOW_CUMULATIVE		B ON A.SEQ = B.PM_CASH_FLOW_SEQ
LEFT OUTER JOIN PM_CASH_FLOW_FINANCIAL		D ON A.SEQ = D.PM_CASH_FLOW_SEQ
LEFT OUTER JOIN ORG_COMPANY					G ON A.ORG_COMPANY_SEQ = G.SEQ
LEFT OUTER JOIN ORG_UNION					H ON G.ORG_UNION_SEQ = H.SEQ
WHERE	A.REGIST_STATUS = " + Define.REGIST_STATUS.GetKey("최종승인") + @"
AND		ISNULL(B.DIFF, " + Define.DIFF.GetKey("실적") + ") = '" + Define.DIFF.GetKey("실적") + @"'
AND		ISNULL(D.CUMULATIVE, " + Define.CUMULATIVE.GetKey("누계 실적") + ") = '" + Define.CUMULATIVE.GetKey("누계 실적") + @"'
)		A
WHERE	A.NO_Z = 1
)
SELECT	*
FROM	CTE_CASH_FLOW_LOW_DATA

";

                    return con.Query<TrendCashFlow>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.ReportErrorLog(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<TrendCashFlow> GetCashFlowYear_NEW(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"  	    SELECT	 
		                                            CASH_FLOW_YEAR
		                                            ,MONTHLY
		                                            ,SUM(EBITDA					)AS EBITDA				
		                                            ,SUM(WC_SUM					)AS WC_SUM				
		                                            ,SUM(ETC					)AS ETC				
		                                            ,SUM(NET_CAPEX_SUM			)AS NET_CAPEX_SUM		
		                                            ,SUM(FINANCIAL_COST_SUM		)AS FINANCIAL_COST_SUM	
		                                            ,SUM(FCF2					)AS FCF2				
		                                            ,SUM(FINANCIAL_SUM			)AS FINANCIAL_SUM		
		                                            ,SUM(CASH_SUM				)AS CASH_SUM			
		                                            ,SUM(ENDING_CASH			)AS ENDING_CASH		
		                                            ,SUM(CREDIT_LINE			)AS CREDIT_LINE		
		                                            ,SUM(AVAILABLE_CASH			)AS AVAILABLE_CASH		
		                                            ,SUM(ALLOCATION				)AS ALLOCATION			
		                                            ,SUM(INCREASE				)AS INCREASE			
		                                            ,SUM(BORROWING				)AS BORROWING			
		                                            ,SUM(REPAYMENT				)AS REPAYMENT			
		                                            ,SUM(FINANCIAL_ETC			)AS FINANCIAL_ETC	
		                                            ,SUM(FCF2					)AS FCF		
	                                            FROM	(
		                                                    SELECT	A.CASH_FLOW_YEAR
				                                                    , A.MONTHLY 
				                                                    , ISNULL(B.EBITDA, 0.00)			AS EBITDA
				                                                    , ISNULL(B.WC_SUM, 0.00)			AS WC_SUM
				                                                    , ISNULL(B.ETC, 0.00)				AS ETC
				                                                    , ISNULL(B.NET_CAPEX_SUM, 0.00)		AS NET_CAPEX_SUM
				                                                    , ISNULL(B.FINANCIAL_COST, 0.00)	AS FINANCIAL_COST_SUM
				                                                    , ISNULL(B.FCF2, 0.00)				AS FCF2
				                                                    , ISNULL(B.FINANCIAL_SUM, 0.00)		AS FINANCIAL_SUM
				                                                    , ISNULL(B.CASH_SUM, 0.00)			AS CASH_SUM
				                                                    , ISNULL(B.ENDING_CASH, 0.00)		AS ENDING_CASH
				                                                    , ISNULL(B.CREDIT_LINE, 0.00)		AS CREDIT_LINE
				                                                    , ISNULL(B.AVAILABLE_CASH, 0.00)	AS AVAILABLE_CASH
				                                                    , ISNULL(D.ALLOCATION, 0.00)					AS ALLOCATION
				                                                    , ISNULL(D.INCREASE, 0.00)						AS INCREASE
				                                                    , ISNULL(D.BORROWING, 0.00)						AS BORROWING
				                                                    , ISNULL(D.REPAYMENT, 0.00)						AS REPAYMENT
				                                                    , ISNULL(D.ETC, 0.00)							AS FINANCIAL_ETC
		                                                    FROM	(select * from PM_CASH_FLOW WITH(NOLOCK) WHERE CASH_FLOW_YEAR <= '2018'   AND  REGIST_STATUS = 7  ) A
		                                                    INNER JOIN PM_CASH_FLOW_CUMULATIVE		B WITH(NOLOCK)	 
                                                                        ON A.SEQ = B.PM_CASH_FLOW_SEQ 
                                                                            AND A.MONTHLY = (SELECT MAX(MONTHLY) FROM PM_CASH_FLOW WITH(NOLOCK) 
                                                                                                    WHERE CASH_FLOW_YEAR = A.CASH_FLOW_YEAR 
                                                                                                            AND REGIST_STATUS = 7)
		                                                    INNER JOIN PM_CASH_FLOW_FINANCIAL		D WITH(NOLOCK)	 
                                                                        ON A.SEQ = D.PM_CASH_FLOW_SEQ 
                                                                            AND A.MONTHLY = (SELECT MAX(MONTHLY) FROM PM_CASH_FLOW WITH(NOLOCK) 
                                                                                                    WHERE CASH_FLOW_YEAR = A.CASH_FLOW_YEAR 
                                                                                                            AND REGIST_STATUS = 7)
		                                                    WHERE	A.REGIST_STATUS = 7
		                                                    AND		ISNULL(B.DIFF,  20) = '20'
		                                                    AND		ISNULL(D.CUMULATIVE, 20) = '20' 
                                                            AND (A.CASH_FLOW_YEAR >=  @PREYEAR AND A.CASH_FLOW_YEAR  <= @ENDYEAR ) 
		                                                    --AND		A.ORG_COMPANY_SEQ <> 13
	                                                    ) A
	                                            GROUP BY CASH_FLOW_YEAR,MONTHLY
                                       UNION ALL
 
                                        SELECT GROUPDATA_YEAR AS CASH_FLOW_YEAR
	                                        ,GROUPDATA_MONTH AS MONTHLY
	                                        ,EBITDA				
	                                        ,WC AS WC_SUM	 			
	                                        , SALES_ETC AS ETC				
	                                        , NET_CAPEX AS NET_CAPEX_SUM		
	                                        , FINANCIAL_COST AS FINANCIAL_COST_SUM	
	                                        , FCF2				
	                                        ,FINANCIAL_SUM		
	                                        ,CASH_SUM			
	                                        ,ISNULL((SELECT BASIC_CASH FROM PM_GROUPDATA_CF_MONTHLY 
                                                        WHERE GROUPDATA_YEAR = A.GROUPDATA_YEAR 
                                                            AND GROUPDATA_MONTH = '01' AND MONTH_TYPE=20 ),0) 
                                                + FINANCIAL_SUM + FCF AS ENDING_CASH 
                                            ,CREDIT_LINE		
	                                        ,AVAILABLE_CASH		
	                                        ,ALLOCATION			
	                                        ,INCREASE			
	                                        ,BORROWING			
	                                        ,REPAYMENT			
	                                        ,ETC	AS	FINANCIAL_ETC	
	                                        ,FCF
                                        FROM    PM_GROUPDATA_CF_MONTHLY
                                        A WITH(NOLOCK)
		                                        WHERE   (GROUPDATA_YEAR >=  '2019' AND GROUPDATA_YEAR <= @ENDYEAR ) 
                                                        AND GROUPDATA_MONTH = (SELECT MAX(GROUPDATA_MONTH) FROM PM_GROUPDATA_CF_MONTHLY   WITH(NOLOCK) 
                                                                                                            WHERE  GROUPDATA_YEAR = A.GROUPDATA_YEAR )
                                        AND MONTH_TYPE = 20
                                        ORDER BY CASH_FLOW_YEAR 
                                    ";

                    return con.Query<TrendCashFlow>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.ReportErrorLog(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<TrendCashFlow> GetCashFlowMonth_NEW(object param,string strQuater)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
-- 손익 > 월별데이터 = 기본데이터
                                    SELECT	 
		                                            CASH_FLOW_YEAR
		                                            , B.QT
		                                            ,SUM(EBITDA					)AS EBITDA				
		                                            ,SUM(WC_SUM					)AS WC_SUM				
		                                            ,SUM(ETC					)AS ETC				
		                                            ,SUM(NET_CAPEX_SUM			)AS NET_CAPEX_SUM		
		                                            ,SUM(FINANCIAL_COST_SUM		)AS FINANCIAL_COST_SUM	
		                                            ,SUM(FCF2					)AS FCF2				
		                                            ,SUM(FINANCIAL_SUM			)AS FINANCIAL_SUM		
		                                            ,SUM(CASH_SUM				)AS CASH_SUM			
		                                            ,SUM(ENDING_CASH			)AS ENDING_CASH		
		                                            ,SUM(CREDIT_LINE			)AS CREDIT_LINE		
		                                            ,SUM(AVAILABLE_CASH			)AS AVAILABLE_CASH		
		                                            ,SUM(ALLOCATION				)AS ALLOCATION			
		                                            ,SUM(INCREASE				)AS INCREASE			
		                                            ,SUM(BORROWING				)AS BORROWING			
		                                            ,SUM(REPAYMENT				)AS REPAYMENT			
		                                            ,SUM(FINANCIAL_ETC			)AS FINANCIAL_ETC	
		                                            ,SUM(FCF2					)AS FCF		
	                                            FROM	( 
		                                          SELECT  A.CASH_FLOW_YEAR
													, DATEPART(QUARTER, A.CASH_FLOW_YEAR + '-' + A.MONTHLY + '-01') AS QT
																, ISNULL(B.OPERATION_PROFIT, 0.00)				AS OPERATION_PROFIT
																, ISNULL(B.DEPRECIATION_COST, 0.00)				AS DEPRECIATION_COST
																, ISNULL(B.CORP_TAX, 0.00)						AS CORP_TAX
																, ISNULL(B.OPERATION_PROFIT, 0.00)
																	+ ISNULL(B.DEPRECIATION_COST, 0.00) 
																	+ ISNULL(B.CORP_TAX, 0.00)					AS EBITDA
																, ISNULL(B.AR, 0.00)							AS AR
																, ISNULL(B.INV, 0.00)							AS INV
																, ISNULL(B.AP, 0.00)							AS AP
																, ISNULL(B.AR, 0.00)
																	+ ISNULL(B.INV, 0.00)
																	+ ISNULL(B.AP, 0.00)						AS WC_SUM
																, ISNULL(B.ETC, 0.00)                           AS ETC
																, ISNULL(B.INTEREST_EXPENSE, 0.00)				AS INTEREST_EXPENSE
																, ISNULL(B.INTEREST_INCOME, 0.00)				AS INTEREST_INCOME
																, ISNULL(B.INTEREST_EXPENSE, 0.00)
																	+ ISNULL(B.INTEREST_INCOME, 0.00)			AS FINANCIAL_COST_SUM
																, ISNULL(C.ASSETS, 0.00)						AS ASSETS
																, ISNULL(C.EQUITY_INVESTMENT, 0.00)				AS EQUITY_INVESTMENT
																, ISNULL(C.ASSETS_SALE, 0.00)					AS ASSETS_SALE
																, ISNULL(C.ASSETS, 0.00)
																	+ ISNULL(C.EQUITY_INVESTMENT, 0.00)
																	+ ISNULL(C.ASSETS_SALE, 0.00)				AS NET_CAPEX_SUM
																, ISNULL(D.ALLOCATION, 0.00)					AS ALLOCATION
																, ISNULL(D.INCREASE, 0.00)						AS INCREASE
																, ISNULL(D.BORROWING, 0.00)						AS BORROWING
																, ISNULL(D.REPAYMENT, 0.00)						AS REPAYMENT
																, ISNULL(D.ETC, 0.00)							AS FINANCIAL_ETC
																, ISNULL(D.ALLOCATION, 0.00)
																	+ ISNULL(D.INCREASE, 0.00)
																	+ ISNULL(D.BORROWING, 0.00)
																	+ ISNULL(D.REPAYMENT, 0.00)
																	+ ISNULL(D.ETC, 0.00)						AS FINANCIAL_SUM
																, ISNULL(E.FCF1, 0.00)							AS FCF1
																, ISNULL(E.FCF2, 0.00)							AS FCF2
																, ISNULL(E.FCF3, 0.00)							AS FCF3
																, ISNULL(E.CASH_SUM, 0.00)						AS CASH_SUM
																, ISNULL(E.FCF_SALES, 0.00)						AS FCF_SALES
																, ISNULL(F.BASIC_CASH, 0.00)					AS BASIC_CASH
																, ISNULL(F.ENDING_CASH, 0.00)					AS ENDING_CASH
																, ISNULL(F.CREDIT_LINE, 0.00)					AS CREDIT_LINE
																, ISNULL(F.AVAILABLE_CASH, 0.00)				AS AVAILABLE_CASH
														FROM	PM_CASH_FLOW						A
														LEFT OUTER JOIN PM_CASH_FLOW_SALES			B ON A.SEQ = B.PM_CASH_FLOW_SEQ AND B.CUMULATIVE = '10'
														LEFT OUTER JOIN PM_CASH_FLOW_INVESTMENT		C ON A.SEQ = C.PM_CASH_FLOW_SEQ AND C.CUMULATIVE = '10'
														LEFT OUTER JOIN PM_CASH_FLOW_FINANCIAL		D ON A.SEQ = D.PM_CASH_FLOW_SEQ AND D.CUMULATIVE = '10'
														LEFT OUTER JOIN PM_CASH_FLOW_FCF			E ON A.SEQ = E.PM_CASH_FLOW_SEQ AND E.CUMULATIVE = '10'
														LEFT OUTER JOIN PM_CASH_FLOW_BE_CASH		F ON A.SEQ = F.PM_CASH_FLOW_SEQ AND F.CUMULATIVE = '10'
														WHERE	1 = 1
														AND A.CASH_FLOW_YEAR <= '2018'
														AND		A.REGIST_STATUS = " + Define.REGIST_STATUS.GetKey("최종승인") + @"
	                                                    ) B
												WHERE B.CASH_FLOW_YEAR >= @PREYEAR AND B.CASH_FLOW_YEAR <= @ENDYEAR
                                                AND  B.QT IN (" + strQuater + @")
	                                            GROUP BY CASH_FLOW_YEAR, B.QT
                                       UNION ALL
 
										   SELECT CASH_FLOW_YEAR
		                                            , B.QT
		                                            ,SUM(EBITDA					)AS EBITDA				
		                                            ,SUM(WC_SUM					)AS WC_SUM				
		                                            ,SUM(ETC					)AS ETC				
		                                            ,SUM(NET_CAPEX_SUM			)AS NET_CAPEX_SUM		
		                                            ,SUM(FINANCIAL_COST_SUM		)AS FINANCIAL_COST_SUM	
		                                            ,SUM(FCF2					)AS FCF2				
		                                            ,SUM(FINANCIAL_SUM			)AS FINANCIAL_SUM		
		                                            ,SUM(CASH_SUM				)AS CASH_SUM			
	                                       ,ISNULL((SELECT BASIC_CASH FROM PM_GROUPDATA_CF_MONTHLY WHERE GROUPDATA_YEAR = B.CASH_FLOW_YEAR AND GROUPDATA_MONTH = '01' AND MONTH_TYPE=10 ),0)		
		                                             + 	 SUM(FINANCIAL_SUM	+ FCF)	AS ENDING_CASH		
		                                            ,SUM(CREDIT_LINE			)AS CREDIT_LINE		
		                                            ,SUM(AVAILABLE_CASH			)AS AVAILABLE_CASH		
		                                            ,SUM(ALLOCATION				)AS ALLOCATION			
		                                            ,SUM(INCREASE				)AS INCREASE			
		                                            ,SUM(BORROWING				)AS BORROWING			
		                                            ,SUM(REPAYMENT				)AS REPAYMENT			
		                                            ,SUM(FINANCIAL_ETC			)AS FINANCIAL_ETC	
		                                            ,SUM(FCF2					)AS FCF		
                                        FROM (SELECT GROUPDATA_YEAR AS CASH_FLOW_YEAR
	                                        , DATEPART(QUARTER, A.GROUPDATA_YEAR + '-' + A.GROUPDATA_MONTH + '-01') AS QT
	                                        ,EBITDA				
	                                        ,WC AS WC_SUM	 			
	                                        , SALES_ETC AS ETC				
	                                        , NET_CAPEX AS NET_CAPEX_SUM		
	                                        , FINANCIAL_COST AS FINANCIAL_COST_SUM	
											, FCF2		
	                                        , ALLOCATION
											+ INCREASE
											+ BORROWING
											+ REPAYMENT
											+ ETC		AS FINANCIAL_SUM
	                                        ,CASH_SUM		
	                                        ,CREDIT_LINE		
	                                        ,AVAILABLE_CASH		
	                                        ,ALLOCATION			
	                                        ,INCREASE			
	                                        ,BORROWING			
	                                        ,REPAYMENT			
	                                        ,ETC	AS	FINANCIAL_ETC	
	                                        ,FCF
                                        FROM    PM_GROUPDATA_CF_MONTHLY
                                        A WITH(NOLOCK)
		                                        WHERE   (GROUPDATA_YEAR >=  '2019' AND GROUPDATA_YEAR <= @ENDYEAR ) 
                                                       AND GROUPDATA_MONTH <= (SELECT MAX(GROUPDATA_MONTH) FROM PM_GROUPDATA_CF_MONTHLY   WITH(NOLOCK) 
                                                        --AND GROUPDATA_MONTH  = (SELECT MAX(GROUPDATA_MONTH) FROM PM_GROUPDATA_CF_MONTHLY   WITH(NOLOCK)
                                                                                                            WHERE  GROUPDATA_YEAR = A.GROUPDATA_YEAR )
                                       AND MONTH_TYPE = 10  ) B
                                        --AND MONTH_TYPE = 20) B
                                        WHERE  B.QT IN (" + strQuater + @")
										GROUP BY B.CASH_FLOW_YEAR,B.QT
                                        ORDER BY CASH_FLOW_YEAR ,QT
";

                    return con.Query<TrendCashFlow>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.ReportErrorLog(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<TrendCashFlow> GetCashFlowMonth_NEW_Month(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
-- 손익 > 월별데이터 = 기본데이터
                                    		SELECT	 
		                                            CASH_FLOW_YEAR
		                                            , B.MONTHLY
		                                            ,SUM(EBITDA					)AS EBITDA				
		                                            ,SUM(WC_SUM					)AS WC_SUM				
		                                            ,SUM(ETC					)AS ETC				
		                                            ,SUM(NET_CAPEX_SUM			)AS NET_CAPEX_SUM		
		                                            ,SUM(FINANCIAL_COST_SUM		)AS FINANCIAL_COST_SUM	
		                                            ,SUM(FCF2					)AS FCF2				
		                                            ,SUM(FINANCIAL_SUM			)AS FINANCIAL_SUM		
		                                            ,SUM(CASH_SUM				)AS CASH_SUM			
		                                            ,SUM(ENDING_CASH			)AS ENDING_CASH		
		                                            ,SUM(CREDIT_LINE			)AS CREDIT_LINE		
		                                            ,SUM(AVAILABLE_CASH			)AS AVAILABLE_CASH		
		                                            ,SUM(ALLOCATION				)AS ALLOCATION			
		                                            ,SUM(INCREASE				)AS INCREASE			
		                                            ,SUM(BORROWING				)AS BORROWING			
		                                            ,SUM(REPAYMENT				)AS REPAYMENT			
		                                            ,SUM(FINANCIAL_ETC			)AS FINANCIAL_ETC	
		                                            ,SUM(FCF2					)AS FCF		
	                                            FROM	( 
		                                          SELECT  A.CASH_FLOW_YEAR
													, A.MONTHLY
																, ISNULL(B.OPERATION_PROFIT, 0.00)				AS OPERATION_PROFIT
																, ISNULL(B.DEPRECIATION_COST, 0.00)				AS DEPRECIATION_COST
																, ISNULL(B.CORP_TAX, 0.00)						AS CORP_TAX
																, ISNULL(B.OPERATION_PROFIT, 0.00)
																	+ ISNULL(B.DEPRECIATION_COST, 0.00) 
																	+ ISNULL(B.CORP_TAX, 0.00)					AS EBITDA
																, ISNULL(B.AR, 0.00)							AS AR
																, ISNULL(B.INV, 0.00)							AS INV
																, ISNULL(B.AP, 0.00)							AS AP
																, ISNULL(B.AR, 0.00)
																	+ ISNULL(B.INV, 0.00)
																	+ ISNULL(B.AP, 0.00)						AS WC_SUM
																, ISNULL(B.ETC, 0.00)                           AS ETC
																, ISNULL(B.INTEREST_EXPENSE, 0.00)				AS INTEREST_EXPENSE
																, ISNULL(B.INTEREST_INCOME, 0.00)				AS INTEREST_INCOME
																, ISNULL(B.INTEREST_EXPENSE, 0.00)
																	+ ISNULL(B.INTEREST_INCOME, 0.00)			AS FINANCIAL_COST_SUM
																, ISNULL(C.ASSETS, 0.00)						AS ASSETS
																, ISNULL(C.EQUITY_INVESTMENT, 0.00)				AS EQUITY_INVESTMENT
																, ISNULL(C.ASSETS_SALE, 0.00)					AS ASSETS_SALE
																, ISNULL(C.ASSETS, 0.00)
																	+ ISNULL(C.EQUITY_INVESTMENT, 0.00)
																	+ ISNULL(C.ASSETS_SALE, 0.00)				AS NET_CAPEX_SUM
																, ISNULL(D.ALLOCATION, 0.00)					AS ALLOCATION
																, ISNULL(D.INCREASE, 0.00)						AS INCREASE
																, ISNULL(D.BORROWING, 0.00)						AS BORROWING
																, ISNULL(D.REPAYMENT, 0.00)						AS REPAYMENT
																, ISNULL(D.ETC, 0.00)							AS FINANCIAL_ETC
																, ISNULL(D.ALLOCATION, 0.00)
																	+ ISNULL(D.INCREASE, 0.00)
																	+ ISNULL(D.BORROWING, 0.00)
																	+ ISNULL(D.REPAYMENT, 0.00)
																	+ ISNULL(D.ETC, 0.00)						AS FINANCIAL_SUM
																, ISNULL(E.FCF1, 0.00)							AS FCF1
																, ISNULL(E.FCF2, 0.00)							AS FCF2
																, ISNULL(E.FCF3, 0.00)							AS FCF3
																, ISNULL(E.CASH_SUM, 0.00)						AS CASH_SUM
																, ISNULL(E.FCF_SALES, 0.00)						AS FCF_SALES
																, ISNULL(F.BASIC_CASH, 0.00)					AS BASIC_CASH
																, ISNULL(F.ENDING_CASH, 0.00)					AS ENDING_CASH
																, ISNULL(F.CREDIT_LINE, 0.00)					AS CREDIT_LINE
																, ISNULL(F.AVAILABLE_CASH, 0.00)				AS AVAILABLE_CASH
														FROM	PM_CASH_FLOW						A
														LEFT OUTER JOIN PM_CASH_FLOW_SALES			B ON A.SEQ = B.PM_CASH_FLOW_SEQ AND B.CUMULATIVE = '10'
														LEFT OUTER JOIN PM_CASH_FLOW_INVESTMENT		C ON A.SEQ = C.PM_CASH_FLOW_SEQ AND C.CUMULATIVE = '10'
														LEFT OUTER JOIN PM_CASH_FLOW_FINANCIAL		D ON A.SEQ = D.PM_CASH_FLOW_SEQ AND D.CUMULATIVE = '10'
														LEFT OUTER JOIN PM_CASH_FLOW_FCF			E ON A.SEQ = E.PM_CASH_FLOW_SEQ AND E.CUMULATIVE = '10'
														LEFT OUTER JOIN PM_CASH_FLOW_BE_CASH		F ON A.SEQ = F.PM_CASH_FLOW_SEQ AND F.CUMULATIVE = '10'
														WHERE	1 = 1
														AND A.CASH_FLOW_YEAR <= '2018'
														AND		A.REGIST_STATUS = " + Define.REGIST_STATUS.GetKey("최종승인") + @"
	                                                    ) B			
												WHERE (B.CASH_FLOW_YEAR  +  B.MONTHLY >=  @PREYEAR 
                                                        AND   B.CASH_FLOW_YEAR  +  B.MONTHLY <=  @ENDYEAR )
	                                            GROUP BY CASH_FLOW_YEAR, B.MONTHLY
                                       UNION ALL
 
										   SELECT CASH_FLOW_YEAR
		                                            , MONTHLY
		                                            ,SUM(EBITDA					)AS EBITDA			
                                                    ,SUM(WC_SUM					)AS WC_SUM		
		                                            ,SUM(ETC					)AS ETC				
		                                            ,SUM(NET_CAPEX_SUM			)AS NET_CAPEX_SUM		
		                                            ,SUM(FINANCIAL_COST_SUM		)AS FINANCIAL_COST_SUM	
		                                            ,SUM(FCF2					)AS FCF2				
		                                            ,SUM(FINANCIAL_SUM			)AS FINANCIAL_SUM		
		                                            ,SUM(CASH_SUM				)AS CASH_SUM			
	                                       ,ISNULL((SELECT BASIC_CASH FROM PM_GROUPDATA_CF_MONTHLY 
                                                                    WHERE GROUPDATA_YEAR = B.CASH_FLOW_YEAR AND GROUPDATA_MONTH = '01' AND MONTH_TYPE=10 ),0)		
		                                             + 	 SUM(FINANCIAL_SUM	+ FCF)	AS ENDING_CASH		
		                                            ,SUM(CREDIT_LINE			)AS CREDIT_LINE		
		                                            ,SUM(AVAILABLE_CASH			)AS AVAILABLE_CASH		
		                                            ,SUM(ALLOCATION				)AS ALLOCATION			
		                                            ,SUM(INCREASE				)AS INCREASE			
		                                            ,SUM(BORROWING				)AS BORROWING			
		                                            ,SUM(REPAYMENT				)AS REPAYMENT			
		                                            ,SUM(FINANCIAL_ETC			)AS FINANCIAL_ETC	
		                                            ,SUM(FCF2					)AS FCF		
                                        FROM (SELECT GROUPDATA_YEAR AS CASH_FLOW_YEAR
	                                        , GROUPDATA_MONTH AS MONTHLY
	                                        ,EBITDA				
	                                        ,WC AS WC_SUM	 			
	                                        , SALES_ETC AS ETC				
	                                        , NET_CAPEX AS NET_CAPEX_SUM		
	                                        , FINANCIAL_COST AS FINANCIAL_COST_SUM	
											, FCF2		
	                                        , ALLOCATION
											+ INCREASE
											+ BORROWING
											+ REPAYMENT
											+ ETC		AS FINANCIAL_SUM
	                                        ,CASH_SUM		
	                                        ,CREDIT_LINE		
	                                        ,AVAILABLE_CASH		
	                                        ,ALLOCATION			
	                                        ,INCREASE			
	                                        ,BORROWING			
	                                        ,REPAYMENT			
	                                        ,ETC	AS	FINANCIAL_ETC	
	                                        ,FCF
                                        FROM    PM_GROUPDATA_CF_MONTHLY
                                        A WITH(NOLOCK)
		                                        WHERE    ( GROUPDATA_YEAR + GROUPDATA_MONTH >= '2019'  
                                                        AND   GROUPDATA_YEAR + GROUPDATA_MONTH <=  @ENDYEAR   )
                                                        AND GROUPDATA_MONTH <= (SELECT MAX(GROUPDATA_MONTH) FROM PM_GROUPDATA_CF_MONTHLY   WITH(NOLOCK) 
                                                         --AND GROUPDATA_MONTH = (SELECT MAX(GROUPDATA_MONTH) FROM PM_GROUPDATA_CF_MONTHLY   WITH(NOLOCK) 
                                                                                                            WHERE  GROUPDATA_YEAR = A.GROUPDATA_YEAR )
                                       AND MONTH_TYPE = 10  ) B
                                        --AND MONTH_TYPE = 20 ) B
										GROUP BY B.CASH_FLOW_YEAR,B.MONTHLY
                                        ORDER BY CASH_FLOW_YEAR ,MONTHLY
";

                    return con.Query<TrendCashFlow>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.ReportErrorLog(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<TrendCashFlow> GetCashFlowMonth_NEW_MonthChoice(object param, string strMonthly)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
-- 손익 > 월별데이터 = 기본데이터
                                    		SELECT	 
		                                            CASH_FLOW_YEAR
		                                            , B.MONTHLY
		                                            ,SUM(EBITDA					)AS EBITDA				
		                                            ,SUM(WC_SUM					)AS WC_SUM				
		                                            ,SUM(ETC					)AS ETC				
		                                            ,SUM(NET_CAPEX_SUM			)AS NET_CAPEX_SUM		
		                                            ,SUM(FINANCIAL_COST_SUM		)AS FINANCIAL_COST_SUM	
		                                            ,SUM(FCF2					)AS FCF2				
		                                            ,SUM(FINANCIAL_SUM			)AS FINANCIAL_SUM		
		                                            ,SUM(CASH_SUM				)AS CASH_SUM			
		                                            ,SUM(ENDING_CASH			)AS ENDING_CASH		
		                                            ,SUM(CREDIT_LINE			)AS CREDIT_LINE		
		                                            ,SUM(AVAILABLE_CASH			)AS AVAILABLE_CASH		
		                                            ,SUM(ALLOCATION				)AS ALLOCATION			
		                                            ,SUM(INCREASE				)AS INCREASE			
		                                            ,SUM(BORROWING				)AS BORROWING			
		                                            ,SUM(REPAYMENT				)AS REPAYMENT			
		                                            ,SUM(FINANCIAL_ETC			)AS FINANCIAL_ETC	
		                                            ,SUM(FCF2					)AS FCF		
	                                            FROM	( 
		                                          SELECT  A.CASH_FLOW_YEAR
													, A.MONTHLY
																, ISNULL(B.OPERATION_PROFIT, 0.00)				AS OPERATION_PROFIT
																, ISNULL(B.DEPRECIATION_COST, 0.00)				AS DEPRECIATION_COST
																, ISNULL(B.CORP_TAX, 0.00)						AS CORP_TAX
																, ISNULL(B.OPERATION_PROFIT, 0.00)
																	+ ISNULL(B.DEPRECIATION_COST, 0.00) 
																	+ ISNULL(B.CORP_TAX, 0.00)					AS EBITDA
																, ISNULL(B.AR, 0.00)							AS AR
																, ISNULL(B.INV, 0.00)							AS INV
																, ISNULL(B.AP, 0.00)							AS AP
																, ISNULL(B.AR, 0.00)
																	+ ISNULL(B.INV, 0.00)
																	+ ISNULL(B.AP, 0.00)						AS WC_SUM
																, ISNULL(B.ETC, 0.00)                           AS ETC
																, ISNULL(B.INTEREST_EXPENSE, 0.00)				AS INTEREST_EXPENSE
																, ISNULL(B.INTEREST_INCOME, 0.00)				AS INTEREST_INCOME
																, ISNULL(B.INTEREST_EXPENSE, 0.00)
																	+ ISNULL(B.INTEREST_INCOME, 0.00)			AS FINANCIAL_COST_SUM
																, ISNULL(C.ASSETS, 0.00)						AS ASSETS
																, ISNULL(C.EQUITY_INVESTMENT, 0.00)				AS EQUITY_INVESTMENT
																, ISNULL(C.ASSETS_SALE, 0.00)					AS ASSETS_SALE
																, ISNULL(C.ASSETS, 0.00)
																	+ ISNULL(C.EQUITY_INVESTMENT, 0.00)
																	+ ISNULL(C.ASSETS_SALE, 0.00)				AS NET_CAPEX_SUM
																, ISNULL(D.ALLOCATION, 0.00)					AS ALLOCATION
																, ISNULL(D.INCREASE, 0.00)						AS INCREASE
																, ISNULL(D.BORROWING, 0.00)						AS BORROWING
																, ISNULL(D.REPAYMENT, 0.00)						AS REPAYMENT
																, ISNULL(D.ETC, 0.00)							AS FINANCIAL_ETC
																, ISNULL(D.ALLOCATION, 0.00)
																	+ ISNULL(D.INCREASE, 0.00)
																	+ ISNULL(D.BORROWING, 0.00)
																	+ ISNULL(D.REPAYMENT, 0.00)
																	+ ISNULL(D.ETC, 0.00)						AS FINANCIAL_SUM
																, ISNULL(E.FCF1, 0.00)							AS FCF1
																, ISNULL(E.FCF2, 0.00)							AS FCF2
																, ISNULL(E.FCF3, 0.00)							AS FCF3
																, ISNULL(E.CASH_SUM, 0.00)						AS CASH_SUM
																, ISNULL(E.FCF_SALES, 0.00)						AS FCF_SALES
																, ISNULL(F.BASIC_CASH, 0.00)					AS BASIC_CASH
																, ISNULL(F.ENDING_CASH, 0.00)					AS ENDING_CASH
																, ISNULL(F.CREDIT_LINE, 0.00)					AS CREDIT_LINE
																, ISNULL(F.AVAILABLE_CASH, 0.00)				AS AVAILABLE_CASH
														FROM	PM_CASH_FLOW						A
														LEFT OUTER JOIN PM_CASH_FLOW_SALES			B ON A.SEQ = B.PM_CASH_FLOW_SEQ AND B.CUMULATIVE = '10'
														LEFT OUTER JOIN PM_CASH_FLOW_INVESTMENT		C ON A.SEQ = C.PM_CASH_FLOW_SEQ AND C.CUMULATIVE = '10'
														LEFT OUTER JOIN PM_CASH_FLOW_FINANCIAL		D ON A.SEQ = D.PM_CASH_FLOW_SEQ AND D.CUMULATIVE = '10'
														LEFT OUTER JOIN PM_CASH_FLOW_FCF			E ON A.SEQ = E.PM_CASH_FLOW_SEQ AND E.CUMULATIVE = '10'
														LEFT OUTER JOIN PM_CASH_FLOW_BE_CASH		F ON A.SEQ = F.PM_CASH_FLOW_SEQ AND F.CUMULATIVE = '10'
														WHERE	1 = 1
														AND A.CASH_FLOW_YEAR <= '2018'
														AND		A.REGIST_STATUS = " + Define.REGIST_STATUS.GetKey("최종승인") + @"
	                                                    ) B			
												WHERE (B.CASH_FLOW_YEAR >=  @PREYEAR 
                                                        AND   B.CASH_FLOW_YEAR <=  @ENDYEAR )
                                                AND B.MONTHLY IN (" + strMonthly + @")
	                                            GROUP BY CASH_FLOW_YEAR, B.MONTHLY
                                       UNION ALL
 
										   SELECT CASH_FLOW_YEAR
		                                            , MONTHLY
		                                            ,SUM(EBITDA					)AS EBITDA			
                                                    ,SUM(WC_SUM					)AS WC_SUM		
		                                            ,SUM(ETC					)AS ETC				
		                                            ,SUM(NET_CAPEX_SUM			)AS NET_CAPEX_SUM		
		                                            ,SUM(FINANCIAL_COST_SUM		)AS FINANCIAL_COST_SUM	
		                                            ,SUM(FCF2					)AS FCF2				
		                                            ,SUM(FINANCIAL_SUM			)AS FINANCIAL_SUM		
		                                            ,SUM(CASH_SUM				)AS CASH_SUM			
	                                       ,ISNULL((SELECT BASIC_CASH FROM PM_GROUPDATA_CF_MONTHLY 
                                                                    WHERE GROUPDATA_YEAR = B.CASH_FLOW_YEAR AND GROUPDATA_MONTH = '01' AND MONTH_TYPE=10 ),0)		
		                                             + 	 SUM(FINANCIAL_SUM	+ FCF)	AS ENDING_CASH		
		                                            ,SUM(CREDIT_LINE			)AS CREDIT_LINE		
		                                            ,SUM(AVAILABLE_CASH			)AS AVAILABLE_CASH		
		                                            ,SUM(ALLOCATION				)AS ALLOCATION			
		                                            ,SUM(INCREASE				)AS INCREASE			
		                                            ,SUM(BORROWING				)AS BORROWING			
		                                            ,SUM(REPAYMENT				)AS REPAYMENT			
		                                            ,SUM(FINANCIAL_ETC			)AS FINANCIAL_ETC	
		                                            ,SUM(FCF2					)AS FCF		
                                        FROM (SELECT GROUPDATA_YEAR AS CASH_FLOW_YEAR
	                                        , GROUPDATA_MONTH AS MONTHLY
	                                        ,EBITDA				
	                                        ,WC AS WC_SUM	 			
	                                        , SALES_ETC AS ETC				
	                                        , NET_CAPEX AS NET_CAPEX_SUM		
	                                        , FINANCIAL_COST AS FINANCIAL_COST_SUM	
											, FCF2		
	                                        , ALLOCATION
											+ INCREASE
											+ BORROWING
											+ REPAYMENT
											+ ETC		AS FINANCIAL_SUM
	                                        ,CASH_SUM		
	                                        ,CREDIT_LINE		
	                                        ,AVAILABLE_CASH		
	                                        ,ALLOCATION			
	                                        ,INCREASE			
	                                        ,BORROWING			
	                                        ,REPAYMENT			
	                                        ,ETC	AS	FINANCIAL_ETC	
	                                        ,FCF
                                        FROM    PM_GROUPDATA_CF_MONTHLY
                                        A WITH(NOLOCK)
		                                        WHERE    ( GROUPDATA_YEAR  >= '2019'  
                                                        AND   GROUPDATA_YEAR  <=  @ENDYEAR   )
                                                       AND GROUPDATA_MONTH <= (SELECT MAX(GROUPDATA_MONTH) FROM PM_GROUPDATA_CF_MONTHLY   WITH(NOLOCK) 
                                                      --AND GROUPDATA_MONTH = (SELECT MAX(GROUPDATA_MONTH) FROM PM_GROUPDATA_CF_MONTHLY   WITH(NOLOCK) 
                                                                                                            WHERE  GROUPDATA_YEAR = A.GROUPDATA_YEAR )
                                        AND GROUPDATA_MONTH IN (" + strMonthly + @")
                                        AND MONTH_TYPE = " + Define.MONTHLY_TYPE.GetKey("당월") + @" ) B
                                        --AND MONTH_TYPE = " + Define.MONTHLY_TYPE.GetKey("누계") + @" ) B
										GROUP BY B.CASH_FLOW_YEAR,B.MONTHLY
                                        ORDER BY CASH_FLOW_YEAR ,MONTHLY
";

                    return con.Query<TrendCashFlow>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.ReportErrorLog(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<TrendCashFlow> GetCashFlowMonth(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
-- 손익 > 월별데이터 = 기본데이터
SELECT	A.CASH_FLOW_YEAR
		, A.MONTHLY
		, DATEPART(QUARTER, A.CASH_FLOW_YEAR + '-' + A.MONTHLY + '-01') AS QT
		, ISNULL(B.OPERATION_PROFIT, 0.00)				AS OPERATION_PROFIT
		, ISNULL(B.DEPRECIATION_COST, 0.00)				AS DEPRECIATION_COST
		, ISNULL(B.CORP_TAX, 0.00)						AS CORP_TAX
		, ISNULL(B.OPERATION_PROFIT, 0.00)
			+ ISNULL(B.DEPRECIATION_COST, 0.00) 
			+ ISNULL(B.CORP_TAX, 0.00)					AS EBITDA
		, ISNULL(B.AR, 0.00)							AS AR
		, ISNULL(B.INV, 0.00)							AS INV
		, ISNULL(B.AP, 0.00)							AS AP
		, ISNULL(B.AR, 0.00)
			+ ISNULL(B.INV, 0.00)
			+ ISNULL(B.AP, 0.00)						AS WC_SUM
		, ISNULL(B.ETC, 0.00)                           AS ETC
		, ISNULL(B.INTEREST_EXPENSE, 0.00)				AS INTEREST_EXPENSE
		, ISNULL(B.INTEREST_INCOME, 0.00)				AS INTEREST_INCOME
		, ISNULL(B.INTEREST_EXPENSE, 0.00)
			+ ISNULL(B.INTEREST_INCOME, 0.00)			AS FINANCIAL_COST_SUM
		, ISNULL(C.ASSETS, 0.00)						AS ASSETS
		, ISNULL(C.EQUITY_INVESTMENT, 0.00)				AS EQUITY_INVESTMENT
		, ISNULL(C.ASSETS_SALE, 0.00)					AS ASSETS_SALE
		, ISNULL(C.ASSETS, 0.00)
			+ ISNULL(C.EQUITY_INVESTMENT, 0.00)
			+ ISNULL(C.ASSETS_SALE, 0.00)				AS NET_CAPEX_SUM
		, ISNULL(D.ALLOCATION, 0.00)					AS ALLOCATION
		, ISNULL(D.INCREASE, 0.00)						AS INCREASE
		, ISNULL(D.BORROWING, 0.00)						AS BORROWING
		, ISNULL(D.REPAYMENT, 0.00)						AS REPAYMENT
		, ISNULL(D.ETC, 0.00)							AS FINANCIAL_ETC
		, ISNULL(D.ALLOCATION, 0.00)
			+ ISNULL(D.INCREASE, 0.00)
			+ ISNULL(D.BORROWING, 0.00)
			+ ISNULL(D.REPAYMENT, 0.00)
			+ ISNULL(D.ETC, 0.00)						AS FINANCIAL_SUM
		, ISNULL(E.FCF1, 0.00)							AS FCF1
		, ISNULL(E.FCF2, 0.00)							AS FCF2
		, ISNULL(E.FCF3, 0.00)							AS FCF3
		, ISNULL(E.CASH_SUM, 0.00)						AS CASH_SUM
		, ISNULL(E.FCF_SALES, 0.00)						AS FCF_SALES
		, ISNULL(F.BASIC_CASH, 0.00)					AS BASIC_CASH
		, ISNULL(F.ENDING_CASH, 0.00)					AS ENDING_CASH
		, ISNULL(F.CREDIT_LINE, 0.00)					AS CREDIT_LINE
		, ISNULL(F.AVAILABLE_CASH, 0.00)				AS AVAILABLE_CASH
		, A.ORG_COMPANY_SEQ
		, G.COMPANY_NAME
		, G.ORG_UNION_SEQ
		, H.UNION_NAME
FROM	PM_CASH_FLOW						A
LEFT OUTER JOIN PM_CASH_FLOW_SALES			B ON A.SEQ = B.PM_CASH_FLOW_SEQ AND B.CUMULATIVE = '10'
LEFT OUTER JOIN PM_CASH_FLOW_INVESTMENT		C ON A.SEQ = C.PM_CASH_FLOW_SEQ AND C.CUMULATIVE = '10'
LEFT OUTER JOIN PM_CASH_FLOW_FINANCIAL		D ON A.SEQ = D.PM_CASH_FLOW_SEQ AND D.CUMULATIVE = '10'
LEFT OUTER JOIN PM_CASH_FLOW_FCF			E ON A.SEQ = E.PM_CASH_FLOW_SEQ AND E.CUMULATIVE = '10'
LEFT OUTER JOIN PM_CASH_FLOW_BE_CASH		F ON A.SEQ = F.PM_CASH_FLOW_SEQ AND F.CUMULATIVE = '10'
LEFT OUTER JOIN ORG_COMPANY					G ON A.ORG_COMPANY_SEQ = G.SEQ
LEFT OUTER JOIN ORG_UNION					H ON G.ORG_UNION_SEQ = H.SEQ
WHERE	1 = 1
AND		A.REGIST_STATUS = " + Define.REGIST_STATUS.GetKey("최종승인") + @"
";

                    return con.Query<TrendCashFlow>(query, param).ToList();
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