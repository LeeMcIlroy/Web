using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class ExcelFileUploadList
    {
        public int Seq { get; set; }
        public string UserKey { get; set; }
        public string EmpNo { get; set; }
        public DateTime CreateDate { get; set; }
        public string AttachTableName { get; set; }
        public int AttachTableSeq { get; set; }
        public string FileInputName { get; set; }
        public string FilePath { get; set; }
        public string FileOrgName { get; set; }
        public string FileStoredName { get; set; }
        public string FileSize { get; set; }
        public string Descript { get; set; }
    }
}