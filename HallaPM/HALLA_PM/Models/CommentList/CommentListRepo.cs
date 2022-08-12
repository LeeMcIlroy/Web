using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Data;
using Dapper;
using HALLA_PM.Util;

namespace HALLA_PM.Models
{
    public class CommentListRepo : DbCon, ICommentListRepo
    {
        public int count(object param)
        {
            throw new NotImplementedException();
        }
        public int count(object param, string where)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " SELECT COUNT(*) FROM COMMENT_LIST " + where;

                    LogUtil.ReportErrorLog(query.ToString());
                    return con.Query<int>(query, param).First();
                }
                catch (Exception e)
                {
                    LogUtil.ReportErrorLog(e.ToString());
                    return -1;
                }
            }
        }

        public int delete(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = " DELETE COMMENT_LIST " +
                        " WHERE SEQ = @Seq  ";
                    return con.Execute(query, param);

                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return -1;
                }
            }
        }

        public void Dispose()
        {
            throw new NotImplementedException();
        }

        public int insert(CommentList entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " INSERT INTO  COMMENT_LIST ( " +
                        // 이부분은 수정하여 사용하세요. 
                        "USER_KEY " +
                        ", EMP_NO " +
                        ", USER_KOR_NAME " +
                        ", COMP_KOR_NAME " +
                        ", DEPT_KOR_NAME " +
                        ", CREATE_DATE " +
                        ", ATTACH_TABLE_NAME " +
                        ", ATTACH_TABLE_SEQ " +
                        ", COMMENT_YEAR " +
                        ", COMMENT_MONTH " +
                        ", COMMENT " +
                        ", ADMIN_WRITE " +

        
                    " ) VALUES ( " +
                    "@UserKey " +
                    ", @EmpNo " +
                    ", @UserKorName " +                    
                    ", @CompKorName " +
                    ", @DeptKorName " +
                    ", GETDATE() " +
                    ", @AttachTableName " +
                    ", @AttachTableSeq " +
                    ", @CommentYear " +
                    ", @CommentMonth " +
                    ", @Comment " +
                    ", @AdminWrite " +
                    // 이부분은 수정하여 사용하세요. 
                    "); SELECT CAST(SCOPE_IDENTITY() as int)";
                    return con.Query<int>(query, entity).First();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return -1;
                }
            }

        }

        public int save(CommentList entity)
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

        public IEnumerable<CommentList> selectListAll(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string where = @" 
WHERE	1 = 1
AND		ATTACH_TABLE_NAME = @AttachTableName
AND		COMMENT_YEAR = @CommentYear
AND		COMMENT_MONTH = @CommentMonth
AND		ATTACH_TABLE_SEQ = @AttachTableSeq
";

                    string query = @" 
SELECT	USER_KEY
FROM	COMMENT_LIST " + where + @"
GROUP BY USER_KEY";
                    
                    return con.Query<CommentList>(query, param).ToList();

                }
                catch (Exception e)
                {
                    LogUtil.ReportErrorLog(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<CommentList> selectList(object param)
        {
            CommentList search = (CommentList)param;
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string where = @" 
WHERE	1 = 1
AND		ATTACH_TABLE_NAME = @AttachTableName
AND		COMMENT_YEAR = @CommentYear
AND		COMMENT_MONTH = @CommentMonth
AND		ATTACH_TABLE_SEQ = @AttachTableSeq
";

                    string query = @" 
SELECT	ROW_NUMBER() OVER (ORDER BY CREATE_DATE ASC) AS ROW_NUM
		, SEQ
        , USER_KEY
        , EMP_NO
        , USER_KOR_NAME
        , COMP_KOR_NAME
        , DEPT_KOR_NAME
        , CREATE_DATE
        , CONVERT(VARCHAR(10), CREATE_DATE, 121) AS CreateDateToString
        , ATTACH_TABLE_NAME
        , ATTACH_TABLE_SEQ
        , COMMENT_YEAR
        , COMMENT_MONTH
        , COMMENT
		, ADMIN_WRITE
FROM	COMMENT_LIST " + where + @"
ORDER BY CREATE_DATE DESC
OFFSET	@PageCount * (@PageIndex -1)  ROWS FETCH NEXT @PageCount ROW ONLY";

                    search.TotalCount = count(search, where);
                    search.MakePaging();

                    return con.Query<CommentList>(query, param).ToList();

                }
                catch (Exception e)
                {
                    LogUtil.ReportErrorLog(e.ToString());
                    return null;
                }
            }
        }

        public CommentList selectOne(object param)
        {
            CommentList search = (CommentList)param;
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string where = @" 
WHERE	1 = 1
AND		ATTACH_TABLE_NAME = @AttachTableName
AND		COMMENT_YEAR = @CommentYear
AND		COMMENT_MONTH = @CommentMonth
AND		ATTACH_TABLE_SEQ = @AttachTableSeq
AND     ADMIN_WRITE = @AdminWrite
";

                    string query = @" 
SELECT	TOP 1 SEQ
        , USER_KEY
        , EMP_NO
        , USER_KOR_NAME
        , COMP_KOR_NAME
        , DEPT_KOR_NAME
        , CREATE_DATE
        , CONVERT(VARCHAR(10), CREATE_DATE, 121) AS CreateDateToString
        , ATTACH_TABLE_NAME
        , ATTACH_TABLE_SEQ
        , COMMENT_YEAR
        , COMMENT_MONTH
        , COMMENT

FROM	COMMENT_LIST " + where + @"
ORDER BY CREATE_DATE DESC
";
                    return con.Query<CommentList>(query, param).FirstOrDefault();

                }
                catch (Exception e)
                {
                    LogUtil.ReportErrorLog(e.ToString());
                    return null;
                }
            }
        }

        public int update(CommentList entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " UPDATE COMMENT_LIST SET " +
                        // 이부분은 수정하여 사용하세요. 
                        //" , SEQ = @Seq" +
                        " COMMENT = @Comment" +
" WHERE   1 = 1 " +
" AND ATTACH_TABLE_NAME = @AttachTableName " +
" AND COMMENT_YEAR = @CommentYear " +
" AND COMMENT_MONTH = @CommentMonth " +
" AND ATTACH_TABLE_SEQ = @AttachTableSeq " +
" AND ADMIN_WRITE = @AdminWrite " +
                    // 이부분은 수정하여 사용하세요. 
                    "; SELECT @@ROWCOUNT";
                    return con.Query<int>(query, entity).First();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return -1;
                }
            }
        }
    }
}