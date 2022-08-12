using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Util
{
    public class Search : Paging
    {
        #region SearchTitle : 제목
        /// <summary>
        /// 제목
        /// </summary>
        public string SearchTitle { get; set; }
        #endregion

        #region SearchContent : 내용
        /// <summary>
        /// 내용
        /// </summary>
        public string SearchContent { get; set; }
        #endregion

        public string AuthUserKey { get; set; }

        public string year { get; set; }
        public string mm { get; set; }

        public int OrgCompanySeq { get; set; }
        public int DetailSeq { get; set; }


        public string DownExcelType { get; set; }

        public int searchType { get; set; }
        public string searchText { get; set; }
        public string searchText1 { get; set; }
        public string searchYear { get; set; }
        public string searchMonth { get; set; }
        public int searchCpySeq { get; set; }
        public string searchCpyPart { get; set; }
        public string searchCpyName { get; set; }
        public string searchBusType { get; set; }
        public string searchState { get; set; }
        public string searchDate { get; set; }

    }
}