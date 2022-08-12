using System.Web.Mvc;

namespace GCRL.Areas.research
{
    public class researchAreaRegistration : AreaRegistration
    {
        public override string AreaName
        {
            get
            {
                return "research";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context)
        {
            context.MapRoute(
                "research_default",
                "research/{controller}/{action}/{id}",
                new { action = "list", id = UrlParameter.Optional }
            );
        }
    }
}