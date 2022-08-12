using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HALLA_PM.Models
{
    public interface IBaseRepo<TEntity> : IDisposable where TEntity : class
    {
        int count(object param);
        IEnumerable<TEntity> selectList(object param);
        TEntity selectOne(object param);
        int insert(TEntity entity);
        int update(TEntity entity);
        int delete(object key);
        int save(TEntity entity);
    }
}
