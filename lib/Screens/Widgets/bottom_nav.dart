import 'package:flutter/material.dart';
import 'package:money_management_app/Screens/Home/home_screen.dart';

class BottomNavigationScreen extends StatelessWidget {
  const BottomNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: HomeScreen.selectedindexnotifier,
        builder: (BuildContext context, int updatedindex, _) {
          return BottomNavigationBar(
              selectedItemColor: Colors.indigoAccent.shade700,
              unselectedItemColor: Colors.lightBlue,
              selectedFontSize: 18,
              unselectedFontSize: 14,
              selectedLabelStyle: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              unselectedLabelStyle: TextStyle(
                fontStyle: FontStyle.italic,
              ),
              currentIndex: updatedindex,
              onTap: (newIndex) {
                HomeScreen.selectedindexnotifier.value = newIndex;
              },
              items: [
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home,
                    ),
                    label: 'Transactions'),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.category,
                  ),
                  label: 'Categories',
                )
              ]);
        });
  }
}
