using Dapper;
using HALLA_PM.Util;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class PlanGroupdataPalMonthCrRepo : DbCon, IPlanGroupdataPalMonthCrRepo
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

        public int insert(PlanGroupdataPalMonthCr entity)
        {
            throw new NotImplementedException();
        }

        public int save(PlanGroupdataPalMonthCr entity)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<PlanGroupdataPalMonthCr> selectList(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = @" SELECT * FROM PLAN_GROUPDATA_PAL_MONTHLY_SUMMARY_CR
                                        WHERE GROUPDATA_YEAR = @PLANYEAR 
                                            ORDER BY GROUPDATA_YEAR, GROUPDATA_MONTH ";
                    return con.Query<PlanGroupdataPalMonthCr>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public PlanGroupdataPalMonthCr selectOne(object param)
        {
            throw new NotImplementedException();
        }

        public int update(PlanGroupdataPalMonthCr entity)
        {
            throw new NotImplementedException();
        }
    }
}