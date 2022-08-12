using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.ComponentModel.DataAnnotations;

using GCRL.Models;

namespace GCRL.Areas.test.Models
{
    public class instrumentModel
    {
        public string errorCode { get; set; } // 에러코드
        public string totalCount { get; set; } // 총 개수
        public string count { get; set; }   
        public string message { get; set; }

        public string search { get; set; }   //검색어

        public string no { get; set; }  // 순차적 번호
        public string idx { get; set; }  // 번호
        public string name { get; set; }  // 번호
        public string imagePath { get; set; }  // 번호

        public string additive { get; set; }   // 소요일
        public string tests { get; set; }   // 소요일
        public string collection { get; set; }   // 소요일

        public string storage { get; set; }   // 소요일
        public string method { get; set; }   // 소요일

        public string pre_idx { get; set; }  // 이전번호
        public string next_idx { get; set; }  // 다음번호
    }
    public class instrumentViewModel
    {
        public string Specimen { get; set; }   // 검체량
        public string Storage { get; set; }   // 검체보관
        public string Stability { get; set; } //검체안정성
        public string Price { get; set; }   // 소요일
        public string Method { get; set; }   // 소요일
        public string Meaning { get; set; }   // 소요일
        public string Reference { get; set; }   // 소요일
        public string Day { get; set; }   // 소요일
        public string During { get; set; }   // 소요일
        public string Essential { get; set; }   // 소요일
        public string Caution { get; set; }   // 소요일
        public string itemName { get; set; } //품명
        public string itemCode { get; set; } // 검사코드
        public string field { get; set; }    // 검사분야
        public string insNo { get; set; }    // 분류번호
        public string insCode { get; set; }  // 보험코드

        public Array bottle { get; set; }
        public string name { get; set; }   // 소요일
        public string additive { get; set; }   // 소요일
        public string tests { get; set; }   // 소요일
        public string collection { get; set; }   // 소요일

        public string storage { get; set; }   // 소요일
        public string method { get; set; }   // 소요일
        public string imagePath { get; set; }   // 소요일

        public bool hasValue { get; set; }   // 소요일

        public string idx { get; set; }  // 번호
        public string pre_idx { get; set; }  // 이전번호
        public string next_idx { get; set; }  // 다음번호
    }
}