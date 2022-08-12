using Dapper;
using HALLA_PM.Util;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class PlanGroupdataInvestSummaryCrRepo : DbCon, IPlanGroupdataInvestSummaryCrRepo
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

        public int insert(PlanGroupdataInvestSummaryCr entity)
        {
            throw new NotImplementedException();
        }

        public int save(PlanGroupdataInvestSummaryCr entity)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<PlanGroupdataInvestSummaryCr> selectList(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = @" SELECT * FROM PLAN_GROUPDATA_INVEST_SUMMARY_CR
                                        WHERE GROUPDATA_YEAR = @PLANYEAR 
                                            ORDER BY GROUPDATA_YEAR, GROUPDATA_MONTH ";
                    return con.Query<PlanGroupdataInvestSummaryCr>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public PlanGroupdataInvestSummaryCr selectOne(object param)
        {
            throw new NotImplementedException();
        }

        public int update(PlanGroupdataInvestSummaryCr entity)
        {
            throw new NotImplementedException();
        }
    }
}