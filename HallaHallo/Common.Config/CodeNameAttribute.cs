using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace HallaTube
{
    [AttributeUsage(AttributeTargets.Field|AttributeTargets.Class)]
    public sealed class CodeNameAttribute : Attribute
    {
        public string CodeNm { set; get; }

        public CodeNameAttribute(string name)
        {
            CodeNm = name;
        }

    }
}
