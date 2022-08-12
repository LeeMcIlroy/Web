using System;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Data;

namespace HallaTube
{
	[EmptyModel]
	public class AlarmEntity : DataEntity
	{
		[Required,PrimaryKey]
		[SQLDataType(SqlDbType.Char),StringLength(12)]
		[ColumnName("ALARM_ID")]
		public string AlarmID { set; get; }

		[SQLDataType(SqlDbType.VarChar),StringLength(20)]
		[ColumnName("ALARM_TYPE")]
		public string AlarmType { set; get; }

		[SQLDataType(SqlDbType.VarChar),StringLength(20)]
		[ColumnName("ARTICLE_CATEGORY")]
		public string ArticleCategory { set; get; }

		[SQLDataType(SqlDbType.VarChar),StringLength(20)]
		[ColumnName("ARTICLE_TITLE")]
		public string ArticleTitle { set; get; }

		[SQLDataType(SqlDbType.VarChar),StringLength(50)]
		[ColumnName("TARGET_ID")]
		public string TargetID { set; get; }

		[SQLDataType(SqlDbType.NVarChar),StringLength(100)]
		[ColumnName("USER_KORNM")]
		public string UserKornm { set; get; }

		[SQLDataType(SqlDbType.NVarChar),StringLength(100)]
		[ColumnName("USER_ENGNM")]
		public string UserEngnm { set; get; }

		[SQLDataType(SqlDbType.NVarChar),StringLength(100)]
		[ColumnName("USER_CHNNM")]
		public string UserChnnm { set; get; }

		[SQLDataType(SqlDbType.VarChar),StringLength(20)]
		[ColumnName("ALARM_STATE")]
		public string AlarmState { set; get; }

		[SQLDataType(SqlDbType.VarChar),StringLength(50)]
		[ColumnName("REG_ID")]
		public string RegID { set; get; }

		[SQLDataType(SqlDbType.DateTime)]
		[ColumnName("REG_DATE")]
		public DateTime RegDate { set; get; }

	}
}
