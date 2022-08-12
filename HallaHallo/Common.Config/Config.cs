using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Reflection;
using System.IO;
using System.Data;
using Castle.Data;

namespace HallaTube
{
    /// <summary>
    /// 시스템 구성
    /// </summary>
    public static class Config
    {
        /// <summary>
        /// WAS 구분 문자
        /// </summary>
        public static string SystemChar { set; get; }
        
        /// <summary>
        /// 데이터 베이스 Config상 이름,실제 DBMS 상 이름과 동일하게 주는 것을 권장
        /// </summary>
        public static string DBName { set; get; }
        /// <summary>
        /// DB 카탈로그명
        /// </summary>
        public static string DBCatalogName { set; get; }


        /// <summary>
        /// IIS 설정된 응용프로그램 이름
        /// </summary>
        public static string AppName { set; get; }
        /// <summary>
        /// IIS 설정된 응용프로그램 경로
        /// </summary>
        public static string AppPath { set; get; }
        /// <summary>
        /// 첨부파일의 루트 가상디렉토리 이름
        /// </summary>
        public static string FileRoot { set; get; }
        /// <summary>
        /// 첨부파일의 루트 가상디렉토리의 물리적 경로
        /// </summary>
        public static string FileRootMapPath { set; get; }


        /// <summary>
        /// MailServer
        /// </summary>
        public static string MailServer { set; get; }
        /// <summary>
        /// MailServer
        /// </summary>
        public static string MailServerID { set; get; }
        /// <summary>
        /// MailServer
        /// </summary>
        public static string MailServerPW { set; get; }
        /// <summary>
        /// MailServer
        /// </summary>
        public static string MailDefaultAddress { set; get; }
        /// <summary>
        /// SendMail
        /// </summary>
        public static bool SendMail { set; get; }

        /// <summary>
        /// IIS 바인딩된 도메인
        /// </summary>
        public static string Domain { set; get; }
        public static string MobileDomain { set; get; }
        public static string RootDomain { set; get; }

        /// <summary>
        /// 스크립트 캐시관리등을 위한 소스 수정 번호
        /// </summary>
        public static string Version { set; get; }

        /// <summary>
        /// 기본 언어
        /// </summary>
        public static string DefaultLanguage { set; get; }

        /// <summary>
        /// ASE 암호화 키
        /// </summary>
        public static string ASEKey { set; get; }

        /// <summary>
        /// WAS IP 목록
        /// </summary>
        public static string[] ServerIPList { set; get; }

        /// <summary>
        /// 페이지 접속 로그 사용여부
        /// </summary>
        public static bool UsePageLog { set; get; }


        public static bool ManageUse { set; get; }


        public static string GetFileTypeDirectory(string fileType, DateTime? dt = null, string privateID = null, bool bMapPath = true)
        {
            FieldInfo fi = FileType.GetField(fileType);
            if (fi == null) return null;
            var atts = (FolderRuleAttribute[])fi.GetCustomAttributes(typeof(FolderRuleAttribute), false);

            string folderNm = fileType;
            string rulepath = string.Empty;
            if (atts.Length > 0)
            {
                if (dt == null) dt = DateTime.UtcNow;
                if (atts[0].FolderRule == FolderRuleType.Year) rulepath = string.Format("{0}/", dt.Value.Year);
                if (atts[0].FolderRule == FolderRuleType.Month) rulepath = string.Format("{0}{1}/", dt.Value.Year, dt.Value.Month.ToString().PadLeft(2, '0'));
                if (atts[0].FolderRule == FolderRuleType.Day) rulepath = string.Format("{0}{1}{2}/", dt.Value.Year, dt.Value.Month.ToString().PadLeft(2, '0'), dt.Value.Day.ToString().PadLeft(2, '0'));

                if (!string.IsNullOrEmpty(atts[0].FolderNm)) folderNm = atts[0].FolderNm;

                if (atts[0].Private)
                {
                    rulepath += privateID + "/";
                }
            }

            string virpath = string.Format("{0}{1}/{2}", Config.FileRoot, folderNm, rulepath);
            string path = GetPath(virpath);
            if (!Directory.Exists(path))
            {
                Directory.CreateDirectory(path);
            }

            if (bMapPath) return path;
            else return virpath;
        }

        public static string GetFileTypePath(string fileType, string id, string extension, DateTime? dt = null, string privateID=null, bool bMapPath = true)
        {
            string dir = GetFileTypeDirectory(fileType, dt,privateID, bMapPath);
            if (dir == null) return null;

            return dir + id + extension;
        }

        public static string GetPath(string virPath, string id, string extension)
        {
            if (virPath[virPath.Length - 1] != '/') virPath += "/";

            return GetPath(virPath + id + extension);
        }

        public static string GetPath(string virPath)
        {
            if (virPath.StartsWith(Config.FileRoot, StringComparison.OrdinalIgnoreCase))
            {
                virPath = virPath.Substring(Config.FileRoot.Length - 1);
                string path = Config.FileRootMapPath.TrimEnd('\\') + virPath.Replace("/", "\\");
                return path;
            }
            else throw new Exception("FileRoot 위치의 경로가 아닙니다: " + virPath);
        }





        static DataTable dtConfig;

        //[AutoComplete]
        public static void SetConfigList()
        {
            var agent = DataAgent.GetDBAgent();
            dtConfig = agent.GetCommand("Config.GetConfigList").ExecuteDataTable();
        }

        public static DataTable GetConfigList()
        {
            return dtConfig;
        }

        public static string GetConfig(string name, string defaultValue = null)
        {
            DataRow[] adrConfig = dtConfig.Select("CONFIG_ID='" + name + "'");
            if (adrConfig.Length == 0)
            {
                if (defaultValue == null)
                {
                    throw new ApplicationException(name + " Config 구성값이 없습니다.");
                }
                else
                {
                    return defaultValue;
                }
            }
            if (adrConfig[0]["VALUE"] is DBNull)
            {
                if (defaultValue == null)
                {
                    return string.Empty;
                }
                else
                {
                    return defaultValue;
                }
            }
            else return (string)adrConfig[0]["VALUE"];
        }


        /// <summary>
        /// 구성 적재 및 기본값 설정
        /// </summary>
        public static void LoadConfiguration()
        {
            //2021.02.03
            SetConfigList();

            //Domain = GetConfig("Domain");
            RootDomain = GetConfig("RootDomain", string.Empty);
            
            DefaultLanguage = GetConfig("DefaultLanguage", LanguageType.KOR);
            MailServer = GetConfig("MailServer", string.Empty);
            MailServerID = GetConfig("MailServerID", string.Empty);
            MailServerPW = GetConfig("MailServerPW", string.Empty);
            MailDefaultAddress = GetConfig("MailDefaultAddress", string.Empty);
            SendMail = GetConfig("SendMail", string.Empty) == Const.True;

            Version = GetConfig("Version", string.Empty);
            ASEKey = GetConfig("ASEKey", string.Empty);
            ServerIPList = GetConfig("ServerIPList", string.Empty).Split(',');
            UsePageLog = GetConfig("UsePageLog", "N") == Const.True;

            LanguageType.DefaultLanguage = Config.DefaultLanguage;


        }
    }
}
