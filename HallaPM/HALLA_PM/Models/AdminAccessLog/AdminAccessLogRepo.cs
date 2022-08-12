using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Data;
using Dapper;
using HALLA_PM.Util;

namespace HALLA_PM.Models
{
    public class AdminAccessLogRepo : DbCon, IAdminAccessLogRepo
    {
        #region public int count(object param) : 데이터갯수입니다.
        /// <summary>
        /// 데이터 갯수입니다.
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        public int count(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " SELECT COUNT(*) FROM ADMIN_ACCESS_LOG ";
                    return con.Query<int>(query, param).First();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return -1;
                }
            }
        }
        #endregion

        #region public IEnumerable<AdminAccessLog> selectList(object param) : 데이터리스트입니다.
        /// <summary>
        /// 데이터리스트입니다.
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        public IEnumerable<AdminAccessLog> selectList(object param)
        {

            Search search = (Search)param;
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string where = " WHERE 1 = 1 ";

                    string query = " SELECT ROW_NUMBER() OVER (ORDER BY ACCESS_DATE ASC) AS ROW_NUM, * FROM ADMIN_ACCESS_LOG " + where +
                        " ORDER BY ACCESS_DATE DESC " +
                        " OFFSET @PageCount * (@PageIndex -1)  ROWS FETCH NEXT @PageCount ROW ONLY "; ;

                    search.TotalCount = count(search);
                    search.MakePaging();

                    return con.Query<AdminAccessLog>(query, param).ToList();

                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }
        #endregion

        #region public AdminAccessLog selectOne(object param) : 데이터 상세입니다.
        /// <summary>
        /// 데이터 상세입니다.
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        public AdminAccessLog selectOne(object param)
        {
            return null;
        }
        #endregion

        #region public int insert(AdminAccessLog entity) : 데이터입력입니다.
        /// <summary>
        /// 데이터입력입니다.
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public int insert(AdminAccessLog entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = " INSERT INTO ADMIN_ACCESS_LOG ( " +
                        " ACCESS_DATE " +
                        " , USER_KEY " +
                        " , EMP_NO " +
                        " , USER_KOR_NAME " +
                        " , IP " +
                        " , MEMO " +
                        " , DESCRITION " +
                        " ) VALUES ( " +
                        " GETDATE() " +
                        " , @UserKey " +
                        " , @EmpNo " +
                        " , @UserKorName " +
                        " , @Ip " +
                        " , @Memo " +
                        " , @Descrition " +
                        " ); SELECT @@ROWCOUNT ";
                    return con.Query<int>(query, entity).First();

                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return -1;
                }
            }
        }
        #endregion

        #region public int update(AdminAccessLog entity) : 데이터수정입니다.
        /// <summary>
        /// 데이터수정입니다.
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public int update(AdminAccessLog entity)
        {
            return -1;
        }
        #endregion

        #region public int delete(object param) : 데이터삭제입니다.
        /// <summary>
        /// 데이터삭제입니다.
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        public int delete(object param)
        {
            return -1;
        }
        #endregion

        #region public int save(AdminAccessLog entity) : 데이터저장입니다.
        /// <summary>
        /// 데이터저장입니다.
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public int save(AdminAccessLog entity)
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