using Dapper;
using HALLA_PM.Util;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class PmGroupdataBsMonthCrRepo : DbCon, IPmGroupdataBsMonthCrRepo
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

        public int insert(PmGroupdataBsMonthCr entity)
        {
            throw new NotImplementedException();
        }

        public int save(PmGroupdataBsMonthCr entity)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<PmGroupdataBsMonthCr> selectList(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = @" SELECT TOP 1 * FROM PM_GROUPDATA_BS_MONTHLY_CR
                                        WHERE GROUPDATA_YEAR = @PMYEAR AND GROUPDATA_MONTH = @PMMONTH
                                            ORDER BY GROUPDATA_YEAR, GROUPDATA_MONTH ";
                    return con.Query<PmGroupdataBsMonthCr>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public PmGroupdataBsMonthCr selectOne(object param)
        {
            throw new NotImplementedException();
        }

        public int update(PmGroupdataBsMonthCr entity)
        {
            throw new NotImplementedException();
        }
    }
}