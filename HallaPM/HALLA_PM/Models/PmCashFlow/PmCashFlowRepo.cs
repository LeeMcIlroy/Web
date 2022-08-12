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
    public class PmCashFlowRepo : DbCon, IPmCashFlowRepo
    {
        public int count(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " SELECT COUNT(*) FROM PM_CASH_FLOW ";
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
SELECT COUNT(*) FROM	PM_CASH_FLOW			A
INNER JOIN PLAN_SCHEDULE B ON A.CASH_FLOW_YEAR = B.SCHEDULE_YEAR 
INNER JOIN ORG_COMPANY C ON A.ORG_COMPANY_SEQ = C.SEQ 
INNER JOIN ADMIN_ORG_AUTH D ON A.ORG_COMPANY_SEQ = D.ORG_COMPANY_SEQ 
INNER JOIN ADMIN_AUTH F ON D.AUTH_USER_KEY = F.AUTH_USER_KEY 
INNER JOIN ORG_UNION		G ON C.ORG_UNION_SEQ = G.SEQ
INNER JOIN PLAN_SCHEDULE_PERFORMANCE_REG H ON A.CASH_FLOW_YEAR = H.SCHEDULE_YEAR  AND A.MONTHLY = H.REG_MONTH
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

        public IEnumerable<PmCashFlow> selectList(object param)
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
                        where += " AND A.CASH_FLOW_YEAR = @searchYear ";
                    }

                    if (!string.IsNullOrEmpty(search.searchMonth))
                    {
                        where += " AND A.MONTHLY = @searchMonth ";
                    }

                    //string query = @"
                    //                SELECT	ROW_NUMBER() OVER (ORDER BY CASH_FLOW_YEAR ASC) AS ROW_NUM, A.*, C.COMPANY_NAME, G.UNION_NAME 
	                   //                 , CASE WHEN(H.REG_DT_START <= CONVERT(VARCHAR(10), GETDATE(), 121) AND H.REG_DT_END >= CONVERT(VARCHAR(10), GETDATE(), 121)) THEN 'Y' ELSE 'N' END AS WRITE_ABLE 
                    //                FROM	PM_CASH_FLOW			A
                    //                INNER JOIN PLAN_SCHEDULE B ON A.CASH_FLOW_YEAR = B.SCHEDULE_YEAR 
                    //                INNER JOIN ORG_COMPANY C ON A.ORG_COMPANY_SEQ = C.SEQ 
                    //                INNER JOIN ADMIN_ORG_AUTH D ON A.ORG_COMPANY_SEQ = D.ORG_COMPANY_SEQ 
                    //                INNER JOIN ADMIN_AUTH F ON D.AUTH_USER_KEY = F.AUTH_USER_KEY 
                    //                INNER JOIN ORG_UNION		G ON C.ORG_UNION_SEQ = G.SEQ
                    //                INNER JOIN PLAN_SCHEDULE_PERFORMANCE_REG H ON A.CASH_FLOW_YEAR = H.SCHEDULE_YEAR  AND A.MONTHLY = H.REG_MONTH
                    //                " + where + @"
                    //                ORDER BY A.CASH_FLOW_YEAR DESC, A.MONTHLY DESC 
                    //                OFFSET @PageCount * (@PageIndex -1)  ROWS FETCH NEXT @PageCount ROW ONLY ;
                    //                ";

                    string query = @"
                                    SELECT	ROW_NUMBER() OVER (ORDER BY CASH_FLOW_YEAR ASC) AS ROW_NUM, A.*, C.COMPANY_NAME, G.UNION_NAME 
	                                    , CASE WHEN(H.REG_DT_START <= CONVERT(VARCHAR(10), GETDATE(), 121) AND H.REG_DT_END >= CONVERT(VARCHAR(10), GETDATE(), 121)) THEN 'Y' ELSE 'N' END AS WRITE_ABLE 
                                    FROM	PM_CASH_FLOW			A
                                    INNER JOIN PLAN_SCHEDULE B ON A.CASH_FLOW_YEAR = B.SCHEDULE_YEAR 
                                    INNER JOIN ORG_COMPANY C ON A.ORG_COMPANY_SEQ = C.SEQ AND A.CASH_FLOW_YEAR + A.MONTHLY >= ISNULL(C.USE_YEAR,'') + ISNULL(C.USE_MONTH,'')
                                    INNER JOIN ADMIN_ORG_AUTH D ON A.ORG_COMPANY_SEQ = D.ORG_COMPANY_SEQ 
                                    INNER JOIN ADMIN_AUTH F ON D.AUTH_USER_KEY = F.AUTH_USER_KEY 
                                    INNER JOIN ORG_UNION		G ON C.ORG_UNION_SEQ = G.SEQ
                                    INNER JOIN PLAN_SCHEDULE_PERFORMANCE_REG H ON A.CASH_FLOW_YEAR = H.SCHEDULE_YEAR  AND A.MONTHLY = H.REG_MONTH
                                    " + where + @"
                                    ORDER BY A.CASH_FLOW_YEAR DESC, A.MONTHLY DESC 
                                    OFFSET @PageCount * (@PageIndex -1)  ROWS FETCH NEXT @PageCount ROW ONLY ;
                                    ";


                    search.TotalCount = count(search, where);
                    search.MakePaging();

                    return con.Query<PmCashFlow>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public PmCashFlow selectOne(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = " SELECT * " +
                        " FROM PM_CASH_FLOW " +
                        " WHERE SEQ = @Seq ";

                    return con.Query<PmCashFlow>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public PmCashFlow selectOneCompany(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = " SELECT * " +
                        " FROM PM_CASH_FLOW " +
                        " WHERE CASH_FLOW_YEAR = @CashFlowYear " +
                        " AND MONTHLY = @Monthly " +
                        " AND ORG_COMPANY_SEQ = @OrgCompanySeq ";

                    return con.Query<PmCashFlow>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public int insert(PmCashFlow entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " INSERT INTO  PM_CASH_FLOW ( " +
                        "CASH_FLOW_YEAR " +
                        ", MONTHLY " +
                        ", ORG_COMPANY_SEQ " +
                        ", REGIST_STATUS " +
                        ", USER_KEY " +
                        ", EMP_NO " +
                        ", CREATE_DATE " +
                        " ) VALUES ( " +
                        "@CashFlowYear " +
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

        public int update(PmCashFlow entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " UPDATE PM_CASH_FLOW SET " +
                        " CASH_FLOW_YEAR = @CashFlowYear" +
                        " , MONTHLY = @Monthly" +
                        " , ORG_COMPANY_SEQ = @OrgCompanySeq" +
                        " , REGIST_STATUS = @RegistStatus" +
                        " , USER_KEY = @UserKey" +
                        " , EMP_NO = @EmpNo" +
                        " , CREATE_DATE = GETDATE() " +
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

        public int updateRegist(PmCashFlow entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = "UPDATE PM_CASH_FLOW SET " +
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

        public int updateComment(PmCashFlow entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " UPDATE PM_CASH_FLOW SET " +
                        // 이부분은 수정하여 사용하세요. 
                        //" , SEQ = @Seq" +
                        //" , CASH_FLOW_YEAR = @CashFlowYear" +
                        //" , MONTHLY = @Monthly" +
                        //" , ORG_COMPANY_SEQ = @OrgCompanySeq" +
                        //" , REGIST_STATUS = @RegistStatus" +
                        //" , USER_KEY = @UserKey" +
                        //" , EMP_NO = @EmpNo" +
                        //" , CREATE_DATE = @CreateDate" +
                        " SALES_COMMENT = @SalesComment" +
                        " , INVESTMENT_COMMENT = @InvestmentComment" +
                        " , FINANCIAL_COMMENT = @FinancialComment" +
                        " , FCF_COMMENT = @FcfComment" +
                        " , BE_CASH_COMMENT = @BeCashComment" +
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

        public int delete(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " DELETE PM_CASH_FLOW " +
                        " WHERE SEQ = @Seq" +
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

        public int deleteOrg(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " DELETE PM_CASH_FLOW " +
                        " WHERE 1 = 1 AND CASH_FLOW_YEAR + MONTHLY >= @Year + @Month AND ORG_COMPANY_SEQ = @OrgCompanySeq " +
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

        public int save(PmCashFlow entity)
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



        public PmCashFlowCumulativeSummary selectOnePrevCashFlowSummary(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = "";
                    query += " SELECT A.CASH_FLOW_YEAR, SUM(B.ENDING_CASH) AS ENDING_CASH, SUM(B.AVAILABLE_CASH) AS AVAILABLE_CASH ";
                    query += "     , SUM(B.FCF2) AS FCF2, SUM(B.EBITDA) AS EBITDA, SUM(B.WC_SUM) AS WC_SUM, SUM(B.ETC) AS ETC ";
                    query += "     , SUM(B.FINANCIAL_COST) AS FINANCIAL_COST, SUM(B.NET_CAPEX_SUM) AS NET_CAPEX_SUM ";
                    query += " FROM PM_CASH_FLOW A ";
                    query += "     , PM_CASH_FLOW_CUMULATIVE B ";
                    query += " WHERE A.SEQ = B.PM_CASH_FLOW_SEQ ";
                    query += "     AND A.CASH_FLOW_YEAR = @year ";
                    query += "     AND A.MONTHLY = '12' ";
                    query += "     AND A.ORG_COMPANY_SEQ = @orgCompanySeq ";
                    query += "     AND B.DIFF = " + Define.DIFF.GetKey("실적");
                    query += " GROUP BY A.CASH_FLOW_YEAR ";

                    return con.Query<PmCashFlowCumulativeSummary>(query, param).FirstOrDefault();
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