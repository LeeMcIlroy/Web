using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace HallaTube
{
    [AttributeUsage(AttributeTargets.Property)]
    public sealed class CodeTypeAttribute : Attribute
    {
        public Type CodeType { set; get; }

        public CodeTypeAttribute(Type type)
        {   
            CodeType = type;
        }

    }
}
