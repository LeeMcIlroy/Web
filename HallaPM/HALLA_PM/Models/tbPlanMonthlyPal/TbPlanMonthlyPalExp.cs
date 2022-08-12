using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class TbPlanMonthlyPalExp : TbPlanMonthlyPal
    {
        public List<TbPlanMonthlyPalBusiness> tbPlanMonthlyPalBusinessList { get; set; }
    }
}