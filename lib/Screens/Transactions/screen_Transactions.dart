

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ScreenTransactions extends ConsumerWidget {
  const ScreenTransactions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext, WidgetRef) {
    return ListView.separated(
      padding: const EdgeInsets.all(10),
        itemBuilder: (context ,index ){
          return const Card(
            child: ListTile(
              title: Text("12000 ") ,
              subtitle:Text("Dec12"),
              trailing: Text("Travels"),
            ),
          );
        },
        separatorBuilder: (context ,index ){
          return const SizedBox(
            height:10,
          );
        },
        itemCount: 10);
  }
}
