using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;

namespace HALLA_PM.Util
{
    public class clsReturnValues
    {
        public string strResult_Code { get; set; }
        public string strResult_Msg { get; set; }
        public string strApi_Path { get; set; }
        public string strCall_User { get; set; }
        public DataSet dsReturn_Data { get; set; }
    }
}