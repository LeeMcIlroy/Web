using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class MailSendList
    {
        public DateTime SendDate { get; set; }
        public string FmAddress { get; set; }
        public string ToAddress { get; set; }
        public string Subject { get; set; }
        public string Body { get; set; }
        public string IsSend { get; set; }
        public string FailReason { get; set; }
    }
}