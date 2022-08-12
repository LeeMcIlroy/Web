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
    public class PlanGroupdataInvestSummaryRepo : DbCon, IPlanGroupdataInvestSummaryRepo
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

        public int insert(PlanGroupdataInvestSummary entity)
        {
            throw new NotImplementedException();
        }

        public int save(PlanGroupdataInvestSummary entity)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<PlanGroupdataInvestSummary> selectList(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = @"SELECT * FROM PLAN_GROUPDATA_INVEST_SUMMARY
                                        WHERE GROUPDATA_YEAR = @PLANYEAR 
                                            ORDER BY GROUPDATA_YEAR, GROUPDATA_MONTH ";
                    return con.Query<PlanGroupdataInvestSummary>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }
        public IEnumerable<PlanGroupdataInvestSummary> groupSelectList(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = @"SELECT	A.INVEST_YEAR GROUPDATA_YEAR 
		                                    , A.INVEST_YEAR AS GROUPDATA_MONTH 
		                                    ,'05' AS DATATYPE
		                                    ,SUM(B.INVESTMENT) AS INVESTMENT
		                                    ,SUM( PERSONNEL)   as PERSONNEL
		                                    ,SUM(B.DOMESTIC_PERSONNEL) AS DOMESTIC_PERSONNEL
		                                    ,SUM(B.OVERSEAS_PERSONNEL) AS OVERSEAS_PERSONNEL
                                    FROM	PM_INVEST										A
                                        LEFT OUTER JOIN PM_INVEST_SUM	
                                            B ON A.SEQ = B.PM_INVEST_SEQ 
                                    WHERE	1 = 1
                                        AND		A.INVEST_YEAR =  @Year - 1 
                                        AND     A.REGIST_STATUS = 7
                                        AND    A.MONTHLY= '12'
                                        AND    B.MONTHLY_TYPE=" + Define.MONTHLY_TYPE.GetKey("누계") + @"
                                    GROUP BY A.INVEST_YEAR,A.MONTHLY
                                UNION ALL
		                                SELECT GROUPDATA_YEAR
			                                ,GROUPDATA_MONTH
			                                ,DATATYPE,INVESTMENT
			                                ,PERSONNEL
			                                ,DOMESTIC_PERSONNEL
			                                ,OVERSEAS_PERSONNEL
		                                FROM PLAN_GROUPDATA_INVEST_SUMMARY WITH(NOLOCK)
		                                WHERE GROUPDATA_YEAR = @Year  ";
                    return con.Query<PlanGroupdataInvestSummary>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }


        public PlanGroupdataInvestSummary selectOne(object param)
        {
            throw new NotImplementedException();
        }

        public int update(PlanGroupdataInvestSummary entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                con.Open();
                try
                {
                    //string query = @"UPDATE PLAN_GROUPDATA_INVEST_SUMMARY SET 
                    //                  INVESTMENT = INVESTMENT + @Investment
                    //                    ,PERSONNEL = ((DOMESTIC_PERSONNEL + @DomesticPersonnel) + (OVERSEAS_PERSONNEL + @OverseasPersonnel))
                    //                    ,DOMESTIC_PERSONNEL = DOMESTIC_PERSONNEL + @DomesticPersonnel
                    //                    ,OVERSEAS_PERSONNEL = OVERSEAS_PERSONNEL + @OverseasPersonnel
                    //                    WHERE SEQ = @Seq ";
                    string query = String.Format(@" [dbo].[USP_PLAN_GROUPDATA_INVEST_SUMMARY_CR_INSERT]
                                                     @GROUPDATA_YEAR = '{0}',
		                                               @GROUPDATA_MONTH = '{1}',
		                                               @DATATYPE = '{2}',
		                                               @INVESTMENT_CR	= {3},		
		                                               @PERSONNEL_CR	= {4},		
		                                               @DOMESTIC_PERSONNEL_CR= {5},	
		                                               @OVERSEAS_PERSONNEL_CR = {6} "
                                                     , entity.GroupdataYear
                                                     , entity.GroupdataMonth
                                                     , entity.DataType
                                                     , entity.Investment
                                                     , entity.Personnel
                                                     , entity.DomesticPersonnel
                                                     , entity.OverseasPersonnel);

                    return con.Execute(@query);
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