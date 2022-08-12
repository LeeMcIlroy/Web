using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.ComponentModel.DataAnnotations;

using GCMaster.Models;


namespace GCMaster.Areas.connect.Models
{
    public class faqListModel : BoardCommonModel
    {
        public string DIV_NAME1 { get; set; }
        
    }

    public class faqViewModel : BoardCommonModel
    {
        public string VIEW_DATE_YMD { get; set; }

        public string VIEW_DATE_HM { get; set; }
    }

}