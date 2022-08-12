using System.Web.Mvc;

namespace GCMaster.Areas.common
{
    public class commonAreaRegistration : AreaRegistration 
    {
        public override string AreaName 
        {
            get 
            {
                return "common";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context) 
        {
            context.MapRoute(
                "common_default",
                "common/{controller}/{action}/{idx}",
                new { action = "list", idx = UrlParameter.Optional }
            );
        }
    }
}