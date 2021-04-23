import 'dart:convert';
import 'package:http/http.dart' as http;
import '../classes/coin.dart';
import '../constants.dart';

class SupportedCoinData {
  Map<String, Coin> data = new Map();

  SupportedCoinData();

  factory SupportedCoinData.fromJson(Map<String, dynamic> json) {
    print("dasdada");
    SupportedCoinData res = new SupportedCoinData();
    print(json.length);
    for (int i = 0; i < json.length; i++) {
      String id = json[i]['id'];
      String symbol = json[i]['symbol'];
      String name = json[id]['name'];

      Coin coin = new Coin(id, symbol, name);

      res.data[symbol] = coin;
    }
    return res;
  }
}

Future<SupportedCoinData> fetchSupportedCoinsData() async {
  final response = await http.get(
    Uri.https(coinGeckoSite, '/api/v3/coins/list'),
  );

  if (response.statusCode == 200) {
    print(response.request);
    return SupportedCoinData.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load data');
  }
}