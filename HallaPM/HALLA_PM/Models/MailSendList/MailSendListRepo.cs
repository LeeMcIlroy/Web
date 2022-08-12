using Dapper;
using HALLA_PM.Util;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class MailSendListRepo : DbCon, IMailSendListRepo
    {
        public int count(object param)
        {
            throw new NotImplementedException();
        }

        public int delete(object key)
        {
            throw new NotImplementedException();
        }

        public void Dispose()
        {
            throw new NotImplementedException();
        }

        public int insert(MailSendList entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " INSERT INTO  MAIL_SEND_LIST ( " +
                        // 이부분은 수정하여 사용하세요. 
                        " SEND_DATE " + 
                        ", FM_ADDRESS " +
                        ", TO_ADDRESS " +
                        ", SUBJECT " +
                        ", BODY " +
                        ", IS_SEND " +
                        ", FAIL_REASON " +
                    " ) VALUES ( " +
                    " GETDATE() " +
                    ", @FmAddress " +
                    ", @ToAddress " +
                    ", @Subject " +
                    ", @Body " +
                    ", @IsSend " +
                    ", @FailReason " +
                    // 이부분은 수정하여 사용하세요. 
                    "); SELECT @@ROWCOUNT";
                    return con.Query<int>(query, entity).First();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return -1;
                }
            }
        }

        public int save(MailSendList entity)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<MailSendList> selectList(object param)
        {
            throw new NotImplementedException();
        }

        public MailSendList selectOne(object param)
        {
            throw new NotImplementedException();
        }

        public int update(MailSendList entity)
        {
            throw new NotImplementedException();
        }
    }
}