using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Net.Http;
using System.Net.Http.Headers;

namespace GCRL.Areas.test.Models
{
    public class panelModel
    {
        public int ROW_NUM { get; set; }
        public int IDX { get; set; }

        public string PAN_CD { get; set; }      //검사
        public string PAN_NM { get; set; }      //검사명
        public string PAN_TYP { get; set; }     //구분
        public string PAN_TYP_NM { get; set; }  //구분명
        public string TRB_TYP { get; set; }      //질환코드
        public string TRB_TYP_NM { get; set; }   //질환명
        public string TRB_TYP_SUB { get; set; }      //질환코드
        public string TRB_TYP_NM_SUB { get; set; }   //질환명
        public int READ_CNT { get; set; }
        public int VIEW_SEQ { get; set; }
        public string VIEW_YN { get; set; }     //노출여부
        public string FIX_YN { get; set; }     //고정
        public DateTime INS_DATE { get; set; }
        public string INS_USER { get; set; }
        public DateTime UPD_DATE { get; set; }
        public string UPD_USER { get; set; }
        public int IDX_DT { get; set; }
        public int TOT_CNT { get; set; }

        public List<panelModel> panel { get; set; }
    }

    public class panelModel_02
    {
        public int ROW_NUM { get; set; }
        public int IDX { get; set; }

        public string PAN_CD { get; set; }      //검사
        public string PAN_NM { get; set; }      //검사명
        public string PAN_TYP { get; set; }     //구분
        public string PAN_TYP_NM { get; set; }  //구분명
        public string TRB_TYP { get; set; }      //질환코드
        public string TRB_TYP_NM { get; set; }   //질환명
        public string TRB_TYP_SUB { get; set; }      //질환코드
        public string TRB_TYP_NM_SUB { get; set; }   //질환명
        public int READ_CNT { get; set; }
        public int VIEW_SEQ { get; set; }
        public string VIEW_YN { get; set; }     //노출여부
        public string FIX_YN { get; set; }     //고정
        public DateTime INS_DATE { get; set; }
        public string INS_USER { get; set; }
        public DateTime UPD_DATE { get; set; }
        public string UPD_USER { get; set; }
        public int IDX_DT { get; set; }
        public int TOT_CNT { get; set; }

        public List<panelModel_02> panel { get; set; }
    }
}