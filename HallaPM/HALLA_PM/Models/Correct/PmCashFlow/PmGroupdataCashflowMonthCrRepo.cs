using Dapper;
using HALLA_PM.Util;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class PmGroupdataCashflowMonthCrRepo : DbCon, IPmGroupdataCashflowMonthCrRepo
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

        public int insert(PmGroupdataCashflowMonthCr entity)
        {
            throw new NotImplementedException();
        }

        public int save(PmGroupdataCashflowMonthCr entity)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<PmGroupdataCashflowMonthCr> selectList(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = @" SELECT * FROM PM_GROUPDATA_CF_MONTHLY_CR
                                       WHERE GROUPDATA_YEAR = @PMYEAR AND GROUPDATA_MONTH = @PMMONTH
                                            ORDER BY GROUPDATA_YEAR, GROUPDATA_MONTH ";
                    return con.Query<PmGroupdataCashflowMonthCr>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public PmGroupdataCashflowMonthCr selectOne(object param)
        {
            throw new NotImplementedException();
        }

        public int update(PmGroupdataCashflowMonthCr entity)
        {
            throw new NotImplementedException();
        }
    }
}