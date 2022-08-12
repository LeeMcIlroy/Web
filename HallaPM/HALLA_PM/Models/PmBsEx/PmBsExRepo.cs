using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Data;
using Dapper;
using HALLA_PM.Util;

namespace HALLA_PM.Models
{
    public class PmBsExRepo : DbCon, IPmBsExRepo
    {
        public int count(object param)
        {
            throw new NotImplementedException();
        }

        public int count(object param, string where)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = @" 
                                SELECT COUNT(*) FROM	PM_BS_EX			A
                                INNER JOIN PLAN_SCHEDULE B ON A.BS_YEAR = B.SCHEDULE_YEAR 
                                INNER JOIN ORG_COMPANY C ON A.ORG_COMPANY_SEQ = C.SEQ 
                                INNER JOIN ADMIN_ORG_AUTH D ON A.ORG_COMPANY_SEQ = D.ORG_COMPANY_SEQ 
                                INNER JOIN ADMIN_AUTH F ON D.AUTH_USER_KEY = F.AUTH_USER_KEY 
                                INNER JOIN ORG_UNION		G ON C.ORG_UNION_SEQ = G.SEQ
                                INNER JOIN PLAN_SCHEDULE_PERFORMANCE_REG H ON A.BS_YEAR = H.SCHEDULE_YEAR  AND A.MONTHLY = H.REG_MONTH
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

        public int delete(object key)
        {
            throw new NotImplementedException();
        }

        public void Dispose()
        {
            throw new NotImplementedException();
        }

        public int insert(PmBsEx entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " INSERT INTO  PM_BS_EX ( " +
                        " BS_YEAR " +
                        ", MONTHLY " +
                        ", ORG_COMPANY_SEQ " +
                        ", REGIST_STATUS " +
                        ", USER_KEY " +
                        ", EMP_NO " +
                        ", CREATE_DATE " +
                        " ) VALUES ( " +
                        " @BsYear " +
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

        public int save(PmBsEx entity)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<PmBsEx> selectList(object param)
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
                    if (!string.IsNullOrEmpty(search.searchYear))
                    {
                        where += " AND A.BS_YEAR = @searchYear ";
                    }

                    if (!string.IsNullOrEmpty(search.searchMonth))
                    {
                        where += " AND A.MONTHLY = @searchMonth ";
                    }

                    string query = @"
                                SELECT	ROW_NUMBER() OVER (ORDER BY BS_YEAR ASC) AS ROW_NUM, A.*, C.COMPANY_NAME, G.UNION_NAME 
	                                , CASE WHEN(H.REG_DT_START <= CONVERT(VARCHAR(10), GETDATE(), 121) AND H.REG_DT_END >= CONVERT(VARCHAR(10), GETDATE(), 121)) THEN 'Y' ELSE 'N' END AS WRITE_ABLE 
                                FROM	PM_BS_EX			A
                                INNER JOIN PLAN_SCHEDULE B ON A.BS_YEAR = B.SCHEDULE_YEAR 
                                INNER JOIN ORG_COMPANY C ON A.ORG_COMPANY_SEQ = C.SEQ 
                                INNER JOIN ADMIN_ORG_AUTH D ON A.ORG_COMPANY_SEQ = D.ORG_COMPANY_SEQ 
                                INNER JOIN ADMIN_AUTH F ON D.AUTH_USER_KEY = F.AUTH_USER_KEY 
                                INNER JOIN ORG_UNION		G ON C.ORG_UNION_SEQ = G.SEQ
                                INNER JOIN PLAN_SCHEDULE_PERFORMANCE_REG H ON A.BS_YEAR = H.SCHEDULE_YEAR  AND A.MONTHLY = H.REG_MONTH
                                " + where + @"
                                ORDER BY A.BS_YEAR DESC, A.MONTHLY DESC 
                                OFFSET @PageCount * (@PageIndex -1)  ROWS FETCH NEXT @PageCount ROW ONLY ;
                                ";

                    search.TotalCount = count(search, where);
                    search.MakePaging();

                    return con.Query<PmBsEx>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public PmBsEx selectOne(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = " SELECT * " +
                        " FROM PM_BS_EX " +
                        " WHERE SEQ = @Seq ";

                    return con.Query<PmBsEx>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public int update(PmBsEx entity)
        {
            throw new NotImplementedException();
        }

        public int updateRegist(PmBsEx entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" UPDATE PM_BS_EX SET 
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

        public PmBsEx selectOneCompany(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = " SELECT * " +
                        " FROM PM_BS_EX " +
                        " WHERE BS_YEAR = @BsYear " +
                        " AND MONTHLY = @Monthly " +
                        " AND ORG_COMPANY_SEQ = @OrgCompanySeq ";

                    return con.Query<PmBsEx>(query, param).FirstOrDefault();
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