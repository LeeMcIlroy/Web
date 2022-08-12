using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.ComponentModel.DataAnnotations;

using GCRL.Models;

namespace GCRL.Areas.test.Models
{
    public class itemModel
    {
        public string errorCode { get; set; } // 에러코드
        public string totalCount { get; set; } // 총 개수
        public string count { get; set; }   
        public string message { get; set; }

        public string search { get; set; }   //검색어

        public Array data { get; set; }
        public string no { get; set; }       // 번호
       
        public string itemCode { get; set; } // 검사코드

        public string field { get; set; }    // 검사분야
        public string insNo { get; set; }    // 분류번호
        public string insCode { get; set; }  // 보험코드

        public string itemName { get; set; } // 검사명

        public string day { get; set; }      // 검사일

        public string during { get; set; }   // 소요일




    }
    public class itemViewModel
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

        public string name1 { get; set; }   // 소요일
        public string additive1 { get; set; }   // 소요일
        public string tests1 { get; set; }   // 소요일
        public string collection1 { get; set; }   // 소요일

        public string storage1 { get; set; }   // 소요일
        public string method1 { get; set; }   // 소요일
        public string imagePath1 { get; set; }   // 소요일

    }

}