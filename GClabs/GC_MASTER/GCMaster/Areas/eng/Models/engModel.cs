using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.ComponentModel.DataAnnotations;

using GCMaster.Models;


namespace GCMaster.Areas.eng.Models
{
    public class engListModel : BoardCommonModel
    {
        public string DIV_NAME1 { get; set; }

        public string DIV_NAME2 { get; set; }
        
    }

    public class engViewModel : BoardCommonModel
    {
        public string VIEW_DATE_YMD { get; set; }

        public string VIEW_DATE_HM { get; set; }
    }

}