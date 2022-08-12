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
    /// 공시관리 > 공시항목등록
    /// </summary>
    public class DisclosureItemRepo : DbCon, IDisclosureItemRepo
    {
        public int count(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " SELECT COUNT(*) FROM DISCLOSURE_ITEM ";
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
                    string query = " SELECT COUNT(*) FROM DISCLOSURE_ITEM " + where;
                    return con.Query<int>(query, param).First();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return -1;
                }
            }
        }

        public IEnumerable<DisclosureItem> selectList(object param)
        {
            //Search search = (Search)param;
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string where = " WHERE 1 = 1 AND IS_USE = 'Y' ";

                    string query = " SELECT ROW_NUMBER() OVER (ORDER BY CREATE_DATE ASC) AS ROW_NUM, * FROM DISCLOSURE_ITEM " + where;

                    //search.TotalCount = count(search, where);
                    //search.MakePaging();

                    return con.Query<DisclosureItem>(query, param).ToList();

                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }
        public IEnumerable<DisclosureItemExp> selectListExp(object param)
        {
            //Search search = (Search)param;
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = "";
                    query += " SELECT * ";
                    query += " FROM DISCLOSURE_ITEM ";
                    query += " WHERE IS_USE = 'Y' ";
                    query += " ORDER BY SEQ ASC ";
                    return con.Query<DisclosureItemExp>(query, param).ToList();

                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public DisclosureItem selectOne(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = " SELECT * FROM DISCLOSURE_ITEM WHERE SEQ = @Seq ";

                    return con.Query<DisclosureItem>(query, param).FirstOrDefault();
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

                    string query = " SELECT COUNT(*) FROM DISCLOSURE_ITEM WHERE DIS_NAME = @DisName ";

                    return con.Query<int>(query, param).First();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return -1;
                }
            }
        }

        public int insert(DisclosureItem entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = " INSERT INTO DISCLOSURE_ITEM ( " +
                        "   DIS_NAME " +
                        " , IS_USE " +
                        " , USER_KEY " +
                        " , EMP_NO " +
                        " , CREATE_DATE " +
                        " ) VALUES ( " +
                        "   @DisName " +
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

        public int update(DisclosureItem entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = " UPDATE DISCLOSURE_ITEM SET " +
                        "   DIS_NAME = @DisName" +
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

                    string query = " DELETE DISCLOSURE_ITEM " +
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

        public int save(DisclosureItem entity)
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