using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class DisclosureData : Disclosure
    {
        public int rowNum { get; set; }

        public int IdxSeq { get; set; }

        public int DisItemSeq { get; set; }

        public string DisName { get; set; }
        public int DetailSeq { get; set; }

        public string DetailName { get; set; }
        public string Title { get; set; }

        public string TransCpn { get; set; }
        public int TransAmt { get; set; }
        public string TransDate { get; set; }
        public string DisCode { get; set; }
        public string Content { get; set; }
        public string Remark { get; set; }
        public string T11_01 { get; set; }
        public string T11_02 { get; set; }
        public string T11_03 { get; set; }
        public string T12_01 { get; set; }
        public string T12_02 { get; set; }
        public string T12_03 { get; set; }
        public string T13_01 { get; set; }
        public string T13_02 { get; set; }
        public string T13_03 { get; set; }
        public string T14_01 { get; set; }
        public string T14_02 { get; set; }
        public string T14_03 { get; set; }
        public string T15_01 { get; set; }
        public string T15_02 { get; set; }
        public string T15_03 { get; set; }
        public string T16_01 { get; set; }
        public string T16_02 { get; set; }
        public string T16_03 { get; set; }
        public string T17_01 { get; set; }
        public string T17_02 { get; set; }
        public string T17_03 { get; set; }
        public string T18_01 { get; set; }
        public string T18_02 { get; set; }
        public string T18_03 { get; set; }
        public string T19_01 { get; set; }
        public string T19_02 { get; set; }
        public string T19_03 { get; set; }
        public string JAN_01 { get; set; }
        public string JAN_02 { get; set; }
        public string JAN_03 { get; set; }
        public string FEB_01 { get; set; }
        public string FEB_02 { get; set; }
        public string FEB_03 { get; set; }
        public string MAR_01 { get; set; }
        public string MAR_02 { get; set; }
        public string MAR_03 { get; set; }
        public string APR_01 { get; set; }
        public string APR_02 { get; set; }
        public string APR_03 { get; set; }
        public string MAY_01 { get; set; }
        public string MAY_02 { get; set; }
        public string MAY_03 { get; set; }
        public string JUN_01 { get; set; }
        public string JUN_02 { get; set; }
        public string JUN_03 { get; set; }
        public string JUL_01 { get; set; }
        public string JUL_02 { get; set; }
        public string JUL_03 { get; set; }
        public string AUG_01 { get; set; }
        public string AUG_02 { get; set; }
        public string AUG_03 { get; set; }
        public string SEP_01 { get; set; }
        public string SEP_02 { get; set; }
        public string SEP_03 { get; set; }
        public string OCT_01 { get; set; }
        public string OCT_02 { get; set; }
        public string OCT_03 { get; set; }
        public string NOV_01 { get; set; }
        public string NOV_02 { get; set; }
        public string NOV_03 { get; set; }
        public string DEC_01 { get; set; }
        public string DEC_02 { get; set; }
        public string DEC_03 { get; set; }


        public int afterRegistStatus { get; set; }
    }
}