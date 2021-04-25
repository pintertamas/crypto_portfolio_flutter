import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import '../constants.dart';
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
  @JsonKey(name: 'current_price')
  final double? price;
  @JsonKey(name: 'price_change_24h')
  final double? priceChange24h;
  @JsonKey(name: 'price_change_percentage_24h')
  final double? priceChangePercentage24h;
  @JsonKey(name: 'image_address')
  final String? imageAddress;

  Coin(
    this.id,
    this.symbol,
    this.name, [
    this.price,
    this.priceChange24h,
    this.priceChangePercentage24h,
    this.imageAddress,
  ]);

  factory Coin.fromJson(Map<String, dynamic> json) {
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
  }

  /*factory Coin.fromJson(Map<String, dynamic> json) => _$CoinFromJson(json);
  Map<String, dynamic> toJson() => _$CoinToJson(this);*/
}

Future<Coin?> fetchCoinData(String coinName) async {
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
}
