using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Transactions;
using System.Web;
using System.Web.Mvc;
using System.Web.Optimization;
using System.Web.Routing;

using Castle.Data;
using System.Web.Security;
using System.Web.WebPages;
using Newtonsoft.Json;

namespace HallaTube
{
    // 참고: IIS6 또는 IIS7 클래식 모드를 사용하도록 설정하는 지침을 보려면 
    // http://go.microsoft.com/?LinkId=9394801을 방문하십시오.

    public class MvcApplication : System.Web.HttpApplication
    {
        protected void Application_Start()
        {
            AreaRegistration.RegisterAllAreas();

            FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);

            var settings = new JsonSerializerSettings();
            settings.DateFormatString = Const.DateHHmmss;
            JsonConvert.DefaultSettings = new Func<JsonSerializerSettings>(() => { return settings; });

            Logger.LogPath = Server.MapPath("~/Log/");

            Config.Domain = System.Configuration.ConfigurationManager.AppSettings["Domain"];
            Config.DBName = System.Configuration.ConfigurationManager.AppSettings["DBName"];

            var conn = System.Configuration.ConfigurationManager.ConnectionStrings[Config.DBName];
            string[] connitem = conn.ConnectionString.Split(';');
            foreach (string item in connitem)
            {
                string[] t = item.Split('=');
                if (t.Length != 2) continue;
                if (t[0] == "Initial Catalog")
                {
                    Config.DBCatalogName = t[1];
                    break;
                }
            }

            if (System.Configuration.ConfigurationManager.ConnectionStrings["Debug"] != null)
            {
                Config.DBName = "Debug";
            }
            Castle.Data.DataAgent.DefaultDBName = Config.DBName;
            var setting = System.Configuration.ConfigurationManager.ConnectionStrings[Config.DBName];
            Castle.Data.DataAgent.DefaultDBType = (int)DataAgentFactory.GetDataProvideType(Config.DBName);

            Castle.Data.SqlHelper.CommandTimeout = 60 * 2;

            bool use = System.Configuration.ConfigurationManager.AppSettings["UseDBLog"] == Const.True;
            if (use)
            {
                Logger.GetLogDataEvent += Logger_GetLogDataEvent;
            }
            tranOption = new TransactionOptions();
            tranOption.IsolationLevel = System.Transactions.IsolationLevel.ReadCommitted;
            tranOption.Timeout = new TimeSpan(0, 0, 30);


            //ModelBinders.Binders.Add(typeof(IList), new CollectionBinder());
            //ControllerBuilder.Current.SetControllerFactory(new WindsorControllerFactory());

            Config.AppName = System.Configuration.ConfigurationManager.AppSettings["AppName"];
            Config.AppPath = System.Configuration.ConfigurationManager.AppSettings["AppPath"];
            Config.SystemChar = System.Configuration.ConfigurationManager.AppSettings["SystemChar"];
            Config.FileRoot = System.Configuration.ConfigurationManager.AppSettings["FileRoot"];
            Config.FileRootMapPath = Server.MapPath(Config.FileRoot);


            XMLQuery.ResourceFilePath = Server.MapPath(System.Configuration.ConfigurationManager.AppSettings["QueryResourcePath"]);
            XMLQuery.ResourceFileFilter = System.Configuration.ConfigurationManager.AppSettings["QueryResourceFilter"];
            XMLQuery.Init();

            Config.LoadConfiguration();

            LanguageManager.Initialize();
            LanguageManager.Load(Server.MapPath("~/js/"), "libraryLanguageData.json");
            
            
            StartDailyTimer();
        }

        private void StartDailyTimer()
        {
            Timer timerDaily = null;
            timerDaily = new Timer(new TimerCallback(p =>
            {
                try
                {
                    DateTime now = DateTime.Today;
                    
                    
                }
                catch(Exception ex)
                {
                    Logger.WriteLog(ex.Message, "Error", ex);
                }
                

                timerDaily.Change(5 * 60 * 1000, Timeout.Infinite);
            }), null, Timeout.Infinite, Timeout.Infinite);


#if DEBUG
            timerDaily.Change(5 * 1000, Timeout.Infinite);
#else
            timerDaily.Change(5 * 1000, Timeout.Infinite);
#endif
        }

        protected void Session_Start(object sender, EventArgs e)
        {
            if (Request.LogonUserIdentity.IsAuthenticated) return;
#if DEBUG
            FormsAuthentication.SetAuthCookie("admin", false);
#else
            var cookie = Request.Cookies["EP_USER_KEY"];
            if (cookie == null)
            {
                
            }
            else
            {
                string userId = cookie.Value;
                FormsAuthentication.SetAuthCookie(userId, false);
            }
#endif
            //string defaultuserid = System.Configuration.ConfigurationManager.AppSettings["DefaultUserID"];

            //if (!string.IsNullOrEmpty(defaultuserid))
            //{
            //    FormsAuthentication.SetAuthCookie(defaultuserid, false);
            //}


        }

        protected void Session_End(object sender, EventArgs e)
        {
        }

        protected void Application_Error(object sender, EventArgs e)
        {
            Exception ex = Server.GetLastError();
            if (ex is System.Web.HttpException)
            {
                //0x80004005 HTTP 헤더를 보낸 후에는 서버에서 내용 형식을 설정할 수 없습니다
                if (ex.Message.IndexOf("0x800703E3") > 0)//원격 호스트에서 연결을 닫았습니다
                {
                    Server.ClearError();
                    return;
                }
            }

            Logger.WriteLog(null, "Error", ex);
        }




        private static TransactionOptions tranOption;
        private const string insquery =
@"
DELETE TB_LOG WHERE REG_DATE<@DELETE_DATE
INSERT INTO TB_LOG(LOG_ID,CATEGORY,SYSTEM,THREAD,IS_ERROR,REG_DATE,REQUEST_ID,DOC_ID,USER_ID,MESSAGE)
VALUES(@LOG_ID,@CATEGORY,@SYSTEM,@THREAD,@IS_ERROR,@REG_DATE,@REQUEST_ID,@DOC_ID,@USER_ID,@MESSAGE)";
        private static Dictionary<string, string> Logger_GetLogDataEvent()
        {

            if (System.Web.HttpContext.Current != null)
            {
                var context = System.Web.HttpContext.Current;
                if (context != null)
                {
                    if (context.Session != null)
                    {
                        Dictionary<string, string> dic = new Dictionary<string, string>();
                        dic.Add("RequestID", context.Session["_RequestID"] as string);
                        dic.Add("DocID", context.Session["_DocID"] as string);
                        dic.Add("UserID", context.Session["_UserID"] as string);

                        return dic;
                    }
                }
            }

            return null;
        }


        private static string WriteLogDB(string msg, string category, Exception e)
        {
            DataPack dp = new DataPack();

            string logID = Sequence.Generate();
            string requestID = string.Empty;
            string docID = string.Empty;
            string userID = string.Empty;

            if (System.Web.HttpContext.Current != null)
            {
                var context = System.Web.HttpContext.Current;
                if (context != null)
                {
                    if (context.Session != null)
                    {
                        requestID = context.Session["_RequestID"] as string;
                        docID = context.Session["_DocID"] as string;
                        userID = context.Session["_UserID"] as string;
                    }
                }
            }

            dp["LOG_ID"].Value = logID;
            dp["CATEGORY"].Value = category;
            dp["SYSTEM"].Value = Config.SystemChar;
            dp["THREAD"].Value = Thread.CurrentThread.ManagedThreadId;
            dp["IS_ERROR"].Value = e == null ? Const.False : Const.True;
            dp["REG_DATE"].Value = DateTime.Now;
            dp["REQUEST_ID"].Value = requestID;
            dp["DOC_ID"].Value = docID;
            dp["USER_ID"].Value = userID;
            dp["MESSAGE"].Value = msg;
            dp["DELETE_DATE"].Value = DateTime.Now.AddMonths(-3);

            using (TransactionScope scope = new TransactionScope(TransactionScopeOption.Suppress, tranOption))
            {
                var agent = DataAgent.GetDBAgent();
                agent.ExecuteNonQuery(insquery, dp);
                scope.Complete();
            }

            return logID;
        }

        private static string WriteError(string logID, Exception ex, string category, string userID)
        {
            //The remote host closed the connection. The error code is 0x80070040.
            //원격 호스트에서 연결을 닫았습니다. 오류 코드는 0x80070057입니다.

            if (ex.Message.IndexOf("The remote host closed the connection") >= 0 || ex.Message.IndexOf("원격 호스트에서 연결을 닫았습니다") >= 0)
            {
                return string.Empty;
            }

            var context = System.Web.HttpContext.Current;

            DataPack dp = new DataPack();
            dp["ERROR_ID"].Value = logID;
            dp["ERROR_TYPE"].Value = category;
            dp["MESSAGE"].Value = ex.Message;
            dp["TRACE"].Value = ex.ToString();

            dp["USER_ID"].Value = userID;
            dp["USER_NM"].Value = string.Empty;// _User.UserName;

            if (context == null)
            {
                dp["URL"].Value = string.Empty;
                dp["HTTP_COOKIE"].Value = string.Empty;
                dp["HTTP_SERVER"].Value = string.Empty;
                dp["HTTP_FORM"].Value = string.Empty;
            }
            else
            {
                dp["URL"].Value = context.Request.RawUrl;

                StringBuilder sb = new StringBuilder();
                foreach (string key in context.Request.Form.AllKeys)
                {
                    sb.AppendFormat("{0}: {1}\r\n", key, context.Request.Form[key]);
                }
                dp["HTTP_FORM"].Value = sb.ToString();

                sb = new StringBuilder();
                foreach (string key in context.Request.ServerVariables.AllKeys)
                {
                    sb.AppendFormat("{0}: {1}\r\n", key, context.Request.ServerVariables[key]);
                }
                dp["HTTP_SERVER"].Value = sb.ToString();

                sb = new StringBuilder();
                foreach (string key in context.Request.Cookies.AllKeys)
                {
                    sb.AppendFormat("{0}: {1}\r\n", key, context.Request.Cookies[key].Value);
                }
                dp["HTTP_COOKIE"].Value = sb.ToString();
            }


            string qry = "INSERT INTO TB_ERROR VALUES(@ERROR_ID,@USER_ID,@USER_NM,@ERROR_TYPE,@MESSAGE,@TRACE,@URL,@HTTP_COOKIE,@HTTP_SERVER,@HTTP_FORM,GETUTCDATE())";
            using (TransactionScope scope = new TransactionScope(TransactionScopeOption.Suppress, tranOption))
            {
                var agent = DataAgent.GetDBAgent();
                agent.ExecuteNonQuery(qry, dp, false);
                scope.Complete();
            }

            return logID;
        }
    }
}