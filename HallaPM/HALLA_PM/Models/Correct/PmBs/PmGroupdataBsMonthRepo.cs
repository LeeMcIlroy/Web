using Dapper;
using HALLA_PM.Util;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class PmGroupdataBsMonthRepo : DbCon, IPmGroupdataBsMonthRepo
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

        public int insert(PmGroupdataBsMonth entity)
        {
            throw new NotImplementedException();
        }

        public int save(PmGroupdataBsMonth entity)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<PmGroupdataBsMonth> selectList(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = @" SELECT TOP 1 * FROM PM_GROUPDATA_BS_MONTHLY
                                        WHERE GROUPDATA_YEAR = @PMYEAR AND GROUPDATA_MONTH = @PMMONTH
                                            ORDER BY GROUPDATA_YEAR, GROUPDATA_MONTH ";
                    return con.Query<PmGroupdataBsMonth>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public PmGroupdataBsMonth selectOne(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = @" SELECT * FROM PM_GROUPDATA_BS_MONTHLY
                                        WHERE GROUPDATA_YEAR = @PMYEAR AND GROUPDATA_MONTH = @PMMONTH
                                            ORDER BY GROUPDATA_YEAR, GROUPDATA_MONTH ";
                    return con.Query<PmGroupdataBsMonth>(query, param).First();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public int update(PmGroupdataBsMonth entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                con.Open();
                try
                {
                    //string query = @"UPDATE PM_GROUPDATA_BS_MONTHLY SET 
                    //                    CURRENT_ASSETS = CURRENT_ASSETS + @CurrentAssets
                    //                    ,LIABILITIES  = LIABILITIES + @Liabilities
                    //                    ,CAPITAL  = CAPITAL + @Capital
                    //                    ,CASH  = CASH + @Cash
                    //                    ,LOAN  = LOAN + @Loan
                    //                    ,AFTER_TAX_OPERATION_PROFIT  = AFTER_TAX_OPERATION_PROFIT + @AfterTaxOperationProfit
                    //                    ,PAIN_IN_CAPITAL  =  PAIN_IN_CAPITAL + @PainInCapital
                    //                    ,AR  = AR + @Ar
                    //                    ,AR_TO_DAYS  = AR_TO_DAYS + @ArToDays
                    //                    ,AP  = AP + @Ap
                    //                    ,AP_TO_DAYS  = AP_TO_DAYS +  @ApToDays
                    //                    ,INVENTORY  = INVENTORY + @Inventory
                    //                    ,INVENTORY_TO_DAYS  = INVENTORY_TO_DAYS + @inventoryToDays
                    //                 WHERE SEQ = @Seq ";
                    string query = String.Format(@"[dbo].[USP_PM_GROUPDATA_BS_MONTHLY_CR_INSERT]
                                                        @GROUPDATA_YEAR   = '{0}'
                                                        ,@GROUPDATA_MONTH    = '{1}'
                                                        ,@DATATYPE           = '{2}'
                                                        ,@ASSETS_CR			                = {3}
                                                        ,@CURRENT_ASSETS_CR				    = {4}
                                                        ,@LIABILITIES_CR				    = {5}
                                                        ,@CAPITAL_CR					    = {6}
                                                        ,@CASH_CR						    = {7}
                                                        ,@LOAN_CR						    = {8}
                                                        ,@AFTER_TAX_OPERATION_PROFIT_CR	    = {9}
                                                        ,@PAIN_IN_CAPITAL_CR			    = {10}
                                                        ,@AR_CR							    = {11}
                                                        ,@AR_TO_DAYS_CR					    = {12}
                                                        ,@AP_CR							    = {13}
                                                        ,@AP_TO_DAYS_CR					    = {14}
                                                        ,@INVENTORY_CR					    = {15}
                                                        ,@INVENTORY_TO_DAYS_CR	            = {16}               "
                                                     , entity.GroupdataYear
                                                     , entity.GroupdataMonth
                                                     , entity.DataType
                                                     , entity.Assets
                                                     , entity.CurrentAssets
                                                     , entity.Liabilities
                                                     , entity.Capital
                                                     , entity.Cash
                                                     , entity.Loan
                                                     , entity.AfterTaxOperationProfit
                                                     , entity.PainInCapital
                                                     , entity.Ar
                                                     , entity.ArToDays
                                                     , entity.Ap
                                                     , entity.ApToDays
                                                     , entity.Inventory
                                                     , entity.inventoryToDays);
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