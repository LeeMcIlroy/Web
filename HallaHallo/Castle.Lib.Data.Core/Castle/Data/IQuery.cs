// Decompiled with JetBrains decompiler
// Type: Castle.Data.IQuery
// Assembly: Castle.Lib.Data.Core, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 27E9C49E-74A4-4958-A484-30DAD04DD134
// Assembly location: D:\Halla\Hallo\HallaTube\Common.Config\bin\Debug\Castle.Lib.Data.Core.dll

using System.Collections.Generic;
using System.Data;

namespace Castle.Data
{
  public interface IQuery
  {
    DataCommand GetMatchCommand(
      DataAgent agent,
      string qryid,
      List<DataParamSource> paramSource);
  }
}
