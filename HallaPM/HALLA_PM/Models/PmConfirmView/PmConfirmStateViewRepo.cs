using Dapper;
using HALLA_PM.Util;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;

namespace HALLA_PM.Models
{
    public class PmConfirmStateViewRepo : DbCon, IPmConfirmStateViewRepo
    {


        public int count(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                con.Open();
                try
                {
                    Search search = (Search)param;

                    string where = @" WHERE 1 = 1  
                                        AND D.AUTH_USER_KEY = @AuthUserKey  ";
                    if (search.searchCpySeq > 0)
                    {
                        where += " AND A.ORG_COMPANY_SEQ = @searchCpySeq";
                    }
                    if (!string.IsNullOrEmpty(search.searchYear))
                    {
                        where += " AND A.PM_YEAR =  @searchYear ";
                    }
                    if (!string.IsNullOrEmpty(search.searchMonth))
                    {
                        where += " AND A.MONTHLY =  @searchMonth ";
                    }

                    string query = @"SELECT count(*) FROM PM_CONFIRM_STATE_VIEW A  
                                    INNER JOIN ADMIN_ORG_AUTH D ON A.ORG_COMPANY_SEQ = D.ORG_COMPANY_SEQ " + where;
                    return con.Query<int>(query, param).First();
                }
                catch (Exception e)
                {
                    LogUtil.Error(e.ToString());
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

        public int insert(PmConfirmStateView entity)
        {
            throw new NotImplementedException();
        }

        public int save(PmConfirmStateView entity)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<PmConfirmStateView> selectList(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                con.Open();
                try
                {
                    Search search = (Search)param;

                    string where = @" WHERE 1 = 1  
                                        AND D.AUTH_USER_KEY = @AuthUserKey  ";
                    if (search.searchCpySeq > 0)
                    {
                        where += " AND A.ORG_COMPANY_SEQ = @searchCpySeq";
                    }
                    if (!string.IsNullOrEmpty(search.searchYear))
                    {
                        where += " AND A.PM_YEAR =  @searchYear ";
                    }
                    if (!string.IsNullOrEmpty(search.searchMonth))
                    {
                        where += " AND A.MONTHLY =  @searchMonth ";
                    }
                    string query = @"SELECT  ROW_NUMBER() OVER (ORDER BY A.PM_YEAR DESC , A.MONTHLY DESC) AS ROW_NUM,
			                                A.*,(SELECT TOP 1 CONFIRM_COMMENT FROM PM_CONFIRM_LOG
                                                    WHERE PM_YEAR = A.PM_YEAR AND MONTHLY = A.MONTHLY AND ORG_COMPANY_SEQ = A.ORG_COMPANY_SEQ
                                                    ORDER BY SEQ DESC) AS  CONFIRM_COMMENT
		                                FROM PM_CONFIRM_STATE_VIEW  A  INNER JOIN ADMIN_ORG_AUTH D ON A.ORG_COMPANY_SEQ = D.ORG_COMPANY_SEQ " + where + @"
                                    ORDER BY  A.PM_YEAR DESC, A.MONTHLY DESC 
                                    OFFSET @PageCount * (@PageIndex -1)  ROWS FETCH NEXT @PageCount ROW ONLY ;
                                    ";
                    search.TotalCount = count(search);
                    search.MakePaging();
                    return con.Query<PmConfirmStateView>(query, param).ToList();
                }
                catch (Exception e)
                {
                    LogUtil.Error(e.ToString());
                    return null;
                }
            }
        }

        public PmConfirmStateView selectOne(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                con.Open();
                try
                {
                    
                    string where = @" WHERE 1 = 1   ";                     
                        where += " AND  ORG_COMPANY_SEQ = @searchCpySeq";                    
                        where += " AND  PM_YEAR =  @searchYear ";                    
                        where += " AND  MONTHLY =  @searchMonth ";
                     
                    string query = @"SELECT *  FROM PM_CONFIRM_STATE_VIEW   " + where + @" ; "; 
                    return con.Query<PmConfirmStateView>(query, param).First();
                }
                catch (Exception e)
                {
                    LogUtil.Error(e.ToString());
                    return null;
                }
            }
        }

        public PmConfirmStateView selectComment(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                con.Open();
                try
                {

                    string where = @" WHERE 1 = 1   ";
                    where += " AND  ORG_COMPANY_SEQ = @searchCpySeq";
                    where += " AND  PM_YEAR =  @searchYear ";
                    where += " AND  MONTHLY =  @searchMonth ";

                    string query = @" SELECT *, (SELECT TOP 1 confirm_comment   FROM PM_CONFIRM_LOG WITH(NOLOCK)
                                        " + where + @"
                                        AND  confirm_comment IS NOT NULL
                                        ORDER BY SEQ DESC ) as confirm_comment
                                        FROM PM_CONFIRM_STATE_VIEW WITH(NOLOCK)   " + where + @" ; ";
                    return con.Query<PmConfirmStateView>(query, param).First();
                }
                catch (Exception e)
                {
                    LogUtil.Error(e.ToString());
                    return null;
                }
            }
        }

        public PmConfirmStateView selectView(object param,string strPageType,string strTableName)
        {
            using (IDbConnection con = GetHallaDb())
            {
                con.Open();
                try
                {

                    string where = @" WHERE 1 = 1   ";
                    where += " AND  ORG_COMPANY_SEQ = @searchCpySeq";
                    where += " AND  " + strPageType + "_YEAR =  @searchYear ";
                    where += " AND  MONTHLY =  @searchMonth ";

                    string query = @" SELECT  * FROM " + strTableName + " " + where + @" ; ";
                    return con.Query<PmConfirmStateView>(query, param).First();
                }
                catch (Exception e)
                {
                    LogUtil.Error(e.ToString());
                    return null;
                }
            }
        }

        public int update(PmConfirmStateView entity)
        {
            throw new NotImplementedException();
        }

        public int statusChangeAll(object param)
        {
            int intReturn = 0;
            using (IDbConnection con = GetHallaDb())
            {
                con.Open();
                try
                {
                    PmConfirmLog pmConfirmLog = (PmConfirmLog)param;
                    string query = "USP_PM_CONFIRM_LOG_INSERT";
                    intReturn = con.Execute(query, new {
                                                            PM_YEAR = pmConfirmLog.pmYear,
                                                            MONTHLY = pmConfirmLog.monthly,
                                                            ORG_COMPANY_SEQ = pmConfirmLog.orgCompanySeq,
                                                            PRE_STATUS = pmConfirmLog.preStatus,
                                                            CONFIRM_STATUS = pmConfirmLog.confirmStatus,
                                                            CONFIRM_COMMENT = pmConfirmLog.confirmComment,
                                                            USER_KEY = pmConfirmLog.userKey,
                                                            USER_IP = pmConfirmLog.userIp
                                                        }, commandType: CommandType.StoredProcedure);
                    return intReturn;
                }
                catch (Exception e)
                {
                    LogUtil.Error(e.ToString());
                    return intReturn;
                }
            }
        }
    }
}