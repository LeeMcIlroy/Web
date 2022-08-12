using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class MailInfo
    {
        public string fromAddress { get; set; }
        public string fromName { get; set; }
        public string toAddress { get; set; }
        public string toName { get; set; }
        public string subject { get; set; }
        public string body { get; set; }

        public int afterRegistStatus { get; set; }
        public string menuName { get; set; }
        public string year { get; set; }
        public string mm { get; set; }
        public int AuthLevel { get; set; }
        public int OrgCompanySeq { get; set; }

        // 2019.01.03 유저정보 및 반려 사유 추가
        public string UserInfo { get; set; }
        public string RejectReson { get; set; }

        // 2019.01.13 결제메일 추가
        public int Seq { get; set; }
        public string ReferUrl { get; set; }
        public Dictionary<string, int> objPmSeq { get; set; }
    }
}