import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_homework/classes/coin_list_element.dart';
import 'package:flutter_homework/classes/functions.dart';
import 'package:flutter_homework/data/device_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_homework/theme.dart';

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
      portfolio[coin.id.toLowerCase()] =
          (prefs.getDouble(coin.id.toLowerCase()) ?? 0) + amount;
      prefs.setDouble(coin.id.toLowerCase(), portfolio[coin.id.toLowerCase()]!);
    });
  }

  _removeFromPortfolio(double amount) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      portfolio[coin.id.toLowerCase()]! >= amount
          ? portfolio[coin.id.toLowerCase()] =
              (prefs.getDouble(coin.id.toLowerCase()) ?? 0) - amount
          : portfolio[coin.id.toLowerCase()] = 0;
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Card(
            color: theme.accentColor,
            elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FittedBox(
                    child: Text(
                      "Balance:",
                      style: TextStyle(
                        color: theme.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(),
                  ),
                  FittedBox(
                    child: Text(
                      portfolio[coin.id] == null
                          ? '0 ' + coin.name.toUpperCase()
                          : format(portfolio[coin.id]!).toString() +
                              " " +
                              coin.name.toUpperCase(),
                      style: TextStyle(
                        color: theme.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  decoration: InputDecoration(
                      fillColor: theme.accentColor,
                      focusColor: theme.accentColor,
                      hoverColor: theme.accentColor,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: theme.accentColor,
                        ),
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
                    amount = doubleValue.abs();
                    print(amount);
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TxButton(
                    text: "Buy",
                    onTap: () {
                      showAnimatedDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          return ClassicGeneralDialogWidget(
                            titleText: 'Buy ' + coin.name,
                            contentText: 'Are you sure you want to add ' +
                                amount.toString() +
                                ' ' +
                                coin.name +
                                ' to your portfolio?',
                            negativeTextStyle: TextStyle(
                              color: theme.primaryColor,
                              fontSize: 15,
                            ),
                            positiveTextStyle: TextStyle(
                              color: theme.accentColor,
                              fontSize: 20,
                            ),
                            onPositiveClick: () {
                              _addToPortfolio(amount);
                              print(amount);
                              Navigator.of(context).pop();
                            },
                            onNegativeClick: () {
                              Navigator.of(context).pop();
                            },
                          );
                        },
                        animationType: DialogTransitionType.size,
                        curve: Curves.fastOutSlowIn,
                        duration: Duration(seconds: 1),
                      );
                    },
                  ),
                  TxButton(
                    text: "Sell",
                    onTap: () {
                      showAnimatedDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          return ClassicGeneralDialogWidget(
                            titleText: 'Sell ' + coin.name,
                            contentText: 'Are you sure you want to remove ' +
                                amount.toString() +
                                ' ' +
                                coin.name +
                                ' from your portfolio?',
                            negativeTextStyle: TextStyle(
                              color: theme.primaryColor,
                              fontSize: 15,
                            ),
                            positiveTextStyle: TextStyle(
                              color: theme.accentColor,
                              fontSize: 20,
                            ),
                            onPositiveClick: () {
                              _removeFromPortfolio(amount);
                              Navigator.of(context).pop();
                            },
                            onNegativeClick: () {
                              Navigator.of(context).pop();
                            },
                          );
                        },
                        animationType: DialogTransitionType.size,
                        curve: Curves.fastOutSlowIn,
                        duration: Duration(seconds: 1),
                      );
                    },
                  )
                ],
              ),
            ],
          ),
          Expanded(
            flex: 2,
            child: Container(),
          )
        ],
      ),
    );
  }
}

class TxButton extends StatelessWidget {
  final String text;

  final void Function() onTap; //your function expects a context

  const TxButton({required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: FittedBox(
        child: Card(
          color: theme.accentColor,
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: GestureDetector(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 5, 20.0, 5),
              child: Text(
                text,
                style: TextStyle(
                  color: theme.primaryColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
