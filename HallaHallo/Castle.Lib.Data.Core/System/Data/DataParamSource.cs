// Decompiled with JetBrains decompiler
// Type: System.Data.DataParamSource
// Assembly: Castle.Lib.Data.Core, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 27E9C49E-74A4-4958-A484-30DAD04DD134
// Assembly location: D:\Halla\Hallo\HallaTube\Common.Config\bin\Debug\Castle.Lib.Data.Core.dll

using System.Reflection;

namespace System.Data
{
  public class DataParamSource
  {
    public string ColumnName { set; get; }

    public string Name { set; get; }

    public object Value { set; get; }

    public PropertyInfo ValueProperty { set; get; }

    public object ValueSourceObject { set; get; }

    public SQLDataType Type { set; get; }
  }
}
