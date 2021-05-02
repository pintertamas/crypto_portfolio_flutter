import 'package:json_annotation/json_annotation.dart';

part 'coin_market_data.g.dart';

@JsonSerializable()
class CoinMarketData {
  @JsonKey(name: 'current_price')
  final Map<String, dynamic>? price;
  @JsonKey(name: 'price_change_24h_in_currency')
  final Map<String, dynamic>? priceChange24h;
  @JsonKey(name: 'price_change_percentage_24h_in_currency')
  final Map<String, dynamic>? priceChangePercentage24h;

  CoinMarketData(
    this.price,
    this.priceChange24h,
    this.priceChangePercentage24h,
  );

  factory CoinMarketData.fromJson(Map<String, dynamic> json) => _$CoinMarketDataFromJson(json);
  Map<String, dynamic> toJson() => _$CoinMarketDataToJson(this);
}
