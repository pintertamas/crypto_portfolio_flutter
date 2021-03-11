import 'package:flutter/material.dart';

class CurrencyCard extends StatelessWidget {
  const CurrencyCard({
    Key key,
    @required this.balance,
    @required this.currentCrypto,
    @required this.currentValue,
    @required this.selectedCurrency,
  }) : super(key: key);

  final double balance;
  final String currentCrypto;
  final double currentValue;
  final String selectedCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(5.0, 20.0, 5.0, 0),
      child: GestureDetector(
        onTap: () {

        },
        child: Card(
          color: Colors.deepOrange,
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100.0),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
            child: Text(
              currentValue == 0
                  ? 'Loading...'
                  : '$balance $currentCrypto = \$${(currentValue * balance * 10000).toInt().toDouble() / 10000}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}