using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Data;
using Dapper;
using HALLA_PM.Util;

namespace HALLA_PM.Models
{
    public class OrgBusinessRepo : DbCon, IOrgBusinessRepo
    {
        public int count(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " SELECT COUNT(*) FROM ORG_BUSINESS ";
                    return con.Query<int>(query, param).First();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return -1;
                }
            }
        }
        public IEnumerable<OrgBusiness> selectList(object param)
        {
            Search search = (Search)param;
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string where = " WHERE 1 = 1 ";
                    /*
                    string query = " SELECT	OU.SEQ AS ORG_UNION_SEQ " +
                        " , OC.SEQ AS ORG_COMPANY_SEQ " +
                        " , OB.SEQ " +
                        " , OU.UNION_NAME " +
                        " , OC.COMPANY_NAME " +
                        " , OB.BUSINESS_NAME " +
                        //" , OU.IS_USE " +
                        //" , OC.IS_USE " +
                        //" , OB.IS_USE " +
                        " , ISNULL(OB.IS_USE , ISNULL(OC.IS_USE,  OU.IS_USE )) IS_USE " +
                        " FROM    ORG_UNION OU " +
                        " LEFT OUTER JOIN ORG_COMPANY     OC ON OU.SEQ = OC.ORG_UNION_SEQ " +
                        " LEFT OUTER JOIN ORG_BUSINESS    OB ON OC.SEQ = OB.ORG_COMPANY_SEQ " + where;
                    */
                    //string query = "SELECT	OU.SEQ AS ORG_UNION_SEQ " +
                    //    "        , 0 AS ORG_COMPANY_SEQ " +
                    //    "        , 0 AS SEQ " +
                    //    "        , OU.UNION_NAME " +
                    //    "        , NULL AS COMPANY_NAME " +
                    //    "        , NULL AS BUSINESS_NAME " +
                    //    "        , OU.IS_USE " +
                    //    "FROM    ORG_UNION OU " +
                    //    "UNION " +
                    //    "SELECT  OU.SEQ AS ORG_UNION_SEQ " +
                    //    "        , OC.SEQ AS ORG_COMPANY_SEQ " +
                    //    "        , 0 AS SEQ " +
                    //    "        , OU.UNION_NAME " +
                    //    ", OC.COMPANY_NAME " +
                    //    "        , NULL AS BUSINESS_NAME " +
                    //    "        , OC.IS_USE " +
                    //    "FROM    ORG_COMPANY OC " +
                    //    "LEFT OUTER JOIN ORG_UNION OU ON OC.ORG_UNION_SEQ = OU.SEQ " +
                    //    "UNION " +
                    //    "SELECT  OU.SEQ AS ORG_UNION_SEQ " +
                    //    "        , OC.SEQ AS ORG_COMPANY_SEQ " +
                    //    ", OB.SEQ AS SEQ " +
                    //    ", OU.UNION_NAME " +
                    //    ", OC.COMPANY_NAME " +
                    //    ", OB.BUSINESS_NAME " +
                    //    ", OB.IS_USE " +
                    //    "FROM    ORG_BUSINESS OB " +
                    //    "LEFT OUTER JOIN ORG_COMPANY OC ON OB.ORG_COMPANY_SEQ = OC.SEQ " +
                    //    "LEFT OUTER JOIN ORG_UNION OU ON OC.ORG_UNION_SEQ = OU.SEQ " + where;
                    string query = "SELECT	OU.SEQ AS ORG_UNION_SEQ " +
                         "        , 0 AS ORG_COMPANY_SEQ " +
                         "        , 0 AS SEQ " +
                         "        , OU.UNION_NAME " +
                         "        , NULL AS COMPANY_NAME " +
                         "        , NULL AS BUSINESS_NAME " +
                         "        , OU.IS_USE " +
                         "        , 'N' AS IS_DISCLOSURE " +
                         "FROM    ORG_UNION OU " +
                         "UNION " +
                         "SELECT  OU.SEQ AS ORG_UNION_SEQ " +
                         "        , OC.SEQ AS ORG_COMPANY_SEQ " +
                         "        , 0 AS SEQ " +
                         "        , OU.UNION_NAME " +
                         "        , OC.COMPANY_NAME " +
                         "        , NULL AS BUSINESS_NAME " +
                         "        , OC.IS_USE " +
                         "        , OC.IS_DISCLOSURE " +
                         "FROM    ORG_COMPANY OC " +
                         "LEFT OUTER JOIN ORG_UNION OU ON OC.ORG_UNION_SEQ = OU.SEQ " +
                         "UNION " +
                         "SELECT  OU.SEQ AS ORG_UNION_SEQ " +
                         "        , OC.SEQ AS ORG_COMPANY_SEQ " +
                         "        , OB.SEQ AS SEQ " +
                         "        , OU.UNION_NAME " +
                         "        , OC.COMPANY_NAME " +
                         "        , OB.BUSINESS_NAME " +
                         "        , OB.IS_USE " +
                         "        , 'N' AS IS_DISCLOSURE " +                  
                         "FROM    ORG_BUSINESS OB " +
                         "LEFT OUTER JOIN ORG_COMPANY OC ON OB.ORG_COMPANY_SEQ = OC.SEQ " +
                         "LEFT OUTER JOIN ORG_UNION OU ON OC.ORG_UNION_SEQ = OU.SEQ " + where;
                    //search.TotalCount = count(search);
                    //search.MakePaging();

                    return con.Query<OrgBusiness>(query, param).ToList();

                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<OrgBusiness> selectListUnion(object param)
        {
            //Search search = (Search)param;
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string where = " WHERE 1 = 1 ";
                    where += " AND OU.SEQ = @Seq ";
                    string query = " SELECT	OU.SEQ AS ORG_UNION_SEQ " +
                        " , OC.SEQ AS ORG_COMPANY_SEQ " +
                        " , OB.SEQ " +
                        " , OU.UNION_NAME " +
                        " , OC.COMPANY_NAME " +
                        " , OB.BUSINESS_NAME " +
                        //" , OU.IS_USE " +
                        //" , OC.IS_USE " +
                        //" , OB.IS_USE " +
                        " , ISNULL(OB.IS_USE , ISNULL(OC.IS_USE,  OU.IS_USE )) IS_USE " +
                        " FROM    ORG_UNION OU " +
                        " LEFT OUTER JOIN ORG_COMPANY     OC ON OU.SEQ = OC.ORG_UNION_SEQ " +
                        " LEFT OUTER JOIN ORG_BUSINESS    OB ON OC.SEQ = OB.ORG_COMPANY_SEQ " + where;

                    return con.Query<OrgBusiness>(query, param).ToList();

                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<OrgBusiness> selectListCompany(object param)
        {
            //Search search = (Search)param;
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string where = " WHERE 1 = 1 ";
                    where += " AND OC.SEQ = @Seq ";
                    string query = " SELECT	OB.* " +
                        " FROM    ORG_COMPANY     OC  " +
                        " LEFT OUTER JOIN ORG_BUSINESS    OB ON OC.SEQ = OB.ORG_COMPANY_SEQ AND OB.IS_USE = 'Y' " + where;

                    return con.Query<OrgBusiness>(query, param).ToList();

                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<OrgBusiness> selectListAll(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"

SELECT	*
FROM	ORG_BUSINESS
WHERE	1 = 1
AND		ORG_COMPANY_SEQ = @OrgCompanySeq
";

                    return con.Query<OrgBusiness>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public OrgBusiness selectOne(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = " SELECT C.*, A.COMPANY_NAME, B.UNION_NAME, B.SEQ AS ORG_UNION_SEQ  FROM ORG_BUSINESS C " +
                        " LEFT OUTER JOIN ORG_COMPANY A ON C.ORG_COMPANY_SEQ = A.SEQ" +
                        " LEFT OUTER JOIN ORG_UNION B ON A.ORG_UNION_SEQ = B.SEQ WHERE C.SEQ = @Seq ";

                    return con.Query<OrgBusiness>(query, param).FirstOrDefault();
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

                    string query = " SELECT COUNT(*) FROM ORG_BUSINESS WHERE BUSINESS_NAME = @BusinessName AND ORG_COMPANY_SEQ = @OrgCompanySeq ";

                    return con.Query<int>(query, param).First();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return -1;
                }
            }
        }

        public int insert(OrgBusiness entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = " INSERT INTO ORG_BUSINESS ( " +
                        " ORG_COMPANY_SEQ " +
                        " , BUSINESS_NAME " +
                        " , IS_USE " +
                        " , USER_KEY " +
                        " , EMP_NO " +
                        " , CREATE_DATE " +
                        " ) VALUES ( " +
                        " @OrgCompanySeq " +
                        " , @BusinessName " +
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

        public int update(OrgBusiness entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = " UPDATE ORG_BUSINESS SET " +
                        " BUSINESS_NAME = @BusinessName" +
                        " , IS_USE = @IsUse" +
                        " , USER_KEY = @UserKey " +
                        " , EMP_NO = @EmpNo " +
                        " , CREATE_DATE = GETDATE() " +
                        " WHERE SEQ = @Seq  " +
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

                    string query = " DELETE ORG_BUSINESS " +
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

        public int save(OrgBusiness entity)
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