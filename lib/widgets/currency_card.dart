import 'package:flutter/material.dart';
import 'package:flutter_homework/classes/bottom_navigation_bar_provider.dart';
import 'package:flutter_homework/classes/functions.dart';
import 'package:flutter_homework/screens/coin_screen.dart';
import 'package:provider/provider.dart';
import '../classes/coin.dart';
import '../theme.dart';
import 'package:intl/intl.dart';

class CurrencyCard extends StatelessWidget {
  const CurrencyCard({
    Key? key,
    required this.balance,
    required this.coin,
  }) : super(key: key);

  final double balance;
  final Coin coin;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<BottomNavigationBarProvider>(context);

    return Padding(
      padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 10),
      child: GestureDetector(
        onTap: () {
          navigateToNewPage(ChangeScreen(coin), context);
        },
        child: Card(
          color: theme.primaryColor,
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100.0),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      '${format(balance)} ',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        //fontSize: 20.0,
                        color: theme.secondaryHeaderColor,
                      ),
                    ),
                    Text(
                      '${coin.symbol.toUpperCase()}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 10.0,
                        color: theme.secondaryHeaderColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      '${NumberFormat("#,##0.00", "en_US").format((coin.coinMarketData!.price![provider.selectedCurrency] * balance * 10000).toInt().toDouble() / 10000)} ',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15.0,
                        color: theme.secondaryHeaderColor,
                      ),
                    ),
                    Text(
                      '${provider.selectedCurrency.toUpperCase()}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 10.0,
                        color: theme.secondaryHeaderColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> navigateToNewPage(Widget page, BuildContext context) async {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => page),
  );
}

class ChangeScreen extends StatelessWidget {
  final Coin coin;

  ChangeScreen(this.coin);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BottomNavigationBarProvider>(
      create: (context) => BottomNavigationBarProvider(),
      child: MaterialApp(
        home: CoinScreen(
          coin: coin,
        ),
      ),
    );
  }
}
