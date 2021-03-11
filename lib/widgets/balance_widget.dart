import 'package:flutter/material.dart';
import 'package:flutter_homework/coin_data.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../calculate_balance.dart';
import '../constants.dart';

class BalanceWidget extends StatelessWidget {
  const BalanceWidget({
    Key key,
    @required this.coinValues
  }) : super(key: key);

  final CoinData coinValues;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.deepOrange,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              FontAwesomeIcons.coins,
              color: Colors.white,
            ),
            Text(
              '${calculateBalance(coinValues, portfolio)} $selectedCurrency',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}