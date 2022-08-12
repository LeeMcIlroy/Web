using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GCRL.Modules
{
    public enum PageEnum
    {
        /// <summary>
        /// 검사관리 - 장비소개
        /// </summary>
        TestEquipment = 13,

        /// <summary>
        /// 고객지원 - GC Labs 공문
        /// </summary>
        SupportOfficial = 21,
        /// <summary>
        /// 고객지원 - 신규검사
        /// </summary>
        SupportNew = 22,
        /// <summary>
        /// 고객지원 - Info & Tech
        /// </summary>
        SupportInfo = 23,
        /// <summary>
        /// 고객지원 - 인증현황
        /// </summary>
        SupportCertify = 24,
        /// <summary>
        /// 고객지원 - 검사약어
        /// </summary>
        SupportWording = 25,
        /// <summary>
        /// 고객지원 - 브로슈어
        /// </summary>
        SupportBrochure = 26,
        /// <summary>
        /// 고객지원 - 학술발표
        /// </summary>
        SupportAnnounce = 27,

        /// <summary>
        /// 고객문의 - 고객문의
        /// </summary>
        ConnectQna = 31,
        /// <summary>
        /// 고객문의 - 자주하는 질문
        /// </summary>
        ConnectFaq = 32,

        /// <summary>
        /// 재단홍보 - 언론보도
        /// </summary>
        PrPress = 41,
        /// <summary>
        /// 재단홍보 - Live GC Labs
        /// </summary>
        PrLive = 42,
        /// <summary>
        /// 재단홍보 - 재단소식
        /// </summary>
        PrNews = 43,
        /// <summary>
        /// 재단홍보 - 홍보영상
        /// </summary>
        PrVideo = 44,
        /// <summary>
        /// 재단홍보 - 사회공헌
        /// </summary>
        PrShare = 45,

        /// <summary>
        /// 재단소개 - 전문의
        /// </summary>
        GclabsDoctors = 51,
        /// <summary>
        /// 재단소개 - 네트워크
        /// </summary>
        GclabsNetwork = 52,

        /// <summary>
        /// Test Updates
        /// </summary>
        EngUpdates = 61,
        /// <summary>
        /// Test Request Forms
        /// </summary>
        EngForms = 62,
        /// <summary>
        /// Certifications
        /// </summary>
        EngCertification = 63,
        /// <summary>
        /// Press Releases
        /// </summary>
        EngPr = 64,
        /// <summary>
        /// Newsletters
        /// </summary>
        EngNewsletters = 65,
        /// <summary>
        /// Info & Tech
        /// </summary>
        EngInt = 66,
        /// <summary>
        /// Marketing Materials
        /// </summary>
        EngMarketing = 67,
        /// <summary>
        /// Global Networks
        /// </summary>
        EngNetworks = 68,
        /// <summary>
        /// Doctors
        /// </summary>
        EngDoctors = 69,
        /// <summary>
        /// Clients
        /// </summary>
        EngClients = 70,
        /// <summary>
        /// Contact Us
        /// </summary>
        EngQna = 71,
        /// <summary>
        /// Equipment
        /// </summary>
        EngEquipment = 72,

        /// <summary>
        /// 전시관리 - 메인컨텐츠관리
        /// </summary>
        DisplayContents = 81
    }
}