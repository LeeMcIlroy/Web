using System.Web.Mvc;

namespace GCMaster.Areas.eng
{
    public class engAreaRegistration : AreaRegistration 
    {
        public override string AreaName 
        {
            get 
            {
                return "eng";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context) 
        {
            context.MapRoute(
                "eng_default",
                "eng/{controller}/{action}/{id}",
                new { action = "list", id = UrlParameter.Optional }
            );
        }
    }
}