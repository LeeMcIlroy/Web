using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Net;
using System.Text.RegularExpressions;
using HALLA_PM.Core;

namespace HALLA_PM.Util
{
    public class WebUtil
    {
        #region GetLocalIP : 사용자의 로컬 아이피를 가져옵니다.
        /// <summary>
        /// 사용자의 로컬 아이피를 가져옵니다.
        /// </summary>
        /// <returns></returns>
        public static string GetLocalIP()
        {
            string localIp = "0.0.0.0";

            IPHostEntry host = Dns.GetHostEntry(Dns.GetHostName());

            foreach (IPAddress ip in host.AddressList)
            {
                if (ip.AddressFamily == System.Net.Sockets.AddressFamily.InterNetwork)
                {
                    localIp = ip.ToString();
                    break;
                }
            }

            return localIp;
        }
        #endregion

        #region GetClientIP : 사용자의 클라이언트 아이피를 가져옵니다.
        /// <summary>
        /// 사용자의 클라이언트 아이피를 가져옵니다.
        /// </summary>
        /// <returns></returns>
        public static string GetClientIP()
        {
            return HttpContext.Current.Request.UserHostAddress;
        }
        #endregion

        #region GetRandomString : 랜덤문자를 생성합니다.
        /// <summary>
        /// 랜덤문자를 생성합니다.
        /// </summary>
        /// <param name="totalLen"></param>
        /// <returns></returns>
        public static string GetRandomString(int totalLen = 0)
        {
            Random rnd = new Random();
            string listString = "abcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";

            var chars = Enumerable.Range(0, totalLen).Select(x => listString[rnd.Next(0, listString.Length)]);

            return new string(chars.ToArray());
        }
        #endregion

        #region GetRandomStringNumber : 랜덤문자를 생성합니다.(숫자타입만)
        /// <summary>
        /// 랜덤문자를 생성합니다.(숫자타입만)
        /// </summary>
        /// <param name="totalLen"></param>
        /// <returns></returns>
        public static string GetRandomStringNumber(int totalLen = 0)
        {
            Random rnd = new Random();
            string listString = "0123456789";

            var chars = Enumerable.Range(0, totalLen).Select(x => listString[rnd.Next(0, listString.Length)]);

            return new string(chars.ToArray());
        }
        #endregion

        /// <summary>
        /// Decimal(12, 2) 체크
        /// </summary>
        /// <param name="data"></param>
        /// <returns></returns>
        public static bool CheckDecimalTwo(string data)
        {
            Regex reg = new Regex(@"^[-]?[0-9]{1,12}(\.?[0-9]{0,2})$");
            return reg.IsMatch(data);
        }

        public static bool IsDecimal(string data)
        {
            try
            {
                decimal d = Convert.ToDecimal(data);
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }

        /// <summary>
        /// 소수점 반올림
        /// </summary>
        /// <param name="number">값</param>
        /// <param name="value">소수점 자리</param>
        /// <returns></returns>
        public static decimal NumberRound(decimal value, decimal value2, int plus = 1, int decimals = 0)
        {
            decimal result = 0;

            if (value2 == 0)
            {
                result = 0;
            }
            else
            {
                result = Math.Round(value / value2 * plus, decimals, MidpointRounding.AwayFromZero);
            }

            //if (decimal.IsNaN(result) || decimal.IsInfinity(result))
            //{
            //    result = 0;
            //}

            return result;
        }

        /// <summary>
        /// decimal 숫자 콤마찍기
        /// </summary>
        /// <param name="value"></param>
        /// <returns></returns>
        public static decimal NumberComma(decimal value)
        {
            var result = string.Format("{0:n0}", Convert.ToDecimal(value));

            return Convert.ToDecimal(result);
        }

        /// <summary>
        /// 1,000 포멧으로 나오기
        /// </summary>
        /// <param name="value"></param>
        /// <returns></returns>
        public static string NComma(object value)
        {
            return string.Format("{0:#,##0}", value);
        }

        public static string NCommaRound(object value, int round = 0)
        {
            // % 문자가 붙어 들어오면 자르고 나중에 다시 붙여준다.
            var oo = value;
            if (oo.ToString() == "N/A") return oo.ToString();

            // 2019.01.18 적자 혹은 흑자의 글자가 들어오는 경우에는 그대로 내보낸다.
            if (value.ToString().IndexOf("적자") >= 0 || value.ToString().IndexOf("흑자") >= 0)
            {
                return value.ToString();
            }

            bool isPer = false;
            if (value.ToString().IndexOf("%") > 0 )
            {
                isPer = true;
                value = value.ToString().Replace("%", "");
            }


                value = Math.Round(Convert.ToDecimal(value), round, MidpointRounding.AwayFromZero);
            string roundValue = string.Format("{0:#,##0.##}", value);
            if (round == 1 )
            {
                roundValue = string.Format("{0:#,##0.0#}", value);
            }
            else if (round == 2)
            {
                roundValue = string.Format("{0:#,##0.00}", value);
            }
            if (isPer) { roundValue += "%"; }
            return roundValue;
        }

        /// <summary>
        /// 1,000.00 포멧으로 나오기
        /// </summary>
        /// <param name="value"></param>
        /// <returns></returns>
        public static string NCommanaTwo(object value)
        {
            return string.Format("{0:#,##0.00}", value);
        }

        /// <summary>
        /// 계획대비 / 실적대비 값을 구한다.
        /// 적자전환 : 계획 > 0 && 실적 < 0
        /// 적자확대 : 계획 < 0 && 계획 > 0
        /// 적자축소 : 실적 < 0 && 계획 < 실적
        /// 흑자전환 : 계획 < 0 && 실적 > 0
        /// 2019.01.18 혹시 여기에서 항목이 추가 된다면 NCommaRound 클래스에도 해당글자가 들어왔을때 그대로 반환하는 로직을 추가해줘야 합니다. 안 그럼 오류 남
        /// </summary>
        /// <param name="dividend">실적</param>
        /// <param name="divisor">계획/전년</param>
        /// <param name="round">값</param>
        /// <returns></returns>
        public static string DivPmValue(decimal dividend, decimal divisor, int round = 0)
        {
            string quotient = "";

            if (divisor == 0) { quotient = "0"; }
            else if (dividend < 0 && divisor > 0) { quotient = "적자전환"; }
            else if (divisor < 0 && divisor > dividend) { quotient = "적자확대"; }
            else if (dividend < 0 && divisor < dividend) { quotient = "적자축소"; }
            else if (divisor < 0 && dividend > 0) { quotient = "흑자전환"; }
            else { quotient = Math.Round(dividend / divisor * 100, round, MidpointRounding.AwayFromZero).ToString() + "%"; }

            return quotient;
        }

        /// <summary>
        /// 달성율 계산
        /// 계획값이 음수이면 200 - 달성율
        /// 계획값이 0이면 N/A
        /// </summary>
        /// <param name="planValue"></param>
        /// <param name="rateValue"></param>
        /// <returns></returns>
        public static string ReturnNaValueOrM200(decimal? planValue, decimal rateValue)
        {
            string result = "";
            if (planValue == null) planValue = 0;
            if (planValue == 0)
            {
                result = "N/A";
            }
            else if (planValue < 0)
            {
                result = NCommaRound(200 -  rateValue, 2) + "%";
            }
            else
            {
                result = NCommaRound(rateValue, 2) + "%";
            }
            return result;
        }

        /// <summary>
        /// 2019.03.27 Roic 수식변경으로 추가
        /// </summary>
        /// <param name="roic"></param>
        /// <param name="month"></param>
        /// <returns></returns>
        public static decimal NewRoic(decimal roic, decimal month, int round = 2)
        {
            if (month > 12) month = 12;
            if (month == 0) month = 12;
            return Math.Round(roic * (12 / month), round, MidpointRounding.AwayFromZero);
        }
   
  
        // 2019.01.08 중간관리자2 프로세스 추가
        public static string ListGoFunction(string writeAble, int registStatus, int seq, int orgCompanySeq, int authLevel, string companyName)
        {
            string result = "";

            if (writeAble == "Y")
            {
                if (registStatus == Define.REGIST_STATUS.GetKey("미등록") &&
                    (authLevel == Define.AUTH_LEVEL.GetKey("실적 담당자") ||
                    authLevel == Define.AUTH_LEVEL.GetKey("중간 관리자") ||
                    authLevel == Define.AUTH_LEVEL.GetKey("중간 관리자2") ||
                    authLevel == Define.AUTH_LEVEL.GetKey("최종 관리자"))
                    )
                {
                    result = "<a href=\"javascript:; \" onclick=\"onWrite(" + seq + "," + orgCompanySeq + "); \">" + companyName + "</a>";
                }
                else if ((registStatus == Define.REGIST_STATUS.GetKey("저장") ||
                    registStatus == Define.REGIST_STATUS.GetKey("1차반려") ||
                    registStatus == Define.REGIST_STATUS.GetKey("2차반려") ||
                    registStatus == Define.REGIST_STATUS.GetKey("3차반려")
                    ) &&
                    (authLevel == Define.AUTH_LEVEL.GetKey("실적 담당자") ||
                    authLevel == Define.AUTH_LEVEL.GetKey("중간 관리자") ||
                    authLevel == Define.AUTH_LEVEL.GetKey("중간 관리자2") ||
                    authLevel == Define.AUTH_LEVEL.GetKey("최종 관리자"))
                    )
                {
                    result = "<a href=\"javascript:; \" onclick=\"onEdit(" + seq + "," + orgCompanySeq + "); \">" + companyName + "</a>";
                }
                else if ((registStatus == Define.REGIST_STATUS.GetKey("승인대기")) &&
                    (authLevel == Define.AUTH_LEVEL.GetKey("중간 관리자") ||
                    authLevel == Define.AUTH_LEVEL.GetKey("중간 관리자2") ||
                    authLevel == Define.AUTH_LEVEL.GetKey("최종 관리자"))
                    )
                {
                    result = "<a href=\"javascript:; \" onclick=\"onEdit(" + seq + "," + orgCompanySeq + "); \">" + companyName + "</a>";
                }
                else if ((registStatus == Define.REGIST_STATUS.GetKey("1차승인") ||
                    registStatus == Define.REGIST_STATUS.GetKey("2차승인") ||
                    registStatus == Define.REGIST_STATUS.GetKey("최종승인")
                    ) &&
                    (authLevel == Define.AUTH_LEVEL.GetKey("중간 관리자2"))
                    )
                {
                    result = "<a href=\"javascript:; \" onclick=\"onEdit2(" + seq + "," + orgCompanySeq + "); \">" + companyName + "</a>";
                }
                else if ((registStatus == Define.REGIST_STATUS.GetKey("1차승인")||
                    registStatus == Define.REGIST_STATUS.GetKey("2차승인")||
                    registStatus == Define.REGIST_STATUS.GetKey("최종승인")
                    ) &&
                    (authLevel == Define.AUTH_LEVEL.GetKey("최종 관리자"))
                    )
                {
                    result = "<a href=\"javascript:; \" onclick=\"onEdit(" + seq + "," + orgCompanySeq + "); \">" + companyName + "</a>";
                }
                else
                {
                    result = "<a href=\"javascript:; \" onclick=\"onView(" + seq + "," + orgCompanySeq + "); \">" + companyName + "</a>";
                }
            }
            else
            {
                if (registStatus == Define.REGIST_STATUS.GetKey("미등록"))
                {
                    result = "<a href=\"javascript:; \" onclick=\"alert('등록일자가 지나고 미등록인 데이터는 볼 수 없습니다.')\">" + companyName + "</a>";
                }
                else if (authLevel == Define.AUTH_LEVEL.GetKey("최종 관리자"))
                {
                    result = "<a href=\"javascript:; \" onclick=\"onEdit(" + seq + "," + orgCompanySeq + "); \">" + companyName + "</a>";
                }
                else
                {
                    result = "<a href=\"javascript:; \" onclick=\"onView(" + seq + "," + orgCompanySeq + "); \">" + companyName + "</a>";
                }
            }

            return result;
        }

        public static string ListGoFunction2(string writeAble, int registStatus, int seq, int orgCompanySeq, int authLevel, string companyName,string year ,string month)
        {
            string result = "";

            if (writeAble == "Y")
            {
                if (registStatus == Define.REGIST_STATUS.GetKey("미등록") &&
                    (authLevel == Define.AUTH_LEVEL.GetKey("실적 담당자") ||
                    authLevel == Define.AUTH_LEVEL.GetKey("중간 관리자") ||
                    authLevel == Define.AUTH_LEVEL.GetKey("중간 관리자2") ||
                    authLevel == Define.AUTH_LEVEL.GetKey("최종 관리자"))
                    )
                {
                    result = "<a href=\"javascript:; \" onclick=\"onWrite(" + seq + "," + orgCompanySeq + "," + year + "," + month + "); \">" + companyName + "</a>";
                }
                else if ((registStatus == Define.REGIST_STATUS.GetKey("저장") ||
                    registStatus == Define.REGIST_STATUS.GetKey("1차반려") ||
                    registStatus == Define.REGIST_STATUS.GetKey("2차반려") ||
                    registStatus == Define.REGIST_STATUS.GetKey("3차반려")
                    ) &&
                    (authLevel == Define.AUTH_LEVEL.GetKey("실적 담당자") ||
                    authLevel == Define.AUTH_LEVEL.GetKey("중간 관리자") ||
                    authLevel == Define.AUTH_LEVEL.GetKey("중간 관리자2") ||
                    authLevel == Define.AUTH_LEVEL.GetKey("최종 관리자"))
                    )
                {
                    result = "<a href=\"javascript:; \" onclick=\"onEdit(" + seq + "," + orgCompanySeq + "," + year + "," + month +  "); \">" + companyName + "</a>";
                }
                else if ((registStatus == Define.REGIST_STATUS.GetKey("승인대기")) &&
                    (authLevel == Define.AUTH_LEVEL.GetKey("중간 관리자") ||
                    authLevel == Define.AUTH_LEVEL.GetKey("중간 관리자2") ||
                    authLevel == Define.AUTH_LEVEL.GetKey("최종 관리자"))
                    )
                {
                    result = "<a href=\"javascript:; \" onclick=\"onEdit(" + seq + "," + orgCompanySeq + "," + year + "," + month + "); \">" + companyName + "</a>";
                }
                else if ((registStatus == Define.REGIST_STATUS.GetKey("1차승인") ||
                    registStatus == Define.REGIST_STATUS.GetKey("2차승인") ||
                    registStatus == Define.REGIST_STATUS.GetKey("최종승인")
                    ) &&
                    (authLevel == Define.AUTH_LEVEL.GetKey("중간 관리자2"))
                    )
                {
                    result = "<a href=\"javascript:; \" onclick=\"onEdit2(" + seq + "," + orgCompanySeq + "," + year + "," + month + "); \">" + companyName + "</a>";
                }
                else if ((registStatus == Define.REGIST_STATUS.GetKey("1차승인") ||
                    registStatus == Define.REGIST_STATUS.GetKey("2차승인") ||
                    registStatus == Define.REGIST_STATUS.GetKey("최종승인")
                    ) &&
                    (authLevel == Define.AUTH_LEVEL.GetKey("최종 관리자"))
                    )
                {
                    result = "<a href=\"javascript:; \" onclick=\"onEdit(" + seq + "," + orgCompanySeq + "," + year + "," + month + "); \">" + companyName + "</a>";
                }
                else
                {
                    result = "<a href=\"javascript:; \" onclick=\"onView(" + seq + "," + orgCompanySeq + "," + year + "," + month + "); \">" + companyName + "</a>";
                }
            }
            else
            {
                if (registStatus == Define.REGIST_STATUS.GetKey("미등록"))
                {
                    result = "<a href=\"javascript:; \" onclick=\"alert('등록일자가 지나고 미등록인 데이터는 볼 수 없습니다.')\">" + companyName + "</a>";
                }
                else if (authLevel == Define.AUTH_LEVEL.GetKey("최종 관리자"))
                {
                    result = "<a href=\"javascript:; \" onclick=\"onEdit(" + seq + "," + orgCompanySeq + "," + year + "," + month + "); \">" + companyName + "</a>";
                }
                else
                {
                    result = "<a href=\"javascript:; \" onclick=\"onView(" + seq + "," + orgCompanySeq + "," + year + "," + month + "); \">" + companyName + "</a>";
                }
            }

            return result;
        }
    }
}