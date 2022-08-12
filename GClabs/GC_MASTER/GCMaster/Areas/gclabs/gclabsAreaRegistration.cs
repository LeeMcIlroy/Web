using System.Web.Mvc;

namespace GCMaster.Areas.gclabs
{
    public class gclabsAreaRegistration : AreaRegistration 
    {
        public override string AreaName 
        {
            get 
            {
                return "gclabs";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context) 
        {
            context.MapRoute(
                "gclabs_default",
                "gclabs/{controller}/{action}/{id}",
                new { action = "list", id = UrlParameter.Optional }
            );
        }
    }
}