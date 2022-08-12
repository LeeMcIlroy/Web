using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace HallaTube
{
    public class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

            routes.MapRoute(
                name: "Api",
                url: "Api/{action}",
                defaults: new { controller = "Api" },
                namespaces: new string[] { "HallaTube.Controllers" }
            );

            routes.MapRoute(
                name: "DefaultType",
                url: "{controller}/{type}/{action}/{id}",
                defaults: new { id = UrlParameter.Optional },
                constraints: new { type = new CodeConstraint() },
                namespaces: new string[] { "HallaTube.Controllers" }
            );

            routes.MapRoute(
                name: "Default",
                url: "{controller}/{action}",
                defaults: new {  },
                namespaces: new string[] { "HallaTube.Controllers" }
            );

            routes.MapRoute(
                name: "Simple",
                url: "{action}",
                defaults: new { controller = "Default", action = "Index" },
                namespaces: new string[] { "HallaTube.Controllers" }
            );
        }
    }

    public class CodeConstraint : IRouteConstraint
    {
        public bool Match(HttpContextBase httpContext, Route route, string parameterName, RouteValueDictionary values, RouteDirection routeDirection)
        {
            if (parameterName == "type")
            {
                string action = values["action"] as string;
                if (!string.IsNullOrEmpty(action))
                {
                    if (Regex.IsMatch(action, "[0-9]+")) return false;
                    return true;
                }

                return false;
            }
            else
            {
                return true;
            }

        }
    }

    public class SequenceConstraint : IRouteConstraint
    {
        public bool Match(HttpContextBase httpContext, Route route, string parameterName, RouteValueDictionary values, RouteDirection routeDirection)
        {
            if (parameterName == "seq")
            {
                string seq = values["seq"] as string;
                if (!string.IsNullOrEmpty(seq))
                {
                    if (Regex.IsMatch(seq, "[a-z]+")) return false;
                    else return true;
                }
            }

            return true;

        }
    }
}
