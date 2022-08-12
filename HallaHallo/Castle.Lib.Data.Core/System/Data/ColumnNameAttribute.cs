// Decompiled with JetBrains decompiler
// Type: System.Data.ColumnNameAttribute
// Assembly: Castle.Lib.Data.Core, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 27E9C49E-74A4-4958-A484-30DAD04DD134
// Assembly location: D:\Halla\Hallo\HallaTube\Common.Config\bin\Debug\Castle.Lib.Data.Core.dll

namespace System.Data
{
  [AttributeUsage(AttributeTargets.Property, AllowMultiple = false, Inherited = true)]
  public sealed class ColumnNameAttribute : Attribute
  {
    public string ColumnName { set; get; }

    public ColumnNameAttribute(string columnName) => this.ColumnName = columnName;
  }
}
