import 'package:flutter/material.dart';
import 'package:flutter_homework/screens/news_screen.dart';
import 'package:flutter_homework/screens/portfolio_screen.dart';
import 'package:flutter_homework/screens/settings_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';

import '../theme.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() =>
      _BottomNavBarState();
}

class _BottomNavBarState
    extends State<BottomNavBar> {
  var currentTab = [
    NewsScreen(),
    PortfolioScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<BottomNavigationBarProvider>(context);
    return Scaffold(
      body: currentTab[provider.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: theme.primaryColor,
        selectedItemColor: theme.accentColor,
        iconSize: 30,
        unselectedFontSize: 0,
        selectedFontSize: 18,
        unselectedIconTheme: IconThemeData(
            size: 25
        ),
        selectedIconTheme: IconThemeData(
            size: 30
        ),
        currentIndex: provider.currentIndex,
        onTap: (index) {
          provider.currentIndex = index;
        },
        items: [
          BottomNavigationBarItem(
            icon: new Icon(FontAwesomeIcons.newspaper),
            label: 'News',
          ),
          BottomNavigationBarItem(
            icon: new Icon(FontAwesomeIcons.chartLine),
            label: 'Portfolio',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.cog),
            label: 'Settings',
          )
        ],
      ),
    );
  }
}

class BottomNavigationBarProvider with ChangeNotifier {
  int _currentIndex = 2;

  get currentIndex => _currentIndex;

  set currentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}