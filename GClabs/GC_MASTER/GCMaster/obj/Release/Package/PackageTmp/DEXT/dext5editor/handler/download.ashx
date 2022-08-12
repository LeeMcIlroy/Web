<%@ WebHandler Language="C#" Class="download" %>

using System;
using System.Web;
using System.IO;
using DEXTUpload.NET;
using GCMaster.Modules;
using GCMaster.Controllers;
using System.Linq;

using GCMaster.Areas.connect.Models;
using System.Data;
using System.Collections.Generic;
using Dapper;
public class download : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        var type = context.Request.QueryString["TYPE"] ?? string.Empty;
        var idx = context.Request.QueryString["IDX"] ?? string.Empty;
        var attach = context.Request.QueryString["ATTACH"] ?? string.Empty;
        var folder = context.Request.QueryString["FOLDER"] ?? string.Empty;
        var data = "";

        // key에 해당하는 파일의 경로를 얻는다.

        using (var conn = Functions.ConnectionDefault)
        {
            conn.Open();

            data = conn.Query<string>("dbo.GCMASTER_CONNECT_COMMON_FILE_UPD_DEL",
               param: new
               {
                   R_CRUD =  "D10",
                   GUBUN = attach,
                   Type = type,
                   Idx = idx
               },
               commandType: CommandType.StoredProcedure
           ).FirstOrDefault();

        }
        using (var dext = new FileDownload())
        {


            //var file = new FileInfo(Functions.defaultPath+folder+"/"+data);
            //dext.Download(file);

        }
        // 다운로드 작업 이후에 'Response.Write' 메소드를 사용하여 응답 데이터에 데이터를 기록하면 안된다.
    }


    public bool IsReusable { get { return false; } }

}