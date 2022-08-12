using System.Web.Mvc;

namespace GCRL.Areas.eng
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
                new { controller = "main", action = "index", id = UrlParameter.Optional }
            );
        }
    }
}