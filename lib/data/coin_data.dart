import '../classes/coin.dart';

class CoinData {
  final Map<String, double> portfolio;

  Map<String, Coin> data = new Map();

  CoinData(this.portfolio);

  factory CoinData.getCoinData(Map<String, double> portfolio) {
    CoinData res = new CoinData(portfolio);
    portfolio.keys.forEach((element) async {
      final coin = await fetchCoinData(element);
      if (coin != null)
        res.data[element] = coin;
    });
    return res;
  }
}

Future<CoinData> getCoinData() async {
  CoinData res = await getCoinData();
  return res;
}
