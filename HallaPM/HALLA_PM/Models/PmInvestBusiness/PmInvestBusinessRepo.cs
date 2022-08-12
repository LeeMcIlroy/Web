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
    public class PmInvestBusinessRepo : DbCon, IPmInvestBusinessRepo
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
                    string query = @" SELECT COUNT(*) FROM PM_INVEST_BUSINESS " + where;
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

        public int insert(PmInvestBusiness entity)
        {

            using (IDbConnection con = GetHallaDb())
            {
                con.Open();
                try
                {
                    string query = "INSERT INTO PM_INVEST_BUSINESS( " +
                                                        " PM_INVEST_SEQ, " +
                                                        " ORG_BUSINESS_SEQ, " +
                                                        " MONTHLY_TYPE, " +
                                                        " INVESTMENT, " +
                                                        " PERSONNEL, " +
                                                        " DOMESTIC_PERSONNEL, " +
                                                        " OVERSEAS_PERSONNEL " +
                                                    " ) VALUES ( " +
                                                            " @PmInvestSeq," +
                                                            " @orgBusinessSeq," +
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

        public int save(PmInvestBusiness entity)
        {
            throw new NotImplementedException();
        }


        public int saveByPmInvest(PmInvestBusiness entity)
        {
            var item = this.selectOneByPmInvest(entity);
            if(item == null)
            {
                return this.insert(entity);
            }else
            {
                entity.Seq = item.Seq;
                return this.update(entity);
            }
        }

        public IEnumerable<PmInvestBusiness> selectList(object param)
        {
            {
                using (IDbConnection con = GetHallaDb())
                {
                    try
                    {
                        con.Open();

                        string query = " SELECT * " +
                            " FROM PM_INVEST_BUSINESS " +
                            " WHERE PM_INVEST_SEQ = @PmInvestSeq ";

                        return con.Query<PmInvestBusiness>(query, param).ToList();
                    }
                    catch (Exception e)
                    {
                        LogUtil.MngError(e.ToString());
                        return null;
                    }
                }
            }
        }


        public IEnumerable<PmInvestBusiness> selectListExcel(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string where = " WHERE 1 = 1 ";

                    string query = @" 
SELECT	B.PM_INVEST_SEQ
		, B.SEQ
		, D.COMPANY_NAME
		, B.ORG_BUSINESS_SEQ
		, C.BUSINESS_NAME
		, A.INVEST_YEAR
		, A.MONTHLY
		, MONTHLY_TYPE
		, B.INVESTMENT
		, B.PERSONNEL
		, B.DOMESTIC_PERSONNEL
		, B.OVERSEAS_PERSONNEL
FROM	PM_INVEST A
LEFT OUTER JOIN PM_INVEST_BUSINESS		B ON A.SEQ = B.PM_INVEST_SEQ
LEFT OUTER JOIN ORG_BUSINESS		C ON B.ORG_BUSINESS_SEQ = C.SEQ
LEFT OUTER JOIN ORG_COMPANY			D ON C.ORG_COMPANY_SEQ = D.SEQ
WHERE	B.PM_INVEST_SEQ = @PmInvestSeq
                        ";

                    return con.Query<PmInvestBusiness>(query, param).ToList();

                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        /// <summary>
        /// 전년실적 연간 Bu
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        public IEnumerable<PmInvestBusiness> selectListPmLastYear(object param)
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
		, B.ORG_BUSINESS_SEQ
		, D.BUSINESS_NAME
FROM	PM_INVEST										A
LEFT OUTER JOIN PM_INVEST_BUSINESS						B ON A.SEQ = B.PM_INVEST_SEQ
LEFT OUTER JOIN ORG_COMPANY					C ON A.ORG_COMPANY_SEQ = C.SEQ
LEFT OUTER JOIN ORG_BUSINESS				D ON B.ORG_BUSINESS_SEQ = D.SEQ
LEFT OUTER JOIN ORG_UNION					E ON C.ORG_UNION_SEQ = E.SEQ
WHERE	1 = 1
AND		A.INVEST_YEAR = @year -1
AND     A.REGIST_STATUS = " + Define.REGIST_STATUS.GetKey("최종승인");

                    return con.Query<PmInvestBusiness>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }
        
        public IEnumerable<PmInvestBusiness> selectListPmThisYear(object param)
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
		, B.ORG_BUSINESS_SEQ
		, D.BUSINESS_NAME
FROM	PM_INVEST										A
LEFT OUTER JOIN PM_INVEST_BUSINESS						B ON A.SEQ = B.PM_INVEST_SEQ
LEFT OUTER JOIN ORG_COMPANY					C ON A.ORG_COMPANY_SEQ = C.SEQ
LEFT OUTER JOIN ORG_BUSINESS				D ON B.ORG_BUSINESS_SEQ = D.SEQ
LEFT OUTER JOIN ORG_UNION					E ON C.ORG_UNION_SEQ = E.SEQ
WHERE	1 = 1
AND		A.INVEST_YEAR = @year ";

                    return con.Query<PmInvestBusiness>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public PmInvestBusiness selectOne(object param)
        {
            throw new NotImplementedException();
        }

        public PmInvestBusiness selectOneByPmInvest(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = "";
                    query += " SELECT * ";
                    query += " FROM PM_INVEST_BUSINESS ";
                    query += " WHERE PM_INVEST_SEQ = @PmInvestSeq ";
                    query += "     AND ORG_BUSINESS_SEQ = @orgBusinessSeq ";
                    query += "     AND MONTHLY_TYPE = @monthlyType ";

                    return con.Query<PmInvestBusiness>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public List<PmInvestBusiness> selectListByPmInvest(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = "";
                    query += " SELECT * ";
                    query += " FROM PM_INVEST_BUSINESS ";
                    query += " WHERE PM_INVEST_SEQ = @PmInvestSeq ";

                    return con.Query<PmInvestBusiness>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }
        public int update(PmInvestBusiness entity)
        {

            using (IDbConnection con = GetHallaDb())
            {
                con.Open();
                try
                {
                    string query =
                        "UPDATE PM_INVEST_BUSINESS SET " +
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

        public IEnumerable<PmInvestBusiness> selectListBefore(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
SELECT	*
FROM	PM_INVEST					A
LEFT OUTER JOIN PM_INVEST_BUSINESS	B ON A.SEQ = B.PM_INVEST_SEQ
WHERE	1 = 1
AND		A.INVEST_YEAR = @InvestYear - 1
AND		A.ORG_COMPANY_SEQ = @OrgCompanySeq
AND		A.MONTHLY = '12'
AND		B.MONTHLY_TYPE = " + Define.MONTHLY_TYPE.GetKey("누계") + @"
";

                    return con.Query<PmInvestBusiness>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<PmInvestBusiness> selectListNow(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
SELECT	*
FROM	PM_INVEST					A
LEFT OUTER JOIN PM_INVEST_BUSINESS	B ON A.SEQ = B.PM_INVEST_SEQ
WHERE	1 = 1
AND		A.INVEST_YEAR = @investYear
AND		A.ORG_COMPANY_SEQ = @orgCompanySeq
AND		A.MONTHLY = @monthly
";

                    return con.Query<PmInvestBusiness>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }
        public IEnumerable<PmInvestBusiness> selectListBeforeByMonthly(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
SELECT	*
FROM	PM_INVEST					A
LEFT OUTER JOIN PM_INVEST_BUSINESS	B ON A.SEQ = B.PM_INVEST_SEQ
WHERE	1 = 1
AND		A.INVEST_YEAR = @InvestYear - 1
AND		A.ORG_COMPANY_SEQ = @OrgCompanySeq
AND		A.MONTHLY = @monthly
";

                    return con.Query<PmInvestBusiness>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<PmInvestBusiness> selectListNowBySummary(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
SELECT	PM_INVEST_SEQ, MONTHLY_TYPE
	, SUM(INVESTMENT) AS INVESTMENT
	, SUM(PERSONNEL) AS PERSONNEL
	, SUM(DOMESTIC_PERSONNEL) AS DOMESTIC_PERSONNEL
	, SUM(OVERSEAS_PERSONNEL) AS OVERSEAS_PERSONNEL
FROM	PM_INVEST					A
LEFT OUTER JOIN PM_INVEST_BUSINESS	B ON A.SEQ = B.PM_INVEST_SEQ
WHERE	1 = 1
AND		A.INVEST_YEAR = @investYear
AND		A.ORG_COMPANY_SEQ = @orgCompanySeq
AND		A.MONTHLY = @monthly
GROUP BY PM_INVEST_SEQ, MONTHLY_TYPE
";

                    return con.Query<PmInvestBusiness>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<PmInvestBusiness> selectListYear(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
SELECT	*
FROM	PM_INVEST					A
LEFT OUTER JOIN PM_INVEST_BUSINESS	B ON A.SEQ = B.PM_INVEST_SEQ
WHERE	1 = 1
AND		A.INVEST_YEAR = @InvestYear - 1
--AND		A.ORG_COMPANY_SEQ = @OrgCompanySeq
";
                    return con.Query<PmInvestBusiness>(query, param).ToList();
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