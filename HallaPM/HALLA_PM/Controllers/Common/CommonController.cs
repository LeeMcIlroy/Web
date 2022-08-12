using HALLA_PM.Models;
using HALLA_PM.Util;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

using HALLA_PM.Core;
using System.IO;
using System.Dynamic;
using System.Data;

namespace HALLA_PM.Controllers
{
    [RoutePrefix("common")]
    public class CommonController : Controller
    {

        FileInfoRepo fileInfoRepo = new FileInfoRepo();

        [Route("editor_photo_upload")]
        public ActionResult editor_photo_upload(HttpPostedFileBase Filedata, string callback, string callback_func, string folder)
        {
            FileUtil fileUtil = new FileUtil(HALLA_PM.Core.Define.FILE_PATH);
            var file = fileUtil.upload(Filedata, folder);
            string fileResult = "";

            if (file.GetValue("FILE_SIZE") == "0")
            {
                fileResult += "&errstr=error";
            }

            string originalFileName = file.GetValue("ORIGINAL_FILE_NAME");
            string storedFileName = file.GetValue("STORED_FILE_NAME");
            fileResult += "&bNewLine=true&sFileName=" + originalFileName + "&sFileURL=/Files/" + folder + "/" + storedFileName;

            string redirect = callback + "?callback_func=" + callback_func + fileResult;
            return Redirect("~/" + redirect);
        }

    }
}