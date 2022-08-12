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
    public class PlanYearPalBusinessSummaryRepo : DbCon, IPlanYearPalBusinessSummaryRepo
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
                    string query = " DELETE PLAN_YEAR_PAL_BUSINESS_SUMMARY " +
                        " WHERE PLAN_YEAR_PAL_SEQ = @PlanYearPalSeq";
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

        public int insert(PlanYearPalBusinessSummary entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = @" INSERT INTO PLAN_YEAR_PAL_BUSINESS_SUMMARY
(PLAN_YEAR_PAL_SEQ, YEARLY_YEAR, SALES, EBIT, PBT)
SELECT PLAN_YEAR_PAL_SEQ
        , YEARLY_YEAR
        , SUM(SALES)AS SALES
        , SUM(EBIT) AS EBIT " +
        //"--, CONVERT(DECIMAL(12, 2), ROUND(CASE WHEN SUM(EBIT) = 0 THEN 0 ELSE(SUM((EBIT)) / SUM(SALES)) * 100 END, 2)) AS EBIT_RATE " +
        @"
        , SUM(PBT) AS PBT
FROM    PLAN_YEAR_PAL_BUSINESS
WHERE   PLAN_YEAR_PAL_SEQ = @PlanYearPalSeq
GROUP BY PLAN_YEAR_PAL_SEQ, YEARLY_YEAR
--UNION
--SELECT	PLAN_YEAR_PAL_SEQ
--		, '9999' AS YEARLY_YEAR
--		, SUM(SALES) AS SALES
--		, SUM(EBIT) AS EBIT " +
       //"--, CONVERT(DECIMAL(12, 2), ROUND(CASE WHEN SUM(EBIT) = 0 THEN 0 ELSE (SUM((EBIT)) / SUM(SALES)) * 100 END, 2)) AS EBIT_RATE" +
        @", SUM(PBT) AS PBT
--FROM	PLAN_YEAR_PAL_BUSINESS
--WHERE	PLAN_YEAR_PAL_SEQ = @PlanYearPalSeq
--GROUP BY PLAN_YEAR_PAL_SEQ;
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

        public int save(PlanYearPalBusinessSummary entity)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<PlanYearPalBusinessSummary> selectList(object param)
        {

            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = "";
                    query += " SELECT YEARLY_YEAR, SALES, EBIT ";
                    query += " FROM PLAN_YEAR_PAL_BUSINESS_SUMMARY ";
                    query += " WHERE PLAN_YEAR_PAL_SEQ = @planYearPalSeq ";
                    query += "     AND YEARLY_YEAR != '9999' ";
                    query += " ORDER BY YEARLY_YEAR ASC ";

                    return con.Query<PlanYearPalBusinessSummary>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public PlanYearPalBusinessSummary selectOne(object param)
        {
            throw new NotImplementedException();
        }

        public int update(PlanYearPalBusinessSummary entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = @" UPDATE PLAN_YEAR_PAL_BUSINESS_SUMMARY SET
                                        SALES = @Sales
                                        ,EBIT = @Ebit
                                        ,PBT = @Pbt
                                      WHERE SEQ = @Seq
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

        /// <summary>
        /// 당해년도 중기손익 리스트 : 회사
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        public IEnumerable<PlanYearPalBusinessSummaryExp> selectListPnThisYear(object param)
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
        , E.IS_USE
FROM	PLAN_YEAR_PAL						A
LEFT OUTER JOIN PLAN_YEAR_PAL_BUSINESS_SUMMARY		B ON A.SEQ = B.PLAN_YEAR_PAL_SEQ
LEFT OUTER JOIN ORG_COMPANY							C ON A.ORG_COMPANY_SEQ = C.SEQ
LEFT OUTER JOIN ORG_UNION					E ON C.ORG_UNION_SEQ = E.SEQ
WHERE	1 = 1
AND		A.YEAR_PAL_YEAR = @Year
AND		B.YEARLY_YEAR != '9999'
AND     A.REGIST_STATUS = " + Define.REGIST_STATUS.GetKey("최종승인") + @"
--AND     C.SEQ NOT  IN('14','19','4')

ORDER BY C.ORG_UNION_SEQ, C.ORD";

                    return con.Query<PlanYearPalBusinessSummaryExp>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<PlanYearPalBusinessSummary> selectListWithBefore(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    
                    string query = @" 
SELECT	A.PLAN_YEAR_PAL_SEQ
		, A.YEARLY_YEAR
		, ISNULL(D.SALES, 0) AS BEFORE_SALES
		, ISNULL(D.EBIT, 0) AS BEFORE_EBIT
		, CONVERT(DECIMAL(12, 2), ROUND(CASE WHEN ISNULL(D.EBIT, 0) = 0 THEN 0 ELSE (D.EBIT / ISNULL(D.SALES, 0)) * 100 END, 2)) AS BEFORE_EBIT_RATE
		, ISNULL(D.PBT, 0) AS BEFORE_PBT
		, A.SALES
		, A.EBIT
		, CONVERT(DECIMAL(12, 2), ROUND(CASE WHEN ISNULL(A.EBIT, 0) = 0 THEN 0 ELSE (A.EBIT / A.SALES) * 100 END, 2)) AS EBIT_RATE
		, A.PBT
        , A.SEQ AS PLAN_YEAR_PAL_BUSINESS_SUMMARY_SEQ
FROM	PLAN_YEAR_PAL_BUSINESS_SUMMARY			A
LEFT OUTER JOIN PLAN_YEAR_PAL					B ON A.PLAN_YEAR_PAL_SEQ = B.SEQ
LEFT OUTER JOIN PLAN_YEAR_PAL					C ON B.ORG_COMPANY_SEQ = C.ORG_COMPANY_SEQ AND CONVERT(VARCHAR, B.YEAR_PAL_YEAR - 1) = C.YEAR_PAL_YEAR
LEFT OUTER JOIN PLAN_YEAR_PAL_BUSINESS_SUMMARY	D ON C.SEQ = D.PLAN_YEAR_PAL_SEQ
WHERE	A.PLAN_YEAR_PAL_SEQ = @PlanYearPalSeq
                        ;";

                    return con.Query<PlanYearPalBusinessSummary>(query, param).ToList();

                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<PlanYearPalBusinessSummary> selectListYear(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" 
SELECT	A.YEAR_PAL_YEAR
		, B.SEQ
		, B.YEARLY_YEAR
		, ISNULL(B.SALES, 0)				AS SALES
		, ISNULL(B.EBIT, 0)					AS EBIT
		, ISNULL(B.PBT, 0)					AS PBT
		,CASE WHEN ISNULL(SALES, 0) = 0 THEN 0 
			  WHEN ISNULL(EBIT, 0)  = 0 THEN 0
		 ELSE ISNULL(EBIT, 0) / ISNULL(SALES, 0) END AS EBIT_RATE
FROM	PLAN_YEAR_PAL		A
LEFT OUTER JOIN PLAN_YEAR_PAL_BUSINESS_SUMMARY B ON A.SEQ = B.PLAN_YEAR_PAL_SEQ
WHERE	1 = 1
AND		A.YEAR_PAL_YEAR = @YearPalYear
AND		A.ORG_COMPANY_SEQ = @OrgCompanySeq
";

                    return con.Query<PlanYearPalBusinessSummary>(query, param).ToList();
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