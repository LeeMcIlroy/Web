using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Text;

namespace HALLA_PM.Util
{
    /// <summary>
    /// 암복호화 클래스입니다. (Base64)
    /// </summary>
    public class Base64EncryptUtil
    {
        #region Encode : 암호화합니다.
        /// <summary>
        /// 암호화합니다.
        /// </summary>
        /// <param name="data"></param>
        /// <returns></returns>
        public static string Encode(string data)
        {
            try
            {
                byte[] encByteData = new byte[data.Length];
                encByteData = Encoding.UTF8.GetBytes(data);
                return Convert.ToBase64String(encByteData);
            }
            catch (Exception e)
            {
                throw new Exception("Error in Encode : " + e.Message);
            }
        }
        #endregion

        #region Decode : 복호화합니다.
        /// <summary>
        /// 복호화합니다.
        /// </summary>
        /// <param name="data"></param>
        /// <returns></returns>
        public static string Decode(string data)
        {
            try
            {
                UTF8Encoding encoder = new UTF8Encoding();
                Decoder utf8Docode = encoder.GetDecoder();

                byte[] decByteData = Convert.FromBase64String(data);
                int charCount = utf8Docode.GetCharCount(decByteData, 0, decByteData.Length);
                char[] decChar = new char[charCount];
                utf8Docode.GetChars(decByteData, 0, decByteData.Length, decChar, 0);
                return new string(decChar);

            }
            catch (Exception e)
            {
                throw new Exception("Error in Dncode : " + e.Message);
            }
        }
        #endregion

        #region Matches : 암호화 데이터를 비교합니다.
        /// <summary>
        /// 암호화 데이터를 비교합니다.
        /// </summary>
        /// <param name="encData"></param>
        /// <param name="data"></param>
        /// <returns></returns>
        public static bool Matches(string encData, string data)
        {
            if (Decode(encData) == data) { return true; }
            else { return false; }
        }
        #endregion
    }
}