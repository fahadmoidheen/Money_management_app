import 'package:flutter/material.dart';

import '../Home/screen_Home.dart';

class MoneyManagerBottomNavigation extends StatelessWidget {
  const MoneyManagerBottomNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ScreenHome.selectedIndexNotifier,
      builder: (BuildContext context, int updatedIndex , Widget? child) {
        return BottomNavigationBar(
            currentIndex: updatedIndex,
            selectedItemColor: Colors.purple,
            unselectedItemColor: Colors.grey,
            onTap: (newIndex){
              ScreenHome.selectedIndexNotifier.value=newIndex;
            },
            items:
            const [
              BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Transactions'),
              BottomNavigationBarItem(icon: Icon(Icons.category),label: 'Category')
            ]

        );
      },
    );
  }
}
