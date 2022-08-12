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
    public class PlanYearInvestBusinessRepo : DbCon, IPlanYearInvestBusinessRepo
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
                    string query = " SELECT COUNT(*) FROM PLAN_YEAR_INVEST_BUSINESS " + where;
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

        public int insert(PlanYearInvestBusiness entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " INSERT INTO  PLAN_YEAR_INVEST_BUSINESS ( " +
                        // 이부분은 수정하여 사용하세요. 
                        " PLAN_YEAR_INVEST_SEQ " +
                        //", SEQ " +
                        ", ORG_BUSINESS_SEQ " +
                        ", YEARLY_YEAR " +
                        //", MONTHLY " +
                        ", INVESTMENT " +
                        ", PERSONNEL " +
                        ", DOMESTIC_PERSONNEL " +
                        ", OVERSEAS_PERSONNEL " +
                    " ) VALUES ( " +
                    " @PlanYearInvestSeq " +
                    //", @Seq " +
                    ", @OrgBusinessSeq " +
                    ", @YearlyYear " +
                    //", @Monthly " +
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

        public int save(PlanYearInvestBusiness entity)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<PlanYearInvestBusiness> selectList(object param)
        {
            throw new NotImplementedException();
        }

        public PlanYearInvestBusiness selectOne(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = " SELECT * " +
                        " FROM PLAN_YEAR_INVEST_BUSINESS " +
                        " WHERE SEQ = @Seq ";

                    return con.Query<PlanYearInvestBusiness>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<PlanYearInvestBusiness> selectListYear(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" 
SELECT	A.YEAR_INVEST_YEAR
		, B.SEQ
		, B.ORG_BUSINESS_SEQ
		, B.YEARLY_YEAR
        , A.ORG_COMPANY_SEQ
		, ISNULL(B.INVESTMENT, 0)				AS INVESTMENT
		, ISNULL(B.PERSONNEL, 0)				AS PERSONNEL
		, ISNULL(B.DOMESTIC_PERSONNEL, 0)		AS DOMESTIC_PERSONNEL
		, ISNULL(B.OVERSEAS_PERSONNEL, 0)		AS OVERSEAS_PERSONNEL
FROM	PLAN_YEAR_INVEST		A
LEFT OUTER JOIN PLAN_YEAR_INVEST_BUSINESS B ON A.SEQ = B.PLAN_YEAR_INVEST_SEQ
WHERE	1 = 1
AND		A.YEAR_INVEST_YEAR = @YearInvestYear
--AND		A.ORG_COMPANY_SEQ = @OrgCompanySeq
";

                    return con.Query<PlanYearInvestBusiness>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<PlanYearInvestBusiness> selectListPnThisYear(object param)
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
		, B.ORG_BUSINESS_SEQ
		, D.BUSINESS_NAME
FROM	PLAN_YEAR_INVEST										A
LEFT OUTER JOIN PLAN_YEAR_INVEST_BUSINESS						B ON A.SEQ = B.PLAN_YEAR_INVEST_SEQ
LEFT OUTER JOIN ORG_COMPANY					C ON A.ORG_COMPANY_SEQ = C.SEQ
LEFT OUTER JOIN ORG_BUSINESS				D ON B.ORG_BUSINESS_SEQ = D.SEQ
LEFT OUTER JOIN ORG_UNION					E ON C.ORG_UNION_SEQ = E.SEQ
WHERE	1 = 1
AND		A.YEAR_INVEST_YEAR = @year
AND     A.REGIST_STATUS = " + Define.REGIST_STATUS.GetKey("최종승인");

                    return con.Query<PlanYearInvestBusiness>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<PlanYearInvestBusiness> selectListThisYear(object param)
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
		, B.ORG_BUSINESS_SEQ
		, D.BUSINESS_NAME
FROM	PLAN_YEAR_INVEST										A
LEFT OUTER JOIN PLAN_YEAR_INVEST_BUSINESS						B ON A.SEQ = B.PLAN_YEAR_INVEST_SEQ
LEFT OUTER JOIN ORG_COMPANY					C ON A.ORG_COMPANY_SEQ = C.SEQ
LEFT OUTER JOIN ORG_BUSINESS				D ON B.ORG_BUSINESS_SEQ = D.SEQ
LEFT OUTER JOIN ORG_UNION					E ON C.ORG_UNION_SEQ = E.SEQ
WHERE	1 = 1
AND		A.YEAR_INVEST_YEAR = @year " ;

                    return con.Query<PlanYearInvestBusiness>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<PlanYearInvestBusiness> selectListExcel(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string where = " WHERE 1 = 1 ";

                    string query = @" 
SELECT	A.PLAN_YEAR_INVEST_SEQ
		, A.SEQ
		, A.ORG_BUSINESS_SEQ
		, B.BUSINESS_NAME
		, C.COMPANY_NAME
		, A.YEARLY_YEAR
		, A.INVESTMENT
		, A.PERSONNEL
		, A.DOMESTIC_PERSONNEL
		, A.OVERSEAS_PERSONNEL
FROM	PLAN_YEAR_INVEST_BUSINESS		A
LEFT OUTER JOIN ORG_BUSINESS				B ON A.ORG_BUSINESS_SEQ = B.SEQ
LEFT OUTER JOIN ORG_COMPANY					C ON B.ORG_COMPANY_SEQ = C.SEQ
WHERE	1 = 1
AND		A.PLAN_YEAR_INVEST_SEQ = @PlanYearInvestSeq                      
                        
                        ";

                    return con.Query<PlanYearInvestBusiness>(query, param).ToList();

                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public int update(PlanYearInvestBusiness entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " UPDATE PLAN_YEAR_INVEST_BUSINESS SET " +
                        // 이부분은 수정하여 사용하세요. 
                        //" , PLAN_YEAR_INVEST_SEQ = @PlanYearInvestSeq" +
                        //" , SEQ = @Seq" +
                        //" , ORG_BUSINESS_SEQ = @OrgBusinessSeq" +
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

        public IEnumerable<PlanYearInvestBusiness> selectListBefore(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"";

                    return con.Query<PlanYearInvestBusiness>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }

        }
        public IEnumerable<PlanYearInvestBusiness> selectListNowYear(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = "";
                    query += " SELECT	* ";
                    query += " FROM	PLAN_YEAR_INVEST							    A ";
                    query += " LEFT OUTER JOIN PLAN_YEAR_INVEST_BUSINESS			B ON A.SEQ = B.PLAN_YEAR_INVEST_SEQ ";
                    query += " WHERE A.YEAR_INVEST_YEAR = @yearInvestYear ";
                    query += "     AND A.ORG_COMPANY_SEQ = @orgCompanySeq ";
                    query += "     AND A.REGIST_STATUS = " + Define.REGIST_STATUS.GetKey("최종승인");

                    return con.Query<PlanYearInvestBusiness>(query, param).ToList();
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