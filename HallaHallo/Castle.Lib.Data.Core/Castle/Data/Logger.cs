// Decompiled with JetBrains decompiler
// Type: Castle.Data.Logger
// Assembly: Castle.Lib.Data.Core, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 27E9C49E-74A4-4958-A484-30DAD04DD134
// Assembly location: D:\Halla\Hallo\HallaTube\Common.Config\bin\Debug\Castle.Lib.Data.Core.dll

using System;
using System.IO;

namespace Castle.Data
{
  public static class Logger
  {
    private static object _lock = new object();
    public static string LogPath;
    private const string insquery = "\r\nDELETE TB_LOG WHERE REG_DATE<@DELETE_DATE\r\nINSERT INTO TB_LOG(LOG_ID,CATEGORY,SYSTEM,THREAD,IS_ERROR,REG_DATE,REQUEST_ID,DOC_ID,USER_ID,MESSAGE)\r\nVALUES(@LOG_ID,@CATEGORY,@SYSTEM,@THREAD,@IS_ERROR,@REG_DATE,@REQUEST_ID,@DOC_ID,@USER_ID,@MESSAGE)";

    public static string WriteLog(string msg, string category, Exception e)
    {
      msg = msg ?? string.Empty;
      object empty1 = (object) string.Empty;
      object empty2 = (object) string.Empty;
      object empty3 = (object) string.Empty;
      if (e != null)
      {
        if (msg.Length > 0)
          msg += "\n";
        msg += e.ToString();
      }
      return Logger.WriteLogFile(msg, category.ToString(), empty1.ToString(), empty2.ToString(), empty3.ToString());
    }

    private static string WriteLogFile(
      string msg,
      string category,
      string requestID,
      string docID,
      string userID)
    {
      string path = Logger.LogPath + DateTime.Now.ToString("yyyy-MM-dd") + "\\";
      string str = path + category + "_" + DateTime.Now.ToString("yyyy-MM-dd") + ".txt";
      lock (Logger._lock)
      {
        try
        {
          if (!Directory.Exists(path))
            Directory.CreateDirectory(path);
          StreamWriter streamWriter = new StreamWriter(str, true);
          streamWriter.Write("[" + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss fff") + "]  " + msg + "\r\n");
          streamWriter.Write("\r\n");
          streamWriter.Write("requestID:" + requestID + "\r\n");
          streamWriter.Write("docID:" + docID + "\r\n");
          streamWriter.Write("userID:" + userID + "\r\n");
          streamWriter.Flush();
          streamWriter.Close();
        }
        catch (Exception ex)
        {
          Logger.WriteLog2(ex.ToString());
          Logger.WriteLog2(str);
        }
      }
      return string.Empty;
    }

    public static void WriteLog2(string msg)
    {
      lock (Logger._lock)
      {
        StreamWriter streamWriter1 = (StreamWriter) null;
        try
        {
          DateTime now = DateTime.Now;
          streamWriter1 = new StreamWriter("c:\\testlog\\log" + now.ToString("yyyy-MM-dd") + ".txt", true);
          StreamWriter streamWriter2 = streamWriter1;
          string[] strArray = new string[5]
          {
            "[",
            null,
            null,
            null,
            null
          };
          now = DateTime.Now;
          strArray[1] = now.ToString("yyyy-MM-dd HH:mm:ss");
          strArray[2] = "]  ";
          strArray[3] = msg;
          strArray[4] = "\r\n";
          string str = string.Concat(strArray);
          streamWriter2.Write(str);
          streamWriter1.Write("\r\n");
          streamWriter1.Flush();
        }
        catch
        {
        }
        finally
        {
          streamWriter1?.Close();
        }
      }
    }
  }
}
