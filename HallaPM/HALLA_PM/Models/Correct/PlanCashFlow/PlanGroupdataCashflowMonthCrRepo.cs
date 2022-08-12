using Dapper;
using HALLA_PM.Util;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class PlanGroupdataCashflowMonthCrRepo : DbCon, IPlanGroupdataCashflowMonthCrRepo
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

        public int insert(PlanGroupdataCashflowMonthCr entity)
        {
            throw new NotImplementedException();
        }

        public int save(PlanGroupdataCashflowMonthCr entity)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<PlanGroupdataCashflowMonthCr> selectList(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = @" SELECT * FROM PLAN_GROUPDATA_CF_MONTHLY_CR
                                        WHERE GROUPDATA_YEAR = @PLANYEAR 
                                            ORDER BY GROUPDATA_YEAR, GROUPDATA_MONTH ";
                    return con.Query<PlanGroupdataCashflowMonthCr>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public PlanGroupdataCashflowMonthCr selectOne(object param)
        {
            throw new NotImplementedException();
        }

        public int update(PlanGroupdataCashflowMonthCr entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                con.Open();
                try
                {
                    string query = @"UPDATE PLAN_GROUPDATA_CF_MONTHLY SET 
                                        EBITDA = EBITDA + @Ebitda
                                        ,WC = WC + @Wc
                                        ,SALES_ETC = SALES_ETC + @SalesEtc
                                        ,NET_CAPEX  = NET_CAPEX + @NetCapex
                                        ,FINANCIAL_COST = FINANCIAL_COST + @FinancialCost
                                        ,FINANCIAL_SUM  = FINANCIAL_SUM + @FinancialSum
                                        ,CREDIT_LINE    = CREDIT_LINE + @CreditLine 
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