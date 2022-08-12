using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using HALLA_PM.Core;
using System.Data;
using Dapper;
using HALLA_PM.Util;

namespace HALLA_PM.Models
{
    public class PmPalRepo : DbCon, IPmPalRepo
    {
        public int count(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " SELECT COUNT(*) FROM PM_PAL ";
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
                    string query = @" SELECT COUNT(*) FROM PM_PAL A
                        INNER JOIN PLAN_SCHEDULE B ON A.PAL_YEAR = B.SCHEDULE_YEAR
                        INNER JOIN ORG_COMPANY C ON A.ORG_COMPANY_SEQ = C.SEQ
                        INNER JOIN ADMIN_ORG_AUTH D ON A.ORG_COMPANY_SEQ = D.ORG_COMPANY_SEQ
                        INNER JOIN ADMIN_AUTH F ON D.AUTH_USER_KEY = F.AUTH_USER_KEY
                        INNER JOIN ORG_UNION G ON C.ORG_UNION_SEQ = G.SEQ
                        INNER JOIN PLAN_SCHEDULE_PERFORMANCE_REG H ON A.PAL_YEAR = H.SCHEDULE_YEAR  AND A.MONTHLY = H.REG_MONTH "
                        + where;
                    return con.Query<int>(query, param).First();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return -1;
                }
            }
        }

        public int countTemp(object param, string where)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = @" SELECT COUNT(*) FROM PM_PAL A
                        INNER JOIN PLAN_SCHEDULE B ON A.PAL_YEAR = B.SCHEDULE_YEAR
                        INNER JOIN ORG_COMPANY C ON A.ORG_COMPANY_SEQ = C.SEQ
                        --INNER JOIN ADMIN_ORG_AUTH D ON A.ORG_COMPANY_SEQ = D.ORG_COMPANY_SEQ
                        --INNER JOIN ADMIN_AUTH F ON D.AUTH_USER_KEY = F.AUTH_USER_KEY
                        INNER JOIN ORG_UNION G ON C.ORG_UNION_SEQ = G.SEQ
                        INNER JOIN PLAN_SCHEDULE_PERFORMANCE_REG H ON A.PAL_YEAR = H.SCHEDULE_YEAR  AND A.MONTHLY = H.REG_MONTH "
                        + where;
                    return con.Query<int>(query, param).First();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return -1;
                }
            }
        }

        public IEnumerable<PmPal> selectList(object param)
        {
            Search search = (Search)param;
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string where = @" WHERE 1 = 1 
                                        AND B.APPLY_CHK = 'Y'
                                        AND D.AUTH_USER_KEY = @AuthUserKey
                                        AND F.IS_USE = 'Y'
                                        AND H.REG_DT_START <= CONVERT(CHAR(10), GETDATE(), 121) ";
                    if (search.searchCpySeq > 0)
                    {
                        where += " AND A.ORG_COMPANY_SEQ = @searchCpySeq ";
                    }
                    if (!string.IsNullOrEmpty(search.searchYear))
                    {
                        where += " AND A.PAL_YEAR = @searchYear ";
                    }

                    if (!string.IsNullOrEmpty(search.searchMonth))
                    {
                        where += " AND A.MONTHLY = @searchMonth ";
                    }

                    string query = @" SELECT	ROW_NUMBER() OVER (ORDER BY PAL_YEAR ASC) AS ROW_NUM, A.*, C.COMPANY_NAME, G.UNION_NAME 
                                        , CASE WHEN(H.REG_DT_START <= CONVERT(VARCHAR(10), GETDATE(), 121) AND H.REG_DT_END >= CONVERT(VARCHAR(10), GETDATE(), 121)) THEN 'Y' ELSE 'N' END AS WRITE_ABLE 
                                        FROM    PM_PAL A
                                        INNER JOIN PLAN_SCHEDULE B ON A.PAL_YEAR = B.SCHEDULE_YEAR
                                        INNER JOIN ORG_COMPANY C ON A.ORG_COMPANY_SEQ = C.SEQ AND A.PAL_YEAR + A.MONTHLY >= ISNULL(C.USE_YEAR,'') + ISNULL(C.USE_MONTH,'')
                                        INNER JOIN ADMIN_ORG_AUTH D ON A.ORG_COMPANY_SEQ = D.ORG_COMPANY_SEQ
                                        INNER JOIN ADMIN_AUTH F ON D.AUTH_USER_KEY = F.AUTH_USER_KEY
                                        INNER JOIN ORG_UNION		G ON C.ORG_UNION_SEQ = G.SEQ
                                        INNER JOIN PLAN_SCHEDULE_PERFORMANCE_REG H ON A.PAL_YEAR = H.SCHEDULE_YEAR  AND A.MONTHLY = H.REG_MONTH
                                        " + where + @"
                                        ORDER BY PAL_YEAR DESC, A.MONTHLY DESC 
                                        OFFSET @PageCount * (@PageIndex -1)  ROWS FETCH NEXT @PageCount ROW ONLY ";

                    search.TotalCount = count(search, where);
                    search.MakePaging();

                    return con.Query<PmPal>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<PmPal> selectListTemp(object param)
        {
            Search search = (Search)param;
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string where = @" WHERE 1 = 1 
                                        AND B.APPLY_CHK = 'Y'
                                        --AND D.AUTH_USER_KEY = @AuthUserKey
                                        --AND F.IS_USE = 'Y'
                                        AND A.ORG_COMPANY_SEQ = 11
                                        AND H.REG_DT_START <= CONVERT(CHAR(10), GETDATE(), 121) ";

                    string query = @" SELECT	ROW_NUMBER() OVER (ORDER BY PAL_YEAR ASC) AS ROW_NUM, A.*, C.COMPANY_NAME, G.UNION_NAME 
                                        , CASE WHEN(H.REG_DT_START <= CONVERT(VARCHAR(10), GETDATE(), 121) AND H.REG_DT_END >= CONVERT(VARCHAR(10), GETDATE(), 121)) THEN 'Y' ELSE 'N' END AS WRITE_ABLE 
                                        FROM    PM_PAL A
                                        INNER JOIN PLAN_SCHEDULE B ON A.PAL_YEAR = B.SCHEDULE_YEAR
                                       INNER JOIN ORG_COMPANY C ON A.ORG_COMPANY_SEQ = C.SEQ 
                                        --INNER JOIN ADMIN_ORG_AUTH D ON A.ORG_COMPANY_SEQ = D.ORG_COMPANY_SEQ
                                        --INNER JOIN ADMIN_AUTH F ON D.AUTH_USER_KEY = F.AUTH_USER_KEY
                                        INNER JOIN ORG_UNION		G ON C.ORG_UNION_SEQ = G.SEQ
                                        INNER JOIN PLAN_SCHEDULE_PERFORMANCE_REG H ON A.PAL_YEAR = H.SCHEDULE_YEAR  AND A.MONTHLY = H.REG_MONTH
                                        " + where + @"
                                        ORDER BY PAL_YEAR DESC, A.MONTHLY DESC 
                                        OFFSET @PageCount * (@PageIndex -1)  ROWS FETCH NEXT @PageCount ROW ONLY ";

                    search.TotalCount = countTemp(search, where);
                    search.MakePaging();

                    return con.Query<PmPal>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public PmPal selectOne(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = " SELECT * " +
                        " FROM PM_PAL " +
                        " WHERE SEQ = @Seq ";

                    return con.Query<PmPal>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public PmPal selectOneCompany(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = " SELECT * " +
                        " FROM PM_PAL " +
                        " WHERE PAL_YEAR = @PalYear " +
                        " AND MONTHLY = @Monthly " +
                        " AND ORG_COMPANY_SEQ = @OrgCompanySeq ";

                    return con.Query<PmPal>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }



        public List<PmPalExp> selectListExp(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = "";
                    query += " SELECT * ";
                    query += " FROM PM_PAL ";
                    query += " WHERE PAL_YEAR = @year ";
                    query += "     AND MONTHLY = '12' ";
                    query += "     AND REGIST_STATUS = " + Define.REGIST_STATUS.GetKey("최종승인");

                    List<PmPalExp> result = con.Query<PmPalExp>(query, param).ToList();
                    foreach (var item in result)
                    {
                        query = "";
                        query += " SELECT * ";
                        query += " FROM PM_PAL_BUSINESS ";
                        query += " WHERE PM_PAL_SEQ = @seq ";
                        query += "     AND MONTHLY_TYPE = " + Define.MONTHLY_TYPE.GetKey("누계");

                        item.pmPalBusinessList = con.Query<PmPalBusiness>(query, item).ToList();
                    }
                    return result;
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }


        public int insert(PmPal entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " INSERT INTO  PM_PAL ( " +
                        "PAL_YEAR " +
                        ", MONTHLY " +
                        ", ORG_COMPANY_SEQ " +
                        ", REGIST_STATUS " +
                        ", LIABILITIES_RATE_COMMENT " +
                        ", USER_KEY " +
                        ", EMP_NO " +
                        ", CREATE_DATE " +
                        " ) VALUES ( " +
                        "@PalYear " +
                        ", @Monthly " +
                        ", @OrgCompanySeq " +
                        ", @RegistStatus " +
                        ", @LiabilitiesRateComment " +
                        ", @UserKey " +
                        ", @EmpNo " +
                        ", GETDATE() " +
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

        public int update(PmPal entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " UPDATE PM_PAL SET " +
                        " PAL_YEAR = @PalYear" +
                        " , MONTHLY = @Monthly" +
                        " , ORG_COMPANY_SEQ = @OrgCompanySeq" +
                        " , REGIST_STATUS = @RegistStatus" +
                        " , LIABILITIES_RATE_COMMENT = @LiabilitiesRateComment" +
                        " , USER_KEY = @UserKey" +
                        " , EMP_NO = @EmpNo" +
                        " , CREATE_DATE = GETDATE() " +
                        " WHERE SEQ = @Seq" +
                        "); SELECT @@ROWCOUNT";
                    return con.Query<int>(query, entity).First();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return -1;
                }
            }
        }

        public int updateRegist(PmPal entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " UPDATE PM_PAL SET " +
                        " REGIST_STATUS = @RegistStatus " +
                        " , USER_KEY = @UserKey" +
                        " , EMP_NO = @EmpNo" +
                        " , CREATE_DATE = GETDATE() " +
                        " WHERE SEQ = @Seq" +
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

        public int delete(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " DELETE PM_PAL " +
                        " WHERE SEQ = @Seq" +
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
        public int deleteOrg(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " DELETE PM_PAL " +
                        " WHERE 1 = 1 AND PAL_YEAR + MONTHLY >= @Year + @Month AND ORG_COMPANY_SEQ = @OrgCompanySeq " +
                    // 이부분은 수정하여 사용하세요. 
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

        public int save(PmPal entity)
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