using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class PmCashFlowCumulativeSummary
    {
        public string cashFlowYear { get; set; }

        // 하단 도표에 사용
        public decimal endingCash { get; set; }
        public decimal availableCash { get; set; }
        public decimal fcf2 { get; set; }

        // 상단 그래프에 사용
        public decimal ebitda { get; set; }
        public decimal wcSum { get; set; }
        public decimal etc { get; set; }
        public decimal financialCost { get; set; }
        public decimal netCapexSum { get; set; }

        // 추가 
        public decimal sales { get; set; }
        public decimal investment { get; set; }
    }
}