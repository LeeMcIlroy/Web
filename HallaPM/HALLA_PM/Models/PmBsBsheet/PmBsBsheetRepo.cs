using Dapper;
using HALLA_PM.Util;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class PmBsBsheetRepo : DbCon, IPmBsBsheetRepo
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
                    string query = " SELECT COUNT(*) FROM PM_BS_BSHEET " + where;
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

        public int insert(PmBsBsheet entity)
        {

            using (IDbConnection con = GetHallaDb())
            {
                con.Open();
                try
                {
                    string query = "INSERT INTO PM_BS_BSHEET( " +
                                                        " PM_BS_SEQ, " +
                                                        " ASSETS, " +
                                                        " CURRENT_ASSETS, " +
                                                        " LIABILITIES, " +
                                                        " CURRENT_LIABILITIES, " +
                                                        " CAPITAL, " +
                                                        " CASH, " +
                                                        " LOAN " +
                                                    " ) VALUES ( " +
                                                            " @PmBsSeq," +
                                                            " @Assets," +
                                                            " @CurrentAssets, " +
                                                            " @Liabilities," +
                                                            " @currentLiabilities," +
                                                            " @Capital," +
                                                            " @Cash," +
                                                            " @Loan " +
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

        public int save(PmBsBsheet entity)
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

        public IEnumerable<PmBsBsheet> selectList(object param)
        {
            throw new NotImplementedException();
        }

        public PmBsBsheet selectOne(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = " SELECT * " +
                        " FROM PM_BS_BSHEET " +
                        " WHERE PM_BS_SEQ = @PmBsSeq ";

                    return con.Query<PmBsBsheet>(query, param).First();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public PmBsBsheet selectOneByPmBsSeq(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = " SELECT * " +
                        " FROM PM_BS_BSHEET " +
                        " WHERE PM_BS_SEQ = @PmBsSeq ";

                    return con.Query<PmBsBsheet>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public PmBsBsheet selectOneYear(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
SELECT	*
FROM	PM_BS				A
LEFT OUTER JOIN PM_BS_BSHEET	B ON A.SEQ = B.PM_BS_SEQ
WHERE BS_YEAR = @BsYear
    AND MONTHLY = @Monthly
    AND ORG_COMPANY_SEQ = @OrgCompanySeq ";

                    return con.Query<PmBsBsheet>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public int update(PmBsBsheet entity)
        {

            using (IDbConnection con = GetHallaDb())
            {
                con.Open();
                try
                {
                    string query =
                        "UPDATE PM_BS_BSHEET SET " +
                            " ASSETS = @Assets, " +
                            " CURRENT_ASSETS = @CurrentAssets, " +
                            " LIABILITIES = @Liabilities, " +
                            " CURRENT_LIABILITIES = @currentLiabilities, " +
                            " CAPITAL = @Capital, " +
                            " CASH = @Cash, " +
                            " LOAN = @Loan " +
                        " , LIABILITIES_RATE = @LiabilitiesRate " +
                        " , CURRENT_RATE = @CurrentRate " +
                        " WHERE " +
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