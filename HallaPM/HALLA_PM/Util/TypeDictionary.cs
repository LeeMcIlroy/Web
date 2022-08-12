using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HALLA_PM.Util
{
    public class TypeDictionary<TKey, TValue> : Dictionary<TKey, TValue>
    {
        #region GetKey : 값과 대비하는 키를 가져옵니다.
        /// <summary>
        /// 값과 대비하는 키를 가져옵니다.
        /// </summary>
        /// <param name="value"></param>
        /// <returns></returns>
        public TKey GetKey(TValue value)
        {
            try
            {
                return this.First(x => value.Equals(x.Value)).Key;
            }
            catch
            {
                return default(TKey);
            }
        }
        #endregion

        #region GetValue : 키와 대비하는 값을 가져옵니다.
        /// <summary>
        /// 키와 대비하는 값을 가져옵니다.
        /// </summary>
        /// <param name="key"></param>
        /// <returns></returns>
        public TValue GetValue(TKey key)
        {
            try
            {
                return this.First(x => key.Equals(x.Key)).Value;
            }
            catch
            {
                return default(TValue);
            }
        }
        #endregion
    }
}