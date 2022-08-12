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
    public class PmCashFlowFcfRepo : DbCon, IPmCashFlowFcfRepo
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
                    string query = " DELETE PM_CASH_FLOW_FCF " +
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

        public int insert(PmCashFlowFcf entity)
        {
            throw new NotImplementedException();
        }

        public int insertCum(PmCashFlowFcf entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
INSERT INTO PM_CASH_FLOW_FCF
(PM_CASH_FLOW_SEQ, CUMULATIVE, FCF1, FCF2, FCF3, CASH_SUM, FCF_SALES )
SELECT	A.SEQ
		--, A.CASH_FLOW_YEAR
		--, A.MONTHLY
		--, A.ORG_COMPANY_SEQ
		--, B.PM_CASH_FLOW_SEQ
		--, B.SEQ
		--, B.CUMULATIVE
		--, C.PM_CASH_FLOW_SEQ
		--, C.SEQ
		, C.CUMULATIVE
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
		--+ C.ETC						-- NET_CAPEX소계 = 유형/무형자산 + 지분투자 + 자산매각 + 기타
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
		--+ C.ETC						-- NET_CAPEX소계
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
		--+ C.ETC						-- NET_CAPEX소계
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
		--+ C.ETC						-- NET_CAPEX소계
		+ B.INTEREST_EXPENSE
		+ B.INTEREST_INCOME			-- 순금융비용 = 이자비용 + 이자수익
		+ D.ALLOCATION
		+ D.INCREASE
		+ D.BORROWING
		+ D.REPAYMENT
		+ D.ETC						-- 재무활동소계 = 배당 + 증자 + 차입 + 상환 + 기타
									AS CASH_SUM	-- 현금흐름함계 = FCF2 + 재무활동소계
		--, ISNULL(E.SALES, 0)		AS SALES
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
				--+ C.ETC						-- NET_CAPEX소계
				+ B.INTEREST_EXPENSE
				+ B.INTEREST_INCOME			-- 순금융비용 = 이자비용 + 이자수익	
				) / E.SALES, 2) END		AS FCF_SALES
FROM	PM_CASH_FLOW						A
LEFT OUTER JOIN PM_CASH_FLOW_SALES			B ON A.SEQ = B.PM_CASH_FLOW_SEQ
LEFT OUTER JOIN PM_CASH_FLOW_INVESTMENT		C ON A.SEQ = C.PM_CASH_FLOW_SEQ AND B.CUMULATIVE = C.CUMULATIVE
LEFT OUTER JOIN PM_CASH_FLOW_FINANCIAL		D ON A.SEQ = D.PM_CASH_FLOW_SEQ AND B.CUMULATIVE = D.CUMULATIVE
LEFT OUTER JOIN (
	SELECT	A.PAL_YEAR
			, A.MONTHLY
			, A.ORG_COMPANY_SEQ
			, B.MONTHLY_TYPE			-- 10 : 당월, 20 : 누계 [cum과 현재 코드값이 같음]
			, ISNULL(B.SALES, 0)			AS SALES
			, ISNULL(B.EBIT, 0)				AS EBIT
			, ISNULL(B.PBT, 0)				AS PBT
	FROM	PM_PAL							A
	LEFT OUTER JOIN PM_PAL_SUMMARY			B ON A.SEQ = B.PM_PAL_SEQ
	WHERE	1 = 1
)											E ON A.CASH_FLOW_YEAR = E.PAL_YEAR AND A.MONTHLY = E.MONTHLY AND A.ORG_COMPANY_SEQ = E.ORG_COMPANY_SEQ AND B.CUMULATIVE = E.MONTHLY_TYPE
WHERE	1 = 1
AND		A.SEQ = @PmCashFlowSeq
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

        public int save(PmCashFlowFcf entity)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<PmCashFlowFcf> selectList(object param)
        {
            {
                using (IDbConnection con = GetHallaDb())
                {
                    try
                    {
                        con.Open();

                        string query = " SELECT * " +
                            " FROM PM_CASH_FLOW_FCF " +
                            " WHERE PM_CASH_FLOW_SEQ = @PmCashFlowSeq ";

                        return con.Query<PmCashFlowFcf>(query, param).ToList();
                    }
                    catch (Exception e)
                    {
                        LogUtil.MngError(e.ToString());
                        return null;
                    }
                }
            }
        }

        public PmCashFlowFcf selectOne(object param)
        {
            throw new NotImplementedException();
        }

        public int update(PmCashFlowFcf entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " UPDATE PM_CASH_FLOW_FCF SET " +
                        // 이부분은 수정하여 사용하세요. 
                        //" , PM_CASH_FLOW_SEQ = @PmCashFlowSeq" +
                        //" , CUMULATIVE = @Cumulative" +
                        " FCF1 = @Fcf1" +
                        " , FCF2 = @Fcf2" +
                        " , FCF3 = @Fcf3" +
                        " , CASH_SUM = @CashSum" +
                        " , FCF_SALES = @FcfSales" +
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

        /// <summary>
        /// fcf 작년도 실적
        /// (2018.12.11 일부항목 실적요약값에서 가져오기 변경)
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        public IEnumerable<PmCashFlowFcf> selectListBefore(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
SELECT	A.*, B.FCF1, C.FCF2, B.FCF3, B.CASH_SUM, B.FCF_SALES
FROM	PM_CASH_FLOW		A
LEFT OUTER JOIN PM_CASH_FLOW_FCF	B ON A.SEQ = B.PM_CASH_FLOW_SEQ
LEFT OUTER JOIN PM_CASH_FLOW_CUMULATIVE	C ON A.SEQ = C.PM_CASH_FLOW_SEQ
WHERE	1 = 1
AND		A.CASH_FLOW_YEAR = @YearlyYear - 1
AND		A.ORG_COMPANY_SEQ = @OrgCompanySeq
AND		A.MONTHLY = '12'
AND		B.CUMULATIVE = " + Define.CUMULATIVE.GetKey("누계 실적") + @"
AND		C.DIFF = " + Define.DIFF.GetKey("실적") + @"
";

//                    string query = @"
//SELECT	*
//FROM	PM_CASH_FLOW		A
//LEFT OUTER JOIN PM_CASH_FLOW_FCF	B ON A.SEQ = B.PM_CASH_FLOW_SEQ
//WHERE	1 = 1
//AND		A.CASH_FLOW_YEAR = @YearlyYear - 1
//AND		A.ORG_COMPANY_SEQ = @OrgCompanySeq
//AND		A.MONTHLY = '12'
//AND		B.CUMULATIVE = " + Define.CUMULATIVE.GetKey("누계 실적") + @"
//";

                    return con.Query<PmCashFlowFcf>(query, param).ToList();
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