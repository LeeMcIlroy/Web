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
    public class PlanYearPalRepo : DbCon, IPlanYearPalRepo
    {
        public int count(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " SELECT COUNT(*) FROM PLAN_YEAR_PAL ";
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
                    string query = @" SELECT COUNT(*) 
                                      FROM PLAN_YEAR_PAL A
                                      INNER JOIN PLAN_SCHEDULE B ON A.YEAR_PAL_YEAR = B.SCHEDULE_YEAR
                                      INNER JOIN ORG_COMPANY C ON A.ORG_COMPANY_SEQ = C.SEQ
                                      INNER JOIN ADMIN_ORG_AUTH D ON A.ORG_COMPANY_SEQ = D.ORG_COMPANY_SEQ
                                      INNER JOIN ADMIN_AUTH F ON D.AUTH_USER_KEY = F.AUTH_USER_KEY 
                                      INNER JOIN ORG_UNION		G ON C.ORG_UNION_SEQ = G.SEQ" + where;

                    return con.Query<int>(query, param).First();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return -1;
                }
            }
        }

        public IEnumerable<PlanYearPal> selectList(object param)
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
                        where += " AND A.YEAR_PAL_YEAR = @searchYear ";
                    }

                    string query = " SELECT	ROW_NUMBER() OVER (ORDER BY YEAR_PAL_YEAR ASC) AS ROW_NUM, A.*, C.COMPANY_NAME, G.UNION_NAME " +
                        " , CASE WHEN(B.PLAN_DT_START <= CONVERT(VARCHAR(10), GETDATE(), 121) AND B.PLAN_DT_END >= CONVERT(VARCHAR(10), GETDATE(), 121)) THEN 'Y' ELSE 'N' END AS WRITE_ABLE " +
                        " FROM    PLAN_YEAR_PAL A " +
                        " INNER JOIN PLAN_SCHEDULE B ON A.YEAR_PAL_YEAR = B.SCHEDULE_YEAR " +
                        " INNER JOIN ORG_COMPANY C ON A.ORG_COMPANY_SEQ = C.SEQ " +
                        " INNER JOIN ADMIN_ORG_AUTH D ON A.ORG_COMPANY_SEQ = D.ORG_COMPANY_SEQ " +
                        " INNER JOIN ADMIN_AUTH F ON D.AUTH_USER_KEY = F.AUTH_USER_KEY " +
                        " INNER JOIN ORG_UNION		G ON C.ORG_UNION_SEQ = G.SEQ" +
                        "  " + where +
                        " ORDER BY YEAR_PAL_YEAR DESC " +
                        " OFFSET @PageCount * (@PageIndex -1)  ROWS FETCH NEXT @PageCount ROW ONLY ";

                    search.TotalCount = count(search, where);
                    search.MakePaging();

                    return con.Query<PlanYearPal>(query, param).ToList();

                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public PlanYearPal selectOne(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" SELECT * FROM PLAN_YEAR_PAL WHERE SEQ = @Seq ";

                    return con.Query<PlanYearPal>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public PlanYearPal selectOneCompany(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = " SELECT * " +
                        " FROM PLAN_YEAR_PAL " +
                        " WHERE YEAR_PAL_YEAR = @YearPalYear " +
                        " AND ORG_COMPANY_SEQ = @OrgCompanySeq ";

                    return con.Query<PlanYearPal>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public int insert(PlanYearPal entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " INSERT INTO  PLAN_YEAR_PAL ( " +
                        "YEAR_PAL_YEAR " +
                        ", ORG_COMPANY_SEQ " +
                        ", REGIST_STATUS " +
                        ", USER_KEY " +
                        ", EMP_NO " +
                        ", CREATE_DATE " +
                    " ) VALUES ( " +
                    "@YearPalYear " +
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

        public int update(PlanYearPal entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " UPDATE PLAN_YEAR_PAL SET " +
                        " YEAR_PAL_YEAR = @YearPalYear" +
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

        public int updateRegist(PlanYearPalAdmin entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " UPDATE PLAN_YEAR_PAL SET " +
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
                    string query = " DELETE PLAN_YEAR_PAL " +
                        " WHERE SEQ = @Seq" +
                        " ;SELECT @@ROWCOUNT";
                    return con.Query<int>(query, param).First();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return -1;
                }
            }
        }

        public int save(PlanYearPal entity)
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


        public List<PlanYearPalExp> selectListExp(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = "";
                    query += " SELECT * ";
                    query += " FROM PLAN_YEAR_PAL ";
                    query += " WHERE YEAR_PAL_YEAR = @year ";
                    query += "     AND REGIST_STATUS = " + Define.REGIST_STATUS.GetKey("최종승인");

                    List<PlanYearPalExp> result = con.Query<PlanYearPalExp>(query, param).ToList();
                    
                    foreach(var item in result)
                    {
                        query = "";
                        query += " SELECT * ";
                        query += " FROM PLAN_YEAR_PAL_BUSINESS ";
                        query += " WHERE PLAN_YEAR_PAL_SEQ = @seq ";

                        item.planYearPalBusinessList = con.Query<PlanYearPalBusiness>(query, item).ToList();
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