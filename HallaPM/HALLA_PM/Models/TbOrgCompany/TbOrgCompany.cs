using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class TbOrgCompany
    {
        public int orgUnionSeq { get; set; }
        public int seq { get; set; }
        public string companyName { get; set; }
        public string isUse { get; set; }
        public string userKey { get; set; }
        public string empNo { get; set; }
        public string createDate { get; set; }

        public string UpId { get; set; }
        public string id { get; set; }
    }
}