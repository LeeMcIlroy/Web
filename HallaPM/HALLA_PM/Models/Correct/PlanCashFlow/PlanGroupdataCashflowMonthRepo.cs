using Dapper;
using HALLA_PM.Util;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class PlanGroupdataCashflowMonthRepo : DbCon, IPlanGroupdataCashflowMonthRepo
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

        public int insert(PlanGroupdataCashflowMonth entity)
        {
            throw new NotImplementedException();
        }

        public int save(PlanGroupdataCashflowMonth entity)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<PlanGroupdataCashflowMonth> selectList(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = @" SELECT * FROM PLAN_GROUPDATA_CF_MONTHLY
                                        WHERE GROUPDATA_YEAR = @PLANYEAR 
                                            ORDER BY GROUPDATA_YEAR, GROUPDATA_MONTH ";
                    return con.Query<PlanGroupdataCashflowMonth>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public PlanGroupdataCashflowMonth selectOne(object param)
        {
            throw new NotImplementedException();
        }

        public int update(PlanGroupdataCashflowMonth entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                con.Open();
                try
                { 
                   /* string query = @"UPDATE PLAN_GROUPDATA_CF_MONTHLY SET 
                                        EBITDA = EBITDA + @Ebitda
                                        ,WC = WC + @Wc
                                        ,SALES_ETC = SALES_ETC + @SalesEtc
                                        ,NET_CAPEX  = NET_CAPEX + @NetCapex
                                        ,FINANCIAL_COST = FINANCIAL_COST + @FinancialCost
                                        ,FINANCIAL_SUM  = FINANCIAL_SUM + @FinancialSum
                                        ,CREDIT_LINE    = CREDIT_LINE + @CreditLine 
                                     WHERE SEQ = @Seq ";*/
                    string query = String.Format(@" [dbo].[USP_PLAN_GROUPDATA_CF_MONTHLY_CR_INSERT]
                                                     @GROUPDATA_YEAR = '{0}',
		                                                @GROUPDATA_MONTH = '{1}',
		                                                @DATATYPE = '{2}',
		                                                @EBITDA_CR = {3},
		                                                @WC_CR = {4},
		                                                @SALES_ETC_CR = {5},
		                                                @NET_CAPEX_CR = {6},
		                                                @FINANCIAL_COST_CR = {7},
		                                                @FINANCIAL_SUM_CR ={8},
		                                                @CREDIT_LINE_CR = {9} "
                                                        ,entity.GroupdataYear
                                                        ,entity.GroupdataMonth
                                                        ,entity.DataType
                                                        ,entity.Ebitda
                                                        ,entity.Wc
                                                        ,entity.SalesEtc
                                                        ,entity.NetCapex
                                                        ,entity.FinancialCost
                                                        ,entity.FinancialSum
                                                        ,entity.CreditLine);
                    LogUtil.Error(query.ToString());
                    return con.Execute(query);
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