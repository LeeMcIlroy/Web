using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;

using GCMaster.Models;
using System.Web.Mvc;

namespace GCMaster.Areas.test.Models
{
    public class allergenModel
    {
        public int ROW_NUM { get; set; }
        public int IDX { get; set; }

        public string ARG_CD { get; set; }      //알러지
        public string ARG_NM { get; set; }      //알러지명
        public string CTGR { get; set; }
        public string CTGR_NM { get; set; }
        public int READ_CNT { get; set; }
        public int VIEW_SEQ { get; set; }
        public string VIEW_YN { get; set; }     //노출여부
        public DateTime INS_DATE { get; set; }
        public string INS_USER { get; set; }
        public DateTime UPD_DATE { get; set; }
        public string UPD_USER { get; set; }
        public int IDX_DT { get; set; }
    }

    public class allergenDetail                                                                                  
    {
        public int IDX { get; set; }
        public string ARG_CD { get; set; }      //알러지
        public string ARG_NM { get; set; }      //알러지명
        public string CTGR { get; set; }
        public string CTGR_NM { get; set; }
        public int READ_CNT { get; set; }
        public int VIEW_SEQ { get; set; }
        public string VIEW_YN { get; set; }     //노출여부
        public DateTime INS_DATE { get; set; }
        public string INS_USER { get; set; }
        public DateTime UPD_DATE { get; set; }
        public string UPD_USER { get; set; }
        public int IDX_DT { get; set; }

        public string CODE { get; set; }      // 공통코드
        public string NAME { get; set; }      // 공통코드명    
    }

    public class allergenCategory
    {
        public string CODE { get; set; }      // 공통코드
        public string NAME { get; set; }      // 공통코드명                      
    }
}