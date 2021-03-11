import 'package:flutter/material.dart';
import 'package:flutter_homework/coin_chart_data.dart';
import 'package:flutter_homework/constants.dart';
import 'package:flutter_homework/widgets/logo_widget.dart';
import '../widgets/balance_widget.dart';
import '../coin_data.dart';

import '../widgets/currency_card.dart';

class PortfolioScreen extends StatefulWidget {
  @override
  _PortfolioScreenState createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  CoinData coinValues = new CoinData();

  bool isWaiting = false;

  void getData() async {
    isWaiting = true;
    try {
      coinValues = await fetchCoinData();
      print("data loaded");
      fetchCoinChartData("Bitcoin", "USD");

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
      appBar: AppBar(
        title: Text('Crypto Portfolio'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                padding: const EdgeInsets.all(10),
                itemCount: portfolio.length,
                itemBuilder: (BuildContext context, int index) {
                  String coinName = portfolio.keys.elementAt(index);
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: LogoWidget(
                          isWaiting: isWaiting,
                          coinValues: coinValues,
                          coinName: coinName,
                        ),
                      ),
                      Expanded(
                        flex: 8,
                        child: CurrencyCard(
                          balance: portfolio[coinName],
                          currentCrypto: coinName,
                          currentValue: isWaiting == true ||
                                  coinValues.data[coinName] == null
                              ? 0
                              : coinValues.data[coinName].price,
                          selectedCurrency: selectedCurrency,
                        ),
                      ),
                    ],
                  );
                }),
          ),
          BalanceWidget(
            coinValues: coinValues,
          ),
        ],
      ),
    );
  }
}
