using Dapper;
using HALLA_PM.Util;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class TbPlanYearBsRepo : DbCon, ITbPlanYearBsRepo
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

        public int insert(TbPlanYearBs entity)
        {
            throw new NotImplementedException();
        }

        public int save(TbPlanYearBs entity)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<TbPlanYearBs> selectList(object param)
        {
            throw new NotImplementedException();
        }

        public TbPlanYearBs selectOne(object param)
        {
            throw new NotImplementedException();
        }

        public int update(TbPlanYearBs entity)
        {
            throw new NotImplementedException();
        }


        public List<TbPlanYearBsExp> selectListExp(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = "";
                    query += " SELECT * ";
                    query += " FROM PLAN_YEAR_BS ";
                    query += " WHERE YEAR_BS_YEAR = @year ";
                    query += " ORDER BY SEQ ASC ";

                    List<TbPlanYearBsExp> result = con.Query<TbPlanYearBsExp>(query, param).ToList();

                    foreach (var item in result)
                    {
                        query = "";
                        query += " SELECT * ";
                        query += " FROM PLAN_YEAR_BS_SUMMARY ";
                        query += " WHERE PLAN_YEAR_BS_SEQ = @seq ";
                        query += " ORDER BY YEARLY_YEAR ASC ";

                        item.planYearBsSummaryList = con.Query<PlanYearBsSummary>(query, item).ToList();
                    }

                    return result;
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