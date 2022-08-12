using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Data;
using Dapper;
using HALLA_PM.Util;

namespace HALLA_PM.Models
{
    public class PmBsWCapitalExRepo : DbCon, IPmBsWCapitalExRepo
    {
        public int count(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " SELECT COUNT(*) FROM PM_BS_W_CAPITAL_EX ";
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
                    string query = " SELECT COUNT(*) FROM PM_BS_W_CAPITAL_EX " + where;
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

        public int insert(PmBsWCapitalEx entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " INSERT INTO  PM_BS_W_CAPITAL_EX ( " +
                        // 이부분은 수정하여 사용하세요. 
                        " PM_BS_SEQ " +
                        //", SEQ " +
                        ", ANNUAL_SALES " +
                        ", ANNUAL_SALES_COST " +
                        ", INVENTORY_COST " +
                    " ) VALUES ( " +
                    " @PmBsSeq " +
                    //", @Seq " +
                    ", @AnnualSales " +
                    ", @AnnualSalesCost " +
                    ", @InventoryCost " +
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

        public int save(PmBsWCapitalEx entity)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<PmBsWCapitalEx> selectList(object param)
        {
            throw new NotImplementedException();
        }

        public PmBsWCapitalEx selectOne(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = " SELECT * " +
                        " FROM PM_BS_W_CAPITAL_EX " +
                        " WHERE PM_BS_SEQ = @PmBsSeq ";

                    return con.Query<PmBsWCapitalEx>(query, param).First();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public PmBsWCapitalEx selectOneYear(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
SELECT	*
FROM	PM_BS_EX				A
LEFT OUTER JOIN PM_BS_W_CAPITAL_EX	B ON A.SEQ = B.PM_BS_SEQ
WHERE BS_YEAR = @BsYear
    AND MONTHLY = @Monthly
    AND ORG_COMPANY_SEQ = @OrgCompanySeq ";

                    return con.Query<PmBsWCapitalEx>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }
        public int update(PmBsWCapitalEx entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " UPDATE PM_BS_W_CAPITAL_EX SET " +
                        // 이부분은 수정하여 사용하세요. 
                        //" , PM_BS_SEQ = @PmBsSeq" +
                        " ANNUAL_SALES = @AnnualSales" +
                        " , ANNUAL_SALES_COST = @AnnualSalesCost" +
                        " , INVENTORY_COST = @InventoryCost" +
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