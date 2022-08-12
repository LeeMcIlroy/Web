﻿using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Text;
using System.Text.RegularExpressions;
using System.IO;
using System.Xml.Serialization;
using System.Security.Cryptography;

using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using System.Web.Mvc;

using Dapper;
using GCMaster.Models;

namespace GCMaster.Modules
{
    public static class Functions
    {
        public static IDbConnection ConnectionDefault => new SqlConnection(ConnectionString.Default);

  

        public static class ConnectionString
        {
            public static readonly string Default = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
        }

        public static class StaticFilesLocation
        {
            private static readonly string _rootPath = Properties.Settings.Default.StaticFilesRootPath;
            public static readonly string RootUrl = Properties.Settings.Default.StaticFilesRootUrl;

            private static readonly string _imageFolderName = Properties.Settings.Default.ImageFolderName;
            private static readonly string _fileFolderName = Properties.Settings.Default.FileFolderName;

            public static string ImagePath
            {
                get {

                    if (string.IsNullOrEmpty(_rootPath))
                        return Path.Combine(AppDomain.CurrentDomain.BaseDirectory, _imageFolderName);
                    else
                        return Path.Combine(_rootPath, _imageFolderName);
                }
            }

            public static string FilePath
            {
                get
                {
                    if (string.IsNullOrEmpty(_rootPath))
                        return Path.Combine(AppDomain.CurrentDomain.BaseDirectory, _fileFolderName);
                    else
                        return Path.Combine(_rootPath, _fileFolderName);
                }
            }

            

            public static string ImageUrl
            {
                get
                {
                    string url = RootUrl;

                    if (!url.EndsWith("/"))
                        url += "/";

                    url += _imageFolderName;

                    if (!url.EndsWith("/"))
                        url += "/";


                    return url;
                }
            }

            public static string FileUrl
            {
                get
                {
                    string url = RootUrl;

                    if (!url.EndsWith("/"))
                        url += "/";

                    url += _fileFolderName;

                    if (!url.EndsWith("/"))
                        url += "/";


                    return url;
                }
            }
        }

        public static string GetImageUrl(string fileName)
        {
            if (string.IsNullOrEmpty(fileName))
                return "";
            else
                return StaticFilesLocation.ImageUrl + fileName;

        }

        public static string GetFileUrl(string fileName)
        {
            if (string.IsNullOrEmpty(fileName))
                return "";
            else
                return StaticFilesLocation.FileUrl + fileName;

        }


        public static string GetGuidFileName(string fileName)
        {
            return $"{(Guid.NewGuid())}{Path.GetExtension(fileName)}";
        }

        /// <summary>
        /// 파일 경로에 첨부된 파일을 저장
        /// </summary>
        /// <param name="attachedFile">저장할 포스트 파일</param>
        /// <param name="fileName">저장할 파일명</param>
        /// <returns>true이면 저장 성공</returns>
        public static bool SaveAttachedFile(HttpPostedFileBase attachedFile, string fileName)
        {
            bool result = false;

            try
            {
                if (!Directory.Exists(StaticFilesLocation.FilePath))
                    Directory.CreateDirectory(StaticFilesLocation.FilePath);

                string fullPath = Path.Combine(StaticFilesLocation.FilePath, fileName);

                attachedFile.SaveAs(fullPath);

                result = true;
            }
            catch
            {

            }

            return result;
        }

        /// <summary>
        /// 이미지 경로에 첨부된 파일을 저장
        /// </summary>
        /// <param name="attachedFile">저장할 포스트 이미지</param>
        /// <param name="fileName">저장할 파일명</param>
        /// <returns>true이면 저장 성공</returns>
        public static bool SaveAttachedImage(HttpPostedFileBase attachedFile, string fileName)
        {
            bool result = false;

            try
            {
                if (!Directory.Exists(StaticFilesLocation.ImagePath))
                    Directory.CreateDirectory(StaticFilesLocation.ImagePath);

                string fullPath = Path.Combine(StaticFilesLocation.ImagePath, fileName);

                attachedFile.SaveAs(fullPath);

                result = true;
            }
            catch
            {

            }

            return result;
        }

        public static bool DeleteSavedImage(string fileName)
        {
            bool result = false;

            try
            {
                string fullPath = Path.Combine(StaticFilesLocation.ImagePath, fileName);

                if (File.Exists(fullPath))
                {
                    File.Delete(fullPath);

                    result = true;
                }
            }
            catch
            {

            }

            return result;
        }
        public static bool DeleteSavedFile(string fileName)
        {
            bool result = false;

            try
            {
                string fullPath = Path.Combine(StaticFilesLocation.FilePath, fileName);

                if (File.Exists(fullPath))
                {
                    File.Delete(fullPath);

                    result = true;
                }
            }
            catch
            {

            }

            return result;
        }


        #region Code

        /// <summary>
        /// 
        /// </summary>
        /// <param name="groupCode">공통코드</param>
        /// <param name="parentCode">상위코드(Def : "")</param>
        /// <param name="useEmptyValue">Def : false</param>
        /// <param name="emptyValue">useEmptyValue = true 인 경우 Value 설정(Def : "")</param>
        /// <param name="emptyText">useEmptyValue = true 인 경우 Text 설정(Def : "")</param>
        /// <returns></returns>
        public static List<SelectListItem> GetSelectListItems(string groupCode, string parentCode = "", bool useEmptyValue = false, string emptyValue = "", string emptyText = "") {

            List<SelectListItem> selectListItems = new List<SelectListItem>();


            try
            {
                using (var conn = Functions.ConnectionDefault)
                {
                    conn.Open();

                    var result = conn.Query<SelectBoxCodeModel>("dbo.GCMASTER_COMM_LIST",
                        param: new
                        {
                            PGRP_CD = groupCode ?? "",
                            PCOMM_PCD = parentCode ?? ""
                        },
                        commandType: CommandType.StoredProcedure
                    ).ToList();


                    if (result != null) {
                        selectListItems.AddRange(result.Select(s => new SelectListItem() { 
                            Value = s.CODE,
                            Text = s.NAME
                        }));
                    }
                }
            }
            catch
            {

            }

            if (useEmptyValue)
            {
                selectListItems.Insert(0, new SelectListItem() { 
                    Value = emptyValue,
                    Text = emptyText
                });
            }

            return selectListItems;
        }



        public class allergenCategory
        {
            public string CODE { get; set; }      // 공통코드
            public string NAME { get; set; }      // 공통코드명                      
        }

        public static List<SelectListItem> GetCommList(string pGRP_CD, string pCOMM_PCD)
        {
            List<allergenCategory> Commlist = new List<allergenCategory>();

            using (var conn = Functions.ConnectionDefault)
            {
                conn.Open();

                Commlist = conn.Query<allergenCategory>("dbo.GCMASTER_COMM_LIST",
                    param: new
                    {
                        pGRP_CD = pGRP_CD,
                        pCOMM_PCD = pCOMM_PCD
                    },
                    commandType: CommandType.StoredProcedure
                ).ToList();
            }

            List<SelectListItem> select_comm = new List<SelectListItem>();
            select_comm.Add(new SelectListItem() { Value = "", Text = "선택" });

            for (int i = 0; i < Commlist.Count; i++)
            {
                select_comm.Add(new SelectListItem() { Value = Commlist[i].CODE, Text = Commlist[i].NAME });
            }

            return select_comm;
        }

        public static List<allergenCategory> GetCommList_V2(string pGRP_CD, string pCOMM_PCD)
        {
            List<allergenCategory> Commlist = new List<allergenCategory>();

            using (var conn = Functions.ConnectionDefault)
            {
                conn.Open();

                Commlist = conn.Query<allergenCategory>("dbo.GCMASTER_COMM_LIST",
                    param: new
                    {
                        pGRP_CD = pGRP_CD,
                        pCOMM_PCD = pCOMM_PCD
                    },
                    commandType: CommandType.StoredProcedure
                ).ToList();
            }

            //Commlist.Add(new allergenCategory() { CODE = "", NAME = "선택" }); 

            return Commlist;
        }



        #endregion Code



        #region Converting

        private static JavaScriptSerializer JSserializer = new JavaScriptSerializer() { MaxJsonLength = 5242880 };
        /// <summary>
        /// 
        /// </summary>
        /// <param name="obj"></param>
        /// <returns></returns>
        public static string SerializeToJSON(this object obj)
        {
            return JSserializer.Serialize(obj);
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="stringObj"></param>
        /// <param name="targetType"></param>
        /// <returns></returns>
        public static object DeserializeFromJSON(this string stringObj, Type targetType)
        {
            return JSserializer.Deserialize(stringObj, targetType);
        }

        public static string SerializeObject<T>(this T obj)
        {
            StringBuilder sb = new StringBuilder();

            try
            {
                XmlSerializer xmlSerializer = new XmlSerializer(obj.GetType());

                MemoryStream memoryStream = new MemoryStream();

                System.Xml.XmlTextWriter xmlTextWriter = new System.Xml.XmlTextWriter(memoryStream, Encoding.UTF8);

                xmlSerializer.Serialize(xmlTextWriter, obj);

                memoryStream = (MemoryStream)xmlTextWriter.BaseStream;

                UTF8Encoding uTF8Encoding = new UTF8Encoding();

                sb.Append(uTF8Encoding.GetString(memoryStream.ToArray()));

                memoryStream.Close();
                memoryStream.Dispose();
            }
            catch
            {
            }

            // 앞에 XML정의 제거
            return sb.Replace("﻿<?xml version=\"1.0\" encoding=\"utf-8\"?>", string.Empty).ToString();
        }




        /// <summary>
        /// Base64Encode
        /// </summary>
        /// <param name="source"></param>
        /// <param name="useUnicode">true : Encoding.Unicode / false : Encoding.Default</param>
        /// <returns></returns>
        public static string Base64Encoding(this string source, bool useUnicode = false)
        {
            if (useUnicode)
                return Convert.ToBase64String(Encoding.Unicode.GetBytes(source));
            else
                return Convert.ToBase64String(Encoding.Default.GetBytes(source));
        }

        /// <summary>
        /// Base64Decode
        /// </summary>
        /// <param name="source"></param>
        /// <param name="useUnicode">true : Encoding.Unicode / false : Encoding.Default</param>
        /// <returns></returns>
        public static string Base64Decoding(this string source, bool useUnicode = false)
        {
            if (useUnicode)
                return Encoding.Unicode.GetString(Convert.FromBase64String(source));
            else
                return Encoding.Default.GetString(Convert.FromBase64String(source));
        }


        public static string ToUTF8(this string source)
        {
            return Encoding.UTF8.GetString(Encoding.Default.GetBytes(source));
        }

        public static string ToCode(this PageEnum source)
        {
            return source.ToString("D").PadLeft(3, '0');
        }


        /// <summary>
        /// 128bit(16byte) IV
        /// </summary>
        private static readonly string _aesIV = "!#QAZOKMWSXIJN$%";
        /// <summary>
        /// 128bit(16byte) Key
        /// </summary>
        private static readonly string _aesKey = "!#adm@gcmaster$%";

        public static string AESEncrypt(string plainText)
        {
            AesCryptoServiceProvider aesCryptoServiceProvider = new AesCryptoServiceProvider()
            {
                BlockSize = 128,
                KeySize = 128,
                IV = Encoding.UTF8.GetBytes(_aesIV),
                Key = Encoding.UTF8.GetBytes(_aesKey),
                Mode = CipherMode.CBC,
                Padding = PaddingMode.PKCS7
            };

            byte[] src = Encoding.Unicode.GetBytes(plainText);

            using (ICryptoTransform cryptoTransform = aesCryptoServiceProvider.CreateEncryptor())
            {
                byte[] dest = cryptoTransform.TransformFinalBlock(src, 0, src.Length);

                return Convert.ToBase64String(dest);
            }
        }

        public static string AESDecrypt(string encryptedText)
        {
            AesCryptoServiceProvider aesCryptoServiceProvider = new AesCryptoServiceProvider()
            {
                BlockSize = 128,
                KeySize = 128,
                IV = Encoding.UTF8.GetBytes(_aesIV),
                Key = Encoding.UTF8.GetBytes(_aesKey),
                Mode = CipherMode.CBC,
                Padding = PaddingMode.PKCS7
            };

            byte[] src = Convert.FromBase64String(encryptedText);

            // decryption
            using (ICryptoTransform cryptoTransform = aesCryptoServiceProvider.CreateDecryptor())
            {
                byte[] dest = cryptoTransform.TransformFinalBlock(src, 0, src.Length);
                return Encoding.Unicode.GetString(dest);
            }
        }


        #endregion Converting
    }

}