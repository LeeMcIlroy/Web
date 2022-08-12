using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace HallaTube
{
    public enum FolderRuleType
    {
        None = 0,
        Year = 1,
        Month = 3,
        Day = 7
    }

    //클래스나 열거자를 받아 해당 타입의 멤버대로 폴더를 나누는 기능만들예정

    [AttributeUsage(AttributeTargets.Field)]
    public sealed class FolderRuleAttribute : Attribute
    {
        public FolderRuleType FolderRule { set; get; }
        public string FolderNm { set; get; }
        public bool Private { set; get; }

        public FolderRuleAttribute(FolderRuleType rule)
        {
            FolderRule = rule;
        }

        public FolderRuleAttribute(FolderRuleType rule, string folderNm)
        {
            FolderRule = rule;
            FolderNm = folderNm;
        }

        public FolderRuleAttribute(FolderRuleType rule, string folderNm, bool isPrivate)
        {
            FolderRule = rule;
            FolderNm = folderNm;
            Private = isPrivate;
        }
    }
}
