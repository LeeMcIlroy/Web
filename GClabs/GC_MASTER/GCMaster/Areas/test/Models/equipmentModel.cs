using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.ComponentModel.DataAnnotations;

using GCMaster.Models;


namespace GCMaster.Areas.test.Models
{
    public class equipmentListModel : BoardCommonModel
    {
        public string DIV_NAME1 { get; set; }
        
    }

    public class equipmentViewModel : BoardCommonModel
    {
        public string VIEW_DATE_YMD { get; set; }

        public string VIEW_DATE_HM { get; set; }

    }

}