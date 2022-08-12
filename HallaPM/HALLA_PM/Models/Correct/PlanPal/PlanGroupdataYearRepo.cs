using Dapper;
using HALLA_PM.Util;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class PlanGroupdataYearRepo : DbCon, IPlanGroupdataYearRepo
    {
        public int count(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " SELECT COUNT(*) FROM PLAN_GROUPDATA_YEAR ";
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
                    string query = " SELECT COUNT(*) FROM PLAN_GROUPDATA_YEAR " + where;
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

        public int insert(PlanGroupdataYear entity)
        {
            throw new NotImplementedException();
        }

        public int save(PlanGroupdataYear entity)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<PlanGroupdataYear> selectList(object param)
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
                        where += " AND   GROUPDATA_YEAR = @searchYear ";
                    }

                    if (!string.IsNullOrEmpty(search.searchBusType) && search.searchBusType != "")
                    {
                        where += " AND    DATA_TYPE = @searchBusType ";
                    }

                    query = @"SELECT	ROW_NUMBER() OVER (ORDER BY  GROUPDATA_YEAR ASC, DATA_TYPE DESC) AS ROW_NUM,* 
                                   FROM PLAN_GROUPDATA_YEAR  
                                   " + where + @"
                                   ORDER BY  GROUPDATA_YEAR DESC, DATA_TYPE 
                                   OFFSET @PageCount * (@PageIndex -1)  ROWS FETCH NEXT @PageCount ROW ONLY ;
                                   ";


                    search.TotalCount = count(search, where);
                    search.MakePaging();

                    return con.Query<PlanGroupdataYear>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    LogUtil.MngError(string.Format(query,param));
                    return null;
                }
            }
        }

        public PlanGroupdataYear selectOne(object param)
        { 
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = @"
                                    SELECT *
                                        FROM PLAN_GROUPDATA_YEAR WITH(NOLOCK)
                                             WHERE SEQ = @seq ";
                    return con.Query<PlanGroupdataYear>(query, param).First();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public int update(PlanGroupdataYear entity)
        {
            throw new NotImplementedException();
        }

        public int update(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                con.Open();
                try
                {
                    string query = @" UPDATE PLAN_GROUPDATA_YEAR SET 
                                          COMMENT = @strComment
                                        WHERE SEQ = @Seq ";
                    return con.Execute(@query, param);
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