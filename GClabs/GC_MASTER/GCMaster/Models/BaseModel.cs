using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace GCMaster.Models
{
    public class BoardCommonModel
    {
        public int IDX { get; set; }
        public string TYPE { get; set; }

        public string VIEW_YN { get; set; }
        public int VIEW_ORDER { get; set; }
        public int VIEW_CNT { get; set; }
        public DateTime VIEW_DATE { get; set; }
        public string NOTI_YN { get; set; }


        public string DIV_CODE1 { get; set; }
        public string DIV_CODE2 { get; set; }
        public int DIV_VALUE1 { get; set; }
        public int DIV_VALUE2 { get; set; }

        public string DIV_DATE1 { get; set; }


        public string TITLE { get; set; }
        public string CONTENT_S { get; set; }
        public string CONTENT_F { get; set; }

        public string IMAGE1_ORG_NAME { get; set; }
        public string IMAGE1_SAVE_NAME { get; set; }
        public int IMAGE1_SIZE { get; set; }

        public string IMAGE2_ORG_NAME { get; set; }
        public string IMAGE2_SAVE_NAME { get; set; }
        public int IMAGE2_SIZE { get; set; }

        public string ATTACH1_ORG_NAME { get; set; }
        public string ATTACH1_SAVE_NAME { get; set; }
        public int ATTACH1_SIZE { get; set; }

        public string ATTACH2_ORG_NAME { get; set; }
        public string ATTACH2_SAVE_NAME { get; set; }
        public int ATTACH2_SIZE { get; set; }

        public string LINK1_NAME { get; set; }
        public string LINK1_URL { get; set; }

        public string LINK2_NAME { get; set; }
        public string LINK2_URL { get; set; }

        public string LINK3_NAME { get; set; }
        public string LINK3_URL { get; set; }

        public string REGIST_ID { get; set; }
        public string REGIST_NAME { get; set; }
        public DateTime REGIST_DATE { get; set; }

        public string UPDATE_ID { get; set; }
        public string UPDATE_NAME { get; set; }
        public DateTime UPDATE_DATE { get; set; }
    }

    public class SelectBoxCodeModel{
        public string CODE { get; set; }

        public string NAME { get; set; }
    }
}