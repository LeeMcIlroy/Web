// Decompiled with JetBrains decompiler
// Type: System.ObjectDataExtension
// Assembly: Castle.Lib.Data.Core, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 27E9C49E-74A4-4958-A484-30DAD04DD134
// Assembly location: D:\Halla\Hallo\HallaTube\Common.Config\bin\Debug\Castle.Lib.Data.Core.dll

using System.Data;
using System.Text;

namespace System
{
  public static class ObjectDataExtension
  {
    public static string ToJSON(this object data)
    {
      StringBuilder stringBuilder;
      try
      {
        DataSet dataSet = data as DataSet;
        DataTable table1 = data as DataTable;
        if (dataSet != null)
        {
          stringBuilder = new StringBuilder();
          stringBuilder.Append("({");
          foreach (DataTable table2 in (InternalDataCollectionBase) dataSet.Tables)
          {
            stringBuilder.AppendFormat("\"{0}\":", (object) table2.TableName);
            stringBuilder.Append((object) ObjectDataExtension.GetTableData(table2));
            stringBuilder.Append(",\n");
          }
          stringBuilder.Remove(stringBuilder.Length - 2, 2);
          stringBuilder.Append("})");
        }
        else if (table1 != null)
        {
          stringBuilder = ObjectDataExtension.GetTableData(table1);
        }
        else
        {
          stringBuilder = new StringBuilder();
          stringBuilder.AppendFormat("{{ _Scalar:\"{0}\"}}\n", data);
        }
      }
      catch (Exception ex)
      {
        stringBuilder = new StringBuilder();
        stringBuilder.AppendFormat("{{ _SystemError:\"{0}\n{1}\"}}\n", (object) ex.Message, (object) ex.StackTrace);
      }
      return stringBuilder.ToString();
    }

    public static StringBuilder GetTableData(DataTable table)
    {
      StringBuilder stringBuilder = new StringBuilder(table.Rows.Count * table.Columns.Count * 10);
      stringBuilder.Append("[");
      for (int index1 = 0; index1 < table.Rows.Count; ++index1)
      {
        DataRow row = table.Rows[index1];
        stringBuilder.Append("({");
        for (int index2 = 0; index2 < table.Columns.Count; ++index2)
        {
          DataColumn column = table.Columns[index2];
          stringBuilder.AppendFormat("\"{0}\":\"{1}\"", (object) column.ColumnName, (object) ObjectDataExtension.Escape(row[column.ColumnName]));
          if (index2 < table.Columns.Count - 1)
            stringBuilder.Append(",");
        }
        stringBuilder.Append("})");
        if (index1 < table.Rows.Count - 1)
          stringBuilder.Append(",");
        stringBuilder.Append("\n");
      }
      stringBuilder.Append("]");
      return stringBuilder;
    }

    public static string Escape(object str)
    {
      StringBuilder stringBuilder = new StringBuilder(str.ToString());
      stringBuilder.Replace("\\", "\\\\").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\\n").Replace("'", "\\'").Replace("\"", "\\\"");
      return stringBuilder.ToString();
    }
  }
}
