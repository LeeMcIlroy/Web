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
    public class DisclosureDraftRepo : DbCon, IDisclosureDraftRepo
    {
        public int count(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " SELECT COUNT(*) FROM DISCLOSURE_DRAFT ";
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
                    string query = @"
                                    SELECT COUNT(*)

                                          
                                    FROM   DISCLOSURE A

                                           INNER JOIN ORG_COMPANY B
                                    ON     B.SEQ = A.CPN_SEQ
                                    AND    B.IS_USE = 'Y'        
                                    AND    B.IS_DISCLOSURE = 'Y' 

                                           INNER  JOIN ORG_UNION C 
                                    ON     B.ORG_UNION_SEQ = C.SEQ 

                                           LEFT JOIN DISCLOSURE_DRAFT D
                                    ON     B.SEQ = D.CPN_SEQ
                                    AND    A.YEAR = D.YEAR
                                    AND    A.MONTH = D.MONTH

                                           INNER JOIN ADMIN_ORG_AUTH E 
                                    ON     B.SEQ = E.ORG_COMPANY_SEQ 

                                           INNER JOIN ADMIN_AUTH F 
                                    ON     E.AUTH_USER_KEY = F.AUTH_USER_KEY " + where; 
                    //string query = @" SELECT COUNT(*)



                    //                FROM(SELECT SUBSTRING(LEFT(CONVERT(VARCHAR, DATEADD(D, NUMBER, '20220101'), 112), 6), 1, 4) AS 'YEAR'
                    //                               , SUBSTRING(LEFT(CONVERT(VARCHAR, DATEADD(D, NUMBER, '20220101'), 112), 6), 5, 6) AS 'MONTH'
                    //                        FROM   MASTER..SPT_VALUES
                    //                        WHERE  TYPE = 'P'
                    //                        AND    NUMBER <= DATEDIFF(D, '20220101', GETDATE())
                    //                        GROUP BY LEFT(CONVERT(VARCHAR, DATEADD(D, NUMBER, '20220101'), 112), 6)) A

                    //                       LEFT OUTER JOIN ORG_COMPANY B
                    //                ON     1 = 1
                    //                AND B.IS_USE = 'Y'
                    //                AND B.IS_DISCLOSURE = 'Y'

                    //                       LEFT OUTER JOIN ORG_UNION C
                    //                ON     B.ORG_UNION_SEQ = C.SEQ

                    //                       LEFT OUTER JOIN DISCLOSURE_DRAFT D
                    //                ON     B.SEQ = D.CPN_SEQ
                    //                AND A.YEAR = D.YEAR
                    //                AND A.MONTH = D.MONTH


                    //                        INNER JOIN ADMIN_ORG_AUTH E
                    //                ON B.SEQ = E.ORG_COMPANY_SEQ

                    //                       INNER JOIN ADMIN_AUTH F
                    //                ON E.AUTH_USER_KEY = F.AUTH_USER_KEY " + where;
                    return con.Query<int>(query, param).First();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return -1;
                }
            }
        }

        public IEnumerable<DisclosureDraft> selectList(object param)
        {
            Search search = (Search)param;
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string where = @"
                                    WHERE 1 = 1 
                                    AND E.AUTH_USER_KEY = @AuthUserKey 
                                    AND F.IS_USE = 'Y' 
                                    AND A.REGIST_STATUS = 7

                                    ";

                    if (search.searchCpySeq > 0)
                    {
                        where += " AND B.ORG_COMPANY_SEQ = @searchCpySeq ";
                    }
                    if (!string.IsNullOrEmpty(search.searchYear))
                    {
                        where += " AND A.YEAR = @searchYear ";
                    }

                    if (!string.IsNullOrEmpty(search.searchMonth))
                    {
                        where += " AND A.MONTH = @searchMonth ";
                    }

                    search.TotalCount = this.count(search, where);
                    search.MakePaging();


                    string query = @"
                                   SELECT  A.YEAR
                                          , A.MONTH
                                          , D.SEQ 
                                          , C.SEQ   AS UNION_SEQ
                                          , C.UNION_NAME
                                          , B.SEQ   AS COMPANY_SEQ
                                          , B.COMPANY_NAME
                                          , ISNULL(D.REGIST_STATUS,1) AS REGIST_STATUS
                                          , ISNULL(A.CREATE_DATE,'')  AS CREATE_DATE
                                          , ISNULL(A.WRITE_ABLE,'Y')  AS WRITE_ABLE

                                          
                                    FROM   DISCLOSURE A

                                           INNER JOIN ORG_COMPANY B
                                    ON     B.SEQ = A.CPN_SEQ
                                    AND    B.IS_USE = 'Y'        
                                    AND    B.IS_DISCLOSURE = 'Y' 

                                           INNER  JOIN ORG_UNION C 
                                    ON     B.ORG_UNION_SEQ = C.SEQ 

                                           LEFT JOIN DISCLOSURE_DRAFT D
                                    ON     B.SEQ = D.CPN_SEQ
                                    AND    A.YEAR = D.YEAR
                                    AND    A.MONTH = D.MONTH

                                           INNER JOIN ADMIN_ORG_AUTH E 
                                    ON     B.SEQ = E.ORG_COMPANY_SEQ 

                                           INNER JOIN ADMIN_AUTH F 
                                    ON     E.AUTH_USER_KEY = F.AUTH_USER_KEY 

                                              
                                    " + where + @"

                                    ORDER BY A.YEAR DESC , A.MONTH DESC , C.UNION_NAME DESC 


                    OFFSET @PageCount *(@PageIndex - 1)  ROWS FETCH NEXT @PageCount ROW ONLY";

                    search.TotalCount = this.count(search, where);
                    search.MakePaging();
                    //" + where + @"

                    return con.Query<DisclosureDraft>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }
        

        public DisclosureDraft selectOne(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
                                            SELECT DISTINCT  A.YEAR
                                          , A.MONTH
                                          , D.SEQ
                                          , C.SEQ AS UNION_SEQ
                                          , C.UNION_NAME
                                          , B.SEQ AS COMPANY_SEQ
                                          , B.COMPANY_NAME
                                          , ISNULL(D.REGIST_STATUS, 1) AS REGIST_STATUS
                                           , ISNULL(D.CREATE_DATE, '')  AS CREATE_DATE
                                            , ISNULL(D.WRITE_ABLE, 'Y')  AS WRITE_ABLE



                                    FROM(SELECT SUBSTRING(LEFT(CONVERT(VARCHAR, DATEADD(D, NUMBER, '20220101'), 112), 6), 1, 4) AS 'YEAR'
                                                   , SUBSTRING(LEFT(CONVERT(VARCHAR, DATEADD(D, NUMBER, '20220101'), 112), 6), 5, 6) AS 'MONTH'
                                            FROM   MASTER..SPT_VALUES
                                            WHERE  TYPE = 'P'
                                            AND    NUMBER <= DATEDIFF(D, '20220101', GETDATE())
                                            GROUP BY LEFT(CONVERT(VARCHAR, DATEADD(D, NUMBER, '20220101'), 112), 6)) A

                                           LEFT OUTER JOIN ORG_COMPANY B
                                    ON     1 = 1
                                    AND B.IS_USE = 'Y'
                                    AND B.IS_DISCLOSURE = 'Y'

                                           LEFT OUTER JOIN ORG_UNION C
                                    ON     B.ORG_UNION_SEQ = C.SEQ

                                           LEFT OUTER JOIN DISCLOSURE_DRAFT D
                                    ON     B.SEQ = D.CPN_SEQ
                                    AND A.YEAR = D.YEAR
                                    AND A.MONTH = D.MONTH


                                            INNER JOIN ADMIN_ORG_AUTH E
                                    ON B.SEQ = E.ORG_COMPANY_SEQ

                                           INNER JOIN ADMIN_AUTH F
                                    ON E.AUTH_USER_KEY = F.AUTH_USER_KEY


                                    WHERE A.YEAR = @Year
                                    AND A.MONTH = @Month
                                    AND B.SEQ = @CompanySeq ";

                    return con.Query<DisclosureDraft>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }
        public DisclosureDraftExp selectOneExp(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                con.Open();
                try
                {
                    string query = "SELECT * FROM DISCLOSURE_DRAFT  WHERE SEQ = @Seq ";
                    DisclosureDraftExp info = con.Query<DisclosureDraftExp>(query, param).FirstOrDefault();

                    query = "";
                    query += " SELECT * ";
                    query += " FROM FILE_INFO ";
                    query += " WHERE ATTACH_TABLE_NAME = 'DISCLOSURE_DRAFT' ";
                    query += "     AND ATTACH_TABLE_SEQ = @Seq";

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
        public DisclosureDraft availableCheckInfo(object param)
        {

            using (IDbConnection con = GetHallaDb())
            {
                con.Open();
                try
                {
                    string query = "";
                    query += " SELECT * ";
                    query += " FROM DISCLOSURE_DRAFT ";
                    query += " WHERE YEAR = @Year ";
                    query += "     AND MONTH = @Month ";
                    query += "     AND CPN_SEQ = @CompanySeq ";
                    return con.Query<DisclosureDraft>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.Error(e.ToString());
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
       
        public int insert(DisclosureDraft entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = " INSERT INTO DISCLOSURE_DRAFT ( " +
                        "   CPN_SEQ " +
                        " , YEAR " +
                        " , MONTH " +
                        " , WRITE_ABLE " +
                        " , REGIST_STATUS " +
                        " , USER_KEY " +
                        " , EMP_NO " +
                        " , CREATE_DATE " +
                        " ) VALUES ( " +
                        "   @CompanySeq " +
                        " , @Year " +
                        " , @Month " +
                        " , 'Y' " +
                        " , 2 " +

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

        public int update(DisclosureDraft entity)
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

                    string query = " DELETE DISCLOSURE_DRAFT " +
                        "   WHERE CPN_SEQ = @CompanySeq" +
                        "   AND YEAR = @Year" +
                        "   AND MONTH = @Month" +

                    "; SELECT @@ROWCOUNT"; 
                    return con.Execute(query, param);

                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return -1;
                }
            }
        }

        public int save(DisclosureDraft entity)
        {
            var item = availableCheckInfo(entity);

            if (item == null)
            {
                return insert(entity);
            }
            else
            {
                return update(entity);
            }
        }

        public int afterDeleteFileRegist(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = "UPDATE DISCLOSURE_DRAFT SET " +
                        "   REGIST_STATUS = 1 " +
                        "   WHERE CPN_SEQ = @CompanySeq" +
                        "   AND YEAR = @Year" +
                        "   AND MONTH = @Month" +

                    "; SELECT @@ROWCOUNT";
                    return con.Query<int>(query, param).First();
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
    }
}