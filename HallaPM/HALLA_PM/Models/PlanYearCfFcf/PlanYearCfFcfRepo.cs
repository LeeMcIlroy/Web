using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Data;
using Dapper;
using HALLA_PM.Util;

namespace HALLA_PM.Models
{
    public class PlanYearCfFcfRepo : DbCon, IPlanYearCfFcfRepo
    {
        public int count(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " SELECT COUNT(*) FROM PLAN_YEAR_CF_FCF ";
                    return con.Query<int>(query, param).First();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return -1;
                }
            }
        }
        public int count(object param, string where)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " SELECT COUNT(*) FROM PLAN_YEAR_CF_FCF " + where;
                    return con.Query<int>(query, param).First();
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
                    string query = " DELETE PLAN_YEAR_CF_FCF " +
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

        public int insertCum(PlanYearCfFcf entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
INSERT INTO PLAN_YEAR_CF_FCF
( PLAN_YEAR_CF_SEQ, YEARLY_YEAR, MONTHLY, FCF1, FCF2, FCF3, CASH_SUM, SALES, FCF_SALES)
SELECT	A.SEQ
		--, A.YEAR_CF_YEAR
		--, A.ORG_COMPANY_SEQ
		, B.YEARLY_YEAR
		, B.MONTHLY
		, B.OPERATION_PROFIT
		+ B.DEPRECIATION_COST
		+ B.CORP_TAX				-- 세후EBITDA = 영업이익 + 감가비 + 법인세비율
		+ B.AR
		+ B.INV
		+ B.AP						-- WC변동소계 = AR + INV + AP
		+ B.ETC						-- 기타(영업활동)
		+ C.ASSETS
		+ C.EQUITY_INVESTMENT
		+ C.ASSETS_SALE
		+ C.ETC						-- NET_CAPEX소계 = 유형/무형자산 + 지분투자 + 자산매각 + 기타
									AS FCF1		-- FCF1 = 세후EBITDA + WC변동소계 + 기타 + NET_CAPEX소계
		, B.OPERATION_PROFIT
		+ B.DEPRECIATION_COST
		+ B.CORP_TAX				-- 세후EBITDA
		+ B.AR
		+ B.INV
		+ B.AP						-- WC변동소계
		+ B.ETC						-- 기타
		+ C.ASSETS
		+ C.EQUITY_INVESTMENT
		+ C.ASSETS_SALE
		+ C.ETC						-- NET_CAPEX소계
		+ B.INTEREST_EXPENSE
		+ B.INTEREST_INCOME			-- 순금융비용 = 이자비용 + 이자수익
									AS FCF2		-- FCF2 = FCF1 + 순금융비용
		, B.OPERATION_PROFIT
		+ B.DEPRECIATION_COST
		+ B.CORP_TAX				-- 세후EBITDA
		+ B.AR
		+ B.INV
		+ B.AP						-- WC변동소계
		+ B.ETC						-- 기타
		+ C.ASSETS
		+ C.EQUITY_INVESTMENT
		+ C.ASSETS_SALE
		+ C.ETC						-- NET_CAPEX소계
		+ B.INTEREST_EXPENSE
		+ B.INTEREST_INCOME			-- 순금융비용 = 이자비용 + 이자수익
		+ D.ALLOCATION				-- 배당
									AS FCF3		-- FCF3 = FCF2 + 배당
		, B.OPERATION_PROFIT
		+ B.DEPRECIATION_COST
		+ B.CORP_TAX				-- 세후EBITDA
		+ B.AR
		+ B.INV
		+ B.AP						-- WC변동소계
		+ B.ETC						-- 기타
		+ C.ASSETS
		+ C.EQUITY_INVESTMENT
		+ C.ASSETS_SALE
		+ C.ETC						-- NET_CAPEX소계
		+ B.INTEREST_EXPENSE
		+ B.INTEREST_INCOME			-- 순금융비용 = 이자비용 + 이자수익
		+ D.ALLOCATION
		+ D.INCREASE
		+ D.BORROWING
		+ D.REPAYMENT
		+ D.ETC						-- 재무활동소계 = 배당 + 증자 + 차입 + 상환 + 기타
									AS CASH_SUM	-- 현금흐름함계 = FCF2 + 재무활동소계
		, ISNULL(E.SALES, 0)		AS SALES
		, CASE WHEN ISNULL(E.SALES, 0) = 0 THEN 0 ELSE
				ROUND((B.OPERATION_PROFIT
				+ B.DEPRECIATION_COST
				+ B.CORP_TAX				-- 세후EBITDA
				+ B.AR
				+ B.INV
				+ B.AP						-- WC변동소계
				+ B.ETC						-- 기타
				+ C.ASSETS
				+ C.EQUITY_INVESTMENT
				+ C.ASSETS_SALE
				+ C.ETC						-- NET_CAPEX소계
				+ B.INTEREST_EXPENSE
				+ B.INTEREST_INCOME			-- 순금융비용 = 이자비용 + 이자수익	
				) / E.SALES, 2) END		AS FCF_SALES

FROM	PLAN_YEAR_CF						A
LEFT OUTER JOIN PLAN_YEAR_CF_SALES			B ON A.SEQ = B.PLAN_YEAR_CF_SEQ
LEFT OUTER JOIN PLAN_YEAR_CF_INVESTMENT		C ON B.PLAN_YEAR_CF_SEQ = C.PLAN_YEAR_CF_SEQ
											AND B.YEARLY_YEAR = C.YEARLY_YEAR
											AND B.MONTHLY = C.MONTHLY
LEFT OUTER JOIN PLAN_YEAR_CF_FINANCIAL		D ON B.PLAN_YEAR_CF_SEQ = D.PLAN_YEAR_CF_SEQ
											AND B.YEARLY_YEAR = D.YEARLY_YEAR
											AND B.MONTHLY = D.MONTHLY
LEFT OUTER JOIN (
	SELECT	A.MONTHLY_PAL_YEAR
			, A.ORG_COMPANY_SEQ
			, A.MONTHLY_PAL_YEAR	AS YEARLY_YEAR
			, B.MONTHLY
			, B.SALES
	FROM	PLAN_MONTHLY_PAL								A
	LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS_MONTHLY_SUM	B ON A.SEQ = B.PLAN_MONTHLY_PAL_SEQ
	WHERE	1 = 1
	UNION
	SELECT	A.YEAR_PAL_YEAR			AS MONTHLY_PAL_YEAR
			, A.ORG_COMPANY_SEQ
			, B.YEARLY_YEAR
			, '99'					AS MONTHLY
			, B.SALES
	FROM	PLAN_YEAR_PAL							A
	LEFT OUTER JOIN PLAN_YEAR_PAL_BUSINESS_SUMMARY	B ON A.SEQ = B.PLAN_YEAR_PAL_SEQ
	WHERE	1 = 1
)											E ON A.YEAR_CF_YEAR = E.MONTHLY_PAL_YEAR
											AND A.ORG_COMPANY_SEQ = E.ORG_COMPANY_SEQ
											AND B.YEARLY_YEAR = E.YEARLY_YEAR
											AND B.MONTHLY = E.MONTHLY
											
WHERE	A.SEQ = @PlanYearCfSeq

UNION

SELECT	A.SEQ
		--, A.YEAR_CF_YEAR
		--, A.ORG_COMPANY_SEQ
		, B.YEARLY_YEAR
		, '99'						AS MONTHLY
		, SUM(B.OPERATION_PROFIT
		+ B.DEPRECIATION_COST
		+ B.CORP_TAX				-- 세후EBITDA = 영업이익 + 감가비 + 법인세비율
		+ B.AR
		+ B.INV
		+ B.AP						-- WC변동소계 = AR + INV + AP
		+ B.ETC						-- 기타(영업활동)
		+ C.ASSETS
		+ C.EQUITY_INVESTMENT
		+ C.ASSETS_SALE
		+ C.ETC)						-- NET_CAPEX소계 = 유형/무형자산 + 지분투자 + 자산매각 + 기타
									AS FCF1		-- FCF1 = 세후EBITDA + WC변동소계 + 기타 + NET_CAPEX소계
		, SUM(B.OPERATION_PROFIT
		+ B.DEPRECIATION_COST
		+ B.CORP_TAX				-- 세후EBITDA
		+ B.AR
		+ B.INV
		+ B.AP						-- WC변동소계
		+ B.ETC						-- 기타
		+ C.ASSETS
		+ C.EQUITY_INVESTMENT
		+ C.ASSETS_SALE
		+ C.ETC						-- NET_CAPEX소계
		+ B.INTEREST_EXPENSE
		+ B.INTEREST_INCOME)			-- 순금융비용 = 이자비용 + 이자수익
									AS FCF2		-- FCF2 = FCF1 + 순금융비용
		, SUM(B.OPERATION_PROFIT
		+ B.DEPRECIATION_COST
		+ B.CORP_TAX				-- 세후EBITDA
		+ B.AR
		+ B.INV
		+ B.AP						-- WC변동소계
		+ B.ETC						-- 기타
		+ C.ASSETS
		+ C.EQUITY_INVESTMENT
		+ C.ASSETS_SALE
		+ C.ETC						-- NET_CAPEX소계
		+ B.INTEREST_EXPENSE
		+ B.INTEREST_INCOME			-- 순금융비용 = 이자비용 + 이자수익
		+ D.ALLOCATION)				-- 배당
									AS FCF3		-- FCF3 = FCF2 + 배당
		, SUM(B.OPERATION_PROFIT
		+ B.DEPRECIATION_COST
		+ B.CORP_TAX				-- 세후EBITDA
		+ B.AR
		+ B.INV
		+ B.AP						-- WC변동소계
		+ B.ETC						-- 기타
		+ C.ASSETS
		+ C.EQUITY_INVESTMENT
		+ C.ASSETS_SALE
		+ C.ETC						-- NET_CAPEX소계
		+ B.INTEREST_EXPENSE
		+ B.INTEREST_INCOME			-- 순금융비용 = 이자비용 + 이자수익
		+ D.ALLOCATION
		+ D.INCREASE
		+ D.BORROWING
		+ D.REPAYMENT
		+ D.ETC)						-- 재무활동소계 = 배당 + 증자 + 차입 + 상환 + 기타
									AS CASH_SUM	-- 현금흐름함계 = FCF2 + 재무활동소계
		, SUM(ISNULL(E.SALES, 0))		AS SALES
		, CASE WHEN SUM(ISNULL(E.SALES, 0)) = 0 THEN 0 ELSE
				ROUND(SUM(B.OPERATION_PROFIT
				+ B.DEPRECIATION_COST
				+ B.CORP_TAX				-- 세후EBITDA
				+ B.AR
				+ B.INV
				+ B.AP						-- WC변동소계
				+ B.ETC						-- 기타
				+ C.ASSETS
				+ C.EQUITY_INVESTMENT
				+ C.ASSETS_SALE
				+ C.ETC						-- NET_CAPEX소계
				+ B.INTEREST_EXPENSE
				+ B.INTEREST_INCOME			-- 순금융비용 = 이자비용 + 이자수익	
				) / SUM(E.SALES), 2) END		AS FCF_SALES -- FCF2 / SALES

FROM	PLAN_YEAR_CF						A
LEFT OUTER JOIN PLAN_YEAR_CF_SALES			B ON A.SEQ = B.PLAN_YEAR_CF_SEQ
LEFT OUTER JOIN PLAN_YEAR_CF_INVESTMENT		C ON B.PLAN_YEAR_CF_SEQ = C.PLAN_YEAR_CF_SEQ
											AND B.YEARLY_YEAR = C.YEARLY_YEAR
											AND B.MONTHLY = C.MONTHLY
LEFT OUTER JOIN PLAN_YEAR_CF_FINANCIAL		D ON B.PLAN_YEAR_CF_SEQ = D.PLAN_YEAR_CF_SEQ
											AND B.YEARLY_YEAR = D.YEARLY_YEAR
											AND B.MONTHLY = D.MONTHLY
LEFT OUTER JOIN (
	SELECT	A.MONTHLY_PAL_YEAR
			, A.ORG_COMPANY_SEQ
			, A.MONTHLY_PAL_YEAR	AS YEARLY_YEAR
			, B.MONTHLY
			, B.SALES
	FROM	PLAN_MONTHLY_PAL								A
	LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS_MONTHLY_SUM	B ON A.SEQ = B.PLAN_MONTHLY_PAL_SEQ
	WHERE	1 = 1
	UNION
	SELECT	A.YEAR_PAL_YEAR			AS MONTHLY_PAL_YEAR
			, A.ORG_COMPANY_SEQ
			, B.YEARLY_YEAR
			, '99'					AS MONTHLY
			, B.SALES
	FROM	PLAN_YEAR_PAL							A
	LEFT OUTER JOIN PLAN_YEAR_PAL_BUSINESS_SUMMARY	B ON A.SEQ = B.PLAN_YEAR_PAL_SEQ
	WHERE	1 = 1
)											E ON A.YEAR_CF_YEAR = E.MONTHLY_PAL_YEAR
											AND A.ORG_COMPANY_SEQ = E.ORG_COMPANY_SEQ
											AND B.YEARLY_YEAR = E.YEARLY_YEAR
											AND B.MONTHLY = E.MONTHLY
											
WHERE	A.SEQ = @PlanYearCfSeq
AND		B.YEARLY_YEAR = @YearlyYear
GROUP BY A.SEQ, B.YEARLY_YEAR
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

        public int insert(PlanYearCfFcf entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " INSERT INTO  PLAN_YEAR_CF_FCF ( " +
                        // 이부분은 수정하여 사용하세요. 
                        " PLAN_YEAR_CF_SEQ " +
                        ", YEARLY_YEAR " +
                        ", MONTHLY " +
                        ", FCF1 " +
                        ", FCF2 " +
                        ", FCF3 " +
                        ", CASH_SUM " +
                        //", SALES " +
                        ", FCF_SALES " +
                    " ) VALUES ( " +
                    " @PlanYearCfSeq " +
                    ", @YearlyYear " +
                    ", @Monthly " +
                    ", @Fcf1 " +
                    ", @Fcf2 " +
                    ", @Fcf3 " +
                    ", @CashSum " +
                    //", @Sales " +
                    ", @FcfSales " +
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

        public int save(PlanYearCfFcf entity)
        {
            var item = selectOne(entity);
            if (item == null)
            {
                return insert(entity);
            }
            else
            {
                return update(entity);
            }
        }

        public IEnumerable<PlanYearCfFcf> selectList(object param)
        {
            {
                using (IDbConnection con = GetHallaDb())
                {
                    try
                    {
                        con.Open();

                        string query = " SELECT * " +
                            " FROM PLAN_YEAR_CF_FCF " +
                            " WHERE PLAN_YEAR_CF_SEQ = @PlanYearCfSeq ";

                        return con.Query<PlanYearCfFcf>(query, param).ToList();
                    }
                    catch (Exception e)
                    {
                        LogUtil.MngError(e.ToString());
                        return null;
                    }
                }
            }
        }

        public IEnumerable<PlanYearCfFcf> selectListYear(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
SELECT	*
FROM	PLAN_YEAR_CF				A
LEFT OUTER JOIN PLAN_YEAR_CF_FCF	B ON A.SEQ = B.PLAN_YEAR_CF_SEQ AND A.YEAR_CF_YEAR = B.YEARLY_YEAR
WHERE	A.YEAR_CF_YEAR = @YearCfYear
AND		A.ORG_COMPANY_SEQ = @OrgCompanySeq
";

                    return con.Query<PlanYearCfFcf>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public PlanYearCfFcf selectOne(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = " SELECT * " +
                        " FROM PLAN_YEAR_CF_FCF " +
                        " WHERE SEQ = @Seq ";

                    return con.Query<PlanYearCfFcf>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public int update(PlanYearCfFcf entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " UPDATE PLAN_YEAR_CF_FCF SET " +
                        // 이부분은 수정하여 사용하세요. 
                        //" , PLAN_YEAR_CF_SEQ = @PlanYearCfSeq" +
                        //" , YEARLY_YEAR = @YearlyYear" +
                        //" , MONTHLY = @Monthly" +
                        " , FCF1 = @Fcf1" +
                        " , FCF2 = @Fcf2" +
                        " , FCF3 = @Fcf3" +
                        " , CASH_SUM = @CashSum" +
                        //" , SALES = @Sales" +
                        " , FCF_SALES = @FcfSales" +
                        " WHERE SEQ = @Seq" +
                    // 이부분은 수정하여 사용하세요. 
                    "); SELECT @@ROWCOUNT";
                    return con.Query<int>(query, entity).First();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return -1;
                }
            }
        }

        public int update2(PlanYearCfFcf entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " UPDATE PLAN_YEAR_CF_FCF SET " +
                        // 이부분은 수정하여 사용하세요. 
                        //" , PLAN_YEAR_CF_SEQ = @PlanYearCfSeq" +
                        //" , YEARLY_YEAR = @YearlyYear" +
                        //" , MONTHLY = @Monthly" +
                        //" , FCF1 = @Fcf1" +
                        //" , FCF2 = @Fcf2" +
                        //" , FCF3 = @Fcf3" +
                        //" , CASH_SUM = @CashSum" +
                        //" , SALES = @Sales" +
                        " FCF_SALES = @FcfSales" +
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
    }
}