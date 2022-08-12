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
    public class PmPalYealyAnalysisRepo : DbCon, IPmPalYealyAnalysis
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

        public int delete(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = @" DELETE PM_PAL_YEALY_ANALYSIS
                                       WHERE SEQ IN (SELECT B.SEQ
			                                           FROM PM_PAL A
			                                          INNER JOIN PM_PAL_YEALY_ANALYSIS B ON A.SEQ = B.PM_PAL_SEQ
			                                          WHERE A.PAL_YEAR = @PalYear
			                                            AND A.MONTHLY = @Monthly
                                                        AND A.SEQ = @PmPalSeq
			                                            AND ANALYSIS = @Analysis)";
                    return con.Execute(query, param);
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return -1;
                }
            }
        }

        public void Dispose()
        {
            throw new NotImplementedException();
        }

        public int insert(PmPalYealyAnalysis entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = @" INSERT INTO PM_PAL_YEALY_ANALYSIS
                                      (
			                            PM_PAL_SEQ
			                            ,ANALYSIS
			                            ,MONTHLY_CONTENT
			                            ,MONTHLY_VALUE
			                            ,YEALY_CONTENT
			                            ,YEALY_VALUE
		                              )
		                              VALUES
		                              (
			                            @PmPalSeq
			                            ,@Analysis
			                            ,@MonthlyContent
			                            ,@MonthlyValue
			                            ,@YealyContent
			                            ,@YealyValue
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

        public int save(PmPalYealyAnalysis entity)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<PmPalYealyAnalysis> selectList(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" SELECT * FROM PLAN_YEAR_BS_BSHEET WHERE PLAN_YEAR_BS_SEQ = @PlanYearBsSeq ";

                    return con.Query<PmPalYealyAnalysis>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public PmPalYealyAnalysis selectOne(object param)
        {
            throw new NotImplementedException();
        }

        public int update(PmPalYealyAnalysis entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = @" UPDATE PM_PAL_ANALYSIS SET
                                          MONTHLY_CONTENT = @MonthlyContent
                                         ,MONTHLY_VALUE = @MonthlyValue
                                         ,CUMULATIVE_CONTENT = @CumulativeContent
                                         ,CUMULATIVE_VALUE = @CumulativeValue
                                     WHERE SEQ = @PmPalAnalysisSeq
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

        /// <summary>
        /// 연간손익분석
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        public IEnumerable<PmPalYealyAnalysis> selectListYearAnalysisMonthlyContent(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" SELECT PM_PAL_SEQ 
			                                ,MONTHLY_CONTENT
			                                ,MONTHLY_VALUE
			                                ,YEALY_CONTENT 
                                            ,YEALY_VALUE
                                            ,B.SEQ					AS PM_PAL_YEALY_ANALYSIS_SEQ
                                        FROM PM_PAL A
                                        LEFT OUTER JOIN PM_PAL_YEALY_ANALYSIS B ON A.SEQ = B.PM_PAL_SEQ
                                        WHERE 1 = 1
                                        --AND B.PM_PAL_SEQ = @Seq
AND A.ORG_COMPANY_SEQ = @OrgCompanySeq
                                        AND A.PAL_YEAR = @YearlyYear
                                        AND A.MONTHLY = @Monthly
                                        AND B.ANALYSIS = @Analysis ";

                    return con.Query<PmPalYealyAnalysis>(query, param).ToList();
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