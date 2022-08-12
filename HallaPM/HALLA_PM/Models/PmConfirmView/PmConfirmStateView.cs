using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models 
{
    public class PmConfirmStateView : BaseInfo
    {
        public int rowNum { get; set; }
        public int seq { get; set; }
        public int orgCompanySeq { get; set; }
        public string companyName { get; set; }

        public string pmYear { get; set; }
        public string monthly { get; set; }

        public int pmCashFlow { get; set; }
        public int pmInvest { get; set; }
        public int pmPal { get; set; }
        public int pmQuarterPal { get; set; }
        public int pmBs { get; set; }
        public int pmBsEx { get; set; }

        public string readyFirstConfirm { get; set; }
        public string readySecondConfirm { get; set; }
        public string readyLastConfirm { get; set; }
        public string finalConfirm { get; set; }

        public int lastConfirm { get; set; }
        public int ready { get; set; }
        public int reg { get; set; }
        public int readyConfirm { get; set; }
        public int firstConfirm { get; set; }
        public int secondConfirm { get; set; }
        public int firstReject { get; set; }
        public int secondReject { get; set; }
        public int thirdReject { get; set; }

        public string confirmComment { get; set; }
    } 
}