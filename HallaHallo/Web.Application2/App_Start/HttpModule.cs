using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;

public class HttpModule : System.Web.IHttpModule
{
    public void Init(System.Web.HttpApplication context)
    {
        context.BeginRequest += new EventHandler(context_BeginRequest);
        context.EndRequest += new EventHandler(context_EndRequest);
    }

    void context_EndRequest(object sender, EventArgs e)
    {
        HttpApplication application = (HttpApplication)sender;
        HttpContext context = application.Context;
        string filePath = context.Request.FilePath;
        string fileExtension = VirtualPathUtility.GetExtension(filePath);
        if (fileExtension.ToLower().Equals(".aspx") || fileExtension == string.Empty)
        {
            context.Response.CacheControl = "No-Cache";
            context.Response.Expires = -1;
        }
    }


    void context_BeginRequest(object sender, EventArgs e)
    {
        HttpApplication application = (HttpApplication)sender;
        HttpContext context = application.Context;
        string filePath = context.Request.FilePath;

        string fileExtension = VirtualPathUtility.GetExtension(filePath).ToLower();
        if (fileExtension == "exe" || fileExtension == "com" || fileExtension == "bat" || fileExtension == "dll" || fileExtension == "cpl" || fileExtension == "msi")
        {
            HallaTube.Logger.WriteLog("실행 파일 URL 요청됨 : " + filePath, "Request", null);
            context.Response.End();
        }
    }


    public void Dispose()
    {

    }
}
