
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Transactions;

using Castle.Data;

namespace HallaTube
{
    public class CategoryRepository : DataRepository
    {

        public List<CategoryEntity> GetList(SearchModel search, bool containCount = true)
        {
            search.SetSort();

            int start = (search.PageNumber - 1) * search.PageSize;
            int end = search.PageNumber * search.PageSize;

            search.EndDate = search.EndDate.AddDays(1);

            DataCommand command = GetCommand("Category.GetList", search, new { IsCount = false, RowStart = start, RowEnd = end });
            var list = command.ExecuteDataTable().GetEntityList<CategoryEntity>();

            if (containCount)
            {
                command = GetCommand("Category.GetList", search, new { IsCount = true });
                object rtn = command.ExecuteScalar();
                search.TotalCount = long.Parse(rtn.ToString());
            }

            search.EndDate = search.EndDate.AddDays(-1);

            return list;
        }

        public void Create(CategoryEntity category)
        {
            using (var scope = new TransactionScope(TransactionScopeOption.Required, tranOption, EnterpriseServicesInteropOption.None))
            {
                ExecuteNonQuery("Category.Create", category);
                scope.Complete();
            }
        }

        public CategoryEntity Get(string categoryID)
        {
            return ExecuteDataRow("Category.Get", new { categoryID }).GetEntity<CategoryEntity>();
        }
       
        public void Update(CategoryEntity category)
        {
            using (var scope = new TransactionScope(TransactionScopeOption.Required, tranOption, EnterpriseServicesInteropOption.None))
            {
                ExecuteNonQuery("Category.Update", category);
                scope.Complete();
            }
        }

        public void Delete(string categoryID)
        {
            ExecuteNonQuery("Category.Delete", new { categoryID });
        }

        public Dictionary<string, CategoryEntity> GetMenu()
        {
            return ExecuteDataTable("Category.GetMenu").GetEntityDictionary<CategoryEntity>();
        }


        //관리자 목록
        public List<CategoryEntity> GetTypeCategoryList(string categoryType)
        {
            return ExecuteDataTable("Category.GetTypeCategoryList", new { categoryType }).GetEntityList<CategoryEntity>();
        }


        public void CreateCategory(CategoryEntity category, FileEntity file = null)
        {
            var parent = ExecuteDataRow("Category.Get", new { CategoryID = category.ParentID }).GetEntity<CategoryEntity>();
            category.CategoryID = Sequence.Generate();
            category.CategoryLevel = parent.CategoryLevel + 1;
            category.CategoryType = parent.CategoryType;
            if (string.IsNullOrEmpty(category.CategoryCode)) category.CategoryCode = category.CategoryID;
            category.Path = parent.Path + category.CategoryID + "#";
            if (string.IsNullOrEmpty(category.IsDisplay)) category.IsDisplay = "Y";
            //category.PathNm = parent.PathNm + category.CategoryNm + "#";
            //  category.PathNm = parent.PathNm = parent.PathNm + "#" + category.CategoryNm;
            category.IsDel = "N";

            using (var scope = new TransactionScope(TransactionScopeOption.Required, tranOption, EnterpriseServicesInteropOption.None))
            {
                if (file != null)
                {
                    file.ObjectID = category.CategoryID;
                    file.ObjectType = FileType.CATEGORY;
                    file.Path = Config.GetFileTypePath(FileType.CATEGORY, file.FileID, file.Extension, DateTime.UtcNow, null, false);
                    ExecuteNonQuery("File.CreateFile", file);
                }
                ExecuteNonQuery("Category.Create", category);
                scope.Complete();
            }
            if (file != null)
            {
                string path = Config.GetFileTypePath(FileType.TEMP, file.FileID, file.Extension);
                string desPath = Config.GetPath(file.Path);
                System.IO.File.Move(path, desPath);
            }
        }

        public void UpdateCategory(CategoryEntity category, FileEntity file = null)
        {
            var parent = ExecuteDataRow("Category.Get", new { CategoryID = category.ParentID }).GetEntity<CategoryEntity>();

            category.CategoryLevel = parent.CategoryLevel + 1;
            category.Path = parent.Path + category.CategoryID + "#";
            //category.PathNm = parent.PathNm + category.CategoryNm + "#";
            if (string.IsNullOrEmpty(category.IsDisplay)) category.IsDisplay = "Y";

            var exist = ExecuteDataRow("File.GetFileList", new { objectID = category.CategoryID, objectType = FileType.CATEGORY }).GetEntity<FileEntity>();

            using (var scope = new TransactionScope(TransactionScopeOption.Required, tranOption, EnterpriseServicesInteropOption.None))
            {
                if (file != null)
                {
                    if (exist != null)
                    {
                        ExecuteNonQuery("File.DeleteFile", new { exist.FileID });
                    }
                    file.ObjectID = category.CategoryID;
                    file.ObjectType = FileType.CATEGORY;
                    file.Path = Config.GetFileTypePath(FileType.CATEGORY, file.FileID, file.Extension, DateTime.UtcNow, null, false);

                    ExecuteNonQuery("File.CreateFile", file);
                }

                ExecuteNonQuery("Category.Update", category);
                scope.Complete();
            }

            if (file != null)
            {
                if (exist != null)
                {
                    string existPath = Config.GetPath(exist.Path);
                    System.IO.File.Delete(existPath);
                }
                string path = Config.GetFileTypePath(FileType.TEMP, file.FileID, file.Extension);
                string desPath = Config.GetPath(file.Path);
                System.IO.File.Move(path, desPath);
            }
        }

        public void Set(List<CategoryEntity> list, UserModel user)
        {
            using (var scope = new TransactionScope(TransactionScopeOption.Required, tranOption, EnterpriseServicesInteropOption.None))
            {
                foreach (var item in list)
                {
                    if (item._ItemState == "Create")
                    {
                        item.RegID = user.UserId;
                        item.RegDate = DateTime.UtcNow;

                        CreateCategory(item);
                    }
                    else if (item._ItemState == "Update")
                    {
                        UpdateCategory(item);
                    }
                }

                scope.Complete();
            }
        }

        public void DeleteCategory(IEnumerable list)
        {
            using (var scope = new TransactionScope(TransactionScopeOption.Required, tranOption, EnterpriseServicesInteropOption.None))
            {
                foreach (var categoryID in list)
                {
                    ExecuteNonQuery("Category.DeleteCategory", new { categoryID });
                }
                scope.Complete();
            }
        }
    }
}
