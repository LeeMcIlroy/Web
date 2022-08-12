using System;
using System.Linq;
using System.Collections.Generic;
using System.Text;
using System.Reflection;
using System.Diagnostics;

namespace HallaTube
{
    
    /// <summary>
    /// 다국어형태
    /// </summary>
    public sealed class LanguageType : Code<LanguageType>
    {
        static LanguageType()
        {
            DefaultLanguage = KOR;
        }
        public static string DefaultLanguage { set; get; }
        [Order(0)]
        public const string KOR = "KOR";
        [Order(1)]
        public const string ENG = "ENG";
        [Order(2)]
        public const string CHN = "CHN";
    }
    public sealed class BoardCategoryType : Code<BoardCategoryType>
    {
        [CodeName("공지사항")]
        public const string Notice = "Notice";
        [CodeName("묻고답하기")]
        public const string Qna = "Qna";
        [CodeName("정보공유")]
        public const string CodeShare = "CodeShare";
        [CodeName("질문")]
        public const string Question = "Question";
    }

    public sealed class BoardAuthType : Code<BoardAuthType>
    {
        [CodeName("목록")]
        public const string List = "List";
        [CodeName("읽기")]
        public const string Read = "Read";
        [CodeName("쓰기")]
        public const string Write = "Write";
        [CodeName("수정")]
        public const string Modify = "Modify";
        [CodeName("삭제")]
        public const string Delete = "Delete";
    }

    public sealed class ArticleState : Code<ArticleState>
    {
        [CodeName("없음")]
        public const string NONE = "NONE";
        [CodeName("접수")]
        public const string ACCEPT = "ACCEPT";
        [CodeName("완료")]
        public const string DONE = "DONE";
    }

    /// <summary>
    /// 수발신 방향
    /// </summary>
    public sealed class DirectionType : Code<DirectionType>
    {
        /// <summary>
        /// 발송
        /// </summary>
        public const string SEND = "SEND";

        /// <summary>
        /// 수신
        /// </summary>
        public const string RECEIVE = "RECEIVE";
    }
    public sealed class FunctionType : Code<FunctionType>
    {
        [CodeName("없음")]
        public const string NONE = "NONE";
        [CodeName("메뉴")]
        public const string MENU = "MENU";
        [CodeName("게시판")]
        public const string BOARD = "BOARD";
    }

    public sealed class CategoryType : Code<CategoryType>
    {
        public const string Manager = "Manager";


    }
    
    
    /// <summary>
    /// 첨부파일 형태, 물리적 폴더 이름과 맞춘다.
    /// </summary>
    public sealed class FileType : Code<FileType>
    {
        /// <summary>
        /// 임시
        /// </summary>
        public const string TEMP = "TEMP";
        
        public const string HTML = "HTML";

        public const string CATEGORY = "CATEGORY";

        [FolderRule(FolderRuleType.Day)]
        public const string EDITOR = "EDITOR";

        [FolderRule(FolderRuleType.Day)]
        public const string Article = "Article";

        [FolderRule(FolderRuleType.Day)]
        public const string Thumb = "Thumb";

        public const string Submit = "Submit";
        public const string Image = "Image";

        [FolderRule(FolderRuleType.Day)]
        public const string Attach = "Attach";

    }

    /// <summary>
    /// TB_FILE에 OBJECT_TYPE 필드에 사용된다.
    /// </summary>
    public sealed class ObjectType : Code<ObjectType>
    {
        public const string Article = "Article";
        public const string Challenge = "Challenge";
        public const string Submit = "Submit";
        public const string Image = "Image";
    }


    /// <summary>
    /// 파일 확장자
    /// </summary>
    public sealed class FileExtension : Code<FileExtension>
    {
        public const string HTM = ".html";
        public const string DOC = ".doc";
        public const string JPG = ".jpg";
        public const string PNG = ".png";
        public const string GIF = ".gif";
        public const string XML = ".xml";
        public const string JS = ".js";
        public const string None = "";
    }

    /// <summary>
    /// 권한 유형
    /// </summary>
    public sealed class AuthType : Code<AuthType>
    {
        public const string NONE = "NONE";
        public const string USER = "USER";
        public const string ADMIN = "ADMIN";
    }






    /// <summary>
    /// 코드 슈퍼클래스
    /// </summary>
    /// <typeparam name="T">파생될 코드클래스</typeparam>
    public class Code<T> where T : Code<T>
    {
        /// <summary>
        /// 문자열에 해당하는 코드가 실제 코드로 존재하는지 판단
        /// </summary>
        /// <param name="code">코드</param>
        /// <returns>존재 여부</returns>
        public static bool Exist(string code)
        {

            Type type = typeof(T);

            var list = from prop in type.GetFields()
                       where prop.GetRawConstantValue().ToString().Equals(code, StringComparison.CurrentCultureIgnoreCase)
                       select prop;
            return list.Count() > 0;
        }

        /// <summary>
        /// 코드의 FieldInfo개체를 반환
        /// </summary>
        /// <param name="code">코드</param>
        /// <returns>FieldInfo개체</returns>
        public static FieldInfo GetField(string code)
        {
            Type type = typeof(T);

            var list = from prop in type.GetFields()
                       where prop.Name.Equals(code, StringComparison.CurrentCultureIgnoreCase)
                       select prop;
            if (list.Count() > 0)
            {
                return list.First();
            }
            else
            {
                return null;
            }
        }

        /// <summary>
        /// 파스칼 케이로 입력된 코드를 실 코드로 반환
        /// </summary>
        /// <param name="code">파스칼 케이스 코드값</param>
        /// <returns>실 코드</returns>
        public static string GetCode(string code)
        {
            Type type = typeof(T);

            var list = from prop in type.GetFields()
                       where prop.Name.ToPascalCase().Equals(code, StringComparison.CurrentCultureIgnoreCase)
                       select prop;
            if (list.Count() > 0)
            {
                return list.First().Name;
            }
            else
            {
                return null;
            }
        }

        /// <summary>
        /// 코드 순서
        /// </summary>
        /// <param name="code">코드</param>
        /// <returns>코스순서</returns>
        public static int GetOrder(string code)
        {

            Type type = typeof(T);

            var list = from prop in type.GetFields()
                       where prop.GetRawConstantValue().ToString().Equals(code, StringComparison.CurrentCultureIgnoreCase)
                       select prop;

            var attr = list.First().GetCustomAttributes(typeof(OrderAttribute), false);
            if (attr.Length == 0) return -1;
            else
            {
                return (attr[0] as OrderAttribute).Order;
            }
        }

        /// <summary>
        /// 코드의 명칭을 반환
        /// </summary>
        /// <param name="code">코드</param>
        /// <returns>코드명</returns>
        public static string GetName(string code)
        {
            if (string.IsNullOrEmpty(code)) return string.Empty;

            Type type = typeof(T);

            var list = from prop in type.GetFields()
                       where prop.GetRawConstantValue().ToString().Equals(code, StringComparison.CurrentCultureIgnoreCase)
                       select prop;
            if(list.Count()==0) return string.Empty;
            var attr = list.First().GetCustomAttributes(typeof(CodeNameAttribute), false);
            if (attr.Length == 0) return string.Empty;
            else
            {
                return (attr[0] as CodeNameAttribute).CodeNm;
            }
        }

        public static string GetGroup(string code)
        {

            Type type = typeof(T);

            var list = from prop in type.GetFields()
                       where prop.GetRawConstantValue().ToString().Equals(code, StringComparison.CurrentCultureIgnoreCase)
                       select prop;

            var attr = list.First().GetCustomAttributes(typeof(FieldGroupAttribute), false);
            if (attr.Length == 0) return null;
            else
            {
                return (attr[0] as FieldGroupAttribute).GroupNm;
            }
        }

        public static Dictionary<string, string> GetCodeList(bool isValueKey = false, bool isNameValue = false)
        {
            Type type = typeof(T);

            var dic = new Dictionary<string, string>();


            FieldInfo field = null;
            foreach (var prop in type.GetFields())
            {
                int min = int.MaxValue;
                foreach (var attr in type.GetFields())
                {
                    int order = int.MinValue;
                    if (dic.ContainsKey(isValueKey ? attr.GetRawConstantValue() as string : attr.Name))
                    {
                        continue;
                    }

                    var list = attr.GetCustomAttributes(typeof(OrderAttribute), false);
                    if (list.Length > 0)
                    {
                        order = (list[0] as OrderAttribute).Order;
                    }

                    if (min > order)
                    {
                        field = attr;
                        min = order;
                    }
                }

                string name = field.GetRawConstantValue() as string;
                if (isNameValue)
                {
                    var list = field.GetCustomAttributes(typeof(CodeNameAttribute), false);
                    if (list.Length > 0)
                    {
                        name = (list[0] as CodeNameAttribute).CodeNm;
                    }
                }

                dic.Add(isValueKey ? field.GetRawConstantValue() as string : field.Name, name);
            }

            return dic;
        }
    }


}
