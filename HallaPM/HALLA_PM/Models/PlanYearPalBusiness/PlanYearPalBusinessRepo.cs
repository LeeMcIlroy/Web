using Dapper;
using HALLA_PM.Util;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

using HALLA_PM.Core;

namespace HALLA_PM.Models
{
    public class PlanYearPalBusinessRepo : DbCon, IPlanYearPalBusinessRepo
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
                    string query = @" SELECT COUNT(*) FROM PLAN_YEAR_PAL_BUSINESS " + where;

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

        public int insert(PlanYearPalBusiness entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = @" INSERT INTO PLAN_YEAR_PAL_BUSINESS (
                                          PLAN_YEAR_PAL_SEQ
                                          ,ORG_BUSINESS_SEQ
                                          ,YEARLY_YEAR
                                          ,SALES
                                          ,EBIT
                                          ,EBIT_RATE
                                          ,PBT
                                      ) VALUES (
                                          @PlanYearPalSeq
                                          , @OrgBusinessSeq
                                          , @YearlyYear
                                          , @Sales
                                          , @Ebit
                                          , @EbitRate
                                          , @Pbt
                                      ); SELECT CAST(SCOPE_IDENTITY() as int)";
                    return con.Query<int>(query, entity).First();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return -1;
                }
            }
        }

        public int save(PlanYearPalBusiness entity)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<PlanYearPalBusiness> selectList(object param)
        {
            throw new NotImplementedException();
        }

        public PlanYearPalBusiness selectOne(object param)
        {
            throw new NotImplementedException();
        }

        public int update(PlanYearPalBusiness entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" UPDATE PLAN_YEAR_PAL_BUSINESS SET
                        SALES = @Sales 
                        , EBIT = @Ebit
                        , PBT = @Pbt
                        WHERE SEQ = @Seq
                        SELECT @@ROWCOUNT ";
                    return con.Query<int>(query, entity).First();

                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return -1;
                }
            }
        }

        public IEnumerable<PlanYearPalBusiness> selectListYear(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" 
SELECT	A.YEAR_PAL_YEAR
		, B.SEQ
		, B.ORG_BUSINESS_SEQ
		, B.YEARLY_YEAR
		, ISNULL(B.SALES, 0)				AS SALES
		, ISNULL(B.EBIT, 0)					AS EBIT
		, ISNULL(B.PBT, 0)					AS PBT
		,CASE WHEN ISNULL(SALES, 0) = 0 THEN 0 
			  WHEN ISNULL(EBIT, 0)  = 0 THEN 0
		 ELSE ISNULL(EBIT, 0) / ISNULL(SALES, 0) END AS EBIT_RATE
FROM	PLAN_YEAR_PAL		A
LEFT OUTER JOIN PLAN_YEAR_PAL_BUSINESS B ON A.SEQ = B.PLAN_YEAR_PAL_SEQ
WHERE	1 = 1
AND		A.YEAR_PAL_YEAR = @YearPalYear
AND		A.ORG_COMPANY_SEQ = @OrgCompanySeq
";

                    return con.Query<PlanYearPalBusiness>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<PlanYearPalBusiness> selectListExcel(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string where = " WHERE 1 = 1 ";

                    string query = @" 
SELECT	A.PLAN_YEAR_PAL_SEQ
		, A.SEQ
		, A.ORG_BUSINESS_SEQ
		, B.BUSINESS_NAME
		, C.COMPANY_NAME
		, A.YEARLY_YEAR
		, A.SALES
		, A.EBIT
		, A.PBT
FROM	PLAN_YEAR_PAL_BUSINESS	A
LEFT OUTER JOIN ORG_BUSINESS		B ON A.ORG_BUSINESS_SEQ = B.SEQ
LEFT OUTER JOIN ORG_COMPANY			C ON B.ORG_COMPANY_SEQ = C.SEQ
WHERE	A.PLAN_YEAR_PAL_SEQ = @PlanYearPalSeq
                        ";

                    return con.Query<PlanYearPalBusiness>(query, param).ToList();

                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<PlanYearPalBusinessSummary> selectSummaryList(object param)
        {

            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = "";
                    query += " SELECT YEARLY_YEAR, SUM(SALES) AS SALES , SUM(EBIT) AS EBIT ";
                    //query += " FROM PLAN_YEAR_PAL_BUSINESS ";
                    query += " FROM PLAN_YEAR_PAL_BUSINESS_SUMMARY ";
                    query += " WHERE PLAN_YEAR_PAL_SEQ = @planYearPalSeq ";
                    query += "     AND ORG_BUSINESS_SEQ = @orgBusinessSeq ";
                    query += " GROUP BY YEARLY_YEAR ";

                    return con.Query<PlanYearPalBusinessSummary>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }


        public IEnumerable<PlanYearPalBusinessSummary> selectTotalSummaryList(object param)
        {

            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = "";
                    query += " SELECT YEARLY_YEAR, SUM(SALES) AS SALES , SUM(EBIT) AS EBIT ";
                    query += " FROM PLAN_YEAR_PAL_BUSINESS ";
                    query += " WHERE PLAN_YEAR_PAL_SEQ = @planYearPalSeq ";
                    query += " GROUP BY YEARLY_YEAR ";

                    return con.Query<PlanYearPalBusinessSummary>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        /// <summary>
        /// 당해년도 중기손익 리스트 : Bu
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        public IEnumerable<PlanYearPalBusinessExp> selectListPnThisYear(object param)
        {

            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
-- <만도(BU) => 14, HL Klemove => 19, 만도헬라 => 4 제외>

SELECT	A.YEAR_PAL_YEAR
		, B.YEARLY_YEAR
		, ISNULL(B.SALES, 0)				AS SALES
		, ISNULL(B.EBIT, 0)					AS EBIT
		, ISNULL(B.PBT, 0)					AS PBT
		, C.ORG_UNION_SEQ
		, E.UNION_NAME
		, A.ORG_COMPANY_SEQ
		, C.COMPANY_NAME
		, B.ORG_BUSINESS_SEQ
		, D.BUSINESS_NAME
FROM	PLAN_YEAR_PAL						A
LEFT OUTER JOIN PLAN_YEAR_PAL_BUSINESS		B ON A.SEQ = B.PLAN_YEAR_PAL_SEQ
LEFT OUTER JOIN ORG_COMPANY							C ON A.ORG_COMPANY_SEQ = C.SEQ
LEFT OUTER JOIN ORG_BUSINESS				D ON B.ORG_BUSINESS_SEQ = D.SEQ
LEFT OUTER JOIN ORG_UNION					E ON C.ORG_UNION_SEQ = E.SEQ
WHERE	1 = 1
AND		A.YEAR_PAL_YEAR = @year
AND     C.SEQ NOT  IN('14','19','4')
AND     A.REGIST_STATUS = " + Define.REGIST_STATUS.GetKey("최종승인");

                    return con.Query<PlanYearPalBusinessExp>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<PlanYearPalBusiness> selectListWithBefore(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    
                    string query = @" SELECT  A.ORG_BUSINESS_SEQ
		                                    , A.YEARLY_YEAR
		                                    , ISNULL(D.SALES, 0) AS BEFORE_SALES
		                                    , ISNULL(D.EBIT, 0) AS BEFORE_EBIT
		                                    , CONVERT(DECIMAL(12, 2), ROUND(CASE WHEN ISNULL(D.SALES, 0) = 0 THEN 0 ELSE (D.EBIT / ISNULL(D.SALES, 0)) * 100 END, 2)) AS BEFORE_EBIT_RATE
		                                    , ISNULL(D.PBT, 0) AS BEFORE_PBT
		                                    , A.SALES
		                                    , A.EBIT
		                                    , CONVERT(DECIMAL(12, 2), ROUND(CASE WHEN ISNULL(A.SALES, 0) = 0 THEN 0 ELSE (A.EBIT / A.SALES) * 100 END, 2)) AS EBIT_RATE
		                                    , A.PBT
		                                    , A.SEQ AS PLAN_YEAR_PAL_BUSINESS_SEQ
		                                    , B.YEAR_PAL_YEAR
		                                    , C.YEAR_PAL_YEAR AS BEFORE_YEAR_PAL_YEAR
                                    FROM	PLAN_YEAR_PAL_BUSINESS	A
                                    LEFT OUTER JOIN PLAN_YEAR_PAL	B ON A.PLAN_YEAR_PAL_SEQ = B.SEQ
                                    LEFT OUTER JOIN PLAN_YEAR_PAL	C ON B.ORG_COMPANY_SEQ = C.ORG_COMPANY_SEQ AND CONVERT(VARCHAR, B.YEAR_PAL_YEAR - 1) = C.YEAR_PAL_YEAR
                                    LEFT OUTER JOIN PLAN_YEAR_PAL_BUSINESS D ON C.SEQ = D.PLAN_YEAR_PAL_SEQ AND A.ORG_BUSINESS_SEQ = D.ORG_BUSINESS_SEQ AND A.YEARLY_YEAR = D.YEARLY_YEAR
                                    WHERE	A.PLAN_YEAR_PAL_SEQ = @planYearPalSeq
                                    UNION 
                                    SELECT	A.ORG_BUSINESS_SEQ
		                                    , '99' AS YEARLY_YEAR
		                                    , SUM(ISNULL(D.SALES, 0)) AS BEFORE_SALES
		                                    , SUM(ISNULL(D.EBIT, 0)) AS BEFORE_EBIT
		                                    , CONVERT(DECIMAL(12, 2), ROUND(CASE WHEN SUM(ISNULL(D.SALES, 0)) = 0 THEN 0 ELSE (SUM((D.EBIT)) / SUM(ISNULL(D.SALES, 0))) * 100 END, 2)) AS BEFORE_EBIT_RATE
		                                    , SUM(ISNULL(D.PBT, 0)) AS BEFORE_PBT
		                                    , SUM(A.SALES) AS SALES
		                                    , SUM(A.EBIT) AS EBIT
		                                    , CONVERT(DECIMAL(12, 2), ROUND(CASE WHEN SUM(ISNULL(A.SALES, 0)) = 0 THEN 0 ELSE (SUM(A.EBIT) / SUM(A.SALES)) * 100 END, 2)) AS EBIT_RATE
		                                    , SUM(A.PBT) AS PBT
		                                    , 0 AS PLAN_YEAR_PAL_BUSINESS_SEQ
		                                    , '9999' AS MONTHLY_PAL_YEAR
		                                    , '9999' AS BEFORE_YEAR_PAL_YEAR
                                    FROM	PLAN_YEAR_PAL_BUSINESS	A
                                    LEFT OUTER JOIN PLAN_YEAR_PAL	B ON A.PLAN_YEAR_PAL_SEQ = B.SEQ
                                    LEFT OUTER JOIN PLAN_YEAR_PAL	C ON B.ORG_COMPANY_SEQ = C.ORG_COMPANY_SEQ AND CONVERT(VARCHAR, B.YEAR_PAL_YEAR - 1) = C.YEAR_PAL_YEAR
                                    LEFT OUTER JOIN PLAN_YEAR_PAL_BUSINESS D ON C.SEQ = D.PLAN_YEAR_PAL_SEQ AND A.ORG_BUSINESS_SEQ = D.ORG_BUSINESS_SEQ AND A.YEARLY_YEAR = D.YEARLY_YEAR
                                    WHERE	A.PLAN_YEAR_PAL_SEQ = @planYearPalSeq
                                    GROUP BY A.ORG_BUSINESS_SEQ";

                    return con.Query<PlanYearPalBusiness>(query, param).ToList();

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