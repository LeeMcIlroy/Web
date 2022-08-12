using System.Web.Mvc;

namespace GCMaster.Areas.display
{
    public class displayAreaRegistration : AreaRegistration 
    {
        public override string AreaName 
        {
            get 
            {
                return "display";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context) 
        {
            context.MapRoute(
                "display_default",
                "display/{controller}/{action}/{id}",
                new { action = "Index", id = UrlParameter.Optional }
            );
        }
    }
}