using System;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Data;

namespace HallaTube
{
	[EmptyModel]
	public class ArticleEntity : DataEntity
	{
		[Required,PrimaryKey]
		[SQLDataType(SqlDbType.Char),StringLength(12)]
		[Description("게시물ID")]
		[ColumnName("ARTICLE_ID")]
		public string ArticleID { set; get; }

		[SQLDataType(SqlDbType.Char),StringLength(12)]
		[ColumnName("GROUP_ID")]
		public string GroupID { set; get; }

		[SQLDataType(SqlDbType.Int)]
		[ColumnName("ARTICLE_LEVEL")]
		public int ArticleLevel { set; get; }

		[SQLDataType(SqlDbType.VarChar),StringLength(20)]
		[Description("게시판코드")]
		[ColumnName("BOARD_CODE")]
		public string BoardCode { set; get; }

		[SQLDataType(SqlDbType.VarChar),StringLength(20)]
		[ColumnName("CATEGORY_CODE")]
		public string CategoryCode { set; get; }

		[SQLDataType(SqlDbType.VarChar),StringLength(20)]
		[ColumnName("ARTICLE_TYPE")]
		public string ArticleType { set; get; }

		[SQLDataType(SqlDbType.NVarChar),StringLength(250)]
		[Description("제목")]
		[ColumnName("TITLE")]
		public string Title { set; get; }

		[SQLDataType(SqlDbType.NText)]
		[Description("내용")]
		[ColumnName("BODY")]
		public string Body { set; get; }

		[SQLDataType(SqlDbType.NChar),StringLength(500)]
		[ColumnName("SUMMARY")]
		public string Summary { set; get; }

        [SQLDataType(SqlDbType.NChar), StringLength(500)]
        [ColumnName("HASHTAG")]
        public string Hashtag { set; get; }

        [SQLDataType(SqlDbType.VarChar),StringLength(50)]
		[ColumnName("MASTER_ID")]
		public string MasterID { set; get; }

		[SQLDataType(SqlDbType.VarChar),StringLength(50)]
		[Description("작성자")]
		[ColumnName("REG_ID")]
		public string RegID { set; get; }

		[SQLDataType(SqlDbType.DateTime)]
		[Description("작성일")]
		[ColumnName("REG_DATE")]
		public DateTime RegDate { set; get; }

		[SQLDataType(SqlDbType.DateTime)]
		[ColumnName("START_DATE")]
		public DateTime StartDate { set; get; }

		[SQLDataType(SqlDbType.DateTime)]
		[ColumnName("END_DATE")]
		public DateTime EndDate { set; get; }

		[SQLDataType(SqlDbType.VarChar),StringLength(20)]
		[Description("상태코드")]
		[ColumnName("STATE")]
		public string State { set; get; }

		[SQLDataType(SqlDbType.Char),StringLength(1)]
		[ColumnName("IS_NOTICE")]
		public string IsNotice { set; get; }

		[SQLDataType(SqlDbType.Int)]
		[ColumnName("VIEW_COUNT")]
		public int ViewCount { set; get; }

		[SQLDataType(SqlDbType.Int)]
		[ColumnName("COMMENT_COUNT")]
		public int CommentCount { set; get; }

		[SQLDataType(SqlDbType.Int)]
		[ColumnName("LIKE_COUNT")]
		public int LikeCount { set; get; }

		[SQLDataType(SqlDbType.Int)]
		[ColumnName("SHARE_COUNT")]
		public int ShareCount { set; get; }

		[SQLDataType(SqlDbType.Char),StringLength(1)]
		[Description("삭제여부")]
		[ColumnName("IS_DEL")]
		public string IsDel { set; get; }

        [SQLDataType(SqlDbType.NVarChar), StringLength(100)]
        [ColumnName("USER_KORNM")]
        public string UserKornm { set; get; }

        [SQLDataType(SqlDbType.NVarChar), StringLength(100)]
        [ColumnName("USER_ENGNM")]
        public string UserEngnm { set; get; }

        [SQLDataType(SqlDbType.NVarChar), StringLength(100)]
        [ColumnName("USER_CHNNM")]
        public string UserChnnm { set; get; }

        public string ThumbPath { set; get; }

        public string SectionID { set; get; }
        public string SectionCode { set; get; }
        public int ExistViewCount { set; get; }
        public DateTime SetDate { set; get; }
    }
}
