using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class FileInfo
    {
        public int seq { get; set; }
        public string regDate { get; set; }
        public string attachTableName { get; set; }
        public int attachTableSeq { get; set; }
        public string fileInputName { get; set; }
        public string filePath { get; set; }
        public string fileOrgName { get; set; }
        public string fileStoredName { get; set; }
        public string fileSize { get; set; }
    }
}