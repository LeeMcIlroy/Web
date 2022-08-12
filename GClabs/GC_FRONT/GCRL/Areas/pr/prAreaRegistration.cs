using System.Web.Mvc;

namespace GCRL.Areas.pr
{
    public class prAreaRegistration : AreaRegistration
    {
        public override string AreaName
        {
            get
            {
                return "pr";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context)
        {
            context.MapRoute(
                "pr_default",
                "pr/{controller}/{action}/{id}",
                new { action = "list", id = UrlParameter.Optional }
            );
        }
    }
}