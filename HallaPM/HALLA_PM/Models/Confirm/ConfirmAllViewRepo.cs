using Dapper;
using HALLA_PM.Util;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models.Confirm
{
    public class ConfirmAllViewRepo :DbCon,IConfirmAllViewRepo
    {
        public int count(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " SELECT COUNT(*) FROM CONFIRM_ALL_VIEW ";
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
                con.Open();
                try
                {
                    Search search = (Search)param;
                    if (search.searchCpySeq > 0)
                    {
                        where += " AND ORG_COMPANY_SEQ = @searchCpySeq";
                    }
                    if (!string.IsNullOrEmpty(search.searchYear))
                    {
                        where += " AND PLAN_YEAR =  @searchYear ";
                    }
                    if (!string.IsNullOrEmpty(search.searchMonth))
                    {
                        where += " AND MONTHLY =  @searchMonth ";
                    }

                    string query = "SELECT count(*) FROM CONFIRM_ALL_VIEW WHERE 1=1 " + where;
                    return con.Query<int>(query, param).First();
                }
                catch (Exception e)
                {
                    LogUtil.Error(e.ToString());
                    return -1;
                }
            }
        }

        public int totalCount(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                con.Open();
                try
                {
                    Search search = (Search)param;

                    string where = "";
                    if (search.searchCpySeq > 0)
                    {
                        where += " AND ORG_COMPANY_SEQ = @searchCpySeq";
                    }
                    if (!string.IsNullOrEmpty(search.searchYear))
                    {
                        where += " AND PLAN_YEAR =  @searchYear ";
                    }
                    if (!string.IsNullOrEmpty(search.searchMonth))
                    {
                        where += " AND MONTHLY =  @searchMonth ";
                    } 

                    string query = "SELECT count(*) FROM CONFIRM_ALL_VIEW WHERE 1=1 " + where;
                    return con.Query<int>(query, param).First();
                }
                catch (Exception e)
                {
                    LogUtil.Error(e.ToString());
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

        public int insert(ConfirmAllView entity)
        {
            throw new NotImplementedException();
        }

        public int save(ConfirmAllView entity)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<ConfirmAllView> selectList(object param)
        {
            Search search = (Search)param;
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string where = "";
                    if (search.searchCpySeq > 0)
                    {
                        where += " AND ORG_COMPANY_SEQ = @searchCpySeq";
                    }
                    if (!string.IsNullOrEmpty(search.searchYear))
                    {
                        where += " AND PLAN_YEAR =  @searchYear ";
                    }
                    if (!string.IsNullOrEmpty(search.searchMonth)) 
                    {
                        where += " AND MONTHLY =  @searchMonth ";
                    }
                    if (!string.IsNullOrEmpty(search.searchBusType))
                    {
                        where += " AND BUS_TYPE = @searchBusType ";
                    }
                    string query = @" SELECT ROW_NUMBER() OVER(ORDER BY MONTHLY DESC ,BUS_TYPE,CREATE_DATE DESC) ROWNUM
                                        ,* 
                                        ,CASE MONTHLY WHEN '99' THEN '사업계획' ELSE '경영실적' END AS [PLAN_TYPE]
                                        FROM    CONFIRM_ALL_VIEW   WHERE 1=1
                                        " + where + @"
                                        ORDER BY ROWNUM
                                        OFFSET @PageCount * (@PageIndex -1)  ROWS FETCH NEXT @PageCount ROW ONLY ";

                    search.TotalCount = count(search, where);
                    search.MakePaging();

                    return con.Query<ConfirmAllView>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public ConfirmAllView selectOne(object param)
        {
            throw new NotImplementedException();
        }

        public int update(ConfirmAllView entity)
        {
            throw new NotImplementedException();
        }
    }
}