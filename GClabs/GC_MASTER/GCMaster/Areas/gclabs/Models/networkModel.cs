using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.ComponentModel.DataAnnotations;

using GCMaster.Models;


namespace GCMaster.Areas.gclabs.Models
{

    public class networkModel
    {
        public int IDX { get; set; }

        public string VIEW_YN { get; set; }

        public int VIEW_CNT { get; set; }


        public string BRANCH_NAME { get; set; }

        public string MANAGER_NAME { get; set; }


        public string LATITUDE { get; set; }

        public string LONGITUDE { get; set; }

        public string REGION_CODE { get; set; }

        public string ADDRESS { get; set; }

        public string TEL_NO_1 { get; set; }
        public string TEL_NO_2 { get; set; }
        public string TEL_NO_3 { get; set; }
        public bool TEL_NO_VIEW { get; set; }

        public string FAX_NO_1 { get; set; }
        public string FAX_NO_2 { get; set; }
        public string FAX_NO_3 { get; set; }
        public bool FAX_NO_VIEW { get; set; }


        public string REGIST_ID { get; set; }

        public string REGIST_NAME { get; set; }

        public DateTime REGIST_DATE { get; set; }

        public string UPDATE_ID { get; set; }

        public string UPDATE_NAME { get; set; }

        public DateTime UPDATE_DATE { get; set; }
    }


    public class networkListModel : networkModel
    {

        public string REGION_NAME { get; set; }
    }

    public class networkViewModel : networkModel
    { 
    }

}