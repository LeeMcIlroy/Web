using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Data;
using Dapper;
using HALLA_PM.Util;

namespace HALLA_PM.Models
{
    /// <summary>
    /// <세부항목>
    /// </summary>
    public class DisclosureDetailRepo : DbCon, IDisclosureDetailRepo
    {
        public int count(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " SELECT COUNT(*) FROM DISCLOSURE_DETAIL ";
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
                    string query = " SELECT COUNT(*) FROM DISCLOSURE_DETAIL " + where;
                    return con.Query<int>(query, param).First();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return -1;
                }
            }
        }

        public IEnumerable<DisclosureDetail> selectList(object param)
        {
            //Search search = (Search)param;
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string where = " WHERE 1 = 1 AND IS_USE = 'Y' AND DIS_ITEM_SEQ = @DisItemSeq ";

                    string query = " SELECT ROW_NUMBER() OVER (ORDER BY CREATE_DATE ASC) AS ROW_NUM, * FROM DISCLOSURE_DETAIL " + where;

                    //search.TotalCount = count(search, where);
                    //search.MakePaging();

                    return con.Query<DisclosureDetail>(query, param).ToList();

                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }
        public IEnumerable<DisclosureDetailExp> selectListExp(object param)
        {
            //Search search = (Search)param;
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = "";
                    query += " SELECT * ";
                    query += " FROM DISCLOSURE_DETAIL ";
                    query += " WHERE IS_USE = 'Y' ";
                    query += " ORDER BY SEQ ASC ";
                    return con.Query<DisclosureDetailExp>(query, param).ToList();

                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public DisclosureDetail selectOne(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = " SELECT * FROM DISCLOSURE_DETAIL WHERE SEQ = @Seq ";

                    return con.Query<DisclosureDetail>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public int selectDuplicate(object param)
        {

            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = " SELECT COUNT(*) FROM DISCLOSURE_DETAIL WHERE DETAIL_NAME = @DetailName AND DIS_ITEM_SEQ = @DisItemSeq";

                    return con.Query<int>(query, param).First();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return -1;
                }
            }
        }
        public IEnumerable<DisclosureDetail> selectListUnion(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = " SELECT A.*, B.DIS_NAME " +
                        " FROM DISCLOSURE_DETAIL A " +
                        " LEFT OUTER JOIN DISCLOSURE_ITEM B ON DIS_ITEM_SEQ = B.SEQ WHERE B.SEQ = @Seq ";

                    return con.Query<DisclosureDetail>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }
        public int insert(DisclosureDetail entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = " INSERT INTO DISCLOSURE_DETAIL ( " +
                        "   DIS_ITEM_SEQ"+
                        " , DETAIL_NAME " +
                        " , IS_USE " +
                        " , USER_KEY " +
                        " , EMP_NO " +
                        " , CREATE_DATE " +
                        " ) VALUES ( " +
                        "   @DisItemSeq " +
                        " , @DetailName " +
                        " , @IsUse " +
                        " , @UserKey " +
                        " , @EmpNo " +
                        " , GETDATE() " +
                        " ); SELECT CAST(SCOPE_IDENTITY() as int) ";
                    return con.Query<int>(query, entity).First();

                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return -1;
                }
            }
        }

        public int update(DisclosureDetail entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = " UPDATE DISCLOSURE_DETAIL SET " +
                        "   DETAIL_NAME = @DetailName" +
                        " , IS_USE = @IsUse" +
                        " , USER_KEY = @UserKey " +
                        " , EMP_NO = @EmpNo " +
                        " , CREATE_DATE = GETDATE() " +
                        " WHERE SEQ = @Seq " +
                        " SELECT @@ROWCOUNT ";
                    return con.Query<int>(query, entity).First();

                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
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

                    string query = " DELETE DISCLOSURE_DETAIL " +
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

        public int save(DisclosureDetail entity)
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
        public void Dispose()
        {
            throw new NotImplementedException();
        }
    }
}