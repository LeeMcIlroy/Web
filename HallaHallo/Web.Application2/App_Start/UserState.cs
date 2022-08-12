using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Security;
using System.Data;

namespace HallaTube
{
    public class UserState : UserModel
    {
        protected HttpContextBase httpContext { set; get; }
        protected HttpCookie cookieRoot { set; get; }

        private void init(HttpContextBase context)
        {
            httpContext = context;
            cookieRoot = httpContext.Request.Cookies[Const.Name];

            if (cookieRoot == null)
            {
                cookieRoot = new HttpCookie(Const.Name);
                cookieRoot.HttpOnly = true;
                httpContext.Request.Cookies.Add(cookieRoot);
            }
        }

        public UserState(HttpContextBase context)
        {
            init(context);
        }

        public UserState(HttpContextBase context, string userId) : base(userId)
        {
            init(context);
        }

        
        protected HttpCookie SetCookie(string key, string value, string name = Const.Name)
        {
            if (cookieRoot == null) return null;

            if (value == null)
            {
                value = string.Empty;
            }

            if (name == null)
            {
                if (cookieRoot.Values[key] != value)
                {
                    cookieRoot.Values[key] = value;
                    httpContext.Response.Cookies.Add(cookieRoot);
                }
                return cookieRoot;
            }
            else if (name == string.Empty)
            {
                var cookie = httpContext.Request.Cookies[key];
                if (cookie == null) return null;
                if (cookie.Value != value)
                {
                    cookie = httpContext.Request.Cookies[key] ?? new HttpCookie(key);
                    cookie.Value = value;
                    cookie.HttpOnly = true;
                    httpContext.Response.Cookies.Add(cookie);
                }
                return cookie;
            }
            else
            {
                if (httpContext.Request.Cookies[name] == null) return null;
                if (httpContext.Request.Cookies[name][key] != value)
                {
                    var cookie = httpContext.Request.Cookies[name] ?? new HttpCookie(name);
                    cookie.Values[key] = value;
                    cookie.HttpOnly = true;
                    httpContext.Response.Cookies.Add(cookie);
                    return cookie;
                }
            }

            return null;
        }

        protected string GetCookie(string key, string name = Const.Name)
        {
            if (name == null)
            {
                return cookieRoot[key];
            }
            else if (name == string.Empty)
            {
                if (httpContext.Request.Cookies[key] == null) return null;
                return httpContext.Request.Cookies[key].Value;
            }
            else
            {
                if (httpContext.Request.Cookies[name] == null) return null;
                return httpContext.Request.Cookies[name][key];
            }
        }





        public string LastArticleID
        {
            get { return GetCookie("LastArticleID"); }
            set { SetCookie("LastArticleID", value); }
        }

        public string LoginDate
        {
            get { return GetCookie("LoginDate"); }
            set { SetCookie("LoginDate", value); }
        }

        //public bool Office
        //{
        //    get { return (GetCookie(nameof(Office)) ?? Constant.False) == Constant.True; }
        //    set { SetCookie(nameof(Office), value ? Constant.True : Constant.False); }
        //}


        public override string Language
        {
            get { return GetCookie("Language") ?? LanguageType.KOR; }
            set { SetCookie("Language", value); }
        }

        //public override string TimeZones { set; get; }

        //public string Sort
        //{
        //    get { return GetCookie(nameof(Sort)) ?? "{}"; }
        //    set
        //    {
        //        var cookie = SetCookie(nameof(Sort), value);
        //        if (cookie != null)
        //        {
        //            cookie.Expires = DateTime.Now.AddDays(365);
        //        }
        //    }
        //}
    }
}
