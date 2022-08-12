using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class InsaUserV
    {
        public string compcode2 { get; set; }
        public string userKey { get; set; }
        public string empNo { get; set; }
        public string emailAddress { get; set; }
        public string userKorName { get; set; }
        public string userEngName { get; set; }
        public string userChnName { get; set; }
        public string compCode { get; set; }
        public string deptCode { get; set; }
        public string levelCode { get; set; }
        public string levelKorName { get; set; }
        public string levelEngName { get; set; }
        public string levelChnName { get; set; }
        public string positionCode { get; set; }
        public string positionKorName { get; set; }
        public string positionEngName { get; set; }
        public string positionChnName { get; set; }
        public string jikgunCode { get; set; }
        public string jikgunKorName { get; set; }
        public string jikgunEngName { get; set; }
        public string jikgunChnName { get; set; }
        public string myPhotoUrl { get; set; }
        public string codePage { get; set; }
        public string mobilePhone { get; set; }
        public string locationPhone { get; set; }
        public string statusCode { get; set; }
        public string CompKorName { get; set; }

        /// <summary>
        /// 사용자1명의 회사가 여러개인경우 IsDefault : 1인 것을 대표로 보여준다.
        /// </summary>
        public string IsDefault { get; set; }
        public string Deptkorname { get; set; }
    }
}