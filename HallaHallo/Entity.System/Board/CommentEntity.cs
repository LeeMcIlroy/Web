using System;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Data;

namespace HallaTube
{
	[EmptyModel]
	public class CommentEntity : DataEntity
	{
		[Required,PrimaryKey]
		[SQLDataType(SqlDbType.Char),StringLength(12)]
		[ColumnName("COMMENT_ID")]
		public string CommentID { set; get; }

		[SQLDataType(SqlDbType.Char),StringLength(12)]
		[ColumnName("ARTICLE_ID")]
		public string ArticleID { set; get; }

		[SQLDataType(SqlDbType.Char),StringLength(12)]
		[ColumnName("GROUP_ID")]
		public string GroupID { set; get; }

		[SQLDataType(SqlDbType.Int)]
		[ColumnName("COMMENT_LEVEL")]
		public int CommentLevel { set; get; }

		[SQLDataType(SqlDbType.NVarChar)]
		[ColumnName("BODY")]
		public string Body { set; get; }

		[SQLDataType(SqlDbType.VarChar),StringLength(50)]
		[ColumnName("CREATE_ID")]
		public string CreateID { set; get; }

		[SQLDataType(SqlDbType.NVarChar),StringLength(50)]
		[ColumnName("CREATE_KORNM")]
		public string CreateKornm { set; get; }

        [SQLDataType(SqlDbType.NVarChar), StringLength(50)]
        [ColumnName("CREATE_ENGNM")]
        public string CreateEngnm { set; get; }

        [SQLDataType(SqlDbType.NVarChar), StringLength(50)]
        [ColumnName("CREATE_CHNNM")]
        public string CreateChnnm { set; get; }

        public string GetName(string lang)
        {
            return this[$"CREATE_{lang}NM"] as string;
        }

        [SQLDataType(SqlDbType.NVarChar), StringLength(50)]
        [ColumnName("CREATE_DEPT")]
        public string CreateDept { set; get; }

        [SQLDataType(SqlDbType.DateTime)]
		[ColumnName("CREATE_DATE")]
		public DateTime CreateDate { set; get; }

        [SQLDataType(SqlDbType.Char), StringLength(1)]
        [ColumnName("IS_SECRET")]
        public string IsSecret { set; get; }

        [SQLDataType(SqlDbType.VarChar), StringLength(100)]
        [ColumnName("CREATE_PHOTO")]
        public string CreatePhoto { set; get; }
        
    }
}
