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
    public class ReplyRepo : DbCon, IReplyRepo
    {
        public int count(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                con.Open();
                try
                {
                    string query = "SELECT count(*) FROM COMMENT_LIST ";
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
                    if (search.searchCpySeq >= 0)
                    {
                        where += " AND ATTACH_TABLE_SEQ = @searchCpySeq";
                    }
                    if (!string.IsNullOrEmpty(search.searchYear))
                    {
                        where += " AND COMMENT_YEAR =  @searchYear ";
                    }
                    if (!string.IsNullOrEmpty(search.searchMonth))
                    {
                        where += " AND COMMENT_MONTH =  @searchMonth ";
                    }
                    if (!string.IsNullOrEmpty(search.searchText))
                    {
                        where += " AND COMMENT LIKE CONCAT('%', @searchText, '%') ";
                    }

                    string query = "SELECT count(*) FROM COMMENT_LIST WHERE 1=1 " + where;
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

                    string query = "SELECT count(*) FROM COMMENT_LIST WHERE 1=1 " + where;
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
                    string query = "";
                    query += @"  SELECT COUNT(*)
                        FROM COMMENT_LIST
                        WHERE 1 = 1 ";
                    query += where; 

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
                    string query = "DELETE FROM COMMENT_LIST WHERE SEQ = @seq";
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

        public int insert(Reply entity)
        {

            using (IDbConnection con = GetHallaDb())
            {
                con.Open();
                try
                {
                    string query = "INSERT INTO COMMENT_LIST( " +
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

        public int save(Reply entity)
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

        public IEnumerable<Reply> selectList(object param)
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
                        //if (search.searchType == Define.Reply_SEARCH_TYPE.GetKey("전체"))
                        //{
                        //    where += " AND (CONTENTS LIKE CONCAT('%', @searchText, '%') OR TITLE LIKE CONCAT('%', @searchText, '%'))";
                        //}
                        //else if (search.searchType == Define.Reply_SEARCH_TYPE.GetKey("제목"))
                        //{
                        //    where += " AND TITLE LIKE CONCAT('%', @searchText, '%') ";
                        //}
                        //else if (search.searchType == Define.Reply_SEARCH_TYPE.GetKey("내용"))
                        //{
                        //    where += " AND CONTENTS LIKE CONCAT('%', @searchText, '%') ";
                        //}
                        //else
                        //{
                        //    where += " AND (CONTENTS LIKE CONCAT('%', @searchText, '%') OR TITLE LIKE CONCAT('%', @searchText, '%'))";
                        //}
                    }

                    search.TotalCount = this.count(search, where);
                    search.MakePaging();

                    string query = "";
                    query += " SELECT ROW_NUMBER() OVER (ORDER BY INPUT_REG_DATE ASC, SEQ ASC ) AS ROW_NUM ";
                    query += "     , SEQ, USER_KEY, EMP_NO, REG_DATE, UPDATE_DATE, TITLE, CONVERT(VARCHAR(10), INPUT_REG_DATE, 120) AS INPUT_REG_DATE, CONTENTS, IS_USE, VIEW_CNT ";
                    query += " FROM Reply ";
                    query += " WHERE 1=1 ";
                    query += where;
                    query += " ORDER BY INPUT_REG_DATE DESC, SEQ DESC ";
                    query += " OFFSET @pageCount * (@pageIndex -1)  ROWS FETCH NEXT @pageCount ROW ONLY ";
                    return con.Query<Reply>(query, search).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.Error(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<Reply> selectListForFront(object param)
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
                        where += " AND (CONTENTS LIKE CONCAT('%', @searchText, '%') OR TITLE LIKE CONCAT('%', @searchText, '%'))";
                    }

                    search.TotalCount = this.count(search, where);
                    search.MakePaging();

                    string query = "";
                    query += " SELECT ROW_NUMBER() OVER (ORDER BY INPUT_REG_DATE ASC, SEQ ASC ) AS ROW_NUM ";
                    query += "     , SEQ, USER_KEY, EMP_NO, REG_DATE, UPDATE_DATE, TITLE, CONVERT(VARCHAR(10), INPUT_REG_DATE, 120) AS INPUT_REG_DATE, CONTENTS, IS_USE, VIEW_CNT ";
                    query += " FROM Reply ";
                    query += " WHERE 1=1 ";
                    query += where;
                    query += " ORDER BY INPUT_REG_DATE DESC, SEQ DESC ";
                    query += " OFFSET @pageCount * (@pageIndex -1)  ROWS FETCH NEXT @pageCount ROW ONLY ";
                    return con.Query<Reply>(query, search).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.Error(e.ToString());
                    return null;
                }
            }
        }


        public IEnumerable<Reply> selectListForFrontBase()
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
                    query += " FROM Reply ";
                    query += " WHERE 1=1 ";
                    query += where;
                    query += " ORDER BY INPUT_REG_DATE DESC, SEQ DESC ";
                    return con.Query<Reply>(query).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.Error(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<ReplyExp> selectListExp(object param)
        {
            Search search = (Search)param;

            using (IDbConnection con = GetHallaDb())
            {
                con.Open();
                try
                {
                    string where = " AND ATTACH_TABLE_SEQ = 0 AND COMMENT_MONTH =  '99' ";
                   
                    if (!string.IsNullOrEmpty(search.searchYear))
                    {
                        where += " AND COMMENT_YEAR =  @searchYear ";
                    }
                    if (!string.IsNullOrEmpty(search.searchBusType))
                    {
                        where += " AND ATTACH_TABLE_NAME =  @searchBusType ";
                    }
                    if (!string.IsNullOrEmpty(search.searchText))
                    {
                        where += " AND COMMENT LIKE CONCAT('%', @searchText, '%') ";
                    }

                    search.TotalCount = this.count(search, where);
                    search.MakePaging();

                    string query = "";
                    query += @"  SELECT  ROW_NUMBER() OVER (ORDER BY A.ATTACH_TABLE_SEQ, A.COMMENT_YEAR DESC, A.COMMENT_MONTH DESC, A.SEQ  ) AS ROW_NUM
		                        ,A.SEQ
		                        ,A.USER_KEY
		                        ,A.EMP_NO
		                        ,USER_KOR_NAME
		                        ,COMP_KOR_NAME
		                        ,DEPT_KOR_NAME
		                        ,CONVERT(VARCHAR(10) , A.CREATE_DATE,120) AS INPUT_REG_DATE
		                        ,ATTACH_TABLE_NAME
		                        ,ATTACH_TABLE_SEQ
		                        ,COMMENT_YEAR
		                        ,COMMENT_MONTH
		                        ,COMMENT
		                        ,ADMIN_WRITE
		                        ,ISNULL(B.COMPANY_NAME,'그룹') COMPANY_NAME
                        FROM COMMENT_LIST A
                        LEFT OUTER JOIN ORG_COMPANY B
                        ON A.ATTACH_TABLE_SEQ = B.SEQ
                        WHERE 1 = 1 ";
                    query += where;
                    query += @"  ORDER BY A.ATTACH_TABLE_SEQ,A.COMMENT_YEAR DESC, A.COMMENT_MONTH DESC , A.SEQ  ";
                    //query += "     , SEQ, USER_KEY, EMP_NO, REG_DATE, UPDATE_DATE, TITLE, CONVERT(VARCHAR(10), INPUT_REG_DATE, 120) AS INPUT_REG_DATE, CONTENTS, IS_USE, VIEW_CNT ";
                    //query += "     , (SELECT AUTH_USER_KOR_NAME FROM ADMIN_AUTH WHERE AUTH_USER_KEY = A.USER_KEY AND AUTH_EMP_NO = A.EMP_NO) AS ADMIN_NAME ";
                    //query += " FROM Reply A";
                    //query += " WHERE 1=1 ";
                    //query += where;
                    //query += " ORDER BY INPUT_REG_DATE DESC, SEQ DESC ";
                    query += " OFFSET @pageCount * (@pageIndex -1)  ROWS FETCH NEXT @pageCount ROW ONLY ";
                    return con.Query<ReplyExp>(query, search).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.Error(e.ToString());
                    return null;
                }
            }
        }

        public Reply selectOne(object param)
        {

            using (IDbConnection con = GetHallaDb())
            {
                con.Open();
                try
                {
                    string query = "SELECT SEQ, USER_KEY, EMP_NO, REG_DATE, UPDATE_DATE, TITLE, CONVERT(VARCHAR(10), INPUT_REG_DATE, 120) AS INPUT_REG_DATE, CONTENTS, IS_USE, VIEW_CNT FROM Reply WHERE SEQ = @seq ";
                    return con.Query<Reply>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.Error(e.ToString());
                    return null;
                }
            }
        }
        public ReplyExp selectOneExp(object param)
        {

            using (IDbConnection con = GetHallaDb())
            {
                con.Open();
                try
                {
                    string query = "SELECT SEQ, USER_KEY, EMP_NO, REG_DATE, UPDATE_DATE, TITLE, CONVERT(VARCHAR(10), INPUT_REG_DATE, 120) AS INPUT_REG_DATE, CONTENTS, IS_USE, VIEW_CNT FROM Reply WHERE SEQ = @seq ";
                    ReplyExp Reply = con.Query<ReplyExp>(query, param).FirstOrDefault();
                    

                    return Reply;
                }
                catch (Exception e)
                {
                    LogUtil.Error(e.ToString());
                    return null;
                }
            }
        }

        public ReplyExp selectOneExpForFront(object param)
        {

            using (IDbConnection con = GetHallaDb())
            {
                con.Open();
                try
                {
                    string query = "";
                    query += " SELECT * ";
                    query += " FROM Reply ";
                    query += " WHERE SEQ = @seq ";
                    query += "     AND IS_USE = 'Y' ";

                    ReplyExp Reply = con.Query<ReplyExp>(query, param).FirstOrDefault();
                   

                    return Reply;
                }
                catch (Exception e)
                {
                    LogUtil.Error(e.ToString());
                    return null;
                }
            }
        }
        public int update(Reply entity)
        {

            using (IDbConnection con = GetHallaDb())
            {
                con.Open();
                try
                {
                    string query =
                        "UPDATE Reply SET " +
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

        public int updateViewCnt(Reply entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                con.Open();
                try
                {
                    string query =
                        "UPDATE Reply SET " +
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

        public IEnumerable<ReplyExp> selectListPm(object param)
        {
            Search search = (Search)param;

            using (IDbConnection con = GetHallaDb())
            {
                con.Open();
                try
                {
                    string where = " AND COMMENT_MONTH != '99'  ";

                    if ( search.searchCpySeq >= 0 )
                    {
                        where += " AND ATTACH_TABLE_SEQ =  @searchCpySeq ";
                    }

                    if (!string.IsNullOrEmpty(search.searchYear))
                    {
                        where += " AND COMMENT_YEAR =  @searchYear ";
                    }
                    if (!string.IsNullOrEmpty(search.searchMonth))
                    {
                        where += " AND COMMENT_MONTH =  @searchMonth";
                    }
                    if (!string.IsNullOrEmpty(search.searchText))
                    {
                        where += " AND COMMENT LIKE CONCAT('%', @searchText, '%') ";
                    }

                    search.TotalCount = this.count(search, where);
                    search.MakePaging();

                    string query = "";
                    query += @"  SELECT  ROW_NUMBER() OVER (ORDER BY A.ATTACH_TABLE_SEQ, A.COMMENT_YEAR DESC, A.COMMENT_MONTH DESC, A.SEQ  ) AS ROW_NUM
		                        ,A.SEQ
		                        ,A.USER_KEY
		                        ,A.EMP_NO
		                        ,USER_KOR_NAME
		                        ,COMP_KOR_NAME
		                        ,DEPT_KOR_NAME
		                        ,CONVERT(VARCHAR(10) , A.CREATE_DATE,120) AS INPUT_REG_DATE
		                        ,ATTACH_TABLE_NAME
		                        ,ATTACH_TABLE_SEQ
		                        ,COMMENT_YEAR
		                        ,COMMENT_MONTH
		                        ,COMMENT
		                        ,ADMIN_WRITE
		                        ,ISNULL(B.COMPANY_NAME,'그룹') COMPANY_NAME
                        FROM COMMENT_LIST A
                        LEFT OUTER JOIN ORG_COMPANY B
                        ON A.ATTACH_TABLE_SEQ = B.SEQ
                        WHERE 1 = 1 ";
                    query += where;
                    query += @"  ORDER BY A.ATTACH_TABLE_SEQ,A.COMMENT_YEAR DESC, A.COMMENT_MONTH DESC , A.SEQ  ";
                    //query += "     , SEQ, USER_KEY, EMP_NO, REG_DATE, UPDATE_DATE, TITLE, CONVERT(VARCHAR(10), INPUT_REG_DATE, 120) AS INPUT_REG_DATE, CONTENTS, IS_USE, VIEW_CNT ";
                    //query += "     , (SELECT AUTH_USER_KOR_NAME FROM ADMIN_AUTH WHERE AUTH_USER_KEY = A.USER_KEY AND AUTH_EMP_NO = A.EMP_NO) AS ADMIN_NAME ";
                    //query += " FROM Reply A";
                    //query += " WHERE 1=1 ";
                    //query += where;
                    //query += " ORDER BY INPUT_REG_DATE DESC, SEQ DESC ";
                    query += " OFFSET @pageCount * (@pageIndex -1)  ROWS FETCH NEXT @pageCount ROW ONLY ";
                    return con.Query<ReplyExp>(query, search).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.Error(e.ToString());
                    return null;
                }
            }
        }
    }
}