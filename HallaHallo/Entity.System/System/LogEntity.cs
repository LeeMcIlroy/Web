using System;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Data;

namespace HallaTube
{
	[EmptyModel]
	public class LogEntity : DataEntity
	{
		[Required,PrimaryKey]
		[SQLDataType(SqlDbType.Char),StringLength(12)]
		[ColumnName("LOG_ID")]
		public string LogID { set; get; }

		[SQLDataType(SqlDbType.VarChar),StringLength(50)]
		[ColumnName("SESSION_ID")]
		public string SessionID { set; get; }

		[SQLDataType(SqlDbType.VarChar),StringLength(50)]
		[ColumnName("USER_ID")]
		public string UserID { set; get; }

		[SQLDataType(SqlDbType.VarChar),StringLength(50)]
		[ColumnName("USER_IP")]
		public string UserIp { set; get; }

		[SQLDataType(SqlDbType.VarChar),StringLength(50)]
		[ColumnName("HOST")]
		public string Host { set; get; }

		[SQLDataType(SqlDbType.VarChar),StringLength(250)]
		[ColumnName("URL")]
		public string Url { set; get; }

		[SQLDataType(SqlDbType.VarChar),StringLength(50)]
		[ColumnName("CONTROLLER")]
		public string Controller { set; get; }

		[SQLDataType(SqlDbType.VarChar),StringLength(50)]
		[ColumnName("ACTION")]
		public string Action { set; get; }

		[SQLDataType(SqlDbType.VarChar),StringLength(50)]
		[ColumnName("TARGET_ID")]
		public string TargetID { set; get; }

		[SQLDataType(SqlDbType.DateTime)]
		[ColumnName("REQUEST_DATE")]
		public DateTime RequestDate { set; get; }
        public DateTime LocalDate { set; get; }

        [SQLDataType(SqlDbType.Char),StringLength(1)]
		[ColumnName("BEGIN_IS")]
		public string BeginIs { set; get; }

		[SQLDataType(SqlDbType.Char),StringLength(1)]
		[ColumnName("END_IS")]
		public string EndIs { set; get; }

		[SQLDataType(SqlDbType.VarChar)]
		[ColumnName("HTTP_USER_AGENT")]
		public string HttpUserAgent { set; get; }

		[SQLDataType(SqlDbType.VarChar),StringLength(250)]
		[ColumnName("HTTP_REFERER")]
		public string HttpReferer { set; get; }

		[SQLDataType(SqlDbType.VarChar),StringLength(50)]
		[ColumnName("HTTP_REFERER_HOST")]
		public string HttpRefererHost { set; get; }

		[SQLDataType(SqlDbType.VarChar),StringLength(50)]
		[ColumnName("USER_NM")]
		public string UserNm { set; get; }

		[SQLDataType(SqlDbType.VarChar),StringLength(50)]
		[ColumnName("EMP_NO")]
		public string EmpNo { set; get; }

		[SQLDataType(SqlDbType.VarChar),StringLength(50)]
		[ColumnName("USER_EMAIL")]
		public string UserEmail { set; get; }

		[SQLDataType(SqlDbType.VarChar),StringLength(50)]
		[ColumnName("USER_GRADE_ID")]
		public string UserGradeID { set; get; }

		[SQLDataType(SqlDbType.VarChar),StringLength(50)]
		[ColumnName("USER_GRADE_NM")]
		public string UserGradeNm { set; get; }

		[SQLDataType(SqlDbType.VarChar),StringLength(50)]
		[ColumnName("USER_POSITION_ID")]
		public string UserPositionID { set; get; }

		[SQLDataType(SqlDbType.VarChar),StringLength(50)]
		[ColumnName("USER_POSITION_NM")]
		public string UserPositionNm { set; get; }

		[SQLDataType(SqlDbType.VarChar),StringLength(50)]
		[ColumnName("USER_COMP_ID")]
		public string UserCompID { set; get; }

		[SQLDataType(SqlDbType.VarChar),StringLength(50)]
		[ColumnName("USER_COMP_NM")]
		public string UserCompNm { set; get; }

		[SQLDataType(SqlDbType.VarChar),StringLength(50)]
		[ColumnName("USER_DEPT_ID")]
		public string UserDeptID { set; get; }

		[SQLDataType(SqlDbType.VarChar),StringLength(50)]
		[ColumnName("USER_DEPT_NM")]
		public string UserDeptNm { set; get; }

		[SQLDataType(SqlDbType.VarChar),StringLength(250)]
		[ColumnName("USER_DEPT_PATH")]
		public string UserDeptPath { set; get; }

        [SQLDataType(SqlDbType.VarChar), StringLength(50)]
        [ColumnName("CONNECT_PATH")]
        public string ConnectPath { set; get; }// = "ÇÑ¸¶·ç";
        
    }
}
