import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CoinScreen extends StatefulWidget {
  const CoinScreen({ int i });
  @override
  _CoinScreenState createState() => _CoinScreenState();
}

class _CoinScreenState extends State<CoinScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Coin"),
      ),
      body: Container(),
    );
  }
}
