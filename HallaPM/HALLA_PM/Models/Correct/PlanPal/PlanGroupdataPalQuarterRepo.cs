using Dapper;
using HALLA_PM.Util;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models 
{
    public class PlanGroupdataPalQuarterRepo : DbCon, IPlanGroupdataPalQuarterRepo
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

        public int insert(PlanGroupdataPalQuarter entity)
        {
            throw new NotImplementedException();
        }

        public int save(PlanGroupdataPalQuarter entity)
        {
            throw new NotImplementedException();
        }

        public int updateSummary(PlanGroupdataPalQuarter param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                con.Open();
                try
                {
                    //string query = @"UPDATE PLAN_GROUPDATA_PAL_QUARTER_SUMMARY SET 
                    //                   SALES = SALES + @Sales 
                    //                    ,EBIT = EBIT + @Ebit  
                    //                    ,EBIT_RATE = (CASE 
                    //                                    WHEN  ISNULL(SALES + @Sales, 0) = 0 THEN 0 
                    //                                    WHEN  ISNULL(EBIT + @Ebit, 0) = 0 THEN 0
                    //                                    ELSE (ISNULL(EBIT + @Ebit, 0) / ISNULL(SALES + @Sales, 0)) * 100 
                    //                                  END) 
                    //                    ,PBT= PBT + @Pbt
                    //                    WHERE SEQ = @Seq ";
                    string query = String.Format(@" [dbo].[USP_PLAN_GROUPDATA_PAL_QUARTER_SUMMARY_CR_INSERT]
                                                     @GROUPDATA_YEAR = '{0}',
		                                               @GROUPDATA_MONTH = '{1}',
		                                               @DATATYPE = '{2}',
		                                               @SALES_CR = {3},
		                                               @EBIT_CR = {4},
		                                               @EBIT_RATE_CR = {5},	 
		                                               @PBT_CR = {6} "
                                                       , param.GroupdataYear
                                                       , param.GroupdataMonth
                                                       , param.DataType
                                                       , param.Sales
                                                       , param.Ebit
                                                       , param.EbitRate
                                                       , param.Pbt);


                    return con.Execute(@query);
                }
                catch (Exception e)
                {
                    LogUtil.Error(e.ToString());
                    return -1;
                }
            }
        }
        public IEnumerable<PlanGroupdataPalQuarter> selectList(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = @" SELECT SEQ
                                        ,GROUPDATA_YEAR
                                        ,GROUPDATA_MONTH
                                        ,DATATYPE
                                        ,SALES
                                        ,EBIT
                                        ,EBIT_RATE = (CASE 
                                                        WHEN  ISNULL(SALES , 0) = 0 THEN 0 
                                                        WHEN  ISNULL(EBIT , 0) = 0 THEN 0
                                                        ELSE (ISNULL(EBIT, 0) / ISNULL(SALES , 0)) * 100 
                                                        END) 
                                        ,PBT 
                                        FROM PLAN_GROUPDATA_PAL_QUARTER_SUMMARY
                                        WHERE GROUPDATA_YEAR = @PLANYEAR 
                                            ORDER BY GROUPDATA_YEAR, GROUPDATA_MONTH ";
                    return con.Query<PlanGroupdataPalQuarter>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public PlanGroupdataPalQuarter selectOne(object param)
        {
            throw new NotImplementedException();
        }

        public int update(PlanGroupdataPalQuarter entity)
        {
            throw new NotImplementedException();
        }
    }
}