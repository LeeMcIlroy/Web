using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Data;
using Dapper;
using HALLA_PM.Util;

namespace HALLA_PM.Models
{
    public class OrgCompanyRepo : DbCon, IOrgCompanyRepo
    {
        public int count(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " SELECT COUNT(*) FROM ORG_COMPANY ";
                    return con.Query<int>(query, param).First();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return -1;
                }
            }
        }

        public IEnumerable<OrgCompany> selectList(object param)
        {
            //Search search = (Search)param;
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    //string where = " WHERE 1 = 1 AND IS_USE = 'Y' ";
                    string where = " WHERE 1 = 1 ";

                    if (param !=null)
                        where += " AND ORG_UNION_SEQ = @OrgUnionSeq";

                    string query = " SELECT ROW_NUMBER() OVER (ORDER BY ORG_UNION_SEQ ASC) AS ROW_NUM, * FROM ORG_COMPANY " + where;

                    //search.TotalCount = count(search);
                    //search.MakePaging();

                    return con.Query<OrgCompany>(query, param).ToList();

                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<OrgCompany> selectListUnion(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = " SELECT A.*, B.UNION_NAME " +
                        " FROM ORG_COMPANY A " +
                        " LEFT OUTER JOIN ORG_UNION B ON A.ORG_UNION_SEQ = B.SEQ WHERE B.SEQ = @Seq ";

                    return con.Query<OrgCompany>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        /// <summary>
        /// [관리자권한관리 > 조직권한]
        /// [일정관리 > 등록일정계획] 에서 사용
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        public IEnumerable<OrgCompany> selectListAdminAuth(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = " SELECT A.UNION_NAME, B.COMPANY_NAME, B.SEQ " +
                        " FROM ORG_UNION A " +
                        " INNER JOIN ORG_COMPANY B ON A.SEQ = B.ORG_UNION_SEQ WHERE A.IS_USE = 'Y' " +
                        " ORDER BY A.SEQ, B.SEQ ";


                    return con.Query<OrgCompany>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public OrgCompany selectOne(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = " SELECT A.*, B.UNION_NAME " +
                        " FROM ORG_COMPANY A " +
                        " LEFT OUTER JOIN ORG_UNION B ON A.ORG_UNION_SEQ = B.SEQ WHERE A.SEQ = @Seq ";

                    return con.Query<OrgCompany>(query, param).FirstOrDefault();
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

                    string query = " SELECT COUNT(*) FROM ORG_COMPANY WHERE COMPANY_NAME = @CompanyName AND ORG_UNION_SEQ = @OrgUnionSeq  ";

                    return con.Query<int>(query, param).First();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return -1;
                }
            }
        }
        public int disclosureUpdate(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = "UPDATE ORG_COMPANY SET " +
                        "   IS_DISCLOSURE = @IsDisclosure " +
                        "   WHERE SEQ = @Seq " +
                        
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

        public int disclosureUseDateUpdate(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = "UPDATE ORG_COMPANY SET " +
                        "    USE_DIS_YEAR  = @UseDisYear " +
                        "   ,USE_DIS_MONTH = @UseDisMonth " +
                        "   WHERE SEQ = @Seq " +

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
        public int insert(OrgCompany entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = " INSERT INTO ORG_COMPANY ( " +
                        " ORG_UNION_SEQ " +
                        " , COMPANY_NAME " +
                        " , IS_USE " +
                        " , IS_DISCLOSURE " +
                        " , USER_KEY " +
                        " , EMP_NO " +
                        " , CREATE_DATE " +
                        " , USE_YEAR " +
                        " , USE_MONTH " +
                        " , USE_DIS_YEAR " +
                        " , USE_DIS_MONTH " +
                        " ) VALUES ( " +
                        " @OrgUnionSeq " +
                        " , @CompanyName " +
                        " , @IsUse " +
                        " , @IsDisclosure " +
                        " , @UserKey " +
                        " , @EmpNo " +
                        " , GETDATE() " +
                        " , @UseYear " +
                        " , @UseMonth" +
                        " , @UseDisYear " +
                        " , @UseDisMonth " +
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
        public int update(OrgCompany entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = " UPDATE ORG_COMPANY SET " +
                        " ORG_UNION_SEQ = @OrgUnionSeq " +
                        " , COMPANY_NAME = @CompanyName " +
                        " , IS_USE = @IsUse" +
                        " , USER_KEY = @UserKey " +
                        " , EMP_NO = @EmpNo " +
                        " , CREATE_DATE = GETDATE() " +
                        " , USE_YEAR = @UseYear " +
                        " , USE_MONTH = @UseMonth " +
                        " WHERE SEQ = @Seq  " +
                        " SELECT @Seq ";
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

                    string query = " DELETE ORG_COMPANY " +
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

        public int save(OrgCompany entity)
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