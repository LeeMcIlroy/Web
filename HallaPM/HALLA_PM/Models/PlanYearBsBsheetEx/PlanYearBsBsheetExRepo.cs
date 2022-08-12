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
    public class PlanYearBsBsheetExRepo : DbCon, IPlanYearBsBsheetExRepo
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
                    string query = " SELECT COUNT(*) FROM PLAN_YEAR_BS_BSHEET_EX " + where;
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

        public int insert(PlanYearBsBsheetEx entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = @" INSERT INTO  PLAN_YEAR_BS_BSHEET_EX (
                                         PLAN_YEAR_BS_SEQ 
                                        , YEARLY_YEAR
                                        , MONTHLY
                                        , ASSETS
                                        , CURRENT_ASSETS
                                        , LIABILITIES
                                        , CURRENT_LIABILITIES
                                        , CAPITAL
                                        , CASH
                                        , LOAN
                                        , LIABILITIES_RATE
                                        , CURRENT_RATE
                                         ) VALUES (
                                         @PlanYearBsSeq
                                        , @YearlyYear
                                        , @Monthly
                                        , @Assets
                                        , @CurrentAssets
                                        , @Liabilities
                                        , @CurrentLiabilities
                                        , @Capital
                                        , @Cash
                                        , @Loan
                                        , @LiabilitiesRate
                                        , @CurrentRate
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

        public int save(PlanYearBsBsheetEx entity)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<PlanYearBsBsheetEx> selectList(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" SELECT * FROM PLAN_YEAR_BS_BSHEET_EX WHERE PLAN_YEAR_BS_SEQ = @PlanYearBsSeq ";

                    return con.Query<PlanYearBsBsheetEx>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public PlanYearBsBsheetEx selectOne(object param)
        {
            throw new NotImplementedException();
        }

        public int update(PlanYearBsBsheetEx entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" UPDATE PLAN_YEAR_BS_BSHEET_EX SET 
                                        ASSETS = @Assets
                                        ,CURRENT_ASSETS = @CurrentAssets
                                        ,LIABILITIES = @Liabilities
                                        ,CURRENT_LIABILITIES = @CurrentLiabilities
                                        ,CAPITAL = @Capital
                                        ,CASH = @Cash
                                        ,LOAN = @Loan
                                        ,LIABILITIES_RATE = @LiabilitiesRate
                                        ,CURRENT_RATE = @CurrentRate
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

        public PlanYearBsBsheetEx selectOneYear(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
SELECT	*
FROM	PLAN_YEAR_BS_EX				    A
LEFT OUTER JOIN PLAN_YEAR_BS_BSHEET_EX	B ON A.SEQ = B.PLAN_YEAR_BS_SEQ
WHERE	1 = 1
AND		A.YEAR_BS_YEAR = @BsYear
AND		A.ORG_COMPANY_SEQ = @OrgCompanySeq
AND		B.MONTHLY  = @Monthly
";
                    return con.Query<PlanYearBsBsheetEx>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<PlanYearBsBsheetEx> selectListBefore(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
SELECT	*
FROM	PM_BS_EX					A
LEFT OUTER JOIN PM_BS_BSHEET_EX	B ON A.SEQ = B.PM_BS_SEQ
WHERE	1 = 1
AND		A.BS_YEAR = @YearlyYear - 1
AND		A.ORG_COMPANY_SEQ = @OrgCompanySeq
AND		A.MONTHLY = '12'
";

//                    string query = @"
//SELECT	*
//FROM	PLAN_YEAR_BS_EX				    A
//LEFT OUTER JOIN PLAN_YEAR_BS_BSHEET_EX	B ON A.SEQ = B.PLAN_YEAR_BS_SEQ
//WHERE	1 = 1
//AND		A.YEAR_BS_YEAR = @YearlyYear - 1
//AND		A.ORG_COMPANY_SEQ = @OrgCompanySeq
//AND		B.MONTHLY  = '12'
//";
                    return con.Query<PlanYearBsBsheetEx>(query, param).ToList();
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