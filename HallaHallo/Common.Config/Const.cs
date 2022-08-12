using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace HallaTube
{
    /// <summary>
    /// 코드로 분류되지 않는 상수 데이터
    /// </summary>
    public static class Const
    {
        /// <summary>
        /// 목록 기본 갯수
        /// </summary>
        public const int LIST_PAGE_SIZE = 20;
        /// <summary>
        /// DB char(1) 형식의 필드에 들어가는 True를 뜻하는 값
        /// </summary>
        public const string True = "Y";

        /// <summary>
        /// 선택적 / 혹은 제3의 것
        /// </summary>
        public const string Alter = "A";

        /// <summary>
        /// DB char(1) 형식의 필드에 들어가는 False를 뜻하는 값
        /// </summary>
        public const string False = "N";

        /// <summary>
        /// 프로그램 이름
        /// </summary>
        public const string Name = "HallaTube";
        /// <summary>
        /// 트리자료구조에서 최상위 부모를 나타내는 값
        /// 다른 코드값과 같은 필드를 사용하기 때문에 0으로 코드길이와 맞춘다.
        /// </summary>
        public const string TreeRoot = "000000000000";

        /// <summary>
        /// 문자열 구분자 '｜'//ㄱ 특문 2번째 4번
        /// </summary>
        public const string Splitor = "｜";

        /// <summary>
        /// 문자열 구분자 '―'//ㄱ 특문 3번째 5번
        /// </summary>
        public const string SplitorLine = "―";

        /// <summary>
        /// 문자 구분자 '｜'
        /// </summary>
        public const char cSplitor = '｜';


        public const string PointPrev = "<";
        public const string PointNext = ">";

        /// <summary>
        /// 금액
        /// </summary>
        public const string PayFormat = "###,###,###";

		/// <summary>
		/// 날짜 형식
		/// </summary>
		public const string Date = "yyyy-MM-dd";
		public const string DateHHmm = "yyyy-MM-dd HH:mm";
		public const string DateHHmmss = "yyyy-MM-dd HH:mm:ss";
        public const string DateTimeZone = " (UTC + {0}) ";
    }
}
