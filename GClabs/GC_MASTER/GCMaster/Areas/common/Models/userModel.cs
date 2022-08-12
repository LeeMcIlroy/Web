using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;

using GCMaster.Models;
using System.Web.Mvc;

namespace GCMaster.Areas.common.Models
{
    public class userModel
    {
        public int IDX { get; set; }

        public string USE_YN { get; set; }

        public string ADM_ID { get; set; }

        public string ADM_NAME { get; set; }

        public string ADM_PWD { get; set; }

        public string PHONE { get; set; }

        public string EMAIL { get; set; }

        public string AUTH_CODE { get; set; }

        public string DEPT_CODE { get; set; }

        public string QNA_MAIL_TO { get; set; }
        public string QNA_MAIL_CC { get; set; }
        public string QNA_MAIL_BCC { get; set; }

        public DateTime ACCESS_DATE { get; set; }

        public int REGIST_IDX { get; set; }

        public string REGIST_ID { get; set; }

        public DateTime REGIST_DATE { get; set; }

        public int UPDATE_IDX { get; set; }

        public string UPDATE_ID { get; set; }

        public DateTime UPDATE_DATE { get; set; }

    }

    public class userListModel : userModel
    {
        public string AUTH_NAME { get; set; }

        public string DEPT_NAME { get; set; }

        public string REGIST_NAME { get; set; }

    }

    public class userViewModel : userModel
    {

        public string REGIST_NAME { get; set; }

        public string UPDATE_NAME { get; set; }

        public IList<string> SelectedMailTos { get; set; }

        public IList<string> SelectedMailCCs { get; set; }

        public IList<string> SelectedMailBCCs { get; set; }

    }

    public class userEditHistoryModel
    {

        public int ROW_NO { get; set; }

        public string ITEM { get; set; }

        public string REGIST_ID { get; set; }

        public string REGIST_NAME { get; set; }

        public DateTime REGIST_DATE { get; set; }

    }

    public class userAccessHistoryModel
    {

        public int ROW_NO { get; set; }

        public DateTime ACCESS_DATE { get; set; }

        public string IPADDRESS { get; set; }

    }

}