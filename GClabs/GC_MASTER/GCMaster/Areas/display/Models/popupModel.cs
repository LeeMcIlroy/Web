using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;
using GCMaster.Models;
using System.Web.Mvc;

namespace GCMaster.Areas.display.Models
{
    public class popupModel
    {
        public int ROW_NUM { get; set; }
        public int IDX { get; set; }
        public string DVI_TYP { get; set; }
        public string DVI_TYP_NM { get; set; }
        public string LANG_TYP { get; set; }
        public string TITLE { get; set; }
        public string IMG { get; set; }
        public string IMG_NM { get; set; }
        public int IMG_SIZE { get; set; }
        public string VIEW_DATE_ST { get; set; }
        public string VIEW_TIME_ST { get; set; }
        public string VIEW_STT { get; set; }
        public string VIEW_DATE_ED { get; set; }
        public string VIEW_TIME_ED { get; set; }
        public string VIEW_END { get; set; }
        public string VIEW_TIME { get; set; }
        public int WID { get; set; }
        public int HEI { get; set; }
        public int TOP { get; set; }
        public int LFT { get; set; }
        public string URL { get; set; }
        public string CLS_TYP { get; set; }    //링크이동
        public string INS_TYP { get; set; }    //팝업구분
        public string VIEW_YN { get; set; }
        public string INS_DATE { get; set; }
        public string INS_DATE_MIN { get; set; }
        public string INS_USER { get; set; }
        public string INS_USR_NM { get; set; }
        public string UPD_DATE { get; set; }
        public string UPD_DATE_MIN { get; set; }
        public string UPD_USER { get; set; }
        public string UPD_USR_NM { get; set; }
    }

    public class popupDetail
    {
        public int IDX { get; set; }
        public string DVI_TYP { get; set; }
        public string DVI_TYP_NM { get; set; }
        public string LANG_TYP { get; set; }
        public string TITLE { get; set; }
        public string CONTENT { get; set; }
        public string VIEW_DATE_ST { get; set; }
        public string VIEW_TIME_ST { get; set; }
        public string VIEW_STT { get; set; }
        public string VIEW_DATE_ED { get; set; }
        public string VIEW_TIME_ED { get; set; }
        public string VIEW_END { get; set; }
        public string VIEW_TIME { get; set; }
        public int WID { get; set; }
        public int HEI { get; set; }
        public int TOP { get; set; }
        public int LFT { get; set; }
        public string IMG { get; set; }
        public string IMG_NM { get; set; }
        public int IMG_SIZE { get; set; }
        public string URL { get; set; }
        public string URL_NM { get; set; }
        public string CLS_TYP { get; set; }    //링크이동
        public string INS_TYP { get; set; }    //팝업구분
        public string VIEW_YN { get; set; }
        public string INS_DATE { get; set; }
        public string INS_DATE_MIN { get; set; }
        public string INS_USER { get; set; }
        public string INS_USR_NM { get; set; }
        public string UPD_DATE { get; set; }
        public string UPD_DATE_MIN { get; set; }
        public string UPD_USER { get; set; }
        public string UPD_USR_NM { get; set; }
    }
}