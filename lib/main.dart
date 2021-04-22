import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'theme.dart';
import 'widgets/bottom_navigation_bar_provider.dart';
import 'data/device_data.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  /*static const Map<String, double> portfolio = {
    'bitcoin': 6.05,
    'ethereum': 3.4,
    'litecoin': 20,
    'switcheo': 350000,
    'ripple': 300,
    'monero': 2.05,
    'tether': 1002,
    'binancecoin': 43,
    'cardano': 30,
    'tezos': 1002,
    'solana': 654,
    'cosmos': 32,
    'renbtc': 40,
    'stellar': 5321,
    'dogecoin': 200,
  };*/

  @override
  Widget build(BuildContext context) {
    Map<String, double> portfolio = new Map();

    return MaterialApp(
      title: 'Portfolio',
      theme: theme,
      home: FutureBuilder(
        builder: (ctx, snapshot) {
          return ChangeNotifierProvider<BottomNavigationBarProvider>(
            child: BottomNavBar(portfolio: portfolio),
            create: (BuildContext context) => BottomNavigationBarProvider(),
          );
        },
        future: new DataHandler().readPortfolio(portfolio),
      ),
      builder: EasyLoading.init(),
    );
  }
}
