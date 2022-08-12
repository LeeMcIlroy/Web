using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GCRL.Areas.main.Models
{
    public class searchModel
    {
        public int ROW_NO { get; set; }
        public string TYPE { get; set; }

        public int IDX { get; set; }

        public string TITLE { get; set; }

        public string CODE { get; set; }
    }

    public class searchListModel
    {
        public int IDX { get; set; }

        public string MENU { get; set; }

        public string TITLE { get; set; }

        public string LINK { get; set; }
    }

    public class searchResultModel
    {
        public int totalCount { get; set; } = 0;
        public int testCount { get; set; } = 0;
        public int supportCount { get; set; } = 0;
        public int prCount { get; set; } = 0;
        public int gclabsCount { get; set; } = 0;
        /// <summary>
        /// 검사안내
        /// </summary>
        public List<searchListModel> testList { get; set; } = new List<searchListModel>();
        /// <summary>
        /// 고객지원
        /// </summary>
        public List<searchListModel> supportList { get; set; } = new List<searchListModel>();
        /// <summary>
        /// 재단홍보
        /// </summary>
        public List<searchListModel> prList { get; set; } = new List<searchListModel>();
        /// <summary>
        /// 재단소개
        /// </summary>
        public List<searchListModel> gclabsList { get; set; } = new List<searchListModel>();
    }
}