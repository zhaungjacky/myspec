import 'package:certispec/pages/customers/customer_page.dart';
import 'package:certispec/pages/tests/test_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List<Widget> get _pages => [TestLists(), CustomerPage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],

      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(
              Icons.update  ,
              color: Colors.green,
            ),
            icon: Icon(Icons.update_disabled,color: Colors.lightGreen,),
            label: 'Procedures',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.factory,color: Colors.green,),
            icon: Badge(label: Text('3'), child: Icon(Icons.factory,color: Colors.lightGreen,),),
            label: 'Customers',
          ),
        ],
      ),
    );
  }
}
