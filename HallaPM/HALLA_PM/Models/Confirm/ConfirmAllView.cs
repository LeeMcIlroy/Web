using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models.Confirm
{
    public class ConfirmAllView : BaseInfo
    {
        public int rowNum { get; set; }
        public int seq { get; set; }
        public string planYear { get; set; }
        public string monthly { get; set; }
        public int orgCompanySeq { get; set; }
        public int registStatus { get; set; }
        public string busType { get; set; }
        public string planType { get; set; }
        public string companyName { get; set; }
    }
}

 