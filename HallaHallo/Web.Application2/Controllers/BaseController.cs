using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Reflection;
using System.Data;
using Castle.Data;
//using System.Web.Script.Serialization;
using System.Web.Security;
using HallaTube;
using System.Web.WebPages;
using System.Web.Helpers;
using System.Security.Cryptography;
using System.Text;

namespace HallaTube
{
    public abstract class BaseController : Controller
    {

        public bool _IsLoggable { set; get; }
        public bool _IsView { set; get; }

        public DateTime _dtActionStart;
        public DateTime _dtActionEnd;

        public string _RequestID = string.Empty;

        static BaseController()
        {

        }

        public BaseController()
        {
            _dtActionStart = DateTime.Now;
            _IsLoggable = (System.Configuration.ConfigurationManager.AppSettings["UsePageAccessLog"] ?? Const.False) == Const.True;
            _IsView = false;
            this.ValidateRequest = false;
        }

        public UserState _User { private set; get; }
        public LanguageManager _Text { private set; get; }

        public CategoryEntity Category { protected set; get; }
        public Dictionary<string, CategoryEntity> MenuList { protected set; get; }
        public List<CategoryEntity> TopMenuList { protected set; get; }

        public static string Encrypt(string toEncrypt, string key, bool useHashing)
        {
            byte[] keyArray;
            byte[] toEncryptArray = UTF8Encoding.UTF8.GetBytes(toEncrypt);

            if (useHashing)
            {
                MD5CryptoServiceProvider hashmd5 = new MD5CryptoServiceProvider();
                keyArray = hashmd5.ComputeHash(UTF8Encoding.UTF8.GetBytes(key));
            }
            else
                keyArray = UTF8Encoding.UTF8.GetBytes(key);

            TripleDESCryptoServiceProvider tdes = new TripleDESCryptoServiceProvider();
            //tdes.KeySize = 128;
            //return keyArray.GetLength(0).ToString();
            //return Convert.FromBase64String(key).GetLength(0).ToString();
            tdes.Key = keyArray;
            tdes.Mode = CipherMode.ECB;
            tdes.Padding = PaddingMode.PKCS7;

            ICryptoTransform cTransform = tdes.CreateEncryptor();
            byte[] resultArray = cTransform.TransformFinalBlock(toEncryptArray, 0, toEncryptArray.Length);

            return Convert.ToBase64String(resultArray, 0, resultArray.Length);
        }

        public static string Decrypt(string toDecrypt, string key, bool useHashing)
        {
            byte[] keyArray;
            byte[] toEncryptArray = Convert.FromBase64String(toDecrypt);

            if (useHashing)
            {
                MD5CryptoServiceProvider hashmd5 = new MD5CryptoServiceProvider();
                keyArray = hashmd5.ComputeHash(UTF8Encoding.UTF8.GetBytes(key));
            }
            else
                keyArray = UTF8Encoding.UTF8.GetBytes(key);

            TripleDESCryptoServiceProvider tdes = new TripleDESCryptoServiceProvider();
            tdes.Key = keyArray;
            tdes.Mode = CipherMode.ECB;
            tdes.Padding = PaddingMode.PKCS7;

            ICryptoTransform cTransform = tdes.CreateDecryptor();
            byte[] resultArray = cTransform.TransformFinalBlock(toEncryptArray, 0, toEncryptArray.Length);

            return UTF8Encoding.UTF8.GetString(resultArray);
        }
        protected override void OnAuthorization(AuthorizationContext filterContext)
        {
#if DEBUG
            XMLQuery.Init();
#endif
            //TODO : Debug 시 그룹웨어 세션값 가져오기
            //원본 : 00002.X0000P90080/20200318094700
            //암호화코드 ; oW1EWf2OTAVOdI0DmJcYGhe1uFCDfLCb4rN7UrgJ2QduxgxYLkXuOQ==
            //5f97804c4a859jkv

            string spath = Request["SPATH"];
            string EP_USER_KEY = Request["EP_USER_KEY"];

            //spath = "oW1EWf2OTAVOdI0DmJcYGhe1uFCDfLCb4rN7UrgJ2QduxgxYLkXuOQ==";

            string ssoUserId = null;
            DateTime? dt = null;

            try
            {
                if (spath != null)
                {
                    #if DEBUG
                    Logger.WriteLog("spath=" + spath , "SSO", null);
                    Logger.WriteLog("ssoUserId=" + ssoUserId, "SSOUSERID", null);

                    #endif
                    if (spath == "qweqwe121")
                    {
                        //ssoUserId = "admin";'
                        ssoUserId = null;
                        filterContext.Result = Redirect("https://ep.halla.com");

                    }
                    else if (spath == "bWFpbA==")
                    {
                        ssoUserId = "guest";
                        FormsAuthentication.SetAuthCookie(ssoUserId, false);
                    }
                    else
                    {
                        string[] plain = Decrypt(spath, "5f97804c4a859jkv", false).Split('/');
                        ssoUserId = plain[0];
                        dt = DateTime.ParseExact(plain[1], "yyyyMMddHHmmss", null);
                    }

                    #if DEBUG
                    Logger.WriteLog("ssoUserId=" + ssoUserId, "SSO", null);
                 #endif
                }
                else
                {

                }


                if (User.Identity.IsAuthenticated)
                {
                    _User = Session["User"] as UserState;
                    if (string.IsNullOrEmpty(ssoUserId))
                    {
                        if (_User == null || _User.UserId != User.Identity.Name)
                        {
                            _User = new UserState(filterContext.HttpContext, User.Identity.Name);
                        }
                    }
                    else
                    {
                        if (_User == null || ssoUserId != User.Identity.Name)
                        {
                            _User = new UserState(filterContext.HttpContext, ssoUserId);
                            FormsAuthentication.SetAuthCookie(ssoUserId, false);
                        }
                    }
                }
                else
                {
                    if (ssoUserId == null)
                    {
                        filterContext.Result= Redirect("https://ep.halla.com");
                        _User = new UserState(filterContext.HttpContext, string.Empty);
                        return;
                    }
                    else
                    {
                        _User = new UserState(filterContext.HttpContext, ssoUserId);
                        FormsAuthentication.SetAuthCookie(ssoUserId, false);
                    }
                }

                Session["User"] = _User;

                if (string.IsNullOrEmpty(_User.LoginDate))
                {
                    if (dt == null) dt = DateTime.UtcNow.AddHours(_User.TimeZones);
                    _User.LoginDate = dt.Value.ToString("HH:mm:ss");
                }
                
            }
            catch(Exception ex)
            {
                Logger.WriteLog("인증 오류", "SSO", ex);
                Logger.WriteLog("ssoUserId=" + ssoUserId, "SSO", ex);

                filterContext.Result = View("SsoError");
                return;
            }


            AuthorizeAttribute attr = null;

            var attrlist = (AuthorizeAttribute[])filterContext.ActionDescriptor.GetCustomAttributes(typeof(AuthorizeAttribute), true);
            if (attrlist.Length == 0)
            {
                attrlist = (AuthorizeAttribute[])filterContext.ActionDescriptor.ControllerDescriptor.GetCustomAttributes(typeof(AuthorizeAttribute), true);
                if (attrlist.Length == 0)
                {
                    attr = new AuthorizeAttribute();
                    attr.AuthType = string.Empty;
                }
                else
                {
                    attr = attrlist[0];
                }
            }
            else
            {
                attr = attrlist[0];
            }

            if(attr.AuthType == AuthType.ADMIN)
            {
                if (_User.UserType != AuthType.ADMIN)
                {
                    filterContext.Result = new HttpStatusCodeResult(404);
                    return;
                }

                string userIp = Request.UserHostAddress;
                if (userIp.StartsWith("10.20.") || userIp.StartsWith("10.30."))
                {

                }
                else
                {
                    var configRepository = new ConfigRepository();
                    string adminIp = configRepository.Get("AdminIp")?.Value;
                    if (!string.IsNullOrEmpty(adminIp))
                    {
                        if (!adminIp.Split(',').Contains(Request.UserHostAddress))
                        {
                            filterContext.Result = new HttpStatusCodeResult(404);
                            return;
                        }
                    }
                }
            }

            if (attr.AuthType == AuthType.USER && _User.UserType == AuthType.NONE)
            {
                filterContext.Result = new RedirectResult(FormsAuthentication.LoginUrl);
                return;
            }


            string redirectUrl = Request["rUrl2"];
            if (!string.IsNullOrEmpty(redirectUrl))
            {
                filterContext.Result=new RedirectResult(redirectUrl);
                return;
            }

            base.OnAuthorization(filterContext);
        }

        protected override void OnResultExecuting(ResultExecutingContext filterContext)
        {
            base.OnResultExecuting(filterContext);
        }

        protected override void OnResultExecuted(ResultExecutedContext filterContext)
        {
            base.OnResultExecuted(filterContext);
        }

        protected override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            Session["_RequestID"] = Sequence.Generate();

            _Text = LanguageManager.Instance[_User.Language];

            ViewData["_User"] = this._User;
            ViewData["_Text"] = this._Text;
            ViewData["_ServerIP"] = Request.ServerVariables["SERVER_NAME"];

            var menu = WebCache.Get("Menu") as Dictionary<string, CategoryEntity>;
            if (menu == null)
            {
                var repo = new CategoryRepository();
                menu = repo.GetMenu();

                WebCache.Set("Menu", menu, 1);
            }
            MenuList = menu;

            var topmenu = WebCache.Get("TopMenu") as List<CategoryEntity>;
            if (topmenu == null)
            {
                topmenu = menu.Values.Where(p => p.CategoryLevel == 2).ToList();
                WebCache.Set("TopMenu", topmenu, 1);
            }
            TopMenuList = topmenu;

            DateTime? checkTime = filterContext.HttpContext.Application["CheckTime"] as DateTime?;
            if (checkTime == null)
            {
                checkTime = DateTime.Now;
            }

            if (checkTime.Value.AddDays(1) < DateTime.Now)
            {
                //string macAddress = NetUtil.GetMacAddress();

                filterContext.HttpContext.Application["CheckTime"] = checkTime;

                //throw new Exception("개발 버전입니다.");
            }

            foreach (var item in GetType().GetFields(BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic))
            {
                if (item.FieldType.IsSubclassOf(typeof(DataRepository)))
                {
                    if (item.GetValue(this) == null)
                    {
                        var service = Activator.CreateInstance(item.FieldType);
                        item.SetValue(this, service);
                    }
                }
            }



            if (Request.RequestType.ToUpper() == "GET")
            {
                _IsView = true;
            }


#if DEBUG
            ViewData["_Develop"] = false;
#else
            ViewData["_Develop"] = false;
#endif

            base.OnActionExecuting(filterContext);
        }

        protected bool? Logging = null;
        protected string LoggingData;
        protected override void OnActionExecuted(ActionExecutedContext filterContext)
        {

            string controller = filterContext.ActionDescriptor.ControllerDescriptor.ControllerName;

            bool logging = Logging != null
                ? Logging.Value
                : Request.HttpMethod == "GET" && !filterContext.IsChildAction && controller.ToLower() != "admin" && filterContext.Result is ViewResult;

            if (logging)
            {
                var logRepository = new LogRepository();

                string strConnectPath = (_User.UserId == "guest") ? "메일" : "한마루";
                var log = new LogEntity
                {
                    SessionID = Session.SessionID,
                    UserID = _User.UserId,
                    UserIp = Request.UserHostAddress,

                    Host = Request.Url.Authority,
                    Url = Request.Url.PathAndQuery,
                    Controller = controller,
                    Action = filterContext.ActionDescriptor.ActionName,
                    TargetID = filterContext.RouteData.Values["id"] as string ?? Request["id"],

                    RequestDate = DateTime.UtcNow,
                    BeginIs = Session.IsNewSession ? "Y" : "N",

                    HttpUserAgent = LoggingData ?? Request.UserAgent,
                    HttpReferer = Request.UrlReferrer?.PathAndQuery,
                    HttpRefererHost = Request.UrlReferrer?.Authority,

                    UserNm = _User.UserKornm,
                    EmpNo = _User.User.EmpNo,
                    UserEmail = _User.User.Email,
                    UserGradeID = _User.User.GradeID,
                    UserGradeNm = _User.User.GradeNm,
                    UserPositionID = _User.User.PositionNm,
                    UserPositionNm = _User.User.PositionNm,
                    UserCompID = _User.User.CompID,
                    UserCompNm = _User.User.CompNm,
                    UserDeptID = _User.User.DeptID,
                    UserDeptNm = _User.User.DeptNm,
                    UserDeptPath = _User.User.DeptPath,

                    ConnectPath = strConnectPath,
                };
                logRepository.Create(log);
            }

            _dtActionEnd = DateTime.Now;
            ViewData["_ActionStart"] = _dtActionStart;
            ViewData["_ActionEnd"] = _dtActionEnd;

            ViewData["LoggerID"] = string.Empty;

            //ViewData["DebugLog"] = Logger.GetLogQueue();

            ViewData["_TopMenu"] = TopMenuList;
            ViewData["_Menu"] = MenuList;
            ViewData["_Category"] = Category;

            base.OnActionExecuted(filterContext);
        }


        protected string GetViewPath(string type)
        {
            string path = string.Format("~/Views/{0}/{1}/{2}.cshtml", RouteData.Values["controller"], type, RouteData.Values["action"]);
            return path;
        }


        protected new ContentResult Json(object data)
        {
            return Content(Newtonsoft.Json.JsonConvert.SerializeObject(data));
        }
    }
}
