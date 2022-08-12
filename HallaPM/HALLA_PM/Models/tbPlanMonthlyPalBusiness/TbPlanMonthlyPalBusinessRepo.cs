using Dapper;
using HALLA_PM.Util;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class TbPlanMonthlyPalBusinessRepo : DbCon, ITbPlanMonthlyPalBusinessRepo
    {
        public int count(object param)
        {
            throw new NotImplementedException();
        }

        public int delete(object key)
        {
            throw new NotImplementedException();
        }

        public void Dispose()
        {
            throw new NotImplementedException();
        }

        public int insert(TbPlanMonthlyPalBusiness entity)
        {
            throw new NotImplementedException();
        }

        public int save(TbPlanMonthlyPalBusiness entity)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<TbPlanMonthlyPalBusiness> selectList(object param)
        {
            throw new NotImplementedException();
        }

        public TbPlanMonthlyPalBusiness selectOne(object param)
        {
            throw new NotImplementedException();
        }

        public int update(TbPlanMonthlyPalBusiness entity)
        {
            throw new NotImplementedException();
        }




        public IEnumerable<PlanMonthlyPalBusinessMonthlySum> selectSummaryList(object param)
        {

            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = "";
                    query += " SELECT MONTHLY, SUM(SALES) AS SALES , SUM(EBIT) AS EBIT ";
                    query += " FROM PLAN_MONTHLY_PAL_BUSINESS ";
                    query += " WHERE PLAN_MONTHLY_PAL_SEQ = @planMonthlyPalSeq ";
                    query += "     AND ORG_BUSINESS_SEQ = @orgBusinessSeq ";
                    query += " GROUP BY MONTHLY ";

                    return con.Query<PlanMonthlyPalBusinessMonthlySum>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

    }
}