using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Data;
using Dapper;
using HALLA_PM.Util;
using HALLA_PM.Core;

namespace HALLA_PM.Models
{
    public class PlanYearBsBsheetRepo : DbCon, IPlanYearBsBsheetRepo
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
                    string query = " SELECT COUNT(*) FROM PLAN_YEAR_BS_BSHEET " + where;
                    return con.Query<int>(query, param).First();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return -1;
                }
            }
        }

        public PlanYearBsBsheet selectOne(object param)
        {
            throw new NotImplementedException();
        }

        public PlanYearBsBsheet selectOneYear(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
SELECT	*
FROM	PLAN_YEAR_BS				    A
LEFT OUTER JOIN PLAN_YEAR_BS_BSHEET 	B ON A.SEQ = B.PLAN_YEAR_BS_SEQ
WHERE	1 = 1
AND		A.YEAR_BS_YEAR = @BsYear
AND		A.ORG_COMPANY_SEQ = @OrgCompanySeq
AND		B.MONTHLY  = @Monthly
";
                    return con.Query<PlanYearBsBsheet>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        /// <summary>
        /// B/S 
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        public IEnumerable<PlanYearBsBsheet> selectList(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" SELECT * FROM PLAN_YEAR_BS_BSHEET WHERE PLAN_YEAR_BS_SEQ = @PlanYearBsSeq ";

                    return con.Query<PlanYearBsBsheet>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public int insert(PlanYearBsBsheet entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = @" INSERT INTO  PLAN_YEAR_BS_BSHEET (
                                         PLAN_YEAR_BS_SEQ 
                                        , YEARLY_YEAR
                                        , MONTHLY
                                        , ASSETS
                                        , CURRENT_ASSETS
                                        , LIABILITIES
                                        , CURRENT_LIABILITIES
                                        , CAPITAL
                                        , CASH
                                        , LOAN
                                        , LIABILITIES_RATE
                                        , CURRENT_RATE
                                         ) VALUES (
                                         @PlanYearBsSeq
                                        , @YearlyYear
                                        , @Monthly
                                        , @Assets
                                        , @CurrentAssets
                                        , @Liabilities
                                        , @CurrentLiabilities
                                        , @Capital
                                        , @Cash
                                        , @Loan
                                        , @LiabilitiesRate
                                        , @CurrentRate
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

        public PlanYearBsBsheet preYearBsSheet(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" SELECT ISNULL(SUM(ASSETS),0)                  AS ASSETS 
                                            ,ISNULL(SUM(CURRENT_ASSETS), 0)         AS CURRENT_ASSETS
                                            ,ISNULL(SUM(LIABILITIES), 0)            AS LIABILITIES 
                                            ,ISNULL(SUM(CURRENT_LIABILITIES), 0)    AS CURRENT_LIABILITIES 
                                            ,ISNULL(SUM(CAPITAL), 0)                AS CAPITAL 
                                            ,ISNULL(SUM(CASH), 0)                   AS CASH 
                                            ,ISNULL(SUM(LOAN), 0)                   AS LOAN 
                                            ,ISNULL(SUM(LIABILITIES_RATE), 0)       AS LIABILITIES_RATE 
                                            ,ISNULL(SUM(CURRENT_RATE), 0)           AS CURRENT_RATE 
                                     FROM PLAN_YEAR_BS_BSHEET A
                                     LEFT OUTER JOIN PLAN_YEAR_BS B ON A.PLAN_YEAR_BS_SEQ = B.SEQ
                                     LEFT OUTER JOIN PLAN_YEAR_BS C ON B.ORG_COMPANY_SEQ  = C.ORG_COMPANY_SEQ 
                                     AND A.PLAN_YEAR_BS_SEQ = @PlanYearBsSeq
                                     AND YEARLY_YEAR = @Year";

                    return con.Query<PlanYearBsBsheet>(query, param).FirstOrDefault();

                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<PlanYearBsBsheet> nowYearBsSheetList(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" SELECT YEARLY_YEAR
	                                        ,MONTHLY
	                                        ,ASSETS
	                                        ,CURRENT_ASSETS
	                                        ,LIABILITIES
	                                        ,CURRENT_LIABILITIES
	                                        ,CAPITAL
	                                        ,CASH
	                                        ,LOAN
	                                        ,CONVERT(DECIMAL(12, 2), ROUND(CASE WHEN ISNULL(A.LIABILITIES, 0) = 0 THEN 0 ELSE (A.LIABILITIES / A.CAPITAL) * 100 END, 2)) AS LIABILITIES_RATE
	                                        ,CONVERT(DECIMAL(12, 2), ROUND(CASE WHEN ISNULL(A.CURRENT_ASSETS, 0) = 0 THEN 0 ELSE (A.CURRENT_ASSETS / A.CURRENT_LIABILITIES) * 100 END, 2)) AS CURRENT_RATE
                                            ,A.SEQ AS PLAN_YEAR_BS_BSHEET_SEQ
                                      FROM	PLAN_YEAR_BS_BSHEET	A
                                      LEFT OUTER JOIN PLAN_YEAR_BS	B ON A.PLAN_YEAR_BS_SEQ = B.SEQ
                                      LEFT OUTER JOIN PLAN_YEAR_BS	C ON B.ORG_COMPANY_SEQ = C.ORG_COMPANY_SEQ 
                                      WHERE	A.PLAN_YEAR_BS_SEQ = @PlanYearBsSeq
                                      AND YEARLY_YEAR = @Year
                                      UNION
                                      SELECT YEARLY_YEAR
	                                        ,'99' AS MONTHLY
	                                        ,ISNULL(SUM(ASSETS) + SUM(CURRENT_ASSETS),0) AS ASSETS
	                                        ,ISNULL(SUM(CURRENT_ASSETS),0) AS CURRENT_ASSETS
	                                        ,ISNULL(SUM(LIABILITIES) + SUM(CURRENT_LIABILITIES),0) AS LIABILITIES
	                                        ,ISNULL(SUM(CURRENT_LIABILITIES),0) AS CURRENT_LIABILITIES
	                                        ,ISNULL(SUM(CAPITAL),0) AS CAPITAL
	                                        ,ISNULL(SUM(CASH),0) AS CASH
	                                        ,ISNULL(SUM(LOAN),0) AS LOAN
	                                        ,ISNULL(SUM(LIABILITIES_RATE),0) AS LIABILITIES_RATE
	                                        ,ISNULL(SUM(CURRENT_RATE),0) AS CURRENT_RATE
                                            ,'0' AS PLAN_YEAR_BS_BSHEET_SEQ
                                      FROM	PLAN_YEAR_BS_BSHEET	A
                                      LEFT OUTER JOIN PLAN_YEAR_BS	B ON A.PLAN_YEAR_BS_SEQ = B.SEQ
                                      WHERE	A.PLAN_YEAR_BS_SEQ = @PlanYearBsSeq
                                      AND YEARLY_YEAR = @Year
                                      GROUP BY YEARLY_YEAR";

                    return con.Query<PlanYearBsBsheet>(query, param).ToList();

                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }


        public int update(PlanYearBsBsheet entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" UPDATE PLAN_YEAR_BS_BSHEET SET 
                                        ASSETS = @Assets
                                        ,CURRENT_ASSETS = @CurrentAssets
                                        ,LIABILITIES = @Liabilities
                                        ,CURRENT_LIABILITIES = @CurrentLiabilities
                                        ,CAPITAL = @Capital
                                        ,CASH = @Cash
                                        ,LOAN = @Loan
                                        ,LIABILITIES_RATE = @LiabilitiesRate
                                        ,CURRENT_RATE = @CurrentRate
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

        /// <summary>
        /// B/S 작년도 실적
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        public IEnumerable<PlanYearBsBsheet> selectListBefore(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
SELECT	*
FROM	PM_BS					A
LEFT OUTER JOIN PM_BS_BSHEET	B ON A.SEQ = B.PM_BS_SEQ
WHERE	1 = 1
AND		A.BS_YEAR = @YearlyYear - 1
AND		A.ORG_COMPANY_SEQ = @OrgCompanySeq
AND		A.MONTHLY = '12'
";

//                    string query = @"
//SELECT	*
//FROM	PLAN_YEAR_BS				A
//LEFT OUTER JOIN PLAN_YEAR_BS_BSHEET	B ON A.SEQ = B.PLAN_YEAR_BS_SEQ
//WHERE	1 = 1
//AND		A.YEAR_BS_YEAR = @YearlyYear - 1
//AND		A.ORG_COMPANY_SEQ = @OrgCompanySeq
//AND		B.MONTHLY  = '12'
//";
                    //string query = @" SELECT ISNULL(SUM(ASSETS),0)                  AS ASSETS 
                    //                  ,ISNULL(SUM(CURRENT_ASSETS), 0)         AS CURRENT_ASSETS
                    //                  ,ISNULL(SUM(LIABILITIES), 0)            AS LIABILITIES 
                    //                  ,ISNULL(SUM(CURRENT_LIABILITIES), 0)    AS CURRENT_LIABILITIES 
                    //                  ,ISNULL(SUM(CAPITAL), 0)                AS CAPITAL 
                    //                  ,ISNULL(SUM(CASH), 0)                   AS CASH 
                    //                  ,ISNULL(SUM(LOAN), 0)                   AS LOAN 
                    //                  ,ISNULL(SUM(LIABILITIES_RATE), 0)       AS LIABILITIES_RATE 
                    //                  ,ISNULL(SUM(CURRENT_RATE), 0)           AS CURRENT_RATE 
                    //                FROM PLAN_YEAR_BS A
                    //                LEFT OUTER JOIN PLAN_YEAR_BS_BSHEET B ON A.SEQ = B.PLAN_YEAR_BS_SEQ
                    //                WHERE PLAN_YEAR_BS_SEQ = @PlanYearBsSeq
                    //                AND YEAR_BS_YEAR = @YearlyYear - 1";

                    return con.Query<PlanYearBsBsheet>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public int delete(object key)
        {
            throw new NotImplementedException();
        }

        public int save(PlanYearBsBsheet entity)
        {
            throw new NotImplementedException();
        }

        public void Dispose()
        {
            throw new NotImplementedException();
        }


        public PlanYearBsBsheet nowYearBsSheetOneExp(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
                                    SELECT *
                                    FROM PLAN_YEAR_BS A
                                    LEFT OUTER JOIN PLAN_YEAR_BS_BSHEET B ON A.SEQ = B.PLAN_YEAR_BS_SEQ AND A.YEAR_BS_YEAR = B.YEARLY_YEAR
                                    WHERE 1 = 1
                                    AND A.YEAR_BS_YEAR = @yearBsYear
                                    AND B.MONTHLY = @monthly
                                    AND A.ORG_COMPANY_SEQ = @OrgCompanySeq
                    ";
                    return con.Query<PlanYearBsBsheet>(query, param).FirstOrDefault();

                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

    }
}