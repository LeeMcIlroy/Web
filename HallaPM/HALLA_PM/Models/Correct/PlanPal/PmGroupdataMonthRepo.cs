using Dapper;
using HALLA_PM.Util;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class PmGroupdataMonthRepo : DbCon, IPmGroupdataMonthRepo
    {
        public int count(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " SELECT COUNT(*) FROM PM_GROUPDATA_MONTH ";
                    return con.Query<int>(query, param).First();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return -1;
                }
            }
        }
        public int count(object param, string where)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " SELECT COUNT(*) FROM PM_GROUPDATA_MONTH  " + where;
                    return con.Query<int>(query, param).First();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return -1;
                }
            }
        }

        public int delete(object key)
        {
            throw new NotImplementedException();
        }

        public void Dispose()
        {
            throw new NotImplementedException();
        }

        public int insert(PmGroupdataMonth entity)
        {
            throw new NotImplementedException();
        }

        public int save(PmGroupdataMonth entity)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<PmGroupdataMonth> selectList(object param)
        {
            string query = "";
            Search search = (Search)param;
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string where = @" WHERE 1 = 1 ";

                    if (!string.IsNullOrEmpty(search.searchYear) && search.searchYear != "")
                    {
                        where += " AND GROUPDATA_YEAR = @searchYear ";
                    }

                    if (!string.IsNullOrEmpty(search.searchMonth) && search.searchMonth != "")
                    {
                        where += " AND GROUPDATA_MONTH = @searchMonth ";
                    }

                    if (!string.IsNullOrEmpty(search.searchBusType) && search.searchBusType != "")
                    {
                        where += " AND DATA_TYPE = @searchBusType ";
                    }

                     query = @"     SELECT	ROW_NUMBER() OVER (ORDER BY GROUPDATA_YEAR ASC,GROUPDATA_MONTH ASC,DATA_TYPE DESC) AS ROW_NUM,*
                                    FROM PM_GROUPDATA_MONTH
                                    " + where + @"
                                    ORDER BY GROUPDATA_YEAR DESC,GROUPDATA_MONTH DESC,DATA_TYPE 
                                    OFFSET @PageCount * (@PageIndex -1)  ROWS FETCH NEXT @PageCount ROW ONLY ;
                                    ";

                    search.TotalCount = count(search, where);
                    search.MakePaging();
                    return con.Query<PmGroupdataMonth>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public PmGroupdataMonth selectOne(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = @"
                                    SELECT *
                                        FROM PM_GROUPDATA_MONTH WITH(NOLOCK)
                                             WHERE SEQ = @seq ";
                    return con.Query<PmGroupdataMonth>(query, param).First();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }
       
        public int update(PmGroupdataMonth entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                con.Open();
                try
                {
                    string query = @" UPDATE PM_GROUPDATA_MONTH SET 
                                          COMMENT = @Comment
                                        WHERE SEQ = @Seq ";
                    return con.Execute(@query, entity);
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