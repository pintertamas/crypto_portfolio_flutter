import 'dart:convert';
import 'package:http/http.dart' as http;
import 'constants.dart';
import 'news.dart';

class NewsData {
  List<News> data = [];

  NewsData();

  factory NewsData.fromJson(Map<String, dynamic> json) {
    NewsData res = new NewsData();
    for (int i = 0; i < json['status_updates'].length; i++) {
      String description = json['status_updates'][i]['description'];
      DateTime createdAt = json['status_updates'][i]['createdAt'];
      String user = json['status_updates'][i]['user'];
      String userTitle = json['status_updates'][i]['userTitle'];
      String image = json['status_updates'][i]['image'];

      News newNews = new News(description, createdAt, user, userTitle, image);

      RegExp exp = new RegExp(r'(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+');
      Iterable<RegExpMatch> matches = exp.allMatches(description);
      matches.forEach((match) {
        newNews.urls.add(description.substring(match.start, match.end));
      });

      res.data.add(newNews);
    }
    return res;
  }
}

Future<NewsData> fetchNewsData() async {
  final response = await http.get(
    Uri.https(coinGeckoSite, '/api/v3/status_updates'),
  );

  if (response.statusCode == 200) {
    print(response.request);
    return NewsData.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load data');
  }
}
