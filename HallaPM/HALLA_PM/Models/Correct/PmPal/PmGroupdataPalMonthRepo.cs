using Dapper;
using HALLA_PM.Util;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class PmGroupdataPalMonthRepo : DbCon, IPmGroupdataPalMonthRepo
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

        public int insert(PmGroupdataPalMonth entity)
        {
            throw new NotImplementedException();
        }

        public int save(PmGroupdataPalMonth entity)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<PmGroupdataPalMonth> selectList(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = @" SELECT    SEQ
                                                ,GROUPDATA_YEAR
                                                ,GROUPDATA_MONTH
                                                ,DATATYPE
                                                ,MONTHLY_TYPE
                                                ,SALES
                                                ,EBIT
                                                ,EBIT_RATE = (CASE 
                                                                WHEN  ISNULL(SALES , 0) = 0 THEN 0 
                                                                WHEN  ISNULL(EBIT , 0) = 0 THEN 0
                                                                ELSE (ISNULL(EBIT, 0) / ISNULL(SALES , 0)) * 100 
                                                                END) 
                                                ,PBT 
                                                ,NET_PROFIT_TERM    
                            FROM PM_GROUPDATA_PAL_MONTHLY
                                        WHERE GROUPDATA_YEAR = @PMYEAR AND GROUPDATA_MONTH = @PMMONTH
                                            ORDER BY GROUPDATA_YEAR, GROUPDATA_MONTH, MONTHLY_TYPE "; 
                    return con.Query<PmGroupdataPalMonth>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public PmGroupdataPalMonth selectOne(object param)
        {
            throw new NotImplementedException();
        }

        public int update(PmGroupdataPalMonth entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                con.Open();
                try
                {
                    //string query = @" UPDATE PM_GROUPDATA_PAL_MONTHLY SET 
                    //                     SALES = SALES + @Sales 
                    //                    ,EBIT = EBIT + @Ebit  
                    //                    ,EBIT_RATE = (CASE 
                    //                                    WHEN  ISNULL(SALES + @Sales, 0) = 0 THEN 0 
                    //                                    WHEN  ISNULL(EBIT + @Ebit, 0) = 0 THEN 0
                    //                                    ELSE (ISNULL(EBIT + @Ebit, 0) / ISNULL(SALES + @Sales, 0)) * 100 
                    //                                  END) 
                    //                    ,PBT= PBT + @Pbt
                    //                    ,NET_PROFIT_TERM = NET_PROFIT_TERM + @NetProfitTerm
                    //                    WHERE SEQ = @Seq ";
                  

                   string query = String.Format(@" [dbo].[USP_PM_GROUPDATA_PAL_MONTHLY_CR_INSERT]
                                                     @GROUPDATA_YEAR = '{0}',
		                                               @GROUPDATA_MONTH = '{1}',
		                                               @DATATYPE = '{2}',
                                                       @MONTHLY_TYPE = '{3}',
		                                               @SALES_CR = {4},
		                                               @EBIT_CR = {5},
		                                               @EBIT_RATE_CR = {6},	 
		                                               @PBT_CR = {7},   
                                                       @NET_PROFIT_TERM_CR = {8}"
                                                      , entity.GroupdataYear
                                                      , entity.GroupdataMonth
                                                      , entity.DataType
                                                      , entity.MonthlyType
                                                      , entity.Sales
                                                      , entity.Ebit
                                                      , entity.EbitRate
                                                      , entity.Pbt
                                                      , entity.NetProfitTerm);
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