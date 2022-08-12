using System;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Data;

namespace HallaTube
{
	[EmptyModel]
	public class ArticleSectionEntity : DataEntity
	{
        [Required, PrimaryKey]
        [SQLDataType(SqlDbType.Char), StringLength(12)]
        [ColumnName("SECTION_ID")]
        public string SectionID { set; get; }

        [Required]
		[SQLDataType(SqlDbType.Char),StringLength(12)]
		[ColumnName("ARTICLE_ID")]
		public string ArticleID { set; get; }

		[Required]
		[SQLDataType(SqlDbType.VarChar),StringLength(50)]
		[ColumnName("SECTION_CODE")]
		public string SectionCode { set; get; }

		[SQLDataType(SqlDbType.Int)]
		[ColumnName("EXIST_VIEW_COUNT")]
		public int ExistViewCount { set; get; }

		[SQLDataType(SqlDbType.DateTime)]
		[ColumnName("REG_DATE")]
		public DateTime RegDate { set; get; }

	}
}
