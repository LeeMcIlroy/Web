using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class PmConfirmLog
    {
        public int seq { get; set; }
        public string pmYear { get; set; }
        public string monthly { get; set; }
        public int orgCompanySeq { get; set; }
        public int preStatus { get; set; }
        public int confirmStatus { get; set; }
        public string confirmComment { get; set; }
        public string userKey { get; set; }
        public string userIp { get; set; }  
        public string strCompnayName { get; set; }
    }
}