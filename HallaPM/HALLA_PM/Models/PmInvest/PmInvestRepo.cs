using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Data;
using Dapper;
using HALLA_PM.Util;

namespace HALLA_PM.Models
{
    public class PmInvestRepo : DbCon, IPmInvestRepo
    {
        public int count(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " SELECT COUNT(*) FROM PM_INVEST ";
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
SELECT COUNT(*) FROM	PM_INVEST			A
INNER JOIN PLAN_SCHEDULE B ON A.INVEST_YEAR = B.SCHEDULE_YEAR 
INNER JOIN ORG_COMPANY C ON A.ORG_COMPANY_SEQ = C.SEQ 
INNER JOIN ADMIN_ORG_AUTH D ON A.ORG_COMPANY_SEQ = D.ORG_COMPANY_SEQ 
INNER JOIN ADMIN_AUTH F ON D.AUTH_USER_KEY = F.AUTH_USER_KEY 
INNER JOIN ORG_UNION		G ON C.ORG_UNION_SEQ = G.SEQ
INNER JOIN PLAN_SCHEDULE_PERFORMANCE_REG H ON A.INVEST_YEAR = H.SCHEDULE_YEAR  AND A.MONTHLY = H.REG_MONTH
" + where;
                    return con.Query<int>(query, param).First();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return -1;
                }
            }
        }

        public IEnumerable<PmInvest> selectList(object param)
        {
            return null;
        }

        public PmInvest selectOne(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = " SELECT * " +
                        " FROM PM_INVEST " +
                        " WHERE SEQ = @Seq ";

                    return con.Query<PmInvest>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public PmInvest selectOneCompany(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = " SELECT * " +
                        " FROM PM_INVEST " +
                        " WHERE INVEST_YEAR = @InvestYear " +
                        " AND MONTHLY = @Monthly " +
                        " AND ORG_COMPANY_SEQ = @OrgCompanySeq ";

                    return con.Query<PmInvest>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public int insert(PmInvest entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " INSERT INTO  PM_INVEST ( " +
                        "INVEST_YEAR " +
                        ", MONTHLY " +
                        ", ORG_COMPANY_SEQ " +
                        ", REGIST_STATUS " +
                        ", USER_KEY " +
                        ", EMP_NO " +
                        ", CREATE_DATE " +
                        " ) VALUES ( " +
                        "@InvestYear " +
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

        public int update(PmInvest entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " UPDATE PM_INVEST SET " +
                        " INVEST_YEAR = @InvestYear" +
                        " , MONTHLY = @Monthly" +
                        " , ORG_COMPANY_SEQ = @OrgCompanySeq" +
                        " , REGIST_STATUS = @RegistStatus" +
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

        public int updateRegist(PmInvest entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " UPDATE PM_INVEST SET " +
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
                    string query = " DELETE PM_INVEST " +
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
                    string query = " DELETE PM_INVEST " +
                        " WHERE 1 = 1 AND INVEST_YEAR + MONTHLY >= @Year + @Month AND ORG_COMPANY_SEQ = @OrgCompanySeq " +
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

        public int save(PmInvest entity)
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


        public int updateRegistStatusByPmInvestSeq(object param)
        {

            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    string query = " UPDATE PM_INVEST SET " +
                           " REGIST_STATUS = @RegistStatus" +
                           " , USER_KEY = @UserKey" +
                           " , EMP_NO = @EmpNo" +
                           " , CREATE_DATE = GETDATE()" +
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

        public IEnumerable<PmInvestExp> selectListExp(object param)
        {
            Search search = (Search)param;
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string where = @"
                                    WHERE 1 = 1 
                                    AND B.APPLY_CHK = 'Y' 
                                    AND D.AUTH_USER_KEY = @AuthUserKey 
                                    AND F.IS_USE = 'Y' 
                                    AND H.REG_DT_START <= CONVERT(CHAR(10), GETDATE(), 121) -- 현재 일자보다 등록 예정일이 작은 것들만 보여준다.
                                    ";
                    if (search.searchCpySeq > 0)
                    {
                        where += " AND A.ORG_COMPANY_SEQ = @searchCpySeq ";
                    }
                    if (!string.IsNullOrEmpty(search.searchYear))
                    {
                        where += " AND A.INVEST_YEAR = @searchYear ";
                    }

                    if (!string.IsNullOrEmpty(search.searchMonth))
                    {
                        where += " AND A.MONTHLY = @searchMonth ";
                    }
                    string query = @"
                                    SELECT	ROW_NUMBER() OVER (ORDER BY INVEST_YEAR ASC) AS ROW_NUM, A.*, C.COMPANY_NAME, G.UNION_NAME 
	                                    , CASE WHEN(H.REG_DT_START <= CONVERT(VARCHAR(10), GETDATE(), 121) AND H.REG_DT_END >= CONVERT(VARCHAR(10), GETDATE(), 121)) THEN 'Y' ELSE 'N' END AS WRITE_ABLE 
                                    FROM	PM_INVEST			A
                                    INNER JOIN PLAN_SCHEDULE B ON A.INVEST_YEAR = B.SCHEDULE_YEAR 
                                    INNER JOIN ORG_COMPANY C ON A.ORG_COMPANY_SEQ = C.SEQ  AND A.INVEST_YEAR + A.MONTHLY >= ISNULL(C.USE_YEAR,'') + ISNULL(C.USE_MONTH,'')

                                    INNER JOIN ADMIN_ORG_AUTH D ON A.ORG_COMPANY_SEQ = D.ORG_COMPANY_SEQ 
                                    INNER JOIN ADMIN_AUTH F ON D.AUTH_USER_KEY = F.AUTH_USER_KEY 
                                    INNER JOIN ORG_UNION		G ON C.ORG_UNION_SEQ = G.SEQ
                                    INNER JOIN PLAN_SCHEDULE_PERFORMANCE_REG H ON A.INVEST_YEAR = H.SCHEDULE_YEAR  AND A.MONTHLY = H.REG_MONTH
                                    " + where + @"
                                    ORDER BY A.INVEST_YEAR DESC, A.MONTHLY DESC 
                                    OFFSET @PageCount * (@PageIndex -1)  ROWS FETCH NEXT @PageCount ROW ONLY ;
                                    ";

                    search.TotalCount = count(search, where);
                    search.MakePaging();

                    return con.Query<PmInvestExp>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }


    }
}