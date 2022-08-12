
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Principal;
using System.Web;
using System.Web.Mvc;
using System.Web.WebPages;

namespace HallaTube
{
    public abstract class WebViewPage<TModel> : System.Web.Mvc.WebViewPage<TModel>
    {
        public IPrincipal PrincipalUser { get { return base.User; } }
        public new UserState User { private set; get; }
        public LanguageManager Text { private set; get; }

        protected override void ConfigurePage(WebPageBase parentPage)
        {
            

            base.ConfigurePage(parentPage);
        }

        protected override void InitializePage()
        {
            base.InitializePage();

            User = ViewData["_User"] as UserState;
            Text = ViewData["_Text"] as LanguageManager;
        }

    }
}