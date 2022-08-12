using Dapper;
using HALLA_PM.Util;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class PmBsRoicRepo : DbCon, IPmBsRoicRepo
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
                    string query = " SELECT COUNT(*) FROM PM_BS_ROIC " + where;
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

        public int insert(PmBsRoic entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                con.Open();
                try
                {
                    string query = "INSERT INTO PM_BS_ROIC( " +
                                                        " PM_BS_SEQ, " +
                                                        " AFTER_TAX_OPERATION_PROFIT, " +
                                                        " PAIN_IN_CAPITAL " +
                                                    " ) VALUES ( " +
                                                            " @PmBsSeq," +
                                                            " @AfterTaxOperationProfit," +
                                                            " @PainInCapital " +
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

        public int save(PmBsRoic entity)
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

        public IEnumerable<PmBsRoic> selectList(object param)
        {
            throw new NotImplementedException();
        }

        public PmBsRoic selectOne(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = " SELECT * " +
                        " FROM PM_BS_ROIC " +
                        " WHERE PM_BS_SEQ = @PmBsSeq ";

                    return con.Query<PmBsRoic>(query, param).First();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public PmBsRoic selectOneYear(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
SELECT	*
FROM	PM_BS				A
LEFT OUTER JOIN PM_BS_ROIC  	B ON A.SEQ = B.PM_BS_SEQ
WHERE BS_YEAR = @BsYear
    AND MONTHLY = @Monthly
    AND ORG_COMPANY_SEQ = @OrgCompanySeq ";

                    return con.Query<PmBsRoic>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public PmBsRoic selectOneByPmBsSeq(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = " SELECT * " +
                        " FROM PM_BS_ROIC " +
                        " WHERE PM_BS_SEQ = @PmBsSeq ";

                    return con.Query<PmBsRoic>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }
        

        public int update(PmBsRoic entity)
        {

            using (IDbConnection con = GetHallaDb())
            {
                con.Open();
                try
                {
                    string query =
                        "UPDATE PM_BS_ROIC SET " +
                            " AFTER_TAX_OPERATION_PROFIT = @AfterTaxOperationProfit, " +
                            " PAIN_IN_CAPITAL = @PainInCapital " +
                        " , ROIC = @Roic " +
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