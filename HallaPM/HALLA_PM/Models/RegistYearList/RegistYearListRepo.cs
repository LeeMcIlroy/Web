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
    public class RegistYearListRepo : DbCon, IRegistYearListRepo
    {
        public int count(object param)
        {
            throw new NotImplementedException();
        }

        public int delete(object key)
        {
            throw new NotImplementedException();
        }

        public void Dispose()
        {
            throw new NotImplementedException();
        }

        public int insert(RegistYearList entity)
        {
            throw new NotImplementedException();
        }

        public int save(RegistYearList entity)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<RegistYearList> selectList(object param)
        {
            throw new NotImplementedException();
        }

        public RegistYearList selectOne(object param)
        {
            throw new NotImplementedException();
        }

        public int update(RegistYearList entity)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<RegistYearList> selectListPm(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    #region query
                    string query = @";WITH CTE_BS AS
(
	SELECT	*
	FROM	(
	SELECT	BS_YEAR													AS REGIST_YEAR
			, MONTHLY												AS REGIST_MONTH
			, COUNT(*)												AS TOTAL_COMPANY
			, SUM(CASE WHEN REGIST_STATUS = 7 THEN 1 ELSE 0 END)	AS REGIST_COMPANY
	FROM	(SELECT * FROM PM_BS UNION ALL  SELECT * FROM PM_BS_EX) B
	WHERE	1 = 1
	GROUP BY BS_YEAR
			, MONTHLY 
	) A
	WHERE	TOTAL_COMPANY = REGIST_COMPANY
)
, CTE_CF AS
(
	SELECT	*
	FROM	(
	SELECT	CASH_FLOW_YEAR											AS REGIST_YEAR
			, MONTHLY												AS REGIST_MONTH
			, COUNT(*)												AS TOTAL_COMPANY
			, SUM(CASE WHEN REGIST_STATUS = 7 THEN 1 ELSE 0 END)	AS REGIST_COMPANY
	FROM	PM_CASH_FLOW
	WHERE	1 = 1

	GROUP BY CASH_FLOW_YEAR
			, MONTHLY
	) A
	WHERE	TOTAL_COMPANY = REGIST_COMPANY
)
, CTE_INVEST AS
(
	SELECT	*
	FROM	(
	SELECT	INVEST_YEAR												AS REGIST_YEAR
			, MONTHLY												AS REGIST_MONTH
			, COUNT(*)												AS TOTAL_COMPANY
			, SUM(CASE WHEN REGIST_STATUS = 7 THEN 1 ELSE 0 END)	AS REGIST_COMPANY
	FROM	PM_INVEST
	WHERE	1 = 1

	GROUP BY INVEST_YEAR
			, MONTHLY
	) A
	WHERE	TOTAL_COMPANY = REGIST_COMPANY
)
, CTE_PAL AS
(
	SELECT	*
	FROM	(
	SELECT	PAL_YEAR												AS REGIST_YEAR
			, MONTHLY												AS REGIST_MONTH
			, COUNT(*)												AS TOTAL_COMPANY
			, SUM(CASE WHEN REGIST_STATUS = 7 THEN 1 ELSE 0 END)	AS REGIST_COMPANY
	FROM	PM_PAL

	WHERE	1 = 1

	GROUP BY PAL_YEAR
			, MONTHLY
	) A
	WHERE	TOTAL_COMPANY = REGIST_COMPANY
)
, CTE_Q_PAL AS
(
	SELECT	*
	FROM	(
	SELECT	QUARTER_PAL_YEAR										AS REGIST_YEAR
			, MONTHLY												AS REGIST_MONTH
			, COUNT(*)												AS TOTAL_COMPANY
			, SUM(CASE WHEN REGIST_STATUS = 7 THEN 1 ELSE 0 END)	AS REGIST_COMPANY
	FROM	PM_QUARTER_PAL
	WHERE	1 = 1
        

	GROUP BY QUARTER_PAL_YEAR
			, MONTHLY
	) A
	WHERE	TOTAL_COMPANY = REGIST_COMPANY
)
SELECT	A.SCHEDULE_YEAR					AS REGIST_YEAR
		, A.REG_MONTH					AS REGIST_MONTH
FROM	PLAN_SCHEDULE_PERFORMANCE_REG	A
INNER JOIN CTE_BS						B ON A.SCHEDULE_YEAR = B.REGIST_YEAR AND A.REG_MONTH = B.REGIST_MONTH
INNER JOIN CTE_CF						C ON A.SCHEDULE_YEAR = C.REGIST_YEAR AND A.REG_MONTH = C.REGIST_MONTH
INNER JOIN CTE_INVEST					D ON A.SCHEDULE_YEAR = D.REGIST_YEAR AND A.REG_MONTH = D.REGIST_MONTH
INNER JOIN CTE_PAL						E ON A.SCHEDULE_YEAR = E.REGIST_YEAR AND A.REG_MONTH = E.REGIST_MONTH
INNER JOIN CTE_Q_PAL					F ON A.SCHEDULE_YEAR = F.REGIST_YEAR AND A.REG_MONTH = F.REGIST_MONTH
WHERE	1 = 1
AND		A.SCHEDULE_YEAR >= '2018'
ORDER BY A.SCHEDULE_YEAR, B.REGIST_MONTH
";
                    //>= '2018
                    //                    string query = @"
                    //;WITH CTE_BS AS
                    //(
                    //	SELECT	*
                    //	FROM	(
                    //	SELECT	BS_YEAR													AS REGIST_YEAR
                    //			, MONTHLY												AS REGIST_MONTH
                    //			, COUNT(*)												AS TOTAL_COMPANY
                    //			, SUM(CASE WHEN REGIST_STATUS = 7 THEN 1 ELSE 0 END)	AS REGIST_COMPANY
                    //	FROM	(SELECT * FROM PM_BS UNION ALL  SELECT * FROM PM_BS_EX) B
                    //	WHERE	1 = 1
                    //	GROUP BY BS_YEAR
                    //			, MONTHLY 
                    //	) A
                    //	WHERE	TOTAL_COMPANY = REGIST_COMPANY
                    //)
                    //, CTE_CF AS
                    //(
                    //	SELECT	*
                    //	FROM	(
                    //	SELECT	CASH_FLOW_YEAR											AS REGIST_YEAR
                    //			, MONTHLY												AS REGIST_MONTH
                    //			, COUNT(*)												AS TOTAL_COMPANY
                    //			, SUM(CASE WHEN REGIST_STATUS = 7 THEN 1 ELSE 0 END)	AS REGIST_COMPANY
                    //	FROM	PM_CASH_FLOW
                    //	WHERE	1 = 1
                    //	GROUP BY CASH_FLOW_YEAR
                    //			, MONTHLY
                    //	) A
                    //	WHERE	TOTAL_COMPANY = REGIST_COMPANY
                    //)
                    //, CTE_INVEST AS
                    //(
                    //	SELECT	*
                    //	FROM	(
                    //	SELECT	INVEST_YEAR												AS REGIST_YEAR
                    //			, MONTHLY												AS REGIST_MONTH
                    //			, COUNT(*)												AS TOTAL_COMPANY
                    //			, SUM(CASE WHEN REGIST_STATUS = 7 THEN 1 ELSE 0 END)	AS REGIST_COMPANY
                    //	FROM	PM_INVEST
                    //	WHERE	1 = 1
                    //	GROUP BY INVEST_YEAR
                    //			, MONTHLY
                    //	) A
                    //	WHERE	TOTAL_COMPANY = REGIST_COMPANY
                    //)
                    //, CTE_PAL AS
                    //(
                    //	SELECT	*
                    //	FROM	(
                    //	SELECT	PAL_YEAR												AS REGIST_YEAR
                    //			, MONTHLY												AS REGIST_MONTH
                    //			, COUNT(*)												AS TOTAL_COMPANY
                    //			, SUM(CASE WHEN REGIST_STATUS = 7 THEN 1 ELSE 0 END)	AS REGIST_COMPANY
                    //	FROM	PM_PAL
                    //	WHERE	1 = 1
                    //	GROUP BY PAL_YEAR
                    //			, MONTHLY
                    //	) A
                    //	WHERE	TOTAL_COMPANY = REGIST_COMPANY
                    //)
                    //, CTE_Q_PAL AS
                    //(
                    //	SELECT	*
                    //	FROM	(
                    //	SELECT	QUARTER_PAL_YEAR										AS REGIST_YEAR
                    //			, MONTHLY												AS REGIST_MONTH
                    //			, COUNT(*)												AS TOTAL_COMPANY
                    //			, SUM(CASE WHEN REGIST_STATUS = 7 THEN 1 ELSE 0 END)	AS REGIST_COMPANY
                    //	FROM	PM_QUARTER_PAL
                    //	WHERE	1 = 1
                    //	GROUP BY QUARTER_PAL_YEAR
                    //			, MONTHLY
                    //	) A
                    //	WHERE	TOTAL_COMPANY = REGIST_COMPANY
                    //)
                    //SELECT	A.SCHEDULE_YEAR					AS REGIST_YEAR
                    //		, A.REG_MONTH					AS REGIST_MONTH
                    //FROM	PLAN_SCHEDULE_PERFORMANCE_REG	A
                    //INNER JOIN CTE_BS						B ON A.SCHEDULE_YEAR = B.REGIST_YEAR AND A.REG_MONTH = B.REGIST_MONTH
                    //INNER JOIN CTE_CF						C ON A.SCHEDULE_YEAR = C.REGIST_YEAR AND A.REG_MONTH = C.REGIST_MONTH
                    //INNER JOIN CTE_INVEST					D ON A.SCHEDULE_YEAR = D.REGIST_YEAR AND A.REG_MONTH = D.REGIST_MONTH
                    //INNER JOIN CTE_PAL						E ON A.SCHEDULE_YEAR = E.REGIST_YEAR AND A.REG_MONTH = E.REGIST_MONTH
                    //INNER JOIN CTE_Q_PAL					F ON A.SCHEDULE_YEAR = F.REGIST_YEAR AND A.REG_MONTH = F.REGIST_MONTH
                    //WHERE	1 = 1
                    //AND		A.SCHEDULE_YEAR >= '2018'
                    //ORDER BY A.SCHEDULE_YEAR, B.REGIST_MONTH
                    //";
                    #endregion

                    return con.Query<RegistYearList>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.ReportErrorLog(e.ToString());
                    return null;
                }
            }
        }
        public IEnumerable<RegistYearList> selectListDisclosure(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    #region query
                    string query = @"
                                    SELECT  A.YEAR  AS REGIST_YEAR
                                          , A.MONTH AS REGIST_MONTH
                                    

                                          
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
                                     
                                              
                                    GROUP BY A.YEAR, A.MONTH
                                    ORDER BY A.YEAR DESC , A.MONTH DESC        
                                    ";
                    #endregion

                    return con.Query<RegistYearList>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.ReportErrorLog(e.ToString());
                    return null;
                }
            }
        }
        public IEnumerable<RegistYearList> selectListPlan(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    #region query
                    string query = @"

;WITH CTE_PAL AS
(
	SELECT	*
	FROM	(
	SELECT	MONTHLY_PAL_YEAR										AS REGIST_YEAR
			, COUNT(*)												AS TOTAL_COMPANY
			, SUM(CASE WHEN REGIST_STATUS = 7 THEN 1 ELSE 0 END)	AS REGIST_COMPANY
	FROM	PLAN_MONTHLY_PAL
	GROUP BY MONTHLY_PAL_YEAR
	) A
	WHERE	TOTAL_COMPANY = REGIST_COMPANY
), CTE_YEAR_BS AS
(
	SELECT	*
	FROM	(
	SELECT	YEAR_BS_YEAR											AS REGIST_YEAR
			, COUNT(*)												AS TOTAL_COMPANY
			, SUM(CASE WHEN REGIST_STATUS = 7 THEN 1 ELSE 0 END)	AS REGIST_COMPANY
	FROM	PLAN_YEAR_BS
	GROUP BY YEAR_BS_YEAR
	) A
	WHERE	TOTAL_COMPANY = REGIST_COMPANY
), CTE_YEAR_CF AS
(
	SELECT	*
	FROM	(
	SELECT	YEAR_CF_YEAR											AS REGIST_YEAR
			, COUNT(*)												AS TOTAL_COMPANY
			, SUM(CASE WHEN REGIST_STATUS = 7 THEN 1 ELSE 0 END)	AS REGIST_COMPANY
	FROM	PLAN_YEAR_CF
	GROUP BY YEAR_CF_YEAR
	) A
	WHERE	TOTAL_COMPANY = REGIST_COMPANY
), CTE_YEAR_INVEST AS
(
	SELECT	*
	FROM	(
	SELECT	YEAR_INVEST_YEAR											AS REGIST_YEAR
			, COUNT(*)												AS TOTAL_COMPANY
			, SUM(CASE WHEN REGIST_STATUS = 7 THEN 1 ELSE 0 END)	AS REGIST_COMPANY
	FROM	PLAN_YEAR_INVEST
	GROUP BY YEAR_INVEST_YEAR
	) A
	WHERE	TOTAL_COMPANY = REGIST_COMPANY
), CTE_YEAR_PAL AS
(
	SELECT	*
	FROM	(
	SELECT	YEAR_PAL_YEAR											AS REGIST_YEAR
			, COUNT(*)												AS TOTAL_COMPANY
			, SUM(CASE WHEN REGIST_STATUS = 7 THEN 1 ELSE 0 END)	AS REGIST_COMPANY
	FROM	PLAN_YEAR_PAL
	GROUP BY YEAR_PAL_YEAR
	) A
	WHERE	TOTAL_COMPANY = REGIST_COMPANY
)
SELECT	A.SCHEDULE_YEAR				AS REGIST_YEAR
FROM	PLAN_SCHEDULE				A
INNER JOIN CTE_PAL					B ON A.SCHEDULE_YEAR = B.REGIST_YEAR
INNER JOIN CTE_YEAR_PAL				C ON A.SCHEDULE_YEAR = C.REGIST_YEAR
INNER JOIN CTE_YEAR_BS				D ON A.SCHEDULE_YEAR = D.REGIST_YEAR
INNER JOIN CTE_YEAR_CF				E ON A.SCHEDULE_YEAR = E.REGIST_YEAR
INNER JOIN CTE_YEAR_INVEST			F ON A.SCHEDULE_YEAR = F.REGIST_YEAR
ORDER BY REGIST_YEAR DESC
";
                    #endregion

                    return con.Query<RegistYearList>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.ReportErrorLog(e.ToString());
                    return null;
                }
            }
        }
    }
}