// Decompiled with JetBrains decompiler
// Type: Castle.Data.DataParameter
// Assembly: Castle.Lib.Data.Core, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 27E9C49E-74A4-4958-A484-30DAD04DD134
// Assembly location: D:\Halla\Hallo\HallaTube\Common.Config\bin\Debug\Castle.Lib.Data.Core.dll

using System;
using System.Data;

namespace Castle.Data
{
  [Serializable]
  public class DataParameter : MarshalByRefObject
  {
    public string ParameterName { set; get; }

    public Type Type { set; get; }

    public SqlDbType? SqlType { set; get; }

    public DataParameterDirection Direction { set; get; }

    public object Value { set; get; }

    public int Size { set; get; }

    public override string ToString() => this.Value.ToString();
  }
}
