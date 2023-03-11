import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../diaryScreen/screen/monthScreen.dart';
import 'mainPage.dart';
import 'model.dart';

class NavigationPage extends StatefulWidget {
  final List<Gym> gymData;
  final SharedPreferences pref;
  final List<int> tileCounts;
  const NavigationPage({
    Key? key,
    required this.gymData,
    required this.pref,
    required this.tileCounts,
  }) : super(key: key);

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  List<BottomNavigationBarItem> _items = [
    BottomNavigationBarItem(
        icon: Image.asset("image/navigation_gym_normal.png", width: 40, height: 30),
        activeIcon: Image.asset("image/navigation_gym_activated.png", width: 40, height: 30,color: Colors.green,),
        label: "Gym",),
    BottomNavigationBarItem(
        icon: Image.asset("image/navigation_diary_normal2.png", width: 35, height: 25),
        activeIcon: Image.asset("image/navigation_diary_normal2.png", width: 35, height: 25, color: Colors.green,),
        label: "Diary"),
  ];
  late int _selectedIndex;

  @override
  void initState() {
    _selectedIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent
        ),
        child: BottomNavigationBar(
          unselectedFontSize: 12,
          selectedFontSize: 12,
          selectedItemColor: Colors.green.shade300,
          items: _items,
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
      body: _getPage(_selectedIndex),
    );
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0: return MainPage(gymData: widget.gymData, pref: widget.pref);
      case 1: return MonthScreen(tileCounts: widget.tileCounts, pref: widget.pref,);
      default: return MainPage(gymData: widget.gymData, pref: widget.pref);
    }
  }
}

