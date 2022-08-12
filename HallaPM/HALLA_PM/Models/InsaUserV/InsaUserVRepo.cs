using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Data;
using Dapper;
using HALLA_PM.Util;

namespace HALLA_PM.Models
{
    public class InsaUserVRepo : DbCon, IInsaUserVRepo
    {
        #region public int count(object param) : 데이터 갯수입니다.
        /// <summary>
        /// 데이터 갯수입니다.
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        public int count(object param)
        {
            return 0;
        }
        #endregion

        #region public IEnumerable<InsaUserV> selectList(object param) : 데이터 리스트입니다.
        /// <summary>
        /// 데이터 리스트입니다.(구성원 검색용) 
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        public IEnumerable<InsaUserV> selectList(object param)
        {
            using (IDbConnection con = GetInsaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
                                    SELECT	A.USER_KEY, A.EmpNo, A.UserKorName, A.COMPCODE2, A.CompCode, A.LevelKorName,
                                    (SELECT TOP 1 B.CompKorName FROM TB_HEIS_InsaDeptV B WHERE A.CompCode = B.CompCode) AS COMP_KOR_NAME,
                                    (SELECT TOP 1 C.DeptKorName FROM TB_HEIS_InsaDeptV C WHERE A.DeptCode = C.DeptCode) AS DeptKorName
                                    FROM TB_HEIS_InsaUserV A WITH(NOLOCK) 
                                    WHERE   UserKorName LIKE '%' + @UserKorName + '%'
                                    ";
                    /*
                    string query = "SELECT	A.USER_KEY, A.EmpNo, A.UserKorName, A.COMPCODE2, A.CompCode, " +
                        " (SELECT TOP 1 B.CompKorName FROM TB_HEIS_InsaDeptV B WHERE A.CompCode = B.CompCode) AS COMP_KOR_NAME " +
                        " FROM TB_HEIS_InsaUserV A WITH(NOLOCK) " +
                        " WHERE   UserKorName LIKE '%' + @UserKorName + '%'" +
                        " GROUP BY A.USER_KEY, A.EmpNo, A.UserKorName, A.COMPCODE2, A.CompCode";
                    */
                    //string query = " SELECT * FROM TB_HEIS_InsaUserV WHERE UserKorName LIKE '%' + @UserKorName + '%'";
                    return con.Query<InsaUserV>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }
        #endregion


        public IEnumerable<InsaUserV> selectListWithAuth(object param)
        {
            using (IDbConnection con = GetInsaDb())
            {
                try
                {
                    con.Open();
                    string query = @"
                                    ;WITH LIST_USER AS
                                    (
                                    SELECT	ROW_NUMBER() OVER (PARTITION BY A.USER_KEY ORDER BY USER_KEY DESC) ROW_NUM, A.*, B.CompKorName
                                    FROM	TB_HEIS_InsaUserV A LEFT OUTER JOIN TB_HEIS_InsaDeptV B ON A.DeptCode = B.DeptCode
                                    WHERE	CHARINDEX(USER_KEY, @EmpNo) > 0
                                    )
                                    SELECT	*
                                    FROM	LIST_USER
                                    WHERE	ROW_NUM = 1
                                    ";
                                    //;WITH LIST_USER AS
                                    //(
                                    //SELECT	ROW_NUMBER() OVER (PARTITION BY A.USER_KEY ORDER BY IS_DEFAULT DESC) ROW_NUM, A.*, B.CompKorName
                                    //FROM	TB_HEIS_InsaUserV A LEFT OUTER JOIN TB_HEIS_InsaDeptV B ON A.DeptCode = B.DeptCode
                                    //WHERE	CHARINDEX(USER_KEY, @EmpNo) > 0
                                    //)
                                    //SELECT	*
                                    //FROM	LIST_USER
                                    //WHERE	ROW_NUM = 1
                    //string query = " SELECT * FROM TB_HEIS_InsaUserV WHERE UserKorName LIKE '%' + @UserKorName + '%'";
                    return con.Query<InsaUserV>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        #region InsaUserV selectOne(object param) : 데이터 상세입니다.(한건)
        /// <summary>
        /// 데이터 상세입니다.(한건)
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        public InsaUserV selectOne(object param)
        {
            using (IDbConnection con = GetInsaDb())
            {
                try
                {
                    con.Open();
                    #region
                    /*SELECT [COMPCODE2]
                    ,[USER_KEY]
                    ,[EmpNo]
                    ,[EmailAddress]
                    ,[UserKorName]
                    ,[UserEngName]
                    ,[UserChnName]
                    ,[CompCode]
                    ,[DeptCode]
                    ,[LevelCode]
                    ,[LevelKorName]
                    ,[LevelEngName]
                    ,[LevelChnName]
                    ,[PositionCode]
                    ,[PositionKorName]
                    ,[PositionEngName]
                    ,[PositionChnName]
                    ,[JikgunCode]
                    ,[JikgunKorName]
                    ,[JikgunEngName]
                    ,[JikgunChnName]
                    ,[MyPhotoUrl]
                    ,[CODEPAGE]
                    ,[MobilePhone]
                    ,[LocationPhone]
                    ,[StatusCode]
                    FROM [dbo].[TB_HEIS_InsaUserV]*/
                    #endregion
                    //string query = " SELECT * FROM TB_HEIS_InsaUserV WHERE EmpNo = @EmpNo ORDER BY DeptCode";
                    string query = " SELECT * FROM TB_HEIS_InsaUserV WHERE USER_KEY = @EmpNo";
                    return con.Query<InsaUserV>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }
        #endregion

        public InsaUserV selectOneJoinDept(object param)
        {
            using (IDbConnection con = GetInsaDb())
            {
                try
                {
                    con.Open();
                    #region
                    /*SELECT [COMPCODE2]
                    ,[USER_KEY]
                    ,[EmpNo]
                    ,[EmailAddress]
                    ,[UserKorName]
                    ,[UserEngName]
                    ,[UserChnName]
                    ,[CompCode]
                    ,[DeptCode]
                    ,[LevelCode]
                    ,[LevelKorName]
                    ,[LevelEngName]
                    ,[LevelChnName]
                    ,[PositionCode]
                    ,[PositionKorName]
                    ,[PositionEngName]
                    ,[PositionChnName]
                    ,[JikgunCode]
                    ,[JikgunKorName]
                    ,[JikgunEngName]
                    ,[JikgunChnName]
                    ,[MyPhotoUrl]
                    ,[CODEPAGE]
                    ,[MobilePhone]
                    ,[LocationPhone]
                    ,[StatusCode]
                    FROM [dbo].[TB_HEIS_InsaUserV]*/
                    #endregion
                    //string query = " SELECT * FROM TB_HEIS_InsaUserV WHERE EmpNo = @EmpNo ORDER BY DeptCode";
                    string query = " SELECT A.*, B.CompKorName FROM TB_HEIS_InsaUserV A LEFT OUTER JOIN TB_HEIS_InsaDeptV B ON A.DeptCode = B.DeptCode WHERE USER_KEY = @EmpNo ORDER BY IS_DEFAULT DESC ";
                    return con.Query<InsaUserV>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public int ExecProcedure(string exec)
        {
            using (IDbConnection con = GetInsaDb())
            {
                try
                {
                    con.Open();
                    return con.Execute(exec);
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return -1;
                }
            }
        }

        public InsaUserV selectOneMail(object param)
        {
            using (IDbConnection con = GetInsaDb())
            {
                try
                {
                    con.Open();
                    string query = " SELECT TOP 1 * FROM TB_HEIS_InsaUserV WHERE USER_KEY = @userKey ";
                    return con.Query<InsaUserV>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<InsaUserV> selectListAuth()
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = @"
                                    SELECT	*
                                    FROM	(
                                    SELECT	AUTH_USER_KEY AS USER_KEY
                                    FROM	SYSTEM_AUTH
                                    WHERE	1 = 1
                                    AND		IS_USE = 'Y'
                                    UNION ALL
                                    SELECT	AUTH_USER_KEY AS USER_KEY
                                    FROM	ADMIN_AUTH
                                    WHERE	1 = 1
                                    AND		IS_USE = 'Y'
                                    )			A
                                    GROUP BY USER_KEY
                                    ";

                    return con.Query<InsaUserV>(query).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        #region public int insert(InsaUserV entity) : 입력입니다.
        /// <summary>
        /// 입력입니다.
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public int insert(InsaUserV entity)
        {
            return 0;
        }
        #endregion

        #region public int update(InsaUserV entity) : 수정입니다.
        /// <summary>
        /// 수정입니다.
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public int update(InsaUserV entity)
        {
            return 0;
        }
        #endregion

        #region public int delete(object param) : 삭제입니다.
        /// <summary>
        /// 삭제입니다.
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        public int delete(object param)
        {
            return 0;
        }
        #endregion

        #region public int save(InsaUserV entity) : 저장입니다.
        /// <summary>
        /// 저장입니다.
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public int save(InsaUserV entity)
        {
            var item = selectOne(entity);
            if (item == null)
            {
                return insert(entity);
            }
            else
            {
                return update(entity);
            }
        }
        #endregion

        #region Dispose : 닫기
        public void Dispose()
        {
            throw new NotImplementedException();
        }
        #endregion
    }
}