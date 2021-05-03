import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_homework/classes/bottom_navigation_bar_provider.dart';
import 'package:flutter_homework/classes/coin.dart';
import 'package:flutter_homework/classes/coin_list_element.dart';
import 'package:flutter_homework/data/device_data.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/coin_chart_data.dart';
import 'package:flutter_homework/theme.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class AddCoinScreen extends StatefulWidget {
  const AddCoinScreen({required this.coin, required this.portfolio});

  final CoinListElement coin;
  final Map<String, double> portfolio;

  @override
  _AddCoinScreenState createState() => _AddCoinScreenState(coin, portfolio);
}

class _AddCoinScreenState extends State<AddCoinScreen> {
  final CoinListElement coin;
  final Map<String, double> portfolio;
  double amount = 0.0;

  _AddCoinScreenState(this.coin, this.portfolio);

  @override
  void initState() {
    super.initState();
    DataHandler().loadPortfolio(portfolio);
  }

  _addToPortfolio(double amount) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {

      portfolio[coin.id.toLowerCase()] = (prefs.getDouble(coin.id.toLowerCase()) ?? 0) + amount;
      prefs.setDouble(coin.id.toLowerCase(), portfolio[coin.id.toLowerCase()]!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.secondaryHeaderColor,
      appBar: AppBar(
        title: Text(
          '${coin.name}',
          style: TextStyle(
            color: theme.secondaryHeaderColor,
          ),
        ),
        backgroundColor: theme.primaryColor,
        foregroundColor: theme.secondaryHeaderColor,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: theme.accentColor,
        child: Icon(
          FontAwesomeIcons.plus,
          color: theme.primaryColor,
        ),
        onPressed: () {
          _addToPortfolio(amount);
        },
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        hintText: 'Enter amount!',
                        hintStyle: TextStyle(
                          color: theme.primaryColor,
                        )),
                    onChanged: (value) {
                      double doubleValue;
                      try {
                        doubleValue = double.parse(value);
                      } catch (e) {
                        doubleValue = 0;
                      }
                      amount = doubleValue;
                      print(amount);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
