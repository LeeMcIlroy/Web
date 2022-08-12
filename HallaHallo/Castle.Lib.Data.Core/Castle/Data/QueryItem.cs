// Decompiled with JetBrains decompiler
// Type: Castle.Data.QueryItem
// Assembly: Castle.Lib.Data.Core, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 27E9C49E-74A4-4958-A484-30DAD04DD134
// Assembly location: D:\Halla\Hallo\HallaTube\Common.Config\bin\Debug\Castle.Lib.Data.Core.dll

using System.Collections.Generic;

namespace Castle.Data
{
  public class QueryItem
  {
    public string ID;
    public string Text;
    public bool UseSP;
    public List<SubQueryItem> SubQueryList;
    public List<DataParameter> ParamList;
  }
}
