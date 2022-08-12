using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace HallaTube
{
    [AttributeUsage(AttributeTargets.Property | AttributeTargets.Field, AllowMultiple = true)]
    public sealed class FieldGroupAttribute : Attribute
    {
        public static string ALL = "ALL";

        public string GroupNm { set; get; }

        public FieldGroupAttribute()
        {
            GroupNm = ALL;
        }

        public FieldGroupAttribute(string name)
        {
            GroupNm = name;
        }

    }
}
