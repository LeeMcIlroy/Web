// Decompiled with JetBrains decompiler
// Type: System.Data.DataSetExtension
// Assembly: Castle.Lib.Data.Core, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 27E9C49E-74A4-4958-A484-30DAD04DD134
// Assembly location: D:\Halla\Hallo\HallaTube\Common.Config\bin\Debug\Castle.Lib.Data.Core.dll

using System.Collections.Generic;

namespace System.Data
{
  public static class DataSetExtension
  {
    public static DataRow GetUniqueRow(this DataSet ds) => ds.Tables.Count == 0 ? (DataRow) null : ds.Tables[0].GetUniqueRow();

    public static List<T> GetEntityList<T>(this DataSet ds) => ds.Tables.Count == 0 ? new List<T>(0) : ds.Tables[0].GetEntityList<T>();

    public static T GetEntity<T>(this DataSet ds) => ds.Tables.Count == 0 ? default (T) : ds.Tables[0].GetEntity<T>();
  }
}
