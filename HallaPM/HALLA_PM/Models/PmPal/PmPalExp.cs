using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class PmPalExp : PmPal
    {
        public List<PmPalBusiness> pmPalBusinessList { get; set; }
    }
}