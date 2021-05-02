import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
import '../classes/news.dart';

part 'news_data.g.dart';

@JsonSerializable()
class NewsData {
  @JsonKey(name: "status_updates")
  List<News> data = [];

  NewsData();

  factory NewsData.fromJson(Map<String, dynamic> json) =>
      _$NewsDataFromJson(json);

  Map<String, dynamic> toJson() => _$NewsDataToJson(this);
}

Future<NewsData?> fetchNewsData() async {
  var coinGeckoSite = 'https://api.coingecko.com';
  var options = BaseOptions(
    baseUrl: coinGeckoSite,
    connectTimeout: 5000,
    receiveTimeout: 3000,
  );
  Dio dio = Dio(options);

  try {
    var response = await dio.get('/api/v3/status_updates');
    final statusCode = response.statusCode;
    if (statusCode != 200) {
      print("status code:$statusCode");
    }
    return NewsData.fromJson(response.data);
  } on Exception catch (e) {
    print("news data exception" + e.toString());
    return null;
  }
}
