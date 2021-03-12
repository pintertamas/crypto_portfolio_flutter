import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_homework/coin_chart_data.dart';
import 'package:flutter_homework/theme.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class CoinScreen extends StatefulWidget {
  const CoinScreen({this.coinName});

  final String coinName;

  @override
  _CoinScreenState createState() => _CoinScreenState(coinName);
}

class _CoinScreenState extends State<CoinScreen> {
  String coinName;

  _CoinScreenState(this.coinName) {
    this.coinName = coinName;
  }

  CoinChartData coinValues = new CoinChartData();

  bool isWaiting = false;

  void getData() async {
    isWaiting = true;
    try {
      coinValues = await fetchCoinChartData(coinName);
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
        title: Text('$coinName'),
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
