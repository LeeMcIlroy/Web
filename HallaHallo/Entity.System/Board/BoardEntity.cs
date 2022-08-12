using System;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Data;

namespace HallaTube
{
	[EmptyModel]
	public class BoardEntity : DataEntity
	{
		[Required,PrimaryKey]
		[SQLDataType(SqlDbType.Char),StringLength(12)]
		[ColumnName("BOARD_ID")]
		public string BoardID { set; get; }

		[SQLDataType(SqlDbType.VarChar),StringLength(20)]
		[ColumnName("BOARD_CODE")]
		public string BoardCode { set; get; }

		[SQLDataType(SqlDbType.VarChar),StringLength(50)]
		[ColumnName("BOARD_NM")]
		public string BoardNm { set; get; }

		[SQLDataType(SqlDbType.VarChar),StringLength(20)]
		[ColumnName("TYPE")]
		public string Type { set; get; }

		[SQLDataType(SqlDbType.VarChar),StringLength(50)]
		[ColumnName("VIEW_PATH")]
		public string ViewPath { set; get; }

		[SQLDataType(SqlDbType.VarChar),StringLength(20)]
		[ColumnName("TOP_MENU")]
		public string TopMenu { set; get; }

		[SQLDataType(SqlDbType.Char),StringLength(1)]
		[ColumnName("USE_LOGIN")]
		public string UseLogin { set; get; }

		[SQLDataType(SqlDbType.Char),StringLength(1)]
		[ColumnName("USE_PRIVATE")]
		public string UsePrivate { set; get; }

		[SQLDataType(SqlDbType.Char),StringLength(1)]
		[ColumnName("IS_DEL")]
		public string IsDel { set; get; }

	}
}
