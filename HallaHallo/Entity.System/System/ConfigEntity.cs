using System;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Data;

namespace HallaTube
{
	[EmptyModel]
	public class ConfigEntity : DataEntity
	{
		[Required,PrimaryKey]
		[SQLDataType(SqlDbType.VarChar),StringLength(50)]
		[Description("구성 아이디")]
		[ColumnName("CONFIG_ID")]
		public string ConfigID { set; get; }

		[SQLDataType(SqlDbType.VarChar),StringLength(100)]
        [Description("구성 값")]
		[ColumnName("VALUE")]
		public string Value { set; get; }

		[SQLDataType(SqlDbType.DateTime)]
		[ColumnName("REG_DATE")]
		public DateTime RegDate { set; get; }

	}
}
