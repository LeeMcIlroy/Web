using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Data;
using Dapper;
using HALLA_PM.Core;
using HALLA_PM.Util;

namespace HALLA_PM.Models
{
    public class PmQuarterPalBusinessRepo : DbCon, IPmQuarterPalBusinessRepo
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
                    string query = @" SELECT COUNT(*) FROM PM_QUARTER_PAL_BUSINESS " + where;
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

        public int insert(PmQuarterPalBusiness entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = @" INSERT INTO PM_QUARTER_PAL_BUSINESS
                                      (
                                           PM_QUARTER_PAL_SEQ
                                           ,ORG_BUSINESS_SEQ
                                           ,BUSINESS_YEAR
                                           ,BUSINESS_QUARTER
                                           ,SALES
                                           ,EBIT
                                           ,EBIT_RATE
                                           ,PBT
                                      )
                                      VALUES
                                      (
                                           @PmQuarterPalSeq
                                           ,@OrgBusinessSeq
                                           ,@BusinessYear
                                           ,@BusinessQuarter
                                           ,@Sales
                                           ,@Ebit
                                           ,@EbitRate
                                           ,@Pbt
                                       )SELECT CAST(SCOPE_IDENTITY() as int);";

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
        /// 실적
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        public IEnumerable<PmQuarterPalBusiness> QuarterResultLastYearList(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" 

SELECT	A.QT AS BUSINESS_QUARTER, A.ORG_BUSINESS_SEQ, SUM(A.SALES) AS SALES, SUM(A.EBIT) AS EBIT, SUM(A.PBT) AS PBT
FROM	(
SELECT	A.PAL_YEAR, A.MONTHLY, DATEPART(QUARTER, A.PAL_YEAR + '-' + A.MONTHLY + '-01') AS QT, A.ORG_COMPANY_SEQ, B.ORG_BUSINESS_SEQ, B.PM_PAL_SEQ, B.SALES, B.EBIT, B.PBT
FROM	PM_PAL						A
LEFT OUTER JOIN PM_PAL_BUSINESS		B ON A.SEQ = B.PM_PAL_SEQ
WHERE	1 = 1
AND		A.PAL_YEAR = @YearlyYear - 1
AND		B.MONTHLY_TYPE = 10
AND		A.ORG_COMPANY_SEQ = @Seq
) A
GROUP BY A.QT, A.ORG_BUSINESS_SEQ

/*SELECT A.ORG_COMPANY_SEQ 
			                                ,ORG_BUSINESS_SEQ
			                                ,QUARTER_PAL_YEAR
			                                ,BUSINESS_QUARTER
			                                ,MONTHLY
			                                ,ISNULL(SALES,0)            AS SALES
			                                ,ISNULL(EBIT,0)             AS EBIT
			                                ,CASE WHEN ISNULL(SALES, 0) = 0 THEN 0 
				                                  WHEN ISNULL(EBIT, 0)  = 0 THEN 0
			                                 ELSE ISNULL(EBIT, 0) / ISNULL(SALES, 0) END AS EBITRATE
			                                ,PBT
                                    FROM PM_QUARTER_PAL A
                                    LEFT OUTER JOIN PM_QUARTER_PAL_BUSINESS B ON A.SEQ = B.PM_QUARTER_PAL_SEQ
                                    LEFT OUTER JOIN ORG_COMPANY C ON A.ORG_COMPANY_SEQ = C.SEQ
                                    LEFT OUTER JOIN ORG_BUSINESS D ON B.ORG_BUSINESS_SEQ = D.SEQ
                                    WHERE 1 = 1
                                    AND A.ORG_COMPANY_SEQ = @Seq
                                    AND QUARTER_PAL_YEAR = @YearlyYear - 1
                                    AND A.MONTHLY = @Monthly
*/";

                    return con.Query<PmQuarterPalBusiness>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }


        /// <summary>
        /// 계획
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        public IEnumerable<PmQuarterPalBusiness> QuarterPlanLastYearList(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" SELECT A.ORG_COMPANY_SEQ
							                ,B.ORG_BUSINESS_SEQ
							                ,MONTHLY_PAL_YEAR
							                ,'1'							AS BUSINESS_QUARTER
							                ,SUM(ISNULL(SALES, 0))		AS SALES
							                ,SUM(ISNULL(EBIT, 0))			AS EBIT
							                ,CASE WHEN SUM(ISNULL(SALES, 0)) = 0 THEN 0 
				                                WHEN SUM(ISNULL(EBIT, 0))  = 0 THEN 0
			                                ELSE SUM(ISNULL(EBIT, 0)) / SUM(ISNULL(SALES, 0)) END AS EBITRATE
							                ,SUM(ISNULL(PBT, 0))			AS PBT
                                    FROM PLAN_MONTHLY_PAL A
                                    LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS B ON A.SEQ = B.PLAN_MONTHLY_PAL_SEQ
                                    WHERE 1 = 1
                                    AND A.ORG_COMPANY_SEQ = @Seq
                                    AND MONTHLY_PAL_YEAR = @YearlyYear
                                    AND MONTHLY BETWEEN '01' AND '03'
                                    GROUP BY ORG_COMPANY_SEQ, ORG_BUSINESS_SEQ, MONTHLY_PAL_YEAR
                                    UNION
                                    SELECT A.ORG_COMPANY_SEQ
							                ,B.ORG_BUSINESS_SEQ
							                ,MONTHLY_PAL_YEAR
							                ,'2'							AS BUSINESS_QUARTER
							                ,SUM(ISNULL(SALES, 0))		AS SALES
							                ,SUM(ISNULL(EBIT, 0))			AS EBIT
							                ,CASE WHEN SUM(ISNULL(SALES, 0)) = 0 THEN 0 
				                                WHEN SUM(ISNULL(EBIT, 0))  = 0 THEN 0
			                                ELSE SUM(ISNULL(EBIT, 0)) / SUM(ISNULL(SALES, 0)) END AS EBITRATE
							                ,SUM(ISNULL(PBT, 0))			AS PBT
                                    FROM PLAN_MONTHLY_PAL A
                                    LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS B ON A.SEQ = B.PLAN_MONTHLY_PAL_SEQ
                                    WHERE 1 = 1
                                    AND A.ORG_COMPANY_SEQ = @Seq
                                    AND MONTHLY_PAL_YEAR = @YearlyYear
                                    AND MONTHLY BETWEEN '04' AND '06'
                                    GROUP BY ORG_COMPANY_SEQ, ORG_BUSINESS_SEQ, MONTHLY_PAL_YEAR
                                    UNION
                                    SELECT A.ORG_COMPANY_SEQ
							                ,B.ORG_BUSINESS_SEQ
							                ,MONTHLY_PAL_YEAR
							                ,'3'							AS BUSINESS_QUARTER
							                ,SUM(ISNULL(SALES, 0))		AS SALES
							                ,SUM(ISNULL(EBIT, 0))			AS EBIT
							                ,CASE WHEN SUM(ISNULL(SALES, 0)) = 0 THEN 0 
				                                WHEN SUM(ISNULL(EBIT, 0))  = 0 THEN 0
			                                ELSE SUM(ISNULL(EBIT, 0)) / SUM(ISNULL(SALES, 0)) END AS EBITRATE
							                ,SUM(ISNULL(PBT, 0))			AS PBT
                                    FROM PLAN_MONTHLY_PAL A
                                    LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS B ON A.SEQ = B.PLAN_MONTHLY_PAL_SEQ
                                    WHERE 1 = 1
                                    AND A.ORG_COMPANY_SEQ = @Seq
                                    AND MONTHLY_PAL_YEAR = @YearlyYear
                                    AND MONTHLY BETWEEN '07' AND '09'
                                    GROUP BY ORG_COMPANY_SEQ, ORG_BUSINESS_SEQ, MONTHLY_PAL_YEAR
                                    UNION
                                    SELECT A.ORG_COMPANY_SEQ
							                ,B.ORG_BUSINESS_SEQ
							                ,MONTHLY_PAL_YEAR
							                ,'4'							AS BUSINESS_QUARTER
							                ,SUM(ISNULL(SALES, 0))		AS SALES
							                ,SUM(ISNULL(EBIT, 0))			AS EBIT
							                ,CASE WHEN SUM(ISNULL(SALES, 0)) = 0 THEN 0 
				                                WHEN SUM(ISNULL(EBIT, 0))  = 0 THEN 0
			                                ELSE SUM(ISNULL(EBIT, 0)) / SUM(ISNULL(SALES, 0)) END AS EBITRATE
							                ,SUM(ISNULL(PBT, 0))			AS PBT
                                    FROM PLAN_MONTHLY_PAL A
                                    LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS B ON A.SEQ = B.PLAN_MONTHLY_PAL_SEQ
                                    WHERE 1 = 1
                                    AND A.ORG_COMPANY_SEQ = @Seq
                                    AND MONTHLY_PAL_YEAR = @YearlyYear
                                    AND MONTHLY BETWEEN '10' AND '12'
                                    GROUP BY ORG_COMPANY_SEQ, ORG_BUSINESS_SEQ, MONTHLY_PAL_YEAR";

                    return con.Query<PmQuarterPalBusiness>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        /// <summary>
        /// 실적
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        public IEnumerable<PmQuarterPalBusiness> QuarterExpectThisYearList(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" SELECT A.ORG_COMPANY_SEQ 
			                                ,ORG_BUSINESS_SEQ
			                                ,QUARTER_PAL_YEAR
			                                ,BUSINESS_QUARTER
			                                ,MONTHLY
			                                ,ISNULL(SALES,0)            AS SALES
			                                ,ISNULL(EBIT,0)             AS EBIT
			                                ,CASE WHEN ISNULL(SALES, 0) = 0 THEN 0 
				                                  WHEN ISNULL(EBIT, 0)  = 0 THEN 0
			                                 ELSE ISNULL(EBIT, 0) / ISNULL(SALES, 0) END AS EBITRATE
			                                ,PBT
                                            ,B.SEQ						AS PM_QUARTER_PAL_BUSINESS_SEQ
                                    FROM PM_QUARTER_PAL A
                                    LEFT OUTER JOIN PM_QUARTER_PAL_BUSINESS B ON A.SEQ = B.PM_QUARTER_PAL_SEQ
                                    LEFT OUTER JOIN ORG_COMPANY C ON A.ORG_COMPANY_SEQ = C.SEQ
                                    LEFT OUTER JOIN ORG_BUSINESS D ON B.ORG_BUSINESS_SEQ = D.SEQ
                                    WHERE 1 = 1
                                    AND A.ORG_COMPANY_SEQ = @Seq
                                    AND QUARTER_PAL_YEAR = @YearlyYear
                                    AND A.MONTHLY = @Monthly";

                    return con.Query<PmQuarterPalBusiness>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public int save(PmQuarterPalBusiness entity)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<PmQuarterPalBusiness> selectList(object param)
        {
            throw new NotImplementedException();
        }

        public PmQuarterPalBusiness selectOne(object param)
        {
            throw new NotImplementedException();
        }

        public int update(PmQuarterPalBusiness entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = @" UPDATE PM_QUARTER_PAL_BUSINESS SET
                                      SALES = @Sales
                                     ,EBIT = @Ebit
                                     ,EBIT_RATE = @EbitRate
                                     ,PBT = @Pbt
                                     WHERE SEQ = @Seq
                                    ; SELECT @@ROWCOUNT ";
                    return con.Query<int>(query, entity).First();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return -1;
                }
            }
        }

        public IEnumerable<PmQuarterPalBusiness> selectListExcel(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string where = " WHERE 1 = 1 ";

                    string query = @" 
SELECT	A.PM_QUARTER_PAL_SEQ
		, A.SEQ
		, A.ORG_BUSINESS_SEQ
		, B.BUSINESS_NAME
		, C.COMPANY_NAME
		, A.BUSINESS_YEAR
        , BUSINESS_QUARTER
		, A.SALES
		, A.EBIT
		, A.PBT
FROM	PM_QUARTER_PAL_BUSINESS	A
LEFT OUTER JOIN ORG_BUSINESS		B ON A.ORG_BUSINESS_SEQ = B.SEQ
LEFT OUTER JOIN ORG_COMPANY			C ON B.ORG_COMPANY_SEQ = C.SEQ
WHERE	A.PM_QUARTER_PAL_SEQ = @PmQuarterPalSeq
                        ";

                    return con.Query<PmQuarterPalBusiness>(query, param).ToList();

                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        /// <summary>
        /// 당해년도 연간예상(분기) Bu
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        public IEnumerable<PmQuarterPalBusinessExp> selectListPmThisYear(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
SELECT	A.QUARTER_PAL_YEAR
		, A.MONTHLY
		--, DATEPART(QUARTER, A.QUARTER_PAL_YEAR + '-' + A.MONTHLY + '-01') AS QT
		, B.BUSINESS_QUARTER
		, ISNULL(B.SALES, 0.00)							AS SALES
		, ISNULL(B.EBIT, 0.00)							AS EBIT
		, ISNULL(B.PBT, 0.00)							AS PBT
		, C.ORG_UNION_SEQ
		, E.UNION_NAME
		, A.ORG_COMPANY_SEQ
		, C.COMPANY_NAME
		, B.ORG_BUSINESS_SEQ
		, D.BUSINESS_NAME
FROM	PM_QUARTER_PAL						A
LEFT OUTER JOIN PM_QUARTER_PAL_BUSINESS			B ON A.SEQ = B.PM_QUARTER_PAL_SEQ
LEFT OUTER JOIN ORG_COMPANY					C ON A.ORG_COMPANY_SEQ = C.SEQ
LEFT OUTER JOIN ORG_BUSINESS				D ON B.ORG_BUSINESS_SEQ = D.SEQ
LEFT OUTER JOIN ORG_UNION					E ON C.ORG_UNION_SEQ = E.SEQ
WHERE	1 = 1
AND		A.QUARTER_PAL_YEAR = @year
AND		A.MONTHLY = @mm
AND     A.REGIST_STATUS = " + Define.REGIST_STATUS.GetKey("최종승인") + @"
ORDER BY C.ORG_UNION_SEQ, A.ORG_COMPANY_SEQ, B.ORG_BUSINESS_SEQ
";

                    return con.Query<PmQuarterPalBusinessExp>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        /// <summary>
        /// 전년도 실적(분기) Bu
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        public IEnumerable<PmQuarterPalBusinessExp> selectListPmLastYear(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
SELECT	A.PAL_YEAR									AS QUARTER_PAL_YEAR
		--, A.MONTHLY
		, DATEPART(QUARTER, A.PAL_YEAR + '-' + A.MONTHLY + '-01') AS BUSINESS_QUARTER
		--, B.MONTHLY_TYPE
		, SUM(ISNULL(B.SALES, 0.00))						AS SALES
		, SUM(ISNULL(B.EBIT, 0.00))						AS EBIT
		, SUM(ISNULL(B.PBT, 0.00))						AS PBT
		, C.ORG_UNION_SEQ
		, E.UNION_NAME
		, A.ORG_COMPANY_SEQ
		, C.COMPANY_NAME
		, B.ORG_BUSINESS_SEQ
		, D.BUSINESS_NAME
FROM	PM_PAL										A
LEFT OUTER JOIN PM_PAL_BUSINESS							B ON A.SEQ = B.PM_PAL_SEQ
LEFT OUTER JOIN ORG_COMPANY					C ON A.ORG_COMPANY_SEQ = C.SEQ
LEFT OUTER JOIN ORG_BUSINESS				D ON B.ORG_BUSINESS_SEQ = D.SEQ
LEFT OUTER JOIN ORG_UNION					E ON C.ORG_UNION_SEQ = E.SEQ
WHERE	1 = 1
AND		A.PAL_YEAR = @year - 1
AND		B.MONTHLY_TYPE =  " + Define.MONTHLY_TYPE.GetKey("당월") + @"
AND     A.REGIST_STATUS = " + Define.REGIST_STATUS.GetKey("최종승인") + @"
GROUP BY A.PAL_YEAR
		--, A.MONTHLY
		, DATEPART(QUARTER, A.PAL_YEAR + '-' + A.MONTHLY + '-01')
		, C.ORG_UNION_SEQ
		, E.UNION_NAME
		, A.ORG_COMPANY_SEQ
		, C.COMPANY_NAME
		, B.ORG_BUSINESS_SEQ
		, D.BUSINESS_NAME
";

                    return con.Query<PmQuarterPalBusinessExp>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        /// <summary>
        /// 전년도 계획(분기) Bu
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        public IEnumerable<PmQuarterPalBusinessExp> selectListPnThisYear(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
SELECT	A.MONTHLY_PAL_YEAR								AS QUARTER_PAL_YEAR
		--, B.MONTHLY
		, DATEPART(QUARTER, A.MONTHLY_PAL_YEAR + '-' + B.MONTHLY + '-01') AS BUSINESS_QUARTER
		, SUM(ISNULL(B.SALES, 0.00))						AS SALES
		, SUM(ISNULL(B.EBIT, 0.00))						AS EBIT
		, SUM(ISNULL(B.PBT, 0.00))						AS PBT
		, C.ORG_UNION_SEQ
		, E.UNION_NAME
		, A.ORG_COMPANY_SEQ
		, C.COMPANY_NAME
		, B.ORG_BUSINESS_SEQ
		, D.BUSINESS_NAME
FROM	PLAN_MONTHLY_PAL									A
LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS						B ON A.SEQ = B.PLAN_MONTHLY_PAL_SEQ
LEFT OUTER JOIN ORG_COMPANY					C ON A.ORG_COMPANY_SEQ = C.SEQ
LEFT OUTER JOIN ORG_BUSINESS				D ON B.ORG_BUSINESS_SEQ = D.SEQ
LEFT OUTER JOIN ORG_UNION					E ON C.ORG_UNION_SEQ = E.SEQ
WHERE	1 = 1
AND		A.MONTHLY_PAL_YEAR = @year
AND     A.REGIST_STATUS = " + Define.REGIST_STATUS.GetKey("최종승인") + @"
GROUP BY A.MONTHLY_PAL_YEAR
		--, A.MONTHLY
		, DATEPART(QUARTER, A.MONTHLY_PAL_YEAR + '-' + B.MONTHLY + '-01')
		, C.ORG_UNION_SEQ
		, E.UNION_NAME
		, A.ORG_COMPANY_SEQ
		, C.COMPANY_NAME
		, B.ORG_BUSINESS_SEQ
		, D.BUSINESS_NAME
";

                    return con.Query<PmQuarterPalBusinessExp>(query, param).ToList();
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