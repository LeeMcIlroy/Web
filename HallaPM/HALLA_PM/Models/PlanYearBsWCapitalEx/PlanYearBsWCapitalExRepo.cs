using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Data;
using Dapper;
using HALLA_PM.Util;

namespace HALLA_PM.Models
{
    public class PlanYearBsWCapitalExRepo : DbCon, IPlanYearBsWCapitalExRepo
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
                    string query = " SELECT COUNT(*) FROM PLAN_YEAR_BS_W_CAPITAL_EX " + where;
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

        public int insert(PlanYearBsWCapitalEx entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = @" INSERT INTO PLAN_YEAR_BS_W_CAPITAL_EX ( 
                             PLAN_YEAR_BS_SEQ 
                            , YEARLY_YEAR
                            , ANNUAL_SALES 
                            , ANNUAL_SALES_COST
                            , INVENTORY_COST
                            , MONTHLY 
                             ) VALUES ( 
                             @PlanYearBsSeq 
                            , @YearlyYear
                            , @AnnualSales
                            , @AnnualSalesCost
                            , @InventoryCost
                            , @Monthly
                            ); SELECT CAST(SCOPE_IDENTITY() as int)";
                    return con.Query<int>(query, entity).First();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return -1;
                }
            }
        }

        public int save(PlanYearBsWCapitalEx entity)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<PlanYearBsWCapitalEx> selectList(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" SELECT  YEARLY_YEAR
                                             ,ANNUAL_SALES
                                             ,ANNUAL_SALES_COST
                                                , INVENTORY_COST
                                             ,B.SEQ
                                             ,B.PLAN_YEAR_BS_SEQ
                                             --,B.SEQ AS PLAN_YEAR_BS_W_CAPITAL_SEQ
                                            , B.MONTHLY
                                        FROM PLAN_YEAR_BS_EX A
                                        LEFT OUTER JOIN PLAN_YEAR_BS_W_CAPITAL_EX B ON A.SEQ = B.PLAN_YEAR_BS_SEQ
                                        WHERE PLAN_YEAR_BS_SEQ = @PlanYearBsSeq
                                        AND YEARLY_YEAR >= @YearlyYear
                                        ORDER BY B.YEARLY_YEAR, B.MONTHLY";

                    return con.Query<PlanYearBsWCapitalEx>(query, param).ToList();

                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<PlanYearBsWCapitalEx> selectListBefore(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" SELECT	*
FROM	PLAN_YEAR_BS_EX				A
LEFT OUTER JOIN PLAN_YEAR_BS_W_CAPITAL_EX	B ON A.SEQ = B.PLAN_YEAR_BS_SEQ AND A.YEAR_BS_YEAR = B.YEARLY_YEAR
WHERE	1 = 1
AND		A.YEAR_BS_YEAR = @YearlyYear - 1
AND		A.ORG_COMPANY_SEQ = @OrgCompanySeq
";

                    return con.Query<PlanYearBsWCapitalEx>(query, param).ToList();

                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public PlanYearBsWCapitalEx selectOne(object param)
        {
            throw new NotImplementedException();
        }

        public PlanYearBsWCapitalEx selectOneYear(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
SELECT	*
FROM	PLAN_YEAR_BS_EX				    A
LEFT OUTER JOIN PLAN_YEAR_BS_W_CAPITAL_EX	B ON A.SEQ = B.PLAN_YEAR_BS_SEQ
WHERE	1 = 1
AND		A.YEAR_BS_YEAR = @BsYear
AND		A.ORG_COMPANY_SEQ = @OrgCompanySeq
AND		B.MONTHLY  = @Monthly
";
                    return con.Query<PlanYearBsWCapitalEx>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public int update(PlanYearBsWCapitalEx entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" UPDATE PLAN_YEAR_BS_W_CAPITAL_EX SET
                         ANNUAL_SALES = @AnnualSales
                         ,ANNUAL_SALES_COST = @AnnualSalesCost, INVENTORY_COST = @InventoryCost
                         WHERE SEQ = @Seq 
                         SELECT @@ROWCOUNT ";
                    return con.Query<int>(query, entity).First();

                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return -1;
                }
            }
        }
    }
}