using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Data;
using Dapper;
using HALLA_PM.Util;
using HALLA_PM.Core;

namespace HALLA_PM.Models
{
    public class PlanMonthlyInvestBusinessRepo : DbCon, IPlanMonthlyInvestBusinessRepo
    {
        public int count(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " SELECT COUNT(*) FROM PLAN_MONTHLY_INVEST_BUSINESS ";
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
                    string query = " SELECT COUNT(*) FROM PLAN_MONTHLY_INVEST_BUSINESS " + where;
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

        public int insert(PlanMonthlyInvestBusiness entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " INSERT INTO  PLAN_MONTHLY_INVEST_BUSINESS ( " +
                        // 이부분은 수정하여 사용하세요. 
                        " PLAN_MONTHLY_INVEST_SEQ " +
                        //", SEQ " +
                        ", ORG_BUSINESS_SEQ " +
                        ", MONTHLY " +
                        ", INVESTMENT " +
                        ", PERSONNEL " +
                        ", DOMESTIC_PERSONNEL " +
                        ", OVERSEAS_PERSONNEL " +
                    " ) VALUES ( " +
                    " @PlanMonthlyInvestSeq " +
                    //", @Seq " +
                    ", @OrgBusinessSeq " +
                    ", @Monthly " +
                    ", @Investment " +
                    ", @Personnel " +
                    ", @DomesticPersonnel " +
                    ", @OverseasPersonnel " +
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

        public int save(PlanMonthlyInvestBusiness entity)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<PlanMonthlyInvestBusiness> selectList(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string where = " WHERE 1 = 1 ";

                    string query = " SELECT	A.*, B.BUSINESS_NAME " +
                        " FROM PLAN_MONTHLY_INVEST_BUSINESS 	A " +
                        "LEFT OUTER JOIN ORG_BUSINESS        B ON A.ORG_BUSINESS_SEQ = B.SEQ WHERE PLAN_MONTHLY_INVEST_SEQ = @PlanMonthlyInvestSeq";

                    return con.Query<PlanMonthlyInvestBusiness>(query, param).ToList();

                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<PlanMonthlyInvestBusiness> selectListExcel(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string where = " WHERE 1 = 1 ";

                    string query = @" 
SELECT	A.PLAN_MONTHLY_INVEST_SEQ
		, A.SEQ
		, A.ORG_BUSINESS_SEQ
		, B.BUSINESS_NAME
		, C.COMPANY_NAME
		, A.MONTHLY
		, A.INVESTMENT
		, A.PERSONNEL
		, A.DOMESTIC_PERSONNEL
		, A.OVERSEAS_PERSONNEL
FROM	PLAN_MONTHLY_INVEST_BUSINESS		A
LEFT OUTER JOIN ORG_BUSINESS				B ON A.ORG_BUSINESS_SEQ = B.SEQ
LEFT OUTER JOIN ORG_COMPANY					C ON B.ORG_COMPANY_SEQ = C.SEQ
WHERE	1 = 1
AND		A.PLAN_MONTHLY_INVEST_SEQ = @PlanMonthlyInvestSeq                      
                        
                        ";

                    return con.Query<PlanMonthlyInvestBusiness>(query, param).ToList();

                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }
        public IEnumerable<PlanMonthlyInvestBusinessExp> selectListPnThisYear(object param)
        {

            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
SELECT	A.MONTHLY_INVEST_YEAR
		, B.MONTHLY
		, ISNULL(B.INVESTMENT, 0)				AS INVESTMENT
		, ISNULL(B.PERSONNEL, 0)				AS PERSONNEL
		, ISNULL(B.DOMESTIC_PERSONNEL, 0)		AS DOMESTIC_PERSONNEL
		, ISNULL(B.OVERSEAS_PERSONNEL, 0)		AS OVERSEAS_PERSONNEL
		, C.ORG_UNION_SEQ
		, E.UNION_NAME
		, A.ORG_COMPANY_SEQ
		, C.COMPANY_NAME
        , B.ORG_BUSINESS_SEQ
		, D.BUSINESS_NAME
FROM	PLAN_MONTHLY_INVEST										A
LEFT OUTER JOIN PLAN_MONTHLY_INVEST_BUSINESS						B ON A.SEQ = B.PLAN_MONTHLY_INVEST_SEQ
LEFT OUTER JOIN ORG_COMPANY					C ON A.ORG_COMPANY_SEQ = C.SEQ
LEFT OUTER JOIN ORG_BUSINESS				D ON B.ORG_BUSINESS_SEQ = D.SEQ
LEFT OUTER JOIN ORG_UNION					E ON C.ORG_UNION_SEQ = E.SEQ
WHERE	1 = 1
AND		A.MONTHLY_INVEST_YEAR = @year
AND     A.REGIST_STATUS = " + Define.REGIST_STATUS.GetKey("최종승인") + @"";

                    return con.Query<PlanMonthlyInvestBusinessExp>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<PlanMonthlyInvestBusinessExp> selectListYear(object param)
        {

            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
SELECT	A.MONTHLY_INVEST_YEAR
		, B.MONTHLY
		, ISNULL(B.INVESTMENT, 0)				AS INVESTMENT
		, ISNULL(B.PERSONNEL, 0)				AS PERSONNEL
		, ISNULL(B.DOMESTIC_PERSONNEL, 0)		AS DOMESTIC_PERSONNEL
		, ISNULL(B.OVERSEAS_PERSONNEL, 0)		AS OVERSEAS_PERSONNEL
		, C.ORG_UNION_SEQ
		, E.UNION_NAME
		, A.ORG_COMPANY_SEQ
		, C.COMPANY_NAME
        , B.ORG_BUSINESS_SEQ
		, D.BUSINESS_NAME
FROM	PLAN_MONTHLY_INVEST										A
LEFT OUTER JOIN PLAN_MONTHLY_INVEST_BUSINESS						B ON A.SEQ = B.PLAN_MONTHLY_INVEST_SEQ
LEFT OUTER JOIN ORG_COMPANY					C ON A.ORG_COMPANY_SEQ = C.SEQ
LEFT OUTER JOIN ORG_BUSINESS				D ON B.ORG_BUSINESS_SEQ = D.SEQ
LEFT OUTER JOIN ORG_UNION					E ON C.ORG_UNION_SEQ = E.SEQ
WHERE	1 = 1
AND		A.MONTHLY_INVEST_YEAR = @YearInvestYear
";

                    return con.Query<PlanMonthlyInvestBusinessExp>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<PlanMonthlyInvestBusiness> selectListBofore(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
SELECT	A.ORG_BUSINESS_SEQ
		, A.MONTHLY
		, ISNULL(D.INVESTMENT, 0)				AS BEFORE_INVESTMENT
		, ISNULL(D.PERSONNEL, 0)				AS BEFORE_PERSONNEL
		, ISNULL(D.DOMESTIC_PERSONNEL, 0)		AS BEFORE_DOMESTIC_PERSONNEL
		, ISNULL(D.OVERSEAS_PERSONNEL, 0)		AS BEFORE_OVERSEAS_PERSONNEL
		, A.INVESTMENT
		, A.PERSONNEL
		, A.DOMESTIC_PERSONNEL
		, A.OVERSEAS_PERSONNEL
		, B.MONTHLY_INVEST_YEAR					AS MONTHLY_INVEST_YEAR
		, C.MONTHLY_INVEST_YEAR					AS BEFORE_MONTHLY_INVEST_YEAR
        , A.SEQ AS PLAN_MONTHLY_INVEST_BUSINESS_SEQ
FROM	PLAN_MONTHLY_INVEST_BUSINESS			A
LEFT OUTER JOIN PLAN_MONTHLY_INVEST				B ON A.PLAN_MONTHLY_INVEST_SEQ = B.SEQ
LEFT OUTER JOIN PLAN_MONTHLY_INVEST				C ON B.ORG_COMPANY_SEQ = C.ORG_COMPANY_SEQ AND CONVERT(VARCHAR, B.MONTHLY_INVEST_YEAR - 1) = C.MONTHLY_INVEST_YEAR
LEFT OUTER JOIN PLAN_MONTHLY_INVEST_BUSINESS	D ON C.SEQ = D.PLAN_MONTHLY_INVEST_SEQ AND A.ORG_BUSINESS_SEQ = D.ORG_BUSINESS_SEQ AND A.MONTHLY = D.MONTHLY
WHERE	1 = 1
AND		A.PLAN_MONTHLY_INVEST_SEQ = @PlanMonthlyInvestSeq
";
                    return con.Query<PlanMonthlyInvestBusiness>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public PlanMonthlyInvestBusiness selectOne(object param)
        {
            throw new NotImplementedException();
        }

        public int update(PlanMonthlyInvestBusiness entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " UPDATE PLAN_MONTHLY_INVEST_BUSINESS SET " +
                        // 이부분은 수정하여 사용하세요. 
                        //" PLAN_MONTHLY_INVEST_SEQ = @PlanMonthlyInvestSeq" +
                        //" , ORG_BUSINESS_SEQ = @OrgBusinessSeq" +
                        //" , MONTHLY = @Monthly" +
                        " INVESTMENT = @Investment" +
                        " , PERSONNEL = @Personnel" +
                        " , DOMESTIC_PERSONNEL = @DomesticPersonnel" +
                        " , OVERSEAS_PERSONNEL = @OverseasPersonnel" +
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

        

        public IEnumerable<PlanMonthlyInvestBusiness> selectListNowMonthly(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = "";
                    query += " SELECT	* ";
                    query += " FROM	PLAN_MONTHLY_INVEST							    A ";
                    query += " LEFT OUTER JOIN PLAN_MONTHLY_INVEST_BUSINESS			B ON A.SEQ = B.PLAN_MONTHLY_INVEST_SEQ ";
                    query += " WHERE A.MONTHLY_INVEST_YEAR = @monthlyInvestYear ";
                    query += "     AND A.ORG_COMPANY_SEQ = @orgCompanySeq ";
                    query += "     AND A.REGIST_STATUS = " + Define.REGIST_STATUS.GetKey("최종승인");
                    query += "     AND B.MONTHLY = @monthly ";

                    return con.Query<PlanMonthlyInvestBusiness>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<PlanMonthlyInvestBusiness> selectListNowMonthlySummary(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = "";
                    query += " SELECT	ORG_BUSINESS_SEQ ";
                    query += "     , SUM(B.INVESTMENT) AS INVESTMENT ";
                    query += "     , SUM(B.PERSONNEL)AS PERSONNEL ";
                    query += "     , SUM(B.DOMESTIC_PERSONNEL) AS DOMESTIC_PERSONNEL ";
                    query += "     , SUM(B.OVERSEAS_PERSONNEL) AS OVERSEAS_PERSONNEL ";
                    query += " FROM	PLAN_MONTHLY_INVEST							    A ";
                    query += " LEFT OUTER JOIN PLAN_MONTHLY_INVEST_BUSINESS			B ON A.SEQ = B.PLAN_MONTHLY_INVEST_SEQ ";
                    query += " WHERE A.MONTHLY_INVEST_YEAR = @monthlyInvestYear ";
                    query += "     AND A.ORG_COMPANY_SEQ = @orgCompanySeq ";
                    query += "     AND A.REGIST_STATUS = " + Define.REGIST_STATUS.GetKey("최종승인");
                    query += "     AND B.MONTHLY <= @monthly ";
                    query += " GROUP BY ORG_BUSINESS_SEQ ";

                    return con.Query<PlanMonthlyInvestBusiness>(query, param).ToList();
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