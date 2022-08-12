using Dapper;
using HALLA_PM.Core;
using HALLA_PM.Util;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class TbPlanMonthlyPalRepo : DbCon, ITbPlanMonthlyPalRepo
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

        public int insert(TbPlanMonthlyPal entity)
        {
            throw new NotImplementedException();
        }

        public int save(TbPlanMonthlyPal entity)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<TbPlanMonthlyPal> selectList(object param)
        {
            throw new NotImplementedException();
        }

        public TbPlanMonthlyPal selectOne(object param)
        {
            throw new NotImplementedException();
        }

        public int update(TbPlanMonthlyPal entity)
        {
            throw new NotImplementedException();
        }


        public List<TbPlanMonthlyPalExp> selectListExp(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = "";
                    query += " SELECT * ";
                    query += " FROM PLAN_MONTHLY_PAL ";
                    query += " WHERE MONTHLY_PAL_YEAR = @year ";
                    query += "     AND REGIST_STATUS = " + Define.REGIST_STATUS.GetKey("최종승인");

                    List<TbPlanMonthlyPalExp> result = con.Query<TbPlanMonthlyPalExp>(query, param).ToList();

                    foreach (var item in result)
                    {
                        query = "";
                        query += " SELECT * ";
                        query += " FROM PLAN_MONTHLY_PAL_BUSINESS ";
                        query += " WHERE PLAN_MONTHLY_PAL_SEQ = @seq ";

                        item.tbPlanMonthlyPalBusinessList = con.Query<TbPlanMonthlyPalBusiness>(query, item).ToList();
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