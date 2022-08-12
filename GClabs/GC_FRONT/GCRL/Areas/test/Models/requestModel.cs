using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Net.Http;
using System.Net.Http.Headers;

namespace GCRL.Areas.test.Models
{
    public class requestModel
    {
        public string errorCode { get; set; }
        public string totalCount { get; set; }
        public string count { get; set; }
        public string message { get; set; }

        public string search { get; set; }

        public Array data { get; set; }

        public string idx { get; set; }
        public string name { get; set; }
        public string fileName { get; set; }
        public string jpgFile { get; set; }
        public string pdfFile { get; set; }
        public string viewOrderby { get; set; }

        public string PDF_idx { get; set; }
        public string PDF_name { get; set; }
        public string PDF_fileName { get; set; }
        public string PDF_jpgFile { get; set; }
        public string PDF_pdfFile { get; set; }
        public string PDF_pdfFileLink { get; set; }

        public string PDF_viewOrderby { get; set; }

        public string load_idx1 { get; set; }
        public string load_idx2 { get; set; }
        public string load_idx3 { get; set; }
        public string load_idx4 { get; set; }
        public string load_idx5 { get; set; }

        public string idx1 { get; set; }
        public string idx2 { get; set; }
        public string idx3 { get; set; }
        public string idx4 { get; set; }
        public string idx5 { get; set; }

        public string name1 { get; set; }
        public string name2 { get; set; }
        public string name3 { get; set; }
        public string name4 { get; set; }
        public string name5 { get; set; }

        public string fileName1 { get; set; }
        public string fileName2 { get; set; }
        public string fileName3 { get; set; }
        public string fileName4 { get; set; }
        public string fileName5 { get; set; }

        public string jpgFile1 { get; set; }
        public string jpgFile2 { get; set; }
        public string jpgFile3 { get; set; }
        public string jpgFile4 { get; set; }
        public string jpgFile5 { get; set; }

        public string pdfFile1 { get; set; }
        public string pdfFile2 { get; set; }
        public string pdfFile3 { get; set; }
        public string pdfFile4 { get; set; }
        public string pdfFile5 { get; set; }

        public string viewOrderby1 { get; set; }
        public string viewOrderby2 { get; set; }
        public string viewOrderby3 { get; set; }
        public string viewOrderby4 { get; set; }
        public string viewOrderby5 { get; set; }

        //public AddressViewModel Address { get; set; }
        //public StandardViewModel Standard { get; set; }
    }
}