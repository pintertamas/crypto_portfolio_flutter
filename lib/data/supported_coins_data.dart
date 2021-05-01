import 'dart:convert';
import 'package:flutter_homework/classes/coin_list_element.dart';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';

part 'supported_coins_data.g.dart';

@JsonSerializable()
class SupportedCoinData {
  Map<String, CoinListElement> data = new Map();

  SupportedCoinData();

  factory SupportedCoinData.fromJson(List<dynamic> json) {
    SupportedCoinData res = new SupportedCoinData();
    print("number of coins: " + json.length.toString());
    for (int i = 0; i < json.length; i++) {
      String id = json[i]['id'];
      String symbol = json[i]['symbol'];
      String name = json[i]['name'];

      CoinListElement coin = new CoinListElement(id, symbol, name);

      res.data[symbol] = coin;
    }
    return res;
  }

  //factory SupportedCoinData.fromJson(Map<String, dynamic> json) => _$SupportedCoinDataFromJson(json);
  //Map<String, dynamic> toJson() => _$SupportedCoinDataToJson(this);
}

Future<SupportedCoinData?> fetchSupportedCoinsData() async { //TODO át kell írni diora
  var coinGeckoSite = 'api.coingecko.com';

  final response = await http.get(
    Uri.https(coinGeckoSite, '/api/v3/coins/list'),
  );

  if (response.statusCode == 200) {
    return SupportedCoinData.fromJson(jsonDecode(response.body));
  } else {
    print("supported: status code: " + response.statusCode.toString());
    return null;
  }
}