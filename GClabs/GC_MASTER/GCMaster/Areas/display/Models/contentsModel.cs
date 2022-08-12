using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;

using GCMaster.Models;
using System.Web.Mvc;

namespace GCMaster.Areas.display.Models
{

    public class contentsModel
    {
        public string TYPE { get; set; }        // 타입
        public string ROW_NUM { get; set; }        // 타입

        public int IDX { get; set; }            // 번호

        public string CONTENT_CLS { get; set; }      //컨텐츠 구분
        public string DEVI_CLS { get; set; }


        public string SUBJECT { get; set; }      //제목

        public string TITLE_1 { get; set; }     //설명문 1

        public string TITLE_2 { get; set; }        // 설명문2

        public string IMAGE_ORG_NM { get; set; }     

        public string IMAGE_SAVE_NM { get; set; }     

        public int IMAGE_SIZE { get; set; }     

        public string LINK_NAME { get; set; }    

        public string LINK_URL { get; set; }     

        public string VIEW_YN { get; set; }

        public string REGIST_ID { get; set; }

        public string REGIST_NAME { get; set; }

        public string REGIST_DATE { get; set; }

        public string UPDATE_ID { get; set; }

        public string UPDATE_NAME { get; set; }

        public string UPDATE_DATE { get; set; }
        public string COMM_CD { get; set; }

        public string COMM_NM { get; set; }
        public string LANG_CLS { get; set; }


    }

}