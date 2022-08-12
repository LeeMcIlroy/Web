using Dapper;
using HALLA_PM.Util;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace HALLA_PM.Models
{
    public class FileInfoRepo : DbCon, IFileInfoRepo
    {
        FileUtil fileUtil = new FileUtil(HALLA_PM.Core.Define.FILE_PATH);
        // HttpFileCollectionBase 에서 input name으로 fileInputName에 저장
        public List<FileInfo> attachFile(HttpFileCollectionBase uploadFiles, string attachTableName, int attachTableSeq, string filePath, int ord = 0)
        {
            if (uploadFiles == null)
                return null;

            List<FileInfo> fileInfo = new List<FileInfo>();
            string[] fileNames = uploadFiles.AllKeys;
            for (int i = 0; i < uploadFiles.Count; i++)
            {
                HttpPostedFileBase uploadFile = uploadFiles.Get(i);
                string fileInputName = fileNames[i];

                if (uploadFile.ContentLength == 0)
                    continue;

                var file = fileUtil.FileUpload(uploadFile, filePath);

                var newFileInfo = new FileInfo()
                {
                    attachTableName = attachTableName,
                    attachTableSeq = attachTableSeq,
                    fileInputName = fileInputName,
                    filePath = filePath,
                    fileOrgName = file["ORIGINAL_FILE_NAME"],
                    fileStoredName = file["STORED_FILE_NAME"],
                    fileSize = file["FILE_SIZE"],
                };

                this.insert(newFileInfo);
                fileInfo.Add(newFileInfo);
              
            }
            return fileInfo;
        }

        public List<FileInfo> attachFileDevelop(HttpFileCollectionBase uploadFiles, string attachTableName, int attachTableSeq, string filePath, int ord = 0)
        {
            if (uploadFiles == null)
                return null;

            List<FileInfo> fileInfo = new List<FileInfo>();
            try
            {
                string[] fileNames = uploadFiles.AllKeys;
                for (int i = 0; i < uploadFiles.Count; i++)
                {
                    HttpPostedFileBase uploadFile = uploadFiles.Get(i);
                    string fileInputName = fileNames[i];

                    if (uploadFile.ContentLength == 0)
                        continue;

                    var file = fileUtil.FileUpload(uploadFile, filePath);

                    var newFileInfo = new FileInfo()
                    {
                        attachTableName = attachTableName,
                        attachTableSeq = attachTableSeq,
                        fileInputName = fileInputName,
                        filePath = filePath,
                        fileOrgName = file["ORIGINAL_FILE_NAME"],
                        fileStoredName = file["STORED_FILE_NAME"],
                        fileSize = file["FILE_SIZE"],
                    };

                    //this.insert(newFileInfo);
                    var fileInfoVO = this.selectByInputNameOne(newFileInfo); // 기존파일 확인 // 업로드 파일명 
                    if (fileInfoVO != null)
                    {
                        fileUtil.FileDelete(fileInfoVO.filePath, fileInfoVO.fileStoredName);
                        newFileInfo.seq = fileInfoVO.seq;
                        this.update(newFileInfo);
                    }
                    else
                    {
                        this.insert(newFileInfo);
                    }

                    fileInfo.Add(newFileInfo);
                }
            }
            catch(Exception e)
            {
                LogUtil.MngError("PDF 파일 업로드 에러");
                LogUtil.MngError(e.ToString());
            }
            return fileInfo;

        }
        public int count(object param)
        {
            throw new NotImplementedException();
        }
        public int countAll()
        {
            throw new NotImplementedException();
        }

        public int delete(object key)
        {
            using (IDbConnection con = GetHallaDb())
            {
                con.Open();
                try
                {
                    var fileInfo = this.selectOne(key); // 기존파일 확인 // 업로드 파일명 
                    if (fileInfo != null)
                    {
                        fileUtil.FileDelete(fileInfo.filePath, fileInfo.fileStoredName);
                    }

                    string query = "DELETE FROM FILE_INFO WHERE SEQ = @seq";
                    return con.Execute(query, key);
                }
                catch (Exception e)
                {
                    LogUtil.Error(e.ToString());
                    return -1;
                }
            }
        }
        public int deleteTableSeq(object key)
        {
            using (IDbConnection con = GetHallaDb())
            {
                con.Open();
                try
                {
                    var fileInfo = this.selectOne(key); // 기존파일 확인 // 업로드 파일명 
                    if (fileInfo != null)
                    {
                        fileUtil.FileDelete(fileInfo.filePath, fileInfo.fileStoredName);
                    }

                    string query = "DELETE FROM FILE_INFO WHERE ATTACH_TABLE_NAME =@attachTableName AND ATTACH_TABLE_SEQ=@attachTableSeq ";
                    return con.Execute(query, key);
                }
                catch (Exception e)
                {
                    LogUtil.Error(e.ToString());
                    return -1;
                }
            }
        }

        public int deleteTableSeqAndInputName(object key)
        {
            using (IDbConnection con = GetHallaDb())
            {
                con.Open();
                try
                {
                    var fileInfo = this.selectOneByInputName(key); // 기존파일 확인 // 업로드 파일명 
                    if (fileInfo != null)
                    {
                        fileUtil.FileDelete(fileInfo.filePath, fileInfo.fileStoredName);
                    }

                    string query = "DELETE FROM FILE_INFO WHERE ATTACH_TABLE_NAME =@attachTableName AND ATTACH_TABLE_SEQ=@attachTableSeq AND FILE_INPUT_NAME=@fileInputName ";
                    return con.Execute(query, key);
                }
                catch (Exception e)
                {
                    LogUtil.Error(e.ToString());
                    return -1;
                }
            }
        }

        public void Dispose()
        {
            throw new NotImplementedException();
        }

        public void insert(IEnumerable<FileInfo> entities)
        {
            throw new NotImplementedException();
        }

        public int insert(FileInfo entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                con.Open();
                string query = "INSERT INTO FILE_INFO (" +
                                    " ATTACH_TABLE_NAME, ATTACH_TABLE_SEQ, FILE_INPUT_NAME, FILE_PATH , FILE_ORG_NAME, FILE_STORED_NAME, FILE_SIZE" +
                                " ) VALUES (" +
                                    " @attachTableName, @attachTableSeq, @fileInputName, @filePath, @fileOrgName, @fileStoredName, @fileSize" +
                                "); SELECT CAST(SCOPE_IDENTITY() as int)";
                return con.Query<int>(@query, entity).First();
            }
        }
        
        public FileInfo selectOne(object pksFields)
        {
            using (IDbConnection con = GetHallaDb())
            {
                con.Open();
                string query = "SELECT *  FROM FILE_INFO WHERE " +
                                " ATTACH_TABLE_NAME =@attachTableName AND ATTACH_TABLE_SEQ=@attachTableSeq ";
                return con.Query<FileInfo>(query, pksFields).FirstOrDefault();
            }
        }

        #region //- selectOneSeq : 테이블 시퀀스로 데이터 가져옵니다. -//
        /// <summary>
        /// 테이블 시퀀스로 데이터 가져옵니다.
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        public FileInfo selectOneSeq(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                con.Open();
                string query = "SELECT * FROM FILE_INFO WHERE SEQ = @seq ";
                return con.Query<FileInfo>(query, param).FirstOrDefault();
            }
        }
        #endregion

        public FileInfo selectOneByInputName(object pksFields)
        {
            using (IDbConnection con = GetHallaDb())
            {
                con.Open();
                string query = "SELECT *  FROM FILE_INFO WHERE " +
                                " ATTACH_TABLE_NAME =@attachTableName AND ATTACH_TABLE_SEQ=@attachTableSeq AND FILE_INPUT_NAME=@fileInputName ";
                return con.Query<FileInfo>(query, pksFields).FirstOrDefault();
            }
        }
        public FileInfo selectAptAreaKindOne(object pksFields)
        {
            using (IDbConnection con = GetHallaDb())
            {
                con.Open();
                string query = "SELECT *  FROM FILE_INFO WHERE " +
                                " ATTACH_TABLE_NAME =@attachTableName AND ATTACH_TABLE_SEQ=@attachTableSeq AND FILE_ORG_NAME=@fileOrgName";
                return con.Query<FileInfo>(query, pksFields).FirstOrDefault();
            }
        }
        public int update(FileInfo entity)
        {
            using (IDbConnection con = GetHallaDb())
            {
                con.Open();

                string query =
                    "UPDATE FILE_INFO SET " +
                        "FILE_ORG_NAME= @fileOrgName , FILE_STORED_NAME= @fileStoredName, FILE_SIZE=@fileSize " +
                    "WHERE " +
                        " SEQ=@seq ";
                try
                {
                    return con.Execute(@query, entity);
                }
                catch (Exception e)
                {
                    LogUtil.Error(e.ToString());
                    return -1;

                }
            }
        }

        public IEnumerable<FileInfo> selectAll(object param)
        {
            throw new NotImplementedException();
        }
        public IEnumerable<FileInfo> selectListByAttachTableName(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                con.Open();
                string query = "SELECT * FROM FILE_INFO WHERE ATTACH_TABLE_NAME =@attachTableName ORDER BY seq DESC";
                return con.Query<FileInfo>(query, param).ToList();
            }
        }

        public IEnumerable<FileInfo> selectList(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                con.Open();
                string query = "SELECT * FROM FILE_INFO WHERE ATTACH_TABLE_NAME =@attachTableName AND ATTACH_TABLE_SEQ=@attachTableSeq ORDER BY seq DESC";
                return con.Query<FileInfo>(query, param).ToList();
            }
        }

        /**
         * [nsy] 사용자 > 브랜드 > 이벤트
         **/
        public IEnumerable<FileInfo> selectUserList(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                con.Open();
                string query = "SELECT * FROM FILE_INFO WHERE ATTACH_TABLE_NAME =@attachTableName ORDER BY seq DESC";
                return con.Query<FileInfo>(query, param).ToList();
            }
        }

        public IEnumerable<FileInfo> selectByInputName(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                con.Open();
                string query = "SELECT *  FROM FILE_INFO WHERE " +
                                " ATTACH_TABLE_NAME =@attachTableName AND ATTACH_TABLE_SEQ=@attachTableSeq AND FILE_INPUT_NAME=@fileInputName ";
                return con.Query<FileInfo>(query, param).ToList();
            }
        }

        public FileInfo selectByInputNameOne(object param)
        {
            using (IDbConnection con = GetHallaDb())
            {
                con.Open();
                string query = "SELECT *  FROM FILE_INFO WHERE " +
                                " ATTACH_TABLE_NAME =@attachTableName AND ATTACH_TABLE_SEQ=@attachTableSeq AND FILE_INPUT_NAME=@fileInputName ";
                return con.Query<FileInfo>(query, param).FirstOrDefault();
            }
        }

        public int save(FileInfo entity)
        {
            throw new NotImplementedException();
        }

    }

}
