using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class PushMaster
    {
        public int PushIdx { get; set; }
        public int Type { get; set; }
        public string Title { get; set; }
        public string Contents { get; set; }
        public string Link { get; set; }
        public string Response { get; set; }
        public DateTime SendedAt { get; set; }
        public DateTime CreatedAt { get; set; }
    }
}