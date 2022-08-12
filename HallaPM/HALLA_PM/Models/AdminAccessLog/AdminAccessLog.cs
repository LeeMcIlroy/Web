using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    /// <summary>
    /// 접속로그
    /// </summary>
    public class AdminAccessLog
    {
        public string RowNum { get; set; }
        public DateTime AccessDate { get; set; }
        public string UserKey { get; set; }
        public string EmpNo { get; set; }
        public string UserKorName { get; set; }
        public string Ip { get; set; }
        public string Memo { get; set; }
        public string Descrition { get; set; }
    }
}