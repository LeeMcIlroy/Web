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
    public class PlanMonthlyInvestSummaryRepo : DbCon, IPlanMonthlyInvestSummaryRepo
    {
        public int count(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " SELECT COUNT(*) FROM PLAN_MONTHLY_INVEST_SUMMARY ";
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
                    string query = " DELETE PLAN_MONTHLY_INVEST_SUMMARY " +
                        " WHERE PLAN_MONTHLY_INVEST_SEQ = @PlanMonthlyInvestSeq";
                    return con.Execute(query, key);
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

        public int insert(PlanMonthlyInvestSummary entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " INSERT INTO  PLAN_MONTHLY_INVEST_SUMMARY ( " +
                        // 이부분은 수정하여 사용하세요. 
                        " PLAN_MONTHLY_INVEST_SEQ " +
                        //", SEQ " +
                        ", MONTHLY " +
                        ", INVESTMENT " +
                        ", PERSONNEL " +
                        ", DOMESTIC_PERSONNEL " +
                        ", OVERSEAS_PERSONNEL " +
                    " ) VALUES ( " +
                    " @PlanMonthlyInvestSeq " +
                    //", @Seq " +
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

        public int insertSum(PlanMonthlyInvestSummary entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
INSERT INTO PLAN_MONTHLY_INVEST_SUMMARY
( PLAN_MONTHLY_INVEST_SEQ, MONTHLY, INVESTMENT, PERSONNEL, DOMESTIC_PERSONNEL, OVERSEAS_PERSONNEL)
SELECT	A.PLAN_MONTHLY_INVEST_SEQ
		, A.MONTHLY
		, SUM(A.INVESTMENT)				AS INVESTMENT
		, SUM(A.PERSONNEL)				AS PERSONNEL
		, SUM(A.DOMESTIC_PERSONNEL)		AS DOMESTIC_PERSONNEL
		, SUM(A.OVERSEAS_PERSONNEL)		AS OVERSEAS_PERSONNEL
FROM	PLAN_MONTHLY_INVEST_BUSINESS		A
WHERE	1 = 1
AND		A.PLAN_MONTHLY_INVEST_SEQ = @PlanMonthlyInvestSeq
GROUP BY A.PLAN_MONTHLY_INVEST_SEQ, A.MONTHLY
         SELECT @@ROWCOUNT";

                    return con.Query<int>(query, entity).First();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return -1;
                }
            }
        }

        public int save(PlanMonthlyInvestSummary entity)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<PlanMonthlyInvestSummary> selectList(object param)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<PlanMonthlyInvestSummary> selectListYear(object param)
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
FROM	PLAN_MONTHLY_INVEST										A
LEFT OUTER JOIN PLAN_MONTHLY_INVEST_SUMMARY						B ON A.SEQ = B.PLAN_MONTHLY_INVEST_SEQ
LEFT OUTER JOIN ORG_COMPANY					C ON A.ORG_COMPANY_SEQ = C.SEQ
LEFT OUTER JOIN ORG_UNION					E ON C.ORG_UNION_SEQ = E.SEQ
WHERE	1 = 1
AND		A.MONTHLY_INVEST_YEAR = @YearInvestYear
AND		A.ORG_COMPANY_SEQ = @OrgCompanySeq
";

                    return con.Query<PlanMonthlyInvestSummary>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }
        public IEnumerable<PlanMonthlyInvestSummary> selectListBefore(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
SELECT	A.PLAN_MONTHLY_INVEST_SEQ
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
        , A.SEQ AS PLAN_MONTHLY_INVEST_SUMMARY_SEQ
FROM	PLAN_MONTHLY_INVEST_SUMMARY				A
LEFT OUTER JOIN PLAN_MONTHLY_INVEST				B ON A.PLAN_MONTHLY_INVEST_SEQ = B.SEQ
LEFT OUTER JOIN PLAN_MONTHLY_INVEST				C ON B.ORG_COMPANY_SEQ = C.ORG_COMPANY_SEQ AND CONVERT(VARCHAR, B.MONTHLY_INVEST_YEAR - 1) = C.MONTHLY_INVEST_YEAR
LEFT OUTER JOIN PLAN_MONTHLY_INVEST_SUMMARY		D ON C.SEQ = D.PLAN_MONTHLY_INVEST_SEQ AND A.MONTHLY = D.MONTHLY
WHERE	1 = 1
AND		A.PLAN_MONTHLY_INVEST_SEQ = @PlanMonthlyInvestSeq
";
                    return con.Query<PlanMonthlyInvestSummary>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }
        public IEnumerable<PlanMonthlyInvestSummaryExp> selectListPnThisYear(object param)
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
FROM	PLAN_MONTHLY_INVEST										A
LEFT OUTER JOIN PLAN_MONTHLY_INVEST_SUMMARY						B ON A.SEQ = B.PLAN_MONTHLY_INVEST_SEQ
LEFT OUTER JOIN ORG_COMPANY					C ON A.ORG_COMPANY_SEQ = C.SEQ
LEFT OUTER JOIN ORG_UNION					E ON C.ORG_UNION_SEQ = E.SEQ
WHERE	1 = 1
AND		A.MONTHLY_INVEST_YEAR = @year
AND     A.REGIST_STATUS = " + Define.REGIST_STATUS.GetKey("최종승인") + @"
ORDER BY C.ORG_UNION_SEQ, C.ORD";

                    return con.Query<PlanMonthlyInvestSummaryExp>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public PlanMonthlyInvestSummary selectOne(object param)
        {
            throw new NotImplementedException();
        }

        public int update(PlanMonthlyInvestSummary entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " UPDATE PLAN_MONTHLY_INVEST_SUMMARY SET " +
                        // 이부분은 수정하여 사용하세요. 
                        //" PLAN_MONTHLY_INVEST_SEQ = @PlanMonthlyInvestSeq" +
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


        public PlanMonthlyInvestSummaryExp selectOneNowYear(object param)
        {

            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
                    
SELECT PLAN_MONTHLY_INVEST_SEQ
	, SUM(INVESTMENT) AS INVESTMENT
	, SUM(PERSONNEL) AS PERSONNEL
	, SUM(DOMESTIC_PERSONNEL) AS DOMESTIC_PERSONNEL
	, SUM(OVERSEAS_PERSONNEL) AS OVERSEAS_PERSONNEL
FROM PLAN_MONTHLY_INVEST						A
LEFT OUTER JOIN PLAN_MONTHLY_INVEST_SUMMARY		B ON A.SEQ = B.PLAN_MONTHLY_INVEST_SEQ
WHERE 1=1
AND	A.MONTHLY_INVEST_YEAR = @MonthlyInvestYear
AND B.MONTHLY <= @Monthly
AND ORG_COMPANY_SEQ = @OrgCompanySeq
GROUP BY PLAN_MONTHLY_INVEST_SEQ
";

                    return con.Query<PlanMonthlyInvestSummaryExp>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }



        public PlanMonthlyInvestSummaryExp selectOneNowMonth(object param)
        {

            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
                    
SELECT *
FROM PLAN_MONTHLY_INVEST						A
LEFT OUTER JOIN PLAN_MONTHLY_INVEST_SUMMARY		B ON A.SEQ = B.PLAN_MONTHLY_INVEST_SEQ
WHERE 1=1
AND	A.MONTHLY_INVEST_YEAR = @MonthlyInvestYear
AND B.MONTHLY = @Monthly
AND ORG_COMPANY_SEQ = @OrgCompanySeq
";

                    return con.Query<PlanMonthlyInvestSummaryExp>(query, param).FirstOrDefault();
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