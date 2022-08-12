using Dapper;
using HALLA_PM.Util;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class PlanGroupdataInvestMonthCrRepo : DbCon, IPlanGroupdataInvestMonthCrRepo
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

        public int insert(PlanGroupdataInvestMonthCr entity)
        {
            throw new NotImplementedException();
        }

        public int save(PlanGroupdataInvestMonthCr entity)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<PlanGroupdataInvestMonthCr> selectList(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = @"SELECT * FROM PLAN_GROUPDATA_INVEST_MONTHLY_CR
                                        WHERE GROUPDATA_YEAR = @PLANYEAR 
                                            ORDER BY GROUPDATA_YEAR, GROUPDATA_MONTH ";
                    return con.Query<PlanGroupdataInvestMonthCr>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public PlanGroupdataInvestMonthCr selectOne(object param)
        {
            throw new NotImplementedException();
        }

        public int update(PlanGroupdataInvestMonthCr entity)
        {
            throw new NotImplementedException();
        }
    }
}