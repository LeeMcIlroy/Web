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
    public class PmCashFlowCumulativeRepo : DbCon, IPmCashFlowCumulativeRepo
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
                    string query = " DELETE PM_CASH_FLOW_CUMULATIVE " +
                        " WHERE PM_CASH_FLOW_SEQ = @PmCashFlowSeq";
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

        public int insert(PmCashFlowCumulative entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " INSERT INTO  PM_CASH_FLOW_CUMULATIVE ( " +
                        // 이부분은 수정하여 사용하세요. 
                        " PM_CASH_FLOW_SEQ " +
                        //", SEQ " +
                        ", DIFF " +
                        ", EBITDA " +
                        ", WC_SUM " +
                        ", ETC " +
                        ", NET_CAPEX_SUM " +
                        ", FINANCIAL_COST " +
                        ", FCF2 " +
                        //", F_ALLOCATION " +
                        //", F_INCREASE " +
                        //", F_BORROWING " +
                        //", F_REPAYMENT " +
                        //", F_ETC " +
                        ", FINANCIAL_SUM " +
                        ", CASH_SUM " +
                        ", ENDING_CASH " +
                        ", CREDIT_LINE " +
                        ", AVAILABLE_CASH " +
                    " ) VALUES ( " +
                    " @PmCashFlowSeq " +
                    //", @Seq " +
                    ", @Diff " +
                    ", @Ebitda " +
                    ", @WcSum " +
                    ", @Etc " +
                    ", @NetCapexSum " +
                    ", @FinancialCost " +
                    ", @Fcf2 " +
                    //", @FAllocation " +
                    //", @FIncrease " +
                    //", @FBorrowing " +
                    //", @FRepayment " +
                    //", @FEtc " +
                    ", @FinancialSum " +
                    ", @CashSum " +
                    ", @EndingCash " +
                    ", @CreditLine " +
                    ", @AvailableCash " +
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

        public int save(PmCashFlowCumulative entity)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<PmCashFlowCumulative> selectList(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
SELECT	*
FROM	PM_CASH_FLOW_CUMULATIVE
WHERE	PM_CASH_FLOW_SEQ = @PmCashFlowSeq
";

                    return con.Query<PmCashFlowCumulative>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.ReportErrorLog(e.ToString());
                    return null;
                }
            }
        }

        public PmCashFlowCumulative selectOne(object param)
        {
            throw new NotImplementedException();
        }

        public int update(PmCashFlowCumulative entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " UPDATE PM_CASH_FLOW_CUMULATIVE SET " +
                        // 이부분은 수정하여 사용하세요. 
                        //" , PM_CASH_FLOW_SEQ = @PmCashFlowSeq" +
                        //" , DIFF = @Diff" +
                        " EBITDA = @Ebitda" +
                        " , WC_SUM = @WcSum" +
                        " , ETC = @Etc" +
                        " , NET_CAPEX_SUM = @NetCapexSum" +
                        " , FINANCIAL_COST = @FinancialCost" +
                        " , FCF2 = @Fcf2" +
                        //" , F_ALLOCATION = @FAllocation" +
                        //" , F_INCREASE = @FIncrease" +
                        //" , F_BORROWING = @FBorrowing" +
                        //" , F_REPAYMENT = @FRepayment" +
                        //" , F_ETC = @FEtc" +
                        " , FINANCIAL_SUM = @FinancialSum" +
                        " , CASH_SUM = @CashSum" +
                        " , ENDING_CASH = @EndingCash" +
                        " , CREDIT_LINE = @CreditLine" +
                        " , AVAILABLE_CASH = @AvailableCash" +
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

        public IEnumerable<PmCashFlowCumulativeExcel> selectListExcel(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    // 순서 변경
                    string query = @"
SELECT	A.CASH_FLOW_YEAR
		, A.MONTHLY
		, B.DIFF
		, B.EBITDA
		, B.WC_SUM
		, B.ETC
		, B.NET_CAPEX_SUM
		, B.FINANCIAL_COST
		, B.FCF2
		, B.FINANCIAL_SUM
		, B.CASH_SUM
		, B.ENDING_CASH
		, B.CREDIT_LINE
		, B.AVAILABLE_CASH
		, A.ORG_COMPANY_SEQ
		, C.COMPANY_NAME
FROM	PM_CASH_FLOW				A
INNER JOIN PM_CASH_FLOW_CUMULATIVE	B ON A.SEQ = B.PM_CASH_FLOW_SEQ
LEFT OUTER JOIN ORG_COMPANY			C ON A.ORG_COMPANY_SEQ = C.SEQ
WHERE	1 = 1
AND		A.CASH_FLOW_YEAR = @year
AND		A.MONTHLY = @mm
ORDER BY C.ORG_UNION_SEQ, C.ORD
";

                    return con.Query<PmCashFlowCumulativeExcel>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.ReportErrorLog(e.ToString());
                    return null;
                }
            }
        }



        public IEnumerable<PmCashFlowCumulativeExp> selectListpmLastYear(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"

-- 작년도실적 
SELECT	A.CASH_FLOW_YEAR
		--, ISNULL(B.DIFF, 20)				AS DIFF
		, ISNULL(B.EBITDA, 0.00)			
		+ ISNULL(B.WC_SUM, 0.00)			
		+ ISNULL(B.ETC, 0.00)				
		+ ISNULL(B.FINANCIAL_COST, 0.00)	AS CF_SALES

		, ISNULL(B.NET_CAPEX_SUM, 0.00)		AS CF_INVESTMENT
		, ISNULL(B.FINANCIAL_SUM, 0.00)		AS CF_FINANCIAL
		--, ISNULL(B.CASH_SUM, 0.00)			AS CASH_SUM
		, ISNULL(B.ENDING_CASH, 0.00)		AS CF_ENDING_CASH
		--, ISNULL(B.CREDIT_LINE, 0.00)		AS CREDIT_LINE
		, ISNULL(B.AVAILABLE_CASH, 0.00)	AS CF_AVAILABLE_CASH
		, ISNULL(B.FCF2, 0.00)				AS FCF2
		, C.ORG_UNION_SEQ
		, E.UNION_NAME
		, A.ORG_COMPANY_SEQ
		, C.COMPANY_NAME
FROM	PM_CASH_FLOW						A
LEFT OUTER JOIN PM_CASH_FLOW_CUMULATIVE		B ON A.SEQ = B.PM_CASH_FLOW_SEQ
LEFT OUTER JOIN ORG_COMPANY					C ON A.ORG_COMPANY_SEQ = C.SEQ
LEFT OUTER JOIN ORG_UNION					E ON C.ORG_UNION_SEQ = E.SEQ
WHERE	1 = 1
AND		A.CASH_FLOW_YEAR = @year - 1
AND		A.MONTHLY = '12'
AND     A.REGIST_STATUS = " + Define.REGIST_STATUS.GetKey("최종승인") + @"
AND		B.DIFF = " + Define.DIFF.GetKey("실적") + @"
";

                    return con.Query<PmCashFlowCumulativeExp>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.ReportErrorLog(e.ToString());
                    return null;
                }
            }
        }

        public PmCashFlowCumulative selectOneCumMonPn(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
SELECT	A.YEAR_CF_YEAR
		, SUM(B.OPERATION_PROFIT
		+ B.DEPRECIATION_COST
		+ B.CORP_TAX)						AS EBITDA
		, SUM(B.AR + B.INV + B.AP)			AS WC_SUM
		, SUM(B.ETC)						AS ETC
		, SUM(C.ASSETS
		+ C.EQUITY_INVESTMENT
		+ C.ASSETS_SALE
		+ C.ETC)							AS NET_CAPEX_SUM
		, SUM(B.INTEREST_EXPENSE
		+ B.INTEREST_INCOME)				AS FINANCIAL_COST
		, SUM(D.FCF2)						AS FCF2
		, SUM(E.ALLOCATION
		+ E.INCREASE
		+ E.BORROWING
		+ E.REPAYMENT
		+ E.ETC)							AS FINANCIAL_SUM
		, SUM(D.CASH_SUM)					AS CASH_SUM
		, SUM(F.ENDING_CASH)				AS ENDING_CASH
		, SUM(F.CREDIT_LINE)				AS CREDIT_LINE
		, SUM(F.AVAILABLE_CASH)				AS AVAILABLE_CASH
FROM	PLAN_YEAR_CF						A
LEFT OUTER JOIN PLAN_YEAR_CF_SALES			B ON A.SEQ = B.PLAN_YEAR_CF_SEQ AND A.YEAR_CF_YEAR = B.YEARLY_YEAR
LEFT OUTER JOIN PLAN_YEAR_CF_INVESTMENT		C ON A.SEQ = C.PLAN_YEAR_CF_SEQ AND A.YEAR_CF_YEAR = C.YEARLY_YEAR AND B.MONTHLY = C.MONTHLY
LEFT OUTER JOIN PLAN_YEAR_CF_FCF			D ON A.SEQ = D.PLAN_YEAR_CF_SEQ AND A.YEAR_CF_YEAR = D.YEARLY_YEAR AND B.MONTHLY = D.MONTHLY
LEFT OUTER JOIN PLAN_YEAR_CF_FINANCIAL		E ON A.SEQ = E.PLAN_YEAR_CF_SEQ AND A.YEAR_CF_YEAR = E.YEARLY_YEAR AND B.MONTHLY = E.MONTHLY
LEFT OUTER JOIN PLAN_YEAR_CF_BE_CASH		F ON A.SEQ = F.PLAN_YEAR_CF_SEQ AND A.YEAR_CF_YEAR = F.YEARLY_YEAR AND B.MONTHLY = F.MONTHLY
WHERE	1 = 1
AND		A.YEAR_CF_YEAR = @YearCfYear
AND		A.ORG_COMPANY_SEQ = @OrgCompanySeq
AND		B.MONTHLY <= @Monthly
GROUP BY A.YEAR_CF_YEAR
";
                    return con.Query<PmCashFlowCumulative>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public PmCashFlowCumulative selectOneCumMonPm(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
SELECT	A.CASH_FLOW_YEAR
		, B.OPERATION_PROFIT
		+ B.DEPRECIATION_COST
		+ B.CORP_TAX						AS EBITDA
		, B.AR + B.INV + B.AP				AS WC_SUM
		, B.ETC								AS ETC
		, C.ASSETS
		+ C.EQUITY_INVESTMENT
		+ C.ASSETS_SALE
		+ C.INVESTMENT_ETC								
											AS NET_CAPEX_SUM
		, B.INTEREST_EXPENSE
		+ B.INTEREST_INCOME					AS FINANCIAL_COST
		, D.FCF2							AS FCF2
		, E.ALLOCATION
		+ E.INCREASE
		+ E.BORROWING
		+ E.REPAYMENT
		+ E.ETC								AS FINANCIAL_SUM
		, D.CASH_SUM						AS CASH_SUM
		, F.ENDING_CASH						AS ENDING_CASH
		, F.CREDIT_LINE						AS CREDIT_LINE
		, F.AVAILABLE_CASH					AS AVAILABLE_CASH
FROM	PM_CASH_FLOW						A
LEFT OUTER JOIN PM_CASH_FLOW_SALES			B ON A.SEQ = B.PM_CASH_FLOW_SEQ
LEFT OUTER JOIN PM_CASH_FLOW_INVESTMENT		C ON A.SEQ = C.PM_CASH_FLOW_SEQ AND B.CUMULATIVE = C.CUMULATIVE
LEFT OUTER JOIN PM_CASH_FLOW_FCF			D ON A.SEQ = D.PM_CASH_FLOW_SEQ AND B.CUMULATIVE = D.CUMULATIVE
LEFT OUTER JOIN PM_CASH_FLOW_FINANCIAL		E ON A.SEQ = E.PM_CASH_FLOW_SEQ AND B.CUMULATIVE = E.CUMULATIVE
LEFT OUTER JOIN PM_CASH_FLOW_BE_CASH		F ON A.SEQ = F.PM_CASH_FLOW_SEQ AND B.CUMULATIVE = F.CUMULATIVE
WHERE	1 = 1
AND		A.SEQ = @Seq
AND		B.CUMULATIVE = " + Define.CUMULATIVE.GetKey("누계 실적") + @"
";
                    return con.Query<PmCashFlowCumulative>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public PmCashFlowCumulative selectListLastYear(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
SELECT	*
FROM	PM_CASH_FLOW					A
LEFT OUTER JOIN PM_CASH_FLOW_CUMULATIVE	B ON A.SEQ = B.PM_CASH_FLOW_SEQ
WHERE	1 = 1
AND		A.CASH_FLOW_YEAR = @Year - 1
AND		A.ORG_COMPANY_SEQ = @OrgCompanySeq
AND		A.MONTHLY = '12'
AND		B.DIFF = 20
";

                    return con.Query<PmCashFlowCumulative>(query, param).First();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<PmCashFlowCumulative> selectListLastYear2(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
SELECT	*
		, OC.ORG_UNION_SEQ
		, OU.UNION_NAME
		, OC.COMPANY_NAME
FROM	PM_CASH_FLOW					A
LEFT OUTER JOIN PM_CASH_FLOW_CUMULATIVE	B ON A.SEQ = B.PM_CASH_FLOW_SEQ
LEFT OUTER JOIN ORG_COMPANY					OC ON A.ORG_COMPANY_SEQ = OC.SEQ
LEFT OUTER JOIN ORG_UNION					OU ON OC.ORG_UNION_SEQ = OU.SEQ
WHERE	1 = 1
AND		A.CASH_FLOW_YEAR = @Year - 1
--AND		A.ORG_COMPANY_SEQ = @OrgCompanySeq
AND		A.MONTHLY = '12'
AND		B.DIFF = 20
";

                    return con.Query<PmCashFlowCumulative>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<PmCashFlowCumulativeExp> selectListLastYearPn(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"

SELECT	A.CASH_FLOW_YEAR		
		, B.SALES               AS CF_SALES
		, C.INVESTMENT          AS CF_INVESTMENT
		, D.FINANCIAL           AS CF_FINANCIAL
		--, B.SALES
		--+ C.INVESTMENT
		--+ D.FINANCIAL			AS CF_SUM
		, E.ENDING_CASH         AS CF_ENDING_CASH
		, E.AVAILABLE_CASH      AS CF_AVAILABLE_CASH
		, F.FCF1
		, F.FCF2
		, F.FCF3
FROM	PM_CASH_FLOW					A
LEFT OUTER JOIN (
	SELECT	PM_CASH_FLOW_SEQ
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
	FROM	PM_CASH_FLOW_SALES
	WHERE	CUMULATIVE = " + Define.DIFF.GetKey("실적") + @"
	GROUP BY PM_CASH_FLOW_SEQ
)		B ON A.SEQ = B.PM_CASH_FLOW_SEQ
LEFT OUTER JOIN (
	SELECT	PM_CASH_FLOW_SEQ
			, SUM(ASSETS) AS ASSETS
			, SUM(EQUITY_INVESTMENT) AS EQUITY_INVESTMENT
			, SUM(ASSETS_SALE) AS ASSETS_SALE
			, SUM(ASSETS
			+ EQUITY_INVESTMENT
			+ ASSETS_SALE)			AS INVESTMENT
	FROM	PM_CASH_FLOW_INVESTMENT
	WHERE	CUMULATIVE = '20'
	GROUP BY PM_CASH_FLOW_SEQ
)		C ON A.SEQ = C.PM_CASH_FLOW_SEQ
LEFT OUTER JOIN (
	SELECT	PM_CASH_FLOW_SEQ
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
	FROM	PM_CASH_FLOW_FINANCIAL
	WHERE	CUMULATIVE = " + Define.DIFF.GetKey("실적") + @"
	GROUP BY PM_CASH_FLOW_SEQ
)		D ON A.SEQ = D.PM_CASH_FLOW_SEQ
LEFT OUTER JOIN (
	SELECT	*
	FROM	PM_CASH_FLOW_BE_CASH
	WHERE	CUMULATIVE = " + Define.DIFF.GetKey("실적") + @"
)		E ON A.SEQ = E.PM_CASH_FLOW_SEQ
LEFT OUTER JOIN (
	SELECT	*
	FROM	PM_CASH_FLOW_FCF
	WHERE	CUMULATIVE = " + Define.DIFF.GetKey("실적") + @"
)		F ON A.SEQ = F.PM_CASH_FLOW_SEQ
WHERE	1 = 1
AND		A.CASH_FLOW_YEAR = @YearlyYear - 1
AND		A.MONTHLY = '12'
AND		A.ORG_COMPANY_SEQ = @OrgCompanySeq
";

                    return con.Query<PmCashFlowCumulativeExp>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.ReportErrorLog(e.ToString());
                    return null;
                }
            }

        }

        public IEnumerable<PmCashFlowCumulativeExp> selectListLastYearPn2(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"

SELECT	A.CASH_FLOW_YEAR		
		, B.SALES               AS CF_SALES
		, C.INVESTMENT          AS CF_INVESTMENT
		, D.FINANCIAL           AS CF_FINANCIAL
		--, B.SALES
		--+ C.INVESTMENT
		--+ D.FINANCIAL			AS CF_SUM
		, E.ENDING_CASH         AS CF_ENDING_CASH
		, E.AVAILABLE_CASH      AS CF_AVAILABLE_CASH
		, F.FCF1
		, F.FCF2
		, F.FCF3
		, OC.ORG_UNION_SEQ
		, OU.UNION_NAME
		, A.ORG_COMPANY_SEQ
		, OC.COMPANY_NAME
FROM	PM_CASH_FLOW					A
LEFT OUTER JOIN (
	SELECT	PM_CASH_FLOW_SEQ
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
	FROM	PM_CASH_FLOW_SALES
	WHERE	CUMULATIVE = " + Define.DIFF.GetKey("실적") + @"
	GROUP BY PM_CASH_FLOW_SEQ
)		B ON A.SEQ = B.PM_CASH_FLOW_SEQ
LEFT OUTER JOIN (
	SELECT	PM_CASH_FLOW_SEQ
			, SUM(ASSETS) AS ASSETS
			, SUM(EQUITY_INVESTMENT) AS EQUITY_INVESTMENT
			, SUM(ASSETS_SALE) AS ASSETS_SALE
			, SUM(ASSETS
			+ EQUITY_INVESTMENT
			+ ASSETS_SALE)			AS INVESTMENT
	FROM	PM_CASH_FLOW_INVESTMENT
	WHERE	CUMULATIVE = '20'
	GROUP BY PM_CASH_FLOW_SEQ
)		C ON A.SEQ = C.PM_CASH_FLOW_SEQ
LEFT OUTER JOIN (
	SELECT	PM_CASH_FLOW_SEQ
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
	FROM	PM_CASH_FLOW_FINANCIAL
	WHERE	CUMULATIVE = " + Define.DIFF.GetKey("실적") + @"
	GROUP BY PM_CASH_FLOW_SEQ
)		D ON A.SEQ = D.PM_CASH_FLOW_SEQ
LEFT OUTER JOIN (
	SELECT	*
	FROM	PM_CASH_FLOW_BE_CASH
	WHERE	CUMULATIVE = " + Define.DIFF.GetKey("실적") + @"
)		E ON A.SEQ = E.PM_CASH_FLOW_SEQ
LEFT OUTER JOIN (
	SELECT	*
	FROM	PM_CASH_FLOW_FCF
	WHERE	CUMULATIVE = " + Define.DIFF.GetKey("실적") + @"
)		F ON A.SEQ = F.PM_CASH_FLOW_SEQ
LEFT OUTER JOIN ORG_COMPANY					OC ON A.ORG_COMPANY_SEQ = OC.SEQ
LEFT OUTER JOIN ORG_UNION					OU ON OC.ORG_UNION_SEQ = OU.SEQ
WHERE	1 = 1
AND		A.CASH_FLOW_YEAR = @YearlyYear - 1
AND		A.MONTHLY = '12'
--AND		A.ORG_COMPANY_SEQ = @OrgCompanySeq
";

                    return con.Query<PmCashFlowCumulativeExp>(query, param).ToList();
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