import 'package:flutter/material.dart';
import '../classes/coin.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({
    Key key,
    @required this.isWaiting,
    @required this.coin,
  }) : super(key: key);

  final bool isWaiting;
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
          coin == null
              ? 'https://www.auszac.com/wp/wp-content/uploads/2017/04/circle-placeholder.png'
              : '${coin.imageAddress}',
        ),
      ),
    );
  }
}
