import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_homework/coin_chart_data.dart';
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('$coinName'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Card(
                color: Colors.white,
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: SfSparkAreaChart(
                  color: Colors.orange,
                  borderColor: Colors.deepOrange,
                  borderWidth: 1,
                  data: coinValues.prices == null ? 1 : coinValues.prices,
                ),
              ),
            ),
          ),
          Container(
            height: 100,
            color: Colors.black
          ),
        ],
      ),
    );
  }
}
