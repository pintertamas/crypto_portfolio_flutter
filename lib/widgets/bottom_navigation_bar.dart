import 'package:flutter/material.dart';
import 'package:flutter_homework/classes/bottom_navigation_bar_provider.dart';
import 'package:flutter_homework/screens/news_screen.dart';
import 'package:flutter_homework/screens/portfolio_screen.dart';
import 'package:flutter_homework/screens/settings_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';

import '../theme.dart';

class BottomNavBar extends StatefulWidget {
  final Map<String, double> portfolio;

  const BottomNavBar({Key? key, required this.portfolio}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState(portfolio);
}

class _BottomNavBarState extends State<BottomNavBar> {
  Map<String, double> portfolio = Map();

  var currentTab = [];

  _BottomNavBarState(Map<String, double> portfolio) {
    this.portfolio = portfolio;
    currentTab = [
      NewsScreen(),
      PortfolioScreen(portfolio: portfolio),
      SettingsScreen(portfolio: portfolio),
    ];
  }

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
        unselectedIconTheme: IconThemeData(size: 25),
        selectedIconTheme: IconThemeData(size: 30),
        currentIndex: provider.currentIndex,
        onTap: (index) {
          provider.currentIndex = index;
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.newspaper),
            label: 'News',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.chartLine),
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