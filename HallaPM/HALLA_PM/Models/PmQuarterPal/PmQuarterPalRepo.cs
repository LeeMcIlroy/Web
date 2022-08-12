using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Data;
using Dapper;
using HALLA_PM.Util;

namespace HALLA_PM.Models
{
    public class PmQuarterPalRepo : DbCon, IPmQuarterPalRepo
    {
        public int count(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " SELECT COUNT(*) FROM PM_QUARTER_PAL ";
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
                    string query = @" SELECT COUNT(*) FROM PM_QUARTER_PAL A
                        INNER JOIN PLAN_SCHEDULE B ON A.QUARTER_PAL_YEAR = B.SCHEDULE_YEAR
                        INNER JOIN ORG_COMPANY C ON A.ORG_COMPANY_SEQ = C.SEQ
                        INNER JOIN ADMIN_ORG_AUTH D ON A.ORG_COMPANY_SEQ = D.ORG_COMPANY_SEQ
                        INNER JOIN ADMIN_AUTH F ON D.AUTH_USER_KEY = F.AUTH_USER_KEY
                        INNER JOIN ORG_UNION G ON C.ORG_UNION_SEQ = G.SEQ
                        INNER JOIN PLAN_SCHEDULE_PERFORMANCE_REG H ON A.QUARTER_PAL_YEAR = H.SCHEDULE_YEAR  AND A.MONTHLY = H.REG_MONTH "
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

        public IEnumerable<PmQuarterPal> selectList(object param)
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
                        where += " AND A.QUARTER_PAL_YEAR = @searchYear ";
                    }

                    if (!string.IsNullOrEmpty(search.searchMonth))
                    {
                        where += " AND A.MONTHLY = @searchMonth ";
                    }

                    string query = @" SELECT	ROW_NUMBER() OVER (ORDER BY QUARTER_PAL_YEAR ASC) AS ROW_NUM, A.*, C.COMPANY_NAME, G.UNION_NAME 
                                        , CASE WHEN(H.REG_DT_START <= CONVERT(VARCHAR(10), GETDATE(), 121) AND H.REG_DT_END >= CONVERT(VARCHAR(10), GETDATE(), 121)) THEN 'Y' ELSE 'N' END AS WRITE_ABLE 
                                        FROM    PM_QUARTER_PAL A
                                        INNER JOIN PLAN_SCHEDULE B ON A.QUARTER_PAL_YEAR = B.SCHEDULE_YEAR
                                        INNER JOIN ORG_COMPANY C ON A.ORG_COMPANY_SEQ = C.SEQ  AND A.QUARTER_PAL_YEAR + A.MONTHLY >= ISNULL(C.USE_YEAR,'') + ISNULL(C.USE_MONTH,'')

                                        INNER JOIN ADMIN_ORG_AUTH D ON A.ORG_COMPANY_SEQ = D.ORG_COMPANY_SEQ
                                        INNER JOIN ADMIN_AUTH F ON D.AUTH_USER_KEY = F.AUTH_USER_KEY
                                        INNER JOIN ORG_UNION		G ON C.ORG_UNION_SEQ = G.SEQ
                                        INNER JOIN PLAN_SCHEDULE_PERFORMANCE_REG H ON A.QUARTER_PAL_YEAR = H.SCHEDULE_YEAR  AND A.MONTHLY = H.REG_MONTH
                                        " + where + @"
                                        ORDER BY QUARTER_PAL_YEAR DESC, A.MONTHLY DESC 
                                        OFFSET @PageCount * (@PageIndex -1)  ROWS FETCH NEXT @PageCount ROW ONLY ";

                    search.TotalCount = count(search, where);
                    search.MakePaging();

                    return con.Query<PmQuarterPal>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public PmQuarterPal selectOne(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = " SELECT * " +
                        " FROM PM_QUARTER_PAL " +
                        " WHERE SEQ = @Seq ";

                    return con.Query<PmQuarterPal>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public PmQuarterPal selectOneCompany(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = " SELECT * " +
                        " FROM PM_QUARTER_PAL " +
                        " WHERE QUARTER_PAL_YEAR = @QuarterPalYear " +
                        " AND MONTHLY = @Monthly " +
                        " AND ORG_COMPANY_SEQ = @OrgCompanySeq ";

                    return con.Query<PmQuarterPal>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public int insert(PmQuarterPal entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " INSERT INTO  PM_QUARTER_PAL ( " +
                        "QUARTER_PAL_YEAR " +
                        ", MONTHLY " +
                        ", ORG_COMPANY_SEQ " +
                        ", REGIST_STATUS " +
                        ", USER_KEY " +
                        ", EMP_NO " +
                        ", CREATE_DATE " +
                        " ) VALUES ( " +
                        "@QuarterPalYear " +
                        ", @Monthly " +
                        ", @OrgCompanySeq " +
                        ", @RegistStatus " +
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

        public int update(PmQuarterPal entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " UPDATE PM_QUARTER_PAL SET " +
                        " QUARTER_PAL_YEAR = @QuarterPalYear" +
                        " , MONTHLY = @Monthly" +
                        " , ORG_COMPANY_SEQ = @OrgCompanySeq" +
                        " , REGIST_STATUS = @RegistStatus" +
                        " , USER_KEY = @UserKey" +
                        " , EMP_NO = @EmpNo" +
                        " , CREATE_DATE = GETDATE()" +
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

        public int updateRegist(PmQuarterPal entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = "UPDATE PM_QUARTER_PAL SET " +
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
            return -1;
        }

        public int deleteOrg(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " DELETE PM_QUARTER_PAL " +
                        " WHERE 1 = 1 AND QUARTER_PAL_YEAR + MONTHLY >= @Year + @Month AND ORG_COMPANY_SEQ = @OrgCompanySeq " +
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

        public int save(PmQuarterPal entity)
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