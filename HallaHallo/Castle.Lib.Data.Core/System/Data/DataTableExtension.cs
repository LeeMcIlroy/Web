// Decompiled with JetBrains decompiler
// Type: System.Data.DataTableExtension
// Assembly: Castle.Lib.Data.Core, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 27E9C49E-74A4-4958-A484-30DAD04DD134
// Assembly location: D:\Halla\Hallo\HallaTube\Common.Config\bin\Debug\Castle.Lib.Data.Core.dll

using System.Collections.Generic;
using System.Reflection;

namespace System.Data
{
  public static class DataTableExtension
  {
    public static DataRow GetUniqueResult(DataTable dt)
    {
      if (dt.Rows.Count == 0)
        throw new ApplicationException("결과가 없습니다.");
      if (dt.Rows.Count > 1)
        throw new ApplicationException("결과가 여러개 입니다.");
      return dt.Rows[0];
    }

    public static DataRow GetUniqueRowForDataTable(object data)
    {
      DataSet dataSet = data as DataSet;
      DataTable dataTable = data as DataTable;
      if (dataSet != null)
      {
        if (dataSet.Tables.Count == 0)
          return (DataRow) null;
        dataTable = dataSet.Tables[0];
      }
      if (dataTable == null)
        return (DataRow) null;
      return dataTable.Rows.Count == 0 ? (DataRow) null : dataTable.Rows[0];
    }

    public static DataRow GetUniqueRow(this DataTable dt) => DataTableExtension.GetUniqueRowForDataTable((object) dt);

    public static List<T> GetEntityList<T>(this DataTable dt)
    {
      List<T> objList = new List<T>(dt.Rows.Count);
      if (dt != null)
      {
        foreach (DataRow row in (InternalDataCollectionBase) dt.Rows)
          objList.Add(row.GetEntity<T>());
      }
      return objList;
    }

    public static Dictionary<string, T> GetEntityDictionary<T>(this DataTable dt)
    {
      Dictionary<string, T> dictionary = new Dictionary<string, T>(dt.Rows.Count);
      Type type = typeof (T);
      PropertyInfo propertyInfo = (PropertyInfo) null;
      string des = string.Empty;
      foreach (PropertyInfo property in type.GetProperties())
      {
        if (property.GetCustomAttributes(typeof (PrimaryKeyAttribute), false).Length != 0)
        {
          propertyInfo = property;
          object[] customAttributes = property.GetCustomAttributes(typeof (ColumnNameAttribute), false);
          if (customAttributes.Length != 0)
            des = (customAttributes[0] as ColumnNameAttribute).ColumnName;
        }
      }
      if (propertyInfo == (PropertyInfo) null)
        throw new Exception(type.ToString() + "에 대한 PK 속성을 확인 할 수 없습니다.");
      string columnName = string.Empty;
      foreach (DataColumn column in (InternalDataCollectionBase) dt.Columns)
      {
        if (column.ColumnName.IsDataNameMatch(propertyInfo.Name) || column.ColumnName.IsDataNameMatch(des))
          columnName = column.ColumnName;
      }
      if (string.IsNullOrEmpty(columnName))
        throw new Exception("TYPE:" + type.ToString() + " 의 PK:" + propertyInfo.Name + " 에 대한 데이터 매칭이 없습니다.");
      if (dt != null)
      {
        foreach (DataRow row in (InternalDataCollectionBase) dt.Rows)
        {
          string key = row[columnName].ToString();
          if (dictionary.ContainsKey(key))
            throw new Exception("TYPE:" + type.ToString() + ", 의 PK:" + propertyInfo.Name + "에 중복데이터가 있습니다.\r\n중복값:" + (object) dictionary[key]);
          dictionary.Add(key, row.GetEntity<T>());
        }
      }
      return dictionary;
    }

    public static T GetEntity<T>(this DataTable dt) => dt.GetUniqueRow().GetEntity<T>();
  }
}
