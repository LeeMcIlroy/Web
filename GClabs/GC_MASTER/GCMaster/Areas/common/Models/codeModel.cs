using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;

using GCMaster.Models;
using System.Web.Mvc;

namespace GCMaster.Areas.common.Models
{
    public class codeModel
    {
        public int ROW_NUM { get; set; }
        public int IDX { get; set; }

        public string GRP_CD { get; set; }      //그룹코드

        public string GRP_NM { get; set; }      //그룹코드명

        public string GRP_PCD { get; set; }     //상세코드

        public string NOTE { get; set; }        // 참조값

        public string USE_FLG { get; set; }     //사용여부

        public DateTime INS_DATE { get; set; }

        public string INS_USER { get; set; }

        public DateTime UPD_DATE { get; set; }

        public string UPD_USER { get; set; }
        public int IDX_DT { get; set; }

        public string GUBUN { get; set; }
        public string COMM_CD { get; set; }      // 공통코드

        public string COMM_NM { get; set; }      // 공통코드명
        public int SORT_SEQ { get; set; }

    }
    public class codeDetail
    {


        public int IDX { get; set; }

        public string GRP_CD { get; set; }       // 그룹코드
        public string GRP_NM { get; set; }       // 그룹명


        public string COMM_CD { get; set; }      // 공통코드

        public string COMM_NM { get; set; }      // 공통코드명

        public string COMM_PCD { get; set; }     // 

        public string ETC_COL1 { get; set; }     // 기타 1

        public string ETC_COL2 { get; set; }     // 기타 2

        public string ETC_COL3 { get; set; }     // 기타 3

        public string ETC_COL4 { get; set; }     // 기타 4

        public string ETC_COL5 { get; set; }     // 기타 5

        public int SORT_SEQ { get; set; }       // 노출순서

        public string NOTE { get; set; }         // 비고

        public string USE_FLG { get; set; }      // 사용여부

        public DateTime INS_DATE { get; set; }

        public string INS_USER { get; set; }

        public DateTime UPD_DATE { get; set; }

        public string UPD_USER { get; set; }

        public string GUBUN { get; set; }


    }

}