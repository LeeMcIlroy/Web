using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Text.RegularExpressions;
using System.Reflection;

namespace HallaTube
{
    public static class Util
    {
        public static string GetDayOfWeekString(DayOfWeek dayOfWeek, string lang)
        {
            string DayOfWeekString = string.Empty;
            if (lang == "KOR")
            {
                switch (dayOfWeek)
                {
                    case DayOfWeek.Sunday:
                        DayOfWeekString = "일";
                        break;
                    case DayOfWeek.Monday:
                        DayOfWeekString = "월";
                        break;
                    case DayOfWeek.Tuesday:
                        DayOfWeekString = "화";
                        break;
                    case DayOfWeek.Wednesday:
                        DayOfWeekString = "수";
                        break;
                    case DayOfWeek.Thursday:
                        DayOfWeekString = "목";
                        break;
                    case DayOfWeek.Friday:
                        DayOfWeekString = "금";
                        break;
                    case DayOfWeek.Saturday:
                        DayOfWeekString = "토";
                        break;
                }
            }
            else
            {
                DayOfWeekString = dayOfWeek.ToString().Substring(0, 3);
            }

            return DayOfWeekString;
        }

        public static string GetDBDateString(DateTime dt)
        {
            if (dt == DateTime.MinValue) return "null";
            int hour = dt.Hour > 12 ? dt.Hour - 12 : dt.Hour;
            string dd = dt.Hour > 12 ? "PM" : "AM";
            string s = "{0} {1} {2} {3}:{4}:{5}:{6}{7}";
            return string.Format(s, dt.Month, dt.Day, dt.Year, hour.ToString().PadLeft(2, '0'),
                dt.Minute.ToString().PadLeft(2, '0'), dt.Second.ToString().PadLeft(2, '0'),
                dt.Millisecond.ToString().PadLeft(3, '0'), dd);

        }

        public static string GetDBDateString2(DateTime dt)
        {
            if (dt == DateTime.MinValue) return "null";

            return dt.ToString(Const.DateHHmmss);

        }

        public static string[] Split(string str, int length)
        {
            int size = (int)Math.Ceiling((double)str.Length / (double)length);

            int remainder = str.Length % length;

            string[] arr = new string[size];

            for (int i = 0; i < arr.Length; i++)
            {
                arr[i] = str.Substring(i * length, (i + 1) * length > str.Length ? remainder : length);
            }

            return arr;
        }

        public static string DashCorpNo(string no)
        {

            if (no.Length == 10)
            {
                return no.Substring(0, 3) + "-" + no.Substring(3, 2) + "-" + no.Substring(5, 5);
            }
            else
            {
                return no;
            }
        }
        public static string DashTelNo(string no)
        {
            if (no.Length == 10)
            {
                return no.Substring(0, 2) + "-" + no.Substring(2, 4) + "-" + no.Substring(6, 4);
            }
            else if (no.Length == 11)
            {
                return no.Substring(0, 3) + "-" + no.Substring(3, 4) + "-" + no.Substring(7, 4);
            }
            else if (no.Length == 10)
            {
                return no.Substring(0, 3) + "-" + no.Substring(3, 3) + "-" + no.Substring(6, 4);

            }
            else
            {
                return no;
            }
        }


        public static string GetEMailAlias(string id, string domain)
        {
            string alias = id + "@" + domain;
            if (alias == "@") alias = string.Empty;
            return alias;
        }

        

        public static string GetFileSize(long size)
        {
            string unit = GetUnitSize((double)size) + "B";
            double dsize = (double)size;
            long lunit = 1024;
            if (dsize > lunit)
            {
                unit = GetUnitSize(dsize / lunit) + "KB";
                lunit *= 1024;
            }
            if (dsize > lunit)
            {
                unit = GetUnitSize(dsize / lunit) + "MB";
                lunit *= 1024;
            }
            if (dsize > lunit)
            {
                unit = GetUnitSize(dsize / lunit) + "GB";
                lunit *= 1024;
            }
            return unit;
        }

        public static string GetUnitSize(double size)
        {
            string[] asSize = size.ToString().Split('.');
            if (asSize.Length == 1) return asSize[0];
            asSize[1] = asSize[1].TrimEnd('0');
            string s = asSize[1][0].ToString();
            if (asSize[1].Length > 1) s += asSize[1][1].ToString();
            return asSize[0] + "." + s;
        }

        public static string GetSizeName(int size)
        {
            string unit = size + "";
            int lunit = 10000;
            if (size > lunit)
            {
                size = size / lunit;
                unit = size + "만";
            }
            if (size > lunit)
            {
                size = size / lunit;
                unit = size + "억";
            }
            return unit;
        }

        public static string RemoveHTMLTag(string replace, string content)
        {
            //		/<(.*)>.*<\/\1>/ "<(.*)>.*<\/\1>" 
            return Regex.Replace(Regex.Replace(Regex.Replace(Regex.Replace(content, "</?[^>]+>", replace), @"[\r\n\t]", string.Empty), @"&[^;]+;", replace).Trim(), @" +", " ");
        }

        public static void SendMail(string subject, string from, string to, string body)
        {
            var fromAddress = new System.Net.Mail.MailAddress(from);
            SendMail(subject, fromAddress, to, body);
        }

        public static void SendMail(string subject, System.Net.Mail.MailAddress from, string to, string body)
        {
            System.Net.Mail.MailMessage mail = new System.Net.Mail.MailMessage();
            mail.From = from;
            mail.To.Add(to);
            mail.Subject = subject;
            mail.Body = body;
            mail.IsBodyHtml = true;
            System.Net.Mail.SmtpClient client = new System.Net.Mail.SmtpClient(Config.MailServer);
            System.Net.NetworkCredential credentials = new System.Net.NetworkCredential(Config.MailServerID, Config.MailServerPW);
            client.Credentials = credentials;
            client.Send(mail);
        }

        public static string GenerateTemplateHTML(string template, Dictionary<string, string> map)
        {
            string path = Config.GetFileTypePath(FileType.HTML, template, FileExtension.HTM);
            if (!System.IO.File.Exists(path)) return string.Empty;

            string mailContent = System.IO.File.ReadAllText(path);

            foreach (string key in map.Keys)
            {
                mailContent = mailContent.Replace("[" + key + "]", map[key]);
            }

            mailContent = mailContent.Replace("[_DOMAIN]", Config.Domain);
            mailContent = mailContent.Replace("[_APP_PATH]", Config.AppPath);


            return mailContent;
        }

        public static string GetRealPath(string tempPath, string fileType, DateTime date)
        {
            if (string.IsNullOrEmpty(tempPath)) return string.Empty;

            System.IO.FileInfo fi = new System.IO.FileInfo(tempPath);
            string path = Config.GetFileTypeDirectory(fileType, date, bMapPath: false);
            return path + fi.Name;
        }

        public static void MoveFile(string path)
        {
            if (string.IsNullOrEmpty(path)) return;

            System.IO.FileInfo fi = new System.IO.FileInfo(path);
            string tempPath = Config.GetFileTypeDirectory(FileType.TEMP) + fi.Name;
            if (System.IO.File.Exists(tempPath))
            {
                System.IO.File.Move(tempPath, Config.GetPath(path));
            }

        }
    }
}
