import 'package:flutter/material.dart';
import 'package:flutter_homework/classes/coin.dart';
import 'package:flutter_homework/screens/add_coin_screen.dart';
import 'package:flutter_homework/theme.dart';

class ListTileWidget extends StatelessWidget {
  final Coin coin;
  final Map<String, double> portfolio;

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

  ListTileWidget(this.coin, this.portfolio);
}

void _onTapItem(
    BuildContext context, Coin coin, Map<String, double> portfolio) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: GestureDetector(
    child: Text(
      "Tap here to add " + coin.name + " to your portfolio!",
      style: TextStyle(
        color: theme.primaryColor,
      ),
    ),
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddCoinScreen(
            coin: coin,
            portfolio: portfolio,
          ),
        ),
      );
    },
  )));
}
