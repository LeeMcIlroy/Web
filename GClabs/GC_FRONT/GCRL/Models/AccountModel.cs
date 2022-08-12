using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GCRL.Models.Account
{
    public enum UserType
    {
        Guest = 0,
        User = 1,
        Manager = 2,
        Supervisor = 9
    }

    public class UserModel
    {
        /// <summary>
        /// 
        /// </summary>
        public Guid UserID { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string LoginID { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string UserName { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string UserEmail { get; set; }

        /// <summary>
        /// 
        /// </summary>
        public string Language { get; set; }

        /// <summary>
        /// 
        /// </summary>
        public UserType UserType { get; set; }

        /// <summary>
        /// 
        /// </summary>
        public List<MenuModel> Menus { get; set; }
    }

    public class MenuModel
    {
        /// <summary>
        /// 
        /// </summary>
        public int MenuID { get; set; }

        /// <summary>
        /// 0:Folder, 1:Program, 2:Popup, 3:report
        /// </summary>
        public int MenuType { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string Controller { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string Action { get; set; }

        /// <summary>
        /// 
        /// </summary>
        public int MenuSeq { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string MenuName { get; set; }


        /// <summary>
        /// 
        /// </summary>
        public int ParentMenuID { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public int ParentMenuSeq { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string ParentMenuName { get; set; }



        /// <summary>
        /// 
        /// </summary>
        public int NaviMenuID { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public int NaviMenuSeq { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string NaviMenuName { get; set; }


        /// <summary>
        /// 
        /// </summary>
        public bool AllowNEW { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public bool AllowSAVE { get; set; }

        /// <summary>
        /// 
        /// </summary>
        public bool AllowDELETE { get; set; }

        /// <summary>
        /// 
        /// </summary>
        public bool AllowEXCEL { get; set; }

        /// <summary>
        /// 
        /// </summary>
        public bool AllowPRINT { get; set; }
    }
}