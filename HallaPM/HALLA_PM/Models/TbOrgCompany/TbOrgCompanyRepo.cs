using Dapper;
using HALLA_PM.Util;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using HALLA_PM.Core;
using System.Web;

namespace HALLA_PM.Models
{
    public class TbOrgCompanyRepo : DbCon, ITbOrgCompanyRepo
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

        public int insert(TbOrgCompany entity)
        {
            throw new NotImplementedException();
        }

        public int save(TbOrgCompany entity)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<TbOrgCompanyExp> selectListByPlanYearPal(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = "";
                    query += " SELECT A.* ";
                    query += " FROM ORG_COMPANY A ";
                    query += "     , PLAN_YEAR_PAL B ";
                    query += " WHERE A.SEQ = B.ORG_COMPANY_SEQ ";
                    //query += "     AND IS_USE = 'Y' ";
                    query += "     AND B.REGIST_STATUS = " + Define.REGIST_STATUS.GetKey("최종승인");
                    query += "    AND B.YEAR_PAL_YEAR = @year ";
                    query += " ORDER BY SEQ ASC ";

                    List<TbOrgCompanyExp> result = con.Query<TbOrgCompanyExp>(query, param).ToList();
                    foreach(var item in result)
                    {
                        query = "";
                        query += " SELECT * ";
                        query += " FROM ORG_BUSINESS ";
                        query += " WHERE ORG_COMPANY_SEQ = @seq ";
                        query += "     AND IS_USE = 'Y' ";
                        query += " ORDER BY SEQ ASC ";

                        item.orgBusinessList = con.Query<OrgBusinessExp>(query, item).ToList();
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

        public IEnumerable<TbOrgCompanyExp> selectListByPlanMonthlyPal(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = "";
                    query += " SELECT A.* ";
                    query += " FROM ORG_COMPANY A ";
                    query += "     , PLAN_MONTHLY_PAL B ";
                    query += " WHERE A.SEQ = B.ORG_COMPANY_SEQ ";
                    query += "     AND IS_USE = 'Y' ";
                    query += "     AND B.REGIST_STATUS = " + Define.REGIST_STATUS.GetKey("최종승인");
                    query += "     AND B.MONTHLY_PAL_YEAR = @year ";
                    query += " ORDER BY SEQ ASC ";

                    List<TbOrgCompanyExp> result = con.Query<TbOrgCompanyExp>(query, param).ToList();
                    foreach (var item in result)
                    {
                        query = "";
                        query += " SELECT * ";
                        query += " FROM ORG_BUSINESS ";
                        query += " WHERE ORG_COMPANY_SEQ = @seq ";
                        query += "     AND IS_USE = 'Y' ";
                        query += " ORDER BY SEQ ASC ";

                        item.orgBusinessList = con.Query<OrgBusinessExp>(query, item).ToList();
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
        public IEnumerable<TbOrgCompanyExp> selectListByPlanYearCf(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = "";
                    query += " SELECT A.* ";
                    query += " FROM ORG_COMPANY A ";
                    query += "     , PLAN_YEAR_CF B ";
                    query += " WHERE A.SEQ = B.ORG_COMPANY_SEQ ";
                    query += "     AND IS_USE = 'Y' ";
                    query += "     AND B.REGIST_STATUS = " + Define.REGIST_STATUS.GetKey("최종승인");
                    query += "     AND B.YEAR_CF_YEAR = @year ";
                    query += " ORDER BY SEQ ASC ";

                    List<TbOrgCompanyExp> result = con.Query<TbOrgCompanyExp>(query, param).ToList();
                    foreach (var item in result)
                    {
                        query = "";
                        query += " SELECT * ";
                        query += " FROM ORG_BUSINESS ";
                        query += " WHERE ORG_COMPANY_SEQ = @seq ";
                        query += "     AND IS_USE = 'Y' ";
                        query += " ORDER BY SEQ ASC ";

                        item.orgBusinessList = con.Query<OrgBusinessExp>(query, item).ToList();
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

        public IEnumerable<TbOrgCompanyExp> selectListByPlanYearBs(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    string query = "";
                    query += " SELECT A.* ";
                    query += " FROM ORG_COMPANY A ";
                    query += "     , PLAN_YEAR_BS B ";
                    query += " WHERE A.SEQ = B.ORG_COMPANY_SEQ ";
                    query += "     AND IS_USE = 'Y' ";
                    query += "     AND B.REGIST_STATUS = " + Define.REGIST_STATUS.GetKey("최종승인");
                    query += "     AND B.YEAR_BS_YEAR = @year ";
                    query += " ORDER BY SEQ ASC ";

                    List<TbOrgCompanyExp> result = con.Query<TbOrgCompanyExp>(query, param).ToList();
                    foreach (var item in result)
                    {
                        query = "";
                        query += " SELECT * ";
                        query += " FROM ORG_BUSINESS ";
                        query += " WHERE ORG_COMPANY_SEQ = @seq ";
                        query += "     AND IS_USE = 'Y' ";
                        query += " ORDER BY SEQ ASC ";

                        item.orgBusinessList = con.Query<OrgBusinessExp>(query, item).ToList();
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

        public IEnumerable<TbOrgCompanyExp> selectListByPlanYearInvest(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();

                    // 2018.12.14 그룹합산을 위해 데이터는 모든 회사를 가져온다.
                    string query = "";
                    query += " SELECT A.*, A.SEQ AS ID, A.ORG_UNION_SEQ AS UP_ID ";
                    query += " FROM ORG_COMPANY A ";
                    query += "     , PLAN_YEAR_INVEST B ";
                    query += " WHERE A.SEQ = B.ORG_COMPANY_SEQ ";
                    //query += "     AND IS_USE = 'Y' ";
                    query += "     AND B.REGIST_STATUS = " + Define.REGIST_STATUS.GetKey("최종승인");
                    query += "     AND B.YEAR_INVEST_YEAR = @year ";
                    query += " ORDER BY ORG_UNION_SEQ, SEQ ";

                    List<TbOrgCompanyExp> result = con.Query<TbOrgCompanyExp>(query, param).ToList();
                    foreach (var item in result)
                    {
                        query = "";
                        query += " SELECT * ";
                        query += " FROM ORG_BUSINESS ";
                        query += " WHERE ORG_COMPANY_SEQ = @seq ";
                        query += "     AND IS_USE = 'Y' ";
                        query += " ORDER BY SEQ ASC ";

                        item.orgBusinessList = con.Query<OrgBusinessExp>(query, item).ToList();
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
        public TbOrgCompany selectOne(object param)
        {
            throw new NotImplementedException();
        }

        public int update(TbOrgCompany entity)
        {
            throw new NotImplementedException();
        }

        IEnumerable<TbOrgCompany> IBaseRepo<TbOrgCompany>.selectList(object param)
        {
            throw new NotImplementedException();
        }
    }
}