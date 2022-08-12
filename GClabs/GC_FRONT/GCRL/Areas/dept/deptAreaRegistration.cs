using System.Web.Mvc;

namespace GCRL.Areas.dept
{
    public class deptAreaRegistration : AreaRegistration 
    {
        public override string AreaName 
        {
            get 
            {
                return "dept";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context) 
        {
            context.MapRoute(
                "dept_default",
                "dept/{controller}/{action}/{id}",
                new { action = "list", id = UrlParameter.Optional }
            );
        }
    }
}