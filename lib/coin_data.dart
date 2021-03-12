import 'coin.dart';
import 'constants.dart';

class CoinData {
  Map<String, Coin> data = new Map();

  CoinData();

  factory CoinData.getCoinData() {
    CoinData res = new CoinData();
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
