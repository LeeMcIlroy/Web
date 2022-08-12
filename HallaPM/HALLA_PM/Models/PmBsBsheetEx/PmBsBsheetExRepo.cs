using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Data;
using Dapper;
using HALLA_PM.Util;

namespace HALLA_PM.Models
{
    public class PmBsBsheetExRepo : DbCon, IPmBsBsheetExRepo
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
                    string query = " SELECT COUNT(*) FROM PM_BS_BSHEET_EX " + where;
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

        public int insert(PmBsBsheetEx entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " INSERT INTO  PM_BS_BSHEET_EX ( " +
                        // 이부분은 수정하여 사용하세요. 
                        " PM_BS_SEQ " +
                        //", SEQ " +
                        ", ASSETS " +
                        ", CURRENT_ASSETS " +
                        ", LIABILITIES " +
                        ", CURRENT_LIABILITIES " +
                        ", CAPITAL " +
                        ", CASH " +
                        ", LOAN " +
                        ", LIABILITIES_RATE " +
                        ", CURRENT_RATE " +
                    " ) VALUES ( " +
                    " @PmBsSeq " +
                    //", @Seq " +
                    ", @Assets " +
                    ", @CurrentAssets " +
                    ", @Liabilities " +
                    ", @CurrentLiabilities " +
                    ", @Capital " +
                    ", @Cash " +
                    ", @Loan " +
                    ", @LiabilitiesRate " +
                    ", @CurrentRate " +
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

        public int save(PmBsBsheetEx entity)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<PmBsBsheetEx> selectList(object param)
        {
            throw new NotImplementedException();
        }

        public PmBsBsheetEx selectOneYear(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
SELECT	*
FROM	PM_BS_EX				A
LEFT OUTER JOIN PM_BS_BSHEET_EX	B ON A.SEQ = B.PM_BS_SEQ
WHERE BS_YEAR = @BsYear
    AND MONTHLY = @Monthly
    AND ORG_COMPANY_SEQ = @OrgCompanySeq ";

                    return con.Query<PmBsBsheetEx>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public PmBsBsheetEx selectOne(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = " SELECT * " +
                        " FROM PM_BS_BSHEET_EX " +
                        " WHERE PM_BS_SEQ = @PmBsSeq ";

                    return con.Query<PmBsBsheetEx>(query, param).First();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public int update(PmBsBsheetEx entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " UPDATE PM_BS_BSHEET_EX SET " +
                        // 이부분은 수정하여 사용하세요. 
                        //" , PM_BS_SEQ = @PmBsSeq" +
                        " ASSETS = @Assets" +
                        " , CURRENT_ASSETS = @CurrentAssets" +
                        " , LIABILITIES = @Liabilities" +
                        " , CURRENT_LIABILITIES = @CurrentLiabilities" +
                        " , CAPITAL = @Capital" +
                        " , CASH = @Cash" +
                        " , LOAN = @Loan" +
                        " , LIABILITIES_RATE = @LiabilitiesRate" +
                        " , CURRENT_RATE = @CurrentRate" +
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