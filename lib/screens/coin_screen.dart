import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../data/coin_chart_data.dart';
import 'package:flutter_homework/theme.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import '../classes/coin.dart';

class CoinScreen extends StatefulWidget {
  const CoinScreen({this.coin});

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

  bool isWaiting = false;

  void getData() async {
    isWaiting = true;
    try {
      coinValues = await fetchCoinChartData(coin.id);
      print("data loaded");

      isWaiting = false;

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
                    labelDisplayMode: SparkChartLabelDisplayMode.last,
                    axisLineWidth: 0,
                    labelStyle: TextStyle(
                      fontSize: 18
                    ),
                    data: coinValues.prices == null ? 0 : coinValues.prices,
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
