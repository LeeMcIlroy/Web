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
    public class TrendBsRepo : DbCon, ITrendBsRepo
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

        public int insert(TrendBs entity)
        {
            throw new NotImplementedException();
        }

        public int save(TrendBs entity)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<TrendBs> selectList(object param)
        {
            throw new NotImplementedException();
        }

        public TrendBs selectOne(object param)
        {
            throw new NotImplementedException();
        }

        public int update(TrendBs entity)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<TrendBs> GetBsYear(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"

SELECT	*
FROM	(
SELECT	A.BS_YEAR
		, A.MONTHLY
		, ROW_NUMBER() OVER (PARTITION BY A.BS_YEAR, A.ORG_COMPANY_SEQ ORDER BY A.BS_YEAR, A.MONTHLY DESC) AS NO_Z
		, ISNULL(B.ASSETS, 0.00)						AS ASSETS
		, ISNULL(C.CURRENT_ASSETS, 0.00)				AS CURRENT_ASSETS
		, ISNULL(B.LIABILITIES, 0.00)					AS LIABILITIES
		, ISNULL(C.CURRENT_LIABILITIES, 0.00)			AS CURRENT_LIABILITIES
		, ISNULL(B.CAPITAL, 0.00)						AS CAPITAL
		, ISNULL(B.CASH, 0.00)							AS CASH
		, ISNULL(B.LOAN, 0.00)							AS LOAN
		-- 부채비율 = 총부채 / 총자본(디비는 수식 참고용. 계산은 백엔드에서)
		--, B.LIABILITIES / B.CAPITAL AS LIABILITIES_RATE
		-- 유동비율 = 총자산 / 총부채(디비는 수식 참고용. 계산은 백엔드에서)
		--, B.ASSETS / B.LIABILITIES AS CURRENT_RATE
		, ISNULL(B.AFTER_TAX_OPERATION_PROFIT, 0.00)	AS AFTER_TAX_OPERATION_PROFIT
		, ISNULL(B.PAIN_IN_CAPITAL, 0.00)				AS PAIN_IN_CAPITAL
		-- ROIC = (투하자본 / 세후영업이익) * 100(디비는 수식 참고용. 계산은 백엔드에서)
		--, (B.PAIN_IN_CAPITAL / B.AFTER_TAX_OPERATION_PROFIT) * 100 AS ROIC
		, ISNULL(B.AR, 0.00)							AS AR
		, ISNULL(B.AR_TO_DAYS, 0.00)					AS AR_TO_DAYS
		, ISNULL(B.AP, 0.00)							AS AP
		, ISNULL(B.AP_TO_DAYS, 0.00)					AS AP_TO_DAYS
		, ISNULL(B.INVENTORY, 0.00)						AS INVENTORY
		, ISNULL(B.INVENTORY_TO_DAYS, 0.00)				AS INVENTORY_TO_DAYS
		, A.ORG_COMPANY_SEQ
		, G.COMPANY_NAME
		, G.ORG_UNION_SEQ
		, H.UNION_NAME
FROM	PM_BS					A
LEFT OUTER JOIN PM_BS_SUMMARY	B ON A.SEQ = B.PM_BS_SEQ
LEFT OUTER JOIN PM_BS_BSHEET	C ON A.SEQ = C.PM_BS_SEQ
LEFT OUTER JOIN ORG_COMPANY					G ON A.ORG_COMPANY_SEQ = G.SEQ
LEFT OUTER JOIN ORG_UNION					H ON G.ORG_UNION_SEQ = H.SEQ
WHERE	1 = 1
AND		A.REGIST_STATUS = " + Define.REGIST_STATUS.GetKey("최종승인") + @"
) A
WHERE	1 = 1
AND		NO_Z = 1

";

                    return con.Query<TrendBs>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.ReportErrorLog(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<TrendBs> GetBsMonth(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
SELECT	A.BS_YEAR
		, A.MONTHLY
		, DATEPART(QUARTER, A.BS_YEAR + '-' + A.MONTHLY + '-01') AS QT
		, ISNULL(B.ASSETS, 0.00)						AS ASSETS
		, ISNULL(B.CURRENT_ASSETS, 0.00)				AS CURRENT_ASSETS
		, ISNULL(B.LIABILITIES, 0.00)					AS LIABILITIES
		, ISNULL(B.CURRENT_LIABILITIES, 0.00)			AS CURRENT_LIABILITIES
		, ISNULL(B.CAPITAL, 0.00)						AS CAPITAL
		, ISNULL(B.CASH, 0.00)							AS CASH
		, ISNULL(B.LOAN, 0.00)							AS LOAN
		--, B.LIABILITIES_RATE
		--, B.CURRENT_RATE
		, ISNULL(C.AFTER_TAX_OPERATION_PROFIT, 0.00)	AS AFTER_TAX_OPERATION_PROFIT
		, ISNULL(C.PAIN_IN_CAPITAL, 0.00)				AS PAIN_IN_CAPITAL
		--, C.ROIC
		, ISNULL(D.ANNUAL_SALES, 0.00)					AS ANNUAL_SALES
		, ISNULL(D.ANNUAL_SALES_COST, 0.00)				AS ANNUAL_SALES_COST
		, ISNULL(D.INVENTORY_COST, 0.00)				AS INVENTORY_COST
		, ISNULL(E.AR, 0.00)							AS AR
		--, E.AR_TO_DAYS
		, ISNULL(E.AP, 0.00)							AS AP
		--, E.AP_TO_DAYS
		, ISNULL(E.INVENTORY, 0.00)						AS INVENTORY
		--, E.INVENTORY_TO_DAYS
		, A.ORG_COMPANY_SEQ
		, G.COMPANY_NAME
		, G.ORG_UNION_SEQ
		, H.UNION_NAME
FROM	PM_BS						A
LEFT OUTER JOIN PM_BS_BSHEET		B ON A.SEQ = B.PM_BS_SEQ
LEFT OUTER JOIN PM_BS_ROIC			C ON A.SEQ = C.PM_BS_SEQ
LEFT OUTER JOIN PM_BS_W_CAPITAL		D ON A.SEQ = D.PM_BS_SEQ
LEFT OUTER JOIN PM_BS_W_CAPITAL_REG	E ON A.SEQ = E.PM_BS_SEQ
LEFT OUTER JOIN ORG_COMPANY					G ON A.ORG_COMPANY_SEQ = G.SEQ
LEFT OUTER JOIN ORG_UNION					H ON G.ORG_UNION_SEQ = H.SEQ
WHERE	1 = 1
AND		A.REGIST_STATUS = " + Define.REGIST_STATUS.GetKey("최종승인") + @"
";

                    return con.Query<TrendBs>(query, param).ToList();
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