using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Data;
using Dapper;
using HALLA_PM.Util;

namespace HALLA_PM.Models
{
    public class PlanYearCfBeCashRepo : DbCon, IPlanYearCfBeCashRepo
    {
        public int count(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " SELECT COUNT(*) FROM PLAN_YEAR_CF_BE_CASH ";
                    return con.Query<int>(query, param).First();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return -1;
                }
            }
        }
        public int count(object param, string where)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " SELECT COUNT(*) FROM PLAN_YEAR_CF_BE_CASH " + where;
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
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " DELETE PLAN_YEAR_CF_BE_CASH WHERE PLAN_YEAR_CF_SEQ = @PlanYearCfSeq ";
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

        public int insert(PlanYearCfBeCash entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " INSERT INTO  PLAN_YEAR_CF_BE_CASH ( " +
                        // 이부분은 수정하여 사용하세요. 
                        " PLAN_YEAR_CF_SEQ " +
                        ", YEARLY_YEAR " +
                        ", MONTHLY " +
                        ", BASIC_CASH " +
                        ", ENDING_CASH " +
                        ", CREDIT_LINE " +
                        ", AVAILABLE_CASH " +
                    " ) VALUES ( " +
                    " @PlanYearCfSeq " +
                    ", @YearlyYear " +
                    ", @Monthly " +
                    ", @BasicCash " +
                    ", @EndingCash " +
                    ", @CreditLine " +
                    ", @AvailableCash " +
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

        public int save(PlanYearCfBeCash entity)
        {
            var item = selectOne(entity);
            if (item == null)
            {
                return insert(entity);
            }
            else
            {
                return update(entity);
            }
        }

        public IEnumerable<PlanYearCfBeCash> selectList(object param)
        {
            {
                using (IDbConnection con = GetHallaDb())
                {
                    try
                    {
                        con.Open();

                        string query = " SELECT * " +
                            " FROM PLAN_YEAR_CF_BE_CASH " +
                            " WHERE PLAN_YEAR_CF_SEQ = @PlanYearCfSeq ";

                        return con.Query<PlanYearCfBeCash>(query, param).ToList();
                    }
                    catch (Exception e)
                    {
                        LogUtil.MngError(e.ToString());
                        return null;
                    }
                }
            }
        }

        public IEnumerable<PlanYearCfBeCash> selectListYear(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
SELECT	*
FROM	PLAN_YEAR_CF				A
LEFT OUTER JOIN PLAN_YEAR_CF_BE_CASH	B ON A.SEQ = B.PLAN_YEAR_CF_SEQ AND A.YEAR_CF_YEAR = B.YEARLY_YEAR
WHERE	A.YEAR_CF_YEAR = @YearCfYear
AND		A.ORG_COMPANY_SEQ = @OrgCompanySeq
";

                    return con.Query<PlanYearCfBeCash>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public PlanYearCfBeCash selectOne(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = " SELECT * " +
                        " FROM PLAN_YEAR_CF_BE_CASH " +
                        " WHERE SEQ = @Seq ";

                    return con.Query<PlanYearCfBeCash>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public PlanYearCfBeCash selectOneLastMonth(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = " SELECT * " +
                        " FROM PLAN_YEAR_CF_BE_CASH " +
                        " WHERE PLAN_YEAR_CF_SEQ = @PlanYearCfSeq " +
                        " AND YEARLY_YEAR = @YearlyYear" +
                        " AND MONTHLY = @Monthly";

                    return con.Query<PlanYearCfBeCash>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public int update(PlanYearCfBeCash entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " UPDATE PLAN_YEAR_CF_BE_CASH SET " +
                        // 이부분은 수정하여 사용하세요. 
                        //" , PLAN_YEAR_CF_SEQ = @PlanYearCfSeq" +
                        //" , YEARLY_YEAR = @YearlyYear" +
                        //" , MONTHLY = @Monthly" +
                        " BASIC_CASH = @BasicCash" +
                        " , ENDING_CASH = @EndingCash" +
                        " , CREDIT_LINE = @CreditLine" +
                        " , AVAILABLE_CASH = @AvailableCash" +
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

        public int updateCum(PlanYearCfBeCash entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " UPDATE PLAN_YEAR_CF_BE_CASH SET " +
                        // 이부분은 수정하여 사용하세요. 
                        //" , PLAN_YEAR_CF_SEQ = @PlanYearCfSeq" +
                        //" , YEARLY_YEAR = @YearlyYear" +
                        //" , MONTHLY = @Monthly" +
                        " CREDIT_LINE = @CreditLine" +
                        " , AVAILABLE_CASH = ENDING_CASH + @CreditLine" +
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
    }
}