using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using HALLA_PM.Util;

namespace HALLA_PM.Core
{
    public class Define
    {
        #region FILE_PATH : 시스템의 파일 위치입니다.
        /// <summary>
        /// 시스템의 파일위치입니다.
        /// </summary>
        public static readonly string FILE_PATH = HttpContext.Current.Server.MapPath("~/Files");
        #endregion

        #region LOG_PATH : 시스템의 로그파일 위치입니다.
        /// <summary>
        /// 시스템의 로그파일 위치입니다.
        /// </summary>
        public static readonly string LOG_PATH = HttpContext.Current.Server.MapPath("~/Logs");
        #endregion

        #region SSO_SYSTEM_CODE : SSO 로그인시 체크하는 시스템 코드입니다.
        /// <summary>
        /// SSO 로그인시 체크하는 시스템 코드입니다.
        /// </summary>
        public static readonly string SSO_SYSTEM_CODE = "23bfUlot87-pI00-12UB-2490UD-A6874csvV5GS";
        #endregion

        #region SSO_CONTENTS_CODE : SSO 로그인시 체크하는 컨텐츠 코드입니다.
        /// <summary>
        /// SSO 로그인시 체크하는 컨텐츠 코드입니다.
        /// </summary>
        public static readonly string SSO_CONTENTS_CODE = "CONTENTS.HEIS.SSO";
        #endregion

        #region SSO_DECRYPT_KEY : SSO 암호화코드를 복호화하는 키입니다.
        /// <summary>
        /// SSO 암호화코드를 복호화하는 키입니다.
        /// </summary>
        public static readonly string SSO_DECRYPT_KEY = "137847902154806368821970";
        #endregion

        #region ADMIN_SESSION_NAME : 관리자 세션 이름입니다.
        /// <summary>
        /// 관리자 세션 이름입니다.
        /// </summary>
        public static readonly string ADMIN_SESSION_NAME = "adminSession";
        #endregion

        #region MEMBER_SESSION_NAME : 사용자 세션 이름입니다.
        public static readonly string MEMBER_SESSION_NAME = "memberSession";
        #endregion

        #region ERROR_PAGE_URL : 문제 발생시 이동 페이지
        /// <summary>
        /// 문제 발생시 이동 페이지
        /// </summary>
        public static readonly string ERROR_PAGE_URL = "/SiteMngHome/LogOut";
        //public static readonly string ERROR_PAGE_URL = "/SiteMngHome/LoginAccessTemp";
        #endregion

        #region AUTH_PAGE_URL : 관리자 권한 없을시 이동 페이지
        public static readonly string AUTH_PAGE_URL = "/SiteMngHome/index";
        #endregion

        #region SYSTEM_ERROR_PAGE_URL : 보고시스템 문제 발생시 이동 페이지
        /// <summary>
        /// 사용자 페이지 이동
        /// : /LoginAccessTemp
        /// </summary>
        public static readonly string SYSTEM_ERROR_PAGE_URL = "/Home/LogOut";
        //public static readonly string SYSTEM_ERROR_PAGE_URL = "/Home/LoginAccessTemp";
        #endregion

        #region SYSTEM_AUTH_PAGE_URL : 보고시스템 권한 없을 시 이동 페이지
        public static readonly string SYSTEM_AUTH_PAGE_URL = "/Home/Index";
        #endregion

        #region AUTH_LEVEL : 관리자권한의 마스터 레벨
        /// <summary>
        /// 관리자권한의 마스터 레벨
        /// </summary>
        public static readonly TypeDictionary<int, string> AUTH_LEVEL = new TypeDictionary<int, string>()
        {
            { 1, "최종 관리자" },
            { 2, "중간 관리자" },
            { 4, "중간 관리자2" },
            { 3, "실적 담당자" },
        };
        #endregion

        #region IS_USE : 사용여부
        /// <summary>
        /// 사용여부
        /// </summary>
        public static readonly TypeDictionary<string, string> IS_USE = new TypeDictionary<string, string>()
        {
            { "Y", "사용" },
            { "N", "미사용" },
        };
        #endregion

        #region IS_USE : 사용여부
        /// <summary>
        /// 사용여부
        /// </summary>
        public static readonly TypeDictionary<string, string> IS_DISCLOSURE = new TypeDictionary<string, string>()
        {
            { "Y", "사용" },
            { "N", "미사용" },
        };
        #endregion

        #region MENU_TYPE : 보고시스템 메뉴 권한
        /// <summary>
        /// 보고시스템 메뉴 권한
        /// </summary>
        public static readonly TypeDictionary<int, string> MENU_TYPE = new TypeDictionary<int, string>()
        {
            { 1, "사업계획" },
            { 2, "경영실적" },
            { 3, "트렌드분석" },
            { 4, "공시관리"}
        };
        #endregion

        #region REGIST_STATUS : 등록상태
        /// <summary>
        /// 등록상태
        /// </summary>
        public static readonly TypeDictionary<int, string> REGIST_STATUS = new TypeDictionary<int, string>()
        {
            { 1, "미등록" },
            { 2, "저장" },
            { 3, "승인대기" },
            { 4, "1차반려" },
            { 5, "2차반려" },
            { 6, "1차승인" },
            { 7, "최종승인" },
            { 8, "2차승인" },
            { 9, "3차반려" },
        };
        #endregion

        #region CUMULATIVE : 누계여부
        /// <summary>
        /// 누계여부
        /// </summary>
        public static readonly TypeDictionary<int, string> CUMULATIVE = new TypeDictionary<int, string>()
        {
            { 10, "당월 실적" },
            { 20, "누계 실적" },
            //{ 30, "누적 차이" },
        };
        #endregion

        #region DIFF : 계획, 실적, 차이 구분
        /// <summary>
        /// 계획, 실적, 차이 구분
        /// 계획이면 PL, 실적이면 PM, 차이이면, DI
        /// </summary>
        public static readonly TypeDictionary<int, string> DIFF = new TypeDictionary<int, string>()
        {
            { 10, "계획" },
            { 15, "예상" },
            { 20, "실적" },
            { 30, "차이" },
            { 40, "계획대비" },
            { 50, "전년대비" },
        };
        #endregion

        #region MONTHLY_TYPE : 년간 데이터의 순서 - 당월, 누계, 연간
        /// <summary>
        /// 당월, 누계, 연간이외의 항목이 추가되면 트렌드분석 쿼리를 수정해줘야한다.
        /// 현재 연간 값 이외에 값을 가져오게 되어있음.
        /// </summary>
        public static readonly TypeDictionary<int, string> MONTHLY_TYPE = new TypeDictionary<int, string>()
        {
            { 10, "당월" },
            { 20, "누계" },
            { 30, "연간" },
        };
        #endregion

        #region ANALYSIS : 손익분석 구분값
        /// <summary>
        /// 손익분석 구분값
        /// 매출 차이 : 10, 영업이익 차이 : 20, 경상이익 차이 : 30, 당기순이익 차이 : 40
        /// </summary>
        public static readonly TypeDictionary<int, string> ANALYSIS = new TypeDictionary<int, string>()
        {
            { 10, "매출 차이" },
            { 20, "영업이익 차이" },
            { 30, "경상이익 차이" },
            { 40, "당기순이익 차이" },
        };
        #endregion

        #region MyRegion
        /// <summary>
        /// 상세데이터구분
        /// </summary>
        public static readonly TypeDictionary<int, string> DETAIL_TYPE = new TypeDictionary<int, string>()
        {
            { 0, "월별(혹은년도별)데이터" },
            { 1, "월별(혹은년도별)데이터합계" },
            { 2, "월별(혹은년도별)데이터(회사)" },
            { 3, "월별(혹은년도별)데이터합계(회사)" },
            { 4, "분기별(혹은년도별)데이터(회사)" },
            { 5, "분기별(혹은년도별)데이터합계(회사)" }
        };
        #endregion

        /// <summary>
        /// { "year", "년도" },
        /// { "quater", "분기" },
        /// { "month_period", "월(기간)" },
        /// { "month_select", "월(선택)" },
        /// </summary>
        public static readonly TypeDictionary<string, string> YEAR_TYPE = new TypeDictionary<string, string>()
        {
            { "year", "년도" },
            { "quater", "분기" },
            { "month_period", "월(기간)" },
            { "month_select", "월(선택)" },
        };

        /// <summary>
        /// { "0", "그룹" },
        /// { "1", "부문" },
        /// { "2", "회사" },
        /// { "3", "BU" },
        /// </summary>
        public static readonly TypeDictionary<string, string> LEVEL = new TypeDictionary<string, string>()
        {
            { "0", "그룹" },
            { "1", "부문" },
            { "2", "회사" },
            { "3", "BU" },
        };

        // 공지사항 관리 타입
        public static readonly TypeDictionary<int, string> NOTICE_SEARCH_TYPE = new TypeDictionary<int, string>()
        {
            { 0, "전체" },
            { 1, "제목" },
            { 2, "내용" },
        };

        // 자료실 관리 타입
        public static readonly TypeDictionary<int, string> REFERENCE_SEARCH_TYPE = new TypeDictionary<int, string>()
        {
            { 0, "전체" },
            { 1, "제목" },
            { 2, "내용" },
        };

        // 경영실적 관리 타입
        public static readonly TypeDictionary<int, string> BUSINESS_PERFORMANCE_SEARCH_TYPE = new TypeDictionary<int, string>()
        {
            { 0, "전체" },
            { 1, "제목" },
            { 2, "내용" },
        };
        // 경영실적 관리 타입
        public static readonly TypeDictionary<int, string> BUSINESS_PERFORMANCE_TYPE = new TypeDictionary<int, string>()
        {
            { 1, "Cash Flow" },
            { 2, "손익" },
            { 3, "분기별 손익" },
            { 4, "BS" },
            { 5, "투자·인원" },
        };

        public static readonly TypeDictionary<string, string> BUSINESS_PLAN_REPLY_TYPE = new TypeDictionary<string, string>()
        {
            { "", "계획관리 항목" },
            { "손익월별계획", "손익월별계획" },
            { "손익중기계획", "손익중기계획 " },
            { "중기BS", "중기BS" },
           // { "PLAN_YEAR_BS_EX", "중기BS-(주)한라별도" },
            { "중기CF", "중기CF" },
            { "월별투자인원계획", "월별투자인원계획" },
            { "중기투자인원계획", "중기투자인원계획" },
        };

        public static readonly TypeDictionary<string, string> BUSINESS_PLAN_REPLY_ITEM = new TypeDictionary<string, string>()
        {
            { "", "계획관리 항목" },
            { "PLAN_MONTHLY_PAL", "손익월별계획" },
            { "PLAN_YEAR_PAL", "손익중기계획 " },
            { "PLAN_YEAR_BS", "중기BS" },
           // { "PLAN_YEAR_BS_EX", "중기BS-(주)한라별도" },
            { "PLAN_YEAR_CF", "중기CF" },
            { "PLAN_MONTHLY_INVEST", "월별투자인원계획" },
            { "PLAN_YEAR_INVEST", "중기투자인원계획" },
        };

        public static readonly TypeDictionary<string, string> BUSINESS_PLAN_TYPE = new TypeDictionary<string, string>()
        {
            { "", "분류" },
            { "PLAN_MONTHLY_PAL", "[사업계획] 손익월별" },
            { "PLAN_YEAR_PAL", "[사업계획] 손익중기 " },
            { "PLAN_YEAR_BS", "[사업계획] 중기BS" },
            { "PLAN_YEAR_BS_EX", "[사업계획] 중기BS-(주)한라별도" },
            { "PLAN_YEAR_CF", "[사업계획] 중기CF" },
            { "PLAN_MONTHLY_INVEST", "[사업계획] 월별투자인원" },
            { "PLAN_YEAR_INVEST", "[사업계획] 중기투자인원" },
            { "PM_CASH_FLOW", "[경영실적] Cash Flow" },
            { "PM_PAL", "[경영실적] 손익" },
            { "PM_QUARTER_PAL", "[경영실적] 분기별 손익 " },
            { "PM_BS", "[경영실적] BS" },
            { "PM_BS_EX", "[경영실적] BS (주)한라 별도" },
            { "PM_INVEST", "[경영실적] 투자,인원" },
        };
        public static readonly TypeDictionary<string, string> BUSINESS_PM_TYPE = new TypeDictionary<string, string>()
        {
            { "", "경영실적 항목" },
            { "CF", "CF" },
            { "손익", "손익" },
            { "분기별손익", "분기별손익" },
            { "BS", "BS" },            
            //{ "PM_BS_EX", "BS (주)한라 별도" },
            { "투자,인원", "투자,인원" },
        };

        #region 관리자권한관리 : 검색종류
        /// <summary>
        /// 관리자권한관리 : 검색종류
        /// </summary>
        public static readonly TypeDictionary<int, string> ADMIN_SEARCH_TYPE = new TypeDictionary<int, string>()
        {
            { 0, "전체" },
            { 1, "사번" },
            { 2, "이름" },
            { 3, "회사명" },
            { 4, "직위" },
        };
        #endregion

        // 그룹데이타조정 계획종류
        public static readonly TypeDictionary<string, string> PLAN_GROUPDATA_TYPE = new TypeDictionary<string, string>()
        {
            { "", "계획관리 항목" },
            { "01", "Cash Flow" },
            { "02", "손익" },
            //{ "03", "분기별 손익" },
            { "04", "BS" },
            { "05", "투자·인원" },
        };

        // 그룹데이타조정 계획종류
        public static readonly TypeDictionary<string, string> PERFORMANCE_GROUPDATA_TYPE = new TypeDictionary<string, string>()
        {
            { "", "경영실적 항목" },
            { "01", "Cash Flow" },
            { "02", "손익" },
            { "03", "분기별 손익" },
            { "04", "BS" },
            { "05", "투자·인원" },
        };
    }
}