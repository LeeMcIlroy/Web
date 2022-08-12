using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Data;

namespace HallaTube
{
	[EmptyModel]
	public class CategoryEntity : DataEntity
	{
		[Required,PrimaryKey]
		[SQLDataType(SqlDbType.Char),StringLength(12)]
		[Description("CATEGORY_ID")]
		[ColumnName("CATEGORY_ID")]
		public string CategoryID { set; get; }

		[Required]
		[SQLDataType(SqlDbType.VarChar),StringLength(20)]
		[Description("CATEGORY_TYPE")]
		[ColumnName("CATEGORY_TYPE")]
		public string CategoryType { set; get; }

		[Required]
		[SQLDataType(SqlDbType.VarChar),StringLength(20)]
		[Description("CATEGORY_CODE")]
		[ColumnName("CATEGORY_CODE")]
		public string CategoryCode { set; get; }

		[Required]
		[SQLDataType(SqlDbType.NVarChar),StringLength(100)]
		[Description("CATEGORY_NM")]
		[ColumnName("CATEGORY_KORNM")]
		public string CategoryKornm { set; get; }

		[SQLDataType(SqlDbType.NVarChar),StringLength(100)]
		[ColumnName("CATEGORY_ENGNM")]
		public string CategoryEngnm { set; get; }

		[SQLDataType(SqlDbType.NVarChar),StringLength(100)]
		[ColumnName("CATEGORY_CHNNM")]
		public string CategoryChnnm { set; get; }

		[SQLDataType(SqlDbType.NVarChar),StringLength(100)]
		[ColumnName("CATEGORY_ETCNM")]
		public string CategoryEtcnm { set; get; }


        public string GetName(string lang)
        {
            return this[$"CATEGORY_{lang}NM"] as string;
        }

        [Required]
		[SQLDataType(SqlDbType.Int)]
		[Description("CATEGORY_LEVEL")]
		[ColumnName("CATEGORY_LEVEL")]
		public int CategoryLevel { set; get; }

		[Required]
		[SQLDataType(SqlDbType.Int)]
		[Description("CATEGORY_ORDER")]
		[ColumnName("CATEGORY_ORDER")]
		public int CategoryOrder { set; get; }

		[SQLDataType(SqlDbType.VarChar),StringLength(20)]
		[ColumnName("FUNCTION_TYPE")]
		public string FunctionType { set; get; }

		[SQLDataType(SqlDbType.VarChar),StringLength(12)]
		[ColumnName("OBJECT_ID")]
		public string ObjectID { set; get; }

		[SQLDataType(SqlDbType.VarChar),StringLength(500)]
		[ColumnName("DATA")]
		public string Data { set; get; }

		[SQLDataType(SqlDbType.VarChar)]
		[ColumnName("DESCRIPTION")]
		public string Description { set; get; }

		[SQLDataType(SqlDbType.VarChar),StringLength(500)]
		[Description("PATH")]
		[ColumnName("PATH")]
		public string Path { set; get; }

		[Required]
		[SQLDataType(SqlDbType.Char),StringLength(12)]
		[Description("PARENT_ID")]
		[ColumnName("PARENT_ID")]
		public string ParentID { set; get; }

		[Required]
		[SQLDataType(SqlDbType.VarChar),StringLength(50)]
		[Description("REG_ID")]
		[ColumnName("REG_ID")]
		public string RegID { set; get; }

		[Required]
		[SQLDataType(SqlDbType.DateTime)]
		[Description("REG_DATE")]
		[ColumnName("REG_DATE")]
		public DateTime RegDate { set; get; }

		[Required]
		[SQLDataType(SqlDbType.Char),StringLength(1)]
		[Description("IS_DEL")]
		[ColumnName("IS_DEL")]
		public string IsDel { set; get; }

		[Required]
		[SQLDataType(SqlDbType.Char),StringLength(1)]
		[Description("IS_DISPLAY")]
		[ColumnName("IS_DISPLAY")]
		public string IsDisplay { set; get; }

        public bool Selected { set; get; }
        public string _ItemState { set; get; }
    }

    public static class ListCategoryEntityExtension
    {
        public static void SelectCategory(this List<CategoryEntity> category, string code)
        {
            foreach (var item in category)
            {
                if (item.CategoryID == code)
                {
                    item.Selected = true;
                    break;
                }
            }
        }
    }
}
