// Decompiled with JetBrains decompiler
// Type: System.DateTimeExtension
// Assembly: Castle.Lib.Data.Core, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 27E9C49E-74A4-4958-A484-30DAD04DD134
// Assembly location: D:\Halla\Hallo\HallaTube\Common.Config\bin\Debug\Castle.Lib.Data.Core.dll

namespace System
{
  public static class DateTimeExtension
  {
    public static int GetWeek(this DateTime dt)
    {
      int num1 = (dt.Day - 1) / 7 + 1;
      int num2 = (dt.Day - 1) % 7;
      if (dt.DayOfWeek <= (DayOfWeek) num2)
        ++num1;
      return num1;
    }

    public static bool IsLastWeek(this DateTime dt) => dt.AddDays(7.0).Month != dt.Month;

    public static bool IsValid(this DateTime dt) => dt > new DateTime(1900, 1, 1);
  }
}
