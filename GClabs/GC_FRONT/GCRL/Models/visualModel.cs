using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GCRL.Model
{
    public class visualModel
    {
     
        public int IDX { get; set; }
        public string LANG_CLS { get; set; }

        public string DEVI_CLS { get; set; }

        public string VIEW_YN { get; set; }

        public int VIEW_ORDER { get; set; }

        public string TITLE { get; set; }
        public string TITLE_1 { get; set; }
        public string TITLE_2{ get; set; }

        public string IMG_ALT { get; set; }

        public string IMAGE1_ORG_NM { get; set; }

        public string IMAGE1_SAVE_NM { get; set; }

        public int IMAGE1_SIZE { get; set; }

        public string IMAGE2_ORG_NM { get; set; }
        
        public string IMAGE2_SAVE_NM { get; set; }

        public int IMAGE2_SIZE { get; set; }

        public string IMAGE_ORG_NM { get; set; }

        public string IMAGE_SAVE_NM { get; set; }

        public int IMAGE_SIZE { get; set; }
        public string COMM_CD { get; set; }
        public string COMM_NM { get; set; }
        public string CONTENT_CLS { get; set; }
        public string LINK_URL { get; set; }


    }
}