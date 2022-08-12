using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace HALLA_PM.Models
{
    public class DbCon
    {
        public IDbConnection GetInsaDb()
        {
            Dapper.DefaultTypeMap.MatchNamesWithUnderscores = true;
            return new SqlConnection(WebConfigurationManager.ConnectionStrings["insa"].ConnectionString);
        }
        public IDbConnection GetHallaDb()
        {
            Dapper.DefaultTypeMap.MatchNamesWithUnderscores = true;
            return new SqlConnection(WebConfigurationManager.ConnectionStrings["hallaPM"].ConnectionString);
        }
    }
}