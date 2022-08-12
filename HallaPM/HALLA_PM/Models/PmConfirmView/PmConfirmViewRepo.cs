using Dapper;
using HALLA_PM.Util;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;

namespace HALLA_PM.Models
{
    public class PmConfirmViewRepo : DbCon, IPmConfirmViewRepo
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

        public int insert(PmConfirmView entity)
        {
            throw new NotImplementedException();
        }

        public int save(PmConfirmView entity)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<PmConfirmView> selectList(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                con.Open();
                try
                {
                    string query = @"SELECT
			                                SEQ
			                                ,PLAN_YEAR
			                                ,MONTHLY
			                                ,ORG_COMPANY_SEQ
			                                ,REGIST_STATUS
			                                ,BUS_TYPE 
		                                FROM PM_CONFIRM_VIEW
		                                WHERE ORG_COMPANY_SEQ = @orgCompanySeq 
			                                AND PLAN_YEAR = @planYear
			                                AND MONTHLY = @monthly
			                                AND REGIST_STATUS = @registStatus";
                    return con.Query<PmConfirmView>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.Error(e.ToString());
                    return null;
                }
            }
        }

       public List<PmConfirmView> selectSeqList(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                con.Open();
                try
                {
                    string query = @"SELECT
			                                SEQ
			                                ,PLAN_YEAR
			                                ,MONTHLY
			                                ,ORG_COMPANY_SEQ
			                                ,REGIST_STATUS
			                                ,BUS_TYPE 
		                                FROM PM_CONFIRM_VIEW
		                                WHERE ORG_COMPANY_SEQ = @orgCompanySeq 
			                                AND PLAN_YEAR = @planYear
			                                AND MONTHLY = @monthly
			                                AND REGIST_STATUS = @registStatus";
                    return con.Query<PmConfirmView>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.Error(e.ToString());
                    return null;
                }
            }
        }

        public PmConfirmView selectOne(object param)
        {
            throw new NotImplementedException();
        }

        public int update(PmConfirmView entity)
        {
            throw new NotImplementedException();
        }
    }
}