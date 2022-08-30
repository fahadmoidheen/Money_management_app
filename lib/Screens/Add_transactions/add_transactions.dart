import 'package:flutter/material.dart';
import 'package:money_manager_flutter/models/category/category_model.dart';

class ScreenaddTransaction extends StatelessWidget{

  static const routeName ='add-transaction';
  const ScreenaddTransaction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  hintText: 'Purpose',
                    border: OutlineInputBorder()
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Amount',
                  border: OutlineInputBorder()
                ),
              ),
              TextButton.icon(
                  onPressed: (){},
                  icon: Icon(Icons.calendar_today),
                  label: Text("Select date")),
              Row(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Radio(
                          value:CategoryType.income, groupValue: CategoryType.income, onChanged: (newValue){}
                      ),
                      const Text("Income")
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                          value:CategoryType.income, groupValue: CategoryType.expense, onChanged: (newValue){}
                      ),
                      const Text("Expense")
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

}