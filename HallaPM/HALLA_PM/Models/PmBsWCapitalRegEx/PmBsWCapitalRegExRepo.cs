using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Data;
using Dapper;
using HALLA_PM.Util;

namespace HALLA_PM.Models
{
    public class PmBsWCapitalRegExRepo : DbCon, IPmBsWCapitalRegExRepo
    {
        public int count(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " SELECT COUNT(*) FROM PM_BS_W_CAPITAL_REG_EX ";
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
                    string query = " SELECT COUNT(*) FROM PM_BS_W_CAPITAL_REG_EX " + where;
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

        public int insert(PmBsWCapitalRegEx entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " INSERT INTO  PM_BS_W_CAPITAL_REG_EX ( " +
                        // 이부분은 수정하여 사용하세요. 
                        " PM_BS_SEQ " +
                        //", SEQ " +
                        ", AR " +
                        ", AR_TO_DAYS " +
                        ", AP " +
                        ", AP_TO_DAYS " +
                        ", INVENTORY " +
                        ", INVENTORY_TO_DAYS " +
                    " ) VALUES ( " +
                    " @PmBsSeq " +
                    //", @Seq " +
                    ", @Ar " +
                    ", @ArToDays " +
                    ", @Ap " +
                    ", @ApToDays " +
                    ", @Inventory " +
                    ", @InventoryToDays " +
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

        public int save(PmBsWCapitalRegEx entity)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<PmBsWCapitalRegEx> selectList(object param)
        {
            throw new NotImplementedException();
        }

        public PmBsWCapitalRegEx selectOne(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = " SELECT * " +
                        " FROM PM_BS_W_CAPITAL_REG_EX " +
                        " WHERE PM_BS_SEQ = @PmBsSeq ";

                    return con.Query<PmBsWCapitalRegEx>(query, param).First();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }
        
        public PmBsWCapitalRegEx selectOneYear(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
SELECT	*
FROM	PM_BS_EX				A
LEFT OUTER JOIN PM_BS_W_CAPITAL_REG_EX	B ON A.SEQ = B.PM_BS_SEQ
WHERE BS_YEAR = @BsYear
    AND MONTHLY = @Monthly
    AND ORG_COMPANY_SEQ = @OrgCompanySeq ";

                    return con.Query<PmBsWCapitalRegEx>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public int update(PmBsWCapitalRegEx entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " UPDATE PM_BS_W_CAPITAL_REG_EX SET " +
                        // 이부분은 수정하여 사용하세요. 
                        //" , PM_BS_SEQ = @PmBsSeq" +
                        " AR = @Ar" +
                        " , AR_TO_DAYS = @ArToDays" +
                        " , AP = @Ap" +
                        " , AP_TO_DAYS = @ApToDays" +
                        " , INVENTORY = @Inventory" +
                        " , INVENTORY_TO_DAYS = @InventoryToDays" +
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