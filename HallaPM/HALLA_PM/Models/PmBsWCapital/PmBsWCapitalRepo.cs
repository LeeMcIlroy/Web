using Dapper;
using HALLA_PM.Util;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class PmBsWCapitalRepo : DbCon, IPmBsWCapitalRepo
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
                    string query = " SELECT COUNT(*) FROM PM_BS_W_CAPITAL " + where;
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

        public int insert(PmBsWCapital entity)
        {

            using (IDbConnection con = GetHallaDb())
            {
                con.Open();
                try
                {
                    string query = "INSERT INTO PM_BS_W_CAPITAL( " +
                                                        " PM_BS_SEQ, " +
                                                        " ANNUAL_SALES, " +
                                                        " ANNUAL_SALES_COST, " +
                                                        " INVENTORY_COST " +
                                                    " ) VALUES ( " +
                                                            " @PmBsSeq," +
                                                            " @AnnualSales," +
                                                            " @AnnualSalesCost, " +
                                                            " @InventoryCost " +
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

        public int save(PmBsWCapital entity)
        {

            var item = this.selectOneByPmBsSeq(entity);
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

        public PmBsWCapital selectOneByPmBsSeq(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = " SELECT * " +
                        " FROM PM_BS_W_CAPITAL " +
                        " WHERE PM_BS_SEQ = @PmBsSeq ";

                    return con.Query<PmBsWCapital>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }
        public IEnumerable<PmBsWCapital> selectList(object param)
        {
            throw new NotImplementedException();
        }

        public PmBsWCapital selectOne(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = " SELECT * " +
                        " FROM PM_BS_W_CAPITAL " +
                        " WHERE PM_BS_SEQ = @PmBsSeq ";

                    return con.Query<PmBsWCapital>(query, param).First();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public PmBsWCapital selectOneYear(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
SELECT	*
FROM	PM_BS				A
LEFT OUTER JOIN PM_BS_W_CAPITAL 	B ON A.SEQ = B.PM_BS_SEQ
WHERE BS_YEAR = @BsYear
    AND MONTHLY = @Monthly
    AND ORG_COMPANY_SEQ = @OrgCompanySeq ";

                    return con.Query<PmBsWCapital>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public int update(PmBsWCapital entity)
        {

            using (IDbConnection con = GetHallaDb())
            {
                con.Open();
                try
                {
                    string query =
                        "UPDATE PM_BS_W_CAPITAL SET " +
                            " ANNUAL_SALES = @AnnualSales, " +
                            " ANNUAL_SALES_COST = @AnnualSalesCost, " +
                            " INVENTORY_COST = @InventoryCost " +
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
    }
}