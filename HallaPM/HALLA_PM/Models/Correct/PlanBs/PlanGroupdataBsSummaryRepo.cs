using Dapper;
using HALLA_PM.Util;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class PlanGroupdataBsSummaryRepo : DbCon, IPlanGroupdataBsSummaryRepo
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

        public int insert(PlanGroupdataBsSummary entity)
        {
            throw new NotImplementedException();
        }

        public int save(PlanGroupdataBsSummary entity)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<PlanGroupdataBsSummary> selectList(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = @" SELECT * FROM PLAN_GROUPDATA_BS_SUMMARY
                                        WHERE GROUPDATA_YEAR = @PLANYEAR 
                                            ORDER BY GROUPDATA_YEAR, GROUPDATA_MONTH ";
                    return con.Query<PlanGroupdataBsSummary>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<PlanGroupdataBsSummary> groupSelectList(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = @" /*SELECT   A.YEAR_INVEST_YEAR AS GROUPDATA_YEAR
				                        ,B.YEARLY_YEAR AS GROUPDATA_MONTH
				                        ,'05' AS DATATYPE
				                        ,SUM(B.INVESTMENT) AS INVESTMENT
				                        ,SUM(B.DOMESTIC_PERSONNEL) + SUM(B.OVERSEAS_PERSONNEL)  as PERSONNEL
				                        ,SUM(B.DOMESTIC_PERSONNEL) AS DOMESTIC_PERSONNEL
				                        ,SUM(B.OVERSEAS_PERSONNEL) AS OVERSEAS_PERSONNEL
		                             FROM PLAN_YEAR_INVEST  A WITH(NOLOCK)
			                                INNER JOIN  PLAN_YEAR_INVEST_SUMMARY  B   WITH(NOLOCK)
		                                ON A.SEQ = B.PLAN_YEAR_INVEST_SEQ
		                                WHERE A.YEAR_INVEST_YEAR = @Year - 1 
                                            AND B.YEARLY_YEAR = @Year - 1 
                                            AND A.REGIST_STATUS = 7 
                                            AND A.ORG_COMPANY_SEQ <> 13
		                                GROUP BY A.YEAR_INVEST_YEAR,B.YEARLY_YEAR
                                UNION ALL*/
		                                SELECT *
		                                FROM PLAN_GROUPDATA_BS_SUMMARY
		                                WHERE GROUPDATA_YEAR = @Year  ";
                    return con.Query<PlanGroupdataBsSummary>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public PlanGroupdataBsSummary selectOne(object param)
        {
            throw new NotImplementedException();
        }

        public int update(PlanGroupdataBsSummary entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                con.Open();
                try
                {
                    //string query = @"UPDATE PLAN_GROUPDATA_BS_SUMMARY SET 
                    //                    ASSETS = ASSETS + @Assets
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

                    string query = String.Format(@" [dbo].[USP_PLAN_GROUPDATA_BS_SUMMARY_CR_INSERT]
                                                     @GROUPDATA_YEAR = '{0}',
		                                               @GROUPDATA_MONTH = '{1}',
		                                               @DATATYPE = '{2}',
		                                               @ASSETS_CR = {3},
		                                               @LIABILITIES_CR = {4},
		                                               @CAPITAL_CR = {5},
		                                               @CASH_CR = {6},
												       @LOAN_CR = {7},
												       @AFTER_TAX_OPERATION_PROFIT_CR = {8},
												       @PAIN_IN_CAPITAL_CR = {9},
												       @AR_CR = {10},
												       @AR_TO_DAYS_CR = {11},
												       @AP_CR = {12},
												       @AP_TO_DAYS_CR = {13},
												       @INVENTORY_CR = {14},
												       @INVENTORY_TO_DAYS_CR = {15}"
                                                        , entity.GroupdataYear
                                                        , entity.GroupdataMonth
                                                        , entity.DataType
                                                        , entity.Assets
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
                                                        , entity.InventoryToDays);

                    return con.Execute(@query, entity);
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