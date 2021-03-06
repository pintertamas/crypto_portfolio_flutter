import 'package:flutter/material.dart';
import 'package:flutter_homework/classes/bottom_navigation_bar_provider.dart';
import 'package:flutter_homework/classes/coin.dart';
import 'package:flutter_homework/classes/coin_list_element.dart';
import 'package:flutter_homework/screens/add_coin_screen.dart';
import 'package:flutter_homework/theme.dart';
import 'package:provider/provider.dart';

class ListTileWidget extends StatelessWidget {
  final CoinListElement coin;
  final Map<String, double> portfolio;

  ListTileWidget(this.coin, this.portfolio);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        '${coin.id}',
        style: TextStyle(
          color: theme.primaryColor,
        ),
      ),
      subtitle: Text(
        '${coin.symbol.toUpperCase()}',
        style: TextStyle(
          color: theme.primaryColorLight,
        ),
      ),
      leading: CircleAvatar(
        backgroundColor: theme.accentColor,
        child: Text(
          coin.symbol.length > 3
              ? coin.symbol.substring(0, 3).toUpperCase()
              : coin.symbol,
          style: TextStyle(color: theme.secondaryHeaderColor),
        ),
      ),
      onTap: () => _onTapItem(context, coin, portfolio),
    );
  }
}

void _onTapItem(
    BuildContext context, CoinListElement coin, Map<String, double> portfolio) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: GestureDetector(
    child: Text(
      "Tap here to add " + coin.name + " to your portfolio!",
      style: TextStyle(
        color: theme.primaryColor,
      ),
    ),
    onTap: () {
      navigateToNewPage(ChangeScreen(coin, portfolio), context);
    },
  )));
}

Future<void> navigateToNewPage(Widget page, BuildContext context) async {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => page),
  );
}

class ChangeScreen extends StatelessWidget {
  final CoinListElement coin;
  final portfolio;
  ChangeScreen(this.coin, this.portfolio);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BottomNavigationBarProvider>(
      create: (context) => BottomNavigationBarProvider(),
      child: MaterialApp(
        home: AddCoinScreen(
          coin: coin,
          portfolio: portfolio,
        ),
      ),
    );
  }
}
