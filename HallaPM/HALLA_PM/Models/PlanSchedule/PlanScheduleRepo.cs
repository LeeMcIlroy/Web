using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Data;
using Dapper;
using HALLA_PM.Util;

namespace HALLA_PM.Models
{
    public class PlanScheduleRepo : DbCon, IPlanScheduleRepo
    {
        public int count(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " SELECT COUNT(*) FROM PLAN_SCHEDULE ";
                    return con.Query<int>(query, param).First();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return -1;
                }
            }
        }

        public IEnumerable<PlanSchedule> selectList(object param)
        {
            Search search = (Search)param;
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string where = " WHERE 1 = 1 ";

                    string query = " SELECT	ROW_NUMBER() OVER (ORDER BY SCHEDULE_YEAR ASC) AS ROW_NUM, * " +
                        " FROM    PLAN_SCHEDULE " +
                        "  " + where +
                        " ORDER BY SCHEDULE_YEAR DESC " +
                        " OFFSET @PageCount * (@PageIndex -1)  ROWS FETCH NEXT @PageCount ROW ONLY ";

                    search.TotalCount = count(search);
                    search.MakePaging();

                    return con.Query<PlanSchedule>(query, param).ToList();

                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public IEnumerable<PlanSchedule> selectListAll()
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string where = " WHERE 1 = 1 AND SCHEDULE_YEAR >= YEAR(GETDATE()) - 1";

                    string query = " SELECT	ROW_NUMBER() OVER (ORDER BY SCHEDULE_YEAR ASC) AS ROW_NUM, * " +
                        " FROM    PLAN_SCHEDULE " +
                        "  " + where +
                        " ORDER BY SCHEDULE_YEAR ";

                    return con.Query<PlanSchedule>(query).ToList();

                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public PlanSchedule selectOne(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = " SELECT * " +
                        " FROM PLAN_SCHEDULE " +
                        " WHERE SCHEDULE_YEAR = @ScheduleYear ";

                    return con.Query<PlanSchedule>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }

        public PlanSchedule selectOneMaxYear(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = " SELECT ISNULL(MAX(SCHEDULE_YEAR), CONVERT(VARCHAR(4), GETDATE(), 121) - 10) + 1 AS SCHEDULE_YEAR " +
                        " FROM PLAN_SCHEDULE " +
                        " ";

                    return con.Query<PlanSchedule>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }
        public Disclosure selectOneDisclosureMaxYear(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = " SELECT ISNULL(MAX(YEAR), CONVERT(VARCHAR(4), GETDATE(), 121) - 10) + 1 AS SCHEDULE_YEAR " +
                        " FROM DISCLOSURE " +
                        " ";

                    return con.Query<Disclosure>(query, param).FirstOrDefault();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return null;
                }
            }
        }
        public int insert(PlanSchedule entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = " INSERT INTO PLAN_SCHEDULE ( " +
                        " SCHEDULE_YEAR " +
                        " , PLAN_DT_START " +
                        " , PLAN_DT_END " +
                        " , APPLY_CHK " +
                        " , USER_KEY " +
                        " , EMP_NO " +
                        " , CREATE_DATE " +
                        " ) VALUES ( " +
                        " @ScheduleYear " +
                        " , @PlanDtStart " +
                        " , @PlanDtEnd " +
                        " , @ApplyChk " +
                        " , @UserKey " +
                        " , @EmpNo " +
                        " , GETDATE() " +
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

        public int update(PlanSchedule entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = " UPDATE PLAN_SCHEDULE SET " +
                        " PLAN_DT_START = @PlanDtStart " +
                        " , PLAN_DT_END = @PlanDtEnd " +
                        " , APPLY_CHK = @ApplyChk " +
                        " , USER_KEY = @UserKey " +
                        " , EMP_NO = @EmpNo " +
                        " , CREATE_DATE = GETDATE() " +
                        " WHERE SCHEDULE_YEAR = @ScheduleYear " +
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

                    string query = " DELETE PLAN_SCHEDULE " +
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

        public int save(PlanSchedule entity)
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