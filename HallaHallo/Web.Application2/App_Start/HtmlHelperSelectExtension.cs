using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;

namespace System.Web.Mvc
{
    public static class HtmlHelperSelectListItemExtension
    {
        public static IEnumerable<SelectListItem> ToSelectListItems<TModel, TProperty>(this IEnumerable<TModel> items
            , Func<TModel, TProperty> text, Func<TModel, TProperty> value, Func<TModel, bool> selected = null)
        {
            if (selected == null)
            {
                selected = new Func<TModel, bool>(p => false);
            }
            return items.Select(p => new SelectListItem { Text = text(p).ToString(), Value = value(p).ToString(), Selected = selected(p) });
        }

    }

    public static class HtmlHelperOptionExtension
    {
        public static MvcHtmlString Options(this IEnumerable<SelectListItem> items)
        {
            StringBuilder sb = new StringBuilder();
            foreach (var item in items)
            {
                sb.Append(GetHtmlString(item.Text, item.Value, item.Selected));
            }

            return MvcHtmlString.Create(sb.ToString());
        }






        public static MvcHtmlString Options<TModel, TProperty>(this HtmlHelper htmlHelper, IEnumerable<TModel> items
            , Func<TModel, TProperty> text, Func<TModel, TProperty> value, Func<TModel, bool> selected = null)
        {
            return items.ToSelectListItems(text, value, selected).Options();
        }

        public static MvcHtmlString Option(this HtmlHelper htmlHelper, SelectListItem item)
        {
            return htmlHelper.Option(item.Text, item.Value, item.Selected);
        }



        private static string GetHtmlString(this SelectListItem item)
        {
            return GetHtmlString(item.Text, item.Value, item.Selected);
        }

        private static string GetHtmlString(string text, string value, bool selected = false)
        {
            return "<option value=\""+ value + "\""+ (selected ? " selected" : string.Empty) + ">"+ text + "</option>" + System.Environment.NewLine;
        
            //return $"<option value=\"{value}\"{(selected ? " selected" : string.Empty)}>{text}</option>" + System.Environment.NewLine;
        }

        public static MvcHtmlString Option(this HtmlHelper htmlHelper, string text, string value, bool selected = false)
        {
            return MvcHtmlString.Create(GetHtmlString(text, value, selected));
        }

        public static MvcHtmlString OptionTop(this HtmlHelper htmlHelper, string text = null)
        {
            if (string.IsNullOrEmpty(text))
            {
                text = "SELECT";
            }

            return MvcHtmlString.Create(GetHtmlString(text, string.Empty, false));
        }
    }

    public static class HtmlHelperInputListExtension
    {
        public static MvcHtmlString InputList(this IEnumerable<SelectListItem> items, string type, string name)
        {
            StringBuilder sb = new StringBuilder();
            foreach (var item in items)
            {
                sb.Append(GetHtmlString(type, name, item.Text, item.Value, item.Selected));
            }

            return MvcHtmlString.Create(sb.ToString());
        }

        public static MvcHtmlString CheckboxList(this IEnumerable<SelectListItem> items, string name)
        {
            return items.InputList("checkbox", name);
        }

        public static MvcHtmlString RadioList(this IEnumerable<SelectListItem> items, string name)
        {
            return items.InputList("radio", name);
        }






        public static MvcHtmlString CheckboxList<TModel, TProperty>(this HtmlHelper htmlHelper, IEnumerable<TModel> items
            , Func<TModel, TProperty> text, Expression<Func<TModel, TProperty>> value, Func<TModel, bool> selected = null)
        {
            var member = (value.Body as MemberExpression).Member;

            return items.ToSelectListItems(text, value.Compile(), selected).CheckboxList(member.Name);
        }

        public static MvcHtmlString RadioList<TModel, TProperty>(this HtmlHelper htmlHelper, IEnumerable<TModel> items
            , Func<TModel, TProperty> text, Expression<Func<TModel, TProperty>> value, Func<TModel, bool> selected = null)
        {
            var member = (value.Body as MemberExpression).Member;

            return items.ToSelectListItems(text, value.Compile(), selected).RadioList(member.Name);
        }




        private static string GetHtmlString(this SelectListItem item, string type, string name)
        {
            return GetHtmlString(type, name, item.Text, item.Value, item.Selected);
        }

        private static string GetHtmlString(string type, string name, string text, string value, bool selected = false)
        {
            return "<label><input type=\""+ type + "\" name=\""+ name + "\" value=\""+ value + "\""+ (selected ? " checked" : string.Empty) + "/>"+ text + "</label>" + System.Environment.NewLine;
            //return $"<label><input type=\"{type}\" name=\"{name}\" value=\"{value}\"{(selected ? " checked" : string.Empty)}/>{text}</label>" + System.Environment.NewLine;
        }
    }



    public static class ExtentionLegacy
    {
        public static MvcHtmlString ToOptions(this HtmlHelper html, DataTable dt, string textField, string valueField, bool containSelect = true, string selected = null)
        {
            return ToOptions(html, dt.Rows, textField, valueField, containSelect, selected);
        }

        public static MvcHtmlString ToOptions(this HtmlHelper html, DataRowCollection rows, string textField, string valueField, bool containSelect = true, string selected = null)
        {
            StringBuilder sb = new StringBuilder();

            if (containSelect)
            {
                sb.AppendLine("<option value=\"\">---SELECT---</option>");
            }
            foreach (DataRow dr in rows)
            {
                sb.AppendLine("<option value=\""+ dr[valueField] + "\" "+ (dr[valueField].ToString() == selected ? " selected" : string.Empty) + ">"+ dr[textField] + "</option>");

                //sb.AppendLine($"<option value=\"{dr[valueField]}\" {(dr[valueField].ToString() == selected ? " selected" : string.Empty)}>{dr[textField]}</option>");

            }
            return new MvcHtmlString(sb.ToString());
        }
    }
}
