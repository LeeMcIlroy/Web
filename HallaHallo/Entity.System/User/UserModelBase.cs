using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Collections;
using System.Data;

using Castle.Data;
using HallaTube;

namespace HallaTube
{
    [Serializable]
    [EmptyModel]
    public class UserModelBase
    {
        [ReflectionType("NoDisplay")]
        public UserEntity User { set; get; }

        public UserModelBase()
        {
            UserId = string.Empty;

            this.User = new UserEntity();
        }


        public string UserId { set; get; }

        #region 사용자 정보

        public string UserKornm { get { return this.User.UserKornm; } }
        public string UserEngnm { get { return this.User.UserEngnm; } }
        public string UserChnnm { get { return this.User.UserChnnm; } }

        [ReflectionType("NoDisplay")]
        public string LoginType { set; get; }
        public string Login { set; get; }//로그인 처리 여부
        public string UserType
        {
            get
            {
                //TODO : 유저모드 변경
                return AuthType.ADMIN;
            }
        }

        #endregion


        [ReflectionType("NoDisplay")]
        public virtual int ListCount { set; get; }
    }
}
