using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class PmConfirmView 
    {
        public int seq { get; set; }
        public string planYear { get; set; }
        public string monthly { get; set; }
        public int orgCompanySeq { get; set; }
        public int registStatus { get; set; }
        public string busType { get; set; }  
    }    
}