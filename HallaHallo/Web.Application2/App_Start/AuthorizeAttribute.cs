using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HallaTube
{
    [AttributeUsage(AttributeTargets.Method | AttributeTargets.Class, Inherited = true, AllowMultiple = false)]
    public sealed class AuthorizeAttribute : Attribute
    {
        public string AuthType { set; get; }
        public string RedirectType { set; get; }

        public AuthorizeAttribute()
        {
            AuthType = HallaTube.AuthType.USER;
        }

        public AuthorizeAttribute(string authType)
        {
            AuthType = authType;
        }
    }

}