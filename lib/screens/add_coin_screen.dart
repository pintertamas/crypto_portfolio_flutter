import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_homework/classes/bottom_navigation_bar_provider.dart';
import 'package:flutter_homework/classes/coin_list_element.dart';
import 'package:flutter_homework/data/device_data.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<BottomNavigationBarProvider>(context);

    return Scaffold(
      backgroundColor: theme.secondaryHeaderColor,
      appBar: AppBar(
        title: Text('${coin.name}'),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: theme.accentColor,
        child: Icon(
          FontAwesomeIcons.plus,
          color: theme.primaryColor,
        ),
        onPressed: () {
          print(portfolio[coin.name.toLowerCase()]);
          DataHandler().addToPortfolio(coin.name.toLowerCase(), amount);
          DataHandler().savePortfolio(portfolio);
          DataHandler().readPortfolio(portfolio);
          print(portfolio[coin.name.toLowerCase()]);
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
                  Card(
                    color: theme.primaryColor,
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: FutureBuilder<CoinChartData?>(
                        future: fetchCoinChartData(coin.name, provider.selectedCurrency), // async work
                        builder: (BuildContext context,
                            AsyncSnapshot<CoinChartData?> snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return Text(
                                '${EasyLoading.show(status: 'Loading...')}',
                                style: TextStyle(
                                  fontSize: 0,
                                ),
                              );
                            default:
                              if (snapshot.hasError)
                                return Text('Error: ${snapshot.error}');
                              else {
                                EasyLoading.dismiss();
                                return SfSparkAreaChart(
                                  color: theme.primaryColor,
                                  borderColor: theme.accentColor,
                                  axisLineDashArray:
                                      snapshot.data!.data.values.toList(),
                                  borderWidth: 3,
                                  axisLineWidth: 0,
                                  labelStyle: TextStyle(fontSize: 18),
                                  data: snapshot.data!.prices,
                                );
                              }
                          }
                        },
                      ),
                    ),
                  ),
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
