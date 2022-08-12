
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Transactions;

using Castle.Data;

namespace HallaTube
{
    /// <summary>
    /// ÆÄÀÏ(Ã·ºÎ µî)
    /// </summary>
    public class FileRepository : DataRepository
    {
        
        public void CreateFile(FileEntity file)
        {
            using (var scope = new TransactionScope(TransactionScopeOption.Required, tranOption, EnterpriseServicesInteropOption.None))
            {
                ExecuteNonQuery("File.CreateFile", file);
                scope.Complete();
            }
        }

        public FileEntity GetFile(string fileID)
        {
            return ExecuteDataRow("File.GetFile", new { fileID }).GetEntity<FileEntity>();
        }

        public void DeleteFile(string fileID)
        {
            ExecuteNonQuery("File.DeleteFile", new { fileID });
        }

        public void DeleteFile(IEnumerable list)
        {
            using (var scope = new TransactionScope(TransactionScopeOption.Required, tranOption, EnterpriseServicesInteropOption.None))
            {
                ExecuteNonQuery("File.DeleteFile", list);
                scope.Complete();
            }
        }

        public List<FileEntity> GetFileList(string objectID, string objectType)
        {
            return ExecuteDataTable("File.GetFileList", new { objectID, objectType }).GetEntityList<FileEntity>();
        }

        public FileEntity GetFile(string objectID, string objectType)
        {
            return ExecuteDataRow("File.GetFileList", new { objectID, objectType }).GetEntity<FileEntity>();
        }
    }
}
