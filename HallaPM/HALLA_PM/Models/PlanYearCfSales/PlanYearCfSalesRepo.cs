using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Data;
using Dapper;
using HALLA_PM.Util;

namespace HALLA_PM.Models
{
    public class PlanYearCfSalesRepo : DbCon, IPlanYearCfSalesRepo

    {
        public int count(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " SELECT COUNT(*) FROM PLAN_YEAR_CF_SALES ";
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
                    string query = " SELECT COUNT(*) FROM PLAN_YEAR_CF_SALES " + where;
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

        public int insert(PlanYearCfSales entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " INSERT INTO  PLAN_YEAR_CF_SALES ( " +
                        // 이부분은 수정하여 사용하세요. 
                        " PLAN_YEAR_CF_SEQ " +
                        ", YEARLY_YEAR " +
                        ", MONTHLY " +
                        ", OPERATION_PROFIT " +
                        ", DEPRECIATION_COST " +
                        ", CORP_TAX " +
                        //", EBITDA " +
                        ", AR " +
                        ", INV " +
                        ", AP " +
                        //", WC_SUM " +
                        ", ETC " +
                        ", INTEREST_EXPENSE " +
                        ", INTEREST_INCOME " +
                        //", FINANCIAL_COST_SUM " +
                    " ) VALUES ( " +
                    " @PlanYearCfSeq " +
                    ", @YearlyYear " +
                    ", @Monthly " +
                    ", @OperationProfit " +
                    ", @DepreciationCost " +
                    ", @CorpTax " +
                    //", @Ebitda " +
                    ", @Ar " +
                    ", @Inv " +
                    ", @Ap " +
                    //", @WcSum " +
                    ", @Etc " +
                    ", @InterestExpense " +
                    ", @InterestIncome " +
                    //", @FinancialCostSum " +
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

        public int save(PlanYearCfSales entity)
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

        public IEnumerable<PlanYearCfSales> selectList(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = " SELECT * " +
                        " FROM PLAN_YEAR_CF_SALES " +
                        " WHERE PLAN_YEAR_CF_SEQ = @PlanYearCfSeq ";

                    return con.Query<PlanYearCfSales>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<PlanYearCfSales> selectListYear(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
SELECT	*
FROM	PLAN_YEAR_CF				A
LEFT OUTER JOIN PLAN_YEAR_CF_SALES	B ON A.SEQ = B.PLAN_YEAR_CF_SEQ AND A.YEAR_CF_YEAR = B.YEARLY_YEAR
WHERE	A.YEAR_CF_YEAR = @YearCfYear
AND		A.ORG_COMPANY_SEQ = @OrgCompanySeq
";

                    return con.Query<PlanYearCfSales>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public PlanYearCfSales selectOne(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = " SELECT * " +
                        " FROM PLAN_YEAR_CF_SALES " +
                        " WHERE SEQ = @Seq ";

                    return con.Query<PlanYearCfSales>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public int update(PlanYearCfSales entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " UPDATE PLAN_YEAR_CF_SALES SET " +
                        // 이부분은 수정하여 사용하세요. 
                        //" , PLAN_YEAR_CF_SEQ = @PlanYearCfSeq" +
                        //" , YEARLY_YEAR = @YearlyYear" +
                        //" , MONTHLY = @Monthly" +
                        " OPERATION_PROFIT = @OperationProfit" +
                        " , DEPRECIATION_COST = @DepreciationCost" +
                        " , CORP_TAX = @CorpTax" +
                        //" , EBITDA = @Ebitda" +
                        " , AR = @Ar" +
                        " , INV = @Inv" +
                        " , AP = @Ap" +
                        //" , WC_SUM = @WcSum" +
                        " , ETC = @Etc" +
                        " , INTEREST_EXPENSE = @InterestExpense" +
                        " , INTEREST_INCOME = @InterestIncome" +
                        //" , FINANCIAL_COST_SUM = @FinancialCostSum" +
                        " WHERE SEQ = @Seq" +
                    // 이부분은 수정하여 사용하세요. 
                    ";SELECT @@ROWCOUNT";
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