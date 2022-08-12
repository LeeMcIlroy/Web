using System;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Data;

namespace HallaTube
{
    [EmptyModel]
    public class UserEntity : DataEntity
    {
        public string UserID { set; get; }
        public string EmpNo { set; get; }
        public string Email { set; get; }
        public string UserType { set; get; }

        public string UserKornm { set; get; }
        public string UserEngnm { set; get; }
        public string UserChnnm { set; get; }

        public string DeptID { set; get; }
        public string DeptNm { set; get; }
        public string DeptPath { set; get; }

        public string GradeID { set; get; }
        public string GradeNm { set; get; }
        public string PositionID { set; get; }
        public string PositionNm { set; get; }
        public string CompID { set; get; }
        public string CompNm { set; get; }

        public float? TimezoneH { set; get; } = 9;
        public string Language { set; get; } = LanguageType.KOR;
        public string Photo { set; get; }
    }
}
