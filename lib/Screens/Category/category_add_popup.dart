import 'package:flutter/material.dart';
import 'package:money_manager_flutter/database/category_db/category_db.dart';
import 'package:money_manager_flutter/models/category/category_model.dart';


 ValueNotifier<CategoryType>selectedCategoryNotifier=
 ValueNotifier(CategoryType.income);
Future<void>showCategoryAddPopup(BuildContext context) async{
  final _nameEditingcontroller=TextEditingController();
  showDialog(
    context: context,
    builder:(ctx){ 
      return  SimpleDialog(
        title:  const Text("Add Category"),
        contentPadding: const EdgeInsets.all(15),
        children: [
          TextFormField( decoration: const  InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
          hintText: 'Add category'
          ),
            controller: _nameEditingcontroller,
        ),
          Padding(padding: const EdgeInsets.all(8.0),
          child: Row(
            children: const [
              RadioButton(title: "Income",type: CategoryType.income,),
              RadioButton(title: "Expense",type: CategoryType.expense,)
            ],
          ),),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(onPressed: (){
              final _name=_nameEditingcontroller.text;
              if(_name.isEmpty){
                return;
              }
              final _type=selectedCategoryNotifier.value;
              final _category=
              CategoryModel(
                  id: DateTime.now().microsecondsSinceEpoch.toString(),
                  name: _name,
                  type: _type);
              CategoryDb().insertCategory(_category);
              Navigator.of(ctx).pop();
            }, child: const Text("Add")),
          )
         ],
       );
    } );

} 

class RadioButton extends StatelessWidget {

  final String title;
  final CategoryType type;
  
  const RadioButton({
    Key? key ,
    required this.title,
    required this.type
   }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(valueListenable: selectedCategoryNotifier,
            builder: (BuildContext ctx, CategoryType newCategory, Widget? _){
          return Radio<CategoryType>(
            onChanged: (value) {
              if(value==null){
                return ;
              }
              selectedCategoryNotifier.value=value;
              selectedCategoryNotifier.notifyListeners();
            },
            groupValue:newCategory ,
            value: type, );
        }),
        Text((title))
      ],
    );
  }
}