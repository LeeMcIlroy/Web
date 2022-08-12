// Decompiled with JetBrains decompiler
// Type: System.Data.IEntityDataRow
// Assembly: Castle.Lib.Data.Core, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 27E9C49E-74A4-4958-A484-30DAD04DD134
// Assembly location: D:\Halla\Hallo\HallaTube\Common.Config\bin\Debug\Castle.Lib.Data.Core.dll

namespace System.Data
{
  public interface IEntityDataRow
  {
    void SetEntityData(DataRow data);

    DataRow GetEntityData();
  }
}
