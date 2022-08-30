import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:money_manager_flutter/Screens/Add_transactions/add_transactions.dart';
import 'package:money_manager_flutter/Screens/Category/category_add_popup.dart';
import 'package:money_manager_flutter/database/category_db/category_db.dart';
import 'package:money_manager_flutter/models/category/category_model.dart';

import '../Category/screen_Category.dart';
import '../Transactions/screen_Transactions.dart';
import '../Widgets/bottom_navigation.dart';

class ScreenHome extends ConsumerWidget {
  const ScreenHome({Key? key}) : super(key: key);
  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);

  final _pages = const [ScreenTransactions(), ScreenCategory()];
  @override
  Widget build(BuildContext context, WidgetRef) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Money Manager"),
        centerTitle: true,
      ),
      bottomNavigationBar: const MoneyManagerBottomNavigation(),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: selectedIndexNotifier,
          builder: (context, int updatedIndex, Widget? child) {
            return _pages[updatedIndex];
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (selectedIndexNotifier.value == 0) {
            print("screeen transactions");
            Navigator.of(context).pushNamed(ScreenaddTransaction.routeName);
          } else {
            showCategoryAddPopup(context);
            //     final _sample = CategoryModel(
            // id: DateTime.now().microsecondsSinceEpoch.toString(),
            // name: 'Travel',
            // type: CategoryType.expense);
            // CategoryDb().insertCategory(_sample).then((value) => {
            //   print('haha')
            // });

          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
