
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Transactions;

using Castle.Data;

namespace HallaTube
{
    /// <summary>
    /// »ç¿ëÀÚ
    /// </summary>
    public class UserRepository : DataRepository
    {
        public void LoadUser(string userId, UserModel model)
        {
            ExecuteDataRow("User.Get", new { userId }).GetEntity<UserEntity>(model.User);
        }

        public UserEntity GetData(string userId)
        {
            return ExecuteDataRow("User.GetData", new { userId }).GetEntity<UserEntity>();
        }

        public List<UserEntity> GetAll()
        {
            return ExecuteDataTable("User.GetAll").GetEntityList<UserEntity>();
        }

        public List<UserEntity> GetSubAll(string subDeptNm)
        {
            return ExecuteDataTable("User.GetAll",new { subDeptNm }).GetEntityList<UserEntity>();
        }

        public List<UserEntity> GetDeptUser(string deptNm)
        {
            return ExecuteDataTable("User.GetAll", new { deptNm }).GetEntityList<UserEntity>();
        }

        public DataRow GetPosition(string userID)
        {
            return ExecuteDataRow("User.GetPosition", new { userID });
        }

        public DataRow GetAllCount()
        {
            return ExecuteDataRow("User.GetAllCount");
        }

        public DataRow GetValidUser(string userId)
        {
            return ExecuteDataRow("User.GetValidUser", new { userId });
        }
    }
}
