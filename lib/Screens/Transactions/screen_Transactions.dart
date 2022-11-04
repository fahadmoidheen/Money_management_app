
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:money_manager_flutter/database/transactions_db/transactions_db.dart';

import '../../models/transactions/transactions_model.dart';

class ScreenTransactions extends ConsumerWidget {
  const ScreenTransactions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef) {
    TransactionsDB.instance.refresh();
    return ValueListenableBuilder(
        valueListenable: TransactionsDB.instance.transactionListNotifier,
        builder: (BuildContext ctx , List<TransactionModel> newList1, Widget?_){
          return ListView.separated(
              padding: const EdgeInsets.all(10),
              itemBuilder: (ctx ,index ){
                final _value=newList1[index];
                return  Card(
                  child: ListTile(
                    title: Text('RS ${_value.amount}') ,
                    subtitle:Text(_value.category.name),
                    // trailing: Text(_value.category.toString()),
                  ),
                );
              },
              separatorBuilder: (ctx ,index ){
                return const SizedBox(
                  height:10,
                );
              },
              itemCount: newList1.length);
        });













  }
}
