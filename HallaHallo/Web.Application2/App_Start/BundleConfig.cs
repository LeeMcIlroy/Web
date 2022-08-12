using System.Web;
using System.Web.Optimization;

namespace HallaTube
{
    public class BundleConfig
    {
        // 묶음에 대한 자세한 내용은 https://go.microsoft.com/fwlink/?LinkId=301862를 참조하세요.
        public static void RegisterBundles(BundleCollection bundles)
        {
            bundles.Add(new ScriptBundle("~/bundles/jquery").Include(
                        "~/Scripts/jquery-{version}.js",
                        "~/Scripts/jquery.form.js"
            ));

            bundles.Add(new ScriptBundle("~/bundles/jqueryui").Include(
                "~/Scripts/jquery-ui.js"
            ));

            bundles.Add(new ScriptBundle("~/bundles/library").Include(
                "~/Js/library.js",
                "~/Js/libraryJquery.js",
                "~/Js/libraryLanguage.js",
                "~/Js/librarySite.js",
                "~/Js/libraryProperty.js",
                "~/Js/libraryGrid.js",
                "~/Js/site.js"
            ));

            bundles.Add(new ScriptBundle("~/bundles/jqueryval").Include(
                        "~/Scripts/jquery.validate*"));

            // Modernizr의 개발 버전을 사용하여 개발하고 배우십시오. 그런 다음
            // 프로덕션에 사용할 준비를 하고 https://modernizr.com의 빌드 도구를 사용하여 필요한 테스트만 선택하세요.
            bundles.Add(new ScriptBundle("~/bundles/modernizr").Include(
                        "~/Scripts/modernizr-*"));

            bundles.Add(new ScriptBundle("~/bundles/bootstrap").Include(
                      "~/Scripts/bootstrap.js"));

            bundles.Add(new StyleBundle("~/inc/css/css").Include(
                      "~/inc/css/common.css",
                      "~/inc/css/contents.css",
                      "~/inc/css/override.css"));

            bundles.Add(new StyleBundle("~/Admin/css").Include(
                      "~/_css/style.css"));
        }
    }
}
