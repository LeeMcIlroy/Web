using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GCRL.Models
{
    public class certifyBoardModel
    {
        public int IDX { get; set; }


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

    }

    public class certifyListModel
    {
        public List<certifyBoardModel> localCertifies { get; set; }

        public List<certifyBoardModel> globalCertifies { get; set; }
    }
}