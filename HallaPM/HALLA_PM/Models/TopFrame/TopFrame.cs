using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class TopFrame
    {
        public int RegistStatus { get; set; }
        public int AuthLevel { get; set; }
        public string UnionName { get; set; }
        public string CompanyName { get; set; }
        //공시계획 여부 추가
        public string PlanYn { get; set; }

    }
}