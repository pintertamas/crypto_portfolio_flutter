import 'dart:convert';
import 'package:http/http.dart' as http;
import 'coin.dart';
import 'constants.dart';

class CoinData {
  final Map<String, Coin> data = new Map<String, Coin>();

  CoinData();

  factory CoinData.fromJson(Map<String, dynamic> json) {
    CoinData res = new CoinData();
    for (int i = 0; i < json['data'].length; i++) {
      portfolio.forEach((key, value) {
        if (key == json['data'][i]['symbol']) {
          String coinSymbol = json['data'][i]['symbol'];
          String coinName = json['data'][i]['name'];
          print(coinName);
          int coinId = json['data'][i]['id'];
          double coinPrice = json['data'][i]['quote']['USD']['price'];
          res.data[coinSymbol] = Coin(coinId, coinSymbol, coinPrice, coinName);
        }
      });
    }
    return res;
  }
}

Future<CoinData> fetchCoinData() async {
  final response = await http.get(
    Uri.https(coinMarketCapSite, '/v1/cryptocurrency/listings/latest'),
    headers: {'X-CMC_PRO_API_KEY': apiKeyCoinMarketCap},
  );

  if (response.statusCode == 200) {
    print(response.request);
    return CoinData.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load data');
  }
}
