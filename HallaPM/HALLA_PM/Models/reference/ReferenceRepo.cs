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
    public class ReferenceRepo : DbCon, IReferenceRepo
    {
        public int count(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                con.Open();
                try
                {
                    string query = "SELECT count(*) FROM REFERENCE ";
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
                    string query = "SELECT count(*) FROM REFERENCE WHERE 1=1 " + where;
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
                    if (!string.IsNullOrEmpty(search.searchText))
                    {
                        if (search.searchType == Define.REFERENCE_SEARCH_TYPE.GetKey("전체"))
                        {
                            where += " AND (CONTENTS LIKE CONCAT('%', @searchText, '%') OR TITLE LIKE CONCAT('%', @searchText, '%'))";
                        }
                        else if (search.searchType == Define.REFERENCE_SEARCH_TYPE.GetKey("제목"))
                        {
                            where += " AND TITLE LIKE CONCAT('%', @searchText, '%') ";
                        }
                        else if (search.searchType == Define.REFERENCE_SEARCH_TYPE.GetKey("내용"))
                        {
                            where += " AND CONTENTS LIKE CONCAT('%', @searchText, '%') ";
                        }
                    }

                    string query = "SELECT count(*) FROM REFERENCE WHERE 1=1 " + where;
                    return con.Query<int>(query, param).First();
                }
                catch (Exception e)
                {
                    LogUtil.Error(e.ToString());
                    return -1;
                }
            }
        }


        public int totalCountForFront(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                con.Open();
                try
                {
                    Search search = (Search)param;

                    string where = " AND IS_USE = 'Y' ";
                    if (!string.IsNullOrEmpty(search.searchText))
                    {
                        where += " AND (CONTENTS LIKE CONCAT('%', @searchText, '%') OR TITLE LIKE CONCAT('%', @searchText, '%'))";
                    }

                    string query = "SELECT count(*) FROM REFERENCE WHERE 1=1 " + where;
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
                    string query = "DELETE FROM REFERENCE WHERE SEQ = @seq";
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

        public int insert(Reference entity)
        {

            using (IDbConnection con = GetHallaDb())
            {
                con.Open();
                try
                {
                    string query = "INSERT INTO REFERENCE( " +
                                                        " USER_KEY, " +
                                                        " EMP_NO, " +
                                                        " TITLE, " +
                                                        " INPUT_REG_DATE, " +
                                                        " CONTENTS, " +
                                                        " IS_USE " +
                                                    " ) VALUES ( " +
                                                            " @userKey," +
                                                            " @empNo," +
                                                            " @title, " +
                                                            " @inputRegDate," +
                                                            " @contents," +
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

        public int save(Reference entity)
        {
            var item = this.selectOne(entity);
            if (item == null)
            {
                return this.insert(entity);
            }
            else
            {
                return this.update(entity);
            }
        }

        public IEnumerable<Reference> selectList(object param)
        {
            Search search = (Search)param;

            using (IDbConnection con = GetHallaDb())
            {
                con.Open();
                try
                {
                    string where = "";
                    if (!string.IsNullOrEmpty(search.searchText))
                    {
                        if (search.searchType == Define.REFERENCE_SEARCH_TYPE.GetKey("전체"))
                        {
                            where += " AND (CONTENTS LIKE CONCAT('%', @searchText, '%') OR TITLE LIKE CONCAT('%', @searchText, '%'))";
                        }
                        else if (search.searchType == Define.REFERENCE_SEARCH_TYPE.GetKey("제목"))
                        {
                            where += " AND TITLE LIKE CONCAT('%', @searchText, '%') ";
                        }
                        else if (search.searchType == Define.REFERENCE_SEARCH_TYPE.GetKey("내용"))
                        {
                            where += " AND CONTENTS LIKE CONCAT('%', @searchText, '%') ";
                        }
                    }

                    search.TotalCount = this.count(search, where);
                    search.MakePaging();

                    string query = "";
                    query += " SELECT ROW_NUMBER() OVER (ORDER BY REG_DATE DESC) AS ROW_NUM ";
                    query += "     , SEQ, USER_KEY, EMP_NO, REG_DATE, UPDATE_DATE, TITLE, CONVERT(VARCHAR(10), INPUT_REG_DATE, 120) AS INPUT_REG_DATE, CONTENTS, IS_USE, VIEW_CNT ";
                    query += " FROM REFERENCE ";
                    query += " WHERE 1=1 ";
                    query += where;
                    query += " ORDER BY REG_DATE DESC, SEQ DESC ";
                    query += " OFFSET @pageCount * (@pageIndex -1)  ROWS FETCH NEXT @pageCount ROW ONLY ";
                    return con.Query<Reference>(query, search).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.Error(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<ReferenceExp> selectListExp(object param)
        {
            Search search = (Search)param;

            using (IDbConnection con = GetHallaDb())
            {
                con.Open();
                try
                {
                    string where = "";
                    if (!string.IsNullOrEmpty(search.searchText))
                    {
                        if (search.searchType == Define.REFERENCE_SEARCH_TYPE.GetKey("전체"))
                        {
                            where += " AND (CONTENTS LIKE CONCAT('%', @searchText, '%') OR TITLE LIKE CONCAT('%', @searchText, '%'))";
                        }
                        else if (search.searchType == Define.REFERENCE_SEARCH_TYPE.GetKey("제목"))
                        {
                            where += " AND TITLE LIKE CONCAT('%', @searchText, '%') ";
                        }
                        else if (search.searchType == Define.REFERENCE_SEARCH_TYPE.GetKey("내용"))
                        {
                            where += " AND CONTENTS LIKE CONCAT('%', @searchText, '%') ";
                        }
                    }

                    search.TotalCount = this.count(search, where);
                    search.MakePaging();

                    string query = "";
                    query += " SELECT ROW_NUMBER() OVER (ORDER BY INPUT_REG_DATE ASC, SEQ ASC ) AS ROW_NUM ";
                    query += "     , SEQ, USER_KEY, EMP_NO, REG_DATE, UPDATE_DATE, TITLE, CONVERT(VARCHAR(10), INPUT_REG_DATE, 120) AS INPUT_REG_DATE, CONTENTS, IS_USE, VIEW_CNT ";
                    query += "     , (SELECT AUTH_USER_KOR_NAME FROM ADMIN_AUTH WHERE AUTH_USER_KEY = A.USER_KEY AND AUTH_EMP_NO = A.EMP_NO) AS ADMIN_NAME ";
                    query += " FROM REFERENCE A";
                    query += " WHERE 1=1 ";
                    query += where;
                    query += " ORDER BY INPUT_REG_DATE DESC, SEQ DESC ";
                    query += " OFFSET @pageCount * (@pageIndex -1)  ROWS FETCH NEXT @pageCount ROW ONLY ";
                    return con.Query<ReferenceExp>(query, search).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.Error(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<Reference> selectListForFront(object param)
        {
            Search search = (Search)param;

            using (IDbConnection con = GetHallaDb())
            {
                con.Open();
                try
                {
                    string where = " AND IS_USE = 'Y' ";
                    if (!string.IsNullOrEmpty(search.searchText))
                    {
                        if (search.searchType == Define.NOTICE_SEARCH_TYPE.GetKey("전체"))
                        {
                            where += " AND (CONTENTS LIKE CONCAT('%', @searchText, '%') OR TITLE LIKE CONCAT('%', @searchText, '%'))";
                        }
                        else if (search.searchType == Define.NOTICE_SEARCH_TYPE.GetKey("제목"))
                        {
                            where += " AND TITLE LIKE CONCAT('%', @searchText, '%') ";
                        }
                        else if (search.searchType == Define.NOTICE_SEARCH_TYPE.GetKey("내용"))
                        {
                            where += " AND CONTENTS LIKE CONCAT('%', @searchText, '%') ";
                        }
                    }

                    search.TotalCount = this.count(search, where);
                    search.MakePaging();

                    string query = "";
                    query += " SELECT ROW_NUMBER() OVER (ORDER BY INPUT_REG_DATE ASC, SEQ ASC ) AS ROW_NUM ";
                    query += "     , SEQ, USER_KEY, EMP_NO, REG_DATE, UPDATE_DATE, TITLE, CONVERT(VARCHAR(10), INPUT_REG_DATE, 120) AS INPUT_REG_DATE, CONTENTS, IS_USE, VIEW_CNT ";
                    query += " FROM REFERENCE ";
                    query += " WHERE 1=1 ";
                    query += where;
                    query += " ORDER BY INPUT_REG_DATE DESC, SEQ DESC ";
                    query += " OFFSET @pageCount * (@pageIndex -1)  ROWS FETCH NEXT @pageCount ROW ONLY ";
                    return con.Query<Reference>(query, search).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.Error(e.ToString());
                    return null;
                }
            }
        }
        public IEnumerable<Reference> selectListForFrontBase()
        {
            using (IDbConnection con = GetHallaDb())
            {
                con.Open();
                try
                {
                    string where = " AND IS_USE = 'Y' ";
                    string query = "";
                    query += " SELECT ROW_NUMBER() OVER (ORDER BY INPUT_REG_DATE ASC, SEQ ASC ) AS ROW_NUM ";
                    query += "     , SEQ, USER_KEY, EMP_NO, REG_DATE, UPDATE_DATE, TITLE, CONVERT(VARCHAR(10), INPUT_REG_DATE, 120) AS INPUT_REG_DATE, CONTENTS, IS_USE, VIEW_CNT ";
                    query += " FROM REFERENCE ";
                    query += " WHERE 1=1 ";
                    query += where;
                    query += " ORDER BY INPUT_REG_DATE DESC, SEQ DESC ";
                    return con.Query<Reference>(query).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.Error(e.ToString());
                    return null;
                }
            }
        }

        
        public Reference selectOne(object param)
        {

            using (IDbConnection con = GetHallaDb())
            {
                con.Open();
                try
                {
                    string query = "SELECT SEQ, USER_KEY, EMP_NO, REG_DATE, UPDATE_DATE, TITLE, CONVERT(VARCHAR(10), INPUT_REG_DATE, 120) AS INPUT_REG_DATE, CONTENTS, IS_USE, VIEW_CNT FROM REFERENCE WHERE SEQ = @seq ";
                    return con.Query<Reference>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.Error(e.ToString());
                    return null;
                }
            }
        }

        public ReferenceExp selectOneExp(object param)
        {

            using (IDbConnection con = GetHallaDb())
            {
                con.Open();
                try
                {
                    string query = "SELECT SEQ, USER_KEY, EMP_NO, REG_DATE, UPDATE_DATE, TITLE, CONVERT(VARCHAR(10), INPUT_REG_DATE, 120) AS INPUT_REG_DATE, CONTENTS, IS_USE, VIEW_CNT FROM REFERENCE WHERE SEQ = @seq ";
                    ReferenceExp reference = con.Query<ReferenceExp>(query, param).FirstOrDefault();

                    query = "";
                    query += " SELECT * ";
                    query += " FROM FILE_INFO ";
                    query += " WHERE ATTACH_TABLE_NAME = 'REFERENCE' ";
                    query += "     AND ATTACH_TABLE_SEQ = @seq";

                    reference.fileInfoList = con.Query<FileInfo>(query, reference).ToList();

                    return reference;
                }
                catch (Exception e)
                {
                    LogUtil.Error(e.ToString());
                    return null;
                }
            }
        }


        public ReferenceExp selectOneExpForFront(object param)
        {

            using (IDbConnection con = GetHallaDb())
            {
                con.Open();
                try
                {
                    string query = "";
                    query += " SELECT * ";
                    query += " FROM REFERENCE ";
                    query += " WHERE SEQ = @seq ";
                    query += "     AND IS_USE = 'Y' ";

                    ReferenceExp reference = con.Query<ReferenceExp>(query, param).FirstOrDefault();

                    query = "";
                    query += " SELECT * ";
                    query += " FROM FILE_INFO ";
                    query += " WHERE ATTACH_TABLE_NAME = 'REFERENCE' ";
                    query += "     AND ATTACH_TABLE_SEQ = @seq";

                    reference.fileInfoList = con.Query<FileInfo>(query, reference).ToList();

                    return reference;
                }
                catch (Exception e)
                {
                    LogUtil.Error(e.ToString());
                    return null;
                }
            }
        }

        public int update(Reference entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                con.Open();
                try
                {
                    string query =
                        "UPDATE REFERENCE SET " +
                            " UPDATE_DATE = GETDATE(), " +
                            " USER_KEY = @userKey, " +
                            " EMP_NO = @empNo, " +
                            " TITLE = @title, " +
                            " INPUT_REG_DATE = @inputRegDate, " +
                            " CONTENTS = @contents, " +
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


        public int updateViewCnt(Reference entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                con.Open();
                try
                {
                    string query =
                        "UPDATE REFERENCE SET " +
                            " VIEW_CNT = @viewCnt " +
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