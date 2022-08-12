using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class DisclosureTitle : DisclosureDetail
    {
    
        public int DetailSeq { get; set; }

        public string Title { get; set; }
        public string DisCode { get; set; }

        public string Initial { get; set; }
    }
}