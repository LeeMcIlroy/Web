using Dapper;
using HALLA_PM.Util;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class PlanGroupdataCashflowSummaryRepo : DbCon, IPlanGroupdataCashflowSummaryRepo
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

        public int insert(PlanGroupdataCashflowSummary entity)
        {
            throw new NotImplementedException();
        }

        public int save(PlanGroupdataCashflowSummary entity)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<PlanGroupdataCashflowSummary> selectList(object param)
        { 
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = @" SELECT *, BASIC_CASH + FCF + FINANCIAL_SUM AS ENDING_CASH	
                                              , BASIC_CASH + FCF + FINANCIAL_SUM + CREDIT_LINE	 AS AVAILABLE_CASH2
                                        FROM PLAN_GROUPDATA_CF_MONTHLY
                                        WHERE GROUPDATA_YEAR = @PLANYEAR AND GROUPDATA_MONTH >= @PLANYEAR 
                                            ORDER BY GROUPDATA_YEAR, GROUPDATA_MONTH ";
                    return con.Query<PlanGroupdataCashflowSummary>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<PlanGroupdataCashflowSummary> groupDataList(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = @" SELECT * FROM PLAN_GROUPDATA_CF_SUMMARY
                                        WHERE GROUPDATA_YEAR = @PLANYEAR AND GROUPDATA_MONTH >= @PLANYEAR 
                                            ORDER BY GROUPDATA_YEAR, GROUPDATA_MONTH ";
                    return con.Query<PlanGroupdataCashflowSummary>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }
        public PlanGroupdataCashflowSummary selectOne(object param)
        {

            throw new NotImplementedException();
        }

        public int update(PlanGroupdataCashflowSummary entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                con.Open();
                try
                {
                    string query = @"UPDATE PLAN_GROUPDATA_CF_Summary SET 
                                        EBITDA = @Ebitda
                                        ,WC = @Wc
                                        ,SALES_ETC = @SalesEtc
                                        ,NET_CAPEX  = @NetCapex
                                        ,FINANCIAL_COST = @FinancialCost
                                        ,FINANCIAL_SUM  = @FinancialSum
                                        ,CREDIT_LINE    = @CreditLine
                                        ,BASIC_CASH     = @BasicCash 
                                     WHERE SEQ = @Seq ";

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