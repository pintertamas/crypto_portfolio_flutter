import '../classes/coin.dart';
import '../constants.dart';

class CoinData {
  final Map<String, double> portfolio;

  Map<String, Coin> data = new Map();

  CoinData(this.portfolio);

  factory CoinData.getCoinData(Map<String, double> portfolio) {
    CoinData res = new CoinData(portfolio);
    portfolio.keys.forEach((element) async {
      res.data[element] = await fetchCoinData(element);
    });
    return res;
  }
}

Future<CoinData> getCoinData() async {
  CoinData res = await getCoinData();
  return res;
}
