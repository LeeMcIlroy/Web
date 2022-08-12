using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace HallaTube
{
    public static class Sequence
    {
        static object _lock = new object();
        static long lastTicks = 0;

        private static string ConvertSystem36(long num)
        {
            string result = string.Empty;

            while (true)
            {
                long ans = num / 36;
                long remain = num % 36;

                if (remain < 10) result = (char)('0' + remain) + result;
                else result = (char)('A' + (remain - 10)) + result;

                if (ans == 0) break;
                num = ans;
            }

            return result;
        }

        public static string Generate()
        {
            lock (_lock)
            {
                long ticks = DateTime.UtcNow.Ticks;
                if (lastTicks >= ticks) ticks = lastTicks + 10000;

                //초기 틱값을 빼서 아이디를 가능한 적은 숫자부터 채번하여 사용 가능한 아이디 갯수를 극대화
                long preticks = ticks / 10000 - 63567610202306;
                string id = ConvertSystem36(preticks).PadLeft(11, '0') + Config.SystemChar;
                lastTicks = ticks;

                return id;
            }
        }
    }
}
