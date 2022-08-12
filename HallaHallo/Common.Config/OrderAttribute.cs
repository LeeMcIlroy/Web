using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace HallaTube
{
    [AttributeUsage(AttributeTargets.Field)]
    public sealed class OrderAttribute : Attribute
    {
        public int Order { set; get; }

        public OrderAttribute(int order)
        {
            Order = order;
        }
    }


}
