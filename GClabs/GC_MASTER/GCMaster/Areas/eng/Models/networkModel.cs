using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;

using GCMaster.Models;
using System.Web.Mvc;

namespace GCMaster.Areas.eng.Models
{

    public class networkModel
    {
        public string ROW_NUM { get; set; }        

        public int IDX { get; set; }            

        public string NATION_NM { get; set; }      

        public string COMPANY_NM { get; set; }     


        public string IMAGE1_ORG_NM { get; set; }     

        public string IMAGE1_SAVE_NM { get; set; }     

        public int IMAGE1_SIZE { get; set; }

        public string IMAGE2_ORG_NM { get; set; }

        public string IMAGE2_SAVE_NM { get; set; }

        public int IMAGE2_SIZE { get; set; }


        public string LINK_URL { get; set; }     

        public string NOTI_YN { get; set; }
        public string VIEW_YN { get; set; }
        public int VIEW_CNT { get; set; }

        public int VIEW_ORDER { get; set; }
        public string VIEW_DATE_ST { get; set; }
        public string VIEW_TIME_ST { get; set; }
        public string VIEW_STT { get; set; }
        public string VIEW_DATE_ED { get; set; }
        public string VIEW_TIME_ED { get; set; }
        public string VIEW_END { get; set; }
        public string VIEW_TIME { get; set; }
        public string REGIST_ID { get; set; }

        public string REGIST_NAME { get; set; }

        public string REGIST_DATE { get; set; }

        public string UPDATE_ID { get; set; }

        public string UPDATE_NAME { get; set; }

        public string UPDATE_DATE { get; set; }
  

    }
   
}