using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.ComponentModel.DataAnnotations;

namespace GCMaster.Models
{
    public class doctorsModel
    {
        public int IDX { get; set; }

        public string VIEW_YN { get; set; }

        public int VIEW_ORDER { get; set; }

        public int VIEW_CNT { get; set; }


        public string NAME { get; set; }

        public string NAME_ENG { get; set; }

        public string DEPT_CODE { get; set; }

        public string SUMMARY { get; set; }


        public string REGIST_ID { get; set; }

        public string REGIST_NAME { get; set; }

        public DateTime REGIST_DATE { get; set; }

        public string UPDATE_ID { get; set; }

        public string UPDATE_NAME { get; set; }

        public DateTime UPDATE_DATE { get; set; }
    }

    public class paperModel
    {
        public int DOCTORS_IDX { get; set; }

        public int IDX { get; set; }

        public string VIEW_YN { get; set; }

        public string NAME { get; set; }

        public string YEAR { get; set; }

        public string SOURCE { get; set; }


        public string ATTACH_ORG_NAME { get; set; }
        public string ATTACH_SAVE_NAME { get; set; }
        public int ATTACH_SIZE { get; set; }


        public string REGIST_ID { get; set; }

        public string REGIST_NAME { get; set; }

        public DateTime REGIST_DATE { get; set; }

        public string UPDATE_ID { get; set; }

        public string UPDATE_NAME { get; set; }

        public DateTime UPDATE_DATE { get; set; }
    }

    public class doctorsListModel : doctorsModel
    {
        public string DEPT_NAME { get; set; }

        public int PAPER_COUNT { get; set; }

    }

    public class doctorsViewModel : doctorsModel
    {
    }


    public class paperListModel : paperModel
    {

        public string ATTACH_FILE { get; set; }
    }

    public class paperViewModel : paperModel
    {
        public string VIEW_DATE_YMD { get; set; }

        public string VIEW_DATE_HM { get; set; }
    }
}