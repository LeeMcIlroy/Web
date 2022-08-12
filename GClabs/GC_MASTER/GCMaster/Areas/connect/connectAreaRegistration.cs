using System.Web.Mvc;

namespace GCMaster.Areas.connect
{
    public class connectAreaRegistration : AreaRegistration 
    {
        public override string AreaName 
        {
            get 
            {
                return "connect";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context) 
        {
            context.MapRoute(
                "connect_default",
                "connect/{controller}/{action}/{id}",
                new { action = "list", id = UrlParameter.Optional }
            );
        }
    }
}