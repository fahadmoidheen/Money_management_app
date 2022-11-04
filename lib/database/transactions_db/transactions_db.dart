import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:money_manager_flutter/models/transactions/transactions_model.dart';

const TRANSACTIONS_DB_NAME='Transactions-Db';

abstract class TransactionDbFunctions{
  Future<void> addTransactions(TransactionModel obj);
  Future<List<TransactionModel>>getAllTransactions();
}
class TransactionsDB implements TransactionDbFunctions{
  TransactionsDB._internal();

  ValueNotifier<List<TransactionModel>>transactionListNotifier=ValueNotifier([]);

  static TransactionsDB instance =TransactionsDB._internal();

  factory TransactionsDB(){
    return instance;
  }

  @override
  Future<void> addTransactions(TransactionModel obj) async {
    final _db= await Hive.openBox<TransactionModel>(TRANSACTIONS_DB_NAME);
    await  _db.put(obj.id, obj);
  }

  Future<void>refresh() async{
    final _list= await getAllTransactions();
    print(_list);
    transactionListNotifier.value.clear();
    transactionListNotifier.value.addAll(_list);
    transactionListNotifier.notifyListeners();
  }

  @override
  Future<List<TransactionModel>> getAllTransactions() async {

    final _db= await Hive.openBox<TransactionModel>(TRANSACTIONS_DB_NAME);
        return _db.values.toList();
  }

}