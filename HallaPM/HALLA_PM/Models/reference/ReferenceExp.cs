using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class ReferenceExp : Reference
    {
        public List<FileInfo> fileInfoList { get; set; }
        public string adminName { get; set; }

        public int prevSeq { get; set; }            // 이전글 SEQ
        public int nextSeq { get; set; }            // 다음글 SEQ
        public string prevTitle { get; set; }       // 이전글 제목
        public string nextTitle { get; set; }       // 다음글 제목
    }
}