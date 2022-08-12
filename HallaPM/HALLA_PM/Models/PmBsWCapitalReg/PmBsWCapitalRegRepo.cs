using Dapper;
using HALLA_PM.Util;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class PmBsWCapitalRegRepo : DbCon, IPmBsWCapitalRegRepo
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
                    string query = " SELECT COUNT(*) FROM PM_BS_W_CAPITAL_REG " + where;
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

        public int insert(PmBsWCapitalReg entity)
        {

            using (IDbConnection con = GetHallaDb())
            {
                con.Open();
                try
                {
                    string query = "INSERT INTO PM_BS_W_CAPITAL_REG( " +
                                                        " PM_BS_SEQ, " +
                                                        " AR, " +
                                                        " AR_TO_DAYS, " +
                                                        " AP, " +
                                                        " AP_TO_DAYS, " +
                                                        " INVENTORY, " +
                                                        " INVENTORY_TO_DAYS " +
                                                    " ) VALUES ( " +
                                                            " @PmBsSeq," +
                                                            " @Ar," +
                                                            " @ArToDays, " +
                                                            " @Ap," +
                                                            " @ApToDays, " +
                                                            " @Inventory," +
                                                            " @InventoryToDays " +
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

        public int save(PmBsWCapitalReg entity)
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

        public IEnumerable<PmBsWCapitalReg> selectList(object param)
        {
            throw new NotImplementedException();
        }

        public PmBsWCapitalReg selectOne(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = " SELECT * " +
                        " FROM PM_BS_W_CAPITAL_REG " +
                        " WHERE PM_BS_SEQ = @PmBsSeq ";

                    return con.Query<PmBsWCapitalReg>(query, param).First();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public PmBsWCapitalReg selectOneYear(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
SELECT	*
FROM	PM_BS				A
LEFT OUTER JOIN PM_BS_W_CAPITAL_REG	B ON A.SEQ = B.PM_BS_SEQ
WHERE BS_YEAR = @BsYear
    AND MONTHLY = @Monthly
    AND ORG_COMPANY_SEQ = @OrgCompanySeq ";

                    return con.Query<PmBsWCapitalReg>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }


        public PmBsWCapitalReg selectOneByPmBsSeq(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = " SELECT * " +
                        " FROM PM_BS_W_CAPITAL_REG " +
                        " WHERE PM_BS_SEQ = @PmBsSeq ";

                    return con.Query<PmBsWCapitalReg>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }


        public int update(PmBsWCapitalReg entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                con.Open();
                try
                {
                    string query =
                        "UPDATE PM_BS_W_CAPITAL_REG SET " +
                            " AR = @Ar" +
                            " , AR_TO_DAYS = @ArToDays" +
                            " , AP = @Ap" +
                            " , AP_TO_DAYS = @ApToDays" +
                            " , INVENTORY = @Inventory" +
                            " , INVENTORY_TO_DAYS = @InventoryToDays " +
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