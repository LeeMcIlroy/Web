using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;

namespace System.Collections.Generic
{
    public static class DictionaryExtension
    {
        public static TValue SafeGet<TKey, TValue>(this IDictionary<TKey, TValue> dic, TKey key)
        {
            TValue val = default(TValue);
            if (key == null) return val;

            dic.TryGetValue(key, out val);
            return val;
        }

        public static void SafeSet<TKey, TValue>(this IDictionary<TKey, TValue> dic, TKey key, TValue val)
        {
            if (dic.ContainsKey(key))
            {
                dic[key] = val;
            }
            else
            {
                dic.Add(key, val);
            }
        }

        public static void SafeRemove<TKey, TValue>(this IDictionary<TKey, TValue> dic, TKey key)
        {
            if (dic.ContainsKey(key))
            {
                dic.Remove(key);
            }
        }
    }
}
