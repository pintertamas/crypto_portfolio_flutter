import 'package:flutter/material.dart';
import 'package:flutter_homework/coin_data.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../calculate_balance.dart';
import '../theme.dart';
import '../constants.dart';


class BalanceWidget extends StatelessWidget {
  const BalanceWidget({
    Key key,
    @required this.coinValues
  }) : super(key: key);

  final CoinData coinValues;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100.0),
      ),
      color: theme.accentColor,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              FontAwesomeIcons.coins,
              color: theme.primaryColor,
            ),
            Text(
              '${NumberFormat("#,##0.00", "en_US").format(calculateBalance(coinValues, portfolio))} $selectedCurrency',
              style: TextStyle(
                color: theme.primaryColor,
                fontSize: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}