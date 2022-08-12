using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class InsaDeptV
    {
        public string Deptcode { get; set; }
        public string Compcode2 { get; set; }
        public string Deptkorname { get; set; }
        public string Deptengname { get; set; }
        public string Deptchnname { get; set; }
        public string Deptjpnname { get; set; }
        public string Deptetcname { get; set; }
        public string Compcode { get; set; }
        public string Compkorname { get; set; }
        public string Compengname { get; set; }
        public string Compchnname { get; set; }
        public string Compjpnname { get; set; }
        public string Competcname { get; set; }
        public string Parentcode { get; set; }
        public string Nationalcode { get; set; }
        public int Deptlevel { get; set; }
        public string Deptfullcode { get; set; }
        public string Deptfullkorname { get; set; }
        public string Deptfullengname { get; set; }
        public string Deptfullchnname { get; set; }
        public string Deptfulljpnname { get; set; }
        public string Deptfulletcname { get; set; }
        public string Statuscode { get; set; }
        public string Displayyn { get; set; }
        public string Insainfoyn { get; set; }
        public int Issortno { get; set; }
        public DateTime Updatedt { get; set; }
    }
}