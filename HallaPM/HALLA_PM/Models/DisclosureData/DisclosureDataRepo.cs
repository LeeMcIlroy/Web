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
    public class DisclosureDataRepo : DbCon, IDisclosureDataRepo
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

        public IEnumerable<DisclosureData> selectList(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string where = @"
                                    WHERE 1 = 1 
                                    AND A.IDX_SEQ = @CompanySeq
                                    AND A.[YEAR] = @Year
                                    AND A.[MONTH] = @Month
                                    ";

                    

                    string query = @"
                                   SELECT * FROM
                                    (
                                    SELECT                                  
                                        ROW_NUMBER() OVER(ORDER BY A.IDX DESC) AS ROW_NUM
                                        , A.IDX
                                        , A.IDX_SEQ
                                        , A.YEAR
                                        , A.MONTH
                                        , A.DIS_NAME
                                        , A.DETAIL_NAME
                                        , A.TITLE
                                        , A.PLAN_YN
                                        , A.TRANS_CPN
                                        , A.TRANS_AMT 
                                        , A.TRANS_DATE
                                        , A.CONTENT
                                        , A.REMARK
                                        , A.USER_KEY
                                        , A.EMP_NO
                                        , A.CREATE_DATE

                                        FROM DISCLOSURE_DATA A 
                                         WHERE 1 = 1
                                    AND A.IDX_SEQ = @CompanySeq
                                    AND A.[YEAR] = @Year
                                    AND A.[MONTH] = @Month 

                                    ) A 
                                    ORDER BY ROW_NUM DESC ";
                                       


                    //OFFSET @PageCount *(@PageIndex - 1)  ROWS FETCH NEXT @PageCount ROW ONLY;


                    //search.TotalCount = count(search, where);
                    //search.MakePaging();

                    return con.Query<DisclosureData>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public DisclosureData selectOne(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                
                try
                {
                    con.Open();
                    string where = @"
                                    WHERE A.YEAR  = @YEAR
                                    AND   A.MONTH = @MONTH
                                    AND   B.SEQ   = @CompanySeq

                                    ";
                    string query = @" 
                                            SELECT  DISTINCT  A.YEAR
                                          , A.MONTH
                                          , C.SEQ   AS UNION_SEQ
                                          , C.UNION_NAME
                                          , B.SEQ   AS COMPANY_SEQ
                                          , B.COMPANY_NAME
                                          , ISNULL(D.REGIST_STAUTS,1) AS REGIST_STATUS
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


                    return con.Query<DisclosureData>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public DisclosureData selectOneCompany(object param)
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

                    return con.Query<DisclosureData>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public int insert(DisclosureData entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = "  INSERT INTO  DISCLOSURE_DATA ( " +
                        "  IDX_SEQ " +
                        ", YEAR " +
                        ", MONTH " +
                        ", DIS_NAME " +
                        ", DETAIL_NAME " +
                        ", TITLE " +
                        ", DIS_CODE " +
                        ", PLAN_YN " +
                        ", TRANS_CPN " +
                        ", TRANS_AMT " +
                        ", TRANS_DATE " +
                        ", CONTENT " +
                        ", REMARK " +
                        ", USER_KEY " +
                        ", EMP_NO " +
                        ", CREATE_DATE " +
                        " ) VALUES ( " +
                        "  @IdxSeq " +
                        ", @Year " +
                        ", @Month " +
                        ", @DisName " +
                        ", @DetailName " +
                        ", @Title " +
                        ", @DisCode " +
                        ", @PlanYn " +
                        ", @TransCpn " +
                        ", @TransAmt " +
                        ", @TransDate " +
                        ", @Content " +
                        ", @Remark " +
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

        public int update(DisclosureData entity)
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

        public int updateRegist(DisclosureData entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = "UPDATE DISCLOSURE SET " +
                        " REGIST_STATUS = @RegistStatus " +        
                        " WHERE IDX_SEQ = @CompanySeq" +
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

        public int updateComment(DisclosureData entity)
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
                    string query = " DELETE DISCLOSURE_DATA " +
                        " WHERE IDX_SEQ = @CompanySeq AND MONTH = @Month AND YEAR = @Year "  +
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

        public int save(DisclosureData entity)
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