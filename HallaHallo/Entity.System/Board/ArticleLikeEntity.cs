using System;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Data;

namespace HallaTube
{
	[EmptyModel]
	public class ArticleLikeEntity : DataEntity
	{
		[Required,PrimaryKey]
		[SQLDataType(SqlDbType.Char),StringLength(12)]
		[ColumnName("LIKE_ID")]
		public string LikeID { set; get; }

		[SQLDataType(SqlDbType.Char),StringLength(12)]
		[ColumnName("ARTICLE_ID")]
		public string ArticleID { set; get; }

		[SQLDataType(SqlDbType.VarChar),StringLength(50)]
		[ColumnName("REG_ID")]
		public string RegID { set; get; }

		[SQLDataType(SqlDbType.DateTime)]
		[ColumnName("REG_DATE")]
		public DateTime RegDate { set; get; }

	}
}
