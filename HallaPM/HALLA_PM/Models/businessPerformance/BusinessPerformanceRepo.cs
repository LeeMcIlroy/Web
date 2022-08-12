using Dapper;
using HALLA_PM.Core;
using HALLA_PM.Util;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class BusinessPerformanceRepo : DbCon, IBusinessPerformanceRepo
    {
        public int count(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                con.Open();
                try
                {
                    string query = "SELECT count(*) FROM BUSINESS_PERFORMANCE ";
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
                    if (search.searchType > 0)
                    {
                        where += " AND BUSINESS_TYPE = @searchType ";
                    }

                    if (!string.IsNullOrEmpty(search.searchText))
                    {
                        where += " AND YEAR = @searchText ";
                    }

                    if (!string.IsNullOrEmpty(search.searchText1))
                    {
                        where += " AND MONTH = @searchText1 ";
                    }

                    string query = "SELECT count(*) FROM BUSINESS_PERFORMANCE WHERE 1=1 " + where;
                    return con.Query<int>(query, param).First();
                }
                catch (Exception e)
                {
                    LogUtil.Error(e.ToString());
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
                    string query = "SELECT count(*) FROM BUSINESS_PERFORMANCE WHERE 1=1 " + where;
                    return con.Query<int>(query, param).First();
                }
                catch (Exception e)
                {
                    LogUtil.Error(e.ToString());
                    return -1;
                }
            }
        }
        public int delete(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                con.Open();
                try
                {
                    string query = "DELETE FROM BUSINESS_PERFORMANCE WHERE SEQ = @seq";
                    return con.Execute(query, param);
                }
                catch (Exception e)
                {
                    LogUtil.Error(e.ToString());
                    return -1;
                }
            }
        }

        public void Dispose()
        {
            throw new NotImplementedException();
        }

        public int insert(BusinessPerformance entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                con.Open();
                try
                {
                    string query = "INSERT INTO BUSINESS_PERFORMANCE( " +
                                                        " USER_KEY, " +
                                                        " EMP_NO, " +
                                                        " TITLE, " +
                                                        " YEAR, " +
                                                        " MONTH, " +
                                                        " BUSINESS_TYPE, " +
                                                        " IS_USE " +
                                                    " ) VALUES ( " +
                                                            " @userKey," +
                                                            " @empNo," +
                                                            " @title, " +
                                                            " @year," +
                                                            " @month," +
                                                            " @businessType, " +
                                                            " @isUse " +
                                                    "); SELECT CAST(SCOPE_IDENTITY() as int)";
                    return con.Query<int>(@query, entity).First();
                }
                catch (Exception e)
                {
                    LogUtil.Error(e.ToString());
                    return -1;
                }
            }
            }

        public int save(BusinessPerformance entity)
        {
            var item = this.selectOne(entity);
            if (item == null)
            {
                return this.insert(entity);
            }
            else
            {
                entity.seq = item.seq;
                return this.update(entity);
            }
        }

        public IEnumerable<BusinessPerformance> selectList(object param)
        {

            Search search = (Search)param;

            using (IDbConnection con = GetHallaDb())
            {
                con.Open();
                try
                {
                    string where = "";
                    if(search.searchType > 0)
                    {
                        where += " AND BUSINESS_TYPE = @searchType ";
                    }

                    if (!string.IsNullOrEmpty(search.searchText))
                    {
                        where += " AND YEAR = @searchText ";
                    }

                    if (!string.IsNullOrEmpty(search.searchText1))
                    {
                        where += " AND MONTH = @searchText1 ";
                    }

                    search.TotalCount = this.count(search, where);
                    search.MakePaging();

                    string query = "";
                    query += " SELECT ROW_NUMBER() OVER (ORDER BY YEAR ASC, MONTH ASC, SEQ ASC) AS ROW_NUM ";
                    query += "     , SEQ, USER_KEY, EMP_NO, CONVERT(VARCHAR(10), REG_DATE, 120) AS REG_DATE, TITLE, YEAR, MONTH, BUSINESS_TYPE, IS_USE ";
                    query += " FROM BUSINESS_PERFORMANCE A";
                    query += " WHERE 1=1 ";
                    query += where;
                    query += " ORDER BY YEAR DESC, MONTH DESC, SEQ DESC ";
                    query += " OFFSET @pageCount * (@pageIndex -1)  ROWS FETCH NEXT @pageCount ROW ONLY ";
                    return con.Query<BusinessPerformance>(query, search).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.Error(e.ToString());
                    return null;
                }
            }
        }

        public BusinessPerformance selectOne(object param)
        {

            using (IDbConnection con = GetHallaDb())
            {
                con.Open();
                try
                {
                    string query = "SELECT SEQ, USER_KEY, EMP_NO, CONVERT(VARCHAR(10), REG_DATE, 120) AS REG_DATE, TITLE, YEAR, MONTH, BUSINESS_TYPE, IS_USE FROM BUSINESS_PERFORMANCE WHERE SEQ = @seq ";
                    return con.Query<BusinessPerformance>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.Error(e.ToString());
                    return null;
                }
            }
        }

        public BusinessPerformanceExp selectOneExp(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                con.Open();
                try
                {
                    string query = "SELECT * FROM BUSINESS_PERFORMANCE WHERE SEQ = @seq ";
                    BusinessPerformanceExp info = con.Query<BusinessPerformanceExp>(query, param).FirstOrDefault();

                    query = "";
                    query += " SELECT * ";
                    query += " FROM FILE_INFO ";
                    query += " WHERE ATTACH_TABLE_NAME = 'BUSINESS_PERFORMANCE' ";
                    query += "     AND ATTACH_TABLE_SEQ = @seq";

                    info.fileInfoList = con.Query<FileInfo>(query, info).ToList();
                    return info;
                }
                catch (Exception e)
                {
                    LogUtil.Error(e.ToString());
                    return null;
                }
            }
        }
        
        public BusinessPerformance availableCheckInfo(object param)
        {

            using (IDbConnection con = GetHallaDb())
            {
                con.Open();
                try
                {
                    string query = "";
                    query += " SELECT * ";
                    query += " FROM BUSINESS_PERFORMANCE ";
                    query += " WHERE YEAR = @year ";
                    query += "     AND MONTH = @month ";
                    query += "     AND BUSINESS_TYPE = @businessType ";
                    return con.Query<BusinessPerformance>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.Error(e.ToString());
                    return null;
                }
            }
        }
        
        public int update(BusinessPerformance entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                con.Open();
                try
                {
                    string query =
                        "UPDATE BUSINESS_PERFORMANCE SET " +
                            " UPDATE_DATE = GETDATE(), " +
                            " USER_KEY = @userKey, " +
                            " EMP_NO = @empNo, " +
                            " TITLE = @title, " +
                            " YEAR = @year, " +
                            " MONTH = @month, " +
                            " BUSINESS_TYPE = @businessType, " + 
                            " IS_USE = @isUse " +
                        "WHERE " +
                            " SEQ = @seq ";

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