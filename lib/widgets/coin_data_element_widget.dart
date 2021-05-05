import 'package:flutter/cupertino.dart';
import 'package:flutter_homework/classes/bottom_navigation_bar_provider.dart';
import 'package:flutter_homework/classes/functions.dart';
import 'package:provider/provider.dart';

import '../theme.dart';

class CoinDataElement extends StatelessWidget {
  final String text;
  final Map<String, dynamic>? value;
  final int size;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<BottomNavigationBarProvider>(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              text,
              style: detailsTextStyle(size),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              format(value![provider.selectedCurrency].toString()) +
                  " " +
                  provider.selectedCurrency.toUpperCase(),
              style: detailsTextStyle(size),
            ),
          ),
        ],
      ),
    );
  }

  CoinDataElement(this.text, this.value, this.size);
}