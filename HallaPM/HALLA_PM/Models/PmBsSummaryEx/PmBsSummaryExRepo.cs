using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using Dapper;
using HALLA_PM.Core;
using HALLA_PM.Util;
using System.Data;

namespace HALLA_PM.Models
{
    public class PmBsSummaryExRepo : DbCon, IPmBsSummaryExRepo
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
                    string query = " DELETE PM_BS_SUMMARY_EX " +
                        " WHERE PM_BS_SEQ = @PmBsSeq ";
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

        public int insert(PmBsSummaryEx entity)
        {
            throw new NotImplementedException();
        }

        public int insertCum(PmBsSummaryEx entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = @" 

INSERT INTO PM_BS_SUMMARY_EX
( PM_BS_SEQ, ASSETS, CURRENT_ASSETS, LIABILITIES, CURRENT_LIABILITIES
	, CAPITAL, CASH, LOAN, LIABILITIES_RATE, AFTER_TAX_OPERATION_PROFIT, PAIN_IN_CAPITAL, ROIC
	, AR, AR_TO_DAYS, AP, AP_TO_DAYS, INVENTORY, INVENTORY_TO_DAYS )
SELECT	B.PM_BS_SEQ
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
FROM	PM_BS_EX						A
LEFT OUTER JOIN PM_BS_BSHEET_EX			B ON A.SEQ = B.PM_BS_SEQ
LEFT OUTER JOIN PM_BS_ROIC_EX			C ON A.SEQ = C.PM_BS_SEQ 
LEFT OUTER JOIN PM_BS_W_CAPITAL_EX		D ON A.SEQ = D.PM_BS_SEQ
LEFT OUTER JOIN PM_BS_W_CAPITAL_REG_EX	E ON A.SEQ = E.PM_BS_SEQ
WHERE	1 = 1
AND		A.SEQ = @PmBsSeq
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

        public int save(PmBsSummaryEx entity)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<PmBsSummaryEx> selectList(object param)
        {
            throw new NotImplementedException();
        }
        public IEnumerable<PmBsSummaryExExp> selectListBefore(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
SELECT	A.BS_YEAR
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
AND		A.BS_YEAR = @YearlyYear - 1
AND		A.MONTHLY = '12'

";

                    return con.Query<PmBsSummaryExExp>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public PmBsSummaryEx selectOne(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = " SELECT * " +
                        " FROM PM_BS_SUMMARY_EX " +
                        " WHERE PM_BS_SEQ = @PmBsSeq ";

                    return con.Query<PmBsSummaryEx>(query, param).First();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public PmBsSummaryEx selectOneYear(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
SELECT	*
FROM	PM_BS_EX				A
LEFT OUTER JOIN PM_BS_SUMMARY_EX	B ON A.SEQ = B.PM_BS_SEQ
WHERE BS_YEAR = @BsYear
    AND MONTHLY = @Monthly
    AND ORG_COMPANY_SEQ = @OrgCompanySeq ";

                    return con.Query<PmBsSummaryEx>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public int update(PmBsSummaryEx entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " UPDATE PM_BS_SUMMARY_EX SET " +
                        // 이부분은 수정하여 사용하세요. 
                        //" , PM_BS_SEQ = @PmBsSeq" +
                        " ASSETS = @Assets" +
                        //" , CURRENT_ASSETS = @CurrentAssets" +
                        " , LIABILITIES = @Liabilities" +
                        //" , CURRENT_LIABILITIES = @CurrentLiabilities" +
                        " , CAPITAL = @Capital" +
                        " , CASH = @Cash" +
                        " , LOAN = @Loan" +
                        //" , LIABILITIES_RATE = @LiabilitiesRate" +
                        " , AFTER_TAX_OPERATION_PROFIT = @AfterTaxOperationProfit" +
                        " , PAIN_IN_CAPITAL = @PainInCapital" +
                        //" , ROIC = @Roic" +
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

        public IEnumerable<PmBsSummaryEx> selectListPmThisYear(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
SELECT	A.BS_YEAR
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
AND     A.REGIST_STATUS = " + Define.REGIST_STATUS.GetKey("최종승인") + @"
";

                    return con.Query<PmBsSummaryEx>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<PmBsSummaryEx> selectListPmLastYear(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
SELECT	A.BS_YEAR
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
LEFT OUTER JOIN PM_BS_SUMMARY_EX								B ON A.SEQ = B.PM_BS_SEQ
WHERE	1 = 1
AND		A.BS_YEAR = @year - 1
AND		A.MONTHLY = '12'
AND     A.REGIST_STATUS = " + Define.REGIST_STATUS.GetKey("최종승인") + @"
";

                    return con.Query<PmBsSummaryEx>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<PmBsSummaryEx> selectListPnThisYear(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
SELECT	A.YEAR_BS_YEAR									AS BS_YEAR
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
AND     A.REGIST_STATUS = " + Define.REGIST_STATUS.GetKey("최종승인") + @"
";

                    return con.Query<PmBsSummaryEx>(query, param).ToList();
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