import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_homework/constants.dart';
import 'package:flutter_homework/widgets/logo_widget.dart';
import 'package:intl/intl.dart';
import '../calculate_balance.dart';
import '../classes/coin.dart';
import '../data/coin_data.dart';
import '../theme.dart';
import '../data/coin_data.dart';
import '../widgets/currency_card.dart';

class PortfolioScreen extends StatefulWidget {
  final Map<String, double> portfolio;

  const PortfolioScreen({Key key, this.portfolio}) : super(key: key);

  @override
  _PortfolioScreenState createState() => _PortfolioScreenState(portfolio);
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  Map<String, double> portfolio;

  CoinData coinValues;

  bool isWaiting = false;

  _PortfolioScreenState(Map<String, double> portfolio) {
    this.portfolio = portfolio;
    coinValues = new CoinData(portfolio);
  }

  void getData() async {
    isWaiting = true;
    try {
      portfolio.keys.forEach((element) async {
        await fetchCoinData(element)
            .then((value) => coinValues.data[element] = value);
        if (!mounted) return;
        setState(() {
          EasyLoading.dismiss();
        });
      });
      print("coin data loaded");

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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                flex: 1,
                child: Text(
                  'Portfolio balance',
                )),
            if (coinValues.data.isEmpty)
              Expanded(
                flex: 1,
                child: Text(
                  '${EasyLoading.show(status: 'Loading...')}',
                  style: TextStyle(
                    fontSize: 0,
                  ),
                ),
              )
            else
              Expanded(
                flex: 1,
                child: Text(
                  '${NumberFormat("#,##0.00", "en_US").format(calculateBalance(coinValues, portfolio))} ${selectedCurrency.toUpperCase()}',
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
                            coin: coinValues.data[coinName],
                          ),
                        ),
                        Expanded(
                          flex: 8,
                          child: CurrencyCard(
                            balance: portfolio[coinName],
                            coin: coinValues.data[coinName],
                          ),
                        ),
                      ],
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
