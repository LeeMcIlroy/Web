using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class PushDetail
    {
        public int PushIdx { get; set; }
        public string UserIdx { get; set; }
        public int PushConfirm { get; set; }
        public DateTime CreatedAt { get; set; }
    }
}