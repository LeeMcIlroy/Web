using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Data;
using Dapper;
using HALLA_PM.Util;

namespace HALLA_PM.Models
{
    public class PlanYearCfRepo : DbCon, IPlanYearCfRepo
    {
        public int count(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " SELECT COUNT(*) FROM PLAN_YEAR_CF ";
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
SELECT COUNT(*) FROM PLAN_YEAR_CF			A
INNER JOIN PLAN_SCHEDULE B ON A.YEAR_CF_YEAR = B.SCHEDULE_YEAR 
INNER JOIN ORG_COMPANY C ON A.ORG_COMPANY_SEQ = C.SEQ 
INNER JOIN ADMIN_ORG_AUTH D ON A.ORG_COMPANY_SEQ = D.ORG_COMPANY_SEQ 
INNER JOIN ADMIN_AUTH F ON D.AUTH_USER_KEY = F.AUTH_USER_KEY 
INNER JOIN ORG_UNION		G ON C.ORG_UNION_SEQ = G.SEQ
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

        public IEnumerable<PlanYearCf> selectList(object param)
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
";
                    if (search.searchCpySeq > 0)
                    {
                        where += " AND A.ORG_COMPANY_SEQ = @searchCpySeq ";
                    }
                    if (!string.IsNullOrEmpty(search.searchYear))
                    {
                        where += " AND A.YEAR_CF_YEAR = @searchYear ";
                    }
                    string query = @"
SELECT	ROW_NUMBER() OVER (ORDER BY YEAR_CF_YEAR ASC) AS ROW_NUM, A.*, C.COMPANY_NAME, G.UNION_NAME 
	, CASE WHEN(B.PLAN_DT_START <= CONVERT(VARCHAR(10), GETDATE(), 121) AND B.PLAN_DT_END >= CONVERT(VARCHAR(10), GETDATE(), 121)) THEN 'Y' ELSE 'N' END AS WRITE_ABLE 
FROM	PLAN_YEAR_CF			A
INNER JOIN PLAN_SCHEDULE B ON A.YEAR_CF_YEAR = B.SCHEDULE_YEAR 
INNER JOIN ORG_COMPANY C ON A.ORG_COMPANY_SEQ = C.SEQ 
INNER JOIN ADMIN_ORG_AUTH D ON A.ORG_COMPANY_SEQ = D.ORG_COMPANY_SEQ 
INNER JOIN ADMIN_AUTH F ON D.AUTH_USER_KEY = F.AUTH_USER_KEY 
INNER JOIN ORG_UNION		G ON C.ORG_UNION_SEQ = G.SEQ
" +
                        "  " + where +
@"
ORDER BY YEAR_CF_YEAR DESC 
OFFSET @PageCount *(@PageIndex - 1)  ROWS FETCH NEXT @PageCount ROW ONLY; ";

                    search.TotalCount = count(search, where);
                    search.MakePaging();

                    return con.Query<PlanYearCf>(query, param).ToList();

                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public PlanYearCf selectOne(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = " SELECT * " +
                        " FROM PLAN_YEAR_CF " +
                        " WHERE SEQ = @Seq ";

                    return con.Query<PlanYearCf>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public PlanYearCf selectOneCompany(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = " SELECT * " +
                        " FROM PLAN_YEAR_CF " +
                        " WHERE YEAR_CF_YEAR = @YearCfYear " +
                        " AND ORG_COMPANY_SEQ = @OrgCompanySeq ";

                    return con.Query<PlanYearCf>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public int insert(PlanYearCf entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " INSERT INTO  PLAN_YEAR_CF ( " +
                        "YEAR_CF_YEAR " +
                        ", ORG_COMPANY_SEQ " +
                        ", REGIST_STATUS " +
                        ", USER_KEY " +
                        ", EMP_NO " +
                        ", CREATE_DATE " +
                        " ) VALUES ( " +
                        "@YearCfYear " +
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

        public int update(PlanYearCf entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " UPDATE PLAN_YEAR_CF SET " +
                        " YEAR_CF_YEAR = @YearCfYear" +
                        " , ORG_COMPANY_SEQ = @OrgCompanySeq" +
                        " , REGIST_STATUS = @RegistStatus" +
                        " , USER_KEY = @UserKey" +
                        " , EMP_NO = @EmpNo" +
                        " , CREATE_DATE = GETDATE()" +
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

        public int updateRegist(PlanYearCf entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = "UPDATE PLAN_YEAR_CF SET " +
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

        public int save(PlanYearCf entity)
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


        public List<PlanYearCfExp> selectListExp(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = "";
                    query += " SELECT * ";
                    query += " FROM PLAN_YEAR_CF ";
                    query += " WHERE YEAR_CF_YEAR = @year ";
                    query += " ORDER BY SEQ ASC ";

                    List<PlanYearCfExp> result = con.Query<PlanYearCfExp>(query, param).ToList();
                    
                    foreach(var item in result)
                    {
                        query = "";
                        query += " SELECT * ";
                        query += " FROM PLAN_YEAR_CF_SUMMARY ";
                        query += " WHERE PLAN_YEAR_CF_SEQ = @seq ";
                        query += " AND YEARLY = 'THIS'"; // 현재년도가져오기 위해 추가(LAST는 전년대비)
                        query += " ORDER BY YEARLY_YEAR ASC ";

                        item.planYearCfSummaryList = con.Query<PlanYearCfSummary>(query, item).ToList();
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

    }

}