using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Data;
using Dapper;
using HALLA_PM.Util;

namespace HALLA_PM.Models
{
    public class PlanYearBsWCapitalRegExRepo : DbCon, IPlanYearBsWCapitalRegExRepo
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
                    string query = " SELECT COUNT(*) FROM PLAN_YEAR_BS_W_CAPITAL_REG_EX " + where;
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

        public int insert(PlanYearBsWCapitalRegEx entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = @" INSERT INTO PLAN_YEAR_BS_W_CAPITAL_REG_EX ( 
                             PLAN_YEAR_BS_SEQ 
                            , YEARLY_YEAR 
                            , MONTHLY 
                            , AR 
                            , AR_TO_DAYS
                            , AP
                            , AP_TO_DAYS
                            , INVENTORY
                            , INVENTORY_TO_DAYS
                             ) VALUES ( 
                             @PlanYearBsSeq 
                            , @YearlyYear
                            , @Monthly
                            , @Ar
                            , @ArToDays 
                            , @Ap
                            , @ApToDays
                            , @Inventory
                            , @InventoryToDays
                            ); SELECT CAST(SCOPE_IDENTITY() as int)";
                    return con.Query<int>(query, entity).First();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return -1;
                }
            }
        }

        public int save(PlanYearBsWCapitalRegEx entity)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<PlanYearBsWCapitalRegEx> selectList(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" SELECT * FROM PLAN_YEAR_BS_W_CAPITAL_REG_EX WHERE PLAN_YEAR_BS_SEQ = @PlanYearBsSeq  ORDER BY YEARLY_YEAR, MONTHLY";

                    return con.Query<PlanYearBsWCapitalRegEx>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public List<PlanYearBsWCapitalRegEx> selectListBefore(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    // 전년도 12월
                    string query = @"
SELECT	*
FROM	PLAN_YEAR_BS_EX				A
LEFT OUTER JOIN PLAN_YEAR_BS_W_CAPITAL_REG_EX	B ON A.SEQ = B.PLAN_YEAR_BS_SEQ AND A.YEAR_BS_YEAR = B.YEARLY_YEAR
WHERE	1 = 1
AND		A.YEAR_BS_YEAR = @YearlyYear - 1
AND		A.ORG_COMPANY_SEQ = @OrgCompanySeq
AND		B.MONTHLY  = '12'
";
                    return con.Query<PlanYearBsWCapitalRegEx>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public PlanYearBsWCapitalRegEx selectOne(object param)
        {
            throw new NotImplementedException();
        }

        public PlanYearBsWCapitalRegEx selectOneYear(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @"
SELECT	*
FROM	PLAN_YEAR_BS_EX				    A
LEFT OUTER JOIN PLAN_YEAR_BS_W_CAPITAL_REG_EX	B ON A.SEQ = B.PLAN_YEAR_BS_SEQ
WHERE	1 = 1
AND		A.YEAR_BS_YEAR = @BsYear
AND		A.ORG_COMPANY_SEQ = @OrgCompanySeq
AND		B.MONTHLY  = @Monthly
";
                    return con.Query<PlanYearBsWCapitalRegEx>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public int update(PlanYearBsWCapitalRegEx entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = @" UPDATE PLAN_YEAR_BS_W_CAPITAL_REG_EX SET
                                        AR = @Ar
                                        ,AR_TO_DAYS = @ArToDays 
                                        ,AP = @Ap 
                                        ,AP_TO_DAYS = @ApToDays 
                                        ,INVENTORY = @Inventory 
                                        ,INVENTORY_TO_DAYS = @InventoryToDays
                                    WHERE SEQ = @Seq 
                                    SELECT @@ROWCOUNT ";
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