import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_homework/classes/coin_market_data.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:http/http.dart' as http;

part 'coin.g.dart';

@JsonSerializable()
class Coin {
  @required
  final String id;
  @required
  final String symbol;
  @required
  final String name;
  @required
  @JsonKey(name: 'market_data')
  final CoinMarketData coinMarketData;
  @JsonKey(name: 'image_address')
  final String? imageAddress;

  Coin(
    this.id,
    this.symbol,
    this.name,
    this.coinMarketData, [
    this.imageAddress,
  ]);

/*factory Coin.fromJson(Map<String, dynamic> json) {
    String coinId = json['id'];
    String coinSymbol = json['symbol'];
    String coinName = json['name'];
    double coinPrice = double.parse(json['market_data']['current_price']
            [selectedCurrency.toLowerCase()]
        .toString());
    double priceChange24h =
        double.parse(json['market_data']['price_change_24h'].toString());
    double priceChangePercentage24h = double.parse(
        json['market_data']['price_change_percentage_24h'].toString());
    String imageAddress = json['image']["large"];
    return new Coin(coinId, coinSymbol, coinName, coinPrice, priceChange24h,
        priceChangePercentage24h, imageAddress);
  }*/

  factory Coin.fromJson(Map<String, dynamic> json) => _$CoinFromJson(json);

  Map<String, dynamic> toJson() => _$CoinToJson(this);
}

Future<Coin?> fetchCoinData(String coinName) async {
  var coinGeckoSite = 'api.coingecko.com';

  try {
    final response = await http.get(
      Uri.https(coinGeckoSite, '/api/v3/coins/${coinName.toLowerCase()}'),
    );

    if (response.statusCode == 200) {
      return Coin.fromJson(jsonDecode(response.body));
    } else {
      print("request was not succesful req: " + response.statusCode.toString());
      return null;
    }
  } on Exception catch (e) {
    print(e);
  }

  /*var options = BaseOptions(
    baseUrl: coinGeckoSite,
    connectTimeout: 5000,
    receiveTimeout: 3000,
  );
  Dio dio = Dio(options);

  final response = await dio.request(
    '/api/v3/coins/${coinName.toLowerCase()}',
    options: Options(method:'GET'),
  );

  return Coin.fromJson(jsonDecode(response.data));*/
}
