using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class TrendSearch
    {
        public string level0 { get; set; }
        public string level1 { get; set; }
        public string level2 { get; set; }

        /// <summary>
        /// year : 년도,
        /// quater : 분기,
        /// month_period : 월(기간)
        /// month_select : 월선택
        /// </summary>
        public string yearType { get; set; }


        public string year_y_from { get; set; }
        public string year_y_to { get; set; }


        public string quater_y_from { get; set; }
        public string quater_y_to { get; set; }
        public List<string> quater { get; set; }


        public string month_period_y_from { get; set; }
        public string month_period_m_from { get; set; }
        public string month_period_y_to { get; set; }
        public string month_period_m_to { get; set; }


        public string month_select_y_from { get; set; }
        public string month_select_y_to { get; set; }
        public List<string> month_select_m { get; set; }
    }
}