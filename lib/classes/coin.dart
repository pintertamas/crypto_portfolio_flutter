import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_homework/classes/coin_market_data.dart';
import 'package:json_annotation/json_annotation.dart';

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
  final Map<String, dynamic> description;
  @required
  @JsonKey(name: 'sentiment_votes_up_percentage')
  final double? upVotePercentage;
  @required
  @JsonKey(name: 'sentiment_votes_down_percentage')
  final double? downVotePercentage;
  @required
  @JsonKey(name: 'market_data')
  final CoinMarketData? coinMarketData;
  @JsonKey(name: 'image')
  final Map<String, dynamic>? imageAddress;

  Coin(
      this.id,
      this.symbol,
      this.name,
      this.coinMarketData,
      this.imageAddress,
      this.description,
      this.upVotePercentage,
      this.downVotePercentage);

  factory Coin.fromJson(Map<String, dynamic> json) => _$CoinFromJson(json);

  Map<String, dynamic> toJson() => _$CoinToJson(this);
}

Future<Coin?> fetchCoinData(String coinId) async {
  var coinGeckoSite = 'https://api.coingecko.com';
  var options = BaseOptions(
    baseUrl: coinGeckoSite,
    connectTimeout: 5000,
    receiveTimeout: 3000,
  );
  Dio dio = Dio(options);

  try {
    var response = await dio.get('/api/v3/coins/${coinId.toLowerCase()}');
    final statusCode = response.statusCode;
    if (statusCode != 200) {
      print("status code:$statusCode");
    }
    print(response.realUri);
    return Coin.fromJson(response.data);
  } on Exception catch (e) {
    print("coin data exception " + coinId + " " + e.toString());
    return null;
  }
}
