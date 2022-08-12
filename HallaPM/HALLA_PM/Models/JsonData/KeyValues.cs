using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class KeyValues
    {
        public string key { get; set; }

        public List<Values> values { get; set; }
    }
}