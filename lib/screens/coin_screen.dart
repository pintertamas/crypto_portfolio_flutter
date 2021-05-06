import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_homework/classes/bottom_navigation_bar_provider.dart';
import 'package:flutter_homework/classes/functions.dart';
import 'package:flutter_homework/widgets/coin_data_element_widget.dart';
import 'package:flutter_homework/widgets/html_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
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

  CoinChartData coinValues = CoinChartData();

  void getData(String selectedCurrency) async {
    try {
      coinValues = await fetchCoinChartData(coin.id, selectedCurrency);
      print("coin chart data loaded");
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      var coinData =
          Provider.of<BottomNavigationBarProvider>(context, listen: false);
      getData(coinData.selectedCurrency);
    });
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<BottomNavigationBarProvider>(context);

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
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      Column(
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          coin.id.capitalize(),
                                          style: detailsTextStyle(35),
                                        ),
                                        Text(
                                          coin.symbol.toUpperCase(),
                                          style: detailsTextStyle(30),
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              format(coin.coinMarketData!
                                                              .price![
                                                          provider
                                                              .selectedCurrency])
                                                      .toString() +
                                                  " " +
                                                  provider.selectedCurrency
                                                      .toUpperCase() +
                                                  " ",
                                              style: detailsTextStyle(20),
                                            ),
                                            Icon(
                                              (coin.coinMarketData!
                                                              .priceChangePercentage24h![
                                                          provider
                                                              .selectedCurrency] ?? 0) >= 0
                                                  ? FontAwesomeIcons.sortUp
                                                  : FontAwesomeIcons.sortDown,
                                              color: (coin.coinMarketData!
                                                              .priceChangePercentage24h![
                                                          provider
                                                              .selectedCurrency] ??
                                                      0) >= 0
                                                  ? Colors.green
                                                  : Colors.red,
                                              size: 15,
                                            ),
                                            Text(
                                              (coin.coinMarketData!
                                                          .priceChangePercentage24h![
                                                      provider
                                                          .selectedCurrency] ??
                                                  0).toString() + "%",
                                              style: detailsTextStyle(20),
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
                                        coin.imageAddress!['small'],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 20, 0, 20),
                                child: Column(
                                  children: [
                                    CoinMarketDataElement("Market Cap: ",
                                        coin.coinMarketData!.marketCap, 15),
                                    CoinMarketDataElement("Volume: ",
                                        coin.coinMarketData!.volume, 15),
                                    CoinMarketDataElement("24h high: ",
                                        coin.coinMarketData!.high24h, 15),
                                    CoinMarketDataElement("24h low: ",
                                        coin.coinMarketData!.low24h, 15),
                                    CoinMarketDataElement(
                                        "All time high (ATH): ",
                                        coin.coinMarketData!.allTimeHigh,
                                        15),
                                    CoinMarketDataElement(
                                        "All time low (ATL): ",
                                        coin.coinMarketData!.allTimeLow,
                                        15),
                                    if (coin.upVotePercentage != null &&
                                        coin.downVotePercentage != null)
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Market sentiment votes:",
                                          style: detailsTextStyle(15),
                                        ),
                                      ),
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: (100 *
                                                  (coin.upVotePercentage ?? 0))
                                              .toInt(),
                                          child: Container(
                                            color: Colors.green,
                                            height: 10,
                                          ),
                                        ),
                                        Expanded(
                                          flex: (100 *
                                                  (coin.downVotePercentage ??
                                                      0))
                                              .toInt(),
                                          child: Container(
                                            color: Colors.red,
                                            height: 10,
                                          ),
                                        ),
                                      ],
                                    ),
                                    HTMLWidget(
                                      coin.description["en"],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
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
