using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class PlanYearPalExp : PlanYearPal
    {
        public List<PlanYearPalBusiness> planYearPalBusinessList { get; set; }
    }
}