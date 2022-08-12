using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace System
{
    public static class StringExtension
    {
        public static string ToPascalCase(this string str)
        {   
            string[] info = str.Split('_');
            string name = string.Empty;

            

            foreach (var w in info)
            {
                if (w.Length <= 1)
                {
                    name += w;
                }
                else
                {
                    name += w[0].ToString().ToUpper() + w.Substring(1).ToLower();
                }
                
            }
            return name;
        }

        public static string FormatHtml(this string text)
        {
            StringBuilder sb = new StringBuilder(text);

            return sb.Replace("\r", "").Replace("\n", "<br>").Replace(" ", "&nbsp;").ToString();
        }
    }
}

