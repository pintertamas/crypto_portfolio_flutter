import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_homework/classes/bottom_navigation_bar_provider.dart';
import 'package:flutter_homework/classes/functions.dart';
import 'package:flutter_homework/data/device_data.dart';
import 'package:flutter_homework/widgets/logo_widget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../classes/coin.dart';
import '../data/coin_data.dart';
import '../theme.dart';
import '../widgets/currency_card.dart';

class PortfolioScreen extends StatefulWidget {
  final Map<String, double> portfolio;

  const PortfolioScreen({Key? key, required this.portfolio}) : super(key: key);

  @override
  _PortfolioScreenState createState() => _PortfolioScreenState(portfolio);
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  Map<String, double> portfolio;
  final CoinData coinValues;
  late Future<Map<String, Coin>> coinData;

  _PortfolioScreenState(this.portfolio) : coinValues = CoinData(portfolio);

  Future<Map<String, Coin>> getData() async {
    try {
      final keys = portfolio.keys.toList();
      for (var i = 0; i < keys.length; i++) {
        //final isolate = await FlutterIsolate.spawn(fetchCoinData, keys[i]);
        //print(isolate);
        final data = await fetchCoinData(keys[i]);
        if (data != null) coinValues.data[keys[i]] = data;
      }
      setState(() {});
      print("coin data loaded");
      EasyLoading.dismiss();
      return coinValues.data;
    } catch (e) {
      print(e);
      return coinValues.data;
    }
  }

  bool _checkPortfolio() {
    bool result = true;
    portfolio.forEach((key, value) {
      if (portfolio[key] != 0 && portfolio[key] != null) result = false;
      return;
    });
    return result;
  }

  @override
  void initState() {
    super.initState();
    DataHandler().loadPortfolio(portfolio);
    coinData = getData();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<BottomNavigationBarProvider>(context);

    return Scaffold(
      backgroundColor: theme.secondaryHeaderColor,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 1,
              child: Text(
                'Portfolio balance',
              ),
            ),
            if (coinValues.data.isEmpty)
              FittedBox(
                child: _checkPortfolio() ? Text('0 ' + provider.selectedCurrency.toUpperCase()) : Text(
                  "Loading...",
                ),
              )
            else
              Expanded(
                flex: 1,
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    '${NumberFormat("#,##0.00", "en_US").format(calculateBalance(coinValues, portfolio, provider.selectedCurrency))} ${provider.selectedCurrency.toUpperCase()}',
                  ),
                ),
              ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
              child: _checkPortfolio()
                  ? Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: FittedBox(
                        child: Text(
                          "Your portfolio is empty.\nTry adding new tokens on the settings screen.",
                          style: TextStyle(
                            color: theme.primaryColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  : FutureBuilder<Map<String, Coin>>(
                      future: coinData,
                      builder: (context, snapshot) {
                        if (snapshot.hasData ||
                            snapshot.connectionState == ConnectionState.done) {
                          final data = snapshot.data!;
                          return ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(10),
                            itemCount: data.length,
                            itemBuilder: (BuildContext context, int index) {
                              String coinName = data.keys.elementAt(index);
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: LogoWidget(
                                      image: data[coinName]!
                                                  .imageAddress['small'] ==
                                              null
                                          ? 'https://www.clipartmax.com/png/small/215-2151466_bitcoin-cash-bch-icon-bitcoin-cash-logo-svg.png'
                                          : '${data[coinName]!.imageAddress['small']}',
                                    ),
                                  ),
                                  Expanded(
                                    flex: 8,
                                    child: CurrencyCard(
                                      balance: portfolio[coinName]!,
                                      coin: data[coinName]!,
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        } else
                          return Center(
                            child: Text(
                              '${EasyLoading.show(status: 'Loading...')}',
                              style: TextStyle(
                                fontSize: 0,
                              ),
                            ),
                          );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
