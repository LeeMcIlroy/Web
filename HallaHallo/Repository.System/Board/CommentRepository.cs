
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Transactions;

using Castle.Data;

namespace HallaTube
{
    public class CommentRepository : DataRepository
    {

        public List<CommentEntity> GetList(SearchModel search, bool containCount = true)
        {
            search.SetSort();

            int start = (search.PageNumber - 1) * search.PageSize;
            int end = search.PageNumber * search.PageSize;

            search.EndDate = search.EndDate.AddDays(1);

            DataCommand command = GetCommand("Comment.GetList", search, new { IsCount = false, RowStart = start, RowEnd = end });
            var list = command.ExecuteDataTable().GetEntityList<CommentEntity>();

            if (containCount)
            {
                command = GetCommand("Comment.GetList", search, new { IsCount = true });
                object rtn = command.ExecuteScalar();
                search.TotalCount = long.Parse(rtn.ToString());
            }

            search.EndDate = search.EndDate.AddDays(-1);

            return list;
        }

        public List<FileEntity> GetFileList(SearchModel search, bool containCount = true)
        {
            int start = (search.PageNumber - 1) * search.PageSize;
            int end = search.PageNumber * search.PageSize;

            DataCommand command = GetCommand("Comment.GetFileList", search, new { IsCount = false, RowStart = start, RowEnd = end });
            return command.ExecuteDataTable().GetEntityList<FileEntity>();
        }

        public void Create(CommentEntity comment)
        {
            using (var scope = new TransactionScope(TransactionScopeOption.Required, tranOption, EnterpriseServicesInteropOption.None))
            {
                ExecuteNonQuery("Comment.Create", comment);
                scope.Complete();
            }
        }

        public CommentEntity Get(string commentID)
        {
            return ExecuteDataRow("Comment.Get", new { commentID }).GetEntity<CommentEntity>();
        }
       
        public void Update(CommentEntity comment)
        {
            using (var scope = new TransactionScope(TransactionScopeOption.Required, tranOption, EnterpriseServicesInteropOption.None))
            {
                ExecuteNonQuery("Comment.Update", comment);
                scope.Complete();
            }
        }

        public void Delete(string commentID)
        {
            using (var scope = new TransactionScope(TransactionScopeOption.Required, tranOption, EnterpriseServicesInteropOption.None))
            {
                var exist = Get(commentID);

                if (ExecuteNonQuery("Comment.Delete", new { commentID }) > 0)
                {
                    ExecuteNonQuery("Article.DecreaseCommentCount", exist);
                }
                scope.Complete();
            }
        }

        private AlarmEntity PrepareAlarmEntity(ArticleEntity article, CommentEntity comment)
        {
            return new AlarmEntity
            {
                AlarmID = Sequence.Generate(),
                ArticleCategory= article.CategoryCode,
                ArticleTitle= article.Title,
                TargetID = article.ArticleID,
                RegDate = DateTime.UtcNow,

                UserKornm = comment.CreateKornm,
                UserEngnm = comment.CreateEngnm,
                UserChnnm = comment.CreateChnnm,
                AlarmState ="Ready"
            };

        }

        public void Set(CommentEntity comment, List<FileEntity> files, List<string> delFiles, UserModel user)
        {
            bool create = string.IsNullOrEmpty(comment.CommentID);

            //comment.Body += "<script>asdfasdfasdf\nsdfasdfasdf<script>";
            comment.Body = Method.RemoveIlligalTag(comment.Body.Trim());

            using (var scope = new TransactionScope(TransactionScopeOption.Required, tranOption, EnterpriseServicesInteropOption.None))
            {
                if (create)
                {
                    var article = ExecuteDataRow("Article.Get", comment).GetEntity<ArticleEntity>();

                    comment.CommentID = Sequence.Generate();
                    if (string.IsNullOrEmpty(comment.GroupID))
                    {
                        comment.GroupID = comment.CommentID;
                    }
                    else
                    {
                        comment.CommentLevel = 1;
                    }

                    comment.CreateID = user.UserId;
                    comment.CreateKornm = user.UserKornm;
                    comment.CreateEngnm = user.UserEngnm;
                    comment.CreateChnnm = user.UserChnnm;
                    comment.CreateDept = user.DeptID;
                    comment.CreateDate = DateTime.UtcNow;
                    comment.CreatePhoto = user.User.Photo;

                    if(ExecuteNonQuery("Comment.Create", comment) > 0)
                    {
                        ExecuteNonQuery("Article.IncreaseCommentCount", comment);

                        //자기가 쓴 댓글
                        //xxx 글에 댓글을 작성하였습니다.
                        {
                            var alarm = PrepareAlarmEntity(article, comment);
                            alarm.AlarmType = "Self";
                            alarm.RegID = comment.CreateID;
                            

                            ExecuteNonQuery("Alarm.Create", alarm);
                        }


                        //자신이 쓴 글에 대한 타인의 댓글
                        //xxx 글에 xxx님이 댓글을 작성하였습니다.
                        if (article.RegID!= comment.CreateID)
                        {
                            var alarm = PrepareAlarmEntity(article, comment);
                            alarm.AlarmType = "Comment";
                            alarm.RegID = article.RegID;

                            ExecuteNonQuery("Alarm.Create", alarm);
                        }

                        //자신이 쓴 댓글에 대한 타인의 댓글
                        //xxx 글의 댓글에 xxx님이 답글을 작성하였습니다.
                        if (!string.IsNullOrEmpty(comment.GroupID))
                        {
                            var srcComment = ExecuteDataRow("Comment.Get", new { commentID= comment.GroupID }).GetEntity<CommentEntity>();
                            if(srcComment.CreateID!= comment.CreateID)
                            {
                                var alarm = PrepareAlarmEntity(article, comment);
                                alarm.AlarmType = "Reply";
                                alarm.RegID = srcComment.CreateID;

                                ExecuteNonQuery("Alarm.Create", alarm);
                            }
                        }
                    }
                }
                else
                {
                    ExecuteNonQuery("Comment.Update", comment);
                }


                foreach(string fileID in delFiles)
                {
                    ExecuteNonQuery("File.Delete", new { fileID });
                }

                foreach (var item in files)
                {
                    item.FileID = Sequence.Generate();
                    item.ObjectID = comment.CommentID;
                    item.RegDate = DateTime.UtcNow;
                    item.TempPath = item.Path;
                    item.Path = Config.GetFileTypePath(item.ObjectType, item.FileID, item.Extension, item.RegDate, bMapPath: false);

                    ExecuteNonQuery("File.Create", item);
                }

                scope.Complete();
            }

            foreach (var item in files)
            {
                string tempPath = Config.GetPath(item.TempPath);
                if (System.IO.File.Exists(tempPath))
                {
                    System.IO.File.Move(tempPath, Config.GetPath(item.Path));
                }

            }

        }
    }
}
