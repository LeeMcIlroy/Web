using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Data;
using Dapper;
using HALLA_PM.Util;

namespace HALLA_PM.Models
{
    public class ExcelFileUploadListRepo : DbCon, IExcelFileUploadListRepo
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

        public int insert(ExcelFileUploadList entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                try
                {
                    con.Open();
                    string query = " INSERT INTO  EXCEL_FILE_UPLOAD_LIST ( " +
                        // 이부분은 수정하여 사용하세요. 
                        " USER_KEY " +
                        ", EMP_NO " +
                        ", CREATE_DATE " +
                        ", ATTACH_TABLE_NAME " +
                        ", ATTACH_TABLE_SEQ " +
                        ", FILE_INPUT_NAME " +
                        ", FILE_PATH " +
                        ", FILE_ORG_NAME " +
                        ", FILE_STORED_NAME " +
                        ", FILE_SIZE " +
                        ", DESCRIPT " +
                    " ) VALUES ( " +
                    " @UserKey " +
                    ", @EmpNo " +
                    ", GETDATE() " +
                    ", @AttachTableName " +
                    ", @AttachTableSeq " +
                    ", @FileInputName " +
                    ", @FilePath " +
                    ", @FileOrgName " +
                    ", @FileStoredName " +
                    ", @FileSize " +
                    ", @Descript " +
                    // 이부분은 수정하여 사용하세요. 
                    "); SELECT CAST(SCOPE_IDENTITY() as int)";
                    return con.Query<int>(query, entity).First();
                }
                catch (Exception e)
                {
                    LogUtil.MngError(e.ToString());
                    return -1;
                }
            }

        }

        public int save(ExcelFileUploadList entity)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<ExcelFileUploadList> selectList(object param)
        {
            throw new NotImplementedException();
        }

        public ExcelFileUploadList selectOne(object param)
        {
            throw new NotImplementedException();
        }

        public int update(ExcelFileUploadList entity)
        {
            throw new NotImplementedException();
        }
    }
}