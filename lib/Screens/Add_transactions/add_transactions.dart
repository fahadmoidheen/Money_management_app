import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:money_manager_flutter/database/category_db/category_db.dart';
import 'package:money_manager_flutter/database/transactions_db/transactions_db.dart';
import 'package:money_manager_flutter/models/category/category_model.dart';
import 'package:money_manager_flutter/models/transactions/transactions_model.dart';

class ScreenaddTransaction extends StatefulWidget{

  static const routeName ='add-transaction';
  const ScreenaddTransaction({Key? key}) : super(key: key);

  @override
  State<ScreenaddTransaction> createState() => _ScreenaddTransactionState();
}

class _ScreenaddTransactionState extends State<ScreenaddTransaction> {
  DateTime ? selectedDate;
  CategoryType ? selectedCategoryType;
  CategoryModel ? selectedCategoryModel;

  String? categoryID;
  final _purposeController=TextEditingController();
  final _amountController=TextEditingController();

  @override
  void initState() {
    selectedCategoryType=CategoryType.income;
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextFormField(
                keyboardType: TextInputType.text,
                controller: _purposeController,
                decoration: const InputDecoration(
                  hintText: 'Purpose'
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: _amountController,
                decoration: const InputDecoration(
                  hintText: 'Amount'
                ),
              ),

              TextButton.icon(
                  onPressed: () async {
                    final selectedDateTemp=await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now().subtract(Duration(days: 30)),
                        lastDate: DateTime.now());
                  if(selectedDateTemp==null){
                    return ;
                  }else{
                    print(selectedDateTemp.toString());
                    setState((){
                      selectedDate=selectedDateTemp;
                    });
                  }
                    }
                  ,
                  icon: const Icon(Icons.calendar_today),
                  label:  Text( selectedDate == null ?'Select Date': selectedDate.toString()),),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Radio(
                          value:CategoryType.income,
                          groupValue: selectedCategoryType,
                          onChanged: (newValue){
                            setState((){
                              selectedCategoryType=CategoryType.income;
                              categoryID=null;
                            });

                          }
                      ),
                      const Text("Income")
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                          value:CategoryType.expense,
                          groupValue: selectedCategoryType,
                          onChanged: (newValue){
                            setState((){
                              selectedCategoryType=CategoryType.expense;
                              categoryID=null;
                            });

                          }
                      ),
                      const Text("Expense")
                    ],
                  )
                ],
              ),
              DropdownButton(
                hint: const Text("Select Category"),
                  value: categoryID,
                  items: (selectedCategoryType == CategoryType.income ? CategoryDb().incomeCategoryListListener :
                  CategoryDb().expenseCategoryListListener).value.map((e) {
                    return DropdownMenuItem(
                        child: Text(e.name),
                        value: e.id,
                      onTap: (){
                          selectedCategoryModel=e;
                      },
                    );
                  }).toList(),
                  onChanged: (selectedValue){
                print(selectedValue);
                setState((){
                  categoryID=selectedValue as String?;
                });
              }),
              ElevatedButton(
                  onPressed: (){
                    addTransaaction(){

                    }
                  },
                  child: Text('Submit')
              )
            ],
          ),
        ),
      ),
    );
  }
  Future<void>addTransation() async{
    final _purposeText=_purposeController.text;
    final _amountText=_amountController.text;

    if(_purposeText.isEmpty){
      return;
    }
    if(_amountText.isEmpty){
      return;
    }
    if(categoryID==null){
      return;
    }
    if(selectedDate==null){
      return;
    }
    final _parsedamount=double.tryParse(_amountText);
    if(_parsedamount==null){
      return;
    }

    final _model =TransactionModel(
      purpose: _purposeText,
      amount: _parsedamount,
      date: selectedDate!,
      type: selectedCategoryType!,
      category: selectedCategoryModel!,
    );
    TransactionsDB.instance.addTransactions(_model);
  }
}

