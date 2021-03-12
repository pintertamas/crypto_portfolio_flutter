import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme.dart';
import 'widgets/bottom_navigation_bar_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Portfolio',
      theme: theme,
      home: ChangeNotifierProvider<BottomNavigationBarProvider>(
        child: BottomNavBar(),
        create: (BuildContext context) => BottomNavigationBarProvider(),
      ),
    );
  }
}