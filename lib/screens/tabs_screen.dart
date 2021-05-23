import 'package:flutter/material.dart';

import './main_screen.dart';
import './service_requests_screen.dart';
import './history_screen.dart';
import './objects_screen.dart';

import '../widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Map<String, Object>> _pages = [
    {'page': MainScreen(), 'title': 'Главная'},
    {'page': ServiceRequestsScreen(), 'title': 'Заявки'},
    {'page': HistoryScreen(), 'title': 'История'},
    {'page': ObjectsScreen(), 'title': 'Объекты'},
  ];

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title']),
      ),
      drawer: MainDrawer(),
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Colors.white70,
        unselectedItemColor: Colors.black,
        iconSize: 32,
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
                Icons.house_rounded /*water_damage_outlined, house_rounded*/),
            label: 'Главная',
            backgroundColor: Theme.of(context).primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons
                .local_fire_department /*assignment_outlined, fact_check_rounded, whatshot, local_fire_department, fireplace_rounded*/),
            label: 'Заявки',
            backgroundColor: Theme.of(context).primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(
                Icons.history_edu_rounded /*history//history_edu_rounded*/),
            label: 'История',
            backgroundColor: Theme.of(context).primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business_rounded /*location_city_rounded*/),
            label: 'Объекты',
            backgroundColor: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }
}
