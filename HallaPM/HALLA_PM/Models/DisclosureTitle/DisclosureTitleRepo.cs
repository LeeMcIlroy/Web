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
    /// 조직관리 > 부문
    /// </summary>
    public class DisclosureTitleRepo : DbCon, IDisclosureTitleRepo
    {
        public int count(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " SELECT COUNT(*) FROM DISCLOSURE_TITLE ";
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
                    string query = " SELECT COUNT(*) FROM DISCLOSURE_TITLE " + where;
                    return con.Query<int>(query, param).First();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return -1;
                }
            }
        }

        public IEnumerable<DisclosureTitle> selectList(object param)
        {
            //Search search = (Search)param;
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string where = " WHERE 1 = 1 ";

                    string query = "SELECT	  DCI.SEQ   AS DIS_ITEM_SEQ " +
                            "        , 0 AS DETAIL_SEQ " +
                            "        , 0 AS SEQ " +
                            "        , DCI.DIS_NAME " +
                            "        , NULL  AS DETAIL_NAME " +
                            "        , NULL  AS TITLE " +
                            "        , NULL  AS DIS_CODE " +
                            "        , DCI.IS_USE " +
                            "FROM     DISCLOSURE_ITEM DCI " +
                            "UNION " +
                            "SELECT   DCI.SEQ   AS DIS_ITEM_SEQ " +
                            "        ,DCD.SEQ   AS DETAIL_SEQ " +
                            "        ,0         AS SEQ " +
                            "        ,DCI.DIS_NAME  " +
                            "        ,DCD.DETAIL_NAME " +
                            "        ,NULL      AS TITLE " +
                            "        ,NULL      AS DIS_CODE " +
                            "        ,DCD.IS_USE " +
                            "FROM    DISCLOSURE_DETAIL DCD " +
                            "LEFT OUTER JOIN DISCLOSURE_ITEM DCI ON DCD.DIS_ITEM_SEQ = DCI.SEQ " +
                            "UNION " +
                            "SELECT   DCI.SEQ   AS DIS_ITEM_SEQ " +
                            ",DCD.SEQ   AS DETAIL_SEQ " +
                            ",DCT.SEQ   AS SEQ " +
                            ",DCI.DIS_NAME  "+
                            ",DCD.DETAIL_NAME " +
                            ",DCT.TITLE " +
                            ",DCT.DIS_CODE " +
                            ",DCT.IS_USE " +
                            "FROM    DISCLOSURE_TITLE DCT " +
                            "LEFT OUTER JOIN DISCLOSURE_DETAIL DCD ON DCT.DETAIL_SEQ = DCD.SEQ " +
                            "LEFT OUTER JOIN DISCLOSURE_ITEM DCI ON DCD.DIS_ITEM_SEQ = DCI.SEQ " + where;
                    //search.TotalCount = count(search);
                    //search.MakePaging();

                    return con.Query<DisclosureTitle>(query, param).ToList();

                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
          
            }

        }
        public IEnumerable<DisclosureTitle> selectExcelList(object param)
        {
            //Search search = (Search)param;
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    

                    string query = "SELECT A.SEQ  AS DIS_ITEM_SEQ "+
                                    "   , A.DIS_NAME "+
                                    "   , B.SEQ AS DETAIL_SEQ "+
                                    "   , B.DETAIL_NAME "+
                                    "   , C.TITLE "+
                                    "   , C.DIS_CODE "+
                                    " FROM DISCLOSURE_ITEM A " +
                                    "    INNER JOIN DISCLOSURE_DETAIL B "+
                                    "    ON A.SEQ = B.DIS_ITEM_SEQ " +
                                    " INNER JOIN DISCLOSURE_TITLE C "+
                                    " ON B.SEQ = C.DETAIL_SEQ ";

                    //search.TotalCount = count(search);
                    //search.MakePaging();

                    return con.Query<DisclosureTitle>(query, param).ToList();

                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }

            }

        }
        public IEnumerable<DisclosureTitleExp> selectListExp(object param)
        {
            //Search search = (Search)param;
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = "";
                    query += " SELECT * ";
                    query += " FROM  DISCLOSURE_TITLE ";
                    query += " WHERE IS_USE = 'Y' ";
                    query += " ORDER BY SEQ ASC ";
                    return con.Query<DisclosureTitleExp>(query, param).ToList();

                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public DisclosureTitle selectOne(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = " SELECT * FROM DISCLOSURE_TITLE WHERE SEQ = @Seq ";

                    return con.Query<DisclosureTitle>(query, param).FirstOrDefault();
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

                    string query = " SELECT COUNT(*) FROM DISCLOSURE_TITLE WHERE TITLE = @Title ";

                    return con.Query<int>(query, param).First();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return -1;
                }
            }
        }
        public IEnumerable<DisclosureTitle> selectListUnion(object param)
        {
            //Search search = (Search)param;
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string where = " WHERE 1 = 1 ";
                    where += " AND DCI.SEQ = @Seq ";
                    string query = " SELECT	DCI.SEQ AS DIS_ITEM_SEQ " +
                        " , DCD.SEQ AS DETAIL_SEQ " +
                        " , DCT.SEQ " +
                        " , DCI.DIS_NAME " +
                        " , DCD.DETAIL_NAME " +
                        " , DCT.TITLE " +

                        " , ISNULL(DCT.IS_USE , ISNULL(DCD.IS_USE,  DCI.IS_USE )) IS_USE " +
                        " FROM    DISCLOSURE_ITEM DCI " +
                        " INNER JOIN DISCLOSURE_DETAIL     DCD ON DCI.SEQ = DCD.DIS_ITEM_SEQ " +
                        " INNER JOIN DISCLOSURE_TITLE    DCT ON DCD.SEQ = DCT.DETAIL_SEQ " + where;

                    return con.Query<DisclosureTitle>(query, param).ToList();

                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }
        public IEnumerable<DisclosureTitle> selectListDetail(object param)
        {
            //Search search = (Search)param;
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string where =  " WHERE 1 = 1 ";
                           where += " AND DCD.SEQ = @Seq ";
                    string query = " SELECT	DCT.* " +
                        " FROM    DISCLOSURE_DETAIL     DCD  " +
                        " INNER JOIN DISCLOSURE_TITLE    DCT ON DCD.SEQ = DCT.DETAIL_SEQ AND DCT.IS_USE = 'Y' " + where;

                    return con.Query<DisclosureTitle>(query, param).ToList();

                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }
        public int insert(DisclosureTitle entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query =
                        " DECLARE  @P_RTN_KEY NVARCHAR(0030) = ''  " +

                        " SELECT  @P_RTN_KEY = @Initial + RIGHT('0000' + CONVERT(VARCHAR, CONVERT(INT, RIGHT(ISNULL(MAX(A.DIS_CODE), 0), 4)) + 1), 4) " +
                        " FROM    DISCLOSURE_TITLE A " +
                        " WHERE   A.DIS_CODE BETWEEN @Initial + '0000' AND @Initial +'9999' " +

                        " INSERT INTO DISCLOSURE_TITLE ( " +
                        "   DETAIL_SEQ " +
                        " , TITLE " +
                        " , DIS_CODE " +
                        " , IS_USE " +
                        " , USER_KEY " +
                        " , EMP_NO " +
                        " , CREATE_DATE " +
                        " ) VALUES ( " +
                        "   @DetailSeq " +
                        " , @Title " +
                        " , @P_RTN_KEY " +
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

        public int update(DisclosureTitle entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = " UPDATE DISCLOSURE_TITLE SET " +
                        "   TITLE = @Title" +
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

                    string query = " DELETE DISCLOSURE_TITLE " +
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

        public int save(DisclosureTitle entity)
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