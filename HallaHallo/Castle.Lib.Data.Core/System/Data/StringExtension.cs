// Decompiled with JetBrains decompiler
// Type: System.Data.StringExtension
// Assembly: Castle.Lib.Data.Core, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 27E9C49E-74A4-4958-A484-30DAD04DD134
// Assembly location: D:\Halla\Hallo\HallaTube\Common.Config\bin\Debug\Castle.Lib.Data.Core.dll

using System.Text.RegularExpressions;

namespace System.Data
{
  public static class StringExtension
  {
    private const char splitor = '㏂';
    private const string esca = "㏘";

    public static DataTable ToDataTable(this string json)
    {
      if (json == null)
        return (DataTable) null;
      json = json.Trim();
      if (!json.StartsWith("[") || !json.EndsWith("]"))
        return (DataTable) null;
      json = json.Trim('[', ']');
      DataTable dataTable = new DataTable();
      foreach (Capture match in Regex.Matches(json, "{[^}]*}"))
      {
        string str1 = match.Value;
        if (str1.StartsWith("{") && str1.EndsWith("}"))
        {
          MatchCollection matchCollection = Regex.Matches(str1.Trim('{', '}').Replace("\\\"", "㏘"), "\"[^\"]*\":\"[^\"]*\"");
          if (dataTable.Columns.Count == 0)
          {
            foreach (Capture capture in matchCollection)
            {
              string[] strArray = capture.Value.Replace("\":\"", '㏂'.ToString()).Split('㏂');
              if (strArray.Length == 2)
              {
                string columnName = strArray[0].Trim('"');
                dataTable.Columns.Add(columnName);
              }
            }
          }
          DataRow row = dataTable.NewRow();
          foreach (Capture capture in matchCollection)
          {
            string[] strArray = capture.Value.Replace("\":\"", '㏂'.ToString()).Split('㏂');
            if (strArray.Length == 2)
            {
              string str2 = strArray[0].Trim('"');
              string str3 = strArray[1].Trim('"');
              if (dataTable.Columns.Contains(str2))
                row[str2] = (object) Regex.Unescape(str3.Replace("㏘", "\\\""));
            }
          }
          dataTable.Rows.Add(row);
        }
      }
      return dataTable;
    }

    public static bool IsDataNameMatch(this string src, string des) => des != null && src.Replace("_", string.Empty).Equals(des.Replace("_", string.Empty), StringComparison.OrdinalIgnoreCase);
  }
}
