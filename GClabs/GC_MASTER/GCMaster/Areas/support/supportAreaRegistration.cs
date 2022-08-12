using System.Web.Mvc;

namespace GCMaster.Areas.support
{
    public class supportAreaRegistration : AreaRegistration 
    {
        public override string AreaName 
        {
            get 
            {
                return "support";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context) 
        {
            context.MapRoute(
                "support_default",
                "support/{controller}/{action}/{id}",
                new { action = "list", id = UrlParameter.Optional }
            );
        }
    }
}