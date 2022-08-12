using Dapper;
using HALLA_PM.Util;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class PlanGroupdataBsMonthCrRepo : DbCon, IPlanGroupdataBsMonthCrRepo
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

        public int insert(PlanGroupdataBsMonthCr entity)
        {
            throw new NotImplementedException();
        }

        public int save(PlanGroupdataBsMonthCr entity)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<PlanGroupdataBsMonthCr> selectList(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = @" SELECT * FROM PLAN_GROUPDATA_BS_MONTHLY_CR
                                        WHERE GROUPDATA_YEAR = @PLANYEAR 
                                            ORDER BY GROUPDATA_YEAR, GROUPDATA_MONTH ";
                    return con.Query<PlanGroupdataBsMonthCr>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public PlanGroupdataBsMonthCr selectOne(object param)
        {
            throw new NotImplementedException();
        }

        public int update(PlanGroupdataBsMonthCr entity)
        {
            throw new NotImplementedException();
        }
    }
}