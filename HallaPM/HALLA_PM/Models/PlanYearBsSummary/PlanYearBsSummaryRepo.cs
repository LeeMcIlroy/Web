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
    public class PlanYearBsSummaryRepo : DbCon, IPlanYearBsSummary
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
                    string query = " SELECT COUNT(*) FROM PLAN_YEAR_BS_SUMMARY " + where;
                    return con.Query<int>(query, param).First();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return -1;
                }
            }
        }

        public PlanYearBsSummary selectOne(object param)
        {
            throw new NotImplementedException();
        }

        public PlanYearBsSummary selectOneYear(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
SELECT	B.PLAN_YEAR_BS_SEQ
		--, 'THIS'
		, B.YEARLY_YEAR
		, B.ASSETS
		, B.CURRENT_ASSETS
		, B.LIABILITIES
		, B.CURRENT_LIABILITIES
		, B.CAPITAL
		, B.CASH
		, B.LOAN
		, CASE WHEN ISNULL(B.CAPITAL, 0) = 0 THEN 0 ELSE CONVERT(DECIMAL(12, 2), B.LIABILITIES / B.CAPITAL * 100) END AS LIABILITIES_RATE
		, C.AFTER_TAX_OPERATION_PROFIT
		, C.PAIN_IN_CAPITAL
		, CASE WHEN ISNULL(C.PAIN_IN_CAPITAL, 0) = 0 THEN 0 ELSE CONVERT(DECIMAL(12, 2), C.AFTER_TAX_OPERATION_PROFIT / C.PAIN_IN_CAPITAL * 100) END AS ROIC
		, E.AR
		, CASE WHEN ISNULL(D.ANNUAL_SALES, 0) = 0 THEN 0  ELSE CONVERT(DECIMAL(12, 2), E.AR / D.ANNUAL_SALES * 365) END AS AR_TO_DAYS
		, E.AP
		, CASE WHEN ISNULL(D.ANNUAL_SALES_COST, 0) = 0 THEN 0  ELSE CONVERT(DECIMAL(12, 2), E.AP / D.ANNUAL_SALES_COST * 365) END AS AP_TO_DAYS
		, E.INVENTORY
		, CASE WHEN ISNULL(D.INVENTORY_COST, 0) = 0 THEN 0  ELSE CONVERT(DECIMAL(12, 2), E.INVENTORY / D.INVENTORY_COST * 365) END AS INVENTORY_TO_DAYS
FROM	PLAN_YEAR_BS						    A
LEFT OUTER JOIN PLAN_YEAR_BS_BSHEET			B ON A.SEQ = B.PLAN_YEAR_BS_SEQ
LEFT OUTER JOIN PLAN_YEAR_BS_ROIC			C ON A.SEQ = C.PLAN_YEAR_BS_SEQ AND B.YEARLY_YEAR = C.YEARLY_YEAR AND B.MONTHLY = C.MONTHLY
LEFT OUTER JOIN PLAN_YEAR_BS_W_CAPITAL		D ON A.SEQ = D.PLAN_YEAR_BS_SEQ AND B.YEARLY_YEAR = D.YEARLY_YEAR AND B.MONTHLY = D.MONTHLY
LEFT OUTER JOIN PLAN_YEAR_BS_W_CAPITAL_REG	E ON A.SEQ = E.PLAN_YEAR_BS_SEQ AND B.YEARLY_YEAR = E.YEARLY_YEAR AND D.MONTHLY = E.MONTHLY
WHERE	1 = 1
AND		A.YEAR_BS_YEAR = @BsYear
AND		A.ORG_COMPANY_SEQ = @OrgCompanySeq
AND		B.MONTHLY  = @Monthly
";
                    return con.Query<PlanYearBsSummary>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        //public IEnumerable<PlanYearBsSummary> selectList(object param)
        //{
        //    using (IDbConnection con = GetHallaDb())
        //    {
        //        try
        //        {
        //            con.Open();

        //            string where = " WHERE 1 = 1 ";

        //            string query = " SELECT	A.*, B.BUSINESS_NAME " +
        //                " FROM PLAN_YEAR_BS_SUMMARY 	A " +
        //                "LEFT OUTER JOIN ORG_BUSINESS        B ON A.ORG_BUSINESS_SEQ = B.SEQ WHERE PLAN_MONTHLY_PAL_SEQ = @PlanMonthlyPalSeq";

        //            return con.Query<PlanYearBsSummary>(query, param).ToList();
        //        }
        //        catch (Exception e)
        //        {
        //            LogUtil.MngError(e.ToString());
        //            return null;
        //        }
        //    }
        //}

        public int insertCum(PlanYearBsSummary entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    // 2018.12.20 W_CAPITAL, W_CAPTAL_REG 항목의 변경으로 쿼리 수정
                    string query = @" 

INSERT INTO PLAN_YEAR_BS_SUMMARY
( PLAN_YEAR_BS_SEQ, YEARLY_YEAR, ASSETS, CURRENT_ASSETS, LIABILITIES, CURRENT_LIABILITIES
	, CAPITAL, CASH, LOAN, LIABILITIES_RATE, AFTER_TAX_OPERATION_PROFIT, PAIN_IN_CAPITAL, ROIC
	, AR, AR_TO_DAYS, AP, AP_TO_DAYS, INVENTORY, INVENTORY_TO_DAYS )
SELECT	B.PLAN_YEAR_BS_SEQ
		--, 'THIS'
		, B.YEARLY_YEAR
		, B.ASSETS
		, B.CURRENT_ASSETS
		, B.LIABILITIES
		, B.CURRENT_LIABILITIES
		, B.CAPITAL
		, B.CASH
		, B.LOAN
		, CASE WHEN ISNULL(B.CAPITAL, 0) = 0 THEN 0 ELSE CONVERT(DECIMAL(12, 2), B.LIABILITIES / B.CAPITAL * 100) END AS LIABILITIES_RATE
		, C.AFTER_TAX_OPERATION_PROFIT
		, C.PAIN_IN_CAPITAL
		, CASE WHEN ISNULL(C.PAIN_IN_CAPITAL, 0) = 0 THEN 0 ELSE CONVERT(DECIMAL(12, 2), C.AFTER_TAX_OPERATION_PROFIT / C.PAIN_IN_CAPITAL * 100) END AS ROIC
		, E.AR
		, CASE WHEN ISNULL(D.ANNUAL_SALES, 0) = 0 THEN 0  ELSE CONVERT(DECIMAL(12, 2), E.AR / D.ANNUAL_SALES * 365) END AS AR_TO_DAYS
		, E.AP
		, CASE WHEN ISNULL(D.ANNUAL_SALES_COST, 0) = 0 THEN 0  ELSE CONVERT(DECIMAL(12, 2), E.AP / D.ANNUAL_SALES_COST * 365) END AS AP_TO_DAYS
		, E.INVENTORY
		, CASE WHEN ISNULL(D.INVENTORY_COST, 0) = 0 THEN 0  ELSE CONVERT(DECIMAL(12, 2), E.INVENTORY / D.INVENTORY_COST * 365) END AS INVENTORY_TO_DAYS
FROM	PLAN_YEAR_BS						A
LEFT OUTER JOIN PLAN_YEAR_BS_BSHEET			B ON A.SEQ = B.PLAN_YEAR_BS_SEQ AND (B.MONTHLY = '12' OR B.MONTHLY = '99')
LEFT OUTER JOIN PLAN_YEAR_BS_ROIC			C ON A.SEQ = C.PLAN_YEAR_BS_SEQ AND B.YEARLY_YEAR = C.YEARLY_YEAR AND B.MONTHLY = C.MONTHLY
LEFT OUTER JOIN PLAN_YEAR_BS_W_CAPITAL		D ON A.SEQ = D.PLAN_YEAR_BS_SEQ AND B.YEARLY_YEAR = D.YEARLY_YEAR AND B.MONTHLY = D.MONTHLY
LEFT OUTER JOIN PLAN_YEAR_BS_W_CAPITAL_REG	E ON A.SEQ = E.PLAN_YEAR_BS_SEQ AND B.YEARLY_YEAR = E.YEARLY_YEAR AND D.MONTHLY = E.MONTHLY
WHERE	1 = 1
AND		A.SEQ = @PlanYearBsSeq
SELECT CAST(SCOPE_IDENTITY() as int)";
                    return con.Query<int>(query, entity).First();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return -1;
                }
            }
        }

        public int insert(PlanYearBsSummary entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = @" INSERT INTO PLAN_YEAR_BS_SUMMARY ( 
                             PLAN_YEAR_BS_SEQ 
                            , YEARLY_YEAR
                            , ASSETS
                            , LIABILITIES
                            , CAPITAL
                            , CASH
                            , LOAN
                            , LIABILITIES_RATE
                            , AFTER_TAX_OPERATION_PROFIT
                            , PAIN_IN_CAPITAL
                            , ROIC
                            , AR
                            , AR_TO_DAYS
                            , AP
                            , AP_TO_DAYS
                            , INVENTORY
                            , INVENTORY_TO_DAYS
                             ) VALUES ( 
                             @PlanYearBsSeq 
                            , @YearlyYear
                            , @Assets
                            , @Liabilities
                            , @Capital
                            , @Cash
                            , @Loan
                            , @LiabilitiesRate
                            , @AfterTaxOperationProfit
                            , @PainInCapital
                            , @Roic
                            , @Ar
                            , @ArToDays
                            , @Ap
                            , @ApToDays
                            , @Inventory
                            , @InventoryToDays
                            ); SELECT CAST(SCOPE_IDENTITY() as int)";
                    return con.Query<int>(query, entity).First();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return -1;
                }
            }
        }

        public IEnumerable<PlanYearBsSummary> planYearBsSummaryList(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" SELECT YEARLY_YEAR
	                                        ,ASSETS
	                                        ,LIABILITIES
                                            ,CAPITAL
                                            ,CASH
                                            ,LOAN
                                            ,LIABILITIES_RATE
                                            ,AFTER_TAX_OPERATION_PROFIT
                                            ,PAIN_IN_CAPITAL
                                            ,ROIC
                                            ,AR
                                            ,AR_TO_DAYS
                                            ,AP
                                            ,AP_TO_DAYS
                                            ,INVENTORY
                                            ,INVENTORY_TO_DAYS
                                            ,A.SEQ AS PLAN_YEAR_BS_SUMMARY_SEQ
                                      FROM	PLAN_YEAR_BS_SUMMARY	A
                                      LEFT OUTER JOIN PLAN_YEAR_BS	B ON A.PLAN_YEAR_BS_SEQ = B.SEQ
                                      WHERE	A.PLAN_YEAR_BS_SEQ = @PlanYearBsSeq
                                      AND YEARLY_YEAR >= @Year";

                    return con.Query<PlanYearBsSummary>(query, param).ToList();

                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<PlanYearBsSummary> selectList(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" SELECT *
                                      FROM	PLAN_YEAR_BS_SUMMARY
                                      WHERE	PLAN_YEAR_BS_SEQ = @PlanYearBsSeq ";

                    return con.Query<PlanYearBsSummary>(query, param).ToList();

                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public int update(PlanYearBsSummary entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " UPDATE PLAN_YEAR_BS_SUMMARY SET " +
                        // 이부분은 수정하여 사용하세요. 
                        //" , PLAN_YEAR_BS_SEQ = @PlanYearBsSeq" +
                        //" , YEARLY = @Yearly" +
                        //" , YEARLY_YEAR = @YearlyYear" +
                        " ASSETS = @Assets" +
                        " , CURRENT_ASSETS = @CurrentAssets" +
                        " , LIABILITIES = @Liabilities" +
                        " , CURRENT_LIABILITIES = @CurrentLiabilities" +
                        " , CAPITAL = @Capital" +
                        " , CASH = @Cash" +
                        " , LOAN = @Loan" +
                        " , LIABILITIES_RATE = @LiabilitiesRate" +
                        " , AFTER_TAX_OPERATION_PROFIT = @AfterTaxOperationProfit" +
                        " , PAIN_IN_CAPITAL = @PainInCapital" +
                        " , ROIC = @Roic" +
                        " , AR = @Ar" +
                        " , AR_TO_DAYS = @ArToDays" +
                        " , AP = @Ap" +
                        " , AP_TO_DAYS = @ApToDays" +
                        " , INVENTORY = @Inventory" +
                        " , INVENTORY_TO_DAYS = @InventoryToDays" +
                        " WHERE SEQ = @Seq" +
                    // 이부분은 수정하여 사용하세요. 
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
                    string query = " DELETE PLAN_YEAR_BS_SUMMARY " +
                        " WHERE PLAN_YEAR_BS_SEQ = @PlanYearBsSeq ";
                    return con.Execute(query, key);
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return -1;
                }
            }
        }

        public int save(PlanYearBsSummary entity)
        {
            throw new NotImplementedException();
        }

        public void Dispose()
        {
            throw new NotImplementedException();
        }
        public IEnumerable<PlanYearBsSummaryExp> selectListPnThisYear(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
-- 당해년도 계획
SELECT	B.YEARLY_YEAR
		, ISNULL(B.ASSETS, 0.00)						AS ASSETS
		, ISNULL(B.LIABILITIES, 0.00)					AS LIABILITIES
		, ISNULL(B.CAPITAL, 0.00)						AS CAPITAL
		, ISNULL(B.CASH, 0.00)							AS CASH
		, ISNULL(B.LOAN, 0.00)							AS LOAN
		, ISNULL(B.LIABILITIES_RATE, 0)					AS LIABILITIES_RATE -- 부채비율도 불러온다.
		, ISNULL(B.AFTER_TAX_OPERATION_PROFIT, 0)		AS AFTER_TAX_OPERATION_PROFIT
		, ISNULL(B.PAIN_IN_CAPITAL, 0)					AS PAIN_IN_CAPITAL		
		, ISNULL(B.ROIC, 0)								AS ROIC -- 계획은 ROIC값을 저장하기에 저장된 값을 불러온다.
		, ISNULL(B.AR, 0.00)							AS AR
		, ISNULL(B.AR_TO_DAYS, 0.00)					AS AR_TO_DAYS
		, ISNULL(B.AP, 0.00)							AS AP
		, ISNULL(B.AP_TO_DAYS, 0.00)					AS AP_TO_DAYS
		, ISNULL(B.INVENTORY, 0.00)						AS INVENTORY
		, ISNULL(B.INVENTORY_TO_DAYS, 0.00)				AS INVENTORY_TO_DAYS
		, C.ORG_UNION_SEQ
		, E.UNION_NAME
		, A.ORG_COMPANY_SEQ
		, C.COMPANY_NAME
FROM	PLAN_YEAR_BS							A
LEFT OUTER JOIN PLAN_YEAR_BS_SUMMARY			B ON A.SEQ = B.PLAN_YEAR_BS_SEQ
LEFT OUTER JOIN ORG_COMPANY					C ON A.ORG_COMPANY_SEQ = C.SEQ
LEFT OUTER JOIN ORG_UNION					E ON C.ORG_UNION_SEQ = E.SEQ
WHERE	1 = 1
AND		A.YEAR_BS_YEAR = @year
AND     A.REGIST_STATUS = " + Define.REGIST_STATUS.GetKey("최종승인") + @"
ORDER BY C.ORG_UNION_SEQ, C.ORD
";

                    return con.Query<PlanYearBsSummaryExp>(query, param).ToList();
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