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
    public class PmCashFlowFinancialRepo : DbCon, IPmCashFlowFinancialRepo
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
                    string query = " SELECT COUNT(*) FROM PM_CASH_FLOW_FINANCIAL " + where;
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

        public int insert(PmCashFlowFinancial entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " INSERT INTO  PM_CASH_FLOW_FINANCIAL ( " +
                        // 이부분은 수정하여 사용하세요. 
                        " PM_CASH_FLOW_SEQ " +
                        //", SEQ " +
                        ", CUMULATIVE " +
                        ", ALLOCATION " +
                        ", INCREASE " +
                        ", BORROWING " +
                        ", REPAYMENT " +
                        ", ETC " +
                        //", FINANCIAL_SUM " +
                    " ) VALUES ( " +
                    " @PmCashFlowSeq " +
                    //", @Seq " +
                    ", @Cumulative " +
                    ", @Allocation " +
                    ", @Increase " +
                    ", @Borrowing " +
                    ", @Repayment " +
                    ", @Etc " +
                    //", @FinancialSum " +
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

        public int save(PmCashFlowFinancial entity)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<PmCashFlowFinancial> selectList(object param)
        {
            {
                using (IDbConnection con = GetHallaDb())
                {
                    try
                    {
                        con.Open();

                        string query = " SELECT * " +
                            " FROM PM_CASH_FLOW_FINANCIAL " +
                            " WHERE PM_CASH_FLOW_SEQ = @PmCashFlowSeq ";

                        return con.Query<PmCashFlowFinancial>(query, param).ToList();
                    }
                    catch (Exception e)
                    {
                        LogUtil.MngError(e.ToString());
                        return null;
                    }
                }
            }
        }

        public PmCashFlowFinancial selectOne(object param)
        {
            throw new NotImplementedException();
        }

        public int update(PmCashFlowFinancial entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " UPDATE PM_CASH_FLOW_FINANCIAL SET " +
                        // 이부분은 수정하여 사용하세요. 
                        //" , PM_CASH_FLOW_SEQ = @PmCashFlowSeq" +
                        //" , SEQ = @Seq" +
                        //" , CUMULATIVE = @Cumulative" +
                        " ALLOCATION = @Allocation" +
                        " , INCREASE = @Increase" +
                        " , BORROWING = @Borrowing" +
                        " , REPAYMENT = @Repayment" +
                        " , ETC = @Etc" +
                        //" , FINANCIAL_SUM = @FinancialSum" +
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
        /// 재무활동 작년도 실적
        /// (2018.12.11 일부항목 실적요약값에서 가져오기 변경)
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        public IEnumerable<PmCashFlowFinancial> selectListBefore(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
SELECT	A.*, B.ALLOCATION, B.INCREASE, B.BORROWING, B.REPAYMENT, B.ETC, C.FINANCIAL_SUM
FROM	PM_CASH_FLOW		A
LEFT OUTER JOIN PM_CASH_FLOW_FINANCIAL	B ON A.SEQ = B.PM_CASH_FLOW_SEQ
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
//LEFT OUTER JOIN PM_CASH_FLOW_FINANCIAL	B ON A.SEQ = B.PM_CASH_FLOW_SEQ
//WHERE	1 = 1
//AND		A.CASH_FLOW_YEAR = @YearlyYear - 1
//AND		A.ORG_COMPANY_SEQ = @OrgCompanySeq
//AND		A.MONTHLY = '12'
//AND		B.CUMULATIVE = " + Define.CUMULATIVE.GetKey("누계 실적") + @"
//";

                    return con.Query<PmCashFlowFinancial>(query, param).ToList();
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