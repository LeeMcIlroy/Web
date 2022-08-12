using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.IO;

namespace HALLA_PM.Util
{
    public class FileUtil
    {
        /// <summary>
        /// 랜덤파일명 사용 함수
        /// </summary>
        int seq = 0;

        /// <summary>
        /// 파일 저장 위치
        /// </summary>
        string _localPath = string.Empty;

        public FileUtil(string localPath)
        {
            _localPath = localPath;
        }

        private string getRandomString()
        {
            string name = DateTime.Now.ToString("yyyyMMdd_HHmmss_fff");
            return name + string.Format("{0:000}", ++seq % 1000);
        }

        public string GetLocalPath(string folderName, string fileName)
        {
            return Path.Combine(_localPath, folderName, fileName);
        }

        public bool FileCopy(string folderName, string fileName, string targetPath)
        {
            var sourceFile = Path.Combine(_localPath, folderName, fileName);
            var targetDirectory = Path.Combine(_localPath, targetPath);
            var targetFile = Path.Combine(_localPath, targetPath, fileName);

            if (sourceFile.Equals(targetFile)) return false;

            if (File.Exists(sourceFile))
            {
                if (!Directory.Exists(targetDirectory)) Directory.CreateDirectory(targetDirectory);
                File.Copy(sourceFile, targetFile, true);
                return true;
            }
            else
            {
                return false;
            }
        }

        public void FileDelete(string folderName, string fileName)
        {
            var targetFile = Path.Combine(_localPath, folderName, fileName);
            if (File.Exists(targetFile)) File.Delete(targetFile);
        }

        public Dictionary<string, string> FileUpload(HttpPostedFileBase f, string folderName)
        {
            var directory = Path.Combine(_localPath, folderName);
            if (!Directory.Exists(directory)) Directory.CreateDirectory(directory);

            var original = Path.GetFileName(f.FileName);
            var stored = getRandomString() + Path.GetExtension(f.FileName);
            var fileSize = f.ContentLength.ToString();
            var path = Path.Combine(directory, stored);

            f.SaveAs(path);

            Dictionary<string, string> resultFileInfo = new Dictionary<string, string>();
            resultFileInfo.Add("ORIGINAL_FILE_NAME", original);
            resultFileInfo.Add("STORED_FILE_NAME", stored);
            resultFileInfo.Add("FILE_SIZE", fileSize);
            resultFileInfo.Add("FILE_PATH", path);

            return resultFileInfo;
        }


        public TypeDictionary<string, string> upload(HttpPostedFileBase f, string folderName, int fileType = 0)
        {
            try
            {
                if (f == null || f.ContentLength < 1)
                    return null;

                var directory = Path.Combine(_localPath, folderName);
                if (!Directory.Exists(directory))
                {
                    Directory.CreateDirectory(directory);
                }
                var original = Path.GetFileName(f.FileName);
                var stored = getRandomString() + Path.GetExtension(f.FileName);
                var fileSize = f.ContentLength.ToString();
                var path = Path.Combine(directory, stored);

                f.SaveAs(path);

                TypeDictionary<string, string> file = new TypeDictionary<string, string> {
                    { "ORIGINAL_FILE_NAME", original},
                    { "STORED_FILE_NAME", stored},
                    { "FILE_SIZE", fileSize },
                    { "FILE_PATH", path},
                };

                return file;
            }
            catch (Exception e)
            {
                LogUtil.Error(e.ToString());
                return null;
            }
        }
    }
}