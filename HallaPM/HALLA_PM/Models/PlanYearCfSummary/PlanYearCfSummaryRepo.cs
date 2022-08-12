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
    public class PlanYearCfSummaryRepo : DbCon, IPlanYearCfSummaryRepo
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
                    string query = " DELETE PLAN_YEAR_CF_SUMMARY " +
                        " WHERE PLAN_YEAR_CF_SEQ = @PlanYearCfSeq";
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

        public int insert(PlanYearCfSummary entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " INSERT INTO  PLAN_YEAR_CF_SUMMARY ( " +
                        // 이부분은 수정하여 사용하세요. 
                        " PLAN_YEAR_CF_SEQ " +
                        ", YEARLY " +
                        ", YEARLY_YEAR " +
                        ", CF_SALES " +
                        ", CF_INVESTMENT " +
                        ", CF_FINANCIAL " +
                        //", CF_SUM " +
                        ", CF_ENDING_CASH " +
                        ", CF_AVAILABLE_CASH " +
                        ", FCF1 " +
                        ", FCF2 " +
                        ", FCF3 " +
                    " ) VALUES ( " +
                    " @PlanYearCfSeq " +
                    ", @Yearly " +
                    ", @YearlyYear " +
                    ", @CfSales " +
                    ", @CfInvestment " +
                    ", @CfFinancial " +
                    //", @CfSum " +
                    ", @CfEndingCash " +
                    ", @CfAvailableCash " +
                    ", @Fcf1 " +
                    ", @Fcf2 " +
                    ", @Fcf3 " +
                    // 이부분은 수정하여 사용하세요. 
                    "); SELECT CAST(SCOPE_IDENTITY() as int)";
                    return con.Query<int>(query, entity).First();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return -1;
                }
            }


        }

        public int insertCum(PlanYearCfSummary entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
INSERT INTO PLAN_YEAR_CF_SUMMARY
( PLAN_YEAR_CF_SEQ, YEARLY, YEARLY_YEAR, CF_SALES, CF_INVESTMENT, CF_FINANCIAL, CF_ENDING_CASH, CF_AVAILABLE_CASH, FCF1, FCF2, FCF3)
SELECT	B.PLAN_YEAR_CF_SEQ
		, 'THIS'		AS YEARLY
		, B.YEARLY_YEAR
		, B.SALES
		, C.INVESTMENT
		, D.FINANCIAL
		--, B.SALES
		--+ C.INVESTMENT
		--+ D.FINANCIAL			AS CF_SUM
		, E.ENDING_CASH
		, E.AVAILABLE_CASH
		, F.FCF1
		, F.FCF2
		, F.FCF3
FROM	PLAN_YEAR_CF					A
LEFT OUTER JOIN (
	SELECT	PLAN_YEAR_CF_SEQ
			, YEARLY_YEAR
			, '99'				AS MONTHLY
			, SUM(OPERATION_PROFIT) AS OPERATION_PROFIT
			, SUM(DEPRECIATION_COST) AS DEPRECIATION_COST
			, SUM(CORP_TAX) AS CORP_TAX
			, SUM(AR) AS AR
			, SUM(INV) AS INV
			, SUM(AP) AS AP
			, SUM(ETC) AS ETC
			, SUM(INTEREST_EXPENSE) AS INTEREST_EXPENSE
			, SUM(INTEREST_INCOME) AS INTEREST_INCOME
			, SUM(OPERATION_PROFIT
			+ DEPRECIATION_COST
			+ CORP_TAX
			+ AR
			+ INV
			+ AP
			+ ETC
			+ INTEREST_EXPENSE
			+ INTEREST_INCOME)			AS SALES
	FROM	PLAN_YEAR_CF_SALES
	GROUP BY PLAN_YEAR_CF_SEQ, YEARLY_YEAR
)										B ON A.SEQ = B.PLAN_YEAR_CF_SEQ
LEFT OUTER JOIN (
	SELECT	PLAN_YEAR_CF_SEQ
			, YEARLY_YEAR
			, '99'				AS MONTHLY
			, SUM(ASSETS) AS ASSETS
			, SUM(EQUITY_INVESTMENT) AS EQUITY_INVESTMENT
			, SUM(ASSETS_SALE) AS ASSETS_SALE
			, SUM(ETC) AS ETC
			, SUM(ASSETS
			+ EQUITY_INVESTMENT
			+ ASSETS_SALE
			+ ETC)			AS INVESTMENT
	FROM	PLAN_YEAR_CF_INVESTMENT
	GROUP BY PLAN_YEAR_CF_SEQ, YEARLY_YEAR
)										C ON A.SEQ = C.PLAN_YEAR_CF_SEQ AND B.YEARLY_YEAR = C.YEARLY_YEAR
LEFT OUTER JOIN (
	SELECT	PLAN_YEAR_CF_SEQ
			, YEARLY_YEAR
			, '99'				AS MONTHLY
			, SUM(ALLOCATION) AS ALLOCATION
			, SUM(INCREASE) AS INCREASE
			, SUM(BORROWING) AS BORROWING
			, SUM(REPAYMENT) AS REPAYMENT
			, SUM(ETC) AS ETC
			, SUM(ALLOCATION
			+ INCREASE
			+ BORROWING
			+ REPAYMENT
			+ ETC)			AS FINANCIAL
	FROM	PLAN_YEAR_CF_FINANCIAL
	GROUP BY PLAN_YEAR_CF_SEQ, YEARLY_YEAR
)										D ON A.SEQ = D.PLAN_YEAR_CF_SEQ AND B.YEARLY_YEAR = D.YEARLY_YEAR
LEFT OUTER JOIN (
	SELECT	*
	FROM	PLAN_YEAR_CF_BE_CASH
	WHERE	1 = 1
	AND		MONTHLY = '99'
)										E ON A.SEQ = E.PLAN_YEAR_CF_SEQ AND B.YEARLY_YEAR = E.YEARLY_YEAR
LEFT OUTER JOIN (
	SELECT	*
	FROM	PLAN_YEAR_CF_FCF
	WHERE	1 = 1
	AND		MONTHLY = '99'
)										F ON A.SEQ = F.PLAN_YEAR_CF_SEQ AND B.YEARLY_YEAR = F.YEARLY_YEAR
WHERE	1 = 1
AND		A.SEQ = @PlanYearCfSeq;
SELECT  @@ROWCOUNT
";

                    return con.Query<int>(query, entity).First();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return -1;
                }
            }
        }

        public int save(PlanYearCfSummary entity)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<PlanYearCfSummary> selectList(object param)
        {
            {
                using (IDbConnection con = GetHallaDb())
                {
                    try
                    {
                        con.Open();

                        string query = " SELECT * " +
                            " FROM PLAN_YEAR_CF_SUMMARY " +
                            " WHERE PLAN_YEAR_CF_SEQ = @PlanYearCfSeq ";

                        return con.Query<PlanYearCfSummary>(query, param).ToList();
                    }
                    catch (Exception e)
                    {
                        LogUtil.MngError(e.ToString());
                        return null;
                    }
                }
            }
        }

        public PlanYearCfSummary selectOne(object param)
        {
            throw new NotImplementedException();
        }

        public int update(PlanYearCfSummary entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " UPDATE PLAN_YEAR_CF_SUMMARY SET " +
                        // 이부분은 수정하여 사용하세요. 
                        //" , PLAN_YEAR_CF_SEQ = @PlanYearCfSeq" +
                        //" , YEARLY = @Yearly" +
                        //" , YEARLY_YEAR = @YearlyYear" +
                        " CF_SALES = @CfSales" +
                        " , CF_INVESTMENT = @CfInvestment" +
                        " , CF_FINANCIAL = @CfFinancial" +
                        //" , CF_SUM = @CfSum" +
                        " , CF_ENDING_CASH = @CfEndingCash" +
                        " , CF_AVAILABLE_CASH = @CfAvailableCash" +
                        " , FCF1 = @Fcf1" +
                        " , FCF2 = @Fcf2" +
                        " , FCF3 = @Fcf3" +
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

        public IEnumerable<PlanYearCfSummaryExp> selectListpnThisYear(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"

-- 현재년도 계획
SELECT	B.YEARLY_YEAR
		, ISNULL(B.CF_SALES, 0)				AS CF_SALES
		, ISNULL(B.CF_INVESTMENT, 0)		AS CF_INVESTMENT
		, ISNULL(B.CF_FINANCIAL, 0)			AS CF_FINANCIAL
		--, B.CF_SUM
		, ISNULL(B.CF_ENDING_CASH, 0)		AS CF_ENDING_CASH
		, ISNULL(B.CF_AVAILABLE_CASH, 0)	AS CF_AVAILABLE_CASH
		, ISNULL(B.FCF1, 0)					AS FCF1
		, ISNULL(B.FCF2, 0)					AS FCF2
		, ISNULL(B.FCF3, 0)					AS FCF3
		, C.ORG_UNION_SEQ
		, E.UNION_NAME
		, A.ORG_COMPANY_SEQ
		, C.COMPANY_NAME
FROM	PLAN_YEAR_CF						A
LEFT OUTER JOIN PLAN_YEAR_CF_SUMMARY		B ON A.SEQ = B.PLAN_YEAR_CF_SEQ AND B.YEARLY = 'THIS'
LEFT OUTER JOIN ORG_COMPANY					C ON A.ORG_COMPANY_SEQ = C.SEQ
LEFT OUTER JOIN ORG_UNION					E ON C.ORG_UNION_SEQ = E.SEQ
WHERE	1 = 1
AND		A.YEAR_CF_YEAR = @year
AND     A.REGIST_STATUS = " + Define.REGIST_STATUS.GetKey("최종승인") + @"
ORDER BY C.ORG_UNION_SEQ, C.ORD
";

                    return con.Query<PlanYearCfSummaryExp>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.ReportErrorLog(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<PlanYearCfSummaryExp> selectListpnThisYear_NEW(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
                            -- 현재년도 계획
                            SELECT	B.YEARLY_YEAR
		                            , ISNULL(B.CF_SALES, 0)				AS CF_SALES
		                            , ISNULL(B.CF_INVESTMENT, 0)		AS CF_INVESTMENT
		                            , ISNULL(B.CF_FINANCIAL, 0)			AS CF_FINANCIAL
		                            --, B.CF_SUM
		                            , ISNULL(B.CF_ENDING_CASH, 0)		AS CF_ENDING_CASH
		                            , ISNULL(B.CF_AVAILABLE_CASH, 0)	AS CF_AVAILABLE_CASH
		                            , ISNULL(B.FCF1, 0)					AS FCF1
		                            , ISNULL(B.FCF2, 0)					AS FCF2
		                            , ISNULL(B.FCF3, 0)					AS FCF3
		                            , C.ORG_UNION_SEQ
		                            , E.UNION_NAME
		                            , A.ORG_COMPANY_SEQ
		                            , C.COMPANY_NAME
                            FROM	PLAN_YEAR_CF						A
                            LEFT OUTER JOIN PLAN_YEAR_CF_SUMMARY		B ON A.SEQ = B.PLAN_YEAR_CF_SEQ AND B.YEARLY = 'THIS'
                            LEFT OUTER JOIN ORG_COMPANY					C ON A.ORG_COMPANY_SEQ = C.SEQ
                            LEFT OUTER JOIN ORG_UNION					E ON C.ORG_UNION_SEQ = E.SEQ
                            WHERE	1 = 1
                            AND		A.YEAR_CF_YEAR = @year
                            AND     A.REGIST_STATUS = " + Define.REGIST_STATUS.GetKey("최종승인") + @"
                            ORDER BY C.ORG_UNION_SEQ, C.ORD
                            ";

                    return con.Query<PlanYearCfSummaryExp>(query, param).ToList();
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


