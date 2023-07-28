import 'package:flutter/material.dart';
import 'package:stockapps/screen/sales/sales_page.dart';
import 'package:stockapps/screen/stock/stock_page.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({Key? key}) : super(key: key);

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  bool isPressed = false;
  int _currentIndex = 0;
  final List<Widget> _children = [
    StockPage(),
    Scaffold(
      body: Center(
        child: Text("Page 2"),
      ),
    ),
    Scaffold(
      body: Center(
        child: Text("Page 3"),
      ),
    ),
  ];
  void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
      isPressed = !isPressed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 8,
        backgroundColor: Colors.green,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        selectedIconTheme: IconThemeData(size: 28),
        onTap: onTappedBar,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.checklist_rtl_outlined),
            label: 'Stock',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart_rounded),
            label: 'Sales',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money_sharp),
            label: 'Expenses',
          ),
        ],
      ),
    );
  }
}
