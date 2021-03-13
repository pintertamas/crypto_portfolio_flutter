import 'dart:convert';
import 'package:flutter/material.dart';

import '../constants.dart';
import 'package:http/http.dart' as http;

class Coin {
  @required
  final String id;
  @required
  final String symbol;
  @required
  final String name;
  final double price;
  final double priceChange24h;
  final double priceChangePercentage24h;
  final String imageAddress;

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
}

Future<Coin> fetchCoinData(String coinName) async {
  final response = await http.get(
    Uri.https(coinGeckoSite, '/api/v3/coins/${coinName.toLowerCase()}'),
  );

  if (response.statusCode == 200) {
    //print(response.request);
    return Coin.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load data');
  }
}
