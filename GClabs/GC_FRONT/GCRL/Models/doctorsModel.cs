using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GCRL.Models
{
    public class doctorsModel
    {
        public int IDX { get; set; }


        public string NAME { get; set; }

        public string NAME_ENG { get; set; }

        public string DEPT_CODE { get; set; }

        public string SUMMARY { get; set; }
    }

    public class paperModel
    {
        public int IDX { get; set; }

        public string NAME { get; set; }

        public string YEAR { get; set; }

        public string SOURCE { get; set; }


        public string ATTACH_ORG_NAME { get; set; }
        public string ATTACH_SAVE_NAME { get; set; }
    }

    public class doctorsListModel : doctorsModel
    {

    }

    public class doctorsViewModel : doctorsModel
    {

        public int PREV_IDX { get; set; }

        public string PREV_NAME { get; set; }

        public int NEXT_IDX { get; set; }

        public string NEXT_NAME { get; set; }

        public List<paperModel> PAPERS { get; set; }
    }
}