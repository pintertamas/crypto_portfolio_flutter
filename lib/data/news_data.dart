import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
import '../constants.dart';
import '../classes/news.dart';

part 'news_data.g.dart';

@JsonSerializable()
class NewsData {
  @JsonKey(name: "status_updates")
  List<News> data = [];

  NewsData();

  factory NewsData.fromJson(Map<String, dynamic> json) => _$NewsDataFromJson(json);
  Map<String, dynamic> toJson() => _$NewsDataToJson(this);
}

Future<NewsData?> fetchNewsData() async {
  final response = await http.get(
    Uri.https(coinGeckoSite, '/api/v3/status_updates'),
  );

  if (response.statusCode == 200) {
    return NewsData.fromJson(jsonDecode(response.body));
  } else {
    print("news: status code: " + response.statusCode.toString());
    return null;
  }
}
