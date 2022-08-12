using System;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Data;

namespace HallaTube
{
	[EmptyModel]
	public class FileEntity : DataEntity
	{
		[Required,PrimaryKey]
		[SQLDataType(SqlDbType.Char),StringLength(12)]
		[Description("파일ID")]
		[ColumnName("FILE_ID")]
		public string FileID { set; get; }

		[Required]
		[SQLDataType(SqlDbType.Char),StringLength(12)]
		[Description("파일소유 개체ID")]
		[ColumnName("OBJECT_ID")]
		public string ObjectID { set; get; }

		[Required]
		[SQLDataType(SqlDbType.VarChar),StringLength(20)]
		[Description("파일소유 개체형태")]
		[ColumnName("OBJECT_TYPE")]
		public string ObjectType { set; get; }

		[Required]
		[SQLDataType(SqlDbType.NVarChar),StringLength(250)]
		[Description("파일명")]
		[ColumnName("FILE_NM")]
		public string FileNm { set; get; }

		[Required]
		[SQLDataType(SqlDbType.VarChar),StringLength(250)]
		[Description("파일경로, 가상경로")]
		[ColumnName("PATH")]
		public string Path { set; get; }

        [Required]
		[SQLDataType(SqlDbType.VarChar),StringLength(20)]
		[Description("확장자")]
		[ColumnName("EXTENSION")]
		public string Extension { set; get; }

		[Required]
		[SQLDataType(SqlDbType.Int)]
		[Description("크기")]
		[ColumnName("SIZE")]
		public long Size { set; get; }

		[Required]
		[SQLDataType(SqlDbType.DateTime)]
		[Description("등록일")]
		[ColumnName("REG_DATE")]
		public DateTime RegDate { set; get; }

        [ReflectionType("NoUserInput")]
        public string TempPath { set; get; }

        [SQLDataType(SqlDbType.Int)]
        [Description("순서")]
        [ColumnName("FILE_ORDER")]
        public int FileOrder { set; get; }
    }
}
