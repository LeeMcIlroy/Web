using Castle.Data;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HallaTube
{
    public class UserModel: DataRepository
    {
        protected UserModel()
        {
            //Language = LanguageType.KOR;

        }

        public UserModel(UserEntity user) : this()
        {
            this.user = user;

        }

        DataAgent agent=DataAgent.GetDBAgent("HallaTubeInsa");
        public UserModel(string userId) : this()
        {
            DataRow dr = null;
#if !DEBUG
            dr = DataCommand.GetCommand(agent, "User.Get", new { userId }).ExecuteDataRow();
#endif
            if (dr == null)
            {
                if (userId == "admin")
                {
                    this.user = new UserEntity
                    {
                        UserID = userId,
                        UserKornm = userId,
                        UserEngnm = userId,
                        UserChnnm = userId,
                    };
                    user.UserType = AuthType.ADMIN;
                }
                else if (userId == "guest")
                {
                    this.user = new UserEntity
                    {
                        UserID = userId,
                        UserKornm = "게스트",
                        UserEngnm = "게스트",
                        UserChnnm = "게스트",
                    };
                    user.UserType = AuthType.USER;
                }
                else
                {
#if !DEBUG
                throw new Exception("user not found:"+ userId); 
#endif

                    this.user = new UserEntity
                    {
                        UserID = userId,
                        UserKornm = userId,
                        UserEngnm = userId + "_e",
                        UserChnnm = userId + "_c",
                    };
                }
            }
            else
            {
                this.user = new UserEntity
                {
                    UserID = userId,
                    UserKornm = dr["korname"]?.ToString(),
                    UserEngnm = dr["engname"]?.ToString(),
                    UserChnnm = dr["chnname"]?.ToString(),

                    EmpNo = dr["empno"]?.ToString(),
                    Email = dr["EMAIL"]?.ToString(),
                    CompID = dr["compcode"]?.ToString(),
                    CompNm = dr["compname"]?.ToString(),
                    DeptID = dr["deptcode"]?.ToString(),
                    DeptNm = dr["deptname"]?.ToString(),

                    TimezoneH = float.Parse(dr["TIMEZONE_H"]?.ToString() ?? "9"),
                    Language = dr["language"].ToString() ?? LanguageType.KOR,
                    Photo = dr["photo"]?.ToString(),
                };

                if (!string.IsNullOrEmpty(user.DeptNm))
                {
                    user.DeptNm = ((Newtonsoft.Json.Linq.JArray)Newtonsoft.Json.JsonConvert.DeserializeObject(user.DeptNm))[0].ToString();
                }

                if (!string.IsNullOrEmpty(user.CompNm))
                {
                    user.CompNm = ((Newtonsoft.Json.Linq.JArray)Newtonsoft.Json.JsonConvert.DeserializeObject(user.CompNm))[0].ToString();
                }
            }
            

            var manager = ExecuteDataRow("Category.GetCategoryByCode", new { categoryType = CategoryType.Manager, categoryCode = user.UserID }).GetEntity<CategoryEntity>();
            if (manager != null)
            {
                //TODO : 유저모드 변경
                user.UserType = AuthType.ADMIN;
            }
            
        }

        

        protected UserEntity user;

        [Newtonsoft.Json.JsonIgnore]
        public UserEntity User { get { return user; } }

        public string UserKornm { get { return user == null ? "" : user.UserKornm; } }
        public string UserEngnm { get { return user == null ? "" : user.UserEngnm; } }
        public string UserChnnm { get { return user == null ? "" : user.UserChnnm; } }
        public string UserNm
        {
            get
            {
                switch (Language)
                {
                    case LanguageType.ENG:
                        return UserKornm;
                    case LanguageType.CHN:
                        return UserChnnm;

                    default:
                        return UserKornm;
                }
            }
        }

        public string UserId { get { return user == null ? "" : user.UserID; } }
        public string UserType { get { return user == null ? "" : user.UserType; } }
        public string DeptID { get { return user == null ? "" : user.DeptID; } }
        public float TimeZones => user?.TimezoneH ?? 9;

        public virtual string Language { set { if (user != null) user.Language = value; } get { return user == null ? "" : user.Language; } }

        public static implicit operator UserEntity(UserModel model)
        {
            return model.user;
        }

        //public static implicit operator DeptEntity(OrganUserModel model)
        //{
        //    return model.Dept;
        //}




    }
}
