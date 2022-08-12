using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class MobileDevice
    {
        public string UserIdx { get; set; }
        public string DeviceToken { get; set; }
        public string DeviceType { get; set; }
        public DateTime CreatedAt { get; set; }
    }
}