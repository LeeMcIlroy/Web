using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using HALLA_PM.Core;
using System.IO;

namespace HALLA_PM.Util
{
    public class LogUtil
    {
        #region logPath : 시스템의 로그파일 위치를 가져옵니다.
        /// <summary>
        /// 시스템의 로그파일 위치를 가져옵니다.
        /// </summary>
        private static string logPath = Define.LOG_PATH;
        #endregion

        #region getMonthly : 시스템의 년월 정보를 가져옵니다.
        /// <summary>
        /// 시스템의 년월 정보를 가져옵니다.
        /// </summary>
        /// <returns></returns>
        private static string getMonthly()
        {
            return DateTime.Now.ToString("yyyyMM");
        }
        #endregion

        #region getToday : 시스템의 년월일 정보를 가져옵니다.
        /// <summary>
        /// 시스템의 년월일 정보를 가져옵니다.
        /// </summary>
        /// <returns></returns>
        private static string getToday()
        {
            return DateTime.Now.ToString("yyyyMMdd");
        }
        #endregion

        #region getNow : 시스템의 현재 시간(년월일시분초)의 정보를 가져옵니다.
        /// <summary>
        /// 시스템의 현재 시간(년월일시분초)의 정보를 가져옵니다.
        /// </summary>
        /// <returns></returns>
        private static string getNow()
        {
            return DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
        }
        #endregion

        #region WriteLog : 로그를 남깁니다.
        /// <summary>
        /// 로그를 남깁니다.
        /// </summary>
        /// <param name="folderName"></param>
        /// <param name="logMessage"></param>
        public static void WriteLog(string folderName, string logMessage)
        {
            var directory = Path.Combine(logPath, folderName);
            directory = Path.Combine(directory, getMonthly());

            if (!Directory.Exists(directory)) Directory.CreateDirectory(directory);

            using (StreamWriter w = File.AppendText(directory + "/" + getToday() + ".txt"))
            {
                w.WriteLine("{0} | {1}", getNow(), logMessage);
            }
        }
        #endregion

        #region ReportError : 보고사이트 에러 로그를 남깁니다.
        /// <summary>
        /// 보고사이트 에러 로그를 남깁니다.
        /// </summary>
        /// <param name="errMessage"></param>
        public static void ReportErrorLog(string errMessage)
        {
            WriteLog("ReportError", errMessage);
        }
        #endregion

        #region MngError : 관리사이트 에러 로그를 남깁니다.
        /// <summary>
        /// 관리사이트 에러 로그를 남깁니다.
        /// </summary>
        /// <param name="errMessage"></param>
        public static void MngError(string errMessage)
        {
            WriteLog("MngError", errMessage);
        }
        #endregion

        public static void Error(string logMessage)
        {
            WriteLine("error", logMessage);
        }

        private static void WriteLine(string v, string logMessage)
        {
            WriteLog("MngError", logMessage);
        }
    }
}