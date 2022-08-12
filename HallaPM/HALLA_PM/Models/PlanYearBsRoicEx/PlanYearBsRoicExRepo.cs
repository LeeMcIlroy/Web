using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Data;
using Dapper;
using HALLA_PM.Util;

namespace HALLA_PM.Models
{
    public class PlanYearBsRoicExRepo : DbCon, IPlanYearBsRoicExRepo
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
                    string query = " SELECT COUNT(*) FROM PLAN_YEAR_BS_ROIC_EX " + where;
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

        public int insert(PlanYearBsRoicEx entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = @" INSERT INTO  PLAN_YEAR_BS_ROIC_EX ( 
                             PLAN_YEAR_BS_SEQ 
                            , YEARLY_YEAR 
                            , MONTHLY 
                            , AFTER_TAX_OPERATION_PROFIT 
                            , PAIN_IN_CAPITAL 
                            , ROIC 
                             ) VALUES ( 
                             @PlanYearBsSeq 
                            , @YearlyYear
                            , @Monthly
                            , @AfterTaxOperationProfit
                            , @PainInCapital 
                            , @Roic 
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

        public int save(PlanYearBsRoicEx entity)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<PlanYearBsRoicEx> selectList(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" SELECT * FROM PLAN_YEAR_BS_ROIC_EX WHERE PLAN_YEAR_BS_SEQ  = @PlanYearBsSeq";

                    return con.Query<PlanYearBsRoicEx>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<PlanYearBsRoicEx> selectListBefore(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
SELECT	*
FROM	PLAN_YEAR_BS_EX				    A
LEFT OUTER JOIN PLAN_YEAR_BS_ROIC_EX	B ON A.SEQ = B.PLAN_YEAR_BS_SEQ
WHERE	1 = 1
AND		A.YEAR_BS_YEAR = @YearlyYear - 1
AND		A.ORG_COMPANY_SEQ = @OrgCompanySeq
AND		B.MONTHLY  = '12'
";
                    
                    return con.Query<PlanYearBsRoicEx>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public PlanYearBsRoicEx selectOne(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = " SELECT * " +
                        " FROM PLAN_YEAR_BS_ROIC_EX " +
                        " WHERE PM_BS_SEQ = @PmBsSeq ";

                    return con.Query<PlanYearBsRoicEx>(query, param).First();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public PlanYearBsRoicEx selectOneYear(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
SELECT	*
FROM	PLAN_YEAR_BS_EX				    A
LEFT OUTER JOIN PLAN_YEAR_BS_ROIC_EX	B ON A.SEQ = B.PLAN_YEAR_BS_SEQ
WHERE	1 = 1
AND		A.YEAR_BS_YEAR = @BsYear
AND		A.ORG_COMPANY_SEQ = @OrgCompanySeq
AND		B.MONTHLY  = @Monthly
";
                    return con.Query<PlanYearBsRoicEx>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public int update(PlanYearBsRoicEx entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" UPDATE PLAN_YEAR_BS_ROIC_EX SET 
                                    AFTER_TAX_OPERATION_PROFIT = @AfterTaxOperationProfit 
                                    ,PAIN_IN_CAPITAL = @PainInCapital
                                    ,ROIC = @Roic
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
    }
}