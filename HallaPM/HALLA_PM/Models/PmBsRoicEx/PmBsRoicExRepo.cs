using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Data;
using Dapper;
using HALLA_PM.Util;

namespace HALLA_PM.Models
{
    public class PmBsRoicExRepo : DbCon, IPmBsRoicExRepo
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
                    string query = " SELECT COUNT(*) FROM PM_BS_ROIC_EX " + where;
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

        public int insert(PmBsRoicEx entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " INSERT INTO  PM_BS_ROIC_EX ( " +
                        // 이부분은 수정하여 사용하세요. 
                        " PM_BS_SEQ " +
                        //", SEQ " +
                        ", AFTER_TAX_OPERATION_PROFIT " +
                        ", PAIN_IN_CAPITAL " +
                        ", ROIC " +
                    " ) VALUES ( " +
                    " @PmBsSeq " +
                    //", @Seq " +
                    ", @AfterTaxOperationProfit " +
                    ", @PainInCapital " +
                    ", @Roic " +
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

        public int save(PmBsRoicEx entity)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<PmBsRoicEx> selectList(object param)
        {
            throw new NotImplementedException();
        }

        public PmBsRoicEx selectOne(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = " SELECT * " +
                        " FROM PM_BS_ROIC_EX " +
                        " WHERE PM_BS_SEQ = @PmBsSeq ";

                    return con.Query<PmBsRoicEx>(query, param).First();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public PmBsRoicEx selectOneYear(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
SELECT	*
FROM	PM_BS_EX				A
LEFT OUTER JOIN PM_BS_ROIC_EX	B ON A.SEQ = B.PM_BS_SEQ
WHERE BS_YEAR = @BsYear
    AND MONTHLY = @Monthly
    AND ORG_COMPANY_SEQ = @OrgCompanySeq ";

                    return con.Query<PmBsRoicEx>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public int update(PmBsRoicEx entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " UPDATE PM_BS_ROIC_EX SET " +
                        // 이부분은 수정하여 사용하세요. 
                        //" , PM_BS_SEQ = @PmBsSeq" +
                        " AFTER_TAX_OPERATION_PROFIT = @AfterTaxOperationProfit" +
                        " , PAIN_IN_CAPITAL = @PainInCapital" +
                        " , ROIC = @Roic" +
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