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
    public class PmCashFlowSalesRepo : DbCon, IPmCashFlowSalesRepo

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
                    string query = " SELECT COUNT(*) FROM PM_CASH_FLOW_SALES " + where;
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
            throw new NotImplementedException();
        }

        public void Dispose()
        {
            throw new NotImplementedException();
        }

        public int insert(PmCashFlowSales entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " INSERT INTO  PM_CASH_FLOW_SALES ( " +
                        // 이부분은 수정하여 사용하세요. 
                        " PM_CASH_FLOW_SEQ " +
                        //", SEQ " +
                        ", CUMULATIVE " +
                        ", OPERATION_PROFIT " +
                        ", DEPRECIATION_COST " +
                        ", CORP_TAX " +
                        //", EBITDA " +
                        ", AR " +
                        ", INV " +
                        ", AP " +
                        //", WC_SUM " +
                        ", ETC " +
                        ", INTEREST_EXPENSE " +
                        ", INTEREST_INCOME " +
                        //", FINANCIAL_COST_SUM " +
                    " ) VALUES ( " +
                    " @PmCashFlowSeq " +
                    //", @Seq " +
                    ", @Cumulative " +
                    ", @OperationProfit " +
                    ", @DepreciationCost " +
                    ", @CorpTax " +
                    //", @Ebitda " +
                    ", @Ar " +
                    ", @Inv " +
                    ", @Ap " +
                    //", @WcSum " +
                    ", @Etc " +
                    ", @InterestExpense " +
                    ", @InterestIncome " +
                    //", @FinancialCostSum " +
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

        public int save(PmCashFlowSales entity)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<PmCashFlowSales> selectList(object param)
        {
            {
                using (IDbConnection con = GetHallaDb())
                {
                    try
                    {
                        con.Open();

                        string query = " SELECT * " +
                            " FROM PM_CASH_FLOW_SALES " +
                            " WHERE PM_CASH_FLOW_SEQ = @PmCashFlowSeq ";

                        return con.Query<PmCashFlowSales>(query, param).ToList();
                    }
                    catch (Exception e)
                    {
                        LogUtil.MngError(e.ToString());
                        return null;
                    }
                }
            }
        }

        public PmCashFlowSales selectOne(object param)
        {
            throw new NotImplementedException();
        }

        public int update(PmCashFlowSales entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " UPDATE PM_CASH_FLOW_SALES SET " +
                        // 이부분은 수정하여 사용하세요. 
                        //" , PM_CASH_FLOW_SEQ = @PmCashFlowSeq" +
                        //" , SEQ = @Seq" +
                        //" , CUMULATIVE = @Cumulative" +
                        " OPERATION_PROFIT = @OperationProfit" +
                        " , DEPRECIATION_COST = @DepreciationCost" +
                        " , CORP_TAX = @CorpTax" +
                        //" , EBITDA = @Ebitda" +
                        " , AR = @Ar" +
                        " , INV = @Inv" +
                        " , AP = @Ap" +
                        //" , WC_SUM = @WcSum" +
                        " , ETC = @Etc" +
                        " , INTEREST_EXPENSE = @InterestExpense" +
                        " , INTEREST_INCOME = @InterestIncome" +
                        //" , FINANCIAL_COST_SUM = @FinancialCostSum" +
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
        /// 영업활동 작년도 실적
        /// (2018.12.11 세후Ebitda, WcSum, Etc, 순금융비용은 요약에서 가져오게 변경)
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        public IEnumerable<PmCashFlowSales> selectListBefore(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
SELECT	A.*, B.OPERATION_PROFIT, B.DEPRECIATION_COST, B.CORP_TAX
		, C.EBITDA, B.AR, B.INV, B.AP, C.WC_SUM, C.ETC, B.INTEREST_EXPENSE, B.INTEREST_INCOME, C.FINANCIAL_COST AS FINANCIAL_COST_SUM
FROM	PM_CASH_FLOW		A
LEFT OUTER JOIN PM_CASH_FLOW_SALES	B ON A.SEQ = B.PM_CASH_FLOW_SEQ
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
//LEFT OUTER JOIN PM_CASH_FLOW_SALES	B ON A.SEQ = B.PM_CASH_FLOW_SEQ
//WHERE	1 = 1
//AND		A.CASH_FLOW_YEAR = @YearlyYear - 1
//AND		A.ORG_COMPANY_SEQ = @OrgCompanySeq
//AND		A.MONTHLY = '12'
//AND		B.CUMULATIVE = " + Define.CUMULATIVE.GetKey("누계 실적") + @"
//";

                    return con.Query<PmCashFlowSales>(query, param).ToList();
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