using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using GCRL.Models;

namespace GCRL.Areas.pr.Models
{
    public class prBoardModel
    {
        public int IDX { get; set; }

        public int VIEW_ORDER { get; set; }

        public int VIEW_CNT { get; set; }

        public string NOTI_YN { get; set; }


        public string DIV_NAME1 { get; set; }


        public string TITLE { get; set; }

        public string CONTENT_S { get; set; }

        public string CONTENT_F { get; set; }


        public string IMAGE1_ORG_NAME { get; set; }
        public string IMAGE1_SAVE_NAME { get; set; }

        public string ATTACH1_ORG_NAME { get; set; }
        public string ATTACH1_SAVE_NAME { get; set; }


        public string LINK1_NAME { get; set; }
        public string LINK1_URL { get; set; }

        public string LINK2_NAME { get; set; }
        public string LINK2_URL { get; set; }

        public string LINK3_NAME { get; set; }
        public string LINK3_URL { get; set; }

        public string REGIST_NAME { get; set; }

        public DateTime REGIST_DATE { get; set; }

        public bool NEW_YN { get; set; }
    }

    public class prListModel : prBoardModel
    {

    }

    public class prViewModel : prBoardModel
    {

        public int PREV_IDX { get; set; }

        public string PREV_TITLE { get; set; }

        public int NEXT_IDX { get; set; }

        public string NEXT_TITLE { get; set; }
    }
}