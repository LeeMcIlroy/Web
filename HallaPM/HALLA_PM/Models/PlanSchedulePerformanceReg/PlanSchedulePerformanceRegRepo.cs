using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Data;
using Dapper;
using HALLA_PM.Util;

namespace HALLA_PM.Models
{
    public class PlanSchedulePerformanceRegRepo : DbCon, IPlanSchedulePerformanceRegRepo
    {
        public int count(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " SELECT COUNT(*) FROM PLAN_SCHEDULE_PERFORMANCE_REG ";
                    return con.Query<int>(query, param).First();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return -1;
                }
            }
        }

        public IEnumerable<PlanSchedulePerformanceReg> selectList(object param)
        {
            //Search search = (Search)param;
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string where = " WHERE 1 = 1 ";
                    where += " AND SCHEDULE_YEAR = @ScheduleYear ";

                    string query = " SELECT	* " +
                        " FROM    PLAN_SCHEDULE_PERFORMANCE_REG " +
                        "  " + where +
                        " ORDER BY REG_MONTH ASC ";

                    //search.TotalCount = count(search);
                    //search.MakePaging();

                    return con.Query<PlanSchedulePerformanceReg>(query, param).ToList();

                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public PlanSchedulePerformanceReg selectOne(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = " SELECT * " +
                        " FROM PLAN_SCHEDULE_PERFORMANCE_REG " +
                        " WHERE SCHEDULE_YEAR = @ScheduleYear AND REG_MONTH = @RegMonth ";

                    return con.Query<PlanSchedulePerformanceReg>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public int insert(PlanSchedulePerformanceReg entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = " INSERT INTO PLAN_SCHEDULE_PERFORMANCE_REG ( " +
                        " SCHEDULE_YEAR " +
                        " , REG_MONTH " +
                        " , REG_DT_START " +
                        " , REG_DT_END " +
                        " ) VALUES ( " +
                        " @ScheduleYear " +
                        " , @RegMonth " +
                        " , @RegDtStart " +
                        " , @RegDtEnd " +
                        " ); SELECT @@ROWCOUNT ";
                    return con.Query<int>(query, entity).First();

                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return -1;
                }
            }
        }

        public int update(PlanSchedulePerformanceReg entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = " UPDATE PLAN_SCHEDULE_PERFORMANCE_REG SET " +
                        " REG_DT_START = @RegDtStart " +
                        " , REG_DT_END = @RegDtEnd " +
                        " WHERE SCHEDULE_YEAR = @ScheduleYear " +
                        " AND REG_MONTH = @RegMonth " +
                        " SELECT @@ROWCOUNT ";
                    return con.Query<int>(query, entity).First();

                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return -1;
                }
            }
        }

        public int delete(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = " DELETE PLAN_SCHEDULE_PERFORMANCE_REG " +
                        " WHERE SCHEDULE_YEAR = @ScheduleYear " +
                        " AND REG_MONTH = @RegMonth ";
                    return con.Execute(query, param);

                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return -1;
                }
            }
        }

        public int deleteYear(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = " DELETE PLAN_SCHEDULE_PERFORMANCE_REG " +
                        " WHERE SCHEDULE_YEAR = @ScheduleYear ";
                    return con.Execute(query, param);

                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return -1;
                }
            }
        }

        public int save(PlanSchedulePerformanceReg entity)
        {
            var item = selectOne(entity);

            if (item == null)
            {
                return insert(entity);
            }
            else
            {
                return update(entity);
            }
        }

        public void Dispose()
        {
            throw new NotImplementedException();
        }
    }
}