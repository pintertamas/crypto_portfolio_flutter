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
  var coinGeckoSite = 'http://api.coingecko.com';

  /*final response = await http.get(
    Uri.https(coinGeckoSite, '/api/v3/status_updates'),
  );

  if (response.statusCode == 200) {
    return NewsData.fromJson(jsonDecode(response.body));
  } else {
    print("news: status code: " + response.statusCode.toString());
    return null;
  }*/

  var options = BaseOptions(
    baseUrl: coinGeckoSite,
    connectTimeout: 5000,
    receiveTimeout: 3000,
  );
  Dio dio = Dio(options);

  var response = await dio.request(
    '/api/v3/status_updates',
    options: Options(method: 'GET'),
  );
  print(response.data);

  final statusCode = response.statusCode;

  if (statusCode != 200) {
    print("status code:$statusCode");
  }
  return NewsData.fromJson(jsonDecode(response.data));
}
