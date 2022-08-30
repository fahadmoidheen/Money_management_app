import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_manager_flutter/models/category/category_model.dart';

const CATEGORY_DB_NAME = 'Category-database';

abstract class CategoryDbFunctions {
  Future<List<CategoryModel>> getCategories();
  Future<void> insertCategory(CategoryModel value);
  Future<void>deleteCategory(String CategoryId);
}

class CategoryDb implements CategoryDbFunctions {
  CategoryDb._internal();
  static CategoryDb instance =CategoryDb._internal();
  factory CategoryDb(){
    return instance;
  }


  ValueNotifier<List<CategoryModel>> incomeCategoryListListener=ValueNotifier([]);
  ValueNotifier<List<CategoryModel>> expenseCategoryListListener=ValueNotifier([]);

  @override
  Future<void> insertCategory(CategoryModel value) async {
    final _categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    await _categoryDB.put(value.id,value);
    refreshUI();
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    final _categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    return _categoryDB.values.toList();
  }

  Future<void>refreshUI() async{
    final _allCategories=await getCategories();
    incomeCategoryListListener.value.clear();
    expenseCategoryListListener.value.clear();

    Future.forEach(_allCategories, (CategoryModel Category) {
      if(Category.type==CategoryType.income){
        incomeCategoryListListener.value.add(Category);
      }else{
        expenseCategoryListListener.value.add(Category);
      }
    });
    incomeCategoryListListener.notifyListeners();
    expenseCategoryListListener.notifyListeners();
  }

  @override
  Future<void> deleteCategory(CategoryId)  async {
    final Category =await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    Category.delete(CategoryId);
    refreshUI();
  }
}
