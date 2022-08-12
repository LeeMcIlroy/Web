using Dapper;
using HALLA_PM.Util;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class PlanGroupdataPalSummaryCrRepo : DbCon, IPlanGroupdataPalSummaryCrRepo
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

        public int insert(PlanGroupdataPalSummaryCr entity)
        {
            throw new NotImplementedException();
        }

        public int save(PlanGroupdataPalSummaryCr entity)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<PlanGroupdataPalSummaryCr> selectList(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = @" SELECT * FROM PLAN_GROUPDATA_PAL_SUMMARY_CR
                                        WHERE GROUPDATA_YEAR = @PLANYEAR 
                                            ORDER BY GROUPDATA_YEAR, GROUPDATA_MONTH ";
                    return con.Query<PlanGroupdataPalSummaryCr>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public PlanGroupdataPalSummaryCr selectOne(object param)
        {
            throw new NotImplementedException();
        }

        public int update(PlanGroupdataPalSummaryCr entity)
        {
            throw new NotImplementedException();
        }
    }
}