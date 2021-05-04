import 'package:dio/dio.dart';
import 'package:flutter_homework/classes/coin_list_element.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class SupportedCoinData {
  Map<String, CoinListElement> data = Map();

  SupportedCoinData();

  factory SupportedCoinData.fromJson(List<dynamic> json) {
    SupportedCoinData res = SupportedCoinData();
    print("number of coins: " + json.length.toString());
    for (int i = 0; i < json.length; i++) {
      String id = json[i]['id'];
      String symbol = json[i]['symbol'];
      String name = json[i]['name'];

      CoinListElement coin = CoinListElement(id, symbol, name);

      res.data[symbol] = coin;
    }
    return res;
  }
}

Future<SupportedCoinData?> fetchSupportedCoinsData() async {
  var coinGeckoSite = 'https://api.coingecko.com';
  var options = BaseOptions(
    baseUrl: coinGeckoSite,
    connectTimeout: 5000,
    receiveTimeout: 3000,
  );
  Dio dio = Dio(options);

  try {
    var response = await dio.get('/api/v3/coins/list');
    final statusCode = response.statusCode;
    if (statusCode != 200) {
      print("status code:$statusCode");
    }
    print("before decode");
    return SupportedCoinData.fromJson(response.data);
  } on Exception catch (e) {
    print("supported coin data exception" + e.toString());
    return null;
  }
}
