using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.Routing;

namespace HallaTube.Routing
{
    public interface IRouteRegistable
    {
        RouteCollection RegisterRoutes(RouteCollection routes);
    }
}
