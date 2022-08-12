using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Data;
using Dapper;
using HALLA_PM.Util;

namespace HALLA_PM.Models
{
    public class PlanYearBsExRepo : DbCon, IPlanYearBsExRepo
    {
        public int count(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " SELECT COUNT(*) FROM PLAN_YEAR_BS_EX ";
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
                    string query = " SELECT COUNT(*) FROM PLAN_YEAR_BS_EX A " +
                        " INNER JOIN PLAN_SCHEDULE B ON A.YEAR_BS_YEAR = B.SCHEDULE_YEAR " +
                        " INNER JOIN ORG_COMPANY C ON A.ORG_COMPANY_SEQ = C.SEQ " +
                        " INNER JOIN ADMIN_ORG_AUTH D ON A.ORG_COMPANY_SEQ = D.ORG_COMPANY_SEQ " +
                        " INNER JOIN ADMIN_AUTH F ON D.AUTH_USER_KEY = F.AUTH_USER_KEY " +
                        " INNER JOIN ORG_UNION		G ON C.ORG_UNION_SEQ = G.SEQ" + where;
                    return con.Query<int>(query, param).First();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return -1;
                }
            }
        }

        public int delete(object key)
        {
            throw new NotImplementedException();
        }

        public void Dispose()
        {
            throw new NotImplementedException();
        }

        public int insert(PlanYearBsEx entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " INSERT INTO  PLAN_YEAR_BS_EX ( " +
                        "YEAR_BS_YEAR " +
                        ", ORG_COMPANY_SEQ " +
                        ", REGIST_STATUS " +
                        ", USER_KEY " +
                        ", EMP_NO " +
                        ", CREATE_DATE " +
                        " ) VALUES ( " +
                        "@YearBsYear " +
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

        public int save(PlanYearBsEx entity)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<PlanYearBsEx> selectList(object param)
        {
            Search search = (Search)param;
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string where = " WHERE 1 = 1 " +
                        " AND B.APPLY_CHK = 'Y' " +
                        " AND D.AUTH_USER_KEY = @AuthUserKey " +
                        " AND F.IS_USE = 'Y' ";

                    if (!string.IsNullOrEmpty(search.searchYear))
                    {
                        where += " AND A.YEAR_BS_YEAR = @searchYear ";
                    }
                    
                    string query = " SELECT	ROW_NUMBER() OVER (ORDER BY YEAR_BS_YEAR ASC) AS ROW_NUM, A.*, C.COMPANY_NAME, G.UNION_NAME " +
                        " , CASE WHEN(B.PLAN_DT_START <= CONVERT(VARCHAR(10), GETDATE(), 121) AND B.PLAN_DT_END >= CONVERT(VARCHAR(10), GETDATE(), 121)) THEN 'Y' ELSE 'N' END AS WRITE_ABLE " +
                        " FROM    PLAN_YEAR_BS_EX A " +
                        " INNER JOIN PLAN_SCHEDULE B ON A.YEAR_BS_YEAR = B.SCHEDULE_YEAR " +
                        " INNER JOIN ORG_COMPANY C ON A.ORG_COMPANY_SEQ = C.SEQ " +
                        " INNER JOIN ADMIN_ORG_AUTH D ON A.ORG_COMPANY_SEQ = D.ORG_COMPANY_SEQ " +
                        " INNER JOIN ADMIN_AUTH F ON D.AUTH_USER_KEY = F.AUTH_USER_KEY " +
                        " INNER JOIN ORG_UNION		G ON C.ORG_UNION_SEQ = G.SEQ" +
                        "  " + where +
                        " ORDER BY YEAR_BS_YEAR DESC " +
                        " OFFSET @PageCount * (@PageIndex -1)  ROWS FETCH NEXT @PageCount ROW ONLY ";

                    search.TotalCount = count(search, where);
                    search.MakePaging();

                    return con.Query<PlanYearBsEx>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public PlanYearBsEx selectOne(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = " SELECT * " +
                        " FROM PLAN_YEAR_BS_EX " +
                        " WHERE SEQ = @Seq ";

                    return con.Query<PlanYearBsEx>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public int update(PlanYearBsEx entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " UPDATE PLAN_YEAR_BS_EX SET " +
                        " YEAR_BS_YEAR = @YearBsYear" +
                        " , ORG_COMPANY_SEQ = @OrgCompanySeq" +
                        " , REGIST_STATUS = @RegistStatus" +
                        " , USER_KEY = @UserKey" +
                        " , EMP_NO = @EmpNo" +
                        " , CREATE_DATE = GETDATE() " +
                        " WHERE SEQ = @Seq" +
                    "); @@ROWCOUNT";
                    return con.Query<int>(query, entity).First();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return -1;
                }
            }
        }

        public PlanYearBsEx selectOneCompany(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = " SELECT * " +
                        " FROM PLAN_YEAR_BS_EX " +
                        " WHERE YEAR_BS_YEAR = @YearBsYear " +
                        " AND ORG_COMPANY_SEQ = @OrgCompanySeq ";

                    return con.Query<PlanYearBsEx>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public int updateRegist(PlanYearBsEx entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" UPDATE PLAN_YEAR_BS_EX SET 
                            REGIST_STATUS = @RegistStatus
                            ,USER_KEY = @UserKey
                            , EMP_NO = @EmpNo
                            , CREATE_DATE = GETDATE() 
                             WHERE SEQ = @Seq
                        ; SELECT @@ROWCOUNT";

                    return con.Query<int>(query, entity).First();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return -1;
                }
            }
        }
    }
}