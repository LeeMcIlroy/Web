using HallaTube;
using HallaTube.Controllers;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Helpers;
using System.Web.Mvc;

namespace System.Web.Mvc
{
    public static class HtmlHelperExtension
    {


        public static Dictionary<Type, IHtmlString> AddScript(this HtmlHelper html, IHtmlString script)
        {
            var dic = html.ViewContext.HttpContext.Items["_Script"] as Dictionary<Type, IHtmlString>;
            if (dic == null)
            {
                dic = new Dictionary<Type, IHtmlString>();
                html.ViewContext.HttpContext.Items["_Script"] = dic;
            }

            Type type = html.ViewDataContainer.GetType();
            if (!dic.ContainsKey(type))
            {
                dic.Add(type, script);
            }

            return dic;
        }

        public static MvcHtmlString RenderScript(this HtmlHelper html)
        {
            var dic = html.ViewContext.HttpContext.Items["_Script"] as Dictionary<Type, IHtmlString>;
            if (dic == null) return null;

            StringBuilder sb = new StringBuilder();
            foreach (var item in dic.Values)
            {
                sb.Append(item.ToString());
            }
            return new MvcHtmlString(sb.ToString());
        }


        public static MvcHtmlString ToTime(this HtmlHelper html, float minutes)
        {
            int m = (int)minutes;
            string time = "";
            if (m < 0)
            {
                m = m * -1;
                time = string.Format("-{0}:{1}", m / 60, (m % 60).ToString("00"));
            }
            else
            {
                time = string.Format("{0}:{1}", m / 60, (m % 60).ToString("00"));
            }

            if (time == "0:00") time = "0";

            if (time == "" || time == "-")
            {
                time = "0";
            }

            return new MvcHtmlString(time);
        }

        public static MvcHtmlString Radio(this HtmlHelper html, string name, string value, string test)
        {
            return new MvcHtmlString($"<input type='radio' name='{name}' value='{value}' class='inpRadio' {(value == test ? "checked" : "")}>");
        }

        public static MvcHtmlString Radio(this HtmlHelper html, string name, bool chk)
        {
            return new MvcHtmlString($"<input type='radio' name='{name}' class='inpRadio' {(chk ? "checked" : "")}>");
        }
    }

}