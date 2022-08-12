using System.Data;
using System;
using System.Collections.Generic;
using System.IO;
using System.Text.RegularExpressions;
using System.Web;
using System.Text;



namespace HallaTube
{
    public enum ThumbType
    {
            AspectRatioCrop //정비율로 변경 큰부분 크롭
        ,   AspectRatio     //정비율축소
        ,   MaxRatio        //비율없이 변경
    }

    public static class ExtensionDateTime
    {
        /// <summary>
        /// 실제 몇째주인지를 반환한다.
        /// </summary>
        /// <param name="dt">DateTime 개체</param>
        /// <returns>주</returns>
        public static int GetWeek(this DateTime dt)
        {
            //어떤 날의 일수와 요일을 알면 몇주째인지 계산이 가능하다

            //최소한 현재일은 (dt.Day-1) / 7 + 1 의 주 값을 가진다.
            // 여기에 7로 나누었을때 나머지와 수치화된 요일(DayOfWeek enum) 값을 비교하여 주를 보정한다.
            // 이 계산을 편리하게 하고자 나머지를 (dt.Day - 1) % 7 로 현재일에 1을 빼서 계산한다.

            int week = (dt.Day - 1) / 7 + 1;
            int mod = (dt.Day - 1) % 7;
            if ((int)dt.DayOfWeek <= mod) week++;
            return week;
        }

        /// <summary>
        /// 마지막 주인지 논리값을 반환한다.
        /// </summary>
        /// <param name="dt">DateTime 개체</param>
        /// <returns>마지막주라면 true 아니라면 false 반환</returns>
        public static bool IsLastWeek(this DateTime dt)
        {
            DateTime dtNextWeek = dt.AddDays(7);
            return dtNextWeek.Month != dt.Month;
        }
    }

    public static class Method
    {
        
        public static bool CheckFile(string name)
        {
            string t = name.Replace(";", string.Empty);
            return t.Length + 1 == name.Length;
        }

        public static void RemoveHTMLTag(string replace, ref string content)
        {
            //		/<(.*)>.*<\/\1>/ "<(.*)>.*<\/\1>" 
            content = Regex.Replace(Regex.Replace(Regex.Replace(Regex.Replace(content, @" +", " "), "</?[^>]+>", replace), @"[\r\n\t]", string.Empty), @"&[^;]+;", replace).Trim();
        }

        public static string Base64Decode(string pStr)
        {
            if (pStr == string.Empty || pStr == null) return string.Empty;
            return System.Text.Encoding.GetEncoding("euc-kr").GetString(System.Convert.FromBase64String(pStr));
        }

        public static string ConvertTextToHtml(string text)
        {
            return text.Replace("\n", "<br>").Replace(" ", "&nbsp;");
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

        //12 19 2006 7:34:26:017PM
        public static string GetDate(DateTime dt)
        {
            if (dt == DateTime.MinValue) return "null";
            int hour = dt.Hour > 12 ? dt.Hour - 12 : dt.Hour;
            string dd = dt.Hour > 12 ? "PM" : "AM";
            string s = "{0} {1} {2} {3}:{4}:{5}:{6}{7}";
            return string.Format(s, dt.Month, dt.Day, dt.Year, hour.ToString().PadLeft(2, '0'),
                dt.Minute.ToString().PadLeft(2, '0'), dt.Second.ToString().PadLeft(2, '0'),
                dt.Millisecond.ToString().PadLeft(3, '0'), dd);

        }

        public static string ToDBCompareString(object value)
        {
            if (value is DateTime)
            {
                return GetDate((DateTime)value);
            }
            else return value.ToString();
        }

        public static string GetDayofWeekKor(DayOfWeek d)
        {
            if (d == DayOfWeek.Sunday) return "일";
            else if (d == DayOfWeek.Monday) return "월";
            else if (d == DayOfWeek.Tuesday) return "화";
            else if (d == DayOfWeek.Wednesday) return "수";
            else if (d == DayOfWeek.Thursday) return "목";
            else if (d == DayOfWeek.Friday) return "금";
            else if (d == DayOfWeek.Saturday) return "토";
            else return "";
        }

        public static int GetWeek(DateTime d)
        {
            return ((5 - (int)d.DayOfWeek + d.Day) / 7) + 1;
        }

        public static string strCut(string str, int max, string suffix)
        {
            string strResult = "";
            string s = str.ToString();

            if (s == "") return strResult;

            int count = 0;
            string tmpStr = str.Trim().ToString();
            char[] chrarr = tmpStr.ToCharArray();

            if (tmpStr.Length != 0)
            {
                for (int i = 0; i < chrarr.Length; i++)
                {
                    int temp = Convert.ToInt32(chrarr[i]);
                    if (temp < 0 || temp >= 128)
                    {
                        //한글 2byte
                        count = count + 2;
                    }
                    else
                    {
                        count = count + 1;
                    }

                    if (count <= max)
                    {
                        strResult = strResult + tmpStr.Substring(i, 1);
                    }
                    else
                    {
                        strResult = strResult + suffix;
                        break;
                    }
                }
            }
            return strResult;
        }


        public static string HighlightWord(string soruce, string word, string classname)
        {
            return soruce.Replace(word, "<span class='" + classname + "'>" + word + "</span>");
        }

        public static string GetDateString(DateTime dt)
        {
            if (dt.Hour == 0 && dt.Minute == 0 && dt.Second == 0 && dt.Millisecond == 0)
            {
                return dt.ToShortDateString();
            }
            else
            {
                return string.Format("{0} {1:00}:{1:00}", dt.ToShortDateString(), dt.Hour, dt.Minute);
            }
        }

        public static string GetOrderPhase(string nowsort,string oldsort)
        {
            string orderphase;
            if (string.IsNullOrEmpty(oldsort))
            {
                orderphase = nowsort;
            }
            else
            {
                string[] sort = oldsort.Split(',');
                if (nowsort == sort[0].Split(' ')[0])
                {
                    if (sort[0].EndsWith(" DESC")) sort[0] = nowsort;
                    else sort[0] = nowsort + " DESC";

                    orderphase = string.Join(",", sort);
                }
                else
                {
                    orderphase = nowsort;
                    for (int i = 0; i < sort.Length; i++)
                    {
                        string col = sort[i].Split(' ')[0];
                        if (nowsort != col) orderphase += "," + col;
                    }
                }
            }

            return orderphase;
        }


        public static string CategoryPathName(DataSet ds, string id,string splitor)
        {
            DataRow adr = ds.Tables[0].Select("ID='" + id + "'")[0];
            string pid = adr["ParentID"].ToString();
            if (pid == "0") return string.Empty;
            else
            {
                string parentname = CategoryPathName(ds, pid, splitor);
                if (parentname == string.Empty) return adr["Name"].ToString();
                return parentname + splitor + adr["Name"];
            }

        }

        


        public static bool CheckExtension(string filterfilepath, string name)
        {
            string[] files = name.Trim(' ', ';').Split(';');
            foreach (string file in files)
            {
                FileInfo fi = new FileInfo(file);
                using (FileStream fs = File.OpenRead(filterfilepath))
                {
                    StreamReader sr = new StreamReader(fs, Encoding.Default);
                    while (sr.Peek() > -1)
                    {
                        string tword = sr.ReadLine().Trim();
                        if (tword.Length == 0) continue;
                        if (fi.Extension.ToLower().Trim() == tword.ToLower())
                        {
                            sr.Close();
                            return false;
                        }
                    }
                    sr.Close();
                }
            }

            return true;
        }

        

        public static string RemoveHTMLTag(string replace, string content)
        {
            //		/<(.*)>.*<\/\1>/ "<(.*)>.*<\/\1>" 
            return Regex.Replace(Regex.Replace(Regex.Replace(Regex.Replace(Regex.Replace(content, @"<script.*>[\s\S]*?<\/script>", replace), "</?[^>]+>", replace), @"[\r\n\t]", string.Empty), @"&[^;]+;", replace), @" +", " ").Trim();
        }

        public static string RemoveIlligalTag(string content)
        {
            var regexCss = new Regex("(\\<script(.+?)\\</script\\>)|(\\<style(.+?)\\</style\\>)|(\\<iframe(.+?)\\</iframe\\>)", RegexOptions.Singleline | RegexOptions.IgnoreCase);
            content= regexCss.Replace(content, string.Empty);

            return content;
        }
        
        


        public static string GetDateString2(DateTime dt)
        {
            if (dt.Hour == 0 && dt.Minute == 0 && dt.Second == 0 && dt.Millisecond == 0)
            {
                return dt.ToShortDateString();
            }
            else
            {
                return string.Format("{0} {1:00}:{2:00}", dt.ToShortDateString(), dt.Hour, dt.Minute);
            }
        }


        public static string GetRootByCategory(string category)
        {
            string root = string.Empty;
            if (category.StartsWith("40") || category.StartsWith("70") || category.StartsWith("80") || category.StartsWith("a1"))
            {
                root = "geomjgosi";
            }
            return root;
        }


        public static string GetScalar(DataSet ds)
        {
            if (ds.Tables.Count == 0) return null;
            if (ds.Tables[0].Rows.Count == 0) return null;
            if (ds.Tables[0].Rows[0].ItemArray.Length == 0) return null;
            return ds.Tables[0].Rows[0][0].ToString();
        }



        static public string TimeZone10(string time, float timeZones)
        {
            return TimeZone(timeZones, time, Const.Date);
        }
        static public string TimeZone10(this DateTime time, float timeZones)
        {
            return TimeZone(timeZones, time, Const.Date);
        }
        static public string TimeZone10(string time, float timeZones, bool displayTimezoneInfo)
        {
            return TimeZone(timeZones, time, Const.Date) + TimeZoneInfo(displayTimezoneInfo, timeZones);
        }
        static public string TimeZone10(this DateTime time, float timeZones, bool displayTimezoneInfo)
        {
            return TimeZone(timeZones, time, Const.Date) + TimeZoneInfo(displayTimezoneInfo, timeZones);
        }



        static public string TimeZone16(this string time, float timeZones)
        {
            return TimeZone(timeZones, time, Const.DateHHmm);
        }
        static public string TimeZone16(this DateTime time, float timeZones)
        {
            return TimeZone(timeZones, time, Const.DateHHmm);
        }
        static public string TimeZone16(string time, float timeZones, bool displayTimezoneInfo)
        {
            return TimeZone(timeZones, time, Const.DateHHmm) + TimeZoneInfo(displayTimezoneInfo, timeZones);
        }
        static public string TimeZone16(this DateTime time, float timeZones, bool displayTimezoneInfo)
        {
            return TimeZone(timeZones, time, Const.DateHHmm) + TimeZoneInfo(displayTimezoneInfo, timeZones);
        }



        static public string TimeZone19(string time, float timeZones)
        {
            return TimeZone(timeZones, time, Const.DateHHmmss);
        }
        static public string TimeZone19(this DateTime time, float timeZones)
        {
            return TimeZone(timeZones, time, Const.DateHHmmss);
        }
        static public string TimeZone19(string time, float timeZones, bool displayTimezoneInfo)
        {
            return TimeZone(timeZones, time, Const.DateHHmmss) + TimeZoneInfo(displayTimezoneInfo, timeZones);
        }
        static public string TimeZone19(this DateTime time, float timeZones, bool displayTimezoneInfo)
        {
            return TimeZone(timeZones, time, Const.DateHHmmss) + TimeZoneInfo(displayTimezoneInfo, timeZones);
        }



        static public string UTC10(string time, float timeZones)
        {
            return TimeZone(-timeZones, time, Const.Date);
        }
        static public string UTC10(DateTime time, float timeZones)
        {
            return TimeZone(-timeZones, time, Const.Date);
        }
        static public string UTC16(string time, float timeZones)
        {
            return TimeZone(-timeZones, time, Const.DateHHmm);
        }
        static public string UTC16(DateTime time, float timeZones)
        {
            return TimeZone(-timeZones, time, Const.DateHHmm);
        }
        static public string UTC19(string time, float timeZones)
        {
            return TimeZone(-timeZones, time, Const.DateHHmmss);
        }
        static public string UTC19(DateTime time, float timeZones)
        {
            return TimeZone(-timeZones, time, Const.DateHHmmss);
        }


        static public string TimeZone(float timeZones, string time, string format)
        {
            return TimeZone(timeZones, Convert.ToDateTime(time), format);
        }
        static public string TimeZone(float timeZones, DateTime time, string format)
        {
            if (time.Year <= 1900) return null;
            return time.AddHours(timeZones).ToString(format);
        }
        static public string TimeZoneInfo(bool displayTimeZoneInfo, float timeZones)
        {
            return displayTimeZoneInfo == true ? string.Format(Const.DateTimeZone, timeZones) : "";
        }
    }
}