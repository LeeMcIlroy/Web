using Dapper;
using HALLA_PM.Core;
using HALLA_PM.Util;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class PmInvestSumRepo : DbCon, IPmInvestSumRepo
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
                    string query =  " DELETE PM_INVEST_SUM " +
                                    " WHERE PM_INVEST_SEQ = @pmInvestSeq";
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

        public int insert(PmInvestSum entity)
        {

            using (IDbConnection con = GetHallaDb())
            {
                con.Open();
                try
                {
                    string query = "INSERT INTO PM_INVEST_SUM( " +
                                                        " PM_INVEST_SEQ, " +
                                                        " MONTHLY_TYPE, " +
                                                        " INVESTMENT, " +
                                                        " PERSONNEL, " +
                                                        " DOMESTIC_PERSONNEL, " +
                                                        " OVERSEAS_PERSONNEL " +
                                                    " ) VALUES ( " +
                                                            " @pmInvestSeq," +
                                                            " @monthlyType," +
                                                            " @investment," +
                                                            " @personnel," +
                                                            " @domesticPersonnel," +
                                                            " @overseasPersonnel" +
                                                    "); SELECT CAST(SCOPE_IDENTITY() as int)";
                    return con.Query<int>(@query, entity).First();
                }
                catch (Exception e)
                {
                    LogUtil.Error(e.ToString());
                    return -1;
                }
            }
        }
        public int insertCum(PmInvestSum entity)
        {

            using (IDbConnection con = GetHallaDb())
            {
                con.Open();
                try
                {
                    string query = @"
INSERT INTO PM_INVEST_SUM
( PM_INVEST_SEQ, MONTHLY_TYPE, INVESTMENT, PERSONNEL, DOMESTIC_PERSONNEL, OVERSEAS_PERSONNEL )
SELECT	PM_INVEST_SEQ
		, MONTHLY_TYPE
		, SUM(ISNULL(INVESTMENT, 0)) AS INVESTMENT
		, SUM(ISNULL(PERSONNEL, 0)) AS PERSONNEL
		, SUM(ISNULL(DOMESTIC_PERSONNEL, 0)) AS DOMESTIC_PERSONNEL
		, SUM(ISNULL(OVERSEAS_PERSONNEL, 0)) AS OVERSEAS_PERSONNEL
FROM	PM_INVEST_BUSINESS
WHERE	1 = 1
AND		PM_INVEST_SEQ = @pmInvestSeq
GROUP BY PM_INVEST_SEQ, MONTHLY_TYPE 
SELECT @@ROWCOUNT
--SELECT CAST(SCOPE_IDENTITY() as int)";
                    return con.Query<int>(@query, entity).First();
                }
                catch (Exception e)
                {
                    LogUtil.Error(e.ToString());
                    return -1;
                }
            }
        }

        public int save(PmInvestSum entity)
        {
            throw new NotImplementedException();
        }
        public int saveByPmInvest(PmInvestSum entity)
        {
            var item = this.selectOneByPmInvest(entity);
            if (item == null)
            {
                return this.insert(entity);
            }
            else
            {
                entity.Seq = item.Seq;
                return this.update(entity);
            }
        }
        public IEnumerable<PmInvestSum> selectList(object param)
        {
            {
                using (IDbConnection con = GetHallaDb())
                {
                    try
                    {
                        con.Open();

                        string query = " SELECT * " +
                            " FROM PM_INVEST_SUM " +
                            " WHERE PM_INVEST_SEQ = @PmInvestSeq ";

                        return con.Query<PmInvestSum>(query, param).ToList();
                    }
                    catch (Exception e)
                    {
                        LogUtil.MngError(e.ToString());
                        return null;
                    }
                }
            }
        }

        public IEnumerable<PmInvestSum> selectListYear(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
SELECT	*
FROM	PM_INVEST					A
LEFT OUTER JOIN PM_INVEST_SUM	B ON A.SEQ = B.PM_INVEST_SEQ
WHERE	1 = 1
AND		A.INVEST_YEAR = @InvestYear - 1
--AND		A.ORG_COMPANY_SEQ = @OrgCompanySeq
";
                    return con.Query<PmInvestSum>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        /// <summary>
        /// 전년실적 연간 회사
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        public IEnumerable<PmInvestSum> selectListPmLastYear(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
-- 전년실적 : 연간
SELECT	A.INVEST_YEAR
		, A.MONTHLY
		, B.MONTHLY_TYPE
		, ISNULL(B.INVESTMENT, 0)				AS INVESTMENT
		, ISNULL(B.PERSONNEL, 0)				AS PERSONNEL
		, ISNULL(B.DOMESTIC_PERSONNEL, 0)		AS DOMESTIC_PERSONNEL
		, ISNULL(B.OVERSEAS_PERSONNEL, 0)		AS OVERSEAS_PERSONNEL
		, C.ORG_UNION_SEQ
		, E.UNION_NAME
		, A.ORG_COMPANY_SEQ
		, C.COMPANY_NAME
FROM	PM_INVEST										A
LEFT OUTER JOIN PM_INVEST_SUM						B ON A.SEQ = B.PM_INVEST_SEQ
LEFT OUTER JOIN ORG_COMPANY					C ON A.ORG_COMPANY_SEQ = C.SEQ
LEFT OUTER JOIN ORG_UNION					E ON C.ORG_UNION_SEQ = E.SEQ
WHERE	1 = 1
AND		A.INVEST_YEAR = @year -1
AND     A.REGIST_STATUS = " + Define.REGIST_STATUS.GetKey("최종승인");

                    return con.Query<PmInvestSum>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<PmInvestSum> selectListPmThisYear(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
-- 실적 : 연간
SELECT	A.INVEST_YEAR
		, A.MONTHLY
		, B.MONTHLY_TYPE
		, ISNULL(B.INVESTMENT, 0)				AS INVESTMENT
		, ISNULL(B.PERSONNEL, 0)				AS PERSONNEL
		, ISNULL(B.DOMESTIC_PERSONNEL, 0)		AS DOMESTIC_PERSONNEL
		, ISNULL(B.OVERSEAS_PERSONNEL, 0)		AS OVERSEAS_PERSONNEL
		, C.ORG_UNION_SEQ
		, E.UNION_NAME
		, A.ORG_COMPANY_SEQ
		, C.COMPANY_NAME
FROM	PM_INVEST										A
LEFT OUTER JOIN PM_INVEST_SUM						B ON A.SEQ = B.PM_INVEST_SEQ
LEFT OUTER JOIN ORG_COMPANY					C ON A.ORG_COMPANY_SEQ = C.SEQ
LEFT OUTER JOIN ORG_UNION					E ON C.ORG_UNION_SEQ = E.SEQ
WHERE	1 = 1
AND		A.INVEST_YEAR = @year 
ORDER BY C.ORG_UNION_SEQ, C.ORD";

                    return con.Query<PmInvestSum>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }


        public PmInvestSum selectOne(object param)
        {
            throw new NotImplementedException();
        }

        public PmInvestSum selectOneByPmInvest(object param)
        {

            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = "";
                    query += " SELECT * ";
                    query += " FROM PM_INVEST_SUM ";
                    query += " WHERE PM_INVEST_SEQ = @PmInvestSeq ";
                    query += "     AND MONTHLY_TYPE = @MonthlyType ";

                    return con.Query<PmInvestSum>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }
        
        public int update(PmInvestSum entity)
        {

            using (IDbConnection con = GetHallaDb())
            {
                con.Open();
                try
                {
                    string query =
                        "UPDATE PM_INVEST_SUM SET " +
                            " INVESTMENT = @investment, " +
                            " PERSONNEL = @personnel, " +
                            " DOMESTIC_PERSONNEL = @domesticPersonnel, " +
                            " OVERSEAS_PERSONNEL = @overseasPersonnel " +
                        "WHERE " +
                            " SEQ = @seq ";

                    return con.Execute(@query, entity);
                }
                catch (Exception e)
                {
                    LogUtil.Error(e.ToString());
                    return -1;
                }
            }
        }


        public PmInvestSum selectOnePrevInvestSum(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = "";
                    query += " SELECT B.*";
                    query += " FROM PM_INVEST A ";
                    query += "     , PM_INVEST_SUM B ";
                    query += " WHERE A.SEQ = B.PM_INVEST_SEQ ";
                    query += " AND A.INVEST_YEAR = @year ";
                    query += " AND A.MONTHLY = '12' ";
                    query += " AND A.ORG_COMPANY_SEQ = @orgCompanySeq ";
                    query += " AND B.MONTHLY_TYPE = " + Define.MONTHLY_TYPE.GetKey("누계");

                    return con.Query<PmInvestSum>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }


        public IEnumerable<PmInvestSum> selectListBefore(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
SELECT	*
FROM	PM_INVEST					A
LEFT OUTER JOIN PM_INVEST_SUM	B ON A.SEQ = B.PM_INVEST_SEQ
WHERE	1 = 1
AND		A.INVEST_YEAR = @InvestYear - 1
AND		A.ORG_COMPANY_SEQ = @OrgCompanySeq
AND		A.MONTHLY = '12'
AND		B.MONTHLY_TYPE = " + Define.MONTHLY_TYPE.GetKey("누계") + @"
";

                    return con.Query<PmInvestSum>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }



        public IEnumerable<PmInvestSum> selectListByPrevInfoBaseList(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
                            SELECT *
                            FROM PM_INVEST							A
                            LEFT OUTER JOIN PM_INVEST_SUM			B ON A.SEQ = PM_INVEST_SEQ
                            WHERE 1=1
                            AND A.INVEST_YEAR = @InvestYear - 1
                            AND A.ORG_COMPANY_SEQ = @OrgCompanySeq
                    ";

                    return con.Query<PmInvestSum>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }


        public IEnumerable<PmInvestSum> selectListNowYear(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
                            SELECT *
                            FROM PM_INVEST					A
                            LEFT OUTER JOIN PM_INVEST_SUM   B ON A.SEQ = PM_INVEST_SEQ
                            WHERE 1=1
                            AND A.INVEST_YEAR = @InvestYear
                            AND A.ORG_COMPANY_SEQ = @OrgCompanySeq 
                            AND A.MONTHLY = @Monthly
                    ";

                    return con.Query<PmInvestSum>(query, param).ToList();
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