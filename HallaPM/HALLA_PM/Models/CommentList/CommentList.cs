using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using HALLA_PM.Util;

namespace HALLA_PM.Models
{
    public class CommentList : Paging
    {
        public int Seq { get; set; }
        public string UserKey { get; set; }
        public string EmpNo { get; set; }
        public string UserKorName { get; set; }
        public string CompKorName { get; set; }
        public string DeptKorName { get; set; }
        public DateTime CreateDate { get; set; }
        public string CreateDateToString { get; set; }
        public string AttachTableName { get; set; }
        public int AttachTableSeq { get; set; }
        public string CommentYear { get; set; }
        public string CommentMonth { get; set; }
        public string Comment { get; set; }
        public string AdminWrite { get; set; } = "N";

        public string CompanyName { get; set; }
    }
}