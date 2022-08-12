using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Runtime.Caching;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using System.Reflection;
using System.Net;
using Dapper;

namespace GCMaster.Modules
{
    public class AdminProfile
    {
        public int IDX { get; set; }

        public string ID { get; set; }

        public string Name { get; set; }

        public DateTime LoginDate { get; set; }

        public List<AuthMenu> AuthMenus { get; set; }
    }

    public class AuthMenu
    {

        /// <summary>
        /// 
        /// </summary>
        public int IDX { get; set; }

        /// <summary>
        /// 
        /// </summary>
        public string Area { get; set; }

        /// <summary>
        /// 
        /// </summary>
        public string Controller { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string Action { get; set; }

        /// <summary>
        /// 
        /// </summary>
        public string MenuName { get; set; }

    }

    public static class AuthManager
    {
        private static MemoryCache _memoryCache = new MemoryCache("AuthAdminData");


        private static void SetAuthData(string iDX)
        {
            SetAuthData(iDX, GetAuthDataFromDB(iDX));
        }

        private static void SetAuthData(string iDX, AdminProfile adminProfile)
        {
            CacheItem item = new CacheItem(iDX, adminProfile);

            CacheItemPolicy policy = new CacheItemPolicy()
            {
                AbsoluteExpiration = DateTimeOffset.Now.AddDays(1)
            };

            _memoryCache.Set(item, policy);
        }

        private static void DelAuthCache(string iDX)
        {
            _memoryCache.Remove(iDX);
        }

        private static AdminProfile GetAuthDataFromDB(string iDX)
        {
            AdminProfile adminProfile = null;

            using (var conn = Functions.ConnectionDefault)
            {
                conn.Open();

                using (var multi = conn.QueryMultiple(sql: "dbo.GCMASTER_AUTHMANAGER_AUTHDATA_SEL",
                                                        param: new
                                                        {
                                                            pIDX = iDX
                                                        },
                                                        commandType: CommandType.StoredProcedure)
                )
                {
                    adminProfile = multi.Read<AdminProfile>().First();
                    adminProfile.AuthMenus = multi.Read<AuthMenu>().ToList();

                    adminProfile.LoginDate = DateTime.Now;
                }

            }

            return adminProfile;
        }

        public static AdminProfile GetAuthData(string iDX)
        {
            if (string.IsNullOrEmpty(iDX))
                return null;


            AdminProfile adminProfile = null;

            try
            {
                object cachedData = _memoryCache.Get(iDX);

                if (cachedData != null)
                {
                    adminProfile = cachedData as AdminProfile;
                }
                else
                {
                    adminProfile = GetAuthDataFromDB(iDX);
                    SetAuthData(iDX, adminProfile);
                }

            }
            catch
            {
                return null;
            }

            return adminProfile;
        }

        public static int VerifyingAccount(string loginID, string password, string ipAddress)
        {
            int result = 0;

            using (var conn = Functions.ConnectionDefault)
            {
                conn.Open();

                result = conn.QuerySingleOrDefault<int>(sql: "dbo.GCMASTER_AUTHMANAGER_VERIFYACCOUNT_SEL",
                                                                param: new
                                                                {
                                                                    pLoginID = loginID,
                                                                    pPassword = password,
                                                                    pIpAddress = ipAddress
                                                                },
                                                                commandType: CommandType.StoredProcedure);

                if (result > 0)
                {
                    DelAuthCache(result.ToString());
                }
            }

            return result;
        }
    }
}