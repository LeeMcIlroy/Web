// Decompiled with JetBrains decompiler
// Type: System.StringExtention
// Assembly: Castle.Lib.Data.Core, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 27E9C49E-74A4-4958-A484-30DAD04DD134
// Assembly location: D:\Halla\Hallo\HallaTube\Common.Config\bin\Debug\Castle.Lib.Data.Core.dll

namespace System
{
  public static class StringExtention
  {
    public static string CutTail(this string text, int tailLength) => text.Length >= tailLength ? text.Substring(0, text.Length - tailLength) : "";

    public static string CutTail(this string text) => text.CutTail(1);

    public static int ToInt(this string text, int defautvalue)
    {
      try
      {
        return int.Parse(text);
      }
      catch
      {
        return defautvalue;
      }
    }
  }
}
