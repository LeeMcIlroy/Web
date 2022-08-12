using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;
using System.Xml.Serialization;

using GCMaster.Models;
using System.Web.Mvc;

namespace GCMaster.Areas.common.Models
{
    public class menuModel
    {
        public int IDX { get; set; }

        public string GROUP_CODE { get; set; }

        

        public string CONTROLLER { get; set; }

        public string ACTION { get; set; }

        public string NAME { get; set; }


        public string REGIST_ID { get; set; }

        public string REGIST_NAME { get; set; }

        public DateTime REGIST_DATE { get; set; }

        public string UPDATE_ID { get; set; }

        public string UPDATE_NAME { get; set; }

        public DateTime UPDATE_DATE { get; set; }

    }

    public class menuListModel : menuModel
    {
        public string AUTH_CODE { get; set; }

        public string GROUP_NAME { get; set; }

        public bool USE_YN { get; set; }

    }

    [XmlTypeAttribute(typeName: "MenuAuth")]
    public class menuListSaveModel
    {
        public int IDX { get; set; }
        public string AUTH_CODE { get; set; }
        public bool USE_YN { get; set; }
    }


    public class menuViewModel : menuModel
    {
        public string USE_YN { get; set; }
    }

}