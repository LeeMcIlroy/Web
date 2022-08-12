using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading;

namespace HallaTube
{
    public delegate string WriteLogDelegate(string msg, string category);
    public delegate Dictionary<string,string> GetLogDataDelegate();
    public delegate string WriteErrorDelegate(string logID, Exception ex, string category);

    public static class Logger
    {
        static object _lock = new object();
        public static string LogPath;
        public static event WriteLogDelegate WriteLogEvent;
        public static event WriteErrorDelegate WriteErrorEvent;
        public static event GetLogDataDelegate GetLogDataEvent;
        static Logger()
        {
            
            
        }


        public static string WriteLog(string msg, string category, Exception e)
        {
            msg = msg ?? string.Empty;
            

            if (e != null)
            {
                if (msg.Length > 0) msg += "\n";
                msg += e.ToString();
            }

            string logID=null;
            if (WriteLogEvent!=null)
            {
                logID=WriteLogEvent(msg, category.ToString());
            }
            else
            {
                logID=WriteLogFile(msg, category.ToString());
            }

            if(e!=null)
            {
                if (WriteErrorEvent != null)
                {
                    WriteErrorEvent(logID, e, category);
                }
                else
                {
                    WriteLogFile(msg, category.ToString());
                }
            }

            return logID;
        }

        

        

        private static string WriteLogFile(string msg, string category)
        {
            string path = LogPath + DateTime.Now.ToString("yyyy-MM-dd") + "\\";
            //string path = LogPath;
            string filepath = path + category + "_" + DateTime.Now.ToString("yyyy-MM-dd") + ".txt";
            lock (_lock)
            {
                try
                {
                    System.IO.StreamWriter sw = null;
                    if (!Directory.Exists(path))
                    {
                        Directory.CreateDirectory(path);
                    }
                    sw = new System.IO.StreamWriter(filepath, true);
                    sw.Write("[" + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss fff") + "/" + Config.SystemChar + "/" + Thread.CurrentThread.ManagedThreadId + "]  " + msg + "\r\n");
                    sw.Write("\r\n");

                    if(GetLogDataEvent!=null)
                    {
                        var data = GetLogDataEvent();
                        foreach(string key in data.Keys)
                        {
                            sw.Write(key + ":" + data[key] + "\r\n");
                        }
                    }
                    
                    sw.Flush();

                    sw.Close();
                }
                catch (Exception ex)
                {
                    _WriteLog(ex.ToString());
                    _WriteLog(filepath);
                }
            }

            return string.Empty;
        }

        public static void _WriteLog(string msg)
        {
            lock (_lock)
            {
                System.IO.StreamWriter sw = null;
                try
                {
                    sw = new System.IO.StreamWriter("c:\\testlog\\log" + DateTime.Now.ToString("yyyy-MM-dd") + ".txt", true);
                    sw.Write("[" + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") + "]  " + msg + "\r\n");
                    sw.Write("\r\n");
                    sw.Flush();
                }
                catch
                {

                }

                finally
                {
                    if (sw != null) sw.Close();
                }
            }

        }

    }
}
