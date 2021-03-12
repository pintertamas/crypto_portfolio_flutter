import 'package:flutter/material.dart';
import 'package:flutter_homework/constants.dart';
import 'package:flutter_homework/screens/coin_screen.dart';
import '../classes/coin.dart';
import '../theme.dart';
import 'package:intl/intl.dart';

class CurrencyCard extends StatelessWidget {
  const CurrencyCard({
    Key key,
    @required this.balance,
    @required this.coin,
  }) : super(key: key);

  final double balance;
  final Coin coin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 10),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CoinScreen(
                coin: coin,
              ),
            ),
          );
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
                      coin == null ? 'Loading...' : '$balance ',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        //fontSize: 20.0,
                        color: theme.secondaryHeaderColor,
                      ),
                    ),
                    Text(
                      coin == null ? '' : '${coin.symbol.toUpperCase()}',
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
                      coin == null
                          ? ''
                          : '${NumberFormat("#,##0.00", "en_US").format((coin.price * balance * 10000).toInt().toDouble() / 10000)} ',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15.0,
                        color: theme.secondaryHeaderColor,
                      ),
                    ),
                    Text(
                      '$selectedCurrency',
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
