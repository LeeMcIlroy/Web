using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Security.Cryptography;
using System.Text;

namespace HALLA_PM.Util
{
    public class SHA256EncryptUtil
    {
        #region Encode : 암호화합니다.
        /// <summary>
        /// 암호화합니다.
        /// </summary>
        /// <param name="data"></param>
        /// <returns></returns>
        public static string Encode(string data)
        {
            SHA256 sha = new SHA256Managed();
            byte[] hash = sha.ComputeHash(Encoding.UTF8.GetBytes(data));

            StringBuilder sb = new StringBuilder();
            foreach (byte b in hash)
            {
                sb.AppendFormat("{0:x2}", b);
            }

            return sb.ToString();
        }
        #endregion

        #region Matches : 암호화 데이터를 비교합니다.
        /// <summary>
        /// 암호화 데이터를 비교합니다.
        /// </summary>
        /// <param name="plainData"></param>
        /// <param name="data"></param>
        /// <returns></returns>
        public static bool Matches(string plainData, string data)
        {
            if (Encode(plainData) == data)
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        #endregion
    }
}