
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:money_manager_flutter/database/category_db/category_db.dart';

import '../../models/category/category_model.dart';

class ExpenseCategoryList extends StatelessWidget {
  const ExpenseCategoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: CategoryDb().expenseCategoryListListener,
        builder: (BuildContext ctx, List<CategoryModel> newList, Widget? _){
          return ListView.separated(
              itemBuilder: (ctx ,index){
                final Category=newList[index];
                return Card(
                  child: ListTile(
                    trailing: IconButton(onPressed: () {
                      CategoryDb().deleteCategory(Category.id);
                    }, icon: Icon(Icons.delete),),
                    title: Text(Category.name),
                  ),
                )
                ;},
              separatorBuilder: (context ,index) { return const SizedBox(
                height: 10,
              );},
              itemCount: newList.length);
        });
  }
}
