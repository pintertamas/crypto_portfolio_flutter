import 'dart:convert';
import '../constants.dart';
import 'package:http/http.dart' as http;

class Coin {
  final String id;
  final String symbol;
  final String name;
  final double price;
  final String imageAddress;

  Coin(this.id, this.symbol, this.name, this.price, this.imageAddress);

  factory Coin.fromJson(Map<String, dynamic> json) {
    String coinId = json['id'];
    String coinSymbol = json['symbol'];
    String coinName = json['name'];
    double coinPrice = double.parse(json['market_data']['current_price'][selectedCurrency.toLowerCase()].toString());
    String imageAddress = json['image']["large"];
    return new Coin(coinId, coinSymbol, coinName, coinPrice, imageAddress);
  }
}

Future<Coin> fetchCoinData(String coinName) async {
  final response = await http.get(
    Uri.https(coinGeckoSite, '/api/v3/coins/${coinName.toLowerCase()}'),
  );

  if (response.statusCode == 200) {
    print(response.request);
    return Coin.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load data');
  }
}
