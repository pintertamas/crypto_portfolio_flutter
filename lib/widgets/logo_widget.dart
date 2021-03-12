import 'package:flutter/material.dart';

import '../coin_data.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({
    Key key,
    @required this.isWaiting,
    @required this.coinValues,
    @required this.coinName,

  }) : super(key: key);

  final bool isWaiting;
  final CoinData coinValues;
  final String coinName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.0),
        ),
        child: Image.network(
          isWaiting == true ||
              coinValues.data[coinName] ==
                  null
              ? 'https://t4.ftcdn.net/jpg/02/07/87/79/360_F_207877921_BtG6ZKAVvtLyc5GWpBNEIlIxsffTtWkv.jpg'
              : 'https://s2.coinmarketcap.com/static/img/coins/64x64/${coinValues.data[coinName].id}.png',
        ),
      ),
    );
  }
}