using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace GCRL.Controllers
{
    public class BaseController : Controller
    {
        protected CultureInfo InvCulture = CultureInfo.InvariantCulture;

        protected override void Initialize(RequestContext requestContext)
        {
            base.Initialize(requestContext);
        }
    }
}