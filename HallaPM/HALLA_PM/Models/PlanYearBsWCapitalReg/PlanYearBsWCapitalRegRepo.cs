using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using Dapper;
using HALLA_PM.Util;

namespace HALLA_PM.Models
{
    public class PlanYearBsWCapitalRegRepo : DbCon, IPlanYearBsWCapitalReg
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
                    string query = " SELECT COUNT(*) FROM PLAN_YEAR_BS_W_CAPITAL_REG " + where;
                    return con.Query<int>(query, param).First();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return -1;
                }
            }
        }

        public PlanYearBsWCapitalReg selectOne(object param)
        {
            throw new NotImplementedException();
        }

        public PlanYearBsWCapitalReg selectOneYear(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
SELECT	*
FROM	PLAN_YEAR_BS				    A
LEFT OUTER JOIN PLAN_YEAR_BS_W_CAPITAL_REG	B ON A.SEQ = B.PLAN_YEAR_BS_SEQ
WHERE	1 = 1
AND		A.YEAR_BS_YEAR = @BsYear
AND		A.ORG_COMPANY_SEQ = @OrgCompanySeq
AND		B.MONTHLY  = @Monthly
";
                    return con.Query<PlanYearBsWCapitalReg>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        //public IEnumerable<PlanYearBsWCapitalReg> selectList(object param)
        //{
        //    using (IDbConnection con = GetHallaDb())
        //    {
        //        try
        //        {
        //            con.Open();

        //            string where = " WHERE 1 = 1 ";

        //            string query = " SELECT	A.*, B.BUSINESS_NAME " +
        //                " FROM PLAN_YEAR_BS_W_CAPITAL_REG 	A " +
        //                "LEFT OUTER JOIN ORG_BUSINESS        B ON A.ORG_BUSINESS_SEQ = B.SEQ WHERE PLAN_MONTHLY_PAL_SEQ = @PlanMonthlyPalSeq";

        //            return con.Query<PlanYearBsWCapitalReg>(query, param).ToList();
        //        }
        //        catch (Exception e)
        //        {
        //            LogUtil.MngError(e.ToString());
        //            return null;
        //        }
        //    }
        //}

        public int insert(PlanYearBsWCapitalReg entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = @" INSERT INTO PLAN_YEAR_BS_W_CAPITAL_REG ( 
                             PLAN_YEAR_BS_SEQ 
                            , YEARLY_YEAR 
                            , MONTHLY 
                            , AR 
                            , AR_TO_DAYS
                            , AP
                            , AP_TO_DAYS
                            , INVENTORY
                            , INVENTORY_TO_DAYS
                             ) VALUES ( 
                             @PlanYearBsSeq 
                            , @YearlyYear
                            , @Monthly
                            , @Ar
                            , @ArToDays 
                            , @Ap
                            , @ApToDays
                            , @Inventory
                            , @InventoryToDays
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

        public PlanYearBsWCapitalReg preYearBsWCapital(object param, string year)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" SELECT ISNULL(SUM(AR),0)                  AS AR
                                            ,ISNULL(SUM(AR_TO_DAYS),0)          AS AR_TO_DAYS
                                            ,ISNULL(SUM(AP), 0)                 AS AP
                                            ,ISNULL(SUM(AP_TO_DAYS),0)          AS AP_TO_DAYS
                                            ,ISNULL(SUM(INVENTORY),0)           AS INVENTORY
                                            ,ISNULL(SUM(INVENTORY_TO_DAYS),0)   AS INVENTORY_TO_DAYS
                                      FROM PLAN_YEAR_BS_W_CAPITAL_REG A
                                      LEFT OUTER JOIN PLAN_YEAR_BS B ON A.PLAN_YEAR_BS_SEQ = B.SEQ
                                      LEFT OUTER JOIN PLAN_YEAR_BS C ON B.ORG_COMPANY_SEQ  = C.ORG_COMPANY_SEQ 
                                      AND A.PLAN_YEAR_BS_SEQ = @PlanYearBsSeq
                                      AND YEARLY_YEAR =" + year;

                    return con.Query<PlanYearBsWCapitalReg>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<PlanYearBsWCapitalReg> selectList(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    
                    string query = @" SELECT * FROM PLAN_YEAR_BS_W_CAPITAL_REG WHERE PLAN_YEAR_BS_SEQ = @PlanYearBsSeq  ORDER BY YEARLY_YEAR, MONTHLY";

                    return con.Query<PlanYearBsWCapitalReg>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public List<PlanYearBsWCapitalReg> selectListBefore(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    // 전년도 12월
                    string query = @"
SELECT	*
FROM	PLAN_YEAR_BS				A
LEFT OUTER JOIN PLAN_YEAR_BS_W_CAPITAL_REG	B ON A.SEQ = B.PLAN_YEAR_BS_SEQ AND A.YEAR_BS_YEAR = B.YEARLY_YEAR
WHERE	1 = 1
AND		A.YEAR_BS_YEAR = @YearlyYear - 1
AND		A.ORG_COMPANY_SEQ = @OrgCompanySeq
AND		B.MONTHLY  = '12'
";
                    //string query = @" SELECT ISNULL(SUM(AR),0)                  AS AR
                    //                        ,ISNULL(SUM(AR_TO_DAYS),0)          AS AR_TO_DAYS
                    //                        ,ISNULL(SUM(AP), 0)                 AS AP
                    //                        ,ISNULL(SUM(AP_TO_DAYS),0)          AS AP_TO_DAYS
                    //                        ,ISNULL(SUM(INVENTORY),0)           AS INVENTORY
                    //                        ,ISNULL(SUM(INVENTORY_TO_DAYS),0)   AS INVENTORY_TO_DAYS 
                    //                    FROM PLAN_YEAR_BS A
                    //                    LEFT OUTER JOIN PLAN_YEAR_BS_W_CAPITAL_REG B ON A.SEQ = B.PLAN_YEAR_BS_SEQ
                    //                    WHERE B.PLAN_YEAR_BS_SEQ = @PlanYearBsSeq
                    //                    AND YEARLY_YEAR = @YearlyYear - 1
                    //                    AND B.MONTHLY = '12' ";

                    return con.Query<PlanYearBsWCapitalReg>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<PlanYearBsWCapitalReg> nowYearBsWCapitalRegList(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" SELECT A.YEARLY_YEAR
                                            ,MONTHLY
                                            ,AR
                                            ,CONVERT(DECIMAL(12, 2), ROUND(CASE WHEN ISNULL(ANNUAL_SALES, 0) = 0 THEN 0 ELSE (AR / ANNUAL_SALES) * 365 END, 2)) AS AR_TO_DAYS
                                            ,AP
                                            ,CONVERT(DECIMAL(12, 2), ROUND(CASE WHEN ISNULL(ANNUAL_SALES_COST, 0) = 0 THEN 0 ELSE (AP / ANNUAL_SALES_COST) * 365 END, 2)) AS AP_TO_DAYS
                                            ,INVENTORY
                                            ,CONVERT(DECIMAL(12, 2), ROUND(CASE WHEN ISNULL(INVENTORY_COST, 0) = 0 THEN 0 ELSE (INVENTORY / INVENTORY_COST) * 365 END, 2)) AS INVENTORY_TO_DAYS
                                            ,D.ANNUAL_SALES
                                            ,D.ANNUAL_SALES_COST
                                            ,A.SEQ AS PLAN_YEAR_BS_W_CAPITAL_REG_SEQ
                                      FROM	PLAN_YEAR_BS_W_CAPITAL_REG	A
                                      LEFT OUTER JOIN PLAN_YEAR_BS	B ON A.PLAN_YEAR_BS_SEQ = B.SEQ
                                      LEFT OUTER JOIN PLAN_YEAR_BS	C ON B.ORG_COMPANY_SEQ = C.ORG_COMPANY_SEQ 
                                      LEFT OUTER JOIN PLAN_YEAR_BS_W_CAPITAL D ON D.PLAN_YEAR_BS_SEQ = A.PLAN_YEAR_BS_SEQ AND D.YEARLY_YEAR = A.YEARLY_YEAR
                                      WHERE	A.PLAN_YEAR_BS_SEQ = @PlanYearBsSeq
                                      AND A.YEARLY_YEAR = @Year
                                      UNION
                                      SELECT A.YEARLY_YEAR
                                            ,'99' AS MONTHLY
                                            ,ISNULL(SUM(AR),0) AS AR
                                            ,CONVERT(DECIMAL(12, 2), ROUND(CASE WHEN ISNULL(SUM(ANNUAL_SALES), 0) = 0 THEN 0 ELSE (SUM(AR) / SUM(ANNUAL_SALES)) * 365 END, 2)) AS AR_TO_DAYS
                                            ,ISNULL(SUM(AP),0) AS AP
                                            ,CONVERT(DECIMAL(12, 2), ROUND(CASE WHEN ISNULL(SUM(ANNUAL_SALES_COST), 0) = 0 THEN 0 ELSE (SUM(AP) / SUM(ANNUAL_SALES_COST)) * 365 END, 2)) AS AP_TO_DAYS
                                            ,ISNULL(SUM(INVENTORY),0) AS INVENTORY
                                            ,CONVERT(DECIMAL(12, 2), ROUND(CASE WHEN ISNULL(SUM(INVENTORY_COST), 0) = 0 THEN 0 ELSE (SUM(INVENTORY) / SUM(INVENTORY_COST)) * 365 END, 2)) AS INVENTORY_TO_DAYS
                                            ,ISNULL(SUM(ANNUAL_SALES),0) AS ANNUAL_SALES
                                            ,ISNULL(SUM(ANNUAL_SALES_COST),0) AS ANNUAL_SALES_COST
                                            ,'0' AS PLAN_YEAR_BS_W_CAPITAL_REG_SEQ
                                      FROM	PLAN_YEAR_BS_W_CAPITAL_REG	A
                                      LEFT OUTER JOIN PLAN_YEAR_BS	B ON A.PLAN_YEAR_BS_SEQ = B.SEQ
                                      LEFT OUTER JOIN PLAN_YEAR_BS_W_CAPITAL D ON D.PLAN_YEAR_BS_SEQ = A.PLAN_YEAR_BS_SEQ AND D.YEARLY_YEAR = A.YEARLY_YEAR
                                      WHERE	A.PLAN_YEAR_BS_SEQ = @PlanYearBsSeq
                                      AND A.YEARLY_YEAR = @Year
                                      GROUP BY A.YEARLY_YEAR";

                    return con.Query<PlanYearBsWCapitalReg>(query, param).ToList();

                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }



        public PlanYearBsWCapitalReg nowYearBsWCapitalRegOneExp(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" 
                        SELECT *
                        FROM PLAN_YEAR_BS A
                        LEFT OUTER JOIN PLAN_YEAR_BS_W_CAPITAL_REG B ON A.SEQ = B.PLAN_YEAR_BS_SEQ AND A.YEAR_BS_YEAR = B.YEARLY_YEAR
                        WHERE 1 = 1
                        AND A.YEAR_BS_YEAR = @yearBsYear
                        AND B.MONTHLY = @monthly
                        AND A.ORG_COMPANY_SEQ = @OrgCompanySeq
                    ";
                    return con.Query<PlanYearBsWCapitalReg>(query, param).FirstOrDefault();

                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }
        public int update(PlanYearBsWCapitalReg entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" UPDATE PLAN_YEAR_BS_W_CAPITAL_REG SET
                                        AR = @Ar
                                        ,AR_TO_DAYS = @ArToDays 
                                        ,AP = @Ap 
                                        ,AP_TO_DAYS = @ApToDays 
                                        ,INVENTORY = @Inventory 
                                        ,INVENTORY_TO_DAYS = @InventoryToDays
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

        public int save(PlanYearBsWCapitalReg entity)
        {
            throw new NotImplementedException();
        }

        public void Dispose()
        {
            throw new NotImplementedException();
        }
    }
}