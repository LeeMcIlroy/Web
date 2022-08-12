using System;
using System.ComponentModel.DataAnnotations;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using GCRL.Models;

namespace GCRL.Areas.eng.Models
{
    public class updateModel
    {
        public int ROW_NUM { get; set; }
        public int IDX { get; set; }
        public string DIV_CODE1 { get; set; }       // 구분
        public string DIV_NAME1 { get; set; }

        public string TITLE { get; set; }           // Test item
        public string CONTENT_S { get; set; }       // GC Labs code
        public string CONTENT_F { get; set; }       // 내용

        public string IMAGE_SAVE_NAME { get; set; }

        public string DIV_DATE1 { get; set; }
        public string REGIST_DATE { get; set; }
    }

    public class updateViewModel
    {
        public int ROW_NUM { get; set; }
        public int IDX { get; set; }
        public string DIV_CODE1 { get; set; }       // 구분
        public string DIV_NAME1 { get; set; }

        public string TITLE { get; set; }           // Test item
        public string CONTENT_S { get; set; }       // GC Labs code
        public string CONTENT_F { get; set; }       // 내용

        public string IMAGE_SAVE_NAME { get; set; }

        public string DIV_DATE1 { get; set; }
        public string REGIST_DATE { get; set; }

        public int PRE_IDX { get; set; }
        public string PRE_TITLE { get; set; }
        public int NEXT_IDX { get; set; }
        public string NEXT_TITLE { get; set; }
    }
}