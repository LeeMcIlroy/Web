using Dapper;
using HALLA_PM.Util;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class PlanGroupdataInvestMonthRepo : DbCon, IPlanGroupdataInvestMonthRepo
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

        public int insert(PlanGroupdataInvestMonth entity)
        {
            throw new NotImplementedException();
        }

        public int save(PlanGroupdataInvestMonth entity)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<PlanGroupdataInvestMonth> selectList(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = @" SELECT * FROM PLAN_GROUPDATA_INVEST_MONTHLY
                                        WHERE GROUPDATA_YEAR = @PLANYEAR 
                                            ORDER BY GROUPDATA_YEAR, GROUPDATA_MONTH ";
                    return con.Query<PlanGroupdataInvestMonth>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public PlanGroupdataInvestMonth selectOne(object param)
        {
            throw new NotImplementedException();
        }

        public int update(PlanGroupdataInvestMonth entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                con.Open();
                try
                { 
                    //string query = @"UPDATE PLAN_GROUPDATA_INVEST_MONTHLY SET 
                    //                  INVESTMENT = INVESTMENT + @Investment
                    //                    ,PERSONNEL = ((DOMESTIC_PERSONNEL + @DomesticPersonnel) + (OVERSEAS_PERSONNEL + @OverseasPersonnel))
                    //                    ,DOMESTIC_PERSONNEL = DOMESTIC_PERSONNEL + @DomesticPersonnel
                    //                    ,OVERSEAS_PERSONNEL = OVERSEAS_PERSONNEL + @OverseasPersonnel
                    //                    WHERE SEQ = @Seq ";

                    string query = String.Format(@" [dbo].[USP_PLAN_GROUPDATA_INVEST_MONTHLY_CR_INSERT]
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
                                                       , entity.OverseasPersonnel );
                    LogUtil.Error(query.ToString());
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