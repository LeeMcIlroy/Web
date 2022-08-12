using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Data;
using Dapper;
using HALLA_PM.Util;

namespace HALLA_PM.Models
{
    public class PlanMonthlyInvestRepo : DbCon, IPlanMonthlyInvestRepo
    {
        public int count(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " SELECT COUNT(*) FROM PLAN_MONTHLY_INVEST ";
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
                    string query = " SELECT COUNT(*) FROM PLAN_MONTHLY_INVEST A " +
                        " INNER JOIN PLAN_SCHEDULE B ON A.MONTHLY_INVEST_YEAR = B.SCHEDULE_YEAR " +
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
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " DELETE PLAN_MONTHLY_INVEST " +
                        " WHERE SEQ = @Seq" +
                    // 이부분은 수정하여 사용하세요. 
                    "; SELECT @@ROWCOUNT";
                    return con.Query<int>(query, key).First();
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

        public int insert(PlanMonthlyInvest entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " INSERT INTO  PLAN_MONTHLY_INVEST ( " +
                        // 이부분은 수정하여 사용하세요. 
                        //" SEQ " +
                        "MONTHLY_INVEST_YEAR " +
                        ", ORG_COMPANY_SEQ " +
                        ", REGIST_STATUS " +
                        ", USER_KEY " +
                        ", EMP_NO " +
                        ", CREATE_DATE " +
                    " ) VALUES ( " +
                    //" @Seq " +
                    "@MonthlyInvestYear " +
                    ", @OrgCompanySeq " +
                    ", @RegistStatus " +
                    ", @UserKey " +
                    ", @EmpNo " +
                    ", GETDATE() " +
                    // 이부분은 수정하여 사용하세요. 
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

        public int save(PlanMonthlyInvest entity)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<PlanMonthlyInvest> selectList(object param)
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

                    if (search.searchCpySeq > 0)
                    {
                        where += " AND A.ORG_COMPANY_SEQ = @searchCpySeq ";
                    }
                    if (!string.IsNullOrEmpty(search.searchYear))
                    {
                        where += " AND A.MONTHLY_INVEST_YEAR = @searchYear ";
                    }


                    string query = " SELECT	ROW_NUMBER() OVER (ORDER BY MONTHLY_INVEST_YEAR ASC) AS ROW_NUM, A.*, C.COMPANY_NAME, G.UNION_NAME " +
                        " , CASE WHEN(B.PLAN_DT_START <= CONVERT(VARCHAR(10), GETDATE(), 121) AND B.PLAN_DT_END >= CONVERT(VARCHAR(10), GETDATE(), 121)) THEN 'Y' ELSE 'N' END AS WRITE_ABLE " +
                        " FROM    PLAN_MONTHLY_INVEST A " +
                        " INNER JOIN PLAN_SCHEDULE B ON A.MONTHLY_INVEST_YEAR = B.SCHEDULE_YEAR " +
                        " INNER JOIN ORG_COMPANY C ON A.ORG_COMPANY_SEQ = C.SEQ " +
                        " INNER JOIN ADMIN_ORG_AUTH D ON A.ORG_COMPANY_SEQ = D.ORG_COMPANY_SEQ " +
                        " INNER JOIN ADMIN_AUTH F ON D.AUTH_USER_KEY = F.AUTH_USER_KEY " +
                        " INNER JOIN ORG_UNION		G ON C.ORG_UNION_SEQ = G.SEQ" +
                        "  " + where +
                        " ORDER BY MONTHLY_INVEST_YEAR DESC " +
                        " OFFSET @PageCount * (@PageIndex -1)  ROWS FETCH NEXT @PageCount ROW ONLY ";

                    search.TotalCount = count(search, where);
                    search.MakePaging();

                    return con.Query<PlanMonthlyInvest>(query, param).ToList();

                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public PlanMonthlyInvest selectOne(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = " SELECT * " +
                        " FROM PLAN_MONTHLY_INVEST " +
                        " WHERE SEQ = @Seq ";

                    return con.Query<PlanMonthlyInvest>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }


        public PlanMonthlyInvest selectOneCompany(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = " SELECT * " +
                        " FROM PLAN_MONTHLY_INVEST " +
                        " WHERE MONTHLY_INVEST_YEAR = @MonthlyInvestYear " +
                        " AND ORG_COMPANY_SEQ = @OrgCompanySeq ";

                    return con.Query<PlanMonthlyInvest>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }
        public int update(PlanMonthlyInvest entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " UPDATE PLAN_MONTHLY_INVEST SET " +
                        // 이부분은 수정하여 사용하세요. 
                        " MONTHLY_INVEST_YEAR = @MonthlyInvestYear" +
                        " , ORG_COMPANY_SEQ = @OrgCompanySeq" +
                        " , REGIST_STATUS = @RegistStatus" +
                        " , USER_KEY = @UserKey" +
                        " , EMP_NO = @EmpNo" +
                        " , CREATE_DATE = @CreateDate" +
                        " WHERE SEQ = @Seq" +
                    // 이부분은 수정하여 사용하세요. 
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


        public int updateRegist(PlanMonthlyInvest entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " UPDATE PLAN_MONTHLY_INVEST SET " +
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
    }
}