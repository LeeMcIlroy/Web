using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GCMaster.Models
{
    public class certifyCommonModel
    {
        public int IDX { get; set; }

        public string VIEW_YN { get; set; }

        public int VIEW_ORDER { get; set; }

        public int VIEW_CNT { get; set; }

        public DateTime VIEW_DATE { get; set; }

        public string NOTI_YN { get; set; }


        public string CATEGORY_CODE { get; set; }
        public string CERTIFY_NAME { get; set; }
        public string PROGRAM_NAME { get; set; }
        public string COUNTRY_NAME { get; set; }
        public string ISSUER_NAME { get; set; }
        public string ISSUE_DATE { get; set; }
        public string CERTIFY_CONTENT { get; set; }
        public string ANALYSIS_ITEM { get; set; }


        public string IMAGE_ORG_NAME { get; set; }
        public string IMAGE_SAVE_NAME { get; set; }
        public int IMAGE_SIZE { get; set; }


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

    public class certifyListModel : certifyCommonModel
    {
        /// <summary>
        /// 카테고리 국내
        /// </summary>
        public string CATEGORY_NAME1 { get; set; }

        /// <summary>
        /// 카테고리 국외
        /// </summary>
        public string CATEGORY_NAME2 { get; set; }

    }

    public class certifyViewModel : certifyCommonModel
    {
        public string VIEW_DATE_YMD { get; set; }

        public string VIEW_DATE_HM { get; set; }

    }
}