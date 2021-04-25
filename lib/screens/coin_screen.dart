import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_homework/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../data/coin_chart_data.dart';
import 'package:flutter_homework/theme.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import '../classes/coin.dart';

class CoinScreen extends StatefulWidget {
  const CoinScreen({required this.coin});

  final Coin coin;

  @override
  _CoinScreenState createState() => _CoinScreenState(coin);
}

class _CoinScreenState extends State<CoinScreen> {
  Coin coin;

  _CoinScreenState(this.coin) {
    this.coin = coin;
  }

  CoinChartData coinValues = new CoinChartData();

  void getData() async {
    try {
      coinValues = await fetchCoinChartData(coin.id);
      print("coin chart data loaded");
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.secondaryHeaderColor,
      appBar: AppBar(
        title: Text('${coin.name}'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Card(
                color: theme.primaryColor,
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SfSparkAreaChart(
                    color: theme.primaryColor,
                    borderColor: theme.accentColor,
                    axisLineDashArray: coinValues.data.values.toList(),
                    borderWidth: 3,
                    axisLineWidth: 0,
                    labelStyle: TextStyle(fontSize: 18),
                    data: coinValues.prices,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Card(
                color: theme.primaryColor,
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      coin.id.capitalize(),
                                      style: detailsTextStyle(35),
                                    ),
                                    Text(
                                      coin.symbol.toUpperCase(),
                                      style: detailsTextStyle(25),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          coin.price.toString() + " " + selectedCurrency.toUpperCase() + " ",
                                          style: detailsTextStyle(18),
                                        ),
                                        Icon(
                                          coin.priceChangePercentage24h! >= 0
                                              ? FontAwesomeIcons.sortUp
                                              : FontAwesomeIcons.sortDown,
                                          color:
                                              coin.priceChangePercentage24h! >=
                                                      0
                                                  ? Colors.green
                                                  : Colors.red,
                                          size: 15,
                                        ),
                                        Text(
                                          coin.priceChangePercentage24h
                                                  .toString()
                                                  .substring(0, 5) +
                                              "%",
                                          style: detailsTextStyle(15),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Image.network(
                                    coin.imageAddress.toString(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                            child: ListView(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              children: [
                                Text(
                                  coin.price.toString(),
                                  style: detailsTextStyle(20),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

TextStyle detailsTextStyle(double size) {
  return TextStyle(
    color: theme.secondaryHeaderColor,
    fontWeight: FontWeight.bold,
    fontSize: size,
  );
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
