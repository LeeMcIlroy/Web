using Dapper;
using HALLA_PM.Util;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models 
{
    public class PmGroupdataInvestMonthRepo : DbCon, IPmGroupdataInvestMonthRepo
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

        public int insert(PmGroupdataInvestMonth entity)
        {
            throw new NotImplementedException();
        }

        public int save(PmGroupdataInvestMonth entity)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<PmGroupdataInvestMonth> selectList(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = @" SELECT * FROM PM_GROUPDATA_INVEST_MONTHLY
                                        WHERE GROUPDATA_YEAR = @PMYEAR AND GROUPDATA_MONTH = @PMMONTH
                                            ORDER BY GROUPDATA_YEAR, GROUPDATA_MONTH, MONTHLY_TYPE ";
                    return con.Query<PmGroupdataInvestMonth>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public PmGroupdataInvestMonth selectOne(object param)
        {
            throw new NotImplementedException();
        }

        public int update(PmGroupdataInvestMonth entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                con.Open();
                try
                {
                    //string query = @"UPDATE PM_GROUPDATA_INVEST_MONTHLY SET 
                    //                  INVESTMENT = INVESTMENT + @Investment
                    //                    ,PERSONNEL = ((DOMESTIC_PERSONNEL + @DomesticPersonnel) + (OVERSEAS_PERSONNEL + @OverseasPersonnel))
                    //                    ,DOMESTIC_PERSONNEL = DOMESTIC_PERSONNEL + @DomesticPersonnel
                    //                    ,OVERSEAS_PERSONNEL = OVERSEAS_PERSONNEL + @OverseasPersonnel
                    //                    WHERE SEQ = @Seq ";
                    string query = String.Format(@" [dbo].[USP_PM_GROUPDATA_INVEST_MONTHLY_CR_INSERT]
                                                     @GROUPDATA_YEAR = '{0}',
		                                               @GROUPDATA_MONTH = '{1}',
		                                               @DATATYPE = '{2}',
                                                       @MONTHLY_TYPE = '{3}',
		                                               @INVESTMENT_CR	= {4},		
		                                               @PERSONNEL_CR	= {5},		
		                                               @DOMESTIC_PERSONNEL_CR= {6},	
		                                               @OVERSEAS_PERSONNEL_CR = {7} "
                                                       , entity.GroupdataYear
                                                       , entity.GroupdataMonth
                                                       , entity.DataType
                                                       , entity.MonthlyType
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