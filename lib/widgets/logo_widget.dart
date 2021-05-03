import 'package:flutter/material.dart';
import '../classes/coin.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({
    Key? key,
    required this.image,
  }) : super(key: key);

  final String image;

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
          //'https://www.clipartmax.com/png/small/215-2151466_bitcoin-cash-bch-icon-bitcoin-cash-logo-svg.png'
          image,
        ),
      ),
    );
  }
}
