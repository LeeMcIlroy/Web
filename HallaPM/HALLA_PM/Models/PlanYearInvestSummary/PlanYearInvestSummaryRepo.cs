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
    public class PlanYearInvestSummaryRepo : DbCon, IPlanYearInvestSummaryRepo
    {
        public int count(object param)
        {
            throw new NotImplementedException();
        }

        public int delete(object key)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " DELETE PLAN_YEAR_INVEST_SUMMARY " +
                        " WHERE PLAN_YEAR_INVEST_SEQ = @PlanYearInvestSeq";
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

        public int insert(PlanYearInvestSummary entity)
        {
            throw new NotImplementedException();
        }

        public int insertSum(PlanYearInvestSummary entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
INSERT INTO PLAN_YEAR_INVEST_SUMMARY
( PLAN_YEAR_INVEST_SEQ, YEARLY_YEAR, INVESTMENT, PERSONNEL, DOMESTIC_PERSONNEL, OVERSEAS_PERSONNEL )
SELECT	A.PLAN_YEAR_INVEST_SEQ
		, A.YEARLY_YEAR
		, SUM(A.INVESTMENT)				AS INVESTMENT
		, SUM(A.PERSONNEL)				AS PERSONNEL
		, SUM(A.DOMESTIC_PERSONNEL)		AS DOMESTIC_PERSONNEL
		, SUM(A.OVERSEAS_PERSONNEL)		AS OVERSEAS_PERSONNEL
FROM	PLAN_YEAR_INVEST_BUSINESS		A
WHERE	1 = 1
AND		A.PLAN_YEAR_INVEST_SEQ = @PlanYearInvestSeq
GROUP BY A.PLAN_YEAR_INVEST_SEQ, A.YEARLY_YEAR

SELECT @@ROWCOUNT
";

                    return con.Query<int>(query, entity).First();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return -1;
                }
            }
        }

        public int save(PlanYearInvestSummary entity)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<PlanYearInvestSummary> selectList(object param)
        {
            throw new NotImplementedException();
        }


        public IEnumerable<PlanYearInvestSummary> selectListYear(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" 
SELECT	A.YEAR_INVEST_YEAR
		, B.SEQ
		, B.YEARLY_YEAR
		, ISNULL(B.INVESTMENT, 0)				AS INVESTMENT
		, ISNULL(B.PERSONNEL, 0)				AS PERSONNEL
		, ISNULL(B.DOMESTIC_PERSONNEL, 0)		AS DOMESTIC_PERSONNEL
		, ISNULL(B.OVERSEAS_PERSONNEL, 0)		AS OVERSEAS_PERSONNEL
FROM	PLAN_YEAR_INVEST		A
LEFT OUTER JOIN PLAN_YEAR_INVEST_SUMMARY B ON A.SEQ = B.PLAN_YEAR_INVEST_SEQ
WHERE	1 = 1
AND		A.YEAR_INVEST_YEAR = @YearInvestYear
AND		A.ORG_COMPANY_SEQ = @OrgCompanySeq
";

                    return con.Query<PlanYearInvestSummary>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<PlanYearInvestSummary> selectListPnThisYear(object param)
        {

            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
SELECT	A.YEAR_INVEST_YEAR
		, B.YEARLY_YEAR
		, ISNULL(B.INVESTMENT, 0)				AS INVESTMENT
		, ISNULL(B.PERSONNEL, 0)				AS PERSONNEL
		, ISNULL(B.DOMESTIC_PERSONNEL, 0)		AS DOMESTIC_PERSONNEL
		, ISNULL(B.OVERSEAS_PERSONNEL, 0)		AS OVERSEAS_PERSONNEL
		, C.ORG_UNION_SEQ
		, E.UNION_NAME
		, A.ORG_COMPANY_SEQ
		, C.COMPANY_NAME
FROM	PLAN_YEAR_INVEST										A
LEFT OUTER JOIN PLAN_YEAR_INVEST_SUMMARY						B ON A.SEQ = B.PLAN_YEAR_INVEST_SEQ
LEFT OUTER JOIN ORG_COMPANY					C ON A.ORG_COMPANY_SEQ = C.SEQ
LEFT OUTER JOIN ORG_UNION					E ON C.ORG_UNION_SEQ = E.SEQ
WHERE	1 = 1
AND		A.YEAR_INVEST_YEAR = @year
ORDER BY C.ORG_UNION_SEQ, C.ORD";

                    return con.Query<PlanYearInvestSummary>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public PlanYearInvestSummary selectOne(object param)
        {
            throw new NotImplementedException();
        }

        public int update(PlanYearInvestSummary entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " UPDATE PLAN_YEAR_INVEST_SUMMARY SET " +
                        // 이부분은 수정하여 사용하세요. 
                        //" , PLAN_YEAR_INVEST_SEQ = @PlanYearInvestSeq" +
                        //" , SEQ = @Seq" +
                        //" , YEARLY_YEAR = @YearlyYear" +
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


        public PlanYearInvestSummary selectListNowYear(object param)
        {

            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
SELECT	*
FROM	PLAN_YEAR_INVEST					A
LEFT OUTER JOIN PLAN_YEAR_INVEST_SUMMARY		B ON A.SEQ = B.PLAN_YEAR_INVEST_SEQ
WHERE	1 = 1
AND		A.YEAR_INVEST_YEAR = @YearInvestYear
AND     B.YEARLY_YEAR = @YearlyYear
AND		A.ORG_COMPANY_SEQ = @OrgCompanySeq
";

                    return con.Query<PlanYearInvestSummary>(query, param).FirstOrDefault();
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