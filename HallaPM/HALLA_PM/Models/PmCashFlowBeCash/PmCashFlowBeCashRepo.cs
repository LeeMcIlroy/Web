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
    public class PmCashFlowBeCashRepo : DbCon, IPmCashFlowBeCashRepo
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
                    string query = " DELETE PM_CASH_FLOW_BE_CASH WHERE PM_CASH_FLOW_SEQ = @PmCashFlowSeq ";
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

        public int insert(PmCashFlowBeCash entity)
        {
            throw new NotImplementedException();
        }

        public int insertCum(PmCashFlowBeCash entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " INSERT INTO  PM_CASH_FLOW_BE_CASH ( " +
                        // 이부분은 수정하여 사용하세요. 
                        " PM_CASH_FLOW_SEQ " +
                        //", SEQ " +
                        ", CUMULATIVE " +
                        ", BASIC_CASH " +
                        ", ENDING_CASH " +
                        ", CREDIT_LINE " +
                        ", AVAILABLE_CASH " +
                    " ) VALUES ( " +
                    " @PmCashFlowSeq " +
                    //", @Seq " +
                    ", @Cumulative " +
                    ", @BasicCash " +
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

        public int insertCum2(PmCashFlowBeCash entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " DELETE PM_CASH_FLOW_BE_CASH WHERE PM_CASH_FLOW_SEQ = @PmCashFlowSeq AND CUMULATIVE = @Cumulative ; INSERT INTO  PM_CASH_FLOW_BE_CASH ( " +
                        // 이부분은 수정하여 사용하세요. 
                        " PM_CASH_FLOW_SEQ " +
                        //", SEQ " +
                        ", CUMULATIVE " +
                        ", BASIC_CASH " +
                        ", ENDING_CASH " +
                        ", CREDIT_LINE " +
                        ", AVAILABLE_CASH " +
                    " ) VALUES ( " +
                    " @PmCashFlowSeq " +
                    //", @Seq " +
                    ", @Cumulative " +
                    ", @BasicCash " +
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

        public int save(PmCashFlowBeCash entity)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<PmCashFlowBeCash> selectList(object param)
        {
            {
                using (IDbConnection con = GetHallaDb())
                {
                    try
                    {
                        con.Open();

                        string query = " SELECT * " +
                            " FROM PM_CASH_FLOW_BE_CASH " +
                            " WHERE PM_CASH_FLOW_SEQ = @PmCashFlowSeq ORDER BY CUMULATIVE";

                        return con.Query<PmCashFlowBeCash>(query, param).ToList();
                    }
                    catch (Exception e)
                    {
                        LogUtil.MngError(e.ToString());
                        return null;
                    }
                }
            }
        }

        public PmCashFlowBeCash selectOne(object param)
        {
            throw new NotImplementedException();
        }

        public int update(PmCashFlowBeCash entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " UPDATE PM_CASH_FLOW_BE_CASH SET " +
                        // 이부분은 수정하여 사용하세요. 
                        //" , PM_CASH_FLOW_SEQ = @PmCashFlowSeq" +
                        //" , CUMULATIVE = @Cumulative" +
                        " BASIC_CASH = @BasicCash" +
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
        public int update2(PmCashFlowBeCash entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " UPDATE PM_CASH_FLOW_BE_CASH SET " +
                        // 이부분은 수정하여 사용하세요. 
                        //" , PM_CASH_FLOW_SEQ = @PmCashFlowSeq" +
                        //" , CUMULATIVE = @Cumulative" +
                        " BASIC_CASH = @BasicCash" +
                        //" , ENDING_CASH = @EndingCash" +
                        " , CREDIT_LINE = @CreditLine" +
                        //" , AVAILABLE_CASH = @AvailableCash" +
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
        public IEnumerable<PmCashFlowBeCash> selectListBefore(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
SELECT	A.*, B.BASIC_CASH, C.ENDING_CASH, C.CREDIT_LINE, C.AVAILABLE_CASH
FROM	PM_CASH_FLOW		A
LEFT OUTER JOIN PM_CASH_FLOW_BE_CASH	B ON A.SEQ = B.PM_CASH_FLOW_SEQ
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
//LEFT OUTER JOIN PM_CASH_FLOW_BE_CASH	B ON A.SEQ = B.PM_CASH_FLOW_SEQ
//WHERE	1 = 1
//AND		A.CASH_FLOW_YEAR = @YearlyYear - 1
//AND		A.ORG_COMPANY_SEQ = @OrgCompanySeq
//AND		A.MONTHLY = '12'
//AND		B.CUMULATIVE = " + Define.CUMULATIVE.GetKey("누계 실적") + @"
//";

                    return con.Query<PmCashFlowBeCash>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<PmCashFlowBeCash> selectListBeforeMonth(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    // 2018.12.14 당월실적 기초현금을 가져오는 것은 전월 누계(요약항목)에서 가져온다.
                    string query = @"
SELECT	*
FROM	PM_CASH_FLOW		A
--LEFT OUTER JOIN PM_CASH_FLOW_BE_CASH	B ON A.SEQ = B.PM_CASH_FLOW_SEQ
LEFT OUTER JOIN PM_CASH_FLOW_CUMULATIVE	C ON A.SEQ = C.PM_CASH_FLOW_SEQ
WHERE	1 = 1
AND		A.CASH_FLOW_YEAR = @YearlyYear
AND		A.ORG_COMPANY_SEQ = @OrgCompanySeq
AND		A.MONTHLY = @Monthly - 1
AND     C.DIFF = 20
";

                    return con.Query<PmCashFlowBeCash>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        /// <summary>
        /// 기존에 PM_CASH_FLOW_BE_CASH에서 실적요약 항목 테이블에서 가져오는 것으로 변경
        /// (2018.12.11 일부항목 실적요약값에서 가져오기 변경)
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        public IEnumerable<PmCashFlowBeCash> selectListLastYear(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    // 2018.12.14 당월실적 기초현금을 가져오는 것은 전월 누계(요약항목)에서 가져온다.
                    string query = @"
SELECT	*
FROM	PM_CASH_FLOW		A
--LEFT OUTER JOIN PM_CASH_FLOW_BE_CASH	B ON A.SEQ = B.PM_CASH_FLOW_SEQ
LEFT OUTER JOIN PM_CASH_FLOW_CUMULATIVE	C ON A.SEQ = C.PM_CASH_FLOW_SEQ
WHERE	1 = 1
AND		A.CASH_FLOW_YEAR = @YearlyYear - 1
AND		A.ORG_COMPANY_SEQ = @OrgCompanySeq
AND		A.MONTHLY = '12'
AND     C.DIFF = 20
";

                    return con.Query<PmCashFlowBeCash>(query, param).ToList();
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