using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Data;
using Dapper;
using HALLA_PM.Util;

namespace HALLA_PM.Models
{
    public class PlanYearCfFinancialRepo : DbCon, IPlanYearCfFinancialRepo
    {
        public int count(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " SELECT COUNT(*) FROM PLAN_YEAR_CF_FINANCIAL ";
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
                    string query = " SELECT COUNT(*) FROM PLAN_YEAR_CF_FINANCIAL " + where;
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

        public int insert(PlanYearCfFinancial entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " INSERT INTO  PLAN_YEAR_CF_FINANCIAL ( " +
                        // 이부분은 수정하여 사용하세요. 
                        " PLAN_YEAR_CF_SEQ " +
                        ", YEARLY_YEAR " +
                        ", MONTHLY " +
                        ", ALLOCATION " +
                        ", INCREASE " +
                        ", BORROWING " +
                        ", REPAYMENT " +
                        ", ETC " +
                        //", FINANCIAL_SUM " +
                    " ) VALUES ( " +
                    " @PlanYearCfSeq " +
                    ", @YearlyYear " +
                    ", @Monthly " +
                    ", @Allocation " +
                    ", @Increase " +
                    ", @Borrowing " +
                    ", @Repayment " +
                    ", @Etc " +
                    //", @FinancialSum " +
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

        public int save(PlanYearCfFinancial entity)
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

        public IEnumerable<PlanYearCfFinancial> selectList(object param)
        {
            {
                using (IDbConnection con = GetHallaDb())
                {
                    try
                    {
                        con.Open();

                        string query = " SELECT * " +
                            " FROM PLAN_YEAR_CF_FINANCIAL " +
                            " WHERE PLAN_YEAR_CF_SEQ = @PlanYearCfSeq ";

                        return con.Query<PlanYearCfFinancial>(query, param).ToList();
                    }
                    catch (Exception e)
                    {
                        LogUtil.MngError(e.ToString());
                        return null;
                    }
                }
            }
        }

        public IEnumerable<PlanYearCfFinancial> selectListYear(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
SELECT	*
FROM	PLAN_YEAR_CF				A
LEFT OUTER JOIN PLAN_YEAR_CF_FINANCIAL	B ON A.SEQ = B.PLAN_YEAR_CF_SEQ AND A.YEAR_CF_YEAR = B.YEARLY_YEAR
WHERE	A.YEAR_CF_YEAR = @YearCfYear
AND		A.ORG_COMPANY_SEQ = @OrgCompanySeq
";

                    return con.Query<PlanYearCfFinancial>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public PlanYearCfFinancial selectOne(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = " SELECT * " +
                        " FROM PLAN_YEAR_CF_FINANCIAL " +
                        " WHERE SEQ = @Seq ";

                    return con.Query<PlanYearCfFinancial>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public int update(PlanYearCfFinancial entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " UPDATE PLAN_YEAR_CF_FINANCIAL SET " +
                        // 이부분은 수정하여 사용하세요. 
                        //" , PLAN_YEAR_CF_SEQ = @PlanYearCfSeq" +
                        //" , YEARLY_YEAR = @YearlyYear" +
                        //" , MONTHLY = @Monthly" +
                        " ALLOCATION = @Allocation" +
                        " , INCREASE = @Increase" +
                        " , BORROWING = @Borrowing" +
                        " , REPAYMENT = @Repayment" +
                        " , ETC = @Etc" +
                        //" , FINANCIAL_SUM = @FinancialSum" +
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