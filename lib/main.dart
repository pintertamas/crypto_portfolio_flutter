import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'classes/bottom_navigation_bar_provider.dart';
import 'theme.dart';
import 'widgets/bottom_navigation_bar.dart';
import 'data/device_data.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final Map<String, double> portfolio = Map();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Portfolio',
      theme: theme,
      home: FutureBuilder(
        builder: (context, snapshot) {
          return ChangeNotifierProvider<BottomNavigationBarProvider>(
            child: BottomNavBar(portfolio: portfolio),
            create: (BuildContext context) => BottomNavigationBarProvider(),
          );
        },
        future: DataHandler().loadPortfolio(portfolio),
      ),
      builder: EasyLoading.init(),
    );
  }
}
