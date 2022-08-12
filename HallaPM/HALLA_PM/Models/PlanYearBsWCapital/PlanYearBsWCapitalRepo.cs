using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using Dapper;
using HALLA_PM.Util;

namespace HALLA_PM.Models
{
    public class PlanYearBsWCapitalRepo : DbCon, IPlanYearBsWCapital
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
                    string query = " SELECT COUNT(*) FROM PLAN_YEAR_BS_W_CAPITAL " + where;
                    return con.Query<int>(query, param).First();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return -1;
                }
            }
        }

        public PlanYearBsWCapital selectOne(object param)
        {
            throw new NotImplementedException();
        }

        public PlanYearBsWCapital selectOneYear(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
SELECT	*
FROM	PLAN_YEAR_BS				    A
LEFT OUTER JOIN PLAN_YEAR_BS_W_CAPITAL	B ON A.SEQ = B.PLAN_YEAR_BS_SEQ
WHERE	1 = 1
AND		A.YEAR_BS_YEAR = @BsYear
AND		A.ORG_COMPANY_SEQ = @OrgCompanySeq
AND		B.MONTHLY  = @Monthly
";
                    return con.Query<PlanYearBsWCapital>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        //public IEnumerable<PlanYearBsWCapital> selectList(object param)
        //{
        //    using (IDbConnection con = GetHallaDb())
        //    {
        //        try
        //        {
        //            con.Open();

        //            string where = " WHERE 1 = 1 ";

        //            string query = " SELECT	A.*, B.BUSINESS_NAME " +
        //                " FROM PLAN_YEAR_BS_W_CAPITAL 	A " +
        //                "LEFT OUTER JOIN ORG_BUSINESS        B ON A.ORG_BUSINESS_SEQ = B.SEQ WHERE PLAN_MONTHLY_PAL_SEQ = @PlanMonthlyPalSeq";

        //            return con.Query<PlanYearBsWCapital>(query, param).ToList();
        //        }
        //        catch (Exception e)
        //        {
        //            LogUtil.MngError(e.ToString());
        //            return null;
        //        }
        //    }
        //}

        public IEnumerable<PlanYearBsWCapital> selectList(object param)
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
                                            ,  B.MONTHLY
                                        FROM PLAN_YEAR_BS A
                                        LEFT OUTER JOIN PLAN_YEAR_BS_W_CAPITAL B ON A.SEQ = B.PLAN_YEAR_BS_SEQ
                                        WHERE PLAN_YEAR_BS_SEQ = @PlanYearBsSeq
                                        AND YEARLY_YEAR >= @YearlyYear
                                        ORDER BY B.YEARLY_YEAR, B.MONTHLY";

                    return con.Query<PlanYearBsWCapital>(query, param).ToList();

                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<PlanYearBsWCapital> selectListBefore(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" SELECT	*
FROM	PLAN_YEAR_BS				A
LEFT OUTER JOIN PLAN_YEAR_BS_W_CAPITAL	B ON A.SEQ = B.PLAN_YEAR_BS_SEQ AND A.YEAR_BS_YEAR = B.YEARLY_YEAR
WHERE	1 = 1
AND		A.YEAR_BS_YEAR = @YearlyYear - 1
AND		A.ORG_COMPANY_SEQ = @OrgCompanySeq
";

                    return con.Query<PlanYearBsWCapital>(query, param).ToList();

                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public int insert(PlanYearBsWCapital entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = @" INSERT INTO PLAN_YEAR_BS_W_CAPITAL ( 
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
        
        public IEnumerable<PlanYearBsWCapital> nowYearBsWCapitalList(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" SELECT YEARLY_YEAR
	                                        ,ANNUAL_SALES
	                                        ,ANNUAL_SALES_COST
                                            ,INVENTORY_COST
                                            ,A.SEQ AS PLAN_YEAR_BS_W_CAPITAL_SEQ
                                      FROM	PLAN_YEAR_BS_W_CAPITAL	A
                                      LEFT OUTER JOIN PLAN_YEAR_BS	B ON A.PLAN_YEAR_BS_SEQ = B.SEQ
                                      WHERE	A.PLAN_YEAR_BS_SEQ = @PlanYearBsSeq
                                      AND YEARLY_YEAR >= @Year";

                    return con.Query<PlanYearBsWCapital>(query, param).ToList();

                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }


        public PlanYearBsWCapital nowYearBsWCapitalOneExp(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" 
                        SELECT *
                        FROM PLAN_YEAR_BS A
                        LEFT OUTER JOIN PLAN_YEAR_BS_W_CAPITAL B ON A.SEQ = B.PLAN_YEAR_BS_SEQ AND A.YEAR_BS_YEAR = B.YEARLY_YEAR
                        WHERE 1 = 1
                        AND A.YEAR_BS_YEAR = @yearBsYear
                        
                        AND A.ORG_COMPANY_SEQ = @OrgCompanySeq
                    ";
                    //AND B.MONTHLY = @monthly
                    return con.Query<PlanYearBsWCapital>(query, param).FirstOrDefault();

                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }
        //public IEnumerable<PlanYearBsWCapital> selectListBefore(object param)
        //{
        //    using (IDbConnection con = GetHallaDb())
        //    {
        //        try
        //        {
        //            con.Open();

        //            string query = @" SELECT  YEARLY_YEAR
	       //                                  ,ANNUAL_SALES
	       //                                  ,ANNUAL_SALES_COST
        //                                     ,B.SEQ AS PLAN_YEAR_BS_W_CAPITAL_SEQ 
        //                                FROM PLAN_YEAR_BS A
        //                                LEFT OUTER JOIN PLAN_YEAR_BS_W_CAPITAL B ON A.SEQ = B.PLAN_YEAR_BS_SEQ
        //                                WHERE YEAR_BS_YEAR = '2017'
        //                                AND PLAN_YEAR_BS_SEQ = '2'";

        //            return con.Query<PlanYearBsWCapital>(query, param).ToList();

        //        }
        //        catch (Exception e)
        //        {
        //            LogUtil.MngError(e.ToString());
        //            return null;
        //        }
        //    }
        //}

        public int update(PlanYearBsWCapital entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" UPDATE PLAN_YEAR_BS_W_CAPITAL SET
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

        public int delete(object key)
        {
            throw new NotImplementedException();
        }

        public int save(PlanYearBsWCapital entity)
        {
            throw new NotImplementedException();
        }

        public void Dispose()
        {
            throw new NotImplementedException();
        }
    }
}