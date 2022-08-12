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
    public class DisclosureRepo : DbCon, IDisclosureRepo
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
                    string query = @" SELECT COUNT(*)



                                    FROM(SELECT SUBSTRING(LEFT(CONVERT(VARCHAR, DATEADD(D, NUMBER, '20220101'), 112), 6), 1, 4) AS 'YEAR'
                                                   , SUBSTRING(LEFT(CONVERT(VARCHAR, DATEADD(D, NUMBER, '20220101'), 112), 6), 5, 6) AS 'MONTH'
                                            FROM   MASTER..SPT_VALUES
                                            WHERE  TYPE = 'P'
                                            AND    NUMBER <= DATEDIFF(D, '20220101', GETDATE())
                                            GROUP BY LEFT(CONVERT(VARCHAR, DATEADD(D, NUMBER, '20220101'), 112), 6)) A

                                           LEFT OUTER JOIN ORG_COMPANY B
                                    ON     1 = 1
                                    AND    B.IS_USE = 'Y'
                                    AND    B.IS_DISCLOSURE = 'Y'
                                    AND    B.USE_DIS_MONTH <= A.MONTH
                                    AND    B.USE_DIS_YEAR <= A.YEAR

                                           LEFT OUTER JOIN ORG_UNION C
                                    ON     B.ORG_UNION_SEQ = C.SEQ

                                           LEFT OUTER JOIN DISCLOSURE D
                                    ON     B.SEQ = D.CPN_SEQ
                                    AND    A.YEAR = D.YEAR
                                    AND    A.MONTH = D.MONTH


                                           INNER JOIN ADMIN_ORG_AUTH E
                                    ON     B.SEQ = E.ORG_COMPANY_SEQ

                                           INNER JOIN ADMIN_AUTH F
                                    ON     E.AUTH_USER_KEY = F.AUTH_USER_KEY " + where;
                    return con.Query<int>(query, param).First();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return -1;
                }
            }
        }
        public int verifyDisclosure(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = @" SELECT  COUNT(*)
                                      ,MAX(DIS_CODE) AS DIS_CODE

                                      FROM    DISCLOSURE_ITEM A
                                              INNER JOIN DISCLOSURE_DETAIL B
                                      ON      B.DIS_ITEM_SEQ = A.SEQ
                                            INNER JOIN DISCLOSURE_TITLE C
                                      ON    C.DETAIL_SEQ = B.SEQ
                                      WHERE A.DIS_NAME = @DisName
                                      AND   B.DETAIL_NAME = @DetailName
                                      AND   C.TITLE = @Title

                                     ";
                    return con.Query<int>(query, param).First();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return -1;
                }
            }
        }
        public string selectDisCode(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {

                try
                {
                    con.Open();

                    string query = @" SELECT  DIS_CODE

                                      FROM    DISCLOSURE_ITEM A
                                              INNER JOIN DISCLOSURE_DETAIL B
                                      ON      B.DIS_ITEM_SEQ = A.SEQ
                                            INNER JOIN DISCLOSURE_TITLE C
                                      ON    C.DETAIL_SEQ = B.SEQ
                                      WHERE A.DIS_NAME = @DisName
                                      AND   B.DETAIL_NAME = @DetailName
                                      AND   C.TITLE = @Title

                                     ";


                    return con.Query<string>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }
        public IEnumerable<Disclosure> selectList(object param)
        {
            Search search = (Search)param;
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    //string where = @"
                    //                WHERE 1 = 1 
                    //                AND E.AUTH_USER_KEY = @AuthUserKey 
                    //                AND F.IS_USE = 'Y' 
                    //                ";

                    string where = @"
                                    WHERE 1 = 1 
                                    AND E.AUTH_USER_KEY = @AuthUserKey 
                                       AND F.IS_USE = 'Y' 
                                    ";

                    if (search.searchCpySeq > 0)
                    {
                        where += " AND B.SEQ = @searchCpySeq ";
                    }
                    if (!string.IsNullOrEmpty(search.searchYear))
                    {
                        where += " AND A.YEAR = @searchYear ";
                    }

                    if (!string.IsNullOrEmpty(search.searchMonth))
                    {
                        where += " AND A.MONTH = @searchMonth ";
                    }


                    string query = @"
                                   SELECT  A.YEAR
                                          , CONVERT(nvarchar,A.MONTH) AS MONTH
                                          , C.SEQ   AS UNION_SEQ
                                          , C.UNION_NAME
                                          , B.SEQ   AS COMPANY_SEQ
                                          , B.COMPANY_NAME
                                          , ISNULL(D.REGIST_STATUS,1) AS REGIST_STATUS
                                          , ISNULL(D.CREATE_DATE,'')  AS CREATE_DATE
                                          , ISNULL(D.WRITE_ABLE,'Y')  AS WRITE_ABLE

                                          
                                    FROM   ( SELECT SUBSTRING(LEFT(CONVERT(VARCHAR, DATEADD(D, NUMBER, '20220101'), 112), 6),1,4) AS 'YEAR' 
                                                   ,SUBSTRING(LEFT(CONVERT(VARCHAR, DATEADD(D, NUMBER, '20220101'), 112), 6),5,6) AS 'MONTH' 
                                            FROM   MASTER..SPT_VALUES
                                            WHERE  TYPE = 'P' 
                                            AND    NUMBER <= DATEDIFF(D, '20220101', GETDATE())
                                            GROUP BY LEFT(CONVERT(VARCHAR, DATEADD(D, NUMBER, '20220101'), 112), 6)) A

                                           LEFT OUTER JOIN ORG_COMPANY B
                                    ON     1 = 1
                                    --AND    B.IS_USE = 'Y'        
                                    AND    B.IS_DISCLOSURE = 'Y' 
                                    
                                    AND    B.USE_DIS_MONTH <= A.MONTH
                                    AND    B.USE_DIS_YEAR <= A.YEAR

                                           LEFT OUTER JOIN ORG_UNION C 
                                    ON     B.ORG_UNION_SEQ = C.SEQ 

                                           LEFT OUTER JOIN DISCLOSURE D
                                    ON     B.SEQ = D.CPN_SEQ
                                    AND    A.YEAR = D.YEAR
                                    AND    A.MONTH = D.MONTH
                                    
                                            INNER JOIN ADMIN_ORG_AUTH E 
                                    ON     B.SEQ = E.ORG_COMPANY_SEQ 

                                           INNER JOIN ADMIN_AUTH F 
                                    ON     E.AUTH_USER_KEY = F.AUTH_USER_KEY 

                                              
                                    " + where + @"

                                    ORDER BY A.YEAR DESC , A.MONTH DESC , C.UNION_NAME DESC       


                    OFFSET @PageCount *(@PageIndex - 1)  ROWS FETCH NEXT @PageCount ROW ONLY ";

                    //" + where + @"

                    search.TotalCount = count(search, where);
                    search.MakePaging();

                    return con.Query<Disclosure>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public Disclosure selectOne(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                
                try
                {
                    con.Open();
                  
                    string query = @" 
                                            SELECT  DISTINCT  A.YEAR
                                          , A.MONTH
                                          , C.SEQ   AS UNION_SEQ
                                          , C.UNION_NAME
                                          , B.SEQ   AS COMPANY_SEQ
                                          , B.COMPANY_NAME
                                          , D.PLAN_YN
                                          , ISNULL(D.REGIST_STATUS,1) AS REGIST_STATUS
                                          , ISNULL(D.CREATE_DATE,'')  AS CREATE_DATE
                                          , ISNULL(D.WRITE_ABLE,'Y')  AS WRITE_ABLE

                                          
                                    FROM   ( SELECT SUBSTRING(LEFT(CONVERT(VARCHAR, DATEADD(D, NUMBER, '20220101'), 112), 6),1,4) AS 'YEAR' 
                                                   ,SUBSTRING(LEFT(CONVERT(VARCHAR, DATEADD(D, NUMBER, '20220101'), 112), 6),5,6) AS 'MONTH' 
                                            FROM   MASTER..SPT_VALUES
                                            WHERE  TYPE = 'P' 
                                            AND    NUMBER <= DATEDIFF(D, '20220101', GETDATE())
                                            GROUP BY LEFT(CONVERT(VARCHAR, DATEADD(D, NUMBER, '20220101'), 112), 6)) A

                                           LEFT OUTER JOIN ORG_COMPANY B
                                    ON     1 = 1
                                    AND    B.IS_USE = 'Y'        
                                    AND    B.IS_DISCLOSURE = 'Y' 

                                           LEFT OUTER JOIN ORG_UNION C 
                                    ON     B.ORG_UNION_SEQ = C.SEQ 

                                           LEFT OUTER JOIN DISCLOSURE D
                                    ON     B.SEQ = D.CPN_SEQ
                                    AND    A.YEAR = D.YEAR
                                    AND    A.MONTH = D.MONTH
                                    
                                            INNER JOIN ADMIN_ORG_AUTH E 
                                    ON     B.SEQ = E.ORG_COMPANY_SEQ 

                                           INNER JOIN ADMIN_AUTH F 
                                    ON     E.AUTH_USER_KEY = F.AUTH_USER_KEY 
                            
                                    WHERE  A.YEAR  =  @Year
                                    AND   A.MONTH =  @Month
                                    AND   B.SEQ   =  @CompanySeq ";


                    return con.Query<Disclosure>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }
        public int disclosureCount(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " SELECT COUNT(*) FROM DISCLOSURE WHERE CPN_SEQ = @CompanySeq AND YEAR = @Year AND MONTH = @Month ";
                    return con.Query<int>(query, param).First();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return -1;
                }
            }
        }
        public Disclosure selectOneCompany(object param)
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

                    return con.Query<Disclosure>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public int insert(Disclosure entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " " +
                        " INSERT INTO DISCLOSURE ( " +
                        "   CPN_SEQ " +
                        " , YEAR " +
                        " , MONTH "+
                        " , PLAN_YN " +
                        " , REGIST_STATUS "+
                        " , WRITE_ABLE " +
                        " , USER_KEY " +
                        " , EMP_NO " +
                        " , CREATE_DATE " +
                        " ) VALUES ( " +
                        "  @CompanySeq " +
                        " , @Year " +
                        ", @Month " +
                        ", 'Y' " +
                        ", 1 " +
                        ", 'Y' " +
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

        public int update(Disclosure entity)
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

        public int updateRegist(Disclosure entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = "UPDATE DISCLOSURE SET " +
                        " REGIST_STATUS = @RegistStatus " +
                        " , USER_KEY = @UserKey" +
                        " , EMP_NO = @EmpNo" +
                        " , CREATE_DATE = GETDATE() " +
                        " WHERE CPN_SEQ = @CompanySeq" +
                        " AND YEAR = @Year" +
                        " AND MONTH = @Month" +

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
        public int afterResetRegist(Disclosure entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = "UPDATE DISCLOSURE SET " +
                        "   REGIST_STATUS = 1 " +
                        "   WHERE CPN_SEQ = @CompanySeq" +
                        "   AND YEAR = @Year" +
                        "   AND MONTH = @Month" +

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
        public int afterUploadRegist(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = @"   IF @RegistStatus = 4 OR @RegistStatus = 5 OR @RegistStatus = 9
                                        BEGIN
                                        UPDATE DISCLOSURE SET  REGIST_STATUS = @RegistStatus , CREATE_DATE = GETDATE() WHERE CPN_SEQ = @CompanySeq AND YEAR = @Year AND MONTH = @Month

                                        END
                                        ELSE
                                        UPDATE DISCLOSURE SET REGIST_STATUS = 2, CREATE_DATE = GETDATE() WHERE CPN_SEQ = @CompanySeq AND YEAR = @Year AND MONTH = @Month 
                                        SELECT @@ROWCOUNT";

                    //string query = "UPDATE DISCLOSURE SET " +
                    //    "   REGIST_STATUS = 2 " + 
                    //    " , CREATE_DATE = GETDATE() " +
                    //    " WHERE CPN_SEQ = @CompanySeq " +
                    //"; SELECT @@ROWCOUNT";
                    return con.Query<int>(query, param).First();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return -1;
                }
            }
        }
        public int planYnUpdate(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = "UPDATE DISCLOSURE SET " +
                        "   PLAN_YN = @PlanYn " +
                        "   WHERE CPN_SEQ = @CompanySeq " +
                        "   AND YEAR = @Year" +
                        "   AND MONTH = @Month" +
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
        public Disclosure selectOneDisclosureMaxYear(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = " SELECT ISNULL(MAX(YEAR), CONVERT(VARCHAR(4), GETDATE(), 121) - 10) + 1 AS YEAR " +
                        " FROM DISCLOSURE " +
                        " ";

                    return con.Query<Disclosure>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }
        public int updateComment(Disclosure entity)
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

        public int save(Disclosure entity)
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



        //public PmCashFlowCumulativeSummary selectOnePrevCashFlowSummary(object param)
        //{
        //    using (IDbConnection con = GetHallaDb())
        //    {
        //        try
        //        {
        //            con.Open();

        //            string query = "";
        //            query += " SELECT A.CASH_FLOW_YEAR, SUM(B.ENDING_CASH) AS ENDING_CASH, SUM(B.AVAILABLE_CASH) AS AVAILABLE_CASH ";
        //            query += "     , SUM(B.FCF2) AS FCF2, SUM(B.EBITDA) AS EBITDA, SUM(B.WC_SUM) AS WC_SUM, SUM(B.ETC) AS ETC ";
        //            query += "     , SUM(B.FINANCIAL_COST) AS FINANCIAL_COST, SUM(B.NET_CAPEX_SUM) AS NET_CAPEX_SUM ";
        //            query += " FROM PM_CASH_FLOW A ";
        //            query += "     , PM_CASH_FLOW_CUMULATIVE B ";
        //            query += " WHERE A.SEQ = B.PM_CASH_FLOW_SEQ ";
        //            query += "     AND A.CASH_FLOW_YEAR = @year ";
        //            query += "     AND A.MONTHLY = '12' ";
        //            query += "     AND A.ORG_COMPANY_SEQ = @orgCompanySeq ";
        //            query += "     AND B.DIFF = " + Define.DIFF.GetKey("실적");
        //            query += " GROUP BY A.CASH_FLOW_YEAR ";

        //            return con.Query<PmCashFlowCumulativeSummary>(query, param).FirstOrDefault();
        //        }
        //        catch (Exception e)
        //        {
        //            LogUtil.MngError(e.ToString());
        //            return null;
        //        }
        //    }
        //}



    }

}