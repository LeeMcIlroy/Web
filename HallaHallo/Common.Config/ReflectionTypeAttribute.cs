using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace HallaTube
{
    [AttributeUsage(AttributeTargets.Field |  AttributeTargets.Property)]
    public class ReflectionTypeAttribute : Attribute
    {
        public string FieldGroup { set; get; }

        public ReflectionTypeAttribute(string fieldGroup)
        {
            FieldGroup = fieldGroup;
        }
    }
}
