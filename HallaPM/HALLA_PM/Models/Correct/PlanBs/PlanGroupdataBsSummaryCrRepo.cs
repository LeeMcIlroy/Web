using Dapper;
using HALLA_PM.Util;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models 
{
    public class PlanGroupdataBsSummaryCrRepo : DbCon, IPlanGroupdataBsSummaryCrRepo
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

        public int insert(PlanGroupdataBsSummaryCr entity)
        {
            throw new NotImplementedException();
        }

        public int save(PlanGroupdataBsSummaryCr entity)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<PlanGroupdataBsSummaryCr> selectList(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = @" SELECT * FROM PLAN_GROUPDATA_BS_SUMMARY_CR
                                        WHERE GROUPDATA_YEAR = @PLANYEAR 
                                            ORDER BY GROUPDATA_YEAR, GROUPDATA_MONTH ";
                    return con.Query<PlanGroupdataBsSummaryCr>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public PlanGroupdataBsSummaryCr selectOne(object param)
        {
            throw new NotImplementedException();
        }

        public int update(PlanGroupdataBsSummaryCr entity)
        {
            throw new NotImplementedException();
        }
    }
}