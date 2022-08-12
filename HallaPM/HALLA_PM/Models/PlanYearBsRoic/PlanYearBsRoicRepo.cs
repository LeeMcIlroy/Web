using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using Dapper;
using HALLA_PM.Util;

namespace HALLA_PM.Models
{
    public class PlanYearBsRoicRepo : DbCon, IPlanYearBsRoicRepo
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
                    string query = " SELECT COUNT(*) FROM PLAN_YEAR_BS_ROIC " + where;
                    return con.Query<int>(query, param).First();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return -1;
                }
            }
        }

        public PlanYearBsRoic selectOne(object param)
        {
            throw new NotImplementedException();
        }

        public PlanYearBsRoic selectOneYear(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
SELECT	*
FROM	PLAN_YEAR_BS				    A
LEFT OUTER JOIN PLAN_YEAR_BS_ROIC   	B ON A.SEQ = B.PLAN_YEAR_BS_SEQ
WHERE	1 = 1
AND		A.YEAR_BS_YEAR = @BsYear
AND		A.ORG_COMPANY_SEQ = @OrgCompanySeq
AND		B.MONTHLY  = @Monthly
";
                    return con.Query<PlanYearBsRoic>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        //public IEnumerable<PlanYearBsRoic> selectList(object param)
        //{
        //    using (IDbConnection con = GetHallaDb())
        //    {
        //        try
        //        {
        //            con.Open();

        //            string where = " WHERE 1 = 1 ";

        //            string query = " SELECT	A.*, B.BUSINESS_NAME " +
        //                " FROM PLAN_YEAR_BS_ROIC 	A " +
        //                "LEFT OUTER JOIN ORG_BUSINESS        B ON A.ORG_BUSINESS_SEQ = B.SEQ WHERE PLAN_MONTHLY_PAL_SEQ = @PlanMonthlyPalSeq";

        //            return con.Query<PlanYearBsRoic>(query, param).ToList();

        //        }
        //        catch (Exception e)
        //        {
        //            LogUtil.MngError(e.ToString());
        //            return null;
        //        }
        //    }
        //}

        public int insert(PlanYearBsRoic entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = @" INSERT INTO  PLAN_YEAR_BS_ROIC ( 
                             PLAN_YEAR_BS_SEQ 
                            , YEARLY_YEAR 
                            , MONTHLY 
                            , AFTER_TAX_OPERATION_PROFIT 
                            , PAIN_IN_CAPITAL 
                            , ROIC 
                             ) VALUES ( 
                             @PlanYearBsSeq 
                            , @YearlyYear
                            , @Monthly
                            , @AfterTaxOperationProfit
                            , @PainInCapital 
                            , @Roic 
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

        public PlanYearBsRoic preYearBsRoic(object param, string year)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" SELECT ISNULL(SUM(AFTER_TAX_OPERATION_PROFIT),0) AS AFTER_TAX_OPERATION_PROFIT
                                            ,ISNULL(SUM(PAIN_IN_CAPITAL),0) AS PAIN_IN_CAPITAL
                                            ,ISNULL(SUM(ROIC), 0) AS ROIC
                                      FROM PLAN_YEAR_BS_ROIC A
                                      LEFT OUTER JOIN PLAN_YEAR_BS B ON A.PLAN_YEAR_BS_SEQ = B.SEQ
                                      LEFT OUTER JOIN PLAN_YEAR_BS C ON B.ORG_COMPANY_SEQ  = C.ORG_COMPANY_SEQ 
                                      AND A.PLAN_YEAR_BS_SEQ = @PlanYearBsSeq
                                      AND YEARLY_YEAR =" + year;

                    return con.Query<PlanYearBsRoic>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<PlanYearBsRoic> nowYearBsRoicList(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" SELECT YEARLY_YEAR
	                                        ,MONTHLY
	                                        ,AFTER_TAX_OPERATION_PROFIT
	                                        ,PAIN_IN_CAPITAL
	                                        ,ROIC
                                            ,A.SEQ AS PLAN_YEAR_BS_ROIC_SEQ
                                      FROM	PLAN_YEAR_BS_ROIC	A
                                      LEFT OUTER JOIN PLAN_YEAR_BS	B ON A.PLAN_YEAR_BS_SEQ = B.SEQ
                                      LEFT OUTER JOIN PLAN_YEAR_BS	C ON B.ORG_COMPANY_SEQ = C.ORG_COMPANY_SEQ 
                                      WHERE	A.PLAN_YEAR_BS_SEQ = @PlanYearBsSeq
                                      AND YEARLY_YEAR = @Year
                                      UNION
                                      SELECT YEARLY_YEAR
	                                        ,'99' AS MONTHLY
	                                        ,ISNULL(SUM(AFTER_TAX_OPERATION_PROFIT),0) AS AFTER_TAX_OPERATION_PROFIT
	                                        ,ISNULL(SUM(PAIN_IN_CAPITAL),0) AS PAIN_IN_CAPITAL
	                                        ,ISNULL(SUM(ROIC),0) AS ROIC
                                            ,'0' AS PLAN_YEAR_BS_ROIC_SEQ
                                      FROM	PLAN_YEAR_BS_ROIC	A
                                      LEFT OUTER JOIN PLAN_YEAR_BS	B ON A.PLAN_YEAR_BS_SEQ = B.SEQ
                                      LEFT OUTER JOIN PLAN_YEAR_BS	C ON B.ORG_COMPANY_SEQ = C.ORG_COMPANY_SEQ 
                                      WHERE	A.PLAN_YEAR_BS_SEQ = @PlanYearBsSeq
                                      AND YEARLY_YEAR = @Year
                                      GROUP BY YEARLY_YEAR";

                    return con.Query<PlanYearBsRoic>(query, param).ToList();

                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public PlanYearBsRoic nowYearBsRoicOneExp(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" 
                        SELECT *
                        FROM PLAN_YEAR_BS A
                        LEFT OUTER JOIN PLAN_YEAR_BS_ROIC B ON A.SEQ = B.PLAN_YEAR_BS_SEQ AND A.YEAR_BS_YEAR = B.YEARLY_YEAR
                        WHERE 1 = 1
                        AND A.YEAR_BS_YEAR = @yearBsYear
                        AND B.MONTHLY = @monthly
                        AND A.ORG_COMPANY_SEQ = @OrgCompanySeq
                    ";

                    return con.Query<PlanYearBsRoic>(query, param).FirstOrDefault();

                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }
        
        public IEnumerable<PlanYearBsRoic> selectList(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" SELECT * FROM PLAN_YEAR_BS_ROIC WHERE PLAN_YEAR_BS_SEQ  = @PlanYearBsSeq";

                    return con.Query<PlanYearBsRoic>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<PlanYearBsRoic> selectListBefore(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
SELECT	*
FROM	PLAN_YEAR_BS				A
LEFT OUTER JOIN PLAN_YEAR_BS_ROIC	B ON A.SEQ = B.PLAN_YEAR_BS_SEQ
WHERE	1 = 1
AND		A.YEAR_BS_YEAR = @YearlyYear - 1
AND		A.ORG_COMPANY_SEQ = @OrgCompanySeq
AND		B.MONTHLY  = '12'
";

                    //string query = @" SELECT ISNULL(SUM(AFTER_TAX_OPERATION_PROFIT),0) AS AFTER_TAX_OPERATION_PROFIT
                    //                        ,ISNULL(SUM(PAIN_IN_CAPITAL),0) AS PAIN_IN_CAPITAL
                    //                        ,ISNULL(SUM(ROIC), 0) AS ROIC
                    //                  FROM PLAN_YEAR_BS_ROIC A
                    //                  LEFT OUTER JOIN PLAN_YEAR_BS B ON A.PLAN_YEAR_BS_SEQ = B.SEQ
                    //                  LEFT OUTER JOIN PLAN_YEAR_BS C ON B.ORG_COMPANY_SEQ  = C.ORG_COMPANY_SEQ 
                    //                  AND A.PLAN_YEAR_BS_SEQ = @PlanYearBsSeq
                    //                  AND YEARLY_YEAR = @YearlyYear - 1 ";

                    return con.Query<PlanYearBsRoic>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }


        public int update(PlanYearBsRoic entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" UPDATE PLAN_YEAR_BS_ROIC SET 
                                    AFTER_TAX_OPERATION_PROFIT = @AfterTaxOperationProfit 
                                    ,PAIN_IN_CAPITAL = @PainInCapital
                                    ,ROIC = @Roic
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

        public int save(PlanYearBsRoic entity)
        {
            throw new NotImplementedException();
        }

        public void Dispose()
        {
            throw new NotImplementedException();
        }
    }
}