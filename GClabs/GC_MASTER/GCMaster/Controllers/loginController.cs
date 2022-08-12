using System;
using System.Collections.Generic;
using System.Linq;

using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using GCMaster.Models;


using System.Data;

using GCMaster.Modules;

using Dapper;
using System.Net;

namespace GCMaster.Controllers
{
    [Authorize]
    public class loginController : Controller
    {
        private readonly string _cookiesNameID = "ck-s-n";
        private readonly string _cookiesNamePWD = "ck-s-p";



        [AllowAnonymous]
        // GET: login
        public ActionResult login()
        {
            LoginModel login = new LoginModel();

            string loginID = GetLoginCookieValue(_cookiesNameID);
            string loginPWD = GetLoginCookieValue(_cookiesNamePWD);

            if (loginID != string.Empty)
            {
                login.LoginID = loginID;
                login.RememberID = true;
            }

            if (loginPWD != string.Empty)
            {
                login.Password = loginPWD;
                login.RememberPWD = true;
            }

            return View(login);
        }


        [AllowAnonymous]
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult login(LoginModel model, string ReturnUrl = null)
        {
            if (ModelState.IsValid)
            {
                int verifiedIDX = AuthManager.VerifyingAccount(model.LoginID, model.Password, GetRemoteIPAddress);

                if (verifiedIDX > 0)
                {
                    if (model.RememberID)
                        SetLoginCookieValue(_cookiesNameID, model.LoginID);
                    else
                        DelLoginCookieValue(_cookiesNameID);

                    if (model.RememberPWD)
                        SetLoginCookieValue(_cookiesNamePWD, model.Password);
                    else
                        DelLoginCookieValue(_cookiesNamePWD);

                    FormsAuthentication.SetAuthCookie(verifiedIDX.ToString(), true);

                    if (ReturnUrl != null)
                        return Redirect(ReturnUrl);
                    else
                        return RedirectToAction("list", "pr/news");
                }
                else
                {
                    TempData["loginError"] = "아이디 또는 비밀번호가 일치하지 않습니다.";
                }
            }

            return View(model);
        }



        

        private string GetLoginCookieValue(string cookieName)
        {
            string value = string.Empty;
            try
            {
                if (Request.Cookies[cookieName] != null)
                {
                    value = Request.Cookies[cookieName].Value;
                    if (!string.IsNullOrEmpty(value))
                        value = Functions.AESDecrypt(value);
                }
            }
            catch
            {
                value = string.Empty;
            }
            return value;
        }

        private void SetLoginCookieValue(string cookieName, string cookieValue)
        {
            HttpCookie httpCookie = null;
            try
            {
                if (Request.Cookies[cookieName] != null)
                {
                    httpCookie = Request.Cookies[cookieName];
                    httpCookie.Value = Functions.AESEncrypt(cookieValue);
                    httpCookie.Expires = DateTime.Today.AddYears(1);
                }
                else
                {
                    httpCookie = new HttpCookie(cookieName, Functions.AESEncrypt(cookieValue));
                    httpCookie.Expires = DateTime.Today.AddYears(1);
                }
                this.Response.Cookies.Add(httpCookie);
            }
            catch
            {
                
            }
        }

        private void DelLoginCookieValue(string cookieName)
        {
            try
            {
                if (Request.Cookies[cookieName] != null)
                {
                    HttpCookie httpCookie = Request.Cookies[cookieName];
                    httpCookie.Expires = DateTime.Today.AddDays(-1);
                    Response.Cookies.Add(httpCookie);
                }
            }
            catch
            {
            }
        }

        private string GetRemoteIPAddress
        {
            get
            {
                string ipAddress = Request.UserHostAddress.Replace(":", ".");

                if (Request.Headers.AllKeys.Contains("X-Forwarded-For"))
                    ipAddress = Request.Headers.Get("X-Forwarded-For").Replace(":", ".");

                return ipAddress;
            }
        }

        public ActionResult logOut()
        {
            FormsAuthentication.SignOut();
            return RedirectToAction("login", "login");
        }

    }
}
