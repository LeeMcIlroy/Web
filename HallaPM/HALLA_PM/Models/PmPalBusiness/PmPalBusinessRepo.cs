using Dapper;
using HALLA_PM.Util;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using HALLA_PM.Core;
namespace HALLA_PM.Models
{
    public class PmPalBusinessRepo : DbCon, IPmPalBusinessRepo
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
                    string query = @" SELECT COUNT(*) FROM PM_PAL_BUSINESS " + where;
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

        public int insert(PmPalBusiness entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = @" INSERT INTO PM_PAL_BUSINESS
                                      (
			                            PM_PAL_SEQ
			                            ,ORG_BUSINESS_SEQ
			                            ,MONTHLY_TYPE
			                            ,SALES
			                            ,EBIT
			                            ,EBIT_RATE
			                            ,PBT
		                              )
		                              VALUES
		                              (
			                            @PmPalSeq
			                            ,@OrgBusinessSeq
			                            ,@MonthlyType
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

        public int save(PmPalBusiness entity)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<PmPalBusiness> selectList(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" SELECT * FROM PLAN_YEAR_BS_BSHEET WHERE PLAN_YEAR_BS_SEQ = @PlanYearBsSeq ";

                    return con.Query<PmPalBusiness>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public PmPalBusiness selectOne(object param)
        {
            throw new NotImplementedException();
        }

        public int update(PmPalBusiness entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = @" UPDATE PM_PAL_BUSINESS SET
                                      SALES = @Sales
                                     ,EBIT = @Ebit
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

        public IEnumerable<PmPalBusiness> selectListBefore(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
SELECT	*
FROM	PM_PAL					A
LEFT OUTER JOIN PM_PAL_BUSINESS	B ON A.SEQ = B.PM_PAL_SEQ
WHERE	1 = 1
AND		A.PAL_YEAR = @YearPalYear - 1
AND		A.ORG_COMPANY_SEQ = @OrgCompanySeq
AND		A.MONTHLY = '12'
AND		B.MONTHLY_TYPE = " + Define.MONTHLY_TYPE.GetKey("누계") + @"
";

                    return con.Query<PmPalBusiness>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }


        public PmPalBusinessSummaryForPlan selectSummaryOne(object param)
        {

            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = "";
                    query += " SELECT B.ORG_BUSINESS_SEQ, SUM(B.SALES) AS SALES, SUM(B.EBIT) AS EBIT ";
                    query += " FROM PM_PAL A ";
                    query += "     , PM_PAL_BUSINESS B ";
                    query += " WHERE A.SEQ = B.PM_PAL_SEQ ";
                    query += "     AND A.REGIST_STATUS = " + Define.REGIST_STATUS.GetKey("최종승인")  ;
                    query += "     AND A.PAL_YEAR = @palYear ";
                    query += "     AND A.MONTHLY = '12' ";
                    query += "     AND A.ORG_COMPANY_SEQ = @orgCompanySeq ";
                    query += "     AND B.ORG_BUSINESS_SEQ = @orgBusinessSeq ";
                    // 전년도 데이터
                    query += "     AND B.MONTHLY_TYPE = " + Define.MONTHLY_TYPE.GetKey("누계");
                    query += " GROUP BY ORG_BUSINESS_SEQ ";

                    return con.Query<PmPalBusinessSummaryForPlan>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }
        
        public IEnumerable<PmPalBusiness> selectListLastYear(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    // 전년도 연간 : 전년도 12월의 누계실적
                    // 전년도 당월 : 전년도 해당월의 실적
                    // 전년도 누계 : 전년도 해당월의 누계실적
                    string query = @" --연간
                                         SELECT '1'												 AS KIND
	                                           ,A.PAL_YEAR										 AS PAL_YEAR
	                                           ,'9999'											 AS MONTHLY
	                                           ,SUM(B.SALES)									 AS SALES
	                                           ,SUM(B.EBIT)										 AS EBIT
	                                           ,ISNULL(ROUND(SUM(B.EBIT_RATE) / COUNT(*), 0), 0) AS EBIT_RATE
	                                           ,SUM(B.PBT)										 AS PBT
	                                           ,A.ORG_COMPANY_SEQ
	                                           ,B.ORG_BUSINESS_SEQ
                                               ,B.MONTHLY_TYPE
                                         FROM PM_PAL A
                                         LEFT OUTER JOIN PM_PAL_BUSINESS B ON A.SEQ = B.PM_PAL_SEQ
                                         WHERE 1 = 1
                                         AND A.ORG_COMPANY_SEQ = @Seq
                                         AND B.MONTHLY_TYPE = " + Define.MONTHLY_TYPE.GetKey("누계") + @"
                                         AND A.PAL_YEAR =  @YearlyYear - 1
                                         AND A.MONTHLY = '12'
                                         GROUP BY PAL_YEAR, ORG_BUSINESS_SEQ, ORG_COMPANY_SEQ, B.MONTHLY_TYPE
                                         UNION 
                                         --당월
                                         SELECT '2' AS KIND
		                                        ,A.PAL_YEAR
		                                        ,MONTHLY
		                                        ,B.SALES
		                                        ,B.EBIT
		                                        ,ISNULL(B.EBIT_RATE, 0) AS EBIT_RATE
		                                        ,B.PBT
		                                        ,A.ORG_COMPANY_SEQ
		                                        ,B.ORG_BUSINESS_SEQ
                                                ,B.MONTHLY_TYPE
                                         FROM PM_PAL A
                                         LEFT OUTER JOIN PM_PAL_BUSINESS B ON A.SEQ = B.PM_PAL_SEQ
                                         WHERE 1 = 1
                                         AND A.ORG_COMPANY_SEQ = @Seq
                                         AND B.MONTHLY_TYPE = " + Define.MONTHLY_TYPE.GetKey("당월") + @"
                                         AND A.PAL_YEAR = @YearlyYear - 1
                                         AND A.MONTHLY = @Monthly
                                         UNION 
                                         --누계
                                         SELECT	'3' AS KIND
		                                        ,A.PAL_YEAR
		                                        ,MONTHLY
		                                        ,B.SALES
		                                        ,B.EBIT
		                                        ,ISNULL(B.EBIT_RATE, 0) AS EBIT_RATE
		                                        ,B.PBT
		                                        ,A.ORG_COMPANY_SEQ
		                                        ,B.ORG_BUSINESS_SEQ
                                                ,B.MONTHLY_TYPE
                                         FROM PM_PAL A
                                         LEFT OUTER JOIN PM_PAL_BUSINESS B ON A.SEQ = B.PM_PAL_SEQ
                                         WHERE 1 = 1
                                         AND A.ORG_COMPANY_SEQ = @Seq
                                         AND B.MONTHLY_TYPE = " + Define.MONTHLY_TYPE.GetKey("누계") + @"
                                         AND A.PAL_YEAR =  @YearlyYear - 1
                                         AND A.MONTHLY = @Monthly";

                    return con.Query<PmPalBusiness>(query, param).ToList();
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
        public IEnumerable<PmPalBusiness> selectListPlanThisYear(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" SELECT A.ORG_COMPANY_SEQ 
                                            ,ORG_BUSINESS_SEQ
                                            ,MONTHLY_PAL_YEAR
	                                        ,MONTHLY
	                                        ,SALES
	                                        ,EBIT
	                                        ,EBIT_RATE
	                                        ,PBT
                                     FROM PLAN_MONTHLY_PAL A
                                     LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS B ON A.SEQ = B.PLAN_MONTHLY_PAL_SEQ
                                     LEFT OUTER JOIN ORG_COMPANY C ON A.ORG_COMPANY_SEQ = C.SEQ
                                     LEFT OUTER JOIN ORG_BUSINESS D ON B.ORG_BUSINESS_SEQ = D.SEQ
                                     WHERE 1 = 1
                                     AND A.ORG_COMPANY_SEQ = @Seq
                                     AND A.MONTHLY_PAL_YEAR = @YearlyYear
                                     AND B.MONTHLY = @Monthly";

                    return con.Query<PmPalBusiness>(query, param).ToList();
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
        public IEnumerable<PmPalBusiness> selectListPlanMonthlyThisYear(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" --당월 계획
                                     SELECT ISNULL(B.SALES, 0)      AS SALES
									       ,ISNULL(B.EBIT, 0)       AS EBIT
										   ,ISNULL(B.PBT, 0)	    AS PBT
										   ,A.ORG_COMPANY_SEQ
										   ,B.ORG_BUSINESS_SEQ
                                     FROM PLAN_MONTHLY_PAL A
                                     LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS B ON A.SEQ = B.PLAN_MONTHLY_PAL_SEQ
                                     WHERE 1 = 1
                                     AND A.ORG_COMPANY_SEQ = @Seq
                                     AND A.MONTHLY_PAL_YEAR = @YearlyYear
                                     AND B.MONTHLY = @Monthly";

                    return con.Query<PmPalBusiness>(query, param).ToList();
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
        public IEnumerable<PmPalBusiness> selectListMonthlyThisYear(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" --당월 계획
                                     SELECT A.PAL_YEAR
	                                       ,A.MONTHLY 
                                           ,B.SALES
                                           ,B.EBIT
                                           ,ISNULL(B.EBIT_RATE, 0) AS EBIT_RATE
                                           ,B.PBT
                                           ,A.ORG_COMPANY_SEQ
                                           ,B.ORG_BUSINESS_SEQ
                                           ,B.SEQ AS 'PM_PAL_BUSSINESS_SEQ'
                                           ,B.MONTHLY_TYPE
                                     FROM PM_PAL A
                                     LEFT OUTER JOIN PM_PAL_BUSINESS B ON A.SEQ = B.PM_PAL_SEQ
                                     WHERE 1 = 1
                                     AND MONTHLY_TYPE = " + Define.MONTHLY_TYPE.GetKey("당월") + @"
                                     AND A.ORG_COMPANY_SEQ = @Seq
                                     AND A.PAL_YEAR = @YearlyYear
                                     AND A.MONTHLY = @Monthly";

                    return con.Query<PmPalBusiness>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }


        public IEnumerable<PmPalBusiness> selectListMonthlyPlanThisYear(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"--누계
                                      SELECT SUM(ISNULL(SALES, 0)) AS SALES
                                            ,SUM(ISNULL(EBIT, 0))  AS EBIT
                                            ,SUM(ISNULL(PBT, 0))   AS PBT
                                            ,CASE WHEN SUM(ISNULL(SALES, 0)) = 0 THEN 0 
				                                  WHEN SUM(ISNULL(EBIT, 0))  = 0 THEN 0
			                                 ELSE SUM(ISNULL(EBIT, 0)) / SUM(ISNULL(SALES, 0)) END AS 'EBITRATE'
                                            ,A.ORG_COMPANY_SEQ
                                            ,D.SEQ	   AS ORG_BUSINESS_SEQ
                                        FROM PLAN_MONTHLY_PAL A
                                        LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS B ON A.SEQ = B.PLAN_MONTHLY_PAL_SEQ
                                        LEFT OUTER JOIN ORG_COMPANY C ON A.ORG_COMPANY_SEQ = C.SEQ
                                        LEFT OUTER JOIN ORG_BUSINESS D ON B.ORG_BUSINESS_SEQ = D.SEQ
                                        WHERE 1 = 1
                                        AND A.ORG_COMPANY_SEQ = @Seq
                                        AND A.MONTHLY_PAL_YEAR = @YearlyYear
                                        AND B.MONTHLY <= @Monthly
                                        GROUP BY A.ORG_COMPANY_SEQ, D.SEQ";

                    return con.Query<PmPalBusiness>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<PmPalBusiness> selectListMonthlyCountThisYear(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"--누계
                                     SELECT PAL_YEAR
                                           ,A.MONTHLY
                                           ,SUM(B.SALES)										AS SALES
                                           ,SUM(B.EBIT)										    AS EBIT
                                           ,ROUND(ISNULL(SUM(B.EBIT_RATE), 0) / COUNT(*), 0)    AS EBIT_RATE
                                           ,SUM(B.PBT)										    AS PBT
                                           ,A.ORG_COMPANY_SEQ
                                           ,B.ORG_BUSINESS_SEQ
                                           ,B.SEQ AS 'PM_PAL_BUSSINESS_SEQ'
                                           ,B.MONTHLY_TYPE
                                     FROM PM_PAL A
                                     LEFT OUTER JOIN PM_PAL_BUSINESS B ON A.SEQ = B.PM_PAL_SEQ
                                     LEFT OUTER JOIN ORG_COMPANY C ON A.ORG_COMPANY_SEQ = C.SEQ
                                     LEFT OUTER JOIN ORG_BUSINESS D ON B.ORG_BUSINESS_SEQ = D.SEQ
                                     WHERE 1 = 1
                                     AND A.ORG_COMPANY_SEQ = @Seq
                                     AND MONTHLY_TYPE = " + Define.MONTHLY_TYPE.GetKey("누계") + @"
                                     AND A.PAL_YEAR = @YearlyYear
                                     AND A.MONTHLY = @Monthly
                                     GROUP BY PAL_YEAR, A.MONTHLY, A.ORG_COMPANY_SEQ, B.ORG_BUSINESS_SEQ, B.MONTHLY_TYPE, B.SEQ";

                    return con.Query<PmPalBusiness>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<PmPalBusiness> selectListExpectPlanThisYear(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"SELECT SUM(ISNULL(SALES, 0)) AS SALES
                                            ,SUM(ISNULL(EBIT, 0))  AS EBIT
                                            ,SUM(ISNULL(PBT, 0))   AS PBT
                                            ,CASE WHEN SUM(ISNULL(SALES, 0)) = 0 THEN 0 
				                                  WHEN SUM(ISNULL(EBIT, 0))  = 0 THEN 0
			                                 ELSE SUM(ISNULL(EBIT, 0)) / SUM(ISNULL(SALES, 0)) END AS 'EBITRATE'
                                            ,A.ORG_COMPANY_SEQ
                                            ,D.SEQ	   AS ORG_BUSINESS_SEQ
                                        FROM PLAN_MONTHLY_PAL A
                                        LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS B ON A.SEQ = B.PLAN_MONTHLY_PAL_SEQ
                                        LEFT OUTER JOIN ORG_COMPANY C ON A.ORG_COMPANY_SEQ = C.SEQ
                                        LEFT OUTER JOIN ORG_BUSINESS D ON B.ORG_BUSINESS_SEQ = D.SEQ
                                        WHERE 1 = 1
                                        AND A.ORG_COMPANY_SEQ = @Seq
                                        AND A.MONTHLY_PAL_YEAR = @YearlyYear
                                        AND B.MONTHLY <= 12
                                        GROUP BY A.ORG_COMPANY_SEQ, D.SEQ";

                    return con.Query<PmPalBusiness>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<PmPalBusiness> selectListExpectThisYear(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" SELECT ISNULL(SALES, 0) AS SALES
		                                    ,ISNULL(EBIT, 0)  AS EBIT
		                                    ,ISNULL(PBT, 0)   AS PBT
		                                    ,CASE WHEN ISNULL(SALES, 0) = 0 THEN 0 
                                                  WHEN ISNULL(EBIT, 0)  = 0 THEN 0
                                             ELSE ISNULL(EBIT, 0) / ISNULL(SALES, 0) END AS 'EBITRATE'
                                            ,B.MONTHLY_TYPE
                                            ,B.SEQ      AS 'PM_PAL_BUSSINESS_SEQ'
                                            ,D.SEQ	    AS ORG_BUSINESS_SEQ
                                     FROM PM_PAL A 
                                     LEFT OUTER JOIN PM_PAL_BUSINESS B ON A.SEQ = B.PM_PAL_SEQ
                                     LEFT OUTER JOIN ORG_COMPANY C ON A.ORG_COMPANY_SEQ = C.SEQ
                                     LEFT OUTER JOIN ORG_BUSINESS D ON B.ORG_BUSINESS_SEQ = D.SEQ
                                     WHERE A.ORG_COMPANY_SEQ = @Seq
                                     AND MONTHLY_TYPE = " + Define.MONTHLY_TYPE.GetKey("연간") + @"
                                     AND A.PAL_YEAR = @YearlyYear
                                     AND A.MONTHLY = @Monthly ";

                    return con.Query<PmPalBusiness>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        /// <summary>
        /// 손익분석
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        public IEnumerable<PmPalAnalysis> selectListAnalysisMonthlyContent(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" SELECT PM_PAL_SEQ 
			                                ,MONTHLY_CONTENT
			                                ,MONTHLY_VALUE
			                                ,CUMULATIVE_CONTENT 
			                                ,CUMULATIVE_VALUE
                                            ,B.SEQ					AS PM_PAL_ANALYSIS_SEQ
                                        FROM PM_PAL A
                                        LEFT OUTER JOIN PM_PAL_ANALYSIS B ON A.SEQ = B.PM_PAL_SEQ
                                        WHERE 1 = 1
                                        --AND B.PM_PAL_SEQ = @Seq
AND A.ORG_COMPANY_SEQ = @OrgCompanySeq
                                        AND A.PAL_YEAR = @YearlyYear
                                        AND A.MONTHLY = @Monthly
                                        AND B.ANALYSIS = @Analysis ";

                    return con.Query<PmPalAnalysis>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        /// <summary>
        /// 당해년도실적 Bu
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        public IEnumerable<PmPalBusinessExp> selectListPmThisYear(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
-- 당해년도 실적 <만도(BU) => 14, HL Klemove => 19, 만도헬라 => 4 제외>

SELECT	A.PAL_YEAR
		, A.MONTHLY
		, B.MONTHLY_TYPE
		, ISNULL(B.SALES, 0)				AS SALES
		, ISNULL(B.EBIT, 0)					AS EBIT
		, ISNULL(B.PBT, 0)					AS PBT
		, C.ORG_UNION_SEQ
		, E.UNION_NAME
		, A.ORG_COMPANY_SEQ
		, C.COMPANY_NAME
		, B.ORG_BUSINESS_SEQ
		, D.BUSINESS_NAME
FROM	PM_PAL										A
LEFT OUTER JOIN PM_PAL_BUSINESS						B ON A.SEQ = B.PM_PAL_SEQ
LEFT OUTER JOIN ORG_COMPANY							C ON A.ORG_COMPANY_SEQ = C.SEQ
LEFT OUTER JOIN ORG_BUSINESS				D ON B.ORG_BUSINESS_SEQ = D.SEQ
LEFT OUTER JOIN ORG_UNION					E ON C.ORG_UNION_SEQ = E.SEQ
WHERE	1 = 1
AND		A.PAL_YEAR = @year
AND		A.MONTHLY = @mm

AND     A.REGIST_STATUS = " + Define.REGIST_STATUS.GetKey("최종승인");


                    return con.Query<PmPalBusinessExp>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        /// <summary>
        /// 전년실적 연간 Bu
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        public IEnumerable<PmPalBusinessExp> selectListPmLastYear(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
-- 전년실적 : 연간<만도(BU) => 14, HL Klemove => 19, 만도헬라 => 4 제외>
SELECT	A.PAL_YEAR
		, A.MONTHLY
		, B.MONTHLY_TYPE
		, ISNULL(B.SALES, 0)				AS SALES
		, ISNULL(B.EBIT, 0)					AS EBIT
		, ISNULL(B.PBT, 0)					AS PBT
		, C.ORG_UNION_SEQ
		, E.UNION_NAME
		, A.ORG_COMPANY_SEQ
		, C.COMPANY_NAME
		, B.ORG_BUSINESS_SEQ
		, D.BUSINESS_NAME
FROM	PM_PAL										A
LEFT OUTER JOIN PM_PAL_BUSINESS						B ON A.SEQ = B.PM_PAL_SEQ
LEFT OUTER JOIN ORG_COMPANY					C ON A.ORG_COMPANY_SEQ = C.SEQ
LEFT OUTER JOIN ORG_BUSINESS				D ON B.ORG_BUSINESS_SEQ = D.SEQ
LEFT OUTER JOIN ORG_UNION					E ON C.ORG_UNION_SEQ = E.SEQ
WHERE	1 = 1
AND		A.PAL_YEAR = @year -1
AND     C.SEQ NOT  IN('14','19','4')
AND     A.REGIST_STATUS = " + Define.REGIST_STATUS.GetKey("최종승인");


                    return con.Query<PmPalBusinessExp>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        /// <summary>
        /// 당해년도 계획 연간 Bu
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        public IEnumerable<PmPalBusinessExp> selectListPnThisYear(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
-- 당해년도 계획 <만도(BU) => 14, HL Klemove => 19, 만도헬라 => 4 제외>
SELECT	A.YEAR_PAL_YEAR						AS PAL_YEAR
		, B.MONTHLY
		, ISNULL(B.SALES, 0)				AS SALES
		, ISNULL(B.EBIT, 0)					AS EBIT
		, ISNULL(B.PBT, 0)					AS PBT
		, C.ORG_UNION_SEQ
		, E.UNION_NAME
		, A.ORG_COMPANY_SEQ
		, C.COMPANY_NAME
		, B.ORG_BUSINESS_SEQ
		, D.BUSINESS_NAME
FROM	PLAN_YEAR_PAL								A
LEFT OUTER JOIN PLAN_MONTHLY_PAL_BUSINESS			B ON A.SEQ = B.PLAN_MONTHLY_PAL_SEQ
LEFT OUTER JOIN ORG_COMPANY					C ON A.ORG_COMPANY_SEQ = C.SEQ
LEFT OUTER JOIN ORG_BUSINESS				D ON B.ORG_BUSINESS_SEQ = D.SEQ
LEFT OUTER JOIN ORG_UNION					E ON C.ORG_UNION_SEQ = E.SEQ
WHERE	1 = 1
AND		A.YEAR_PAL_YEAR = @year
AND     C.SEQ NOT  IN('14','19','4')
AND     A.REGIST_STATUS = " + Define.REGIST_STATUS.GetKey("최종승인");

                    return con.Query<PmPalBusinessExp>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<PmPalBusinessExp> selectListPalRate(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"

; WITH CTE_SUM AS
(
	SELECT	A.PAL_YEAR
			, A.MONTHLY
			, A.ORG_COMPANY_SEQ
			, B.MONTHLY_TYPE
			, SUM(B.SALES)		AS SALES
			, SUM(B.EBIT)		AS EBIT
	FROM	PM_PAL			A
	LEFT OUTER JOIN	PM_PAL_BUSINESS		B ON A.SEQ = B.PM_PAL_SEQ
	WHERE	1 = 1
	GROUP BY A.PAL_YEAR
			, A.MONTHLY
			, A.ORG_COMPANY_SEQ
			, B.MONTHLY_TYPE
)
SELECT	A.PAL_YEAR
		, A.MONTHLY
		, A.ORG_COMPANY_SEQ
		, B.MONTHLY_TYPE
		, B.SALES
		, C.SALES
		, CASE WHEN ISNULL(C.SALES, 0) = 0 THEN 0 ELSE ROUND((B.SALES / C.SALES) * 100, 0) END AS SALES_RATE
		, CASE WHEN ISNULL(C.EBIT, 0) = 0 THEN 0 ELSE ROUND((B.EBIT / C.EBIT) * 100, 0) END EBIT_RATE
		, D.SEQ AS ORG_BUSINESS_SEQ
		, D.BUSINESS_NAME
FROM	PM_PAL				A
LEFT OUTER JOIN PM_PAL_BUSINESS			B ON A.SEQ = B.PM_PAL_SEQ
LEFT OUTER JOIN CTE_SUM					C ON A.PAL_YEAR = C.PAL_YEAR AND A.MONTHLY = C.MONTHLY AND A.ORG_COMPANY_SEQ = C.ORG_COMPANY_SEQ AND B.MONTHLY_TYPE = C.MONTHLY_TYPE
LEFT OUTER JOIN ORG_BUSINESS			D ON A.ORG_COMPANY_SEQ = D.ORG_COMPANY_SEQ AND B.ORG_BUSINESS_SEQ = D.SEQ
WHERE	1 = 1
ORDER BY D.ORD, D.BUSINESS_NAME
";

                    return con.Query<PmPalBusinessExp>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.ReportErrorLog(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<PmPalBusiness> selectListExcel(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string where = " WHERE 1 = 1 ";

                    string query = @" 
SELECT	B.PM_PAL_SEQ
		, B.SEQ
		, D.COMPANY_NAME
		, B.ORG_BUSINESS_SEQ
		, C.BUSINESS_NAME
		, A.PAL_YEAR
		, A.MONTHLY
		, MONTHLY_TYPE
		, B.SALES
		, B.EBIT
		, B.PBT
FROM	PM_PAL A
LEFT OUTER JOIN PM_PAL_BUSINESS		B ON A.SEQ = B.PM_PAL_SEQ
LEFT OUTER JOIN ORG_BUSINESS		C ON B.ORG_BUSINESS_SEQ = C.SEQ
LEFT OUTER JOIN ORG_COMPANY			D ON C.ORG_COMPANY_SEQ = D.SEQ
WHERE	B.PM_PAL_SEQ = @PmPalSeq
                        ";

                    return con.Query<PmPalBusiness>(query, param).ToList();

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