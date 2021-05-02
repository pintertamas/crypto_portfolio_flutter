import 'package:flutter/material.dart';
import '../classes/coin.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({
    Key? key,
    required this.coin,
  }) : super(key: key);

  final Coin coin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.0),
        ),
        child: Image.network(
          'https://www.clipartmax.com/png/small/215-2151466_bitcoin-cash-bch-icon-bitcoin-cash-logo-svg.png'
          //coin.imageAddress!['small'] == null ? 'https://www.clipartmax.com/png/small/215-2151466_bitcoin-cash-bch-icon-bitcoin-cash-logo-svg.png' : '${coin.imageAddress!['small']}',
        ),
      ),
    );
  }
}
