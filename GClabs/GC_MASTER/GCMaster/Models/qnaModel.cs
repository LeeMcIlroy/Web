using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.ComponentModel.DataAnnotations;

namespace GCMaster.Models
{
    public class qnaModel
    {
        public int IDX { get; set; }

        public DateTime QUESTION_DATE { get; set; }

        public string QUESTION_TYPE { get; set; }

        public string NAME { get; set; }

        public string COUNTRY_NAME { get; set; }

        public string REGION_NAME { get; set; }

        public string ORG_NAME { get; set; }

        public string DEPT_NAME { get; set; }

        public string CONTACT { get; set; }

        public string EMAIL { get; set; }

        public string TITLE { get; set; }

        public string CONTENTS { get; set; }

        //2022-06-22 신규
        public string OCCUPATION { get; set; } // 직업 ( 1: 일반 , 2:의사 , 3:간호사 , 4:의료기사 ,5 :기타)
        public string ANS_TYPE { get; set; } //답변유형(1: 이메일 , 2: 방문)



        public string ATTACH1_ORG_NAME { get; set; }

        public string ATTACH1_SAVE_NAME { get; set; }

        public DateTime CHECK_DATE { get; set; }

        public string ANS_ST { get; set; }

        public string ANS_TITLE { get; set; }

        public string ANS_SENDEMAIL { get; set; }

        public string ANS_CONTENTS { get; set; }

        public string ATTACH2_ORG_NAME { get; set; }

        public string ATTACH2_SAVE_NAME { get; set; }


        public string ANS_REG_ID { get; set; }

        public string ANS_REG_NAME { get; set; }

        public DateTime ANS_REG_DATE { get; set; }


        public string ANS_UPD_ID { get; set; }

        public string ANS_UPD_NAME { get; set; }

        public DateTime ANS_UPD_DATE { get; set; }
    }

    public class qnaListModel : qnaModel
    {
        public string QUESTION_NAME { get; set; }

        public string ANS_ST_NAME { get; set; }

        public string ANS_REG_YMD { get; set; }
    }

    public class qnaViewModel : qnaModel
    {
        public string ANS_ST_NAME { get; set; }

        public string QUESTION_TYPE_ORG { get; set; }
    }
}