using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Data;
using Dapper;
using HALLA_PM.Util;

namespace HALLA_PM.Models
{
    public class PmGroupRepo : DbCon, IPmGroupRepo
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
                    string query = @"
; WITH CTE_CASH_FLOW AS
(
	SELECT	PM_YEAR
			, MONTHLY
			, 'CF'					AS MENU_NAME
			, 'PM_CASH_FLOW'			AS TABLE_NAME
			, CASE WHEN TOTAL_COMPANY = REGIST_COMPANY THEN 'Y' ELSE 'N' END AS REGIST_TYPE
	FROM	(
		SELECT	CASH_FLOW_YEAR			AS PM_YEAR
				, MONTHLY				AS MONTHLY
				, COUNT(*)				AS TOTAL_COMPANY
				, SUM(CASE WHEN REGIST_STATUS != 1 THEN 1 ELSE 0 END) AS REGIST_COMPANY
		FROM	PM_CASH_FLOW
		GROUP BY CASH_FLOW_YEAR, MONTHLY
	)		A
), CTE_PAL AS
(
	SELECT	PM_YEAR
			, MONTHLY
			, '손익'					AS MENU_NAME
			, 'PM_PAL'					AS TABLE_NAME
			, CASE WHEN TOTAL_COMPANY = REGIST_COMPANY THEN 'Y' ELSE 'N' END AS REGIST_TYPE
	FROM	(
		SELECT	PAL_YEAR				AS PM_YEAR
				, MONTHLY				AS MONTHLY
				, COUNT(*)				AS TOTAL_COMPANY
				, SUM(CASE WHEN REGIST_STATUS != 1 THEN 1 ELSE 0 END) AS REGIST_COMPANY
		FROM	PM_PAL
		GROUP BY PAL_YEAR, MONTHLY
	)		A
), CTE_QUARTER_PAL AS
(
	SELECT	PM_YEAR
			, MONTHLY
			, '분기별손익'				AS MENU_NAME
			, 'PM_QUARTER_PAL'			AS TABLE_NAME
			, CASE WHEN TOTAL_COMPANY = REGIST_COMPANY THEN 'Y' ELSE 'N' END AS REGIST_TYPE
	FROM	(
		SELECT	QUARTER_PAL_YEAR		AS PM_YEAR
				, MONTHLY				AS MONTHLY
				, COUNT(*)				AS TOTAL_COMPANY
				, SUM(CASE WHEN REGIST_STATUS != 1 THEN 1 ELSE 0 END) AS REGIST_COMPANY
		FROM	PM_QUARTER_PAL
		GROUP BY QUARTER_PAL_YEAR, MONTHLY
	)		A
), CTE_BS AS
(
	SELECT	PM_YEAR
			, MONTHLY
			, 'BS'						AS MENU_NAME
			, 'PM_BS'					AS TABLE_NAME
			, CASE WHEN TOTAL_COMPANY = REGIST_COMPANY THEN 'Y' ELSE 'N' END AS REGIST_TYPE
	FROM	(
		SELECT	BS_YEAR					AS PM_YEAR
				, MONTHLY				AS MONTHLY
				, COUNT(*)				AS TOTAL_COMPANY
				, SUM(CASE WHEN REGIST_STATUS != 1 THEN 1 ELSE 0 END) AS REGIST_COMPANY
		FROM	PM_BS
		GROUP BY BS_YEAR, MONTHLY
	)		A
), CTE_INVEST AS
(
	SELECT	PM_YEAR
			, MONTHLY
			, '투자,인원'					AS MENU_NAME
			, 'PM_INVEST'					AS TABLE_NAME
			, CASE WHEN TOTAL_COMPANY = REGIST_COMPANY THEN 'Y' ELSE 'N' END AS REGIST_TYPE
	FROM	(
		SELECT	INVEST_YEAR				AS PM_YEAR
				, MONTHLY				AS MONTHLY
				, COUNT(*)				AS TOTAL_COMPANY
				, SUM(CASE WHEN REGIST_STATUS != 1 THEN 1 ELSE 0 END) AS REGIST_COMPANY
		FROM	PM_INVEST
		GROUP BY INVEST_YEAR, MONTHLY
	)		A
)
SELECT	COUNT(*) AS CNT
FROM	(
	SELECT	*
	FROM	CTE_CASH_FLOW
	UNION ALL
	SELECT	*
	FROM	CTE_PAL
	UNION ALL
	SELECT	*
	FROM	CTE_QUARTER_PAL
	UNION ALL
	SELECT	*
	FROM	CTE_BS
	UNION ALL
	SELECT	*
	FROM	CTE_INVEST
)				A
INNER JOIN PLAN_SCHEDULE B ON A.PM_YEAR = B.SCHEDULE_YEAR 
INNER JOIN PLAN_SCHEDULE_PERFORMANCE_REG H ON A.PM_YEAR = H.SCHEDULE_YEAR  AND A.MONTHLY = H.REG_MONTH
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
        public int delete(object key)
        {
            throw new NotImplementedException();
        }

        public void Dispose()
        {
            throw new NotImplementedException();
        }

        public int insert(PmGroup entity)
        {
            throw new NotImplementedException();
        }

        public int save(PmGroup entity)
        {
            throw new NotImplementedException();
        }

        /// <summary>
        /// 실적등록 리스트(최종등록완료)
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        public IEnumerable<PmGroup> selectListRegist(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string where = " WHERE 1 = 1 ";

                    string query = @"

;WITH CTE_COMPANY AS
(
	SELECT	*
	FROM	ORG_COMPANY
	WHERE	1 = 1
	AND		IS_USE = 'Y'
), CTE_CASH_FLOW AS
(
	SELECT	CASH_FLOW_YEAR		AS PM_YEAR
			, MONTHLY			AS MONTHLY
			, ORG_COMPANY_SEQ
			, CREATE_DATE
	FROM	PM_CASH_FLOW
	WHERE	1 = 1
	AND		REGIST_STATUS = 7
), CTE_BS AS
(
	SELECT	BS_YEAR				AS PM_YEAR
			, MONTHLY			AS MONTHLY
			, ORG_COMPANY_SEQ
			, CREATE_DATE
	FROM	PM_BS
	WHERE	1 = 1
	AND		REGIST_STATUS = 7
), CTE_INVEST AS
(
	SELECT	INVEST_YEAR			AS PM_YEAR
			, MONTHLY			AS MONTHLY
			, ORG_COMPANY_SEQ
			, CREATE_DATE
	FROM	PM_INVEST
	WHERE	1 = 1
	AND		REGIST_STATUS = 7
), CTE_PAL AS
(
	SELECT	PAL_YEAR			AS PM_YEAR
			, MONTHLY			AS MONTHLY
			, ORG_COMPANY_SEQ
			, CREATE_DATE
	FROM	PM_PAL
	WHERE	1 = 1
	AND		REGIST_STATUS = 7
), CTE_QUARTER_PAL AS
(
	SELECT	QUARTER_PAL_YEAR	AS PM_YEAR
			, MONTHLY			AS MONTHLY
			, ORG_COMPANY_SEQ
			, CREATE_DATE
	FROM	PM_QUARTER_PAL
	WHERE	1 = 1
	AND		REGIST_STATUS = 7
), CTE_LIST AS (
	SELECT	ROW_NUMBER() OVER (PARTITION BY PM_YEAR, MONTHLY, ORG_COMPANY_SEQ ORDER BY PM_YEAR , MONTHLY, ORG_COMPANY_SEQ, CREATE_DATE ) AS ROW_NUM, *
	FROM	(
		SELECT	*
		FROM	CTE_BS
		UNION
		SELECT	*
		FROM	CTE_CASH_FLOW
		UNION
		SELECT	*
		FROM	CTE_INVEST
		UNION
		SELECT	*
		FROM	CTE_PAL
		UNION
		SELECT	*
		FROM	CTE_QUARTER_PAL
	)			A
)
SELECT	A.*, B.COMPANY_NAME
FROM	CTE_LIST		A
--LEFT OUTER JOIN ORG_COMPANY		B ON A.ORG_COMPANY_SEQ = B.SEQ
INNER JOIN CTE_COMPANY		B ON A.ORG_COMPANY_SEQ = B.SEQ
WHERE	1 = 1
AND		ROW_NUM = 5
ORDER BY PM_YEAR DESC, MONTHLY DESC, CREATE_DATE DESC
";
                    return con.Query<PmGroup>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<PmGroup> selectList(object param)
        {
            Search search = (Search)param;
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string where = @" WHERE 1 = 1 ";
                     if (!string.IsNullOrEmpty(search.searchYear))
                    {
                        where += " AND A.PM_YEAR = @searchYear ";
                    }

                    if (!string.IsNullOrEmpty(search.searchMonth))
                    {
                        where += " AND A.MONTHLY = @searchMonth ";
                    }

                    if (!string.IsNullOrEmpty(search.searchBusType))
                    {
                        where += " AND A.MENU_NAME = @searchBusType ";
                    }

                    where += @" AND B.APPLY_CHK = 'Y' 
AND H.REG_DT_START <= CONVERT(CHAR(10), GETDATE(), 121) -- 현재 일자보다 등록 예정일이 작은 것들만 보여준다.
";

                    string query = @"
; WITH CTE_CASH_FLOW AS
(
	SELECT	PM_YEAR
			, MONTHLY
			, 'CF'					AS MENU_NAME
			, 'PM_CASH_FLOW'			AS TABLE_NAME
			, CASE WHEN TOTAL_COMPANY = REGIST_COMPANY THEN 'Y' ELSE 'N' END AS REGIST_TYPE
            , CASE WHEN TOTAL_COMPANY = FINISH_COMPANY THEN 'Y' ELSE 'N' END AS FINISH_TYPE
	FROM	(
		SELECT	CASH_FLOW_YEAR			AS PM_YEAR
				, MONTHLY				AS MONTHLY
				, COUNT(*)				AS TOTAL_COMPANY
				, SUM(CASE WHEN REGIST_STATUS != 1 THEN 1 ELSE 0 END) AS REGIST_COMPANY
                , SUM(CASE WHEN REGIST_STATUS = 7 THEN 1 ELSE 0 END) AS FINISH_COMPANY
		FROM	PM_CASH_FLOW
		GROUP BY CASH_FLOW_YEAR, MONTHLY
	)		A
), CTE_PAL AS
(
	SELECT	PM_YEAR
			, MONTHLY
			, '손익'					AS MENU_NAME
			, 'PM_PAL'					AS TABLE_NAME
			, CASE WHEN TOTAL_COMPANY = REGIST_COMPANY THEN 'Y' ELSE 'N' END AS REGIST_TYPE
            , CASE WHEN TOTAL_COMPANY = FINISH_COMPANY THEN 'Y' ELSE 'N' END AS FINISH_TYPE
	FROM	(
		SELECT	PAL_YEAR				AS PM_YEAR
				, MONTHLY				AS MONTHLY
				, COUNT(*)				AS TOTAL_COMPANY
				, SUM(CASE WHEN REGIST_STATUS != 1 THEN 1 ELSE 0 END) AS REGIST_COMPANY
                 , SUM(CASE WHEN REGIST_STATUS = 7 THEN 1 ELSE 0 END) AS FINISH_COMPANY
		FROM	PM_PAL
		GROUP BY PAL_YEAR, MONTHLY
	)		A
), CTE_QUARTER_PAL AS
(
	SELECT	PM_YEAR
			, MONTHLY
			, '분기별손익'				AS MENU_NAME
			, 'PM_QUARTER_PAL'			AS TABLE_NAME
			, CASE WHEN TOTAL_COMPANY = REGIST_COMPANY THEN 'Y' ELSE 'N' END AS REGIST_TYPE
            , CASE WHEN TOTAL_COMPANY = FINISH_COMPANY THEN 'Y' ELSE 'N' END AS FINISH_TYPE
	FROM	(
		SELECT	QUARTER_PAL_YEAR		AS PM_YEAR
				, MONTHLY				AS MONTHLY
				, COUNT(*)				AS TOTAL_COMPANY
				, SUM(CASE WHEN REGIST_STATUS != 1 THEN 1 ELSE 0 END) AS REGIST_COMPANY
                 , SUM(CASE WHEN REGIST_STATUS = 7 THEN 1 ELSE 0 END) AS FINISH_COMPANY
		FROM	PM_QUARTER_PAL
		GROUP BY QUARTER_PAL_YEAR, MONTHLY
	)		A
), CTE_BS AS
(
	SELECT	PM_YEAR
			, MONTHLY
			, 'BS'						AS MENU_NAME
			, 'PM_BS'					AS TABLE_NAME
			, CASE WHEN TOTAL_COMPANY = REGIST_COMPANY THEN 'Y' ELSE 'N' END AS REGIST_TYPE
            , CASE WHEN TOTAL_COMPANY = FINISH_COMPANY THEN 'Y' ELSE 'N' END AS FINISH_TYPE
	FROM	(
		SELECT	BS_YEAR					AS PM_YEAR
				, MONTHLY				AS MONTHLY
				, COUNT(*)				AS TOTAL_COMPANY
				, SUM(CASE WHEN REGIST_STATUS != 1 THEN 1 ELSE 0 END) AS REGIST_COMPANY
                , SUM(CASE WHEN REGIST_STATUS = 7 THEN 1 ELSE 0 END) AS FINISH_COMPANY
		FROM	PM_BS
		GROUP BY BS_YEAR, MONTHLY
	)		A
), CTE_INVEST AS
(
	SELECT	PM_YEAR
			, MONTHLY
			, '투자,인원'					AS MENU_NAME
			, 'PM_INVEST'					AS TABLE_NAME
			, CASE WHEN TOTAL_COMPANY = REGIST_COMPANY THEN 'Y' ELSE 'N' END AS REGIST_TYPE
            , CASE WHEN TOTAL_COMPANY = FINISH_COMPANY THEN 'Y' ELSE 'N' END AS FINISH_TYPE
	FROM	(
		SELECT	INVEST_YEAR				AS PM_YEAR
				, MONTHLY				AS MONTHLY
				, COUNT(*)				AS TOTAL_COMPANY
				, SUM(CASE WHEN REGIST_STATUS != 1 THEN 1 ELSE 0 END) AS REGIST_COMPANY
                , SUM(CASE WHEN REGIST_STATUS = 7 THEN 1 ELSE 0 END) AS FINISH_COMPANY
		FROM	PM_INVEST
		GROUP BY INVEST_YEAR, MONTHLY
	)		A
)
SELECT	ROW_NUMBER() OVER (ORDER BY PM_YEAR ASC, MONTHLY, MENU_NAME ASC) AS ROW_NUM, A.*
FROM	(
	SELECT	*
	FROM	CTE_CASH_FLOW
	UNION ALL
	SELECT	*
	FROM	CTE_PAL
	UNION ALL
	SELECT	*
	FROM	CTE_QUARTER_PAL
	UNION ALL
	SELECT	*
	FROM	CTE_BS
	UNION ALL
	SELECT	*
	FROM	CTE_INVEST
)				A
INNER JOIN PLAN_SCHEDULE B ON A.PM_YEAR = B.SCHEDULE_YEAR 
INNER JOIN PLAN_SCHEDULE_PERFORMANCE_REG H ON A.PM_YEAR = H.SCHEDULE_YEAR  AND A.MONTHLY = H.REG_MONTH
" + where + @"
ORDER BY PM_YEAR DESC, MONTHLY DESC, MENU_NAME DESC
OFFSET @PageCount * (@PageIndex -1)  ROWS FETCH NEXT @PageCount ROW ONLY
";

                    search.TotalCount = count(search, where);
                    search.MakePaging();

                    return con.Query<PmGroup>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }


        public IEnumerable<PmGroup> selectListAll(object param)
        {
            //Search search = (Search)param;
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string where = " WHERE 1 = 1 ";

                    string query = @"
; WITH CTE_CASH_FLOW AS
(
	SELECT	PM_YEAR
			, MONTHLY
			, 'CF'					AS MENU_NAME
			, 'PM_CASH_FLOW'			AS TABLE_NAME
			, CASE WHEN TOTAL_COMPANY = REGIST_COMPANY THEN 'Y' ELSE 'N' END AS REGIST_TYPE
            , CASE WHEN TOTAL_COMPANY = FINISH_COMPANY THEN 'Y' ELSE 'N' END AS FINISH_TYPE
	FROM	(
		SELECT	CASH_FLOW_YEAR			AS PM_YEAR
				, MONTHLY				AS MONTHLY
				, COUNT(*)				AS TOTAL_COMPANY
				, SUM(CASE WHEN REGIST_STATUS != 1 THEN 1 ELSE 0 END) AS REGIST_COMPANY
                , SUM(CASE WHEN REGIST_STATUS = 7 THEN 1 ELSE 0 END) AS FINISH_COMPANY
		FROM	PM_CASH_FLOW
		GROUP BY CASH_FLOW_YEAR, MONTHLY
	)		A
), CTE_PAL AS
(
	SELECT	PM_YEAR
			, MONTHLY
			, '손익'					AS MENU_NAME
			, 'PM_PAL'					AS TABLE_NAME
			, CASE WHEN TOTAL_COMPANY = REGIST_COMPANY THEN 'Y' ELSE 'N' END AS REGIST_TYPE
            , CASE WHEN TOTAL_COMPANY = FINISH_COMPANY THEN 'Y' ELSE 'N' END AS FINISH_TYPE
	FROM	(
		SELECT	PAL_YEAR				AS PM_YEAR
				, MONTHLY				AS MONTHLY
				, COUNT(*)				AS TOTAL_COMPANY
				, SUM(CASE WHEN REGIST_STATUS != 1 THEN 1 ELSE 0 END) AS REGIST_COMPANY
                , SUM(CASE WHEN REGIST_STATUS = 7 THEN 1 ELSE 0 END) AS FINISH_COMPANY
		FROM	PM_PAL
		GROUP BY PAL_YEAR, MONTHLY
	)		A
), CTE_QUARTER_PAL AS
(
	SELECT	PM_YEAR
			, MONTHLY
			, '분기별손익'				AS MENU_NAME
			, 'PM_QUARTER_PAL'			AS TABLE_NAME
			, CASE WHEN TOTAL_COMPANY = REGIST_COMPANY THEN 'Y' ELSE 'N' END AS REGIST_TYPE
            , CASE WHEN TOTAL_COMPANY = FINISH_COMPANY THEN 'Y' ELSE 'N' END AS FINISH_TYPE
	FROM	(
		SELECT	QUARTER_PAL_YEAR		AS PM_YEAR
				, MONTHLY				AS MONTHLY
				, COUNT(*)				AS TOTAL_COMPANY
				, SUM(CASE WHEN REGIST_STATUS != 1 THEN 1 ELSE 0 END) AS REGIST_COMPANY
                , SUM(CASE WHEN REGIST_STATUS = 7 THEN 1 ELSE 0 END) AS FINISH_COMPANY
		FROM	PM_QUARTER_PAL
		GROUP BY QUARTER_PAL_YEAR, MONTHLY
	)		A
), CTE_BS AS
(
	SELECT	PM_YEAR
			, MONTHLY
			, 'BS'						AS MENU_NAME
			, 'PM_BS'					AS TABLE_NAME
			, CASE WHEN TOTAL_COMPANY = REGIST_COMPANY THEN 'Y' ELSE 'N' END AS REGIST_TYPE
            , CASE WHEN TOTAL_COMPANY = FINISH_COMPANY THEN 'Y' ELSE 'N' END AS FINISH_TYPE
	FROM	(
		SELECT	BS_YEAR					AS PM_YEAR
				, MONTHLY				AS MONTHLY
				, COUNT(*)				AS TOTAL_COMPANY
				, SUM(CASE WHEN REGIST_STATUS != 1 THEN 1 ELSE 0 END) AS REGIST_COMPANY
                , SUM(CASE WHEN REGIST_STATUS = 7 THEN 1 ELSE 0 END) AS FINISH_COMPANY
		FROM	PM_BS
		GROUP BY BS_YEAR, MONTHLY
	)		A
), CTE_INVEST AS
(
	SELECT	PM_YEAR
			, MONTHLY
			, '투자,인원'					AS MENU_NAME
			, 'PM_INVEST'					AS TABLE_NAME
			, CASE WHEN TOTAL_COMPANY = REGIST_COMPANY THEN 'Y' ELSE 'N' END AS REGIST_TYPE
            , CASE WHEN TOTAL_COMPANY = FINISH_COMPANY THEN 'Y' ELSE 'N' END AS FINISH_TYPE
	FROM	(
		SELECT	INVEST_YEAR				AS PM_YEAR
				, MONTHLY				AS MONTHLY
				, COUNT(*)				AS TOTAL_COMPANY
				, SUM(CASE WHEN REGIST_STATUS != 1 THEN 1 ELSE 0 END) AS REGIST_COMPANY
                , SUM(CASE WHEN REGIST_STATUS = 7 THEN 1 ELSE 0 END) AS FINISH_COMPANY
		FROM	PM_INVEST
		GROUP BY INVEST_YEAR, MONTHLY
	)		A
)
SELECT	*
FROM	(
	SELECT	*
	FROM	CTE_CASH_FLOW
	UNION ALL
	SELECT	*
	FROM	CTE_PAL
	UNION ALL
	SELECT	*
	FROM	CTE_QUARTER_PAL
	UNION ALL
	SELECT	*
	FROM	CTE_BS
	UNION ALL
	SELECT	*
	FROM	CTE_INVEST
)				A " + where + @"
ORDER BY PM_YEAR DESC, MONTHLY DESC, MENU_NAME DESC
";

                    //search.TotalCount = count(search, where);
                    //search.MakePaging();

                    return con.Query<PmGroup>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public PmGroup selectOne(object param)
        {
            throw new NotImplementedException();
        }

        public int update(PmGroup entity)
        {
            throw new NotImplementedException();
        }
    }
}