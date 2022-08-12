using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Text;
using System.Security.Cryptography;

namespace HALLA_PM.Util
{
    /// <summary>
    /// 한라그룹 한마루 SSO 로그인 암복호화 클래스입니다.
    /// </summary>
    public class SSOUtil
    {
        #region 암복호화 설명
        // 시스템 코드 : 23bfUlot87-pI00-12UB-2490UD-A6874csvV5GS
        // 컨텐츠 코드 : CONTENTS.HEIS.SSO
        // 복호화 키값 : 137847902154806368821970

        // 암호화 코드 복호화 예시
        // ts=20170123132211&system=23bfUlot87-pI00-12UB-2490UD-A6874csvV5GS&contents=CONTENTS.HEIS.SSO&empNo=300040
        // 복호화하면 코드가 위와 같이 보여짐
        // ts : SSO 로그인한 시간이며 앞뒤로 5분씩 더하여 현재 시간 기준으로 범위안에 해당되는지 체크한다.
        // system : 시스템코드가 맞는지 확인한다.
        // contents : 컨텐츠코드가 맞는지 확인한다.
        // empNo : 실제 SSO 로그인 한 사람의 사번 정보이다.
        #endregion

        #region Encrypt : 암호화 클래스입니다.
        /// <summary>
        /// 암호화 클래스입니다.
        /// </summary>
        /// <param name="encryptString">암호화할문자열</param>
        /// <param name="key">암호화키</param>
        /// <param name="useHashing">해싱키사용여부</param>
        /// <returns></returns>
        public static string Encrypt(string encryptString, string key, bool useHashing)
        {
            byte[] keyArray;
            byte[] encryptByteArray = UTF8Encoding.UTF8.GetBytes(encryptString);

            if (useHashing)
            {
                MD5CryptoServiceProvider hashMd5 = new MD5CryptoServiceProvider();
                keyArray = hashMd5.ComputeHash(UTF8Encoding.UTF8.GetBytes(key));
            }
            else
            {
                keyArray = UTF8Encoding.UTF8.GetBytes(key);
            }

            TripleDESCryptoServiceProvider tdes = new TripleDESCryptoServiceProvider();

            tdes.Key = keyArray;
            tdes.Mode = CipherMode.ECB;
            tdes.Padding = PaddingMode.PKCS7;

            ICryptoTransform cTranscform = tdes.CreateEncryptor();
            byte[] resultByteArray = cTranscform.TransformFinalBlock(encryptByteArray, 0, encryptByteArray.Length);

            return Convert.ToBase64String(resultByteArray, 0, resultByteArray.Length);
        }
        #endregion

        #region Decrypt : 복호화 클래스입니다.
        /// <summary>
        /// 복호화 클래스입니다.
        /// </summary>
        /// <param name="decryptString">복호화할문자열</param>
        /// <param name="key">복호화키</param>
        /// <param name="useHashing">해싱키사용여부</param>
        /// <returns></returns>
        public static string Decrypt(string decryptString, string key, bool useHashing)
        {
            byte[] keyArray;
            byte[] encryptByteArray = Convert.FromBase64String(decryptString);

            if (useHashing)
            {
                MD5CryptoServiceProvider hashmd5 = new MD5CryptoServiceProvider();
                keyArray = hashmd5.ComputeHash(UTF8Encoding.UTF8.GetBytes(key));
            }
            else
                keyArray = UTF8Encoding.UTF8.GetBytes(key);

            TripleDESCryptoServiceProvider tdes = new TripleDESCryptoServiceProvider();
            tdes.Key = keyArray;
            tdes.Mode = CipherMode.ECB;
            tdes.Padding = PaddingMode.PKCS7;

            ICryptoTransform cTransform = tdes.CreateDecryptor();
            byte[] resultArray = cTransform.TransformFinalBlock(encryptByteArray, 0, encryptByteArray.Length);

            return UTF8Encoding.UTF8.GetString(resultArray);
        }
        #endregion
    }
}