using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Web;

namespace GCRL.Modules
{
    public static class Logs
    {

        private static string ExceptionMessage(Exception exception, int depth)
        {
            StringBuilder msg = new StringBuilder();

            // Inner Ex가 있으면 안쪽을 먼저 작성한다
            if (exception.InnerException != null)
                msg.Append(ExceptionMessage(exception.InnerException, depth + 1));

            msg.AppendFormat("---------- depth : {0} ----------\r\n", depth);

            msg.AppendFormat("[Source] : {0}\r\n", exception.Source);
            msg.AppendFormat("[Message]\r\n{0}\r\n", exception.Message);
            msg.AppendFormat("[StackTrace]\r\n{0}\r\n", exception.StackTrace);

            return msg.ToString();
        }

        private static bool SaveLocalLogFile(string localpath, string logdata)
        {
            StreamWriter sw = null;

            try
            {
                if (!Directory.Exists(Path.GetDirectoryName(localpath)))
                {
                    Directory.CreateDirectory(Path.GetDirectoryName(localpath));
                }

                if (!File.Exists(localpath))
                {
                    File.Create(localpath).Close();
                }

                sw = File.AppendText(localpath);

                sw.WriteLine(logdata);
                sw.Close();

                return true;
            }
            catch
            {
                return false;
            }
            finally
            {
                if (sw != null)
                    sw.Dispose();
            }
        }

        internal static void SaveException(MethodBase methodbase, Exception exception)
        {
            string message = ExceptionMessage(exception, 0);

            message = string.Format("[{0} | {1}.{2} ]\r\n{3}",
                            DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"),
                            methodbase.ReflectedType.Name,
                            methodbase.Name,
                            message);


            string filepath = string.Format("{0}Log\\Errors\\{1}.log",
                            AppDomain.CurrentDomain.BaseDirectory,
                            DateTime.Today.ToString("yyyyMMdd"));

            SaveLocalLogFile(filepath, message);
        }
    }
}