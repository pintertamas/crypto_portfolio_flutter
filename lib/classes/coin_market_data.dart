import 'package:json_annotation/json_annotation.dart';

part 'coin_market_data.g.dart';

@JsonSerializable()
class CoinMarketData {
  @JsonKey(name: 'current_price')
  final Map<String, dynamic>? price;
  @JsonKey(name: 'market_cap')
  final Map<String, dynamic>? marketCap;
  @JsonKey(name: 'price_change_24h_in_currency')
  final Map<String, dynamic>? priceChange24h;
  @JsonKey(name: 'price_change_percentage_24h_in_currency')
  final Map<String, dynamic>? priceChangePercentage24h;
  @JsonKey(name: 'ath')
  final Map<String, dynamic>? allTimeHigh;
  @JsonKey(name: 'atl')
  final Map<String, dynamic>? allTimeLow;
  @JsonKey(name: 'total_volume')
  final Map<String, dynamic>? volume;
  @JsonKey(name: 'high_24h')
  final Map<String, dynamic>? high24h;
  @JsonKey(name: 'low_24h')
  final Map<String, dynamic>? low24h;

  CoinMarketData(
    this.price,
    this.priceChange24h,
    this.priceChangePercentage24h,
    this.marketCap,
    this.allTimeHigh,
    this.allTimeLow,
    this.volume,
    this.high24h,
    this.low24h,
  );

  factory CoinMarketData.fromJson(Map<String, dynamic> json) =>
      _$CoinMarketDataFromJson(json);

  Map<String, dynamic> toJson() => _$CoinMarketDataToJson(this);
}
