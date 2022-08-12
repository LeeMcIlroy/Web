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
    public class NoticeRepo : DbCon, INoticeRepo
    {
        public int count(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                con.Open();
                try
                {
                    string query = "SELECT count(*) FROM NOTICE ";
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
                        else
                        {
                            where += " AND (CONTENTS LIKE CONCAT('%', @searchText, '%') OR TITLE LIKE CONCAT('%', @searchText, '%'))";
                        }
                    }

                    string query = "SELECT count(*) FROM NOTICE WHERE 1=1 " + where;
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

                    string query = "SELECT count(*) FROM NOTICE WHERE 1=1 " + where;
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
                    string query = "SELECT count(*) FROM NOTICE WHERE 1=1 " + where;
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
                    string query = "DELETE FROM NOTICE WHERE SEQ = @seq";
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

        public int insert(Notice entity)
        {

            using (IDbConnection con = GetHallaDb())
            {
                con.Open();
                try
                {
                    string query = "INSERT INTO NOTICE( " +
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

        public int save(Notice entity)
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

        public IEnumerable<Notice> selectList(object param)
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
                        if(search.searchType == Define.NOTICE_SEARCH_TYPE.GetKey("전체"))
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
                        }else
                        {
                            where += " AND (CONTENTS LIKE CONCAT('%', @searchText, '%') OR TITLE LIKE CONCAT('%', @searchText, '%'))";
                        }
                    }

                    search.TotalCount = this.count(search, where);
                    search.MakePaging();

                    string query = "";
                    query += " SELECT ROW_NUMBER() OVER (ORDER BY INPUT_REG_DATE ASC, SEQ ASC ) AS ROW_NUM ";
                    query += "     , SEQ, USER_KEY, EMP_NO, REG_DATE, UPDATE_DATE, TITLE, CONVERT(VARCHAR(10), INPUT_REG_DATE, 120) AS INPUT_REG_DATE, CONTENTS, IS_USE, VIEW_CNT ";
                    query += " FROM NOTICE ";
                    query += " WHERE 1=1 ";
                    query += where;
                    query += " ORDER BY INPUT_REG_DATE DESC, SEQ DESC ";
                    query += " OFFSET @pageCount * (@pageIndex -1)  ROWS FETCH NEXT @pageCount ROW ONLY ";
                    return con.Query<Notice>(query, search).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.Error(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<Notice> selectListForFront(object param)
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
                    query += " FROM NOTICE ";
                    query += " WHERE 1=1 ";
                    query += where;
                    query += " ORDER BY INPUT_REG_DATE DESC, SEQ DESC ";
                    query += " OFFSET @pageCount * (@pageIndex -1)  ROWS FETCH NEXT @pageCount ROW ONLY ";
                    return con.Query<Notice>(query, search).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.Error(e.ToString());
                    return null;
                }
            }
        }


        public IEnumerable<Notice> selectListForFrontBase()
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
                    query += " FROM NOTICE ";
                    query += " WHERE 1=1 ";
                    query += where;
                    query += " ORDER BY INPUT_REG_DATE DESC, SEQ DESC ";
                    return con.Query<Notice>(query).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.Error(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<NoticeExp> selectListExp(object param)
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
                    query += "     , (SELECT AUTH_USER_KOR_NAME FROM ADMIN_AUTH WHERE AUTH_USER_KEY = A.USER_KEY AND AUTH_EMP_NO = A.EMP_NO) AS ADMIN_NAME ";
                    query += " FROM NOTICE A";
                    query += " WHERE 1=1 ";
                    query += where;
                    query += " ORDER BY INPUT_REG_DATE DESC, SEQ DESC ";
                    query += " OFFSET @pageCount * (@pageIndex -1)  ROWS FETCH NEXT @pageCount ROW ONLY ";
                    return con.Query<NoticeExp>(query, search).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.Error(e.ToString());
                    return null;
                }
            }
        }

        public Notice selectOne(object param)
        {

            using (IDbConnection con = GetHallaDb())
            {
                con.Open();
                try
                {
                    string query = "SELECT SEQ, USER_KEY, EMP_NO, REG_DATE, UPDATE_DATE, TITLE, CONVERT(VARCHAR(10), INPUT_REG_DATE, 120) AS INPUT_REG_DATE, CONTENTS, IS_USE, VIEW_CNT FROM NOTICE WHERE SEQ = @seq ";
                    return con.Query<Notice>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.Error(e.ToString());
                    return null;
                }
            }
        }
        public NoticeExp selectOneExp(object param)
        {

            using (IDbConnection con = GetHallaDb())
            {
                con.Open();
                try
                {
                    string query = "SELECT SEQ, USER_KEY, EMP_NO, REG_DATE, UPDATE_DATE, TITLE, CONVERT(VARCHAR(10), INPUT_REG_DATE, 120) AS INPUT_REG_DATE, CONTENTS, IS_USE, VIEW_CNT FROM NOTICE WHERE SEQ = @seq ";
                    NoticeExp notice = con.Query<NoticeExp>(query, param).FirstOrDefault();

                    query = "";
                    query += " SELECT * ";
                    query += " FROM FILE_INFO ";
                    query += " WHERE ATTACH_TABLE_NAME = 'NOTICE' ";
                    query += "     AND ATTACH_TABLE_SEQ = @seq";

                    notice.fileInfoList = con.Query<FileInfo>(query, notice).ToList();

                    return notice;
                }
                catch (Exception e)
                {
                    LogUtil.Error(e.ToString());
                    return null;
                }
            }
        }

        public NoticeExp selectOneExpForFront(object param)
        {

            using (IDbConnection con = GetHallaDb())
            {
                con.Open();
                try
                {
                    string query = "";
                    query += " SELECT * ";
                    query += " FROM NOTICE ";
                    query += " WHERE SEQ = @seq ";
                    query += "     AND IS_USE = 'Y' ";

                    NoticeExp notice = con.Query<NoticeExp>(query, param).FirstOrDefault();

                    query = "";
                    query += " SELECT * ";
                    query += " FROM FILE_INFO ";
                    query += " WHERE ATTACH_TABLE_NAME = 'NOTICE' ";
                    query += "     AND ATTACH_TABLE_SEQ = @seq";

                    notice.fileInfoList = con.Query<FileInfo>(query, notice).ToList();

                    return notice;
                }
                catch (Exception e)
                {
                    LogUtil.Error(e.ToString());
                    return null;
                }
            }
        }
        public int update(Notice entity)
        {

            using (IDbConnection con = GetHallaDb())
            {
                con.Open();
                try
                {
                    string query =
                        "UPDATE NOTICE SET " +
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

        public int updateViewCnt(Notice entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                con.Open();
                try
                {
                    string query =
                        "UPDATE NOTICE SET " +
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