using Dapper;
using HALLA_PM.Util;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class PmGroupdataCashflowMonthRepo : DbCon, IPmGroupdataCashflowMonthRepo
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

        public int insert(PmGroupdataCashflowMonth entity)
        {
            throw new NotImplementedException();
        }

        public int save(PmGroupdataCashflowMonth entity)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<PmGroupdataCashflowMonth> selectList(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = @" SELECT 
                                        SEQ
                                        ,GROUPDATA_YEAR
                                        ,GROUPDATA_MONTH
                                        ,DATATYPE
                                        ,EBITDA
                                        ,WC
                                        ,SALES_ETC
                                        ,NET_CAPEX
                                        ,FINANCIAL_COST
                                        ,FINANCIAL_SUM
                                        ,CREDIT_LINE
                                        ,ISNULL((SELECT BASIC_CASH FROM PM_GROUPDATA_CF_MONTHLY 
                                                                   WHERE GROUPDATA_YEAR =  @PMYEAR  AND GROUPDATA_MONTH = '01' AND MONTH_TYPE=10 ),0) AS BASIC_CASH
                                        ,FCF
                                        ,ALLOCATION
                                        ,INCREASE
                                        ,BORROWING
                                        ,REPAYMENT
                                        ,ETC
                                        ,AVAILABLE_CASH
                                        ,FCF1
                                        ,FCF2
                                        ,FCF3
                                        ,CASH_SUM
                                        ,MONTH_TYPE
                                        FROM PM_GROUPDATA_CF_MONTHLY WITH(NOLOCK)
                                        WHERE GROUPDATA_YEAR = @PMYEAR AND GROUPDATA_MONTH = @PMMONTH
                                            AND MONTH_TYPE = 20
                                            -- AND MONTH_TYPE = 20";
                    return con.Query<PmGroupdataCashflowMonth>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public PmGroupdataCashflowMonth selectOne(object param)
        { 
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = @" SELECT * FROM PM_GROUPDATA_CF_MONTHLY
                                        WHERE GROUPDATA_YEAR = @PMYEAR AND GROUPDATA_MONTH = @PMMONTH
                                            ORDER BY GROUPDATA_YEAR, GROUPDATA_MONTH ";
                    return con.Query<PmGroupdataCashflowMonth>(query, param).First();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public int update(PmGroupdataCashflowMonth entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                con.Open();
                try
                {
                    //string query = @"UPDATE PM_GROUPDATA_CF_MONTHLY SET 
                    //                    EBITDA = EBITDA + @Ebitda
                    //                    ,WC = WC + @Wc
                    //                    ,SALES_ETC = SALES_ETC + @SalesEtc
                    //                    ,NET_CAPEX  = NET_CAPEX + @NetCapex
                    //                    ,FINANCIAL_COST = FINANCIAL_COST + @FinancialCost
                    //                    --,FINANCIAL_SUM  = FINANCIAL_SUM + @FinancialSum
                    //                    ,CREDIT_LINE    = CREDIT_LINE + @CreditLine 
                    //                     ,ALLOCATION = ALLOCATION + @Allocation
                    //                    ,INCREASE   = INCREASE   + @Increase
                    //                    ,BORROWING  = BORROWING  + @Borrowing
                    //                    ,REPAYMENT  = REPAYMENT  + @Repayment
                    //                    ,ETC        = ETC        + @Etc
                    //                 WHERE SEQ = @Seq ";

                    string query = String.Format(@"[dbo].[USP_PM_GROUPDATA_CF_MONTHLY_CR_INSERT]
                                                        @GROUPDATA_YEAR   = '{0}'
                                                        ,@GROUPDATA_MONTH    = '{1}'
                                                        ,@DATATYPE           = '{2}'
                                                        ,@EBITDA_CR          = {3}
                                                        ,@WC_CR              = {4}
                                                        ,@SALES_ETC_CR       = {5}
                                                        ,@NET_CAPEX_CR       = {6}
                                                        ,@FINANCIAL_COST_CR  = {7}
                                                        ,@ALLOCATION_CR      = {8}
                                                        ,@INCREASE_CR        = {9}
                                                        ,@BORROWING_CR       = {10}
                                                        ,@REPAYMENT_CR       = {11}
                                                        ,@ETC_CR             = {12}
                                                        ,@CREDIT_LINE_CR     = {13}
                                                        ,@MONTH_TYPE         = {14} "
                                                      , entity.GroupdataYear
                                                      , entity.GroupdataMonth
                                                      , entity.DataType
                                                      , entity.Ebitda
                                                      , entity.Wc
                                                      , entity.SalesEtc
                                                      , entity.NetCapex
                                                      , entity.FinancialCost
                                                      , entity.Allocation
                                                      , entity.Increase
                                                      , entity.Borrowing
                                                      , entity.Repayment
                                                      , entity.Etc
                                                      , entity.CreditLine
                                                      ,entity.MonthType);

                    return con.Execute(@query);
                }
                catch (Exception e)
                {
                    LogUtil.Error(e.ToString());
                    return -1;
                }
            }
        }
    }
}